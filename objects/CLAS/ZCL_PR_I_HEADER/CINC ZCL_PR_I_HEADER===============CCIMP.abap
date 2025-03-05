CLASS lcl_pr_buffer DEFINITION.
  PUBLIC SECTION.

    TYPES  : tt_hdr  TYPE SORTED TABLE OF zpr_tb_wt_hd WITH UNIQUE KEY werks wtktno,
             tt_item TYPE SORTED TABLE OF zpr_tb_wt_it WITH UNIQUE KEY werks wtktno wtktitm,
             tt_log  TYPE STANDARD TABLE OF zpr_tb_log.


    CLASS-DATA : mt_hdr_create          TYPE tt_hdr,
                 mt_hdr_update          TYPE tt_hdr,
                 mt_hdr_read            TYPE tt_hdr,
                 mt_hdr_delete          TYPE tt_hdr,
                 mt_item_create         TYPE tt_item,
                 mt_item_from_header    TYPE tt_item,
                 mt_item_update         TYPE tt_item,
                 mt_item_read           TYPE tt_item,
                 mt_item_delete         TYPE tt_item,
                 mt_log                 TYPE tt_log,
                 gv_error_flag          TYPE char1,
                 gv_msg_num             TYPE symsgno,
                 gv_msg_v1              TYPE symsgv,
                 gv_msg_v2              TYPE symsgv,
                 gv_msg_v3              TYPE symsgv,
                 gv_msg_v4              TYPE symsgv,
                 gv_flag_process_data   TYPE char1,
                 gv_flag_pricing_update TYPE char1,
                 gv_flag_postinv        TYPE char1,
                 gv_flag_wtkt_delete    TYPE char1,
                 gv_wtkt_num_delete     TYPE zpr_dt_wtktno,
                 gv_werks               TYPE werks_d,
                 gv_wtkt_num            TYPE zpr_dt_wtktno,
                 gv_wtkt_item           TYPE zpr_dt_wtktitm,
                 gv_po                  TYPE ebeln,
                 gv_po_item             TYPE ebeln,
                 gv_mblnr               TYPE zpr_dt_belnr,
                 gv_mblnr_item          TYPE zpr_dt_belnr,
                 gv_prueflos            TYPE zpr_dt_qplos,
                 gv_charg               TYPE zpr_dt_charg_d,
                 gv_gr_prod             TYPE zpr_dt_gr,
                 gv_gi                  TYPE zpr_dt_belnr,
                 gv_process_order       TYPE zpr_dt_proc_order,
                 gv_invoice             TYPE zpr_dt_invoice,
                 gv_invoice_item        TYPE zpr_dt_invoice,
                 gv_invoice_split1      TYPE zpr_dt_invoice,
                 gv_invoice_split2      TYPE zpr_dt_invoice,
                 gv_invoice_split3      TYPE zpr_dt_invoice,
                 gv_invoice_nppc        TYPE zpr_dt_invoice_npc,
                 gv_invoice_npb         TYPE zpr_dt_invoice_npb,
                 gv_invoice_frw         TYPE zpr_dt_invoice_frw,
                 gv_invoice_hnd         TYPE zpr_dt_invoice_hnd,
                 lv_dock_count_create   TYPE zpr_dt_quantity,
                 lv_dock_count_update   TYPE zpr_dt_quantity,
                 gv_wtkt_key            TYPE zpr_dt_wtktno,
                 gv_wtkt_read           TYPE zpr_dt_wtktno,
                 gv_po_price            TYPE zpr_dt_poprice.

ENDCLASS.

CLASS lhc_header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR header RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR header RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE header.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE header.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE header.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE header.

    METHODS read FOR READ
      IMPORTING keys FOR READ header RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK header.

    METHODS rba_item FOR READ
      IMPORTING keys_rba FOR READ header\_item FULL result_requested RESULT result LINK association_links.

    METHODS cba_item FOR MODIFY
      IMPORTING entities_cba FOR CREATE header\_item.

    METHODS earlynumbering_cba_item FOR NUMBERING
      IMPORTING entities FOR CREATE header\_item.

    METHODS copy FOR MODIFY
      IMPORTING keys FOR ACTION header~copy.

    METHODS haulerpo FOR MODIFY
      IMPORTING keys FOR ACTION header~haulerpo RESULT result.

    METHODS defaultdata FOR DETERMINE ON MODIFY
      IMPORTING keys FOR header~defaultdata.

    METHODS getuom FOR DETERMINE ON MODIFY
      IMPORTING keys FOR header~getuom.

    METHODS calcnetweight FOR DETERMINE ON MODIFY
      IMPORTING keys FOR header~calcnetweight.

ENDCLASS.

CLASS lhc_header IMPLEMENTATION.

  METHOD get_instance_features.

    LOOP AT keys INTO DATA(ls_keys).
      DATA(lv_wtktno) = ls_keys-wtktno.
      DATA(lv_werks) = ls_keys-werks.
      IF ls_keys-%is_draft EQ '01'.
        DATA(lv_draft)  = abap_true.
      ELSE.
        lv_draft = abap_false.
      ENDIF.
    ENDLOOP.

    SELECT * FROM zpr_tb_wt_hd WHERE wtktno = @lv_wtktno
                                   AND werks = @lv_werks
                                   INTO TABLE @DATA(lt_header).
    IF sy-subrc EQ 0.
      READ TABLE lt_header INTO DATA(ls_header_from_db) INDEX 1.
      IF sy-subrc EQ 0.
      ENDIF.
    ELSE.
      DATA(lv_new) = abap_true.
    ENDIF.

    READ ENTITIES OF zpr_i_header IN LOCAL MODE ENTITY header
    ALL FIELDS WITH CORRESPONDING #( keys ) RESULT DATA(headers).

    READ TABLE headers INTO DATA(ls_data) INDEX 1.

    result = VALUE #( FOR ls_header_status IN headers
                           %tky = ls_keys-%tky
                           wtktno = ls_keys-wtktno
                           werks = ls_keys-werks
                           (
                              %action-haulerpo = COND #( WHEN ls_header_from_db-hauler_po IS  INITIAL AND lv_draft = abap_false AND lv_new EQ abap_false
                                                    THEN if_abap_behv=>fc-o-enabled
                                                    ELSE if_abap_behv=>fc-o-disabled )
                            ) ).

  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create.

    DATA : lt_header     TYPE STANDARD TABLE OF zpr_tb_wt_hd,
           ls_header     TYPE zpr_tb_wt_hd,
           ls_struct     TYPE REF TO cl_abap_structdescr,
           lt_comp       TYPE cl_abap_structdescr=>component_table,
           lv_name       TYPE char30,
           lv_error_flag TYPE char1,
           lv_msg_num    TYPE syst-msgno,
           lv_msg_v1     TYPE syst-msgv1,
           lv_msg_v2     TYPE syst-msgv2,
           ls_wt_hdr     TYPE zpr_tb_wt_hd.

**as it is having only one record
    READ TABLE entities INTO DATA(ls_data) INDEX 1.
    MOVE-CORRESPONDING ls_data TO ls_header.
    ls_header-qualifier = ls_data-qualifier.
    ls_header-hauler = ls_data-hauler.
    ls_header-supplier = ls_data-supplier.
    ls_header-lifnr = ls_data-lifnr.
    ls_header-driverperf = ls_data-driverperf.
    ls_header-truckcond = ls_data-truckcond.
    ls_header-mat_distance = ls_data-matdistance.
    ls_header-mat_weight = ls_data-matweight.
    ls_header-dis_travelled = ls_data-distravelled.
* Add code for validations

* Check for Mandatory fields
    IF ls_data-lifnr IS NOT INITIAL.
*         ls_data-matdistance IS NOT INITIAL AND
*         ls_data-matweight IS NOT INITIAL AND
*         ls_data-distravelled IS NOT INITIAL.
    ELSE.
      lv_msg_num = '175'.
      APPEND VALUE #( %key = ls_data-%key ) TO failed-header.
      APPEND VALUE #( wtktno = ls_data-wtktno
                  werks = ls_data-werks
                  %msg = new_message(
                  id = 'ZPR_MESSAGES'
                  number = lv_msg_num
                  severity = if_abap_behv_message=>severity-error )
                  ) TO reported-header.
    ENDIF.

    SELECT * FROM zpr_i_supplier INTO TABLE @DATA(lt_supplier).

* Invalid Qualifier
    IF ls_header-qualifier IS NOT INITIAL.
      READ TABLE lt_supplier INTO DATA(ls_supplier) WITH KEY lifnr = ls_header-qualifier.
      IF sy-subrc NE 0.
        lv_msg_num = '161'.
        APPEND VALUE #( %key = ls_data-%key ) TO failed-header.
        APPEND VALUE #( wtktno = ls_data-wtktno
                     werks = ls_data-werks
                     %msg = new_message(
                     id = 'ZPR_MESSAGES'
                     number = lv_msg_num
                     severity = if_abap_behv_message=>severity-error )
                     ) TO reported-header.
      ENDIF.
    ENDIF.
    CLEAR: ls_supplier.

* Invalid Hauler
    IF ls_header-hauler IS NOT INITIAL.
      READ TABLE lt_supplier INTO ls_supplier WITH KEY lifnr = ls_header-hauler.
      IF sy-subrc NE 0.
        lv_msg_num = '162'.
        APPEND VALUE #( %key = ls_data-%key ) TO failed-header.
        APPEND VALUE #( wtktno = ls_data-wtktno
                     werks = ls_data-werks
                     %msg = new_message(
                     id = 'ZPR_MESSAGES'
                     number = lv_msg_num
                     severity = if_abap_behv_message=>severity-error )
                     ) TO reported-header.
      ENDIF.
    ENDIF.
    CLEAR: ls_supplier.

* Invalid Supplier
    IF ls_header-supplier IS NOT INITIAL.
      READ TABLE lt_supplier INTO ls_supplier WITH KEY lifnr = ls_header-supplier.
      IF sy-subrc NE 0.
        lv_msg_num = '163'.
        APPEND VALUE #( %key = ls_data-%key ) TO failed-header.
        APPEND VALUE #( wtktno = ls_data-wtktno
                     werks = ls_data-werks
                     %msg = new_message(
                     id = 'ZPR_MESSAGES'
                     number = lv_msg_num
                     severity = if_abap_behv_message=>severity-error )
                     ) TO reported-header.
      ENDIF.
    ENDIF.
    CLEAR: ls_supplier.

    IF ls_header-lifnr IS NOT INITIAL.
      READ TABLE lt_supplier INTO ls_supplier WITH KEY lifnr = ls_header-lifnr.
      IF sy-subrc NE 0.
        lv_msg_num = '163'.
        APPEND VALUE #( %key = ls_data-%key ) TO failed-header.
        APPEND VALUE #( wtktno = ls_data-wtktno
                     werks = ls_data-werks
                     %msg = new_message(
                     id = 'ZPR_MESSAGES'
                     number = lv_msg_num
                     severity = if_abap_behv_message=>severity-error )
                     ) TO reported-header.
      ENDIF.
    ENDIF.
    CLEAR: ls_supplier.

* Check if Driver Performance value is valid
    IF ls_header-driverperf IS NOT INITIAL.
      SELECT SINGLE * FROM zpr_tb_drvrp WHERE driverperf = @ls_header-driverperf
        INTO @DATA(ls_drvrp).
      IF sy-subrc NE 0.
        lv_msg_num = '164'.
        APPEND VALUE #( %key = ls_data-%key ) TO failed-header.
        APPEND VALUE #( wtktno = ls_data-wtktno
                    werks = ls_data-werks
                    %msg = new_message(
                    id = 'ZPR_MESSAGES'
                    number = lv_msg_num
                    severity = if_abap_behv_message=>severity-error )
                    ) TO reported-header.
      ENDIF.
    ENDIF.

* Check if Truck Condition value is valid
    IF ls_header-truckcond IS NOT INITIAL.
      SELECT SINGLE * FROM zpr_tb_trukc WHERE truckcond = @ls_header-truckcond
        INTO @DATA(ls_truckc).
      IF sy-subrc NE 0.
        lv_msg_num = '165'.
        APPEND VALUE #( %key = ls_data-%key ) TO failed-header.
        APPEND VALUE #( wtktno = ls_data-wtktno
                    werks = ls_data-werks
                    %msg = new_message(
                    id = 'ZPR_MESSAGES'
                    number = lv_msg_num
                    severity = if_abap_behv_message=>severity-error )
                    ) TO reported-header.
      ENDIF.
    ENDIF.

    SELECT * FROM zpr_i_material INTO TABLE @DATA(lt_material).

* Validate Material Weight
    IF ls_header-mat_weight IS NOT INITIAL.

      READ TABLE lt_material INTO DATA(ls_material) WITH KEY material = ls_header-mat_weight.
      IF sy-subrc NE 0.
        lv_msg_num = '169'.
        APPEND VALUE #( %key = ls_data-%key ) TO failed-header.
        APPEND VALUE #( wtktno = ls_data-wtktno
                    werks = ls_data-werks
                    %msg = new_message(
                    id = 'ZPR_MESSAGES'
                    number = lv_msg_num
                    severity = if_abap_behv_message=>severity-error )
                    ) TO reported-header.
      ENDIF.
    ENDIF.
    CLEAR: ls_material.

* Validate Material Distance
    IF ls_header-mat_distance IS NOT INITIAL.

      READ TABLE lt_material INTO ls_material WITH KEY material = ls_header-mat_distance.
      IF sy-subrc NE 0.
        lv_msg_num = '170'.
        APPEND VALUE #( %key = ls_data-%key ) TO failed-header.
        APPEND VALUE #( wtktno = ls_data-wtktno
                    werks = ls_data-werks
                    %msg = new_message(
                    id = 'ZPR_MESSAGES'
                    number = lv_msg_num
                    severity = if_abap_behv_message=>severity-error )
                    ) TO reported-header.
      ENDIF.
    ENDIF.

***check for errors
    IF lv_error_flag EQ 'X'.

      APPEND VALUE #( wtktno = ls_data-wtktno
                      werks = ls_data-werks
                      %msg = new_message(
                      id = 'ZPR_MESSAGES'
                      number = lv_msg_num
                      severity = if_abap_behv_message=>severity-error )
                      ) TO reported-header.

    ELSE.

      ls_header-status = '10'.
