  METHOD if_rap_query_provider~select.
*This custom entity is used to fetch the standard documents from weight ticket table

    TYPES : BEGIN OF ty_docu_log,
              wtktno       TYPE  zpr_dt_wtktno,
              doc_type     TYPE char20,
              doc_num      TYPE char20,
              url(1000)    TYPE c,
              created_date TYPE sy-datum,
              created_user TYPE sy-uname,
            END OF ty_docu_log.
    DATA : lt_wtkt     TYPE STANDARD TABLE OF  zpr_tb_wt_hd,
           ls_wtkt     LIKE LINE OF lt_wtkt,
           lt_docu_log TYPE STANDARD TABLE OF ty_docu_log,
           ls_docu_log TYPE ty_docu_log,
           lv_count    TYPE int8.

    DATA : lv_if_po          TYPE ebeln,
           lv_if_mblnr       TYPE zpr_dt_gr_po,
           lv_if_aufnr       TYPE zpr_dt_proc_order,
           lv_if_mblnr_gr    TYPE zpr_dt_gr,
           lv_if_mblnr_gi    TYPE zpr_dt_gi,
           lv_if_invoice     TYPE zpr_dt_invoice,
           lv_if_invoice_npc TYPE zpr_dt_invoice_npc,
           lv_if_invoice_npb TYPE zpr_dt_invoice_npb,
           lv_if_invoice_frw TYPE zpr_dt_invoice_frw,
           lv_if_invoice_hnd TYPE zpr_dt_invoice_hnd.


    DATA(top)     = io_request->get_paging( )->get_page_size( ).
    DATA(skip)    = io_request->get_paging( )->get_offset( ).
    DATA(requested_fields)  = io_request->get_requested_elements( ).
    DATA(sort_order)    = io_request->get_sort_elements( ).

    TRY.
        DATA(lt_get_filter) = io_request->get_filter( )->get_as_ranges( ).
      CATCH cx_rap_query_filter_no_range INTO DATA(lx_remote)..

    ENDTRY.
    DATA(ls_get_filter_sql) = io_request->get_filter( )->get_as_sql_string( ).


    SELECT SINGLE * FROM zpr_tb_wt_it WHERE (ls_get_filter_sql)  INTO @DATA(ls_wtkt_item).

    IF ls_wtkt_item-ebeln IS NOT INITIAL OR lv_if_po IS NOT INITIAL.
      CLEAR :   ls_docu_log.
      ls_docu_log-wtktno = ls_wtkt_item-wtktno.
      ls_docu_log-doc_type = 'PO'.
      IF ls_wtkt_item-ebeln IS NOT INITIAL.
        ls_docu_log-doc_num = ls_wtkt_item-ebeln.
      ELSE.
        ls_docu_log-doc_num = lv_if_po.
      ENDIF.

      IF sy-subrc EQ 0.
      ENDIF.
      CONCATENATE '/sap/bc/ui2/flp#PurchaseOrder-displayFactSheet&/C_PurchaseOrderFs(%27'
                  ls_wtkt_item-ebeln
                  '%27)' INTO ls_docu_log-url.

      APPEND ls_docu_log TO lt_docu_log.
    ENDIF.


    CLEAR :   ls_docu_log.
    ls_docu_log-wtktno = ls_wtkt_item-wtktno.
    ls_docu_log-doc_type = 'GR'.
    IF ls_wtkt_item-mblnr IS NOT INITIAL.
      ls_docu_log-doc_num = ls_wtkt_item-mblnr.
    ELSE.
      ls_docu_log-doc_num = lv_if_mblnr.
    ENDIF.

    IF sy-subrc EQ 0.
    ENDIF.

    CONCATENATE '/sap/bc/ui2/flp?sap-client=400&sap-language=EN#GoodsReceipt-flowDisplay?&Ebeln='
                ls_wtkt_item-ebeln
                INTO ls_docu_log-url.
    APPEND ls_docu_log TO lt_docu_log.


*      CLEAR :   ls_docu_log.
*      ls_docu_log-wtktno = ls_wtkt-wtktno.
*      ls_docu_log-doc_type = 'Process Order'.
*      IF ls_wtkt_item-aufnr IS NOT INITIAL.
*        ls_docu_log-doc_num = ls_wtkt_item-aufnr.
*      ELSE.
*        ls_docu_log-doc_num = lv_if_aufnr.
*      ENDIF.
**fetch dates
*
**        SELECT SINGLE ernam erdat FROM aufk INTO (ls_docu_log-created_user, ls_docu_log-created_date) WHERE aufnr = ls_wtkt-aufnr.
*      IF sy-subrc EQ 0.
*      ENDIF.
*      CONCATENATE '/sap/bc/ui2/flp?sap-client=400&sap-language=EN#ProcessOrder-displayFactSheet&/C_ProcessOrderObjPg(%27'
*                  ls_wtkt-aufnr
*                  '%27)'
*                  INTO ls_docu_log-url.
**ls_docu_log-url   = '/sap/bc/ui2/flp?sap-client=400&sap-language=EN#ProcessOrder-displayFactSheet&/C_ProcessOrderObjPg(%27000001001299%27)'.
*
**      ls_docu_log-url = 'ProcessOrder-displayFactSheet?'.
*      APPEND ls_docu_log TO lt_docu_log.
**    ENDIF.

