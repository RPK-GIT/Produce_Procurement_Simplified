  METHOD def_initiate_recount_on_item.

    DATA:
      lo_function        TYPE REF TO /iwbep/if_v4_pm_function,
      lo_function_import TYPE REF TO /iwbep/if_v4_pm_func_imp,
      lo_parameter       TYPE REF TO /iwbep/if_v4_pm_func_param,
      lo_return          TYPE REF TO /iwbep/if_v4_pm_func_return.


    lo_function = mo_model->create_function( 'INITIATE_RECOUNT_ON_ITEM' ).
    lo_function->set_edm_name( 'InitiateRecountOnItem' ) ##NO_TEXT.

    lo_function_import = lo_function->create_function_import( 'INITIATE_RECOUNT_ON_ITEM' ).
    lo_function_import->set_edm_name( 'InitiateRecountOnItem' ) ##NO_TEXT.


    lo_parameter = lo_function->create_parameter( 'PHYSICAL_INVENTORY_DOCUMEN' ).
    lo_parameter->set_edm_name( 'PhysicalInventoryDocument' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'PHYSICAL_INVENTORY_DOCUM_6' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'FISCAL_YEAR' ).
    lo_parameter->set_edm_name( 'FiscalYear' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'FISCAL_YEAR_4' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'PHYSICAL_INVENTORY_DOCUM_2' ).
    lo_parameter->set_edm_name( 'PhysicalInventoryDocumentItem' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'PHYSICAL_INVENTORY_DOCUM_7' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'PHYS_INVENTORY_PLANNED_COU' ).
    lo_parameter->set_edm_name( 'PhysInventoryPlannedCountDate' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'PHYS_INVENTORY_PLANNED_C_2' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'DOCUMENT_DATE' ).
    lo_parameter->set_edm_name( 'DocumentDate' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'DOCUMENT_DATE_2' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'PHYSICAL_INVENTORY_NUMBER' ).
    lo_parameter->set_edm_name( 'PhysicalInventoryNumber' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'PHYSICAL_INVENTORY_NUMBE_2' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'PHYS_INVENTORY_REFERENCE_N' ).
    lo_parameter->set_edm_name( 'PhysInventoryReferenceNumber' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'PHYS_INVENTORY_REFERENCE_2' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'PHYSICAL_INVENTORY_DOCUM_3' ).
    lo_parameter->set_edm_name( 'PhysicalInventoryDocumentDesc' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'PHYSICAL_INVENTORY_DOCUM_8' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'PHYS_INVTRY_DOC_HAS_QTY_SN' ).
    lo_parameter->set_edm_name( 'PhysInvtryDocHasQtySnapshot' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'PHYS_INVTRY_DOC_HAS_QTY__2' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'POSTING_IS_BLOCKED_FOR_PHY' ).
    lo_parameter->set_edm_name( 'PostingIsBlockedForPhysInvtry' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'POSTING_IS_BLOCKED_FOR_P_2' ).
    lo_parameter->set_is_nullable( ).

    lo_return = lo_function->create_return( ).
    lo_return->set_entity_type( 'A_PHYS_INVENTORY_DOC_ITE_2' ).

  ENDMETHOD.