***moving fields with underscore
      ls_struct ?= cl_abap_typedescr=>describe_by_data( ls_header ).

      LOOP  AT ls_struct->components REFERENCE INTO DATA(ls).
        IF ls->name CS '_'.
          lv_name = ls->name.
          REPLACE ALL OCCURRENCES OF '_' IN lv_name WITH space.
          CONDENSE lv_name NO-GAPS.
          ASSIGN COMPONENT lv_name OF STRUCTURE ls_data TO FIELD-SYMBOL(<lfs_data>).
          IF <lfs_data> IS ASSIGNED.
            ASSIGN COMPONENT ls->name OF STRUCTURE ls_header TO FIELD-SYMBOL(<lfs_data1>).
            IF <lfs_data1> IS ASSIGNED.
              <lfs_data1> = <lfs_data>.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDLOOP.

      CLEAR : lcl_pr_buffer=>mt_hdr_create.
      APPEND ls_header TO lcl_pr_buffer=>mt_hdr_create.

    ENDIF.

    READ ENTITIES OF zpr_i_header IN LOCAL MODE
                   ENTITY header
                     ALL FIELDS WITH CORRESPONDING #( entities )
                   RESULT DATA(headers).

    headers = VALUE #( FOR header IN headers
                     ( %tky   = header-%tky
                       %is_draft = header-%is_draft
                       %data = header-%data ) ).

  ENDMETHOD.

  METHOD earlynumbering_create.

    DATA : lv_wtkt_max         TYPE zpr_dt_wtktno,
           lv_wtkt_max1        TYPE zpr_dt_wtktno,
           lv_max              TYPE int2,
           lv_max_char         TYPE char1,
           lv_wtkt_frm         TYPE n LENGTH 10,
           lv_error_flag_btyp  TYPE c,
           lv_error_flag_plant TYPE c,
           lv_msg_num          TYPE syst-msgno,
           lv_msg_v1           TYPE syst-msgv1,
           lv_msg_v2           TYPE syst-msgv2.

    CLEAR : lv_wtkt_max.
    SELECT SINGLE FROM zpr_tb_wt_dr FIELDS MAX( wtktno ) INTO @lv_wtkt_max.
    IF sy-subrc EQ 0.
      lv_max = lv_wtkt_max+5(1).
      lv_max = lv_max + 1.
      lv_max_char = lv_max.
      CONCATENATE 'DRAFT' lv_max_char INTO lv_wtkt_max1.
      CONDENSE lv_wtkt_max1.
    ENDIF.

    TRY.
        CALL METHOD cl_numberrange_runtime=>number_get
          EXPORTING
            nr_range_nr = '01'
            object      = 'ZPR_WTK'
          IMPORTING
            number      = DATA(lv_number)
            returncode  = DATA(lv_rcode).
      CATCH cx_number_ranges.
        "handle exception
    ENDTRY.

    lv_wtkt_frm = lv_number.

    LOOP AT entities INTO DATA(entity).

      IF lv_error_flag_btyp EQ abap_true OR lv_error_flag_plant EQ abap_true.
        IF lv_error_flag_btyp EQ abap_true.
          lv_msg_num = '166'.
          APPEND VALUE #(
                %cid  = entity-%cid
                %key  = entity-%key
                %is_draft = entity-%is_draft
              ) TO failed-header.
          APPEND VALUE #(
                       werks = entity-werks
                       %msg = new_message(
                       id = 'ZPR_MESSAGES'
                       number = lv_msg_num
                       severity = if_abap_behv_message=>severity-error )
                       ) TO reported-header.
        ENDIF.
        IF lv_error_flag_plant EQ abap_true.
          lv_msg_num = '167'.
          APPEND VALUE #(
                %cid  = entity-%cid
                %key  = entity-%key
                %is_draft = entity-%is_draft
              ) TO failed-header.
          APPEND VALUE #(
                       werks = entity-werks
                       %msg = new_message(
                       id = 'ZPR_MESSAGES'
                       number = lv_msg_num
                       severity = if_abap_behv_message=>severity-error )
                       ) TO reported-header.
        ENDIF.
      ELSE.

        entity-werks =  entity-werks.
        IF entity-wtktno IS INITIAL.
          entity-wtktno =  lv_wtkt_frm.
        ENDIF.

        APPEND VALUE #( %cid  = entity-%cid
                        %key  = entity-%key
                        %is_draft = entity-%is_draft
                      ) TO mapped-header.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD update.

    DATA : ls_header_db      TYPE zpr_tb_wt_hd,
           ls_header_from_db TYPE zpr_tb_wt_hd,
           ls_struct         TYPE REF TO cl_abap_structdescr,
           lt_comp           TYPE cl_abap_structdescr=>component_table,
           lv_name           TYPE char30,
           lv_error_flag     TYPE char1,
           lv_msg_num        TYPE syst-msgno,
           lv_msg_v1         TYPE syst-msgv1,
           lv_msg_v2         TYPE syst-msgv2.

    READ TABLE entities INTO DATA(lt_header_update) INDEX 1.

    MOVE-CORRESPONDING lt_header_update TO ls_header_db.

    SELECT SINGLE * FROM zpr_tb_wt_hd WHERE wtktno = @ls_header_db-wtktno INTO @ls_header_from_db .

    IF ls_header_from_db-status = '80' OR ls_header_from_db-status = '90'.

      APPEND VALUE #( %key = lt_header_update-%key ) TO failed-header.
      APPEND VALUE #( wtktno = lt_header_update-wtktno
                      werks = lt_header_update-werks
                      %msg = new_message(
                      id = 'ZPR_MESSAGES'
                      number = '109'
                      severity = if_abap_behv_message=>severity-error )
                      ) TO reported-header.

    ELSE.
***moving fields with underscore
      ls_struct ?= cl_abap_typedescr=>describe_by_data( ls_header_db ).

      LOOP  AT ls_struct->components REFERENCE INTO DATA(ls).
        IF ls->name CS '_'.
          lv_name = ls->name.
          REPLACE ALL OCCURRENCES OF '_' IN lv_name WITH space.
          CONDENSE lv_name NO-GAPS.
          ASSIGN COMPONENT lv_name OF STRUCTURE lt_header_update TO FIELD-SYMBOL(<lfs_data>).
          IF <lfs_data> IS ASSIGNED.
            ASSIGN COMPONENT ls->name OF STRUCTURE ls_header_db TO FIELD-SYMBOL(<lfs_data1>).
            IF <lfs_data1> IS ASSIGNED.
              <lfs_data1> = <lfs_data>.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDLOOP.

* Check for Mandatory fields
      IF lt_header_update-lifnr IS NOT INITIAL.
*         lt_header_update-matdistance IS NOT INITIAL AND
*         lt_header_update-matweight IS NOT INITIAL AND
*         lt_header_update-distravelled IS NOT INITIAL.
      ELSE.
        lv_msg_num = '175'.
        APPEND VALUE #( %key = lt_header_update-%key ) TO failed-header.
        APPEND VALUE #( wtktno = lt_header_update-wtktno
                    werks = lt_header_update-werks
                    %msg = new_message(
                    id = 'ZPR_MESSAGES'
                    number = lv_msg_num
                    severity = if_abap_behv_message=>severity-error )
                    ) TO reported-header.
      ENDIF.

      SELECT * FROM zpr_i_supplier INTO TABLE @DATA(lt_supplier).

* Invalid Qualifier
      IF lt_header_update-qualifier IS NOT INITIAL.
        READ TABLE lt_supplier INTO DATA(ls_supplier) WITH KEY lifnr = lt_header_update-qualifier.
        IF sy-subrc NE 0.
          lv_error_flag = abap_true.
          lv_msg_num = '161'.
          APPEND VALUE #( %key = lt_header_update-%key ) TO failed-header.
          APPEND VALUE #( wtktno = lt_header_update-wtktno
                       werks = lt_header_update-werks
                       %msg = new_message(
                       id = 'ZPR_MESSAGES'
                       number = lv_msg_num
                       severity = if_abap_behv_message=>severity-error )
                       ) TO reported-header.
        ENDIF.
      ENDIF.
      CLEAR: ls_supplier.

* Invalid Hauler
      IF lt_header_update-hauler IS NOT INITIAL.
        READ TABLE lt_supplier INTO ls_supplier WITH KEY lifnr = lt_header_update-hauler.
        IF sy-subrc NE 0.
          lv_error_flag = abap_true.
          lv_msg_num = '162'.
          APPEND VALUE #( %key = lt_header_update-%key ) TO failed-header.
          APPEND VALUE #( wtktno = lt_header_update-wtktno
                       werks = lt_header_update-werks
                       %msg = new_message(
                       id = 'ZPR_MESSAGES'
                       number = lv_msg_num
                       severity = if_abap_behv_message=>severity-error )
                       ) TO reported-header.
        ENDIF.
      ENDIF.
      CLEAR: ls_supplier.

* Invalid Supplier
      IF lt_header_update-supplier IS NOT INITIAL.
        READ TABLE lt_supplier INTO ls_supplier WITH KEY lifnr = lt_header_update-supplier.
        IF sy-subrc NE 0.
          lv_error_flag = abap_true.
          lv_msg_num = '163'.
          APPEND VALUE #( %key = lt_header_update-%key ) TO failed-header.
          APPEND VALUE #( wtktno = lt_header_update-wtktno
                       werks = lt_header_update-werks
                       %msg = new_message(
                       id = 'ZPR_MESSAGES'
                       number = lv_msg_num
                       severity = if_abap_behv_message=>severity-error )
                       ) TO reported-header.
        ENDIF.
      ENDIF.
      CLEAR: ls_supplier.

* Check if Driver Performance value is valid
      IF lt_header_update-driverperf IS NOT INITIAL.
        SELECT SINGLE * FROM zpr_tb_drvrp WHERE driverperf = @lt_header_update-driverperf
          INTO @DATA(ls_drvrp).
        IF sy-subrc NE 0.
          lv_error_flag = abap_true.
          lv_msg_num = '164'.
          APPEND VALUE #( %key = lt_header_update-%key ) TO failed-header.
          APPEND VALUE #( wtktno = lt_header_update-wtktno
                      werks = lt_header_update-werks
                      %msg = new_message(
                      id = 'ZPR_MESSAGES'
                      number = lv_msg_num
                      severity = if_abap_behv_message=>severity-error )
                      ) TO reported-header.
        ENDIF.
      ENDIF.

* Check if Truck Condition value is valid
      IF lt_header_update-truckcond IS NOT INITIAL.
        SELECT SINGLE * FROM zpr_tb_trukc WHERE truckcond = @lt_header_update-truckcond
          INTO @DATA(ls_truckc).
        IF sy-subrc NE 0.
          lv_error_flag = abap_true.
          lv_msg_num = '165'.
          APPEND VALUE #( %key = lt_header_update-%key ) TO failed-header.
          APPEND VALUE #( wtktno = lt_header_update-wtktno
                      werks = lt_header_update-werks
                      %msg = new_message(
                      id = 'ZPR_MESSAGES'
                      number = lv_msg_num
                      severity = if_abap_behv_message=>severity-error )
                      ) TO reported-header.
        ENDIF.
      ENDIF.

      SELECT * FROM zpr_i_material INTO TABLE @DATA(lt_material).

* Validate Material Weight
      IF lt_header_update-matweight IS NOT INITIAL.

        READ TABLE lt_material INTO DATA(ls_material) WITH KEY material = lt_header_update-matweight.
        IF sy-subrc NE 0.
          lv_msg_num = '169'.
          lv_error_flag = abap_true.
          APPEND VALUE #( %key = lt_header_update-%key ) TO failed-header.
          APPEND VALUE #( wtktno = lt_header_update-wtktno
                      werks = lt_header_update-werks
                      %msg = new_message(
                      id = 'ZPR_MESSAGES'
                      number = lv_msg_num
                      severity = if_abap_behv_message=>severity-error )
                      ) TO reported-header.
        ENDIF.
      ENDIF.
      CLEAR: ls_material.

* Validate Material Distance
      IF lt_header_update-matdistance IS NOT INITIAL.
        CLEAR: ls_material.
        READ TABLE lt_material INTO ls_material WITH KEY material = lt_header_update-matdistance.
        IF sy-subrc NE 0.
          lv_msg_num = '170'.
          lv_error_flag = abap_true.
          APPEND VALUE #( %key = lt_header_update-%key ) TO failed-header.
          APPEND VALUE #( wtktno = lt_header_update-wtktno
                      werks = lt_header_update-werks
                      %msg = new_message(
                      id = 'ZPR_MESSAGES'
                      number = lv_msg_num
                      severity = if_abap_behv_message=>severity-error )
                      ) TO reported-header.
        ENDIF.
      ENDIF.

      IF lv_error_flag EQ abap_false.
        APPEND ls_header_db TO lcl_pr_buffer=>mt_hdr_update.
      ENDIF.

    ENDIF.

  ENDMETHOD.

  METHOD delete.

    CLEAR : lcl_pr_buffer=>gv_flag_wtkt_delete.
    LOOP AT keys INTO DATA(ls_keys).
      lcl_pr_buffer=>gv_wtkt_num_delete = ls_keys-wtktno.
    ENDLOOP.

    SELECT SINGLE  status
    FROM zpr_tb_wt_hd
     WHERE wtktno = @lcl_pr_buffer=>gv_wtkt_num_delete
     INTO @DATA(lv_status).
    IF lv_status EQ '10' OR lv_status EQ '20'.
