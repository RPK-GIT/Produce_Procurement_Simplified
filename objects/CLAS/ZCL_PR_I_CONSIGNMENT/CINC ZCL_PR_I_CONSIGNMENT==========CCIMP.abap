CLASS lhc_zpr_i_consignment DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR consign RESULT result.

    METHODS read FOR READ
      IMPORTING keys FOR READ consign RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK consign.

    METHODS post FOR MODIFY
      IMPORTING keys FOR ACTION consign~post.

ENDCLASS.

CLASS lhc_zpr_i_consignment IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD post.
* Create Supplier Invoice for the GR
    TYPES: BEGIN OF ty_return,
             message TYPE string,
           END OF ty_return,
           tt_return          TYPE STANDARD TABLE OF ty_return WITH DEFAULT KEY,
           tt_inv_deep_create TYPE STANDARD TABLE OF zpr_scm_cbp_inv=>tys_a_supplier_invoice_item__3 WITH NON-UNIQUE DEFAULT KEY.

    TYPES:           BEGIN OF ty_inv_deep_create.
                       INCLUDE TYPE zpr_scm_cbp_inv=>tys_a_supplier_invoice_type.
    TYPES:             to_supplier_invoice_item_g TYPE tt_inv_deep_create,
                     END OF ty_inv_deep_create.

    DATA: lo_http_client           TYPE REF TO if_web_http_client,
          lo_client_proxy          TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request               TYPE REF TO /iwbep/if_cp_request_create,
          lo_response              TYPE REF TO /iwbep/if_cp_response_create,
          lt_property              TYPE /iwbep/if_cp_runtime_types=>ty_t_property_path,
          lt_item_property         TYPE /iwbep/if_cp_runtime_types=>ty_t_property_path,
          lt_msg                   TYPE tt_return,
          lv_message               TYPE string,
          ls_inv_business_data     TYPE zpr_scm_cbp_inv=>tys_a_supplier_invoice_type,
          ls_invitem_business_data TYPE tt_inv_deep_create,
          ls_business_data         TYPE ty_inv_deep_create,
          ls_deep_data             TYPE ty_inv_deep_create,
          ls_item_data             TYPE zpr_scm_cbp_inv=>tys_a_supplier_invoice_item__3,
          lv_wrbtr                 TYPE wrbtr_cs.

    CONSTANTS: lc_inv_url  TYPE string VALUE 'https://my403232-api.s4hana.cloud.sap/sap/opu/odata/sap/API_SUPPLIERINVOICE_PROCESS_SRV',
               lc_user     TYPE string VALUE 'DEMO_API_PC',
               lc_password TYPE string VALUE 'fSQ#xoXWmonAJJnqVaKoqzmRuxAh9ZfFktRbFSfL'.


    IF keys[] IS NOT INITIAL.
* Select Material Documents
      SELECT * FROM zpr_i_consignment FOR ALL ENTRIES IN @keys
        WHERE materialdocument = @keys-materialdocument
        AND materialdocumentyear = @keys-materialdocumentyear
        AND materialdocumentitem = @keys-materialdocumentitem
        INTO TABLE @DATA(lt_matdocs).
      IF sy-subrc EQ 0.
        READ TABLE lt_matdocs INTO DATA(ls_matdocs) INDEX 1.

        CLEAR: lv_wrbtr, ls_matdocs.
        LOOP AT lt_matdocs INTO ls_matdocs.
          IF ls_matdocs-dcindicator = 'H'.
            lv_wrbtr = lv_wrbtr + ( ls_matdocs-amount - ls_matdocs-taxamount ).
          ELSE.
            lv_wrbtr = lv_wrbtr - ( ls_matdocs-amount - ls_matdocs-taxamount ).
          ENDIF.

          ls_item_data-supplier_invoice_item = sy-tabix.
          ls_item_data-company_code = ls_matdocs-Plant.
          ls_item_data-quantity = ls_matdocs-quantity.
          ls_item_data-quantity_unit = ls_matdocs-qtyunit.
          ls_item_data-document_currency = 'USD'.
          ls_item_data-debit_credit_code = ls_matdocs-dcindicator.
          ls_item_data-supplier_invoice_item_amou = (  ls_matdocs-amount - ls_matdocs-taxamount ).
          ls_item_data-tax_code = 'W0'.
          ls_item_data-supplier_invoice_item_text = | { ls_matdocs-materialdocument } 'and' { ls_matdocs-materialdocumentyear } |.
          APPEND ls_item_data TO ls_invitem_business_data.
          CLEAR: ls_item_data.

        ENDLOOP.