*    IF ls_wtkt-goods_issue IS NOT INITIAL OR lv_if_mblnr_gi IS NOT INITIAL.
*      CLEAR :   ls_docu_log.
*      ls_docu_log-wtktno = ls_wtkt-wtktno.
*      ls_docu_log-doc_type = 'Goods Issue'.
*      IF ls_wtkt_item-goods_issue IS NOT INITIAL.
*        ls_docu_log-doc_num = ls_wtkt-goods_issue.
*      ELSE.
*        ls_docu_log-doc_num = lv_if_mblnr_gi.
*      ENDIF.
**        SELECT SINGLE bldat usnam FROM mkpf
**                      INTO (ls_docu_log-created_date, ls_docu_log-created_user)
**                      WHERE mblnr = ls_wtkt-goods_issue.
*      IF sy-subrc EQ 0.
*      ENDIF.
*      ls_docu_log-url = 'GoodsIssue-flowDisplay?'.
*      APPEND ls_docu_log TO lt_docu_log.
**    ENDIF.
*
**    IF ls_wtkt-goods_receipt IS NOT INITIAL OR lv_if_mblnr_gr IS NOT INITIAL.
*      CLEAR :   ls_docu_log.
*      ls_docu_log-wtktno = ls_wtkt-wtktno.
*      ls_docu_log-doc_type = 'Goods Receipt'.
*      IF ls_wtkt-goods_receipt IS NOT INITIAL.
*        ls_docu_log-doc_num = ls_wtkt-goods_receipt.
*      ELSE.
*        ls_docu_log-doc_num = lv_if_mblnr_gr.
*      ENDIF.
**        SELECT SINGLE bldat usnam FROM mkpf
**                      INTO (ls_docu_log-created_date, ls_docu_log-created_user)
**                      WHERE mblnr = ls_wtkt-goods_receipt.
*      IF sy-subrc EQ 0.
*      ENDIF.
*      ls_docu_log-url = 'GoodsReceipt-flowDisplay?'.
*      APPEND ls_docu_log TO lt_docu_log.
**    ENDIF.

*    IF ls_wtkt-invoice IS NOT INITIAL OR lv_if_invoice IS NOT INITIAL.
    CLEAR :   ls_docu_log.
    ls_docu_log-wtktno = ls_wtkt_item-wtktno.
    ls_docu_log-doc_type = 'Invoice'.
    IF lv_if_invoice IS INITIAL.
      ls_docu_log-doc_num = ls_wtkt_item-invoice.
    ELSE.
      ls_docu_log-doc_num = lv_if_invoice.
    ENDIF.
*        SELECT SINGLE budat usnam FROM rbkp INTO (ls_docu_log-created_date, ls_docu_log-created_user) WHERE belnr = ls_wtkt-invoice.
    IF sy-subrc EQ 0.
    ENDIF.


    APPEND ls_docu_log TO lt_docu_log.
*    ENDIF.

**    IF ls_wtkt-invoice_npc IS NOT INITIAL OR lv_if_invoice_npc IS NOT INITIAL.
*      CLEAR :   ls_docu_log.
*      ls_docu_log-wtktno = ls_wtkt_item-wtktno.
*      ls_docu_log-doc_type = 'NPC Invoice'.
*      IF ls_wtkt_item-invoice_npc IS NOT INITIAL.
*        ls_docu_log-doc_num = ls_wtkt_item-invoice_npc.
*      ELSE.
*        ls_docu_log-doc_num = lv_if_invoice_npc.
*      ENDIF.
**        SELECT SINGLE budat usnam FROM bkpf INTO (ls_docu_log-created_date, ls_docu_log-created_user) WHERE belnr = ls_wtkt-invoice_npc.
*      IF sy-subrc EQ 0.
*      ENDIF.
*      APPEND ls_docu_log TO lt_docu_log.
**    ENDIF.
*
**    IF ls_wtkt-invoice_npb IS NOT INITIAL OR lv_if_invoice_npb IS NOT INITIAL.
*      CLEAR :   ls_docu_log.
*      ls_docu_log-wtktno = ls_wtkt-wtktno.
*      ls_docu_log-doc_type = 'NPB Invoice'.
*      IF ls_wtkt-invoice_npb IS NOT INITIAL.
*        ls_docu_log-doc_num = ls_wtkt-invoice_npb.
*      ELSE.
*        ls_docu_log-doc_num = lv_if_invoice_npb.
*      ENDIF.
**        SELECT SINGLE budat usnam FROM bkpf INTO (ls_docu_log-created_date, ls_docu_log-created_user) WHERE belnr = ls_wtkt-invoice_npb.
*      IF sy-subrc EQ 0.
*      ENDIF.
*      APPEND ls_docu_log TO lt_docu_log.
**    ENDIF.


    lv_count = lines( lt_docu_log ).
    io_response->set_total_number_of_records( lv_count ).
    io_response->set_data( lt_docu_log ).

  ENDMETHOD.