**if weight ticket selected for deletion mark the flag for saver class
      CLEAR : lcl_pr_buffer=>gv_flag_wtkt_delete.
      IF lcl_pr_buffer=>gv_wtkt_num_delete IS NOT INITIAL.
        lcl_pr_buffer=>gv_flag_wtkt_delete = 'X'.
      ENDIF.
    ELSE.

      APPEND VALUE #( %key = ls_keys-%key ) TO failed-header.
      APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num_delete
                                            %msg = new_message(
                                              id = 'ZPR_MESSAGES'
                                            number = '029'
                                            v1 =   lcl_pr_buffer=>gv_wtkt_num_delete
                                            severity = if_abap_behv_message=>severity-error
                                                               )
                                          ) TO reported-header.


    ENDIF.

  ENDMETHOD.

  METHOD read.

    DATA : lv_wtkt_num_final TYPE zpr_dt_wtktno.

    LOOP AT keys INTO DATA(ls_keys).

      DATA(lv_wtkt_num_read) = ls_keys-wtktno.
      DATA(lv_werks) = ls_keys-werks.


      SELECT SINGLE * FROM zpr_tb_wt_hd    WHERE  wtktno = @lv_wtkt_num_read
                                           AND werks = @lv_werks INTO @DATA(ls_wtkt_read).


      INSERT VALUE #( wtktno = ls_wtkt_read-wtktno
                      werks = ls_wtkt_read-werks
                      movenum = ls_wtkt_read-movenum
                     driverperf = ls_wtkt_read-driverperf
                     truckcond = ls_wtkt_read-truckcond
                     lifnr = ls_wtkt_read-lifnr
                     qualifier = ls_wtkt_read-qualifier
                     hauler = ls_wtkt_read-hauler
                     supplier = ls_wtkt_read-supplier
                     driver = ls_wtkt_read-driver
                      ) INTO TABLE result.

    ENDLOOP.

  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rba_item.
  ENDMETHOD.

  METHOD cba_item.

    DATA : ls_item_temp  LIKE LINE OF lcl_pr_buffer=>mt_item_create,
           lv_prueflos   TYPE zpr_dt_qplos,
           lv_charg      TYPE charg_d,
           lv_item       TYPE zpr_dt_wtktitm,
           lt_item_count TYPE STANDARD TABLE OF zpr_tb_wt_it,
           ls_item_map   LIKE LINE OF mapped-item.
    CLEAR : lv_item.

    READ ENTITIES OF zpr_i_header IN LOCAL MODE
                                ENTITY header ALL FIELDS WITH CORRESPONDING #( entities_cba ) RESULT DATA(headers).

    READ TABLE headers INTO DATA(ls_headers) INDEX 1.

    LOOP AT entities_cba INTO DATA(ls_item).
      IF lcl_pr_buffer=>gv_wtkt_key IS NOT INITIAL.
        DATA(lv_max_wtkt) = lcl_pr_buffer=>gv_wtkt_key.
      ELSE.
        lv_max_wtkt = ls_item-wtktno.
      ENDIF.

      SORT ls_item-%target BY wtktno werks wtktitm.

      LOOP AT ls_item-%target INTO DATA(ls_item_target).
        MOVE-CORRESPONDING ls_item_target TO  ls_item_temp.
        lv_item = lv_item + 10.
        ls_item_temp-wtktno = lv_max_wtkt.
        ls_item_temp-wtktitm = ls_item_target-wtktitm.
        ls_item_temp-status = '10'.
        ls_item_temp-erdat = ls_item_target-erdat.
        ls_item_temp-ernam = ls_item_target-ernam.
        ls_item_temp-ereit = ls_item_target-ereit.
        ls_item_temp-aedat = ls_item_target-aedat.
        ls_item_temp-aenam = ls_item_target-aenam.
        ls_item_temp-aeeit = ls_item_target-aeeit.
        ls_item_temp-collection_point = ls_item_target-collection_point.
*        ls_item_temp-itm_field2 = ls_item_target-itmfield2.
        ls_item_temp-receipt_type = ls_item_target-receipttype.

        APPEND ls_item_temp TO lcl_pr_buffer=>mt_item_create.
        MOVE-CORRESPONDING ls_item_temp TO ls_item_map.
        APPEND ls_item_map TO mapped-item.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.

  METHOD earlynumbering_cba_item.

    DATA : lv_item TYPE zpr_dt_wtktitm.

    READ ENTITIES OF zpr_i_header
                        ENTITY header ALL FIELDS WITH CORRESPONDING #( entities ) RESULT DATA(headers).

    READ TABLE headers INTO DATA(ls_headers) INDEX 1.
    IF sy-subrc EQ 0.
    ENDIF.

    SELECT MAX( wtktitm  ) FROM zpr_tb_it_dr WHERE wtktno = @ls_headers-wtktno INTO @DATA(lv_max_item).
    IF sy-subrc EQ 0.
      lv_item = lv_max_item + 10.
    ELSE.
      lv_item = 10.
    ENDIF.

    LOOP AT entities INTO DATA(lt_entity).
      LOOP AT lt_entity-%target INTO DATA(ls_entity_item).
        ls_entity_item-wtktitm = lv_item.
        ls_entity_item-supplier = ls_headers-supplier.
        MODIFY lt_entity-%target FROM ls_entity_item.
        APPEND CORRESPONDING #( ls_entity_item ) TO mapped-item.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.

  METHOD copy.
  ENDMETHOD.

  METHOD haulerpo.

    TYPES: BEGIN OF ty_return,
             message TYPE string,
           END OF ty_return,

           tt_return         TYPE STANDARD TABLE OF ty_return WITH DEFAULT KEY,
           tt_po_deep_create TYPE STANDARD TABLE OF zpr_scm_cbp_po_v2=>tys_a_purchase_order_item_type WITH NON-UNIQUE DEFAULT KEY.
    TYPES:           BEGIN OF ty_po_deep_create.
                       INCLUDE TYPE zpr_scm_cbp_po_v2=>tys_a_purchase_order_type.
    TYPES:             to_purchase_order_item TYPE tt_po_deep_create,
                     END OF ty_po_deep_create.

    DATA: lo_http_client          TYPE REF TO if_web_http_client,
          lo_client_proxy         TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request              TYPE REF TO /iwbep/if_cp_request_create,
          lo_response             TYPE REF TO /iwbep/if_cp_response_create,
          lt_property             TYPE /iwbep/if_cp_runtime_types=>ty_t_property_path,
          lt_item_property        TYPE /iwbep/if_cp_runtime_types=>ty_t_property_path,
          lt_msg                  TYPE tt_return,
          lv_message              TYPE string,
          ls_po_business_data     TYPE zpr_scm_cbp_po_v2=>tys_a_purchase_order_type,
          ls_poitem_business_data TYPE tt_po_deep_create,
          ls_business_data        TYPE ty_po_deep_create,
          ls_deep_data            TYPE ty_po_deep_create,
          ls_po_item_data         TYPE zpr_scm_cbp_po_v2=>tys_a_purchase_order_item_type.

    CONSTANTS: lc_po_url   TYPE string VALUE 'https://my403232-api.s4hana.cloud.sap/sap/opu/odata/sap/API_PURCHASEORDER_PROCESS_SRV',
               lc_user     TYPE string VALUE 'DEMO_API_PC',
               lc_password TYPE string VALUE 'fSQ#xoXWmonAJJnqVaKoqzmRuxAh9ZfFktRbFSfL'.

    LOOP AT keys INTO DATA(ls_keys).
      lcl_pr_buffer=>gv_wtkt_num = ls_keys-wtktno.
    ENDLOOP.

**get header info
    SELECT SINGLE * FROM zpr_tb_wt_hd
                    WHERE wtktno = @lcl_pr_buffer=>gv_wtkt_num
                    INTO @DATA(ls_header).
    IF sy-subrc EQ 0.
* Check if fields required for Hauler PO are maintained
      IF ls_header-hauler IS NOT INITIAL AND ls_header-mat_distance IS NOT INITIAL AND
         ls_header-mat_weight IS NOT INITIAL AND ls_header-dis_travelled IS NOT INITIAL.
* Get company code
        SELECT SINGLE * FROM i_plant WHERE plant = @ls_header-werks
          INTO @DATA(ls_plant).
        IF sy-subrc EQ 0.
          SELECT SINGLE * FROM i_valuationarea WHERE valuationarea = @ls_plant-valuationarea
            INTO @DATA(ls_varea).
        ENDIF.

* Create Hauler PO
        TRY.


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

* Prepare business data
            ls_po_business_data = VALUE #(
                      purchase_order_type =  'NB'
                      company_code                = ls_varea-companycode
                      purchasing_organization     = '1710'
                      purchasing_group            = '001'
                      supplier                    = ls_header-hauler
                       ).

            ls_po_item_data-plant = ls_header-werks.
            ls_po_item_data-order_quantity = ls_header-trk_loadwg.
            ls_po_item_data-purchase_order_quantity_un = 'LB'.
            ls_po_item_data-material = ls_header-mat_weight.
            ls_po_item_data-account_assignment_categor = 'K'.
            APPEND ls_po_item_data TO ls_poitem_business_data.
            CLEAR: ls_po_item_data.

            ls_po_item_data-plant = ls_header-werks.
            ls_po_item_data-order_quantity = ls_header-dis_travelled.
            ls_po_item_data-purchase_order_quantity_un = ls_header-dis_travelled_uom.
            ls_po_item_data-material = ls_header-mat_distance.
            ls_po_item_data-account_assignment_categor = 'K'.
            APPEND ls_po_item_data TO ls_poitem_business_data.
            CLEAR: ls_po_item_data.

            MOVE-CORRESPONDING ls_po_business_data TO ls_deep_data.
            ls_deep_data-to_purchase_order_item = ls_poitem_business_data[].

            APPEND 'PURCHASE_ORDER_TYPE' TO  lt_property.
            APPEND 'COMPANY_CODE' TO lt_property.
            APPEND 'PURCHASING_ORGANIZATION' TO  lt_property.
            APPEND 'PURCHASING_GROUP' TO  lt_property.
            APPEND 'SUPPLIER' TO  lt_property.

            APPEND 'PLANT' TO  lt_item_property.
            APPEND 'ORDER_QUANTITY' TO  lt_item_property.
            APPEND 'PURCHASE_ORDER_QUANTITY_UN' TO lt_item_property.
            APPEND 'MATERIAL' TO  lt_item_property.
            APPEND 'ACCOUNT_ASSIGNMENT_CATEGOR' TO lt_item_property.

            lo_http_client->set_csrf_token( ).
            " Navigate to the resource and create a request for the create operation
            lo_request = lo_client_proxy->create_resource_for_entity_set( 'A_PURCHASE_ORDER' )->create_request_for_create( ).

            DATA(lo_data_description_node) = lo_request->create_data_descripton_node( ).
            lo_data_description_node->set_properties( lt_property  ).
            lo_data_description_node->add_child( 'TO_PURCHASE_ORDER_ITEM' )->set_properties( lt_item_property ).
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

            IF ls_business_data-purchase_order IS NOT INITIAL.

              UPDATE zpr_tb_wt_hd SET hauler_po = @ls_business_data-purchase_order,
                                      hauler_po_item = '00010',
                                      status = '20'
            WHERE wtktno =  @ls_header-wtktno.
              CONCATENATE 'Hauler PO ' ls_business_data-purchase_order ' has been created.' INTO lv_message.
              APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                         werks = ls_header-werks
                                       %msg = me->new_message_with_text(
                                        text = lv_message
                                        severity = if_abap_behv_message=>severity-success )
                                     ) TO reported-header.

            ENDIF.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            IF lx_remote->get_text( ) IS NOT INITIAL.
              lt_msg = VALUE #( ( message = lx_remote->get_text( ) ) ).
              IF lt_msg[] IS NOT INITIAL.
                lv_message = lt_msg[ 1 ]-message.
                APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                             werks = ls_header-werks
                                    %msg = me->new_message_with_text(
                                     text = lv_message
                                     severity = if_abap_behv_message=>severity-error )
                                  ) TO reported-header.
              ENDIF.
            ENDIF.

            IF lx_remote->s_odata_error-message IS NOT INITIAL.
              lt_msg = VALUE #( BASE lt_msg ( message = lx_remote->s_odata_error-message ) ).
              IF lt_msg[] IS NOT INITIAL.
                lv_message = lt_msg[ 2 ]-message.
                APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                            werks = ls_header-werks
                                   %msg = me->new_message_with_text(
                                    text = lv_message
                                    severity = if_abap_behv_message=>severity-error )
                                 ) TO reported-header.
              ENDIF.
            ENDIF.

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            lt_msg = VALUE #( ( message = lx_gateway->get_text( ) ) ).
            IF lt_msg[] IS NOT INITIAL.
              lv_message = lt_msg[ 1 ]-message.
              APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                            werks = ls_header-werks
                                   %msg = me->new_message_with_text(
                                    text = lv_message
                                    severity = if_abap_behv_message=>severity-error )
                                 ) TO reported-header.
            ENDIF.

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            lv_message =  lx_web_http_client_error->get_longtext(  ).
            APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                            werks = ls_header-werks
                                   %msg = me->new_message_with_text(
                                    text = lv_message
                                    severity = if_abap_behv_message=>severity-error )
                                 ) TO reported-header.

          CATCH cx_http_dest_provider_error INTO DATA(lx_web_http_dest_error).
            lv_message =  lx_web_http_dest_error->get_longtext(  ).
            APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                            werks = ls_header-werks
                                   %msg = me->new_message_with_text(
                                    text = lv_message
                                    severity = if_abap_behv_message=>severity-error )
                                 ) TO reported-header.
        ENDTRY.

      ELSE.
        lv_message = 'Please maintain Hauler, Material for Distance/Weight and Distance Travelled'.
        APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                           werks = ls_header-werks
                                  %msg = me->new_message_with_text(
                                   text = lv_message
                                   severity = if_abap_behv_message=>severity-error )
                                ) TO reported-header.
      ENDIF.
    ENDIF.

    READ ENTITIES OF zpr_i_header IN LOCAL MODE
                         ENTITY header
                           ALL FIELDS WITH CORRESPONDING #( keys )
                         RESULT DATA(headers).

    result = VALUE #( FOR header IN headers
                            ( %is_draft = header-%is_draft
                              %tky   = header-%tky
                              %param = header ) ).
  ENDMETHOD.

  METHOD defaultdata.

    DATA: lv_matweight TYPE matnr,
          lv_matdist   TYPE matnr,
          lv_uom       TYPE meins.

    SELECT * FROM zpr_dfmat INTO TABLE @DATA(lt_df_matnr).
    IF sy-subrc EQ 0.
      LOOP AT lt_df_matnr INTO DATA(ls_df_matnr).
        CASE ls_df_matnr-identifier.
          WHEN 'Weight'.
            lv_matweight = ls_df_matnr-def_matnr.
          WHEN 'Distance'.
            lv_matdist = ls_df_matnr-def_matnr.
        ENDCASE.
      ENDLOOP.
    ENDIF.

    SELECT SINGLE * FROM zpr_i_material WHERE material = @lv_matdist
       INTO @DATA(ls_material).
    IF sy-subrc EQ 0.
      lv_uom = ls_material-unit.
    ENDIF.

    MODIFY ENTITIES OF zpr_i_header IN LOCAL MODE
          ENTITY header
          UPDATE SET FIELDS
          WITH VALUE #( FOR key IN keys
                          ( %key = key-%key
                          %is_draft = key-%is_draft
                           matweight = lv_matweight
                           matdistance = lv_matdist
                           distravelleduom = lv_uom
                            ) )
         REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).

  ENDMETHOD.

  METHOD getuom.

    DATA: lv_meins      TYPE meins,
          lv_meins_dist TYPE meins.

    READ ENTITIES OF zpr_i_header IN LOCAL MODE
                          ENTITY header ALL FIELDS WITH CORRESPONDING #( keys ) RESULT DATA(headers).

    READ TABLE headers INTO DATA(ls_headers) INDEX 1.

    SELECT SINGLE * FROM zpr_i_material WHERE material = @ls_headers-matdistance
      INTO @DATA(ls_material).
    IF sy-subrc EQ 0.
      lv_meins_dist = ls_material-unit.
    ENDIF.

    MODIFY ENTITIES OF zpr_i_header IN LOCAL MODE
          ENTITY header
          UPDATE SET FIELDS
          WITH VALUE #( FOR header IN headers
                          ( %key = header-%key
                           %is_draft = header-%is_draft
                            distravelleduom = lv_meins_dist
                            ) )
         REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).

  ENDMETHOD.

  METHOD calcnetweight.

    DATA: lv_net_weight TYPE zpr_dt_live_wg.

    READ ENTITIES OF zpr_i_header IN LOCAL MODE
          ENTITY header ALL FIELDS WITH CORRESPONDING #( keys ) RESULT DATA(headers).

    READ TABLE headers INTO DATA(ls_headers) INDEX 1.

    IF ls_headers-trkloadwg IS NOT INITIAL AND ls_headers-trkunloadwg IS NOT INITIAL.
      lv_net_weight =  ls_headers-trkloadwg - ls_headers-trkunloadwg.
    ENDIF.

    MODIFY ENTITIES OF zpr_i_header IN LOCAL MODE
                   ENTITY header
                   UPDATE SET FIELDS
                   WITH VALUE #( FOR header IN headers
                                   ( %key = header-%key
                                    %is_draft = header-%is_draft
                                     livewg = lv_net_weight
                                     ) )
                  REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).

  ENDMETHOD.

