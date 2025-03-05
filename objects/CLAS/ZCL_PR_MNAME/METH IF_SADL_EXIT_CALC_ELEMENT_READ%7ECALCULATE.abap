METHOD if_sadl_exit_calc_element_read~calculate.

   DATA : lt_original_data TYPE STANDARD TABLE OF zpr_c_header WITH DEFAULT KEY.

  lt_original_data = CORRESPONDING #( it_original_data ).

  SELECT * FROM ZPR_I_MATERIAL INTO TABLE @DATA(lt_material).

  LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_original_data>).

       IF <fs_original_data>-MatDistance IS NOT INITIAL.
         READ TABLE lt_material INTO DATA(ls_material) WITH KEY Material = <fs_original_data>-MatDistance.
         IF sy-subrc EQ 0.
            <fs_original_data>-matdisttext = ls_material-Matname.
         ENDIF.
      ENDIF.

       IF <fs_original_data>-MatWeight IS NOT INITIAL.
         READ TABLE lt_material INTO ls_material WITH KEY Material = <fs_original_data>-MatWeight.
         IF sy-subrc EQ 0.
            <fs_original_data>-matwttext = ls_material-Matname.
         ENDIF.
      ENDIF.

    ENDLOOP.

    ct_calculated_data = CORRESPONDING #( lt_original_data ).
  ENDMETHOD.