* Prepare business data
        ls_inv_business_data = VALUE #(
                  company_code                = ls_matdocs-plant
                  document_date = sy-datum
                  posting_date = sy-datum
                  tax_determination_date = sy-datum
                  invoicing_party = ls_matdocs-supplier
                  invoice_gross_amount = lv_wrbtr
                  document_currency = 'USD'
                  accounting_document_type = 'RE'
                  supplier_invoice_status = '5'
                  supplier_invoice_origin = 'K'
                   ).

        MOVE-CORRESPONDING ls_inv_business_data TO ls_deep_data.
        ls_deep_data-to_supplier_invoice_item_g = ls_invitem_business_data[].

        TRY.
            lo_http_client = cl_web_http_client_manager=>create_by_http_destination(
                      i_destination = cl_http_destination_provider=>create_by_url( lc_inv_url ) ).
            DATA(lo_http_req) = lo_http_client->get_http_request( ).
            lo_http_req->set_authorization_basic(
                                                   i_username = lc_user
                                                   i_password = lc_password
                                                 ).

            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
            EXPORTING
               is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                   proxy_model_id      = 'ZPR_SCM_CBP_INV'
                                                   proxy_model_version = '0001' )
              io_http_client             = lo_http_client
              iv_relative_service_root   = ''  ).

            ASSERT lo_http_client IS BOUND.

            APPEND 'COMPANY_CODE' TO  lt_property.
            APPEND 'DOCUMENT_DATE' TO lt_property.
            APPEND 'POSTING_DATE' TO lt_property.
            APPEND 'TAX_DETERMINATION_DATE' TO lt_property.
            APPEND 'SUPPLIER_INVOICE_IDBY_INVC' TO  lt_property.
            APPEND 'INVOICING_PARTY' TO  lt_property.
            APPEND 'INVOICE_GROSS_AMOUNT' TO  lt_property.
            APPEND 'DOCUMENT_CURRENCY' TO lt_property.
            APPEND 'ACCOUNTING_DOCUMENT_TYPE' TO  lt_property.
            APPEND 'SUPPLIER_INVOICE_STATUS' TO lt_property.
            APPEND 'SUPPLIER_INVOICE_ORIGIN' TO lt_property.

            APPEND 'SUPPLIER_INVOICE_ITEM' TO lt_item_property.
            APPEND 'COMPANY_CODE' TO lt_item_property.
            APPEND 'QUANTITY' TO lt_item_property.
            APPEND 'QUANTITY_UNIT' TO lt_item_property.
            APPEND 'DOCUMENT_CURRENCY' TO lt_item_property.
            APPEND 'DEBIT_CREDIT_CODE' TO lt_item_property.
            APPEND 'SUPPLIER_INVOICE_ITEM_AMOU' TO  lt_item_property.
            APPEND 'TAX_CODE' TO lt_item_property.
            APPEND 'SUPPLIER_INVOICE_ITEM_TEXT' TO lt_item_property.

            lo_http_client->set_csrf_token( ).
            " Navigate to the resource and create a request for the create operation
            lo_request = lo_client_proxy->create_resource_for_entity_set( 'A_SUPPLIER_INVOICE' )->create_request_for_create( ).

            DATA(lo_data_description_node) = lo_request->create_data_descripton_node( ).
            lo_data_description_node->set_properties( lt_property  ).
            lo_data_description_node->add_child( 'TO_SUPPLIER_INVOICE_ITEM_G' )->set_properties( lt_item_property ).
            " Set the business data for the created entity
            lo_request->set_deep_business_data(
            is_business_data =  ls_deep_data
            io_data_description = lo_data_description_node
            ).

            " Execute the request
            lo_response = lo_request->execute( ).

            CLEAR: ls_business_data.
            " Get the after image
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

            IF ls_business_data-supplier_invoice IS NOT INITIAL.

            ENDIF.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            IF lx_remote->get_text( ) IS NOT INITIAL.
              lt_msg = VALUE #( ( message = lx_remote->get_text( ) ) ).
              IF lt_msg[] IS NOT INITIAL.
                lv_message = lt_msg[ 1 ]-message.
              ENDIF.
            ENDIF.

            IF lx_remote->s_odata_error-message IS NOT INITIAL.
              lt_msg = VALUE #( BASE lt_msg ( message = lx_remote->s_odata_error-message ) ).
              IF lt_msg[] IS NOT INITIAL.
                lv_message = lt_msg[ 2 ]-message.
              ENDIF.
            ENDIF.

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            lt_msg = VALUE #( ( message = lx_gateway->get_text( ) ) ).
            IF lt_msg[] IS NOT INITIAL.
              lv_message = lt_msg[ 1 ]-message.
            ENDIF.

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            lv_message =  lx_web_http_client_error->get_longtext(  ).

          CATCH cx_http_dest_provider_error INTO DATA(lx_web_http_dest_error).
            lv_message =  lx_web_http_dest_error->get_longtext(  ).

        ENDTRY.
      ENDIF.
    ENDIF.

  ENDMETHOD.
ENDCLASS.

CLASS lsc_zpr_i_consignment DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zpr_i_consignment IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.