ENDCLASS.

CLASS lhc_item DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR item RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR item RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE item.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE item.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE item.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE item.

    METHODS read FOR READ
      IMPORTING keys FOR READ item RESULT result.

    METHODS rba_header FOR READ
      IMPORTING keys_rba FOR READ item\_header FULL result_requested RESULT result LINK association_links.

    METHODS processidata FOR MODIFY
      IMPORTING keys FOR ACTION item~processidata RESULT result.

    METHODS processiteminv FOR MODIFY
      IMPORTING keys FOR ACTION item~processiteminv RESULT result.

    METHODS getuom FOR DETERMINE ON MODIFY
      IMPORTING keys FOR item~getuom.

*    METHODS poupdate FOR MODIFY
*      IMPORTING keys FOR ACTION item~poupdate RESULT result.

    METHODS stock FOR MODIFY
      IMPORTING keys FOR ACTION item~stock RESULT result.

    METHODS defaultitemdata FOR DETERMINE ON MODIFY
      IMPORTING keys FOR item~defaultitemdata.

    METHODS getdefaultsforstock FOR READ
      IMPORTING keys FOR FUNCTION item~getdefaultsforstock RESULT result.

ENDCLASS.

CLASS lhc_item IMPLEMENTATION.

  METHOD get_instance_features.

    LOOP AT keys INTO DATA(ls_keys).
      DATA(lv_wtktno) = ls_keys-wtktno.
      DATA(lv_werks) = ls_keys-werks.
      DATA(lv_item) = ls_keys-wtktitm.
      IF ls_keys-%is_draft EQ '01'.
        DATA(lv_draft)  = abap_true.
      ELSE.
        lv_draft = abap_false.
      ENDIF.
    ENDLOOP.

    SELECT * FROM zpr_tb_wt_hd WHERE wtktno = @lv_wtktno
                                   AND werks = @lv_werks
                                   INTO TABLE @DATA(lt_header).
    IF sy-subrc EQ 0.

      SELECT SINGLE * FROM zpr_tb_wt_it WHERE  wtktno = @lv_wtktno
                                     AND werks = @lv_werks
                                     AND wtktitm = @lv_item
                                     INTO  @DATA(ls_item).
      IF sy-subrc NE 0.
        DATA(lv_new) = abap_true.
      ENDIF.
    ELSE.
      lv_new = abap_true.
    ENDIF.

    READ ENTITIES OF zpr_i_header IN LOCAL MODE ENTITY item
    ALL FIELDS WITH CORRESPONDING #( keys ) RESULT DATA(headers).

    READ TABLE headers INTO DATA(ls_data) INDEX 1.

    LOOP AT keys INTO DATA(ls_keys_item).
    ENDLOOP.

    result = VALUE #( FOR ls_header_status IN headers
                          %tky = ls_keys-%tky
                           ( %action-processidata = COND #( WHEN lv_new EQ abap_false AND lv_draft EQ abap_false AND ( ls_item-ebeln IS INITIAL OR ls_item-mblnr IS INITIAL )
*                           WHEN ls_item-status = '40' AND lv_new EQ abap_false
                                                   THEN if_abap_behv=>fc-o-enabled
                                                   ELSE if_abap_behv=>fc-o-disabled )

                            %action-processiteminv =
                                                   COND #( WHEN lv_new EQ abap_false AND ls_item-invoice IS INITIAL AND lv_draft EQ abap_false
                                                           AND ls_item-po_price IS NOT INITIAL
*                              WHEN ls_item-status = '50' AND lv_new EQ abap_false
                                                   THEN if_abap_behv=>fc-o-enabled
                                                   ELSE if_abap_behv=>fc-o-disabled )

                            %action-stock =
                                                   COND #( WHEN lv_new EQ abap_false AND lv_draft EQ abap_false AND ls_item-status GE '20'
*                              WHEN ls_item-status = '50' AND lv_new EQ abap_false
                                                   THEN if_abap_behv=>fc-o-enabled
                                                   ELSE if_abap_behv=>fc-o-disabled )

*                            %action-poupdate = if_abap_behv=>fc-o-
*                                                   COND #( WHEN lv_new EQ abap_false AND lv_draft EQ abap_false AND ls_item-po_price IS INITIAL AND ls_item-ebeln IS NOT INITIAL
**                              WHEN ls_item-status = '50' AND lv_new EQ abap_false*
*                                                   THEN if_abap_behv=>fc-o-enabled
*                                                   ELSE if_abap_behv=>fc-o-disabled )
                                                   ) ).

  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create.

    DATA : ls_item_temp  LIKE LINE OF lcl_pr_buffer=>mt_item_create,
           lv_prueflos   TYPE zpr_dt_qplos,
           lv_charg      TYPE charg_d,
           ls_item_map   LIKE LINE OF mapped-item,
           lv_item       TYPE zpr_dt_wtktitm,
           lt_item_count TYPE STANDARD TABLE OF zpr_tb_wt_it.

    CLEAR : lv_item.

    READ ENTITIES OF zpr_i_header IN LOCAL MODE
                                ENTITY item ALL FIELDS WITH CORRESPONDING #( entities ) RESULT DATA(headers).

    LOOP AT entities INTO DATA(ls_item).
      IF lcl_pr_buffer=>gv_wtkt_key IS NOT INITIAL.
        DATA(lv_max_wtkt) = lcl_pr_buffer=>gv_wtkt_key.
      ELSE.
        lv_max_wtkt = ls_item-wtktno.
      ENDIF.

      MOVE-CORRESPONDING ls_item TO  ls_item_temp.
      MOVE-CORRESPONDING ls_item TO ls_item_map.
      lv_item = lv_item + 10.
      ls_item_temp-wtktno = lv_max_wtkt.
      ls_item_temp-wtktitm = lv_item .
      ls_item_temp-status = '10'.
      ls_item_temp-erdat = ls_item-erdat.
      ls_item_temp-ernam = ls_item-ereit.
      ls_item_temp-ereit = ls_item-ereit.
      ls_item_temp-aedat = ls_item-aedat.
      ls_item_temp-aenam = ls_item-aenam.
      ls_item_temp-aeeit = ls_item-aeeit.
      ls_item_temp-collection_point = ls_item-collection_point.

      APPEND ls_item_temp TO lcl_pr_buffer=>mt_item_create.
      APPEND ls_item_map TO mapped-item.

    ENDLOOP.

  ENDMETHOD.

  METHOD earlynumbering_create.
  ENDMETHOD.

  METHOD update.

    DATA : ls_item_db TYPE zpr_tb_wt_it,
           ls_struct  TYPE REF TO cl_abap_structdescr,
           lt_comp    TYPE cl_abap_structdescr=>component_table,
           lv_name    TYPE char30.

    LOOP AT entities INTO DATA(ls_item).
      CLEAR : ls_item_db.
      MOVE-CORRESPONDING ls_item TO ls_item_db.
      ls_struct ?= cl_abap_typedescr=>describe_by_data( ls_item_db ).
      LOOP  AT ls_struct->components REFERENCE INTO DATA(ls).
        IF ls->name CS '_'.
          lv_name = ls->name.
          REPLACE ALL OCCURRENCES OF '_' IN lv_name WITH space.
          CONDENSE lv_name NO-GAPS.
          ASSIGN COMPONENT lv_name OF STRUCTURE ls_item  TO FIELD-SYMBOL(<lfs_data>).
          IF <lfs_data> IS ASSIGNED.
            ASSIGN COMPONENT ls->name OF STRUCTURE ls_item_db TO FIELD-SYMBOL(<lfs_data1>).
            IF <lfs_data1> IS ASSIGNED.
              <lfs_data1> = <lfs_data>.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDLOOP.
      ls_item_db-aenam = sy-uname.
      ls_item_db-aedat = sy-datum.
      ls_item_db-aeeit = sy-uzeit.
      APPEND ls_item_db TO lcl_pr_buffer=>mt_item_update.
    ENDLOOP.

  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.

    DATA : lv_wtkt_num_final TYPE zpr_dt_wtktno.

    LOOP AT keys INTO DATA(ls_keys).

      DATA(lv_wtkt_num_read) = ls_keys-wtktno.
      DATA(lv_werks) = ls_keys-werks.

      SELECT * FROM zpr_tb_wt_it    WHERE  wtktno = @lv_wtkt_num_read
                                                  AND werks = @lv_werks
                                                  INTO TABLE @DATA(lt_wtkt_item_read).

      LOOP AT lt_wtkt_item_read INTO DATA(ls_wtkt_item_read).
        INSERT VALUE #( wtktno = ls_wtkt_item_read-wtktno
                        wtktitm = ls_wtkt_item_read-wtktitm
                        werks = ls_wtkt_item_read-werks
                        prueflos = ls_wtkt_item_read-prueflos
                        charg = ls_wtkt_item_read-charg
                        ebeln = ls_wtkt_item_read-ebeln
                        ebelp = ls_wtkt_item_read-ebelp
                        mblnr = ls_wtkt_item_read-mblnr
                        mjahr = ls_wtkt_item_read-mjahr
                        invoice = ls_wtkt_item_read-invoice
                        splitinvoice1 = ls_wtkt_item_read-invoice_split1
                        splitinvoice2 = ls_wtkt_item_read-invoice_split2
                        splitinvoice3 = ls_wtkt_item_read-invoice_split3
                        weight = ls_wtkt_item_read-weight
                        unit = ls_wtkt_item_read-unit
                        ernam = ls_wtkt_item_read-ernam
                        erdat = ls_wtkt_item_read-erdat
                        ereit = ls_wtkt_item_read-ereit
                        aenam = ls_wtkt_item_read-aenam
                        aedat = ls_wtkt_item_read-aedat
                        aeeit = ls_wtkt_item_read-aeeit
                        supplier = ls_wtkt_item_read-supplier
                        agreement = ls_wtkt_item_read-agreement
                        matnr = ls_wtkt_item_read-matnr
                        collection_point = ls_wtkt_item_read-collection_point
                        lgort = ls_wtkt_item_read-lgort
                        poprice = ls_wtkt_item_read-po_price
                        status = ls_wtkt_item_read-status
                        comments = ls_wtkt_item_read-comments
                        rocancel = ls_wtkt_item_read-rocancel
                        ) INTO TABLE result.

      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.

  METHOD rba_header.
  ENDMETHOD.

  METHOD processidata.

    TYPES: BEGIN OF ty_return,
             message TYPE string,
           END OF ty_return,

           tt_return         TYPE STANDARD TABLE OF ty_return WITH DEFAULT KEY,
           tt_po_deep_create TYPE STANDARD TABLE OF zpr_scm_cbp_po_v2=>tys_a_purchase_order_item_type WITH NON-UNIQUE DEFAULT KEY,
           tt_gr_deep_create TYPE STANDARD TABLE OF zpr_scm_cbp_gr=>tys_a_material_document_item_t WITH NON-UNIQUE DEFAULT KEY.
    TYPES:           BEGIN OF ty_po_deep_create.
                       INCLUDE TYPE zpr_scm_cbp_po_v2=>tys_a_purchase_order_type.
    TYPES:             to_purchase_order_item TYPE tt_po_deep_create,
                     END OF ty_po_deep_create.

    TYPES:           BEGIN OF ty_gr_deep_create.
                       INCLUDE TYPE zpr_scm_cbp_gr=>tys_a_material_document_head_2.
    TYPES:             to_material_document_item TYPE tt_gr_deep_create,
                     END OF ty_gr_deep_create.

    DATA: lv_intref               TYPE string,
          lo_http_client          TYPE REF TO if_web_http_client,
          lo_client_proxy         TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request              TYPE REF TO /iwbep/if_cp_request_create,
          lo_response             TYPE REF TO /iwbep/if_cp_response_create,
          lt_property             TYPE /iwbep/if_cp_runtime_types=>ty_t_property_path,
          lt_item_property        TYPE /iwbep/if_cp_runtime_types=>ty_t_property_path,
          lt_msg                  TYPE tt_return,
          lv_message              TYPE string,
          ls_po_business_data     TYPE zpr_scm_cbp_po_v2=>tys_a_purchase_order_type,
          ls_poitem_business_data TYPE tt_po_deep_create,
          ls_business_data        TYPE ty_po_deep_create,
          ls_deep_data            TYPE ty_po_deep_create,
          ls_gr_business_data     TYPE zpr_scm_cbp_gr=>tys_a_material_document_head_2,
          ls_gritem_business_data TYPE tt_gr_deep_create,
          ls_business_data_gr     TYPE ty_gr_deep_create,
          ls_deep_data_gr         TYPE ty_gr_deep_create,
          lv_item_cat             TYPE c LENGTH 1.

    CONSTANTS: lc_po_url   TYPE string VALUE 'https://my403232-api.s4hana.cloud.sap/sap/opu/odata/sap/API_PURCHASEORDER_PROCESS_SRV',
               lc_gr_url   TYPE string VALUE 'https://my403232-api.s4hana.cloud.sap/sap/opu/odata/sap/API_MATERIAL_DOCUMENT_SRV',
               lc_user     TYPE string VALUE 'DEMO_API_PC',
               lc_password TYPE string VALUE 'fSQ#xoXWmonAJJnqVaKoqzmRuxAh9ZfFktRbFSfL'.

    CLEAR : lcl_pr_buffer=>gv_flag_process_data,
            lcl_pr_buffer=>gv_wtkt_num,
            lcl_pr_buffer=>gv_wtkt_item,
            lcl_pr_buffer=>gv_po,
            lcl_pr_buffer=>gv_mblnr.

    IF lcl_pr_buffer=>gv_flag_process_data IS INITIAL.
      lcl_pr_buffer=>gv_flag_process_data = 'X'.

      LOOP AT keys INTO DATA(ls_keys).
        lcl_pr_buffer=>gv_wtkt_num = ls_keys-wtktno.
        lcl_pr_buffer=>gv_wtkt_item = ls_keys-wtktitm.
      ENDLOOP.

    ENDIF.

    CONCATENATE ls_keys-wtktno ls_keys-wtktitm+4(2) INTO lv_intref.

