  METHOD if_rap_query_provider~select.

    DATA : lt_result   TYPE STANDARD TABLE OF zpr_i_ud_get,
           ls_result   LIKE LINE OF lt_result,
           lv_count    TYPE int8,
           lv_matnr    TYPE matnr,
           lv_wtktno   TYPE zpr_dt_wtktno,
           lv_wtktitm  TYPE zpr_dt_wtktitm,
           lv_prueflos TYPE zpr_dt_qplos.

    DATA(top)     = io_request->get_paging( )->get_page_size( ).
    DATA(skip)    = io_request->get_paging( )->get_offset( ).
    DATA(requested_fields)  = io_request->get_requested_elements( ).
    DATA(sort_order)    = io_request->get_sort_elements( ).
    TRY.
        DATA(lt_get_filter) = io_request->get_filter( )->get_as_ranges( ).
      CATCH cx_rap_query_filter_no_range INTO DATA(lx_remote)..

    ENDTRY.
    DATA(ls_get_filter_sql) = io_request->get_filter( )->get_as_sql_string( ).


    LOOP AT lt_get_filter INTO DATA(ls_filter).
      READ TABLE ls_filter-range INTO DATA(ls_filter_data) INDEX 1.
      CASE ls_filter-name.
        WHEN 'MATNR'.
          lv_matnr = ls_filter_data-low.
        WHEN 'WTKTNO'.
          lv_wtktno = ls_filter_data-low.
        WHEN 'WTKTITM'.
          lv_wtktitm = ls_filter_data-low.
      ENDCASE.
    ENDLOOP.


**fetch inspection lot from weight ticket item table
    SELECT SINGLE prueflos FROM zpr_tb_wt_it WHERE wtktno = @lv_wtktno
                                                 AND wtktitm = @lv_wtktitm
                                                 INTO @lv_prueflos.
    IF sy-subrc EQ 0.
      SELECT inspectionlot, inspectioncharacteristic, inspectioncharacteristictext, inspectionspecification,
        inspectionspecificationunit
       FROM i_inspectioncharacteristic WHERE inspectionlot = @lv_prueflos
       INTO TABLE @DATA(lt_char).
      IF sy-subrc EQ 0.
        SELECT * FROM i_inspectionresult WHERE inspectionlot = @lv_prueflos
           INTO TABLE @DATA(lt_insp_results).
        LOOP AT lt_char INTO DATA(ls_char).
          ls_result-wtktno = lv_wtktno.
          ls_result-wtktitm = lv_wtktitm.
          ls_result-charac = ls_char-inspectionspecification.
          ls_result-charac_text = ls_char-inspectioncharacteristictext.
          ls_result-specification = ls_char-inspectionspecificationunit.
          READ TABLE lt_insp_results INTO DATA(ls_results) WITH KEY inspectionlot = lv_prueflos
                                                                    inspectioncharacteristic = ls_char-inspectioncharacteristic.
          IF sy-subrc EQ 0.
            ls_result-result_val = ls_results-inspectionresultmeanvalue.
          ENDIF.
          IF ls_results-inspectionvaluationresult = 'A'.
            ls_result-valuation = 'Accept'.
          ELSEIF ls_results-inspectionvaluationresult = 'R'.
            ls_result-valuation = 'Reject'.
          ENDIF.
          APPEND ls_result TO lt_result.
          CLEAR: ls_result, ls_char.
        ENDLOOP.
      ENDIF.
    ENDIF.

    IF lt_result[] IS NOT INITIAL.
      lv_count = lines( lt_result ).
      io_response->set_total_number_of_records( lv_count ).
      io_response->set_data( lt_result ).
    ENDIF.

  ENDMETHOD.