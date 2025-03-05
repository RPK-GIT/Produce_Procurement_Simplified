  METHOD if_rap_query_provider~select.

DATA: lv_const  TYPE string  VALUE '&1&2&3&4&5&6&7&8&9'.
    TYPES : BEGIN OF ty_log,
              werks    TYPE  werks_d,
              wtktno   TYPE  zpr_dt_wtktno,
              item     TYPE  zpr_dt_wtktitm,
              mdate    TYPE sy-datum,
              time     TYPE sy-timlo,
              muser    TYPE sy-uname,
              message  TYPE c LENGTH 73,
              newvalue TYPE symsgv,
            END OF ty_log.

    DATA : lt_ui_log TYPE STANDARD TABLE OF ty_log,
           ls_ui_log TYPE ty_log.

    DATA : lv_werks   TYPE werks_d,
           lv_wtktno  TYPE zpr_dt_wtktno.

    DATA : lt_log_table TYPE STANDARD TABLE OF zpr_tb_log,
           ls_log_table TYPE zpr_tb_log.

    DATA(top)     = io_request->get_paging( )->get_page_size( ).
    DATA(skip)    = io_request->get_paging( )->get_offset( ).
    DATA(requested_fields)  = io_request->get_requested_elements( ).
    DATA(sort_order)    = io_request->get_sort_elements( ).

   TRY.
    DATA(lt_get_filter) = io_request->get_filter( )->get_as_ranges( ).

   CATCH CX_RAP_QUERY_FILTER_NO_RANGE INTO DATA(lx_remote)..

   ENDTRY.
    DATA(ls_get_filter_sql) = io_request->get_filter( )->get_as_sql_string( ).


    LOOP AT lt_get_filter INTO DATA(ls_filter).
      READ TABLE ls_filter-range INTO DATA(ls_filter_data) INDEX 1.
      CASE ls_filter-name.
        WHEN 'WERKS'.
          lv_werks = ls_filter_data-low.
        WHEN 'WTKTNO'.
          lv_wtktno = ls_filter_data-low.
      ENDCASE.
    ENDLOOP.


    SELECT * FROM zpr_tb_log WHERE werks =  @lv_werks
                                  AND wtktno =  @lv_wtktno INTO TABLE @lt_log_table.
    IF sy-subrc EQ 0.
    ENDIF.

    DATA : lv_item TYPE zpr_dt_wtktitm.
    CLEAR : lv_item.
    LOOP AT lt_log_table INTO ls_log_table.
      CLEAR : ls_ui_log.
      ls_ui_log-werks = ls_log_table-werks.
      ls_ui_log-wtktno = ls_log_table-wtktno.


      lv_item = lv_item + 10.
      ls_ui_log-item = lv_item.

      ls_ui_log-mdate = ls_log_table-mdate.
      ls_ui_log-time = ls_log_table-time.
      ls_ui_log-muser = ls_log_table-muser.
      ls_ui_log-message = ls_log_table-messsage.
      ls_ui_log-newvalue = ls_log_table-new_value.

      APPEND ls_ui_log TO lt_ui_log.

    ENDLOOP.

    DATA : lv_count      TYPE int8.
    lv_count = lines( lt_ui_log ).
    io_response->set_total_number_of_records( lv_count ).
    io_response->set_data( lt_ui_log ).

  ENDMETHOD.