**get header info
    SELECT SINGLE * FROM zpr_tb_wt_hd
                    WHERE wtktno = @lcl_pr_buffer=>gv_wtkt_num
                    INTO @DATA(ls_header).
    IF sy-subrc EQ 0.
* Get company code
      SELECT SINGLE * FROM i_plant WHERE plant = @ls_header-werks
        INTO @DATA(ls_plant).
      IF sy-subrc EQ 0.
        SELECT SINGLE * FROM i_valuationarea WHERE valuationarea = @ls_plant-valuationarea
          INTO @DATA(ls_varea).
      ENDIF.

      SELECT SINGLE * FROM zpr_tb_wt_it WHERE wtktno = @lcl_pr_buffer=>gv_wtkt_num
                                 AND wtktitm = @lcl_pr_buffer=>gv_wtkt_item
                   INTO @DATA(ls_items).

      IF ls_items-ebeln IS INITIAL.
* Create PO
        TRY.

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

* Prepare business data
            ls_po_business_data = VALUE #(
                      purchase_order_type =  'NB'
                      company_code                = ls_varea-companycode
                      purchasing_organization     = '1710'
                      purchasing_group            = '001'
                      supplier                    = ls_items-supplier
                      correspnc_internal_referen  = lv_intref
                       ).

            IF ls_items-itm_field2 = 'Vendor'.
              lv_item_cat = '2'.
            ENDIF.

            ls_poitem_business_data = VALUE tt_po_deep_create( (
                       plant = ls_header-werks
                       storage_location = ls_items-lgort
                       order_quantity = ls_items-weight
                       purchase_order_quantity_un = ls_items-unit
                       material = ls_items-matnr
                       purchase_order_item_catego = lv_item_cat
               ) ).
            MOVE-CORRESPONDING ls_po_business_data TO ls_deep_data.
            ls_deep_data-to_purchase_order_item = ls_poitem_business_data[].

            APPEND 'PURCHASE_ORDER_TYPE' TO  lt_property.
            APPEND 'COMPANY_CODE' TO  lt_property.
            APPEND 'PURCHASING_ORGANIZATION' TO  lt_property.
            APPEND 'PURCHASING_GROUP' TO  lt_property.
            APPEND 'SUPPLIER' TO  lt_property.
            APPEND 'CORRESPNC_INTERNAL_REFEREN' TO  lt_property.

            APPEND 'PLANT' TO  lt_item_property.
            APPEND 'STORAGE_LOCATION' TO  lt_item_property.
            APPEND 'ORDER_QUANTITY' TO  lt_item_property.
            APPEND 'PURCHASE_ORDER_QUANTITY_UN' TO lt_item_property.
            APPEND 'MATERIAL' TO  lt_item_property.
            APPEND 'PURCHASE_ORDER_ITEM_CATEGO' TO lt_item_property.

            lo_http_client->set_csrf_token( ).
            " Navigate to the resource and create a request for the create operation
            lo_request = lo_client_proxy->create_resource_for_entity_set( 'A_PURCHASE_ORDER' )->create_request_for_create( ).

            DATA(lo_data_description_node) = lo_request->create_data_descripton_node( ).
            lo_data_description_node->set_properties( lt_property  ).
            lo_data_description_node->add_child( 'TO_PURCHASE_ORDER_ITEM' )->set_properties( lt_item_property ).
            " Set the business data for the created entity
            lo_request->set_deep_business_data(
            is_business_data =  ls_deep_data
            io_data_description = lo_data_description_node
            ).

            " Execute the request
            lo_response = lo_request->execute( ).
            WAIT UP TO 3 SECONDS.

            CLEAR: ls_business_data.
            " Get the after image
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

            IF ls_business_data-purchase_order IS NOT INITIAL.

              lcl_pr_buffer=>gv_po = ls_business_data-purchase_order.
              lcl_pr_buffer=>gv_po_item = lcl_pr_buffer=>gv_wtkt_item+1(5).
              UPDATE zpr_tb_wt_it SET ebeln = @ls_business_data-purchase_order,
                                      ebelp = @lcl_pr_buffer=>gv_wtkt_item+1(5)
            WHERE wtktno =  @lcl_pr_buffer=>gv_wtkt_num
            AND   wtktitm = @lcl_pr_buffer=>gv_wtkt_item.

            ENDIF.

          CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
            IF lx_remote->get_text( ) IS NOT INITIAL.
              lt_msg = VALUE #( ( message = lx_remote->get_text( ) ) ).
              IF lt_msg[] IS NOT INITIAL.
                lv_message = lt_msg[ 1 ]-message.
                APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                           werks = ls_header-werks
                           wtktitm = lcl_pr_buffer=>gv_wtkt_item
                                  %msg = me->new_message_with_text(
                                   text = lv_message
                                   severity = if_abap_behv_message=>severity-error )
                                ) TO reported-item.
              ENDIF.
            ENDIF.

            IF lx_remote->s_odata_error-message IS NOT INITIAL.
              lt_msg = VALUE #( BASE lt_msg ( message = lx_remote->s_odata_error-message ) ).
              IF lt_msg[] IS NOT INITIAL.
                lv_message = lt_msg[ 2 ]-message.
                APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                          werks = ls_header-werks
                          wtktitm = lcl_pr_buffer=>gv_wtkt_item
                                 %msg = me->new_message_with_text(
                                  text = lv_message
                                  severity = if_abap_behv_message=>severity-error )
                               ) TO reported-item.
              ENDIF.
            ENDIF.

          CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
            lt_msg = VALUE #( ( message = lx_gateway->get_text( ) ) ).
            IF lt_msg[] IS NOT INITIAL.
              lv_message = lt_msg[ 1 ]-message.
              APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                          werks = ls_header-werks
                          wtktitm = lcl_pr_buffer=>gv_wtkt_item
                                 %msg = me->new_message_with_text(
                                  text = lv_message
                                  severity = if_abap_behv_message=>severity-error )
                               ) TO reported-item.
            ENDIF.

          CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
            lv_message =  lx_web_http_client_error->get_longtext(  ).
            APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                          werks = ls_header-werks
                          wtktitm = lcl_pr_buffer=>gv_wtkt_item
                                 %msg = me->new_message_with_text(
                                  text = lv_message
                                  severity = if_abap_behv_message=>severity-error )
                               ) TO reported-item.

          CATCH cx_http_dest_provider_error INTO DATA(lx_web_http_dest_error).
            lv_message =  lx_web_http_dest_error->get_longtext(  ).
            APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                          werks = ls_header-werks
                          wtktitm = lcl_pr_buffer=>gv_wtkt_item
                                 %msg = me->new_message_with_text(
                                  text = lv_message
                                  severity = if_abap_behv_message=>severity-error )
                               ) TO reported-item.
        ENDTRY.
      ELSE.
        lcl_pr_buffer=>gv_po = ls_items-ebeln.
        lcl_pr_buffer=>gv_po_item = ls_items-ebelp.
* PO created already, proceed with GR creation
      ENDIF.

      IF lcl_pr_buffer=>gv_po IS NOT INITIAL AND ls_items-mblnr IS INITIAL.

* Create GR
        TRY.

            lo_http_client = cl_web_http_client_manager=>create_by_http_destination(
                      i_destination = cl_http_destination_provider=>create_by_url( lc_gr_url ) ).
            lo_http_req = lo_http_client->get_http_request( ).
            lo_http_req->set_authorization_basic(
                                                   i_username = lc_user
                                                   i_password = lc_password
                                                 ).

            lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
            EXPORTING
               is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                   proxy_model_id      = 'ZPR_SCM_CBP_GR'
                                                   proxy_model_version = '0001' )
              io_http_client             = lo_http_client
              iv_relative_service_root   = ''  ).

            ASSERT lo_http_client IS BOUND.

* Prepare business data
            ls_gr_business_data = VALUE #(
                 goods_movement_code = '01'
                 version_for_printing_slip = '1'
                 material_document_header_t = ls_header-wtktno
                       ).

            ls_gritem_business_data = VALUE tt_gr_deep_create( (
                    material = ls_items-matnr
                    plant = ls_header-werks
                    storage_location = ls_items-lgort
                    goods_movement_type = '101'
                    supplier = ls_items-supplier
                    purchase_order = lcl_pr_buffer=>gv_po
                    purchase_order_item = lcl_pr_buffer=>gv_po_item
                    goods_movement_ref_doc_typ = 'B'
                    entry_unit = ls_items-unit
                    quantity_in_entry_unit = ls_items-weight
               ) ).
            MOVE-CORRESPONDING ls_gr_business_data TO ls_deep_data_gr.
            ls_deep_data_gr-to_material_document_item = ls_gritem_business_data[].

            CLEAR: lt_property[], lt_item_property[].

            APPEND 'GOODS_MOVEMENT_CODE' TO  lt_property.
            APPEND 'VERSION_FOR_PRINTING_SLIP' TO  lt_property.
            APPEND 'MATERIAL_DOCUMENT_HEADER_T' TO  lt_property.

            APPEND 'PLANT' TO  lt_item_property.
            APPEND 'MATERIAL' TO  lt_item_property.
            APPEND 'STORAGE_LOCATION' TO lt_item_property.
            APPEND 'GOODS_MOVEMENT_TYPE' TO lt_item_property.
            APPEND 'SUPPLIER' TO lt_item_property.
            APPEND 'PURCHASE_ORDER' TO lt_item_property.
            APPEND 'PURCHASE_ORDER_ITEM' TO lt_item_property.
            APPEND 'GOODS_MOVEMENT_REF_DOC_TYP' TO lt_item_property.
            APPEND 'ENTRY_UNIT' TO lt_item_property.
            APPEND 'QUANTITY_IN_ENTRY_UNIT' TO lt_item_property.

            lo_http_client->set_csrf_token( ).
            " Navigate to the resource and create a request for the create operation
            lo_request = lo_client_proxy->create_resource_for_entity_set( 'A_MATERIAL_DOCUMENT_HEADER' )->create_request_for_create( ).

            lo_data_description_node = lo_request->create_data_descripton_node( ).
            lo_data_description_node->set_properties( lt_property  ).
            lo_data_description_node->add_child( 'TO_MATERIAL_DOCUMENT_ITEM' )->set_properties( lt_item_property ).
            " Set the business data for the created entity
            lo_request->set_deep_business_data(
            is_business_data =  ls_deep_data_gr
            io_data_description = lo_data_description_node
            ).

            " Execute the request
            lo_response = lo_request->execute( ).

            CLEAR: ls_business_data_gr.
            " Get the after image
            lo_response->get_business_data( IMPORTING es_business_data = ls_business_data_gr ).

            IF ls_business_data_gr-material_document IS NOT INITIAL.

* Get Inspection Lot
              SELECT SINGLE * FROM i_insplotmatldocitem WHERE materialdocument = @ls_business_data_gr-material_document
                                                        AND materialdocumentyear = @ls_business_data_gr-material_document_year
                INTO @DATA(ls_insplot).

* Get Batch
              SELECT SINGLE * FROM i_materialdocumentitem_2 WHERE  materialdocument = @ls_business_data_gr-material_document
                                                         AND materialdocumentyear = @ls_business_data_gr-material_document_year
*                                                         AND MaterialDocumentItem = @lcl_pr_buffer=>gv_po_item
                 INTO @DATA(ls_matdocitem).

              lcl_pr_buffer=>gv_mblnr = ls_business_data_gr-material_document.
              UPDATE zpr_tb_wt_it SET mblnr = @ls_business_data_gr-material_document,
                                      mjahr = @ls_business_data_gr-material_document_year,
                                      prueflos = @ls_insplot-inspectionlot,
                                      charg = @ls_matdocitem-batch,
                                      status = '20'
            WHERE wtktno =  @lcl_pr_buffer=>gv_wtkt_num
            AND   wtktitm = @lcl_pr_buffer=>gv_wtkt_item.

            ENDIF.

          CATCH /iwbep/cx_cp_remote INTO lx_remote.
            IF lx_remote->get_text( ) IS NOT INITIAL.
              lt_msg = VALUE #( ( message = lx_remote->get_text( ) ) ).
              IF lt_msg[] IS NOT INITIAL.
                lv_message = lt_msg[ 1 ]-message.
                APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                          werks = ls_header-werks
                          wtktitm = lcl_pr_buffer=>gv_wtkt_item
                                 %msg = me->new_message_with_text(
                                  text = lv_message
                                  severity = if_abap_behv_message=>severity-error )
                               ) TO reported-item.
              ENDIF.
            ENDIF.

            IF lx_remote->s_odata_error-message IS NOT INITIAL.
              lt_msg = VALUE #( BASE lt_msg ( message = lx_remote->s_odata_error-message ) ).
              IF lt_msg[] IS NOT INITIAL.
                lv_message = lt_msg[ 2 ]-message.
                APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                           werks = ls_header-werks
                           wtktitm = lcl_pr_buffer=>gv_wtkt_item
                                  %msg = me->new_message_with_text(
                                   text = lv_message
                                   severity = if_abap_behv_message=>severity-error )
                                ) TO reported-item.
              ENDIF.
            ENDIF.

          CATCH /iwbep/cx_gateway INTO lx_gateway.
            lt_msg = VALUE #( ( message = lx_gateway->get_text( ) ) ).
            IF lt_msg[] IS NOT INITIAL.
              lv_message = lt_msg[ 1 ]-message.
              APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                           werks = ls_header-werks
                           wtktitm = lcl_pr_buffer=>gv_wtkt_item
                                  %msg = me->new_message_with_text(
                                   text = lv_message
                                   severity = if_abap_behv_message=>severity-error )
                                ) TO reported-item.
            ENDIF.

          CATCH cx_web_http_client_error INTO lx_web_http_client_error.
            lv_message =  lx_web_http_client_error->get_longtext(  ).
            APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                           werks = ls_header-werks
                           wtktitm = lcl_pr_buffer=>gv_wtkt_item
                                  %msg = me->new_message_with_text(
                                   text = lv_message
                                   severity = if_abap_behv_message=>severity-error )
                                ) TO reported-item.

          CATCH cx_http_dest_provider_error INTO lx_web_http_dest_error.
            lv_message =  lx_web_http_dest_error->get_longtext(  ).
            APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                          werks = ls_header-werks
                          wtktitm = lcl_pr_buffer=>gv_wtkt_item
                                 %msg = me->new_message_with_text(
                                  text = lv_message
                                  severity = if_abap_behv_message=>severity-error )
                               ) TO reported-item.
        ENDTRY.

      ENDIF.

    ENDIF.

    IF lcl_pr_buffer=>gv_po IS NOT INITIAL AND lcl_pr_buffer=>gv_mblnr IS NOT INITIAL.

      CONCATENATE 'Purchase Order ' lcl_pr_buffer=>gv_po ' and Goods Receipt ' lcl_pr_buffer=>gv_mblnr ' are created.'
        INTO lv_message.
      APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                      werks = ls_header-werks
                      wtktitm = lcl_pr_buffer=>gv_wtkt_item
                                    %msg = me->new_message_with_text(
                                     text = lv_message
                                     severity = if_abap_behv_message=>severity-success )
                                  ) TO reported-item.

    ENDIF.

    READ ENTITIES OF zpr_i_header IN LOCAL MODE
                        ENTITY item
                          ALL FIELDS WITH CORRESPONDING #( keys )
                        RESULT DATA(items).

    result = VALUE #( FOR item IN items
                            ( %is_draft = item-%is_draft
                              %tky   = item-%tky
                              %param = item ) ).

  ENDMETHOD.

  METHOD processiteminv.

