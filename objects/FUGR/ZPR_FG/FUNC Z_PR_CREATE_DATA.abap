FUNCTION z_pr_create_data.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(I_WTKT) TYPE  ZPR_DT_WTKTNO OPTIONAL
*"     VALUE(I_WTKTITEM) TYPE  ZPR_DT_WTKTITM OPTIONAL
*"  EXPORTING
*"     VALUE(E_RETURN) TYPE  CHAR1
*"----------------------------------------------------------------------
  TYPES: BEGIN OF ty_return,
           message TYPE string,
         END OF ty_return,

         tt_return         TYPE STANDARD TABLE OF ty_return WITH DEFAULT KEY,
         tt_po_deep_create TYPE STANDARD TABLE OF zpr_scm_cbp_po_v2=>tys_a_pur_ord_pricing_elemen_2 WITH NON-UNIQUE DEFAULT KEY.

  DATA: lo_http_client        TYPE REF TO if_web_http_client,
        lo_client_proxy       TYPE REF TO /iwbep/if_cp_client_proxy,
        lo_request            TYPE REF TO /iwbep/if_cp_request_create,
        lo_response           TYPE REF TO /iwbep/if_cp_response_create,
        lt_property           TYPE /iwbep/if_cp_runtime_types=>ty_t_property_path,
        lt_item_property      TYPE /iwbep/if_cp_runtime_types=>ty_t_property_path,
        lt_msg                TYPE tt_return,
        lv_message            TYPE string,
        ls_po_business_data   TYPE zpr_scm_cbp_po_v2=>tys_a_pur_ord_pricing_elemen_2,
        ls_cond_business_data TYPE tt_po_deep_create,
        ls_business_data      TYPE zpr_scm_cbp_po_v2=>tys_a_pur_ord_pricing_elemen_2.

  CONSTANTS: lc_po_url   TYPE string VALUE 'https://my403232-api.s4hana.cloud.sap/sap/opu/odata/sap/API_PURCHASEORDER_PROCESS_SRV',
             lc_user     TYPE string VALUE 'DEMO_API_PC',
             lc_password TYPE string VALUE 'fSQ#xoXWmonAJJnqVaKoqzmRuxAh9ZfFktRbFSfL'.

**get header info
  SELECT SINGLE * FROM zpr_tb_wt_it
                  WHERE wtktno = @i_wtkt
                  AND wtktitm = @i_wtktitem
                  INTO @DATA(ls_item).

  IF sy-subrc EQ 0 AND ls_item-prueflos IS NOT INITIAL.

* Check if Inspection Lot results are posted
    SELECT * FROM i_inspectionresult WHERE inspectionlot = @ls_item-prueflos
      INTO TABLE @DATA(lt_insp_results).
    IF sy-subrc EQ 0.
* Get inspection lot characteristic
      SELECT * FROM i_inspectioncharacteristic WHERE inspectionlot = @ls_item-prueflos
        INTO TABLE @DATA(lt_insp_char).

      IF sy-subrc EQ 0.
        SELECT * FROM zpr_tb_cond_map FOR ALL ENTRIES IN @lt_insp_char
          WHERE char_name = @lt_insp_char-inspectionspecification
          INTO TABLE @DATA(lt_cond).
*            IF sy-subrc EQ 0.
* Fetch the custom condition types for PO update
        SELECT * FROM zpr_tb_po_price FOR ALL ENTRIES IN @lt_cond
          WHERE cond_type = @lt_cond-cond_type
          AND start_date LE @sy-datum
          AND end_date GE @sy-datum
          AND deletion_ind = ''
          INTO TABLE @DATA(lt_price).
        IF sy-subrc EQ 0.
          SORT lt_price BY cond_type.
        ENDIF.

        SELECT SINGLE * FROM i_purorditmpricingelementapi01
         WHERE purchaseorder = @ls_item-ebeln
         AND purchaseorderitem = @ls_item-ebelp
         INTO @DATA(ls_element).

        LOOP AT lt_insp_char INTO DATA(ls_insp_char).
          READ TABLE lt_cond INTO DATA(ls_cond) WITH KEY char_name = ls_insp_char-inspectionspecification.
          IF sy-subrc EQ 0.
            READ TABLE lt_insp_results INTO DATA(ls_results) WITH KEY inspectionlot = ls_item-prueflos
                                                                      inspectioncharacteristic = ls_insp_char-inspectioncharacteristic.
            IF sy-subrc EQ 0.
              CLEAR: ls_po_business_data.
              LOOP AT lt_price INTO DATA(ls_price) WHERE cond_type = ls_cond-cond_type.
                IF ls_price-low LE ls_results-inspectionresultmeanvalue AND
                   ls_results-inspectionresultmeanvalue LE ls_price-high.

                  TRY.
