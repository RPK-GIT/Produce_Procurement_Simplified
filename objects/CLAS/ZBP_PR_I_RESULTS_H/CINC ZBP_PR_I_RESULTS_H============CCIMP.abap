CLASS lhc_zpr_i_results_h DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zpr_i_results_h RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zpr_i_results_h.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zpr_i_results_h.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zpr_i_results_h.

    METHODS read FOR READ
      IMPORTING keys FOR READ zpr_i_results_h RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zpr_i_results_h.

    METHODS rba_item FOR READ
      IMPORTING keys_rba FOR READ zpr_i_results_h\_item FULL result_requested RESULT result LINK association_links.

    METHODS cba_item FOR MODIFY
      IMPORTING entities_cba FOR CREATE zpr_i_results_h\_item.

ENDCLASS.

CLASS lhc_zpr_i_results_h IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rba_item.
  ENDMETHOD.

  METHOD cba_item.

    DATA : lv_prueflos TYPE zpr_dt_qplos,
           lv_msg      TYPE string,
           lv_wtktno   TYPE zpr_dt_wtktno,
           lv_item     TYPE zpr_dt_wtktitm.

    TYPES: BEGIN OF ty_return,
             message TYPE string,
           END OF ty_return,

           tt_return TYPE STANDARD TABLE OF ty_return WITH DEFAULT KEY.

    DATA: lo_http_client        TYPE REF TO if_web_http_client,
          lo_client_proxy       TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request            TYPE REF TO /iwbep/if_cp_request_create,
          lo_response           TYPE REF TO /iwbep/if_cp_response_create,
          lt_property           TYPE /iwbep/if_cp_runtime_types=>ty_t_property_path,
          lt_item_property      TYPE /iwbep/if_cp_runtime_types=>ty_t_property_path,
          lt_msg                TYPE tt_return,
          lv_message            TYPE string,
          ls_insp_business_data TYPE zpr_scm_cbp_insp=>tys_a_inspection_result_type,
          ls_business_data      TYPE zpr_scm_cbp_insp=>tys_a_inspection_result_type.

    CONSTANTS: lc_insp_url TYPE string VALUE 'https://my403232-api.s4hana.cloud.sap/sap/opu/odata/sap/API_INSPECTIONLOT_SRV',
               lc_user     TYPE string VALUE 'DEMO_API_PC',
               lc_password TYPE string VALUE 'fSQ#xoXWmonAJJnqVaKoqzmRuxAh9ZfFktRbFSfL'.

    LOOP AT entities_cba INTO DATA(ls_data).
      lv_wtktno = ls_data-wtktno.
      LOOP AT ls_data-%target INTO DATA(ls_characs).
        lv_wtktno = ls_characs-wtktno.
        lv_item = ls_characs-wtktitm.
        SELECT SINGLE * FROM zpr_tb_wt_it WHERE wtktno =  @lv_wtktno                                        "EC NEEDED
                                              AND wtktitm =  @lv_item INTO @DATA(ls_item_data).
* Get inspection lot characteristic
        SELECT SINGLE * FROM i_inspectioncharacteristic WHERE inspectionlot = @ls_item_data-prueflos
          AND inspectionspecification = @ls_characs-charac
          INTO @DATA(ls_insp_char).

        TRY.
* Update PO Price - add custom condition types based on results recording
            lo_http_client = cl_web_http_client_manager=>create_by_http_destination(
                      i_destination = cl_http_destination_provider=>create_by_url( lc_insp_url ) ).
            DATA(lo_http_req) = lo_http_client->get_http_request( ).
            lo_http_req->set_authorization_basic(
                                                   i_username = lc_user
                                                   i_password = lc_password
                                                 ).

            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
            EXPORTING
               is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                   proxy_model_id      = 'ZPR_SCM_CBP_INSP'
                                                   proxy_model_version = '0001' )
              io_http_client             = lo_http_client
              iv_relative_service_root   = ''  ).

            ASSERT lo_http_client IS BOUND.

            lo_http_client->set_csrf_token( ).
            " Navigate to the resource and create a request for the create operation
            lo_request = lo_client_proxy->create_resource_for_entity_set( 'A_INSPECTION_RESULT' )->create_request_for_create( ).

            ls_insp_business_data-inspection_lot = ls_item_data-prueflos.
            ls_insp_business_data-insp_plan_operation_intern = '1'.
            ls_insp_business_data-inspection_valuation_resul = ls_characs-status.
            ls_insp_business_data-inspection_characteristic = ls_insp_char-inspectioncharacteristic.
            ls_insp_business_data-inspection_result_status = '5'.
            ls_insp_business_data-insp_result_frmtd_mean_val = ls_characs-resultval.
            ls_insp_business_data-insp_result_valid_values_n = '1'.

            APPEND 'INSPECTION_LOT' TO lt_item_property.
            APPEND 'INSP_PLAN_OPERATION_INTERN' TO lt_item_property.
            APPEND 'INSPECTION_VALUATION_RESUL' TO lt_item_property.
            APPEND 'INSPECTION_CHARACTERISTIC' TO lt_item_property.
            APPEND 'INSPECTION_RESULT_STATUS' TO lt_item_property.
            APPEND 'INSP_RESULT_FRMTD_MEAN_VAL' TO lt_item_property.
            APPEND 'INSP_RESULT_VALID_VALUES_N' TO lt_item_property.

            " Set the business data for the created entity
            lo_request->set_business_data(
            is_business_data =  ls_insp_business_data
            it_provided_property = lt_item_property
            ).

            " Execute the request
            lo_response = lo_request->execute( ).
            WAIT UP TO 3 SECONDS.

            CLEAR: ls_business_data.
            " Get the after image
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

            IF ls_business_data IS NOT INITIAL.
              UPDATE zpr_tb_wt_it SET status = '30' WHERE wtktno = @lv_wtktno AND wtktitm =  @lv_item.
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
      ENDLOOP.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_zpr_i_results_item DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zpr_i_results_item.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zpr_i_results_item.

    METHODS read FOR READ
      IMPORTING keys FOR READ zpr_i_results_item RESULT result.

    METHODS rba_header FOR READ
      IMPORTING keys_rba FOR READ zpr_i_results_item\_header FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_zpr_i_results_item IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_header.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zpr_i_results_h DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zpr_i_results_h IMPLEMENTATION.

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