* Create Supplier Invoice for the PO
    TYPES: BEGIN OF ty_split,
             supplier TYPE lifnr,
             amount   TYPE zpr_dt_poprice,
           END OF ty_split,

           BEGIN OF ty_return,
             message TYPE string,
           END OF ty_return,

           tt_return          TYPE STANDARD TABLE OF ty_return WITH DEFAULT KEY,
           tt_inv_deep_create TYPE STANDARD TABLE OF zpr_scm_cbp_inv=>tys_a_suplr_invc_item_pur_or_2 WITH NON-UNIQUE DEFAULT KEY.

    TYPES:           BEGIN OF ty_inv_deep_create.
                       INCLUDE TYPE zpr_scm_cbp_inv=>tys_a_supplier_invoice_type.
    TYPES:             to_suplr_invc_item_pur_ord TYPE tt_inv_deep_create,
                     END OF ty_inv_deep_create.

    DATA: lv_intref                TYPE string,
          lo_http_client           TYPE REF TO if_web_http_client,
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
          lt_split                 TYPE STANDARD TABLE OF ty_split,
          ls_split                 TYPE ty_split.

    CONSTANTS: lc_inv_url  TYPE string VALUE 'https://my403232-api.s4hana.cloud.sap/sap/opu/odata/sap/API_SUPPLIERINVOICE_PROCESS_SRV',
               lc_user     TYPE string VALUE 'DEMO_API_PC',
               lc_password TYPE string VALUE 'fSQ#xoXWmonAJJnqVaKoqzmRuxAh9ZfFktRbFSfL'.

    LOOP AT keys INTO DATA(ls_keys).
      lcl_pr_buffer=>gv_wtkt_num = ls_keys-wtktno.
      lcl_pr_buffer=>gv_wtkt_item = ls_keys-wtktitm.
    ENDLOOP.

*Get header info
    SELECT SINGLE * FROM zpr_tb_wt_hd
                    WHERE wtktno = @lcl_pr_buffer=>gv_wtkt_num
                    INTO @DATA(ls_header).
    IF sy-subrc EQ 0.

      SELECT SINGLE * FROM zpr_tb_wt_it WHERE wtktno = @lcl_pr_buffer=>gv_wtkt_num
                               AND wtktitm = @lcl_pr_buffer=>gv_wtkt_item
                 INTO @DATA(ls_items).

**Fetch invoice percentages if maintained from agreement table
      IF ls_items-agreement IS NOT INITIAL.
        SELECT * FROM zpr_tb_agrmt WHERE agreement = @ls_items-agreement
                                      INTO TABLE @DATA(lt_agreement).
      ENDIF.

      DATA : lv_inv_amt TYPE zpr_dt_poprice.

      IF lt_agreement[] IS NOT INITIAL.
        LOOP AT lt_agreement INTO DATA(ls_agreement).

          CLEAR : ls_split, lv_inv_amt.

          ls_split-supplier = ls_agreement-lifnr.
          lv_inv_amt = ( ls_items-po_price ) * ( ls_agreement-percentage / 100 ).
          ls_split-amount = lv_inv_amt.
          APPEND ls_split TO lt_split.
        ENDLOOP.
      ELSE.
        IF ls_items-agreement IS INITIAL.

          CLEAR : ls_split.
          ls_split-supplier = ls_items-supplier.
          ls_split-amount = ls_items-po_price.

          APPEND ls_split TO lt_split.
        ENDIF.
      ENDIF.

      IF ls_items-ebeln IS NOT INITIAL AND ls_items-mblnr IS NOT INITIAL.

        LOOP AT lt_split INTO ls_split.
          DATA(lv_tabix) = sy-tabix.

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

* Prepare business data
              ls_inv_business_data = VALUE #(
                        company_code                = ls_items-werks
                        document_date = sy-datum
                        posting_date = sy-datum
                        supplier_invoice_idby_invc = ls_items-status
                        invoicing_party = ls_split-supplier
                        invoice_gross_amount = ls_split-amount
                        document_currency = 'USD'
                        accounting_document_type = 'RE'
                        supplier_invoice_status = '5'
                         ).

              ls_invitem_business_data = VALUE tt_inv_deep_create( (
                        supplier_invoice_item = '1'
                        purchase_order = ls_items-ebeln
                        purchase_order_item = ls_items-ebelp
                        plant = ls_items-werks
*                      reference_document = ls_items-mblnr
*                      reference_document_fiscal = ls_items-mjahr
*                      reference_document_item = '1'
                        document_currency = 'USD'
                        supplier_invoice_item_amou = ls_split-amount
                        purchase_order_quantity_un = ls_items-unit
                        quantity_in_purchase_order = ls_items-weight
                        purchase_order_price_unit = ls_items-unit
                        qty_in_purchase_order_pric = ls_items-weight
                        product_type = '1'
                 ) ).
              MOVE-CORRESPONDING ls_inv_business_data TO ls_deep_data.
              ls_deep_data-to_suplr_invc_item_pur_ord = ls_invitem_business_data[].

              APPEND 'COMPANY_CODE' TO  lt_property.
              APPEND 'DOCUMENT_DATE' TO lt_property.
              APPEND 'POSTING_DATE' TO lt_property.
              APPEND 'SUPPLIER_INVOICE_IDBY_INVC' TO  lt_property.
              APPEND 'INVOICING_PARTY' TO  lt_property.
              APPEND 'INVOICE_GROSS_AMOUNT' TO  lt_property.
              APPEND 'DOCUMENT_CURRENCY' TO lt_property.
              APPEND 'ACCOUNTING_DOCUMENT_TYPE' TO  lt_property.
              APPEND 'SUPPLIER_INVOICE_STATUS' TO lt_property.

              APPEND 'SUPPLIER_INVOICE_ITEM' TO lt_item_property.
              APPEND 'PURCHASE_ORDER' TO  lt_item_property.
              APPEND 'PURCHASE_ORDER_ITEM' TO  lt_item_property.
              APPEND 'PLANT' TO lt_item_property.
*            APPEND 'REFERENCE_DOCUMENT' TO lt_item_property.
*            APPEND 'REFERENCE_DOCUMENT_FISCAL' TO lt_item_property.
*            APPEND 'REFERENCE_DOCUMENT_ITEM' TO lt_item_property.
              APPEND 'DOCUMENT_CURRENCY' TO lt_item_property.
              APPEND 'SUPPLIER_INVOICE_ITEM_AMOU' TO  lt_item_property.
              APPEND 'PURCHASE_ORDER_QUANTITY_UN' TO lt_item_property.
              APPEND 'QUANTITY_IN_PURCHASE_ORDER' TO  lt_item_property.
              APPEND 'PURCHASE_ORDER_PRICE_UNIT' TO lt_item_property.
              APPEND 'QTY_IN_PURCHASE_ORDER_PRIC' TO lt_item_property.
              APPEND 'PRODUCT_TYPE' TO lt_item_property.

              lo_http_client->set_csrf_token( ).
              " Navigate to the resource and create a request for the create operation
              lo_request = lo_client_proxy->create_resource_for_entity_set( 'A_SUPPLIER_INVOICE' )->create_request_for_create( ).

              DATA(lo_data_description_node) = lo_request->create_data_descripton_node( ).
              lo_data_description_node->set_properties( lt_property  ).
              lo_data_description_node->add_child( 'TO_SUPLR_INVC_ITEM_PUR_ORD' )->set_properties( lt_item_property ).
              " Set the business data for the created entity
              lo_request->set_deep_business_data(
              is_business_data =  ls_deep_data
              io_data_description = lo_data_description_node
              ).

              " Execute the request
              lo_response = lo_request->execute( ).
              WAIT UP TO 1 SECONDS.

              CLEAR: ls_business_data.
              " Get the after image
              lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

              IF ls_business_data-supplier_invoice IS NOT INITIAL.
                IF lv_tabix EQ 1.
                  UPDATE zpr_tb_wt_it SET invoice = @ls_business_data-supplier_invoice,
                                          status = '60'
                WHERE wtktno =  @lcl_pr_buffer=>gv_wtkt_num
                AND   wtktitm = @lcl_pr_buffer=>gv_wtkt_item.
                ENDIF.

                IF lv_tabix EQ 2.
                  UPDATE zpr_tb_wt_it SET invoice_split1 = @ls_business_data-supplier_invoice,
                                          status = '60'
                WHERE wtktno =  @lcl_pr_buffer=>gv_wtkt_num
                AND   wtktitm = @lcl_pr_buffer=>gv_wtkt_item.
                ENDIF.

                IF lv_tabix EQ 3.
                  UPDATE zpr_tb_wt_it SET invoice_split2 = @ls_business_data-supplier_invoice,
                                          status = '60'
                WHERE wtktno =  @lcl_pr_buffer=>gv_wtkt_num
                AND   wtktitm = @lcl_pr_buffer=>gv_wtkt_item.
                ENDIF.

              ENDIF.

            CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
              IF lx_remote->get_text( ) IS NOT INITIAL.
                lt_msg = VALUE #( ( message = lx_remote->get_text( ) ) ).
                IF lt_msg[] IS NOT INITIAL.
                  lv_message = lt_msg[ 1 ]-message.
                  APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                            werks = ls_header-werks
                            wtktitm = lcl_pr_buffer=>gv_wtkt_item
                                   %msg = me->new_message_with_text(
                                    text = lv_message
                                    severity = if_abap_behv_message=>severity-error )
                                 ) TO reported-item.
                ENDIF.
              ENDIF.

              IF lx_remote->s_odata_error-message IS NOT INITIAL.
                lt_msg = VALUE #( BASE lt_msg ( message = lx_remote->s_odata_error-message ) ).
                IF lt_msg[] IS NOT INITIAL.
                  lv_message = lt_msg[ 2 ]-message.
                  APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                              werks = ls_header-werks
                              wtktitm = lcl_pr_buffer=>gv_wtkt_item
                                     %msg = me->new_message_with_text(
                                      text = lv_message
                                      severity = if_abap_behv_message=>severity-error )
                                   ) TO reported-item.
                ENDIF.
              ENDIF.

            CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
              lt_msg = VALUE #( ( message = lx_gateway->get_text( ) ) ).
              IF lt_msg[] IS NOT INITIAL.
                lv_message = lt_msg[ 1 ]-message.
                APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                             werks = ls_header-werks
                             wtktitm = lcl_pr_buffer=>gv_wtkt_item
                                    %msg = me->new_message_with_text(
                                     text = lv_message
                                     severity = if_abap_behv_message=>severity-error )
                                  ) TO reported-item.
              ENDIF.

            CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
              lv_message =  lx_web_http_client_error->get_longtext(  ).
              APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                              werks = ls_header-werks
                              wtktitm = lcl_pr_buffer=>gv_wtkt_item
                                     %msg = me->new_message_with_text(
                                      text = lv_message
                                      severity = if_abap_behv_message=>severity-error )
                                   ) TO reported-item.

            CATCH cx_http_dest_provider_error INTO DATA(lx_web_http_dest_error).
              lv_message =  lx_web_http_dest_error->get_longtext(  ).
              APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                              werks = ls_header-werks
                              wtktitm = lcl_pr_buffer=>gv_wtkt_item
                                     %msg = me->new_message_with_text(
                                      text = lv_message
                                      severity = if_abap_behv_message=>severity-error )
                                   ) TO reported-item.
          ENDTRY.
        ENDLOOP.
      ENDIF.
    ENDIF.

    IF ls_business_data-supplier_invoice IS NOT INITIAL.

      CONCATENATE 'Invoice ' ls_business_data-supplier_invoice  ' is created.'
        INTO lv_message.
      APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                       werks = ls_header-werks
                       wtktitm = lcl_pr_buffer=>gv_wtkt_item
                                    %msg = me->new_message_with_text(
                                     text = lv_message
                                     severity = if_abap_behv_message=>severity-success )
                                  ) TO reported-item.

    ENDIF.

    READ ENTITIES OF zpr_i_header IN LOCAL MODE
                       ENTITY item
                         ALL FIELDS WITH CORRESPONDING #( keys )
                       RESULT DATA(items).

    result = VALUE #( FOR item IN items
                            ( %is_draft = item-%is_draft
                              %tky   = item-%tky
                              %param = item ) ).

  ENDMETHOD.

  METHOD getuom.

    DATA: lv_meins      TYPE meins.

    READ ENTITIES OF zpr_i_header IN LOCAL MODE
                          ENTITY item ALL FIELDS WITH CORRESPONDING #( keys ) RESULT DATA(headers).

    READ TABLE headers INTO DATA(ls_headers) INDEX 1.

    SELECT SINGLE * FROM zpr_i_material WHERE material = @ls_headers-matnr INTO @DATA(ls_material).
    IF sy-subrc EQ 0.
      lv_meins = ls_material-unit.
    ENDIF.

    MODIFY ENTITIES OF zpr_i_header IN LOCAL MODE
          ENTITY item
          UPDATE SET FIELDS
          WITH VALUE #( FOR header IN headers
                          ( %key = header-%key
                           %is_draft = header-%is_draft
                           unit = lv_meins
                            ) )
         REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).

  ENDMETHOD.

