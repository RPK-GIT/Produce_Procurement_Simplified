 METHOD if_sadl_exit_calc_element_read~calculate.

  DATA:    lv_qual           TYPE char10,
           lt_original_data TYPE STANDARD TABLE OF zpr_c_header WITH DEFAULT KEY.

    lt_original_data = CORRESPONDING #( it_original_data ).

    SELECT * FROM i_supplier INTO TABLE @DATA(lt_supplier).

  LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_original_data>).

      IF <fs_original_data>-Lifnr IS NOT INITIAL.
         READ TABLE lt_supplier INTO DATA(ls_supplier) WITH KEY Supplier = <fs_original_data>-Lifnr.
         IF sy-subrc EQ 0.
            <fs_original_data>-lifnrname = ls_supplier-SupplierFullName.
         ENDIF.
      ENDIF.

       IF <fs_original_data>-Qualifier IS NOT INITIAL.
         lv_qual = <fs_original_data>-Qualifier+0(10).
         lv_qual = |{ lv_qual ALPHA = IN }|.
         READ TABLE lt_supplier INTO ls_supplier WITH KEY Supplier = lv_qual.
         IF sy-subrc EQ 0.
            <fs_original_data>-qualifiername = ls_supplier-SupplierFullName.
         ENDIF.
      ENDIF.

       IF <fs_original_data>-Hauler IS NOT INITIAL.
         READ TABLE lt_supplier INTO ls_supplier WITH KEY Supplier = <fs_original_data>-Hauler.
         IF sy-subrc EQ 0.
            <fs_original_data>-haulername = ls_supplier-SupplierFullName.
         ENDIF.
      ENDIF.

       IF <fs_original_data>-Supplier IS NOT INITIAL.
         READ TABLE lt_supplier INTO ls_supplier WITH KEY Supplier = <fs_original_data>-Supplier.
         IF sy-subrc EQ 0.
            <fs_original_data>-suppliername = ls_supplier-SupplierFullName.
         ENDIF.
      ENDIF.
 ENDLOOP.

    ct_calculated_data = CORRESPONDING #( lt_original_data ).
  ENDMETHOD.