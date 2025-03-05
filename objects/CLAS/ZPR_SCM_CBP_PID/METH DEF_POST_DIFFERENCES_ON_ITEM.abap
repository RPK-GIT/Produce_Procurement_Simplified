  METHOD def_post_differences_on_item.

    DATA:
      lo_function        TYPE REF TO /iwbep/if_v4_pm_function,
      lo_function_import TYPE REF TO /iwbep/if_v4_pm_func_imp,
      lo_parameter       TYPE REF TO /iwbep/if_v4_pm_func_param,
      lo_return          TYPE REF TO /iwbep/if_v4_pm_func_return.


    lo_function = mo_model->create_function( 'POST_DIFFERENCES_ON_ITEM' ).
    lo_function->set_edm_name( 'PostDifferencesOnItem' ) ##NO_TEXT.

    lo_function_import = lo_function->create_function_import( 'POST_DIFFERENCES_ON_ITEM' ).
    lo_function_import->set_edm_name( 'PostDifferencesOnItem' ) ##NO_TEXT.


    lo_parameter = lo_function->create_parameter( 'PHYSICAL_INVENTORY_DOCUMEN' ).
    lo_parameter->set_edm_name( 'PhysicalInventoryDocumentItem' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'PHYSICAL_INVENTORY_DOCUM_2' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'MATERIAL' ).
    lo_parameter->set_edm_name( 'Material' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'MATERIAL' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'PHYSICAL_INVENTORY_DOCUM_2' ).
    lo_parameter->set_edm_name( 'PhysicalInventoryDocument' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'PHYSICAL_INVENTORY_DOCUM_3' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'FISCAL_YEAR' ).
    lo_parameter->set_edm_name( 'FiscalYear' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'FISCAL_YEAR_2' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'BATCH' ).
    lo_parameter->set_edm_name( 'Batch' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'BATCH' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'REASON_FOR_PHYS_INVTRY_DIF' ).
    lo_parameter->set_edm_name( 'ReasonForPhysInvtryDifference' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'REASON_FOR_PHYS_INVTRY_DIF' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'POSTING_DATE' ).
    lo_parameter->set_edm_name( 'PostingDate' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'POSTING_DATE_2' ).
    lo_parameter->set_is_nullable( ).

    lo_return = lo_function->create_return( ).
    lo_return->set_entity_type( 'A_PHYS_INVENTORY_DOC_ITE_2' ).

  ENDMETHOD.