*  METHOD poupdate.
*
*    TYPES: BEGIN OF ty_return,
*             message TYPE string,
*           END OF ty_return,
*
*           tt_return         TYPE STANDARD TABLE OF ty_return WITH DEFAULT KEY,
*           tt_po_deep_create TYPE STANDARD TABLE OF zpr_scm_cbp_po_v2=>tys_a_pur_ord_pricing_elemen_2 WITH NON-UNIQUE DEFAULT KEY.
*
*    DATA: lo_http_client        TYPE REF TO if_web_http_client,
*          lo_client_proxy       TYPE REF TO /iwbep/if_cp_client_proxy,
*          lo_request            TYPE REF TO /iwbep/if_cp_request_create,
*          lo_response           TYPE REF TO /iwbep/if_cp_response_create,
*          lt_property           TYPE /iwbep/if_cp_runtime_types=>ty_t_property_path,
*          lt_item_property      TYPE /iwbep/if_cp_runtime_types=>ty_t_property_path,
*          lt_msg                TYPE tt_return,
*          lv_message            TYPE string,
*          ls_po_business_data   TYPE zpr_scm_cbp_po_v2=>tys_a_pur_ord_pricing_elemen_2,
*          ls_cond_business_data TYPE tt_po_deep_create,
*          ls_business_data      TYPE zpr_scm_cbp_po_v2=>tys_a_pur_ord_pricing_elemen_2.
*
*    CONSTANTS: lc_po_url   TYPE string VALUE 'https://my403232-api.s4hana.cloud.sap/sap/opu/odata/sap/API_PURCHASEORDER_PROCESS_SRV',
*               lc_user     TYPE string VALUE 'DEMO_API_PC',
*               lc_password TYPE string VALUE 'fSQ#xoXWmonAJJnqVaKoqzmRuxAh9ZfFktRbFSfL'.
*
*    LOOP AT keys INTO DATA(ls_keys).
*      lcl_pr_buffer=>gv_wtkt_num = ls_keys-wtktno.
*      lcl_pr_buffer=>gv_wtkt_item = ls_keys-wtktitm.
*    ENDLOOP.
*
*    READ ENTITIES OF zpr_i_header IN LOCAL MODE
*                         ENTITY item
*                           ALL FIELDS WITH CORRESPONDING #( keys )
*                         RESULT DATA(items).
*    READ TABLE items INTO DATA(ls_item) INDEX 1.
*    IF sy-subrc EQ 0.
*      IF ls_item-ebeln IS NOT INITIAL AND ls_item-prueflos IS NOT INITIAL.
** Check if Inspection Lot results are posted
*        SELECT * FROM i_inspectionresult WHERE inspectionlot = @ls_item-prueflos
*          INTO TABLE @DATA(lt_insp_results).
*        IF sy-subrc EQ 0.
** Get inspection lot characteristic
*          SELECT * FROM i_inspectioncharacteristic WHERE inspectionlot = @ls_item-prueflos
*            INTO TABLE @DATA(lt_insp_char).
*
*          IF sy-subrc EQ 0.
*            SELECT * FROM zpr_tb_cond_map FOR ALL ENTRIES IN @lt_insp_char
*              WHERE char_name = @lt_insp_char-inspectionspecification
*              INTO TABLE @DATA(lt_cond).
**            IF sy-subrc EQ 0.
** Fetch the custom condition types for PO update
*            SELECT * FROM zpr_tb_po_price FOR ALL ENTRIES IN @lt_cond
*              WHERE cond_type = @lt_cond-cond_type
*              AND start_date LE @sy-datum
*              AND end_date GE @sy-datum
*              AND deletion_ind = ''
*              INTO TABLE @DATA(lt_price).
*            IF sy-subrc EQ 0.
*              SORT lt_price BY cond_type.
*            ENDIF.
*
*            SELECT SINGLE * FROM i_purorditmpricingelementapi01
*             WHERE purchaseorder = @ls_item-ebeln
*             AND purchaseorderitem = @ls_item-ebelp
*             INTO @DATA(ls_element).
*
*            LOOP AT lt_insp_char INTO DATA(ls_insp_char).
*              READ TABLE lt_cond INTO DATA(ls_cond) WITH KEY char_name = ls_insp_char-inspectionspecification.
*              IF sy-subrc EQ 0.
*                READ TABLE lt_insp_results INTO DATA(ls_results) WITH KEY inspectionlot = ls_item-prueflos
*                                                                          inspectioncharacteristic = ls_insp_char-inspectioncharacteristic.
*                IF sy-subrc EQ 0.
*                  CLEAR: ls_po_business_data.
*                  LOOP AT lt_price INTO DATA(ls_price) WHERE cond_type = ls_cond-cond_type.
*                    IF ls_price-low LE ls_results-inspectionresultmeanvalue AND
*                       ls_results-inspectionresultmeanvalue LE ls_price-high.
*
*                      TRY.
** Update PO Price - add custom condition types based on results recording
*                          lo_http_client = cl_web_http_client_manager=>create_by_http_destination(
*                                    i_destination = cl_http_destination_provider=>create_by_url( lc_po_url ) ).
*                          DATA(lo_http_req) = lo_http_client->get_http_request( ).
*                          lo_http_req->set_authorization_basic(
*                                                                 i_username = lc_user
*                                                                 i_password = lc_password
*                                                               ).
*
*                          lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
*                          EXPORTING
*                             is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
*                                                                 proxy_model_id      = 'ZPR_SCM_CBP_PO_V2'
*                                                                 proxy_model_version = '0001' )
*                            io_http_client             = lo_http_client
*                            iv_relative_service_root   = ''  ).
*
*                          ASSERT lo_http_client IS BOUND.
*
*                          APPEND 'PURCHASE_ORDER' TO  lt_item_property.
*                          APPEND 'PURCHASE_ORDER_ITEM' TO  lt_item_property.
*                          APPEND 'PRICING_DOCUMENT' TO  lt_item_property.
*                          APPEND 'PRICING_DOCUMENT_ITEM' TO  lt_item_property.
*                          APPEND 'CONDITION_TYPE' TO lt_item_property.
*                          APPEND 'CONDITION_RATE_VALUE' TO lt_item_property.
*
*                          lo_http_client->set_csrf_token( ).
*                          " Navigate to the resource and create a request for the create operation
*                          lo_request = lo_client_proxy->create_resource_for_entity_set( 'A_PUR_ORD_PRICING_ELEMENT' )->create_request_for_create( ).
*
** Prepare business data
*                          ls_po_business_data-purchase_order = ls_item-ebeln.
*                          ls_po_business_data-purchase_order_item = ls_item-ebelp.
*                          ls_po_business_data-pricing_document = ls_element-pricingdocument.
*                          ls_po_business_data-pricing_document_item = '000010'.
*                          ls_po_business_data-condition_type = ls_cond-cond_type.
*                          ls_po_business_data-condition_rate_value = ls_price-cond_value.
*
*                          " Set the business data for the created entity
*                          lo_request->set_business_data(
*                          is_business_data =  ls_po_business_data
*                          it_provided_property = lt_item_property
*                          ).
*
*                          " Execute the request
*                          lo_response = lo_request->execute( ).
*                          WAIT UP TO 3 SECONDS.
*
*                          CLEAR: ls_business_data.
*                          " Get the after image
*                          lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
*
*                          IF ls_business_data IS NOT INITIAL.
** Get Updated PO Price
*                            SELECT SINGLE * FROM i_purchaseorderitemapi01 WHERE purchaseorder = @ls_item-ebeln
*                            AND purchaseorderitem = @ls_item-ebelp
*                            INTO @DATA(ls_po).
*                            UPDATE zpr_tb_wt_it SET status = '40',
*                                                    po_price = @ls_po-netamount
*                                        WHERE wtktno =  @lcl_pr_buffer=>gv_wtkt_num
*                                        AND   wtktitm = @lcl_pr_buffer=>gv_wtkt_item.
*                          ENDIF.
*
*                        CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
*                          IF lx_remote->get_text( ) IS NOT INITIAL.
*                            lt_msg = VALUE #( ( message = lx_remote->get_text( ) ) ).
*                            IF lt_msg[] IS NOT INITIAL.
*                              lv_message = lt_msg[ 1 ]-message.
*                              APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
*                           werks = ls_item-werks
*                           wtktitm = lcl_pr_buffer=>gv_wtkt_item
*                                  %msg = me->new_message_with_text(
*                                   text = lv_message
*                                   severity = if_abap_behv_message=>severity-error )
*                                ) TO reported-item.
*                            ENDIF.
*                          ENDIF.
*
*                          IF lx_remote->s_odata_error-message IS NOT INITIAL.
*                            lt_msg = VALUE #( BASE lt_msg ( message = lx_remote->s_odata_error-message ) ).
*                            IF lt_msg[] IS NOT INITIAL.
*                              lv_message = lt_msg[ 2 ]-message.
*                              APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
*                           werks = ls_item-werks
*                           wtktitm = lcl_pr_buffer=>gv_wtkt_item
*                                  %msg = me->new_message_with_text(
*                                   text = lv_message
*                                   severity = if_abap_behv_message=>severity-error )
*                                ) TO reported-item.
*                            ENDIF.
*                          ENDIF.
*
*                        CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
*                          lt_msg = VALUE #( ( message = lx_gateway->get_text( ) ) ).
*                          IF lt_msg[] IS NOT INITIAL.
*                            lv_message = lt_msg[ 1 ]-message.
*                            APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
*                           werks = ls_item-werks
*                           wtktitm = lcl_pr_buffer=>gv_wtkt_item
*                                  %msg = me->new_message_with_text(
*                                   text = lv_message
*                                   severity = if_abap_behv_message=>severity-error )
*                                ) TO reported-item.
*                          ENDIF.
*
*                        CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
*                          lv_message =  lx_web_http_client_error->get_longtext(  ).
*                          APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
*                           werks = ls_item-werks
*                           wtktitm = lcl_pr_buffer=>gv_wtkt_item
*                                  %msg = me->new_message_with_text(
*                                   text = lv_message
*                                   severity = if_abap_behv_message=>severity-error )
*                                ) TO reported-item.
*
*                        CATCH cx_http_dest_provider_error INTO DATA(lx_web_http_dest_error).
*                          lv_message =  lx_web_http_dest_error->get_longtext(  ).
*                          APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
*                           werks = ls_item-werks
*                           wtktitm = lcl_pr_buffer=>gv_wtkt_item
*                                  %msg = me->new_message_with_text(
*                                   text = lv_message
*                                   severity = if_abap_behv_message=>severity-error )
*                                ) TO reported-item.
*                      ENDTRY.
*                    ENDIF.
*                  ENDLOOP.
*                ENDIF.
*              ENDIF.
*            ENDLOOP.
*          ENDIF.
*        ELSE.
*          lv_message = 'Results not yet recorded for the Inspection Lot.'.
*          APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
*                             werks = ls_item-werks
*                             wtktitm = lcl_pr_buffer=>gv_wtkt_item
*                                    %msg = me->new_message_with_text(
*                                     text = lv_message
*                                     severity = if_abap_behv_message=>severity-error )
*                                  ) TO reported-item.
*        ENDIF.
*      ENDIF.
*    ENDIF.
*
*    READ ENTITIES OF zpr_i_header IN LOCAL MODE
*                       ENTITY item
*                         ALL FIELDS WITH CORRESPONDING #( keys )
*                       RESULT DATA(lt_items).
*
*    result = VALUE #( FOR item IN lt_items
*                            ( %is_draft = item-%is_draft
*                              %tky   = item-%tky
*                              %param = item ) ).
*
*  ENDMETHOD.

  METHOD stock.

* Create Goods Movement
    TYPES: BEGIN OF ty_return,
             message TYPE string,
           END OF ty_return,

           tt_return         TYPE STANDARD TABLE OF ty_return WITH DEFAULT KEY,
           tt_gr_deep_create TYPE STANDARD TABLE OF zpr_scm_cbp_gr=>tys_a_material_document_item_t WITH NON-UNIQUE DEFAULT KEY.

    TYPES:           BEGIN OF ty_gr_deep_create.
                       INCLUDE TYPE zpr_scm_cbp_gr=>tys_a_material_document_head_2.
    TYPES:             to_material_document_item TYPE tt_gr_deep_create,
                     END OF ty_gr_deep_create.

    DATA: lo_http_client          TYPE REF TO if_web_http_client,
          lo_client_proxy         TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request              TYPE REF TO /iwbep/if_cp_request_create,
          lo_response             TYPE REF TO /iwbep/if_cp_response_create,
          lt_property             TYPE /iwbep/if_cp_runtime_types=>ty_t_property_path,
          lt_item_property        TYPE /iwbep/if_cp_runtime_types=>ty_t_property_path,
          lt_msg                  TYPE tt_return,
          lv_message              TYPE string,
          ls_gr_business_data     TYPE zpr_scm_cbp_gr=>tys_a_material_document_head_2,
          ls_gritem_business_data TYPE tt_gr_deep_create,
          ls_business_data_gr     TYPE ty_gr_deep_create,
          ls_deep_data_gr         TYPE ty_gr_deep_create,
          lv_move_type            TYPE bwart.

    CONSTANTS: lc_gr_url   TYPE string VALUE 'https://my403232-api.s4hana.cloud.sap/sap/opu/odata/sap/API_MATERIAL_DOCUMENT_SRV',
               lc_user     TYPE string VALUE 'DEMO_API_PC',
               lc_password TYPE string VALUE 'fSQ#xoXWmonAJJnqVaKoqzmRuxAh9ZfFktRbFSfL',
               lc_name     TYPE string VALUE 'If-Match'.

    LOOP AT keys INTO DATA(ls_keys).
      lcl_pr_buffer=>gv_wtkt_num = ls_keys-wtktno.
      lcl_pr_buffer=>gv_wtkt_item = ls_keys-wtktitm.
    ENDLOOP.

