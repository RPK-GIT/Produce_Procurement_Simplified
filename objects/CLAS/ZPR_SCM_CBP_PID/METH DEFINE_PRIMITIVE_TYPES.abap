  METHOD define_primitive_types.

    DATA lo_primitive_type TYPE REF TO /iwbep/if_v4_pm_prim_type.


    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'BATCH'
                            iv_element             = VALUE tys_types_for_prim_types-batch( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DOCUMENT_DATE'
                            iv_element             = VALUE tys_types_for_prim_types-document_date( ) ).
    lo_primitive_type->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_type->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'DOCUMENT_DATE_2'
                            iv_element             = VALUE tys_types_for_prim_types-document_date_2( ) ).
    lo_primitive_type->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_type->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'FISCAL_YEAR'
                            iv_element             = VALUE tys_types_for_prim_types-fiscal_year( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'FISCAL_YEAR_2'
                            iv_element             = VALUE tys_types_for_prim_types-fiscal_year_2( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'FISCAL_YEAR_3'
                            iv_element             = VALUE tys_types_for_prim_types-fiscal_year_3( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'FISCAL_YEAR_4'
                            iv_element             = VALUE tys_types_for_prim_types-fiscal_year_4( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'MATERIAL'
                            iv_element             = VALUE tys_types_for_prim_types-material( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'PHYSICAL_INVENTORY_DOCUMEN'
                            iv_element             = VALUE tys_types_for_prim_types-physical_inventory_documen( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'PHYSICAL_INVENTORY_DOCUM_2'
                            iv_element             = VALUE tys_types_for_prim_types-physical_inventory_docum_2( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'PHYSICAL_INVENTORY_DOCUM_3'
                            iv_element             = VALUE tys_types_for_prim_types-physical_inventory_docum_3( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'PHYSICAL_INVENTORY_DOCUM_4'
                            iv_element             = VALUE tys_types_for_prim_types-physical_inventory_docum_4( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'PHYSICAL_INVENTORY_DOCUM_5'
                            iv_element             = VALUE tys_types_for_prim_types-physical_inventory_docum_5( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'PHYSICAL_INVENTORY_DOCUM_6'
                            iv_element             = VALUE tys_types_for_prim_types-physical_inventory_docum_6( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'PHYSICAL_INVENTORY_DOCUM_7'
                            iv_element             = VALUE tys_types_for_prim_types-physical_inventory_docum_7( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'PHYSICAL_INVENTORY_DOCUM_8'
                            iv_element             = VALUE tys_types_for_prim_types-physical_inventory_docum_8( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'PHYSICAL_INVENTORY_NUMBER'
                            iv_element             = VALUE tys_types_for_prim_types-physical_inventory_number( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'PHYSICAL_INVENTORY_NUMBE_2'
                            iv_element             = VALUE tys_types_for_prim_types-physical_inventory_numbe_2( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'PHYS_INVENTORY_PLANNED_COU'
                            iv_element             = VALUE tys_types_for_prim_types-phys_inventory_planned_cou( ) ).
    lo_primitive_type->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_type->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'PHYS_INVENTORY_PLANNED_C_2'
                            iv_element             = VALUE tys_types_for_prim_types-phys_inventory_planned_c_2( ) ).
    lo_primitive_type->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_type->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'PHYS_INVENTORY_REFERENCE_2'
                            iv_element             = VALUE tys_types_for_prim_types-phys_inventory_reference_2( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'PHYS_INVENTORY_REFERENCE_N'
                            iv_element             = VALUE tys_types_for_prim_types-phys_inventory_reference_n( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'PHYS_INVTRY_DOC_HAS_QTY_SN'
                            iv_element             = VALUE tys_types_for_prim_types-phys_invtry_doc_has_qty_sn( ) ).
    lo_primitive_type->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'PHYS_INVTRY_DOC_HAS_QTY__2'
                            iv_element             = VALUE tys_types_for_prim_types-phys_invtry_doc_has_qty__2( ) ).
    lo_primitive_type->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'POSTING_DATE'
                            iv_element             = VALUE tys_types_for_prim_types-posting_date( ) ).
    lo_primitive_type->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_type->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'POSTING_DATE_2'
                            iv_element             = VALUE tys_types_for_prim_types-posting_date_2( ) ).
    lo_primitive_type->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_type->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'POSTING_IS_BLOCKED_FOR_PHY'
                            iv_element             = VALUE tys_types_for_prim_types-posting_is_blocked_for_phy( ) ).
    lo_primitive_type->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'POSTING_IS_BLOCKED_FOR_P_2'
                            iv_element             = VALUE tys_types_for_prim_types-posting_is_blocked_for_p_2( ) ).
    lo_primitive_type->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'POSTING_THRESHOLD_VALUE'
                            iv_element             = VALUE tys_types_for_prim_types-posting_threshold_value( ) ).
    lo_primitive_type->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_type->set_precision( 14 ) ##NUMBER_OK.
    lo_primitive_type->set_scale( 3 ) ##NUMBER_OK.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'POSTING_THRESHOLD_VALUE_2'
                            iv_element             = VALUE tys_types_for_prim_types-posting_threshold_value_2( ) ).
    lo_primitive_type->set_edm_type( 'Decimal' ) ##NO_TEXT.
    lo_primitive_type->set_precision( 14 ) ##NUMBER_OK.
    lo_primitive_type->set_scale( 3 ) ##NUMBER_OK.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'REASON_FOR_PHYS_INVTRY_DIF'
                            iv_element             = VALUE tys_types_for_prim_types-reason_for_phys_invtry_dif( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

  ENDMETHOD.