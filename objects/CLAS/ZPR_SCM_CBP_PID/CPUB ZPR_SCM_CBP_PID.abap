"! <p class="shorttext synchronized">Consumption model for client proxy - generated</p>
"! This class has been generated based on the metadata with namespace
"! <em>API_PHYSICAL_INVENTORY_DOC_SRV</em>
CLASS zpr_scm_cbp_pid DEFINITION
  PUBLIC
  INHERITING FROM /iwbep/cl_v4_abs_pm_model_prov
  CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES:
      "! <p class="shorttext synchronized">Types for "OData Primitive Types"</p>
      BEGIN OF tys_types_for_prim_types,
        "! Used for primitive type BATCH
        batch                      TYPE c LENGTH 10,
        "! Used for primitive type DOCUMENT_DATE
        document_date              TYPE timestamp,
        "! Used for primitive type DOCUMENT_DATE_2
        document_date_2            TYPE timestamp,
        "! Used for primitive type FISCAL_YEAR
        fiscal_year                TYPE c LENGTH 4,
        "! Used for primitive type FISCAL_YEAR_2
        fiscal_year_2              TYPE c LENGTH 4,
        "! Used for primitive type FISCAL_YEAR_3
        fiscal_year_3              TYPE c LENGTH 4,
        "! Used for primitive type FISCAL_YEAR_4
        fiscal_year_4              TYPE c LENGTH 4,
        "! Used for primitive type MATERIAL
        material                   TYPE c LENGTH 40,
        "! Used for primitive type PHYSICAL_INVENTORY_DOCUMEN
        physical_inventory_documen TYPE c LENGTH 10,
        "! Used for primitive type PHYSICAL_INVENTORY_DOCUM_2
        physical_inventory_docum_2 TYPE c LENGTH 3,
        "! Used for primitive type PHYSICAL_INVENTORY_DOCUM_3
        physical_inventory_docum_3 TYPE c LENGTH 10,
        "! Used for primitive type PHYSICAL_INVENTORY_DOCUM_4
        physical_inventory_docum_4 TYPE c LENGTH 10,
        "! Used for primitive type PHYSICAL_INVENTORY_DOCUM_5
        physical_inventory_docum_5 TYPE c LENGTH 40,
        "! Used for primitive type PHYSICAL_INVENTORY_DOCUM_6
        physical_inventory_docum_6 TYPE c LENGTH 10,
        "! Used for primitive type PHYSICAL_INVENTORY_DOCUM_7
        physical_inventory_docum_7 TYPE c LENGTH 3,
        "! Used for primitive type PHYSICAL_INVENTORY_DOCUM_8
        physical_inventory_docum_8 TYPE c LENGTH 40,
        "! Used for primitive type PHYSICAL_INVENTORY_NUMBER
        physical_inventory_number  TYPE c LENGTH 16,
        "! Used for primitive type PHYSICAL_INVENTORY_NUMBE_2
        physical_inventory_numbe_2 TYPE c LENGTH 16,
        "! Used for primitive type PHYS_INVENTORY_PLANNED_COU
        phys_inventory_planned_cou TYPE timestamp,
        "! Used for primitive type PHYS_INVENTORY_PLANNED_C_2
        phys_inventory_planned_c_2 TYPE timestamp,
        "! Used for primitive type PHYS_INVENTORY_REFERENCE_2
        phys_inventory_reference_2 TYPE c LENGTH 16,
        "! Used for primitive type PHYS_INVENTORY_REFERENCE_N
        phys_inventory_reference_n TYPE c LENGTH 16,
        "! Used for primitive type PHYS_INVTRY_DOC_HAS_QTY_SN
        phys_invtry_doc_has_qty_sn TYPE abap_bool,
        "! Used for primitive type PHYS_INVTRY_DOC_HAS_QTY__2
        phys_invtry_doc_has_qty__2 TYPE abap_bool,
        "! Used for primitive type POSTING_DATE
        posting_date               TYPE timestamp,
        "! Used for primitive type POSTING_DATE_2
        posting_date_2             TYPE timestamp,
        "! Used for primitive type POSTING_IS_BLOCKED_FOR_PHY
        posting_is_blocked_for_phy TYPE abap_bool,
        "! Used for primitive type POSTING_IS_BLOCKED_FOR_P_2
        posting_is_blocked_for_p_2 TYPE abap_bool,
        "! Used for primitive type POSTING_THRESHOLD_VALUE
        posting_threshold_value    TYPE p LENGTH 8 DECIMALS 3,
        "! Used for primitive type POSTING_THRESHOLD_VALUE_2
        posting_threshold_value_2  TYPE p LENGTH 8 DECIMALS 3,
        "! Used for primitive type REASON_FOR_PHYS_INVTRY_DIF
        reason_for_phys_invtry_dif TYPE c LENGTH 4,
      END OF tys_types_for_prim_types.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function InitiateRecount</p>
      "! <em>with the internal name</em> INITIATE_RECOUNT
      BEGIN OF tys_parameters_1,
        "! PhysicalInventoryDocument
        physical_inventory_documen TYPE c LENGTH 10,
        "! FiscalYear
        fiscal_year                TYPE c LENGTH 4,
        "! PhysInventoryPlannedCountDate
        phys_inventory_planned_cou TYPE timestamp,
        "! DocumentDate
        document_date              TYPE timestamp,
        "! PhysicalInventoryNumber
        physical_inventory_number  TYPE c LENGTH 16,
        "! PhysInventoryReferenceNumber
        phys_inventory_reference_n TYPE c LENGTH 16,
        "! PhysicalInventoryDocumentDesc
        physical_inventory_docum_2 TYPE c LENGTH 40,
        "! PostingThresholdValue
        posting_threshold_value    TYPE p LENGTH 8 DECIMALS 3,
        "! PhysInvtryDocHasQtySnapshot
        phys_invtry_doc_has_qty_sn TYPE abap_bool,
        "! PostingIsBlockedForPhysInvtry
        posting_is_blocked_for_phy TYPE abap_bool,
      END OF tys_parameters_1,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_1</p>
      tyt_parameters_1 TYPE STANDARD TABLE OF tys_parameters_1 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function InitiateRecountOnItem</p>
      "! <em>with the internal name</em> INITIATE_RECOUNT_ON_ITEM
      BEGIN OF tys_parameters_2,
        "! PhysicalInventoryDocument
        physical_inventory_documen TYPE c LENGTH 10,
        "! FiscalYear
        fiscal_year                TYPE c LENGTH 4,
        "! PhysicalInventoryDocumentItem
        physical_inventory_docum_2 TYPE c LENGTH 3,
        "! PhysInventoryPlannedCountDate
        phys_inventory_planned_cou TYPE timestamp,
        "! DocumentDate
        document_date              TYPE timestamp,
        "! PhysicalInventoryNumber
        physical_inventory_number  TYPE c LENGTH 16,
        "! PhysInventoryReferenceNumber
        phys_inventory_reference_n TYPE c LENGTH 16,
        "! PhysicalInventoryDocumentDesc
        physical_inventory_docum_3 TYPE c LENGTH 40,
        "! PhysInvtryDocHasQtySnapshot
        phys_invtry_doc_has_qty_sn TYPE abap_bool,
        "! PostingIsBlockedForPhysInvtry
        posting_is_blocked_for_phy TYPE abap_bool,
      END OF tys_parameters_2,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_2</p>
      tyt_parameters_2 TYPE STANDARD TABLE OF tys_parameters_2 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function PostDifferences</p>
      "! <em>with the internal name</em> POST_DIFFERENCES
      BEGIN OF tys_parameters_3,
        "! PostingThresholdValue
        posting_threshold_value    TYPE p LENGTH 8 DECIMALS 3,
        "! PostingDate
        posting_date               TYPE timestamp,
        "! PhysicalInventoryDocument
        physical_inventory_documen TYPE c LENGTH 10,
        "! FiscalYear
        fiscal_year                TYPE c LENGTH 4,
      END OF tys_parameters_3,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_3</p>
      tyt_parameters_3 TYPE STANDARD TABLE OF tys_parameters_3 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function PostDifferencesOnItem</p>
      "! <em>with the internal name</em> POST_DIFFERENCES_ON_ITEM
      BEGIN OF tys_parameters_4,
        "! PhysicalInventoryDocumentItem
        physical_inventory_documen TYPE c LENGTH 3,
        "! Material
        material                   TYPE c LENGTH 40,
        "! PhysicalInventoryDocument
        physical_inventory_docum_2 TYPE c LENGTH 10,
        "! FiscalYear
        fiscal_year                TYPE c LENGTH 4,
        "! Batch
        batch                      TYPE c LENGTH 10,
        "! ReasonForPhysInvtryDifference
        reason_for_phys_invtry_dif TYPE c LENGTH 4,
        "! PostingDate
        posting_date               TYPE timestamp,
      END OF tys_parameters_4,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_4</p>
      tyt_parameters_4 TYPE STANDARD TABLE OF tys_parameters_4 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">A_PhysInventoryDocHeaderType</p>
      BEGIN OF tys_a_phys_inventory_doc_hea_2,
        "! <em>Key property</em> FiscalYear
        fiscal_year                TYPE c LENGTH 4,
        "! <em>Key property</em> PhysicalInventoryDocument
        physical_inventory_documen TYPE c LENGTH 10,
        "! InventoryTransactionType
        inventory_transaction_type TYPE c LENGTH 2,
        "! Plant
        plant                      TYPE c LENGTH 4,
        "! StorageLocation
        storage_location           TYPE c LENGTH 4,
        "! InventorySpecialStockType
        inventory_special_stock_ty TYPE c LENGTH 1,
        "! DocumentDate
        document_date              TYPE datn,
        "! PhysInventoryPlannedCountDate
        phys_inventory_planned_cou TYPE datn,
        "! PhysicalInventoryLastCountDate
        physical_inventory_last_co TYPE datn,
        "! PostingDate
        posting_date               TYPE datn,
        "! FiscalPeriod
        fiscal_period              TYPE c LENGTH 2,
        "! CreatedByUser
        created_by_user            TYPE c LENGTH 12,
        "! PostingIsBlockedForPhysInvtry
        posting_is_blocked_for_phy TYPE abap_bool,
        "! PhysicalInventoryCountStatus
        physical_inventory_count_s TYPE c LENGTH 1,
        "! PhysInvtryAdjustmentPostingSts
        phys_invtry_adjustment_pos TYPE c LENGTH 1,
        "! PhysInvtryDeletionStatus
        phys_invtry_deletion_statu TYPE c LENGTH 1,
        "! PhysInvtryDocHasQtySnapshot
        phys_invtry_doc_has_qty_sn TYPE abap_bool,
        "! PhysicalInventoryGroupType
        physical_inventory_group_t TYPE c LENGTH 2,
        "! PhysicalInventoryGroup
        physical_inventory_group   TYPE c LENGTH 10,
        "! PhysicalInventoryNumber
        physical_inventory_number  TYPE c LENGTH 16,
        "! PhysInventoryReferenceNumber
        phys_inventory_reference_n TYPE c LENGTH 16,
        "! PhysicalInventoryDocumentDesc
        physical_inventory_docum_2 TYPE c LENGTH 40,
        "! PhysicalInventoryType
        physical_inventory_type    TYPE c LENGTH 1,
        "! LastChangeDateTime
        last_change_date_time      TYPE timestampl,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_a_phys_inventory_doc_hea_2,
      "! <p class="shorttext synchronized">List of A_PhysInventoryDocHeaderType</p>
      tyt_a_phys_inventory_doc_hea_2 TYPE STANDARD TABLE OF tys_a_phys_inventory_doc_hea_2 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">A_PhysInventoryDocItemType</p>
      BEGIN OF tys_a_phys_inventory_doc_ite_2,
        "! <em>Key property</em> FiscalYear
        fiscal_year                TYPE c LENGTH 4,
        "! <em>Key property</em> PhysicalInventoryDocument
        physical_inventory_documen TYPE c LENGTH 10,
        "! <em>Key property</em> PhysicalInventoryDocumentItem
        physical_inventory_docum_2 TYPE c LENGTH 3,
        "! Plant
        plant                      TYPE c LENGTH 4,
        "! StorageLocation
        storage_location           TYPE c LENGTH 4,
        "! Material
        material                   TYPE c LENGTH 40,
        "! Batch
        batch                      TYPE c LENGTH 10,
        "! InventorySpecialStockType
        inventory_special_stock_ty TYPE c LENGTH 1,
        "! PhysicalInventoryStockType
        physical_inventory_stock_t TYPE c LENGTH 1,
        "! SalesOrder
        sales_order                TYPE c LENGTH 10,
        "! SalesOrderItem
        sales_order_item           TYPE c LENGTH 6,
        "! Supplier
        supplier                   TYPE c LENGTH 10,
        "! Customer
        customer                   TYPE c LENGTH 10,
        "! WBSElement
        wbselement                 TYPE c LENGTH 24,
        "! LastChangeUser
        last_change_user           TYPE c LENGTH 12,
        "! LastChangeDate
        last_change_date           TYPE datn,
        "! CountedByUser
        counted_by_user            TYPE c LENGTH 12,
        "! PhysicalInventoryLastCountDate
        physical_inventory_last_co TYPE datn,
        "! AdjustmentPostingMadeByUser
        adjustment_posting_made_by TYPE c LENGTH 12,
        "! PostingDate
        posting_date               TYPE datn,
        "! PhysicalInventoryItemIsCounted
        physical_inventory_item_is TYPE abap_bool,
        "! PhysInvtryDifferenceIsPosted
        phys_invtry_difference_is  TYPE abap_bool,
        "! PhysInvtryItemIsRecounted
        phys_invtry_item_is_recoun TYPE abap_bool,
        "! PhysInvtryItemIsDeleted
        phys_invtry_item_is_delete TYPE abap_bool,
        "! IsHandledInAltvUnitOfMsr
        is_handled_in_altv_unit_of TYPE abap_bool,
        "! CycleCountType
        cycle_count_type           TYPE c LENGTH 1,
        "! IsValueOnlyMaterial
        is_value_only_material     TYPE abap_bool,
        "! PhysInventoryReferenceNumber
        phys_inventory_reference_n TYPE c LENGTH 16,
        "! MaterialDocument
        material_document          TYPE c LENGTH 10,
        "! MaterialDocumentYear
        material_document_year     TYPE c LENGTH 4,
        "! MaterialDocumentItem
        material_document_item     TYPE c LENGTH 4,
        "! PhysInvtryRecountDocument
        phys_invtry_recount_docume TYPE c LENGTH 10,
        "! PhysicalInventoryItemIsZero
        physical_inventory_item__2 TYPE abap_bool,
        "! ReasonForPhysInvtryDifference
        reason_for_phys_invtry_dif TYPE c LENGTH 4,
        "! MaterialBaseUnit
        material_base_unit         TYPE c LENGTH 3,
        "! BookQtyBfrCountInMatlBaseUnit
        book_qty_bfr_count_in_matl TYPE p LENGTH 7 DECIMALS 3,
        "! Quantity
        quantity                   TYPE p LENGTH 7 DECIMALS 3,
        "! UnitOfEntry
        unit_of_entry              TYPE c LENGTH 3,
        "! QuantityInUnitOfEntry
        quantity_in_unit_of_entry  TYPE p LENGTH 7 DECIMALS 3,
        "! Currency
        currency                   TYPE c LENGTH 5,
        "! DifferenceAmountInCoCodeCrcy
        difference_amount_in_co_co TYPE p LENGTH 8 DECIMALS 3,
        "! EnteredSlsAmtInCoCodeCrcy
        entered_sls_amt_in_co_code TYPE p LENGTH 8 DECIMALS 3,
        "! SlsPriceAmountInCoCodeCrcy
        sls_price_amount_in_co_cod TYPE p LENGTH 8 DECIMALS 3,
        "! PhysInvtryCtAmtInCoCodeCrcy
        phys_invtry_ct_amt_in_co_c TYPE p LENGTH 8 DECIMALS 3,
        "! BookQtyAmountInCoCodeCrcy
        book_qty_amount_in_co_code TYPE p LENGTH 8 DECIMALS 3,
        "! LastChangeDateTime
        last_change_date_time      TYPE timestampl,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_a_phys_inventory_doc_ite_2,
      "! <p class="shorttext synchronized">List of A_PhysInventoryDocItemType</p>
      tyt_a_phys_inventory_doc_ite_2 TYPE STANDARD TABLE OF tys_a_phys_inventory_doc_ite_2 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">A_SerialNumberPhysInventoryDocType</p>
      BEGIN OF tys_a_serial_number_phys_inv_2,
        "! <em>Key property</em> Equipment
        equipment                  TYPE c LENGTH 18,
        "! <em>Key property</em> FiscalYear
        fiscal_year                TYPE c LENGTH 4,
        "! <em>Key property</em> PhysicalInventoryDocument
        physical_inventory_documen TYPE c LENGTH 10,
        "! <em>Key property</em> PhysicalInventoryDocumentItem
        physical_inventory_docum_2 TYPE c LENGTH 3,
        "! <em>Key property</em> SerialNumberPhysicalInvtryType
        serial_number_physical_inv TYPE c LENGTH 1,
        "! Material
        material                   TYPE c LENGTH 40,
        "! SerialNumber
        serial_number              TYPE c LENGTH 18,
      END OF tys_a_serial_number_phys_inv_2,
      "! <p class="shorttext synchronized">List of A_SerialNumberPhysInventoryDocType</p>
      tyt_a_serial_number_phys_inv_2 TYPE STANDARD TABLE OF tys_a_serial_number_phys_inv_2 WITH DEFAULT KEY.


    CONSTANTS:
      "! <p class="shorttext synchronized">Internal Names of the entity sets</p>
      BEGIN OF gcs_entity_set,
        "! A_PhysInventoryDocHeader
        "! <br/> Collection of type 'A_PhysInventoryDocHeaderType'
        a_phys_inventory_doc_heade TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'A_PHYS_INVENTORY_DOC_HEADE',
        "! A_PhysInventoryDocItem
        "! <br/> Collection of type 'A_PhysInventoryDocItemType'
        a_phys_inventory_doc_item  TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'A_PHYS_INVENTORY_DOC_ITEM',
        "! A_SerialNumberPhysInventoryDoc
        "! <br/> Collection of type 'A_SerialNumberPhysInventoryDocType'
        a_serial_number_phys_inven TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'A_SERIAL_NUMBER_PHYS_INVEN',
      END OF gcs_entity_set .

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal Names of the function imports</p>
      BEGIN OF gcs_function_import,
        "! InitiateRecount
        "! <br/> See structure type {@link ..tys_parameters_1} for the parameters
        initiate_recount         TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'INITIATE_RECOUNT',
        "! InitiateRecountOnItem
        "! <br/> See structure type {@link ..tys_parameters_2} for the parameters
        initiate_recount_on_item TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'INITIATE_RECOUNT_ON_ITEM',
        "! PostDifferences
        "! <br/> See structure type {@link ..tys_parameters_3} for the parameters
        post_differences         TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'POST_DIFFERENCES',
        "! PostDifferencesOnItem
        "! <br/> See structure type {@link ..tys_parameters_4} for the parameters
        post_differences_on_item TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'POST_DIFFERENCES_ON_ITEM',
      END OF gcs_function_import.

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal Names of the bound functions</p>
      BEGIN OF gcs_bound_function,
         "! Dummy field - Structure must not be empty
         dummy TYPE int1 VALUE 0,
      END OF gcs_bound_function.

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal names for complex types</p>
      BEGIN OF gcs_complex_type,
         "! Dummy field - Structure must not be empty
         dummy TYPE int1 VALUE 0,
      END OF gcs_complex_type.

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal names for entity types</p>
      BEGIN OF gcs_entity_type,
        "! <p class="shorttext synchronized">Internal names for A_PhysInventoryDocHeaderType</p>
        "! See also structure type {@link ..tys_a_phys_inventory_doc_hea_2}
        BEGIN OF a_phys_inventory_doc_hea_2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! to_PhysicalInventoryDocumentItem
            to_physical_inventory_docu TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'TO_PHYSICAL_INVENTORY_DOCU',
          END OF navigation,
        END OF a_phys_inventory_doc_hea_2,
        "! <p class="shorttext synchronized">Internal names for A_PhysInventoryDocItemType</p>
        "! See also structure type {@link ..tys_a_phys_inventory_doc_ite_2}
        BEGIN OF a_phys_inventory_doc_ite_2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! to_PhysicalInventoryDocument
            to_physical_inventory_docu TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'TO_PHYSICAL_INVENTORY_DOCU',
            "! to_SerialNumbers
            to_serial_numbers          TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'TO_SERIAL_NUMBERS',
          END OF navigation,
        END OF a_phys_inventory_doc_ite_2,
        "! <p class="shorttext synchronized">Internal names for A_SerialNumberPhysInventoryDocType</p>
        "! See also structure type {@link ..tys_a_serial_number_phys_inv_2}
        BEGIN OF a_serial_number_phys_inv_2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF a_serial_number_phys_inv_2,
      END OF gcs_entity_type.


    METHODS /iwbep/if_v4_mp_basic_pm~define REDEFINITION.

