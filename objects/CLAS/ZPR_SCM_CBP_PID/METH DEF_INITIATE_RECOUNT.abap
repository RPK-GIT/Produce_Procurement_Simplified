  METHOD def_initiate_recount.

    DATA:
      lo_function        TYPE REF TO /iwbep/if_v4_pm_function,
      lo_function_import TYPE REF TO /iwbep/if_v4_pm_func_imp,
      lo_parameter       TYPE REF TO /iwbep/if_v4_pm_func_param,
      lo_return          TYPE REF TO /iwbep/if_v4_pm_func_return.


    lo_function = mo_model->create_function( 'INITIATE_RECOUNT' ).
    lo_function->set_edm_name( 'InitiateRecount' ) ##NO_TEXT.

    lo_function_import = lo_function->create_function_import( 'INITIATE_RECOUNT' ).
    lo_function_import->set_edm_name( 'InitiateRecount' ) ##NO_TEXT.


    lo_parameter = lo_function->create_parameter( 'PHYSICAL_INVENTORY_DOCUMEN' ).
    lo_parameter->set_edm_name( 'PhysicalInventoryDocument' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'PHYSICAL_INVENTORY_DOCUM_4' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'FISCAL_YEAR' ).
    lo_parameter->set_edm_name( 'FiscalYear' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'FISCAL_YEAR_3' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'PHYS_INVENTORY_PLANNED_COU' ).
    lo_parameter->set_edm_name( 'PhysInventoryPlannedCountDate' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'PHYS_INVENTORY_PLANNED_COU' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'DOCUMENT_DATE' ).
    lo_parameter->set_edm_name( 'DocumentDate' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'DOCUMENT_DATE' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'PHYSICAL_INVENTORY_NUMBER' ).
    lo_parameter->set_edm_name( 'PhysicalInventoryNumber' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'PHYSICAL_INVENTORY_NUMBER' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'PHYS_INVENTORY_REFERENCE_N' ).
    lo_parameter->set_edm_name( 'PhysInventoryReferenceNumber' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'PHYS_INVENTORY_REFERENCE_N' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'PHYSICAL_INVENTORY_DOCUM_2' ).
    lo_parameter->set_edm_name( 'PhysicalInventoryDocumentDesc' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'PHYSICAL_INVENTORY_DOCUM_5' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'POSTING_THRESHOLD_VALUE' ).
    lo_parameter->set_edm_name( 'PostingThresholdValue' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'POSTING_THRESHOLD_VALUE_2' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'PHYS_INVTRY_DOC_HAS_QTY_SN' ).
    lo_parameter->set_edm_name( 'PhysInvtryDocHasQtySnapshot' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'PHYS_INVTRY_DOC_HAS_QTY_SN' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'POSTING_IS_BLOCKED_FOR_PHY' ).
    lo_parameter->set_edm_name( 'PostingIsBlockedForPhysInvtry' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'POSTING_IS_BLOCKED_FOR_PHY' ).
    lo_parameter->set_is_nullable( ).

    lo_return = lo_function->create_return( ).
    lo_return->set_entity_type( 'A_PHYS_INVENTORY_DOC_HEA_2' ).

  ENDMETHOD.