*Get header info
    SELECT SINGLE * FROM zpr_tb_wt_hd
                    WHERE wtktno = @lcl_pr_buffer=>gv_wtkt_num
                    INTO @DATA(ls_header).
    IF sy-subrc EQ 0.

      SELECT SINGLE * FROM zpr_tb_wt_it WHERE wtktno = @lcl_pr_buffer=>gv_wtkt_num
                               AND wtktitm = @lcl_pr_buffer=>gv_wtkt_item
                 INTO @DATA(ls_items).

      TRY.
          lo_http_client = cl_web_http_client_manager=>create_by_http_destination(
                    i_destination = cl_http_destination_provider=>create_by_url( lc_gr_url ) ).
          DATA(lo_http_req) = lo_http_client->get_http_request( ).
          lo_http_req->set_authorization_basic(
                                                 i_username = lc_user
                                                 i_password = lc_password
                                               ).

          lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
          EXPORTING
             is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                 proxy_model_id      = 'ZPR_SCM_CBP_GR'
                                                 proxy_model_version = '0001' )
            io_http_client             = lo_http_client
            iv_relative_service_root   = ''  ).

          ASSERT lo_http_client IS BOUND.

* Prepare business data
          ls_gr_business_data = VALUE #(
               material_document_header_t = ls_header-wtktno
               goods_movement_code = '04'
                     ).

          IF ls_keys-%param-tplant EQ ls_keys-%param-splant.
            lv_move_type = '311'.
          ELSE.
            lv_move_type = '301'.
          ENDIF.

          ls_gritem_business_data = VALUE tt_gr_deep_create( (
                  material = ls_items-matnr
                  plant = ls_keys-%param-tplant
                  storage_location = ls_keys-%param-tsloc
                  goods_movement_type = lv_move_type
                  batch = ls_items-charg
                  entry_unit = ls_items-unit
                  quantity_in_entry_unit = ls_items-weight
                  issg_or_rcvg_material = ls_items-matnr
                  issuing_or_receiving_plant = ls_keys-%param-splant
                  issuing_or_receiving_stora = ls_keys-%param-ssloc
                  issg_or_rcvg_batch = ls_items-charg
             ) ).

          MOVE-CORRESPONDING ls_gr_business_data TO ls_deep_data_gr.
          ls_deep_data_gr-to_material_document_item = ls_gritem_business_data[].

          CLEAR: lt_property[], lt_item_property[].

          APPEND 'MATERIAL_DOCUMENT_HEADER_T' TO  lt_property.
          APPEND 'GOODS_MOVEMENT_CODE' TO lt_property.

          APPEND 'PLANT' TO  lt_item_property.
          APPEND 'MATERIAL' TO  lt_item_property.
          APPEND 'STORAGE_LOCATION' TO lt_item_property.
          APPEND 'GOODS_MOVEMENT_TYPE' TO lt_item_property.
          APPEND 'BATCH' TO lt_item_property.
          APPEND 'ENTRY_UNIT' TO lt_item_property.
          APPEND 'QUANTITY_IN_ENTRY_UNIT' TO lt_item_property.
          APPEND 'ISSG_OR_RCVG_MATERIAL' TO lt_item_property.
          APPEND 'ISSUING_OR_RECEIVING_PLANT' TO lt_item_property.
          APPEND 'ISSUING_OR_RECEIVING_STORA' TO lt_item_property.
          APPEND 'ISSG_OR_RCVG_BATCH' TO lt_item_property.

          lo_http_client->set_csrf_token( ).
          " Navigate to the resource and create a request for the create operation
          lo_request = lo_client_proxy->create_resource_for_entity_set( 'A_MATERIAL_DOCUMENT_HEADER' )->create_request_for_create( ).

          DATA(lo_data_description_node) = lo_request->create_data_descripton_node( ).
          lo_data_description_node->set_properties( lt_property  ).
          lo_data_description_node->add_child( 'TO_MATERIAL_DOCUMENT_ITEM' )->set_properties( lt_item_property ).
          " Set the business data for the created entity
          lo_request->set_deep_business_data(
          is_business_data =  ls_deep_data_gr
          io_data_description = lo_data_description_node
          ).

          " Execute the request
          lo_response = lo_request->execute( ).

          CLEAR: ls_business_data_gr.
          " Get the after image
          lo_response->get_business_data( IMPORTING es_business_data = ls_business_data_gr ).

          IF ls_business_data_gr-material_document IS NOT INITIAL.

          ENDIF.

        CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
          IF lx_remote->get_text( ) IS NOT INITIAL.
            lt_msg = VALUE #( ( message = lx_remote->get_text( ) ) ).
            IF lt_msg[] IS NOT INITIAL.
              lv_message = lt_msg[ 1 ]-message.
              APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                           werks = ls_header-werks
                           wtktitm = lcl_pr_buffer=>gv_wtkt_item
                                  %msg = me->new_message_with_text(
                                   text = lv_message
                                   severity = if_abap_behv_message=>severity-error )
                                ) TO reported-item.
            ENDIF.
          ENDIF.

          IF lx_remote->s_odata_error-message IS NOT INITIAL.
            lt_msg = VALUE #( BASE lt_msg ( message = lx_remote->s_odata_error-message ) ).
            IF lt_msg[] IS NOT INITIAL.
              lv_message = lt_msg[ 2 ]-message.
              APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                           werks = ls_header-werks
                           wtktitm = lcl_pr_buffer=>gv_wtkt_item
                                  %msg = me->new_message_with_text(
                                   text = lv_message
                                   severity = if_abap_behv_message=>severity-error )
                                ) TO reported-item.
            ENDIF.
          ENDIF.

        CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
          lt_msg = VALUE #( ( message = lx_gateway->get_text( ) ) ).
          IF lt_msg[] IS NOT INITIAL.
            lv_message = lt_msg[ 1 ]-message.
            APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                           werks = ls_header-werks
                           wtktitm = lcl_pr_buffer=>gv_wtkt_item
                                  %msg = me->new_message_with_text(
                                   text = lv_message
                                   severity = if_abap_behv_message=>severity-error )
                                ) TO reported-item.
          ENDIF.

        CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
          lv_message =  lx_web_http_client_error->get_longtext(  ).
          APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                           werks = ls_header-werks
                           wtktitm = lcl_pr_buffer=>gv_wtkt_item
                                  %msg = me->new_message_with_text(
                                   text = lv_message
                                   severity = if_abap_behv_message=>severity-error )
                                ) TO reported-item.

        CATCH cx_http_dest_provider_error INTO DATA(lx_web_http_dest_error).
          lv_message =  lx_web_http_dest_error->get_longtext(  ).
          APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num
                           werks = ls_header-werks
                           wtktitm = lcl_pr_buffer=>gv_wtkt_item
                                  %msg = me->new_message_with_text(
                                   text = lv_message
                                   severity = if_abap_behv_message=>severity-error )
                                ) TO reported-item.
      ENDTRY.

    ENDIF.

    READ ENTITIES OF zpr_i_header IN LOCAL MODE
                       ENTITY item
                         ALL FIELDS WITH CORRESPONDING #( keys )
                       RESULT DATA(items).

    result = VALUE #( FOR item IN items
                            ( %is_draft = item-%is_draft
                              %tky   = item-%tky
                              %param = item ) ).

  ENDMETHOD.

  METHOD defaultitemdata.

    READ ENTITIES OF zpr_i_header IN LOCAL MODE
                         ENTITY header
                           ALL FIELDS WITH CORRESPONDING #( keys )
                         RESULT DATA(headers).

    READ TABLE headers INTO DATA(ls_header) INDEX 1.

    MODIFY ENTITIES OF zpr_i_header IN LOCAL MODE
           ENTITY item
           UPDATE SET FIELDS
           WITH VALUE #( FOR key IN keys
                           ( %key = key-%key
                           %is_draft = key-%is_draft
                            supplier = ls_header-lifnr
                            ernam = sy-uname
                            erdat = sy-datum
                            ereit = sy-uzeit
                             ) )
          REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).


  ENDMETHOD.

  METHOD getdefaultsforstock.

    READ ENTITIES OF zpr_i_header IN LOCAL MODE
                         ENTITY item
                           ALL FIELDS WITH CORRESPONDING #( keys )
                         RESULT DATA(items).

    READ TABLE items INTO DATA(item) INDEX 1.
    IF sy-subrc EQ 0.
      APPEND VALUE #( %tky = item-%tky
                      %param-tplant = item-werks
                      %param-tsloc = item-lgort
       ) TO result.

    ENDIF.

  ENDMETHOD.

ENDCLASS.

CLASS lsc_zpr_i_header DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zpr_i_header IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.

    READ TABLE lcl_pr_buffer=>mt_hdr_create INTO DATA(ls_header_check) INDEX 1.

    IF  ls_header_check IS NOT INITIAL AND lcl_pr_buffer=>mt_item_create[] IS INITIAL.

      APPEND VALUE #( %key = '' ) TO failed-header.
      APPEND VALUE #( wtktno = ls_header_check-wtktno
                   werks = ls_header_check-werks
                   %msg = new_message(
                   id = 'ZPR_MESSAGES'
                   number = '174'
                   severity = if_abap_behv_message=>severity-error )
                   ) TO reported-header.
    ENDIF.

  ENDMETHOD.

  METHOD save.

    DATA : lt_hdr        TYPE STANDARD TABLE OF zpr_tb_wt_hd,
           lt_item       TYPE STANDARD TABLE OF zpr_tb_wt_it,
           lt_hdr_update TYPE STANDARD TABLE OF zpr_tb_wt_hd.

***SAVE HEADER TO DB
    DATA: lv_wtkt_frm TYPE n LENGTH 10,
          lv_msgv1    TYPE syst-msgv1,
          lv_msgv2    TYPE syst-msgv2,
          lv_msgv3    TYPE syst-msgv3,
          ls_log      TYPE zpr_tb_log.

    READ TABLE lcl_pr_buffer=>mt_hdr_create INTO DATA(ls_header_check) INDEX 1.

    IF ls_header_check IS NOT INITIAL AND lcl_pr_buffer=>mt_item_create[] IS INITIAL.

      APPEND VALUE #( wtktno = ls_header_check-wtktno
                   werks = ls_header_check-werks
                   %msg = new_message(
                   id = 'ZPR_MESSAGES'
                   number = '174'
                   severity = if_abap_behv_message=>severity-error )
                   ) TO reported-header.

    ELSE.
      IF lcl_pr_buffer=>mt_hdr_create[] IS NOT INITIAL.

        CLEAR : lcl_pr_buffer=>gv_wtkt_read.
        lcl_pr_buffer=>gv_wtkt_read = lv_wtkt_frm.

        READ TABLE lcl_pr_buffer=>mt_hdr_create INTO DATA(ls_header_to_db) INDEX 1.
        IF sy-subrc EQ 0.
          lv_wtkt_frm = ls_header_to_db-wtktno.
          ls_header_to_db-wtktno = ls_header_to_db-wtktno.
          MODIFY zpr_tb_wt_hd FROM @ls_header_to_db.
          IF sy-subrc EQ 0.

            APPEND VALUE #( wtktno = ls_header_to_db-wtktno
                   %msg = new_message(
                   id = 'ZPR_MESSAGES'
                   number = '007'
                   v1 =   ls_header_to_db-wtktno
                   v2 =   'created'
                   severity = if_abap_behv_message=>severity-success
                                      )
                 ) TO reported-header.

***log maintenence
            CLEAR : ls_log .
            ls_log-wtktno = ls_header_to_db-wtktno.
            ls_log-werks = ls_header_to_db-werks.
            ls_log-msgid = 'ZPR_MESSAGES'.
            ls_log-msgno = '007'.
            ls_log-mdate = sy-datum.
            ls_log-msgv1 = ls_header_to_db-wtktno.
            ls_log-messsage = |Weight Ticket { ls_header_to_db-wtktno } saved |.
            ls_log-muser = sy-uname.
            ls_log-time = sy-timlo.
            ls_log-new_value = ls_header_to_db-wtktno.
            MODIFY zpr_tb_log FROM @ls_log.
            IF sy-subrc EQ 0.
            ENDIF.
          ENDIF.
        ENDIF.

****save data directly from item buffer from UI screen
        IF lcl_pr_buffer=>mt_item_create[] IS NOT INITIAL.
          LOOP AT lcl_pr_buffer=>mt_item_create INTO DATA(ls_item).
            APPEND ls_item TO lt_item.
          ENDLOOP.
          IF lt_item IS NOT INITIAL.
            INSERT zpr_tb_wt_it FROM TABLE @lt_item .
          ENDIF.

        ELSE.
**SAVE ITEM TO DB
          IF lcl_pr_buffer=>mt_item_from_header[] IS NOT INITIAL.
            LOOP AT lcl_pr_buffer=>mt_item_from_header INTO DATA(ls_item_to_db).
              ls_item_to_db-wtktno = lv_wtkt_frm.
              MODIFY zpr_tb_wt_it FROM @ls_item_to_db.
            ENDLOOP.
          ENDIF.
        ENDIF.

      ELSE.
        IF lcl_pr_buffer=>mt_item_create[] IS NOT INITIAL.
          LOOP AT lcl_pr_buffer=>mt_item_create INTO ls_item.
            APPEND ls_item TO lt_item.
          ENDLOOP.
          IF lt_item IS NOT INITIAL.
            INSERT zpr_tb_wt_it FROM TABLE @lt_item .
          ENDIF.
        ENDIF.
      ENDIF.

      IF lcl_pr_buffer=>mt_hdr_update[] IS  NOT INITIAL.
        READ TABLE lcl_pr_buffer=>mt_hdr_update INTO DATA(ls_hdr_update) INDEX 1.
        IF ls_hdr_update IS NOT INITIAL.
          APPEND ls_hdr_update TO lt_hdr_update.
          MODIFY zpr_tb_wt_hd FROM TABLE @lt_hdr_update .
        ENDIF.
      ENDIF.

***Start - Item Data - UPDATE
      IF lcl_pr_buffer=>mt_item_update[] IS NOT INITIAL.

        LOOP AT lcl_pr_buffer=>mt_item_update INTO DATA(ls_item_update_db).
          MODIFY zpr_tb_wt_it FROM @ls_item_update_db.
          IF sy-subrc EQ 0.
          ENDIF.
        ENDLOOP.

      ENDIF.

**if deletion action selected, mark the weight ticker for deletion
      IF lcl_pr_buffer=>gv_flag_wtkt_delete IS NOT INITIAL.
        IF lcl_pr_buffer=>gv_wtkt_num_delete IS NOT INITIAL.
          UPDATE zpr_tb_wt_hd SET deletion = 'X'  WHERE wtktno = @lcl_pr_buffer=>gv_wtkt_num_delete.
          IF sy-subrc EQ 0.
            APPEND VALUE #( wtktno = lcl_pr_buffer=>gv_wtkt_num_delete
                            %msg = new_message(
                            id = 'ZPR_MESSAGES'
                            number = '013'
                            v1 =   lcl_pr_buffer=>gv_wtkt_num_delete
                            severity = if_abap_behv_message=>severity-success
                            ) ) TO reported-header.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.

  ENDMETHOD.

  METHOD cleanup.


  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.