* Update PO Price - add custom condition types based on results recording
                      lo_http_client = cl_web_http_client_manager=>create_by_http_destination(
                                i_destination = cl_http_destination_provider=>create_by_url( lc_po_url ) ).
                      DATA(lo_http_req) = lo_http_client->get_http_request( ).
                      lo_http_req->set_authorization_basic(
                                                             i_username = lc_user
                                                             i_password = lc_password
                                                           ).

                      lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
                      EXPORTING
                         is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                             proxy_model_id      = 'ZPR_SCM_CBP_PO_V2'
                                                             proxy_model_version = '0001' )
                        io_http_client             = lo_http_client
                        iv_relative_service_root   = ''  ).

                      ASSERT lo_http_client IS BOUND.

                      APPEND 'PURCHASE_ORDER' TO  lt_item_property.
                      APPEND 'PURCHASE_ORDER_ITEM' TO  lt_item_property.
                      APPEND 'PRICING_DOCUMENT' TO  lt_item_property.
                      APPEND 'PRICING_DOCUMENT_ITEM' TO  lt_item_property.
                      APPEND 'CONDITION_TYPE' TO lt_item_property.
                      APPEND 'CONDITION_RATE_VALUE' TO lt_item_property.

                      lo_http_client->set_csrf_token( ).
                      " Navigate to the resource and create a request for the create operation
                      lo_request = lo_client_proxy->create_resource_for_entity_set( 'A_PUR_ORD_PRICING_ELEMENT' )->create_request_for_create( ).

* Prepare business data
                      ls_po_business_data-purchase_order = ls_item-ebeln.
                      ls_po_business_data-purchase_order_item = ls_item-ebelp.
                      ls_po_business_data-pricing_document = ls_element-pricingdocument.
                      ls_po_business_data-pricing_document_item = '000010'.
                      ls_po_business_data-condition_type = ls_cond-cond_type.
                      ls_po_business_data-condition_rate_value = ls_price-cond_value.

                      " Set the business data for the created entity
                      lo_request->set_business_data(
                      is_business_data =  ls_po_business_data
                      it_provided_property = lt_item_property
                      ).

                      " Execute the request
                      lo_response = lo_request->execute( ).
                      WAIT UP TO 3 SECONDS.

                      CLEAR: ls_business_data.
                      " Get the after image
                      lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

                      IF ls_business_data IS NOT INITIAL.
                        e_return = 'S'.
* Get Updated PO Price
                        SELECT SINGLE * FROM i_purchaseorderitemapi01 WHERE purchaseorder = @ls_item-ebeln
                        AND purchaseorderitem = @ls_item-ebelp
                        INTO @DATA(ls_po).
                        UPDATE zpr_tb_wt_it SET po_price = @ls_po-netamount
                                    WHERE wtktno =  @i_wtkt
                                    AND   wtktitm = @i_wtktitem.
                      ENDIF.

                    CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
                      IF lx_remote->get_text( ) IS NOT INITIAL.
                        lt_msg = VALUE #( ( message = lx_remote->get_text( ) ) ).
                        IF lt_msg[] IS NOT INITIAL.
                          lv_message = lt_msg[ 1 ]-message.
                          e_return = 'E'.
                        ENDIF.
                      ENDIF.

                      IF lx_remote->s_odata_error-message IS NOT INITIAL.
                        lt_msg = VALUE #( BASE lt_msg ( message = lx_remote->s_odata_error-message ) ).
                        IF lt_msg[] IS NOT INITIAL.
                          lv_message = lt_msg[ 2 ]-message.
                          e_return = 'E'.
                        ENDIF.
                      ENDIF.

                    CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
                      lt_msg = VALUE #( ( message = lx_gateway->get_text( ) ) ).
                      IF lt_msg[] IS NOT INITIAL.
                        lv_message = lt_msg[ 1 ]-message.
                        e_return = 'E'.
                      ENDIF.

                    CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
                      lv_message =  lx_web_http_client_error->get_longtext(  ).
                      e_return = 'E'.

                    CATCH cx_http_dest_provider_error INTO DATA(lx_web_http_dest_error).
                      lv_message =  lx_web_http_dest_error->get_longtext(  ).
                      e_return = 'E'.
                  ENDTRY.
                ENDIF.
              ENDLOOP.
            ENDIF.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.
  ENDIF.

ENDFUNCTION.