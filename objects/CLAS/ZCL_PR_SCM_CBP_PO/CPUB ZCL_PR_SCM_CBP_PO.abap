"! <p class="shorttext synchronized">Consumption model for client proxy - generated</p>
"! This class has been generated based on the metadata with namespace
"! <em>com.sap.gateway.srvd_a2x.api_purchaseorder_2.v0001</em>
CLASS zcl_pr_scm_cbp_po DEFINITION
  PUBLIC
  INHERITING FROM /iwbep/cl_v4_abs_pm_model_prov
  CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES:
      "! <p class="shorttext synchronized">Types for primitive collection fields</p>
      BEGIN OF tys_types_for_prim_colls,
        "! additionalTargets
        "! Used for TYS_SAP_MESSAGE-ADDITIONAL_TARGETS
        additional_targets TYPE string,
      END OF tys_types_for_prim_colls.

    TYPES:
      "! <p class="shorttext synchronized">D_PurOrdGetOutputBinaryDataR</p>
      BEGIN OF tys_d_pur_ord_get_output_binar,
        "! MimeType
        mime_type            TYPE c LENGTH 128,
        "! OutputBinaryData
        output_binary_data   TYPE xstring,
        "! OutputChannel
        output_channel       TYPE c LENGTH 5,
        "! OutputDocumentName
        output_document_name TYPE c LENGTH 120,
        "! Recipient
        recipient            TYPE c LENGTH 10,
        "! RecipientRole
        recipient_role       TYPE c LENGTH 2,
      END OF tys_d_pur_ord_get_output_binar,
      "! <p class="shorttext synchronized">List of D_PurOrdGetOutputBinaryDataR</p>
      tyt_d_pur_ord_get_output_binar TYPE STANDARD TABLE OF tys_d_pur_ord_get_output_binar WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Value Control Structure of SAP_MESSAGE</p>
      BEGIN OF tys_value_controls_1,
        "! TARGET
        target       TYPE /iwbep/v4_value_control,
        "! LONGTEXT_URL
        longtext_url TYPE /iwbep/v4_value_control,
      END OF tys_value_controls_1.

    TYPES:
      "! <p class="shorttext synchronized">SAP__Message</p>
      BEGIN OF tys_sap_message,
        "! <em>Value Control Structure</em>
        value_controls     TYPE tys_value_controls_1,
        "! code
        code               TYPE string,
        "! message
        message            TYPE string,
        "! target
        target             TYPE string,
        "! additionalTargets
        additional_targets TYPE STANDARD TABLE OF tys_types_for_prim_colls-additional_targets WITH DEFAULT KEY,
        "! transition
        transition         TYPE abap_bool,
        "! numericSeverity
        numeric_severity   TYPE int1,
        "! longtextUrl
        longtext_url       TYPE string,
      END OF tys_sap_message,
      "! <p class="shorttext synchronized">List of SAP__Message</p>
      tyt_sap_message TYPE STANDARD TABLE OF tys_sap_message WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Value Control Structure of PURCHASE_ORDER_ITEM_TYPE</p>
      BEGIN OF tys_value_controls_2,
        "! GOODS_RECEIPT_LATEST_CREAT
        goods_receipt_latest_creat TYPE /iwbep/v4_value_control,
        "! TAX_DETERMINATION_DATE
        tax_determination_date     TYPE /iwbep/v4_value_control,
        "! PURG_DOC_PRICE_DATE
        purg_doc_price_date        TYPE /iwbep/v4_value_control,
        "! DOWN_PAYMENT_DUE_DATE
        down_payment_due_date      TYPE /iwbep/v4_value_control,
        "! PURCHASE_ORDER_INVOICING_P
        purchase_order_invoicing_p TYPE /iwbep/v4_value_control,
        "! PURCHASE_ORDER_ITEM_NOTE
        purchase_order_item_note   TYPE /iwbep/v4_value_control,
        "! PURCHASE_ORDER_SCHEDULE_LI
        purchase_order_schedule_li TYPE /iwbep/v4_value_control,
        "! PUR_ORD_ACCOUNT_ASSIGNMENT
        pur_ord_account_assignment TYPE /iwbep/v4_value_control,
        "! PUR_ORD_PRICING_ELEMENT
        pur_ord_pricing_element    TYPE /iwbep/v4_value_control,
      END OF tys_value_controls_2.

    TYPES:
      "! <p class="shorttext synchronized">Value Control Structure of PURCHASE_ORDER_PARTNER_TYP</p>
      BEGIN OF tys_value_controls_3,
        "! CREATION_DATE
        creation_date TYPE /iwbep/v4_value_control,
      END OF tys_value_controls_3.

    TYPES:
      "! <p class="shorttext synchronized">Value Control Structure of PURCHASE_ORDER_INVOICING_3</p>
      BEGIN OF tys_value_controls_4,
        "! INVOICING_PLAN_START_DATE
        invoicing_plan_start_date TYPE /iwbep/v4_value_control,
        "! INVOICING_PLAN_END_DATE
        invoicing_plan_end_date   TYPE /iwbep/v4_value_control,
        "! POINVOICING_PLAN_ITEM
        poinvoicing_plan_item     TYPE /iwbep/v4_value_control,
      END OF tys_value_controls_4.

    TYPES:
      "! <p class="shorttext synchronized">Value Control Structure of PURCHASE_ORDER_SCHEDULE__2</p>
      BEGIN OF tys_value_controls_5,
        "! SCHEDULE_LINE_DELIVERY_DAT
        schedule_line_delivery_dat TYPE /iwbep/v4_value_control,
        "! SCHED_LINE_STSC_DELIVERY_D
        sched_line_stsc_delivery_d TYPE /iwbep/v4_value_control,
        "! PERFORMANCE_PERIOD_START_D
        performance_period_start_d TYPE /iwbep/v4_value_control,
        "! PERFORMANCE_PERIOD_END_DAT
        performance_period_end_dat TYPE /iwbep/v4_value_control,
        "! SCHEDULE_LINE_ORDER_DATE
        schedule_line_order_date   TYPE /iwbep/v4_value_control,
        "! PRODUCT_AVAILABILITY_DATE
        product_availability_date  TYPE /iwbep/v4_value_control,
        "! LOADING_DATE
        loading_date               TYPE /iwbep/v4_value_control,
        "! TRANSPORTATION_PLANNING_DA
        transportation_planning_da TYPE /iwbep/v4_value_control,
        "! GOODS_ISSUE_DATE
        goods_issue_date           TYPE /iwbep/v4_value_control,
        "! SUBCONTRACTING_COMPONENT
        subcontracting_component   TYPE /iwbep/v4_value_control,
      END OF tys_value_controls_5.

    TYPES:
      "! <p class="shorttext synchronized">Value Control Structure of POSUBCONTRACTING_COMPONE_2</p>
      BEGIN OF tys_value_controls_6,
        "! REQUIREMENT_DATE
        requirement_date        TYPE /iwbep/v4_value_control,
        "! LATEST_REQUIREMENT_DATE
        latest_requirement_date TYPE /iwbep/v4_value_control,
      END OF tys_value_controls_6.

    TYPES:
      "! <p class="shorttext synchronized">Value Control Structure of PUR_ORDER_ITEM_PRICING_E_2</p>
      BEGIN OF tys_value_controls_7,
        "! PRICE_CONDITION_DETERMINAT
        price_condition_determinat TYPE /iwbep/v4_value_control,
        "! CONFIGBL_PARAMETERS_AND_FO
        configbl_parameters_and_fo TYPE /iwbep/v4_value_control,
      END OF tys_value_controls_7.

    TYPES:
      "! <p class="shorttext synchronized">Value Control Structure of PURCHASE_ORDER_ACCOUNT_A_2</p>
      BEGIN OF tys_value_controls_8,
        "! SETTLEMENT_REFERENCE_DATE
        settlement_reference_date TYPE /iwbep/v4_value_control,
        "! VALIDITY_DATE
        validity_date             TYPE /iwbep/v4_value_control,
        "! CREATION_DATE
        creation_date             TYPE /iwbep/v4_value_control,
      END OF tys_value_controls_8.

    TYPES:
      "! <p class="shorttext synchronized">Value Control Structure of PURCHASE_ORDER_TYPE</p>
      BEGIN OF tys_value_controls_9,
        "! CREATION_DATE
        creation_date             TYPE /iwbep/v4_value_control,
        "! PURCHASE_ORDER_DATE
        purchase_order_date       TYPE /iwbep/v4_value_control,
        "! LAST_CHANGE_DATE_TIME
        last_change_date_time     TYPE /iwbep/v4_value_control,
        "! VALIDITY_START_DATE
        validity_start_date       TYPE /iwbep/v4_value_control,
        "! VALIDITY_END_DATE
        validity_end_date         TYPE /iwbep/v4_value_control,
        "! QUOTATION_SUBMISSION_DATE
        quotation_submission_date TYPE /iwbep/v4_value_control,
        "! DOWN_PAYMENT_DUE_DATE
        down_payment_due_date     TYPE /iwbep/v4_value_control,
        "! PURCHASE_ORDER_ITEM
        purchase_order_item       TYPE /iwbep/v4_value_control,
        "! PURCHASE_ORDER_NOTE
        purchase_order_note       TYPE /iwbep/v4_value_control,
        "! PURCHASE_ORDER_PARTNER
        purchase_order_partner    TYPE /iwbep/v4_value_control,
      END OF tys_value_controls_9.

    TYPES:
      "! <p class="shorttext synchronized">Value Control Structure of POINVOICING_PLAN_ITEM_TYPE</p>
      BEGIN OF tys_value_controls_10,
        "! INVOICING_PLAN_SETTLEMENT
        invoicing_plan_settlement  TYPE /iwbep/v4_value_control,
        "! INVOICING_PLAN_SETTLEMEN_2
        invoicing_plan_settlemen_2 TYPE /iwbep/v4_value_control,
        "! INVOICING_PLAN_INVOICING_D
        invoicing_plan_invoicing_d TYPE /iwbep/v4_value_control,
      END OF tys_value_controls_10.

    TYPES:
      "! <p class="shorttext synchronized">POInvoicingPlanItem_Type</p>
      BEGIN OF tys_poinvoicing_plan_item_type,
        "! <em>Value Control Structure</em>
        value_controls             TYPE tys_value_controls_10,
        "! <em>Key property</em> PurchaseOrder
        purchase_order             TYPE c LENGTH 10,
        "! <em>Key property</em> PurchaseOrderItem
        purchase_order_item        TYPE c LENGTH 5,
        "! <em>Key property</em> InvoicingPlanItem
        invoicing_plan_item        TYPE c LENGTH 6,
        "! <em>Key property</em> InvoicingPlan
        invoicing_plan             TYPE c LENGTH 10,
        "! InvoicingPlanSettlementFromDte
        invoicing_plan_settlement  TYPE datn,
        "! InvoicingPlanSettlementToDte
        invoicing_plan_settlemen_2 TYPE datn,
        "! InvoicingPlanInvoicingDate
        invoicing_plan_invoicing_d TYPE datn,
        "! InvoicingPlanAmount
        invoicing_plan_amount      TYPE decfloat16,
        "! TransactionCurrency
        transaction_currency       TYPE c LENGTH 3,
        "! PurchasingOrganization
        purchasing_organization    TYPE c LENGTH 4,
        "! PurchasingGroup
        purchasing_group           TYPE c LENGTH 3,
        "! PurchaseOrderType
        purchase_order_type        TYPE c LENGTH 4,
        "! Plant
        plant                      TYPE c LENGTH 4,
        "! SAP__Messages
        sap_messages               TYPE tyt_sap_message,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_poinvoicing_plan_item_type,
      "! <p class="shorttext synchronized">List of POInvoicingPlanItem_Type</p>
      tyt_poinvoicing_plan_item_type TYPE STANDARD TABLE OF tys_poinvoicing_plan_item_type WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">POSubcontractingComponent_Type</p>
      BEGIN OF tys_posubcontracting_compone_2,
        "! <em>Value Control Structure</em>
        value_controls             TYPE tys_value_controls_6,
        "! <em>Key property</em> PurchaseOrder
        purchase_order             TYPE c LENGTH 10,
        "! <em>Key property</em> PurchaseOrderItem
        purchase_order_item        TYPE c LENGTH 5,
        "! <em>Key property</em> ScheduleLine
        schedule_line              TYPE c LENGTH 4,
        "! <em>Key property</em> ReservationItem
        reservation_item           TYPE c LENGTH 4,
        "! <em>Key property</em> RecordType
        record_type                TYPE c LENGTH 1,
        "! Material
        material                   TYPE c LENGTH 18,
        "! IsMaterialProvision
        is_material_provision      TYPE abap_bool,
        "! MaterialProvisionType
        material_provision_type    TYPE c LENGTH 1,
        "! MaterialQtyToBaseQtyNmrtr
        material_qty_to_base_qty_n TYPE p LENGTH 3 DECIMALS 0,
        "! MaterialQtyToBaseQtyDnmntr
        material_qty_to_base_qty_d TYPE p LENGTH 3 DECIMALS 0,
        "! MaterialRevisionLevel
        material_revision_level    TYPE c LENGTH 2,
        "! MaterialCompIsVariableSized
        material_comp_is_variable  TYPE abap_bool,
        "! MaterialComponentIsPhantomItem
        material_component_is_phan TYPE abap_bool,
        "! Reservation
        reservation                TYPE c LENGTH 10,
        "! RequiredQuantity
        required_quantity          TYPE p LENGTH 7 DECIMALS 3,
        "! RequirementDate
        requirement_date           TYPE datn,
        "! RequirementTime
        requirement_time           TYPE timn,
        "! ReservationIsFinallyIssued
        reservation_is_finally_iss TYPE abap_bool,
        "! BaseUnit
        base_unit                  TYPE c LENGTH 3,
        "! QuantityInEntryUnit
        quantity_in_entry_unit     TYPE p LENGTH 7 DECIMALS 3,
        "! EntryUnit
        entry_unit                 TYPE c LENGTH 3,
        "! VariableSizeItemQuantity
        variable_size_item_quantit TYPE p LENGTH 7 DECIMALS 3,
        "! VariableSizeItemUnit
        variable_size_item_unit    TYPE c LENGTH 3,
        "! VariableSizeComponentUnit
        variable_size_component_un TYPE c LENGTH 3,
        "! VariableSizeComponentQuantity
        variable_size_component_qu TYPE p LENGTH 7 DECIMALS 3,
        "! UnitOfMeasureForSize1To3
        unit_of_measure_for_size_1 TYPE c LENGTH 3,
        "! Size1
        size_1                     TYPE p LENGTH 7 DECIMALS 3,
        "! Size2
        size_2                     TYPE p LENGTH 7 DECIMALS 3,
        "! Size3
        size_3                     TYPE p LENGTH 7 DECIMALS 3,
        "! Plant
        plant                      TYPE c LENGTH 4,
        "! LatestRequirementDate
        latest_requirement_date    TYPE datn,
        "! OrderLevelValue
        order_level_value          TYPE c LENGTH 2,
        "! OrderPathValue
        order_path_value           TYPE c LENGTH 2,
        "! BillOfMaterialItemNumber
        bill_of_material_item_numb TYPE c LENGTH 4,
        "! MatlCompFreeDefinedAttribute
        matl_comp_free_defined_att TYPE c LENGTH 10,
        "! BOMItemCategory
        bomitem_category           TYPE c LENGTH 1,
        "! IsBulkMaterialComponent
        is_bulk_material_component TYPE abap_bool,
        "! AccountAssignmentCategory
        account_assignment_categor TYPE c LENGTH 1,
        "! InventorySpecialStockType
        inventory_special_stock_ty TYPE c LENGTH 1,
        "! ConsumptionPosting
        consumption_posting        TYPE c LENGTH 1,
        "! InventorySpecialStockValnType
        inventory_special_stock_va TYPE c LENGTH 1,
        "! DebitCreditCode
        debit_credit_code          TYPE c LENGTH 1,
        "! WithdrawnQuantity
        withdrawn_quantity         TYPE p LENGTH 7 DECIMALS 3,
        "! QuantityIsFixed
        quantity_is_fixed          TYPE abap_bool,
        "! ComponentScrapInPercent
        component_scrap_in_percent TYPE p LENGTH 3 DECIMALS 2,
        "! OperationScrapInPercent
        operation_scrap_in_percent TYPE p LENGTH 3 DECIMALS 2,
        "! IsNetScrap
        is_net_scrap               TYPE abap_bool,
        "! LeadTimeOffset
        lead_time_offset           TYPE p LENGTH 2 DECIMALS 0,
        "! QuantityDistributionKey
        quantity_distribution_key  TYPE c LENGTH 4,
        "! FormulaKey
        formula_key                TYPE c LENGTH 2,
        "! StorageLocation
        storage_location           TYPE c LENGTH 4,
        "! ProductionSupplyArea
        production_supply_area     TYPE c LENGTH 10,
        "! Batch
        batch                      TYPE c LENGTH 10,
        "! BOMItemDescription
        bomitem_description        TYPE c LENGTH 40,
        "! BOMItemText2
        bomitem_text_2             TYPE c LENGTH 40,
        "! ChangeNumber
        change_number              TYPE c LENGTH 12,
        "! SAP__Messages
        sap_messages               TYPE tyt_sap_message,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_posubcontracting_compone_2,
      "! <p class="shorttext synchronized">List of POSubcontractingComponent_Type</p>
      tyt_posubcontracting_compone_2 TYPE STANDARD TABLE OF tys_posubcontracting_compone_2 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">PurchaseOrderAccountAssignment_Type</p>
      BEGIN OF tys_purchase_order_account_a_2,
        "! <em>Value Control Structure</em>
        value_controls             TYPE tys_value_controls_8,
        "! <em>Key property</em> PurchaseOrder
        purchase_order             TYPE c LENGTH 10,
        "! <em>Key property</em> PurchaseOrderItem
        purchase_order_item        TYPE c LENGTH 5,
        "! <em>Key property</em> AccountAssignmentNumber
        account_assignment_number  TYPE c LENGTH 2,
        "! CostCenter
        cost_center                TYPE c LENGTH 10,
        "! MasterFixedAsset
        master_fixed_asset         TYPE c LENGTH 12,
        "! ProjectNetwork
        project_network            TYPE c LENGTH 12,
        "! NetworkActivity
        network_activity           TYPE c LENGTH 4,
        "! OrderQuantityUnit
        order_quantity_unit        TYPE c LENGTH 3,
        "! Quantity
        quantity                   TYPE p LENGTH 7 DECIMALS 3,
        "! MultipleAcctAssgmtDistrPercent
        multiple_acct_assgmt_distr TYPE p LENGTH 2 DECIMALS 1,
        "! DocumentCurrency
        document_currency          TYPE c LENGTH 3,
        "! PurgDocNetAmount
        purg_doc_net_amount        TYPE decfloat16,
        "! IsDeleted
        is_deleted                 TYPE abap_bool,
        "! GLAccount
        glaccount                  TYPE c LENGTH 10,
        "! BusinessArea
        business_area              TYPE c LENGTH 4,
        "! SalesOrder
        sales_order                TYPE c LENGTH 10,
        "! SalesOrderItem
        sales_order_item           TYPE c LENGTH 6,
        "! SalesOrderScheduleLine
        sales_order_schedule_line  TYPE c LENGTH 4,
        "! FixedAsset
        fixed_asset                TYPE c LENGTH 4,
        "! OrderID
        order_id                   TYPE c LENGTH 12,
        "! UnloadingPointName
        unloading_point_name       TYPE c LENGTH 25,
        "! ControllingArea
        controlling_area           TYPE c LENGTH 4,
        "! CostObject
        cost_object                TYPE c LENGTH 12,
        "! ProfitCenter
        profit_center              TYPE c LENGTH 10,
        "! WBSElementInternalID
        wbselement_internal_id     TYPE c LENGTH 8,
        "! WBSElementExternalID
        wbselement_external_id     TYPE c LENGTH 24,
        "! ProjectNetworkInternalID
        project_network_internal_i TYPE c LENGTH 10,
        "! CommitmentItemShortID
        commitment_item_short_id   TYPE c LENGTH 14,
        "! FundsCenter
        funds_center               TYPE c LENGTH 16,
        "! Fund
        fund                       TYPE c LENGTH 10,
        "! FunctionalArea
        functional_area            TYPE c LENGTH 16,
        "! GoodsRecipientName
        goods_recipient_name       TYPE c LENGTH 12,
        "! IsFinallyInvoiced
        is_finally_invoiced        TYPE abap_bool,
        "! NetworkActivityInternalID
        network_activity_internal  TYPE c LENGTH 8,
        "! PartnerAccountNumber
        partner_account_number     TYPE c LENGTH 10,
        "! JointVentureRecoveryCode
        joint_venture_recovery_cod TYPE c LENGTH 2,
        "! SettlementReferenceDate
        settlement_reference_date  TYPE datn,
        "! OrderInternalID
        order_internal_id          TYPE c LENGTH 10,
        "! OrderIntBillOfOperationsItem
        order_int_bill_of_operatio TYPE c LENGTH 8,
        "! TaxCode
        tax_code                   TYPE c LENGTH 2,
        "! TaxJurisdiction
        tax_jurisdiction           TYPE c LENGTH 15,
        "! NonDeductibleInputTaxAmount
        non_deductible_input_tax_a TYPE decfloat16,
        "! CostCtrActivityType
        cost_ctr_activity_type     TYPE c LENGTH 6,
        "! BusinessProcess
        business_process           TYPE c LENGTH 12,
        "! GrantID
        grant_id                   TYPE c LENGTH 20,
        "! BudgetPeriod
        budget_period              TYPE c LENGTH 10,
        "! EarmarkedFundsDocument
        earmarked_funds_document   TYPE c LENGTH 10,
        "! EarmarkedFundsDocumentItem
        earmarked_funds_document_i TYPE c LENGTH 3,
        "! ValidityDate
        validity_date              TYPE datn,
        "! ChartOfAccounts
        chart_of_accounts          TYPE c LENGTH 4,
        "! ServiceDocumentType
        service_document_type      TYPE c LENGTH 4,
        "! ServiceDocument
        service_document           TYPE c LENGTH 10,
        "! ServiceDocumentItem
        service_document_item      TYPE c LENGTH 6,
        "! CreationDate
        creation_date              TYPE datn,
        "! IsAcctLineFinal
        is_acct_line_final         TYPE abap_bool,
        "! AcctLineFinalReason
        acct_line_final_reason     TYPE c LENGTH 2,
        "! CompanyCode
        company_code               TYPE c LENGTH 4,
        "! SAP__Messages
        sap_messages               TYPE tyt_sap_message,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_purchase_order_account_a_2,
      "! <p class="shorttext synchronized">List of PurchaseOrderAccountAssignment_Type</p>
      tyt_purchase_order_account_a_2 TYPE STANDARD TABLE OF tys_purchase_order_account_a_2 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">PurchaseOrderInvoicingPlan_Type</p>
      BEGIN OF tys_purchase_order_invoicing_3,
        "! <em>Value Control Structure</em>
        value_controls             TYPE tys_value_controls_4,
        "! <em>Key property</em> PurchaseOrder
        purchase_order             TYPE c LENGTH 10,
        "! <em>Key property</em> PurchaseOrderItem
        purchase_order_item        TYPE c LENGTH 5,
        "! <em>Key property</em> InvoicingPlan
        invoicing_plan             TYPE c LENGTH 10,
        "! InvoicingPlanType
        invoicing_plan_type        TYPE c LENGTH 2,
        "! InvoicingPlanStartDate
        invoicing_plan_start_date  TYPE datn,
        "! InvoicingPlanEndDate
        invoicing_plan_end_date    TYPE datn,
        "! InvoicingPlanNextInvcDateRule
        invoicing_plan_next_invc_d TYPE c LENGTH 2,
        "! PurchasingOrganization
        purchasing_organization    TYPE c LENGTH 4,
        "! PurchasingGroup
        purchasing_group           TYPE c LENGTH 3,
        "! PurchaseOrderType
        purchase_order_type        TYPE c LENGTH 4,
        "! Plant
        plant                      TYPE c LENGTH 4,
        "! SAP__Messages
        sap_messages               TYPE tyt_sap_message,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_purchase_order_invoicing_3,
      "! <p class="shorttext synchronized">List of PurchaseOrderInvoicingPlan_Type</p>
      tyt_purchase_order_invoicing_3 TYPE STANDARD TABLE OF tys_purchase_order_invoicing_3 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">PurchaseOrderItemNote_Type</p>
      BEGIN OF tys_purchase_order_item_note_t,
        "! <em>Key property</em> PurchaseOrder
        purchase_order             TYPE c LENGTH 10,
        "! <em>Key property</em> PurchaseOrderItem
        purchase_order_item        TYPE c LENGTH 5,
        "! <em>Key property</em> TextObjectType
        text_object_type           TYPE c LENGTH 4,
        "! <em>Key property</em> Language
        language                   TYPE c LENGTH 2,
        "! PlainLongText
        plain_long_text            TYPE string,
        "! PurchaseOrderItemUniqueID
        purchase_order_item_unique TYPE c LENGTH 15,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_purchase_order_item_note_t,
      "! <p class="shorttext synchronized">List of PurchaseOrderItemNote_Type</p>
      tyt_purchase_order_item_note_t TYPE STANDARD TABLE OF tys_purchase_order_item_note_t WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">PurchaseOrderItem_Type</p>
      BEGIN OF tys_purchase_order_item_type,
        "! <em>Value Control Structure</em>
        value_controls             TYPE tys_value_controls_2,
        "! <em>Key property</em> PurchaseOrder
        purchase_order             TYPE c LENGTH 10,
        "! <em>Key property</em> PurchaseOrderItem
        purchase_order_item        TYPE c LENGTH 5,
        "! PurchaseOrderCategory
        purchase_order_category    TYPE c LENGTH 1,
        "! DocumentCurrency
        document_currency          TYPE c LENGTH 3,
        "! PurchasingDocumentDeletionCode
        purchasing_document_deleti TYPE c LENGTH 1,
        "! MaterialGroup
        material_group             TYPE c LENGTH 9,
        "! Material
        material                   TYPE c LENGTH 18,
        "! MaterialType
        material_type              TYPE c LENGTH 4,
        "! SupplierMaterialNumber
        supplier_material_number   TYPE c LENGTH 35,
        "! SupplierSubrange
        supplier_subrange          TYPE c LENGTH 6,
        "! ManufacturerPartNmbr
        manufacturer_part_nmbr     TYPE c LENGTH 40,
        "! Manufacturer
        manufacturer               TYPE c LENGTH 10,
        "! ManufacturerMaterial
        manufacturer_material      TYPE c LENGTH 18,
        "! PurchaseOrderItemText
        purchase_order_item_text   TYPE c LENGTH 40,
        "! ProductTypeCode
        product_type_code          TYPE c LENGTH 2,
        "! CompanyCode
        company_code               TYPE c LENGTH 4,
        "! Plant
        plant                      TYPE c LENGTH 4,
        "! ManualDeliveryAddressID
        manual_delivery_address_id TYPE c LENGTH 10,
        "! ReferenceDeliveryAddressID
        reference_delivery_address TYPE c LENGTH 10,
        "! Customer
        customer                   TYPE c LENGTH 10,
        "! Subcontractor
        subcontractor              TYPE c LENGTH 10,
        "! SupplierIsSubcontractor
        supplier_is_subcontractor  TYPE abap_bool,
        "! CrossPlantConfigurableProduct
        cross_plant_configurable_p TYPE c LENGTH 18,
        "! ArticleCategory
        article_category           TYPE c LENGTH 2,
        "! PlndOrderReplnmtElmntType
        plnd_order_replnmt_elmnt_t TYPE c LENGTH 1,
        "! ProductPurchasePointsQtyUnit
        product_purchase_points_qt TYPE c LENGTH 3,
        "! ProductPurchasePointsQty
        product_purchase_points__2 TYPE p LENGTH 7 DECIMALS 3,
        "! StorageLocation
        storage_location           TYPE c LENGTH 4,
        "! PurchaseOrderQuantityUnit
        purchase_order_quantity_un TYPE c LENGTH 3,
        "! OrderItemQtyToBaseQtyNmrtr
        order_item_qty_to_base_qty TYPE p LENGTH 3 DECIMALS 0,
        "! OrderItemQtyToBaseQtyDnmntr
        order_item_qty_to_base_q_2 TYPE p LENGTH 3 DECIMALS 0,
        "! NetPriceQuantity
        net_price_quantity         TYPE p LENGTH 3 DECIMALS 0,
        "! IsCompletelyDelivered
        is_completely_delivered    TYPE abap_bool,
        "! IsFinallyInvoiced
        is_finally_invoiced        TYPE abap_bool,
        "! GoodsReceiptIsExpected
        goods_receipt_is_expected  TYPE abap_bool,
        "! InvoiceIsExpected
        invoice_is_expected        TYPE abap_bool,
        "! IsOrderAcknRqd
        is_order_ackn_rqd          TYPE abap_bool,
        "! InvoiceIsGoodsReceiptBased
        invoice_is_goods_receipt_b TYPE abap_bool,
        "! PurchaseContract
        purchase_contract          TYPE c LENGTH 10,
        "! PurchaseContractItem
        purchase_contract_item     TYPE c LENGTH 5,
        "! PurchaseRequisition
        purchase_requisition       TYPE c LENGTH 10,
        "! PurchaseRequisitionItem
        purchase_requisition_item  TYPE c LENGTH 5,
        "! RequirementTracking
        requirement_tracking       TYPE c LENGTH 10,
        "! SupplierQuotation
        supplier_quotation         TYPE c LENGTH 10,
        "! SupplierQuotationItem
        supplier_quotation_item    TYPE c LENGTH 5,
        "! EvaldRcptSettlmtIsAllowed
        evald_rcpt_settlmt_is_allo TYPE abap_bool,
        "! UnlimitedOverdeliveryIsAllowed
        unlimited_overdelivery_is  TYPE abap_bool,
        "! OverdelivTolrtdLmtRatioInPct
        overdeliv_tolrtd_lmt_ratio TYPE p LENGTH 2 DECIMALS 1,
        "! UnderdelivTolrtdLmtRatioInPct
        underdeliv_tolrtd_lmt_rati TYPE p LENGTH 2 DECIMALS 1,
        "! RequisitionerName
        requisitioner_name         TYPE c LENGTH 12,
        "! PlannedDeliveryDurationInDays
        planned_delivery_duration  TYPE p LENGTH 2 DECIMALS 0,
        "! GoodsReceiptDurationInDays
        goods_receipt_duration_in  TYPE p LENGTH 2 DECIMALS 0,
        "! PartialDeliveryIsAllowed
        partial_delivery_is_allowe TYPE c LENGTH 1,
        "! ConsumptionPosting
        consumption_posting        TYPE c LENGTH 1,
        "! ServicePerformer
        service_performer          TYPE c LENGTH 10,
        "! ServicePackage
        service_package            TYPE c LENGTH 10,
        "! BaseUnit
        base_unit                  TYPE c LENGTH 3,
        "! PurchaseOrderItemCategory
        purchase_order_item_catego TYPE c LENGTH 1,
        "! ProfitCenter
        profit_center              TYPE c LENGTH 10,
        "! OrderPriceUnit
        order_price_unit           TYPE c LENGTH 3,
        "! ItemVolumeUnit
        item_volume_unit           TYPE c LENGTH 3,
        "! ItemWeightUnit
        item_weight_unit           TYPE c LENGTH 3,
        "! MultipleAcctAssgmtDistribution
        multiple_acct_assgmt_distr TYPE c LENGTH 1,
        "! PartialInvoiceDistribution
        partial_invoice_distributi TYPE c LENGTH 1,
        "! PricingDateControl
        pricing_date_control       TYPE c LENGTH 1,
        "! IsStatisticalItem
        is_statistical_item        TYPE abap_bool,
        "! PurchasingParentItem
        purchasing_parent_item     TYPE c LENGTH 5,
        "! GoodsReceiptLatestCreationDate
        goods_receipt_latest_creat TYPE datn,
        "! IsReturnsItem
        is_returns_item            TYPE abap_bool,
        "! PurchasingOrderReason
        purchasing_order_reason    TYPE c LENGTH 3,
        "! IncotermsClassification
        incoterms_classification   TYPE c LENGTH 3,
        "! IncotermsTransferLocation
        incoterms_transfer_locatio TYPE c LENGTH 28,
        "! IncotermsLocation1
        incoterms_location_1       TYPE c LENGTH 70,
        "! IncotermsLocation2
        incoterms_location_2       TYPE c LENGTH 70,
        "! PriorSupplier
        prior_supplier             TYPE c LENGTH 10,
        "! InternationalArticleNumber
        international_article_numb TYPE c LENGTH 18,
        "! IntrastatServiceCode
        intrastat_service_code     TYPE c LENGTH 30,
        "! CommodityCode
        commodity_code             TYPE c LENGTH 30,
        "! MaterialFreightGroup
        material_freight_group     TYPE c LENGTH 8,
        "! DiscountInKindEligibility
        discount_in_kind_eligibili TYPE c LENGTH 1,
        "! PurgItemIsBlockedForDelivery
        purg_item_is_blocked_for_d TYPE abap_bool,
        "! SupplierConfirmationControlKey
        supplier_confirmation_cont TYPE c LENGTH 4,
        "! PurgDocOrderAcknNumber
        purg_doc_order_ackn_number TYPE c LENGTH 20,
        "! PriceIsToBePrinted
        price_is_to_be_printed     TYPE abap_bool,
        "! AccountAssignmentCategory
        account_assignment_categor TYPE c LENGTH 1,
        "! PurchasingInfoRecord
        purchasing_info_record     TYPE c LENGTH 10,
        "! NetAmount
        net_amount                 TYPE decfloat16,
        "! GrossAmount
        gross_amount               TYPE decfloat16,
        "! EffectiveAmount
        effective_amount           TYPE decfloat16,
        "! Subtotal1Amount
        subtotal_1_amount          TYPE decfloat16,
        "! Subtotal2Amount
        subtotal_2_amount          TYPE decfloat16,
        "! Subtotal3Amount
        subtotal_3_amount          TYPE decfloat16,
        "! Subtotal4Amount
        subtotal_4_amount          TYPE decfloat16,
        "! Subtotal5Amount
        subtotal_5_amount          TYPE decfloat16,
        "! Subtotal6Amount
        subtotal_6_amount          TYPE decfloat16,
        "! OrderQuantity
        order_quantity             TYPE p LENGTH 7 DECIMALS 3,
        "! NetPriceAmount
        net_price_amount           TYPE decfloat16,
        "! ItemVolume
        item_volume                TYPE p LENGTH 7 DECIMALS 3,
        "! ItemGrossWeight
        item_gross_weight          TYPE p LENGTH 7 DECIMALS 3,
        "! ItemNetWeight
        item_net_weight            TYPE p LENGTH 7 DECIMALS 3,
        "! OrderPriceUnitToOrderUnitNmrtr
        order_price_unit_to_order  TYPE p LENGTH 3 DECIMALS 0,
        "! OrdPriceUnitToOrderUnitDnmntr
        ord_price_unit_to_order_un TYPE p LENGTH 3 DECIMALS 0,
        "! GoodsReceiptIsNonValuated
        goods_receipt_is_non_valua TYPE abap_bool,
        "! IsToBeAcceptedAtOrigin
        is_to_be_accepted_at_origi TYPE abap_bool,
        "! TaxCode
        tax_code                   TYPE c LENGTH 2,
        "! TaxJurisdiction
        tax_jurisdiction           TYPE c LENGTH 15,
        "! TaxCountry
        tax_country                TYPE c LENGTH 3,
        "! TaxDeterminationDate
        tax_determination_date     TYPE datn,
        "! ShippingInstruction
        shipping_instruction       TYPE c LENGTH 2,
        "! NonDeductibleInputTaxAmount
        non_deductible_input_tax_a TYPE decfloat16,
        "! StockType
        stock_type                 TYPE c LENGTH 1,
        "! ValuationType
        valuation_type             TYPE c LENGTH 10,
        "! ValuationCategory
        valuation_category         TYPE c LENGTH 1,
        "! ItemIsRejectedBySupplier
        item_is_rejected_by_suppli TYPE abap_bool,
        "! PurgDocPriceDate
        purg_doc_price_date        TYPE datn,
        "! PurchasingInfoRecordUpdateCode
        purchasing_info_record_upd TYPE c LENGTH 1,
        "! InventorySpecialStockType
        inventory_special_stock_ty TYPE c LENGTH 1,
        "! DeliveryDocumentType
        delivery_document_type     TYPE c LENGTH 4,
        "! IssuingStorageLocation
        issuing_storage_location   TYPE c LENGTH 4,
        "! AllocationTable
        allocation_table           TYPE c LENGTH 10,
        "! AllocationTableItem
        allocation_table_item      TYPE c LENGTH 5,
        "! RetailPromotion
        retail_promotion           TYPE c LENGTH 10,
        "! PurgConfigurableItemNumber
        purg_configurable_item_num TYPE c LENGTH 40,
        "! PurgDocAggrgdSubitemCategory
        purg_doc_aggrgd_subitem_ca TYPE c LENGTH 1,
        "! PurgExternalSortNumber
        purg_external_sort_number  TYPE c LENGTH 5,
        "! Batch
        batch                      TYPE c LENGTH 10,
        "! PurchasingItemIsFreeOfCharge
        purchasing_item_is_free_of TYPE abap_bool,
        "! DownPaymentType
        down_payment_type          TYPE c LENGTH 4,
        "! DownPaymentPercentageOfTotAmt
        down_payment_percentage_of TYPE p LENGTH 3 DECIMALS 2,
        "! DownPaymentAmount
        down_payment_amount        TYPE decfloat16,
        "! DownPaymentDueDate
        down_payment_due_date      TYPE datn,
        "! ExpectedOverallLimitAmount
        expected_overall_limit_amo TYPE decfloat16,
        "! OverallLimitAmount
        overall_limit_amount       TYPE decfloat16,
        "! PurContractForOverallLimit
        pur_contract_for_overall_l TYPE c LENGTH 10,
        "! PurContractItemForOverallLimit
        pur_contract_item_for_over TYPE c LENGTH 5,
        "! PurgProdCmplncSupplierStatus
        purg_prod_cmplnc_supplier  TYPE c LENGTH 1,
        "! PurgProductMarketabilityStatus
        purg_product_marketability TYPE c LENGTH 1,
        "! PurgSafetyDataSheetStatus
        purg_safety_data_sheet_sta TYPE c LENGTH 1,
        "! PurgProdCmplncDngrsGoodsStatus
        purg_prod_cmplnc_dngrs_goo TYPE c LENGTH 1,
        "! BR_MaterialOrigin
        br_material_origin         TYPE c LENGTH 1,
        "! BR_MaterialUsage
        br_material_usage          TYPE c LENGTH 1,
        "! BR_CFOPCategory
        br_cfopcategory            TYPE c LENGTH 2,
        "! BR_NCM
        br_ncm                     TYPE c LENGTH 16,
        "! ConsumptionTaxCtrlCode
        consumption_tax_ctrl_code  TYPE c LENGTH 16,
        "! BR_IsProducedInHouse
        br_is_produced_in_house    TYPE abap_bool,
        "! ProductSeasonYear
        product_season_year        TYPE c LENGTH 4,
        "! ProductSeason
        product_season             TYPE c LENGTH 10,
        "! ProductCollection
        product_collection         TYPE c LENGTH 10,
        "! ProductTheme
        product_theme              TYPE c LENGTH 10,
        "! SeasonCompletenessStatus
        season_completeness_status TYPE c LENGTH 1,
        "! ShippingGroupRule
        shipping_group_rule        TYPE c LENGTH 4,
        "! ShippingGroupNumber
        shipping_group_number      TYPE c LENGTH 10,
        "! ProductCharacteristic1
        product_characteristic_1   TYPE c LENGTH 18,
        "! ProductCharacteristic2
        product_characteristic_2   TYPE c LENGTH 18,
        "! ProductCharacteristic3
        product_characteristic_3   TYPE c LENGTH 18,
        "! PurgDocSubitemCategory
        purg_doc_subitem_category  TYPE c LENGTH 1,
        "! DiversionStatus
        diversion_status           TYPE c LENGTH 1,
        "! ReferenceDocumentNumber
        reference_document_number  TYPE c LENGTH 10,
        "! ReferenceDocumentItem
        reference_document_item    TYPE c LENGTH 6,
        "! PurchaseOrderReferenceType
        purchase_order_reference_t TYPE c LENGTH 1,
        "! ItemHasValueAddedService
        item_has_value_added_servi TYPE abap_bool,
        "! ValAddedSrvcParentItmNumber
        val_added_srvc_parent_itm  TYPE c LENGTH 5,
        "! StockSegment
        stock_segment              TYPE c LENGTH 40,
        "! SAP__Messages
        sap_messages               TYPE tyt_sap_message,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_purchase_order_item_type,
      "! <p class="shorttext synchronized">List of PurchaseOrderItem_Type</p>
      tyt_purchase_order_item_type TYPE STANDARD TABLE OF tys_purchase_order_item_type WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">PurchaseOrderNote_Type</p>
      BEGIN OF tys_purchase_order_note_type,
        "! <em>Key property</em> PurchaseOrder
        purchase_order   TYPE c LENGTH 10,
        "! <em>Key property</em> TextObjectType
        text_object_type TYPE c LENGTH 4,
        "! <em>Key property</em> Language
        language         TYPE c LENGTH 2,
        "! PlainLongText
        plain_long_text  TYPE string,
        "! odata.etag
        etag             TYPE string,
      END OF tys_purchase_order_note_type,
      "! <p class="shorttext synchronized">List of PurchaseOrderNote_Type</p>
      tyt_purchase_order_note_type TYPE STANDARD TABLE OF tys_purchase_order_note_type WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">PurchaseOrderPartner_Type</p>
      BEGIN OF tys_purchase_order_partner_typ,
        "! <em>Value Control Structure</em>
        value_controls             TYPE tys_value_controls_3,
        "! <em>Key property</em> PurchaseOrder
        purchase_order             TYPE c LENGTH 10,
        "! <em>Key property</em> PartnerFunction
        partner_function           TYPE c LENGTH 2,
        "! SupplierSubrange
        supplier_subrange          TYPE c LENGTH 6,
        "! Plant
        plant                      TYPE c LENGTH 4,
        "! PurchasingOrganization
        purchasing_organization    TYPE c LENGTH 4,
        "! PartnerCounter
        partner_counter            TYPE c LENGTH 3,
        "! CreatedByUser
        created_by_user            TYPE c LENGTH 12,
        "! CreationDate
        creation_date              TYPE datn,
        "! PurchasingDocumentPartnerType
        purchasing_document_partne TYPE c LENGTH 2,
        "! Supplier
        supplier                   TYPE c LENGTH 10,
        "! SupplierHierarchyCategory
        supplier_hierarchy_categor TYPE c LENGTH 1,
        "! SupplierContact
        supplier_contact           TYPE c LENGTH 10,
        "! PersonWorkAgreement
        person_work_agreement      TYPE c LENGTH 8,
        "! EmploymentInternalID
        employment_internal_id     TYPE c LENGTH 8,
        "! DefaultPartner
        default_partner            TYPE abap_bool,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_purchase_order_partner_typ,
      "! <p class="shorttext synchronized">List of PurchaseOrderPartner_Type</p>
      tyt_purchase_order_partner_typ TYPE STANDARD TABLE OF tys_purchase_order_partner_typ WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">PurchaseOrderScheduleLine_Type</p>
      BEGIN OF tys_purchase_order_schedule__2,
        "! <em>Value Control Structure</em>
        value_controls             TYPE tys_value_controls_5,
        "! <em>Key property</em> PurchaseOrder
        purchase_order             TYPE c LENGTH 10,
        "! <em>Key property</em> PurchaseOrderItem
        purchase_order_item        TYPE c LENGTH 5,
        "! <em>Key property</em> ScheduleLine
        schedule_line              TYPE c LENGTH 4,
        "! ScheduleLineDeliveryDate
        schedule_line_delivery_dat TYPE datn,
        "! SchedLineStscDeliveryDate
        sched_line_stsc_delivery_d TYPE datn,
        "! PerformancePeriodStartDate
        performance_period_start_d TYPE datn,
        "! PerformancePeriodEndDate
        performance_period_end_dat TYPE datn,
        "! ScheduleLineDeliveryTime
        schedule_line_delivery_tim TYPE timn,
        "! Batch
        batch                      TYPE c LENGTH 10,
        "! BatchBySupplier
        batch_by_supplier          TYPE c LENGTH 15,
        "! ScheduleLineOrderQuantity
        schedule_line_order_quanti TYPE p LENGTH 7 DECIMALS 3,
        "! OpenPurchaseOrderQuantity
        open_purchase_order_quanti TYPE p LENGTH 8 DECIMALS 3,
        "! PurchaseOrderQuantityUnit
        purchase_order_quantity_un TYPE c LENGTH 3,
        "! Currency
        currency                   TYPE c LENGTH 3,
        "! PurchaseRequisition
        purchase_requisition       TYPE c LENGTH 10,
        "! PurchaseRequisitionItem
        purchase_requisition_item  TYPE c LENGTH 5,
        "! DelivDateCategory
        deliv_date_category        TYPE c LENGTH 1,
        "! ScheduleLineOrderDate
        schedule_line_order_date   TYPE datn,
        "! ProductAvailabilityDate
        product_availability_date  TYPE datn,
        "! LoadingDate
        loading_date               TYPE datn,
        "! LoadingTime
        loading_time               TYPE timn,
        "! TransportationPlanningDate
        transportation_planning_da TYPE datn,
        "! TransportationPlanningTime
        transportation_planning_ti TYPE timn,
        "! GoodsIssueDate
        goods_issue_date           TYPE datn,
        "! GoodsIssueTime
        goods_issue_time           TYPE timn,
        "! RouteSchedule
        route_schedule             TYPE c LENGTH 10,
        "! ProductAvailabilityTime
        product_availability_time  TYPE timn,
        "! SAP__Messages
        sap_messages               TYPE tyt_sap_message,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_purchase_order_schedule__2,
      "! <p class="shorttext synchronized">List of PurchaseOrderScheduleLine_Type</p>
      tyt_purchase_order_schedule__2 TYPE STANDARD TABLE OF tys_purchase_order_schedule__2 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">PurchaseOrderSupplierAddress_Type</p>
      BEGIN OF tys_purchase_order_supplier__2,
        "! <em>Key property</em> SupplierAddressID
        supplier_address_id        TYPE c LENGTH 10,
        "! <em>Key property</em> PurchaseOrder
        purchase_order             TYPE c LENGTH 10,
        "! AddressID
        address_id                 TYPE c LENGTH 10,
        "! AddressPersonID
        address_person_id          TYPE c LENGTH 10,
        "! AddressRepresentationCode
        address_representation_cod TYPE c LENGTH 1,
        "! CorrespondenceLanguage
        correspondence_language    TYPE c LENGTH 2,
        "! PrfrdCommMediumType
        prfrd_comm_medium_type     TYPE c LENGTH 3,
        "! AddresseeFullName
        addressee_full_name        TYPE c LENGTH 80,
        "! OrganizationName1
        organization_name_1        TYPE c LENGTH 40,
        "! OrganizationName2
        organization_name_2        TYPE c LENGTH 40,
        "! OrganizationName3
        organization_name_3        TYPE c LENGTH 40,
        "! OrganizationName4
        organization_name_4        TYPE c LENGTH 40,
        "! AddressSearchTerm1
        address_search_term_1      TYPE c LENGTH 20,
        "! AddressSearchTerm2
        address_search_term_2      TYPE c LENGTH 20,
        "! CityName
        city_name                  TYPE c LENGTH 40,
        "! DistrictName
        district_name              TYPE c LENGTH 40,
        "! VillageName
        village_name               TYPE c LENGTH 40,
        "! PostalCode
        postal_code                TYPE c LENGTH 10,
        "! CompanyPostalCode
        company_postal_code        TYPE c LENGTH 10,
        "! StreetName
        street_name                TYPE c LENGTH 60,
        "! StreetPrefixName1
        street_prefix_name_1       TYPE c LENGTH 40,
        "! StreetPrefixName2
        street_prefix_name_2       TYPE c LENGTH 40,
        "! StreetSuffixName1
        street_suffix_name_1       TYPE c LENGTH 40,
        "! StreetSuffixName2
        street_suffix_name_2       TYPE c LENGTH 40,
        "! HouseNumber
        house_number               TYPE c LENGTH 10,
        "! HouseNumberSupplementText
        house_number_supplement_te TYPE c LENGTH 10,
        "! Building
        building                   TYPE c LENGTH 20,
        "! Floor
        floor                      TYPE c LENGTH 10,
        "! RoomNumber
        room_number                TYPE c LENGTH 10,
        "! Country
        country                    TYPE c LENGTH 3,
        "! Region
        region                     TYPE c LENGTH 3,
        "! FormOfAddress
        form_of_address            TYPE c LENGTH 4,
        "! TaxJurisdiction
        tax_jurisdiction           TYPE c LENGTH 15,
        "! TransportZone
        transport_zone             TYPE c LENGTH 10,
        "! POBox
        pobox                      TYPE c LENGTH 10,
        "! POBoxIsWithoutNumber
        pobox_is_without_number    TYPE abap_bool,
        "! POBoxPostalCode
        pobox_postal_code          TYPE c LENGTH 10,
        "! POBoxLobbyName
        pobox_lobby_name           TYPE c LENGTH 40,
        "! POBoxDeviatingCityName
        pobox_deviating_city_name  TYPE c LENGTH 40,
        "! POBoxDeviatingRegion
        pobox_deviating_region     TYPE c LENGTH 3,
        "! POBoxDeviatingCountry
        pobox_deviating_country    TYPE c LENGTH 3,
        "! CareOfName
        care_of_name               TYPE c LENGTH 40,
        "! DeliveryServiceTypeCode
        delivery_service_type_code TYPE c LENGTH 4,
        "! DeliveryServiceNumber
        delivery_service_number    TYPE c LENGTH 10,
        "! AddressTimeZone
        address_time_zone          TYPE c LENGTH 6,
        "! EmailAddress
        email_address              TYPE c LENGTH 241,
        "! RegionalStructureCheckStatus
        regional_structure_check_s TYPE c LENGTH 1,
        "! SAP__Messages
        sap_messages               TYPE tyt_sap_message,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_purchase_order_supplier__2,
      "! <p class="shorttext synchronized">List of PurchaseOrderSupplierAddress_Type</p>
      tyt_purchase_order_supplier__2 TYPE STANDARD TABLE OF tys_purchase_order_supplier__2 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">PurchaseOrder_Type</p>
      BEGIN OF tys_purchase_order_type,
        "! <em>Value Control Structure</em>
        value_controls             TYPE tys_value_controls_9,
        "! <em>Key property</em> PurchaseOrder
        purchase_order             TYPE c LENGTH 10,
        "! PurchaseOrderType
        purchase_order_type_2      TYPE c LENGTH 4,
        "! PurchaseOrderSubtype
        purchase_order_subtype     TYPE c LENGTH 1,
        "! PurchasingDocumentOrigin
        purchasing_document_origin TYPE c LENGTH 1,
        "! PurchasingDocumentProcessCode
        purchasing_document_proces TYPE c LENGTH 3,
        "! CreatedByUser
        created_by_user            TYPE c LENGTH 12,
        "! CreationDate
        creation_date              TYPE datn,
        "! PurchaseOrderDate
        purchase_order_date        TYPE datn,
        "! LastChangeDateTime
        last_change_date_time      TYPE timestampl,
        "! ValidityStartDate
        validity_start_date        TYPE datn,
        "! ValidityEndDate
        validity_end_date          TYPE datn,
        "! Language
        language                   TYPE c LENGTH 2,
        "! PurchaseOrderDeletionCode
        purchase_order_deletion_co TYPE c LENGTH 1,
        "! ReleaseIsNotCompleted
        release_is_not_completed   TYPE abap_bool,
        "! PurchasingCompletenessStatus
        purchasing_completeness_st TYPE abap_bool,
        "! PurchasingProcessingStatus
        purchasing_processing_stat TYPE c LENGTH 2,
        "! PurgReleaseSequenceStatus
        purg_release_sequence_stat TYPE c LENGTH 8,
        "! ReleaseCode
        release_code               TYPE c LENGTH 1,
        "! PurchasingReleaseStrategy
        purchasing_release_strateg TYPE c LENGTH 2,
        "! PurgReasonForDocCancellation
        purg_reason_for_doc_cancel TYPE c LENGTH 2,
        "! CompanyCode
        company_code               TYPE c LENGTH 4,
        "! PurchasingOrganization
        purchasing_organization    TYPE c LENGTH 4,
        "! PurchasingGroup
        purchasing_group           TYPE c LENGTH 3,
        "! Supplier
        supplier                   TYPE c LENGTH 10,
        "! ManualSupplierAddressID
        manual_supplier_address_id TYPE c LENGTH 10,
        "! SupplierAddressID
        supplier_address_id        TYPE c LENGTH 10,
        "! SupplierRespSalesPersonName
        supplier_resp_sales_person TYPE c LENGTH 30,
        "! SupplierPhoneNumber
        supplier_phone_number      TYPE c LENGTH 16,
        "! SupplyingSupplier
        supplying_supplier         TYPE c LENGTH 10,
        "! SupplyingPlant
        supplying_plant            TYPE c LENGTH 4,
        "! InvoicingParty
        invoicing_party            TYPE c LENGTH 10,
        "! Customer
        customer                   TYPE c LENGTH 10,
        "! PurchaseContract
        purchase_contract          TYPE c LENGTH 10,
        "! SupplierQuotationExternalID
        supplier_quotation_externa TYPE c LENGTH 10,
        "! QuotationSubmissionDate
        quotation_submission_date  TYPE datn,
        "! ItemNumberIntervalForSubItems
        item_number_interval_for_s TYPE c LENGTH 5,
        "! PaymentTerms
        payment_terms              TYPE c LENGTH 4,
        "! CashDiscount1Days
        cash_discount_1_days       TYPE p LENGTH 2 DECIMALS 0,
        "! CashDiscount2Days
        cash_discount_2_days       TYPE p LENGTH 2 DECIMALS 0,
        "! NetPaymentDays
        net_payment_days           TYPE p LENGTH 2 DECIMALS 0,
        "! CashDiscount1Percent
        cash_discount_1_percent    TYPE p LENGTH 3 DECIMALS 3,
        "! CashDiscount2Percent
        cash_discount_2_percent    TYPE p LENGTH 3 DECIMALS 3,
        "! DownPaymentType
        down_payment_type          TYPE c LENGTH 4,
        "! DownPaymentPercentageOfTotAmt
        down_payment_percentage_of TYPE p LENGTH 3 DECIMALS 2,
        "! DownPaymentAmount
        down_payment_amount        TYPE decfloat16,
        "! DownPaymentDueDate
        down_payment_due_date      TYPE datn,
        "! IncotermsClassification
        incoterms_classification   TYPE c LENGTH 3,
        "! IncotermsTransferLocation
        incoterms_transfer_locatio TYPE c LENGTH 28,
        "! IncotermsVersion
        incoterms_version          TYPE c LENGTH 4,
        "! IncotermsLocation1
        incoterms_location_1       TYPE c LENGTH 70,
        "! IncotermsLocation2
        incoterms_location_2       TYPE c LENGTH 70,
        "! IsIntrastatReportingRelevant
        is_intrastat_reporting_rel TYPE abap_bool,
        "! IsIntrastatReportingExcluded
        is_intrastat_reporting_exc TYPE abap_bool,
        "! CorrespncExternalReference
        correspnc_external_referen TYPE c LENGTH 12,
        "! CorrespncInternalReference
        correspnc_internal_referen TYPE c LENGTH 12,
        "! PricingDocument
        pricing_document           TYPE c LENGTH 10,
        "! PricingProcedure
        pricing_procedure          TYPE c LENGTH 6,
        "! DocumentCurrency
        document_currency          TYPE c LENGTH 3,
        "! ExchangeRate
        exchange_rate              TYPE p LENGTH 5 DECIMALS 5,
        "! ExchangeRateIsFixed
        exchange_rate_is_fixed     TYPE abap_bool,
        "! TaxReturnCountry
        tax_return_country         TYPE c LENGTH 3,
        "! VATRegistrationCountry
        vatregistration_country    TYPE c LENGTH 3,
        "! PurgAggrgdProdCmplncSuplrSts
        purg_aggrgd_prod_cmplnc_su TYPE c LENGTH 1,
        "! PurgAggrgdProdMarketabilitySts
        purg_aggrgd_prod_marketabi TYPE c LENGTH 1,
        "! PurgAggrgdSftyDataSheetStatus
        purg_aggrgd_sfty_data_shee TYPE c LENGTH 1,
        "! PurgProdCmplncTotDngrsGoodsSts
        purg_prod_cmplnc_tot_dngrs TYPE c LENGTH 1,
        "! PurchasingCollectiveNumber
        purchasing_collective_numb TYPE c LENGTH 10,
        "! SAP__Messages
        sap_messages               TYPE tyt_sap_message,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_purchase_order_type,
      "! <p class="shorttext synchronized">List of PurchaseOrder_Type</p>
      tyt_purchase_order_type TYPE STANDARD TABLE OF tys_purchase_order_type WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">PurOrderItemDeliveryAddress_Type</p>
      BEGIN OF tys_pur_order_item_delivery__2,
        "! <em>Key property</em> PurchaseOrder
        purchase_order             TYPE c LENGTH 10,
        "! <em>Key property</em> PurchaseOrderItem
        purchase_order_item        TYPE c LENGTH 5,
        "! <em>Key property</em> DeliveryAddressID
        delivery_address_id        TYPE c LENGTH 10,
        "! AddressID
        address_id                 TYPE c LENGTH 10,
        "! AddressPersonID
        address_person_id          TYPE c LENGTH 10,
        "! AddressRepresentationCode
        address_representation_cod TYPE c LENGTH 1,
        "! CorrespondenceLanguage
        correspondence_language    TYPE c LENGTH 2,
        "! PrfrdCommMediumType
        prfrd_comm_medium_type     TYPE c LENGTH 3,
        "! AddresseeFullName
        addressee_full_name        TYPE c LENGTH 80,
        "! OrganizationName1
        organization_name_1        TYPE c LENGTH 40,
        "! OrganizationName2
        organization_name_2        TYPE c LENGTH 40,
        "! OrganizationName3
        organization_name_3        TYPE c LENGTH 40,
        "! OrganizationName4
        organization_name_4        TYPE c LENGTH 40,
        "! AddressSearchTerm1
        address_search_term_1      TYPE c LENGTH 20,
        "! AddressSearchTerm2
        address_search_term_2      TYPE c LENGTH 20,
        "! CityName
        city_name                  TYPE c LENGTH 40,
        "! DistrictName
        district_name              TYPE c LENGTH 40,
        "! VillageName
        village_name               TYPE c LENGTH 40,
        "! PostalCode
        postal_code                TYPE c LENGTH 10,
        "! CompanyPostalCode
        company_postal_code        TYPE c LENGTH 10,
        "! StreetName
        street_name                TYPE c LENGTH 60,
        "! StreetPrefixName1
        street_prefix_name_1       TYPE c LENGTH 40,
        "! StreetPrefixName2
        street_prefix_name_2       TYPE c LENGTH 40,
        "! StreetSuffixName1
        street_suffix_name_1       TYPE c LENGTH 40,
        "! StreetSuffixName2
        street_suffix_name_2       TYPE c LENGTH 40,
        "! HouseNumber
        house_number               TYPE c LENGTH 10,
        "! HouseNumberSupplementText
        house_number_supplement_te TYPE c LENGTH 10,
        "! Building
        building                   TYPE c LENGTH 20,
        "! Floor
        floor                      TYPE c LENGTH 10,
        "! RoomNumber
        room_number                TYPE c LENGTH 10,
        "! Country
        country                    TYPE c LENGTH 3,
        "! Region
        region                     TYPE c LENGTH 3,
        "! FormOfAddress
        form_of_address            TYPE c LENGTH 4,
        "! TaxJurisdiction
        tax_jurisdiction           TYPE c LENGTH 15,
        "! TransportZone
        transport_zone             TYPE c LENGTH 10,
        "! POBox
        pobox                      TYPE c LENGTH 10,
        "! POBoxIsWithoutNumber
        pobox_is_without_number    TYPE abap_bool,
        "! POBoxPostalCode
        pobox_postal_code          TYPE c LENGTH 10,
        "! POBoxLobbyName
        pobox_lobby_name           TYPE c LENGTH 40,
        "! POBoxDeviatingCityName
        pobox_deviating_city_name  TYPE c LENGTH 40,
        "! POBoxDeviatingRegion
        pobox_deviating_region     TYPE c LENGTH 3,
        "! POBoxDeviatingCountry
        pobox_deviating_country    TYPE c LENGTH 3,
        "! CareOfName
        care_of_name               TYPE c LENGTH 40,
        "! DeliveryServiceTypeCode
        delivery_service_type_code TYPE c LENGTH 4,
        "! DeliveryServiceNumber
        delivery_service_number    TYPE c LENGTH 10,
        "! AddressTimeZone
        address_time_zone          TYPE c LENGTH 6,
        "! EmailAddress
        email_address              TYPE c LENGTH 241,
        "! RegionalStructureCheckStatus
        regional_structure_check_s TYPE c LENGTH 1,
        "! SAP__Messages
        sap_messages               TYPE tyt_sap_message,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_pur_order_item_delivery__2,
      "! <p class="shorttext synchronized">List of PurOrderItemDeliveryAddress_Type</p>
      tyt_pur_order_item_delivery__2 TYPE STANDARD TABLE OF tys_pur_order_item_delivery__2 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">PurOrderItemPricingElement_Type</p>
      BEGIN OF tys_pur_order_item_pricing_e_2,
        "! <em>Value Control Structure</em>
        value_controls             TYPE tys_value_controls_7,
        "! <em>Key property</em> PurchaseOrder
        purchase_order             TYPE c LENGTH 10,
        "! <em>Key property</em> PurchaseOrderItem
        purchase_order_item        TYPE c LENGTH 5,
        "! <em>Key property</em> PricingDocument
        pricing_document           TYPE c LENGTH 10,
        "! <em>Key property</em> PricingDocumentItem
        pricing_document_item      TYPE c LENGTH 6,
        "! <em>Key property</em> PricingProcedureStep
        pricing_procedure_step     TYPE c LENGTH 3,
        "! <em>Key property</em> PricingProcedureCounter
        pricing_procedure_counter  TYPE c LENGTH 3,
        "! ConditionApplication
        condition_application      TYPE c LENGTH 2,
        "! ConditionType
        condition_type             TYPE c LENGTH 4,
        "! PriceConditionDeterminationDte
        price_condition_determinat TYPE datn,
        "! ConditionCalculationType
        condition_calculation_type TYPE c LENGTH 3,
        "! ConditionBaseAmount
        condition_base_amount      TYPE p LENGTH 13 DECIMALS 9,
        "! ConditionBaseValue
        condition_base_value       TYPE p LENGTH 13 DECIMALS 9,
        "! ConditionRateAmount
        condition_rate_amount      TYPE p LENGTH 13 DECIMALS 9,
        "! ConditionRateRatio
        condition_rate_ratio       TYPE p LENGTH 13 DECIMALS 9,
        "! ConditionRateRatioUnit
        condition_rate_ratio_unit  TYPE c LENGTH 3,
        "! ConditionCurrency
        condition_currency         TYPE c LENGTH 3,
        "! PriceDetnExchangeRate
        price_detn_exchange_rate   TYPE p LENGTH 5 DECIMALS 5,
        "! ConditionQuantity
        condition_quantity         TYPE p LENGTH 3 DECIMALS 0,
        "! ConditionQuantityUnit
        condition_quantity_unit    TYPE c LENGTH 3,
        "! ConditionToBaseQtyNmrtr
        condition_to_base_qty_nmrt TYPE p LENGTH 6 DECIMALS 0,
        "! ConditionToBaseQtyDnmntr
        condition_to_base_qty_dnmn TYPE p LENGTH 6 DECIMALS 0,
        "! ConditionCategory
        condition_category         TYPE c LENGTH 1,
        "! ConditionIsForStatistics
        condition_is_for_statistic TYPE abap_bool,
        "! PricingScaleType
        pricing_scale_type         TYPE c LENGTH 1,
        "! IsRelevantForAccrual
        is_relevant_for_accrual    TYPE abap_bool,
        "! CndnIsRelevantForInvoiceList
        cndn_is_relevant_for_invoi TYPE abap_bool,
        "! ConditionOrigin
        condition_origin           TYPE c LENGTH 1,
        "! IsGroupCondition
        is_group_condition         TYPE abap_bool,
        "! AccessNumberOfAccessSequence
        access_number_of_access_se TYPE c LENGTH 3,
        "! ConditionRecord
        condition_record           TYPE c LENGTH 10,
        "! ConditionSequentialNumber
        condition_sequential_numbe TYPE c LENGTH 3,
        "! AccountKeyForGLAccount
        account_key_for_glaccount  TYPE c LENGTH 3,
        "! GLAccount
        glaccount                  TYPE c LENGTH 10,
        "! TaxCode
        tax_code                   TYPE c LENGTH 2,
        "! AcctKeyForAccrualsGLAccount
        acct_key_for_accruals_glac TYPE c LENGTH 3,
        "! AccrualsGLAccount
        accruals_glaccount         TYPE c LENGTH 10,
        "! WithholdingTaxCode
        withholding_tax_code       TYPE c LENGTH 2,
        "! FreightSupplier
        freight_supplier           TYPE c LENGTH 10,
        "! CndnRoundingOffDiffAmount
        cndn_rounding_off_diff_amo TYPE decfloat16,
        "! ConditionAmount
        condition_amount           TYPE decfloat16,
        "! TransactionCurrency
        transaction_currency       TYPE c LENGTH 3,
        "! ConditionControl
        condition_control          TYPE c LENGTH 1,
        "! ConditionInactiveReason
        condition_inactive_reason  TYPE c LENGTH 1,
        "! ConditionClass
        condition_class            TYPE c LENGTH 1,
        "! PrcgProcedureCounterForHeader
        prcg_procedure_counter_for TYPE c LENGTH 3,
        "! FactorForConditionBasisValue
        factor_for_condition_basis TYPE /iwbep/v4_float,
        "! StructureCondition
        structure_condition        TYPE c LENGTH 1,
        "! PeriodFactorForCndnBasisValue
        period_factor_for_cndn_bas TYPE /iwbep/v4_float,
        "! PricingScaleBasis
        pricing_scale_basis        TYPE c LENGTH 3,
        "! ConditionScaleBasisValue
        condition_scale_basis_valu TYPE p LENGTH 13 DECIMALS 9,
        "! ConditionScaleBasisUnit
        condition_scale_basis_unit TYPE c LENGTH 3,
        "! ConditionScaleBasisCurrency
        condition_scale_basis_curr TYPE c LENGTH 3,
        "! ConditionAlternativeCurrency
        condition_alternative_curr TYPE c LENGTH 3,
        "! ConditionAmountInLocalCrcy
        condition_amount_in_local  TYPE decfloat16,
        "! CndnIsRelevantForIntcoBilling
        cndn_is_relevant_for_intco TYPE abap_bool,
        "! ConditionIsManuallyChanged
        condition_is_manually_chan TYPE abap_bool,
        "! BillingPriceSource
        billing_price_source       TYPE c LENGTH 1,
        "! TaxJurisdictionLevel
        tax_jurisdiction_level     TYPE c LENGTH 1,
        "! ConditionByteSequence
        condition_byte_sequence    TYPE xstring,
        "! CndnIsRelevantForLimitValue
        cndn_is_relevant_for_limit TYPE abap_bool,
        "! ConditionBasisLimitExceeded
        condition_basis_limit_exce TYPE c LENGTH 1,
        "! ConditionAmountLimitExceeded
        condition_amount_limit_exc TYPE c LENGTH 1,
        "! CumulatedConditionBasisValue
        cumulated_condition_basis  TYPE p LENGTH 13 DECIMALS 9,
        "! CustomerRebateRecipient
        customer_rebate_recipient  TYPE c LENGTH 10,
        "! ConditionIsForConfiguration
        condition_is_for_configura TYPE abap_bool,
        "! VariantCondition
        variant_condition          TYPE c LENGTH 26,
        "! ConditionAcctAssgmtRelevance
        condition_acct_assgmt_rele TYPE c LENGTH 1,
        "! ConditionMatrixMaintRelevance
        condition_matrix_maint_rel TYPE c LENGTH 1,
        "! ConfigblParametersAndFormulas
        configbl_parameters_and_fo TYPE sysuuid_x16,
        "! ConditionAdjustedQuantity
        condition_adjusted_quantit TYPE p LENGTH 16 DECIMALS 14,
        "! ConditionTypeName
        condition_type_name        TYPE c LENGTH 30,
        "! ConditionBaseValueIntlUnit
        condition_base_value_intl  TYPE c LENGTH 5,
        "! ConditionBaseValueUnit
        condition_base_value_unit  TYPE c LENGTH 5,
        "! ConditionRateValueIntlUnit
        condition_rate_value_intl  TYPE c LENGTH 5,
        "! ConditionRateValueUnit
        condition_rate_value_unit  TYPE c LENGTH 5,
        "! TaxCodeName
        tax_code_name              TYPE c LENGTH 50,
        "! ConditionIsDeletable
        condition_is_deletable     TYPE abap_bool,
        "! PricingProcedure
        pricing_procedure          TYPE c LENGTH 6,
        "! SuperordinateDocument
        superordinate_document     TYPE c LENGTH 32,
        "! SuperordinateDocumentItem
        superordinate_document_ite TYPE c LENGTH 70,
        "! SAP__Messages
        sap_messages               TYPE tyt_sap_message,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_pur_order_item_pricing_e_2,
      "! <p class="shorttext synchronized">List of PurOrderItemPricingElement_Type</p>
      tyt_pur_order_item_pricing_e_2 TYPE STANDARD TABLE OF tys_pur_order_item_pricing_e_2 WITH DEFAULT KEY.


    CONSTANTS:
      "! <p class="shorttext synchronized">Internal Names of the entity sets</p>
      BEGIN OF gcs_entity_set,
        "! POSubcontractingComponent
        "! <br/> Collection of type 'POSubcontractingComponent_Type'
        posubcontracting_component TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'POSUBCONTRACTING_COMPONENT',
        "! PurchaseOrder
        "! <br/> Collection of type 'PurchaseOrder_Type'
        purchase_order             TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'PURCHASE_ORDER',
        "! PurchaseOrderAccountAssignment
        "! <br/> Collection of type 'PurchaseOrderAccountAssignment_Type'
        purchase_order_account_ass TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'PURCHASE_ORDER_ACCOUNT_ASS',
        "! PurchaseOrderInvoicingPlanItem
        "! <br/> Collection of type 'POInvoicingPlanItem_Type'
        purchase_order_invoicing_2 TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'PURCHASE_ORDER_INVOICING_2',
        "! PurchaseOrderInvoicingPlan
        "! <br/> Collection of type 'PurchaseOrderInvoicingPlan_Type'
        purchase_order_invoicing_p TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'PURCHASE_ORDER_INVOICING_P',
        "! PurchaseOrderItem
        "! <br/> Collection of type 'PurchaseOrderItem_Type'
        purchase_order_item        TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'PURCHASE_ORDER_ITEM',
        "! PurchaseOrderItemNote
        "! <br/> Collection of type 'PurchaseOrderItemNote_Type'
        purchase_order_item_note   TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'PURCHASE_ORDER_ITEM_NOTE',
        "! PurchaseOrderNote
        "! <br/> Collection of type 'PurchaseOrderNote_Type'
        purchase_order_note        TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'PURCHASE_ORDER_NOTE',
        "! PurchaseOrderPartner
        "! <br/> Collection of type 'PurchaseOrderPartner_Type'
        purchase_order_partner     TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'PURCHASE_ORDER_PARTNER',
        "! PurchaseOrderScheduleLine
        "! <br/> Collection of type 'PurchaseOrderScheduleLine_Type'
        purchase_order_schedule_li TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'PURCHASE_ORDER_SCHEDULE_LI',
        "! PurchaseOrderSupplierAddress
        "! <br/> Collection of type 'PurchaseOrderSupplierAddress_Type'
        purchase_order_supplier_ad TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'PURCHASE_ORDER_SUPPLIER_AD',
        "! PurOrderItemDeliveryAddress
        "! <br/> Collection of type 'PurOrderItemDeliveryAddress_Type'
        pur_order_item_delivery_ad TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'PUR_ORDER_ITEM_DELIVERY_AD',
        "! PurOrderItemPricingElement
        "! <br/> Collection of type 'PurOrderItemPricingElement_Type'
        pur_order_item_pricing_ele TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'PUR_ORDER_ITEM_PRICING_ELE',
      END OF gcs_entity_set .

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal Names of the bound functions</p>
      BEGIN OF gcs_bound_function,
        "! GetOutputBinaryData
        "! <em>bound against entity type</em> PurchaseOrder_Type
        get_output_binary_data TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'GET_OUTPUT_BINARY_DATA',
      END OF gcs_bound_function.

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal names for complex types</p>
      BEGIN OF gcs_complex_type,
        "! <p class="shorttext synchronized">Internal names for D_PurOrdGetOutputBinaryDataR</p>
        "! See also structure type {@link ..tys_d_pur_ord_get_output_binar}
        BEGIN OF d_pur_ord_get_output_binar,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF d_pur_ord_get_output_binar,
        "! <p class="shorttext synchronized">Internal names for SAP__Message</p>
        "! See also structure type {@link ..tys_sap_message}
        BEGIN OF sap_message,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF sap_message,
      END OF gcs_complex_type.

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal names for entity types</p>
      BEGIN OF gcs_entity_type,
        "! <p class="shorttext synchronized">Internal names for POInvoicingPlanItem_Type</p>
        "! See also structure type {@link ..tys_poinvoicing_plan_item_type}
        BEGIN OF poinvoicing_plan_item_type,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! _PurchaseOrder
            purchase_order_2           TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_2',
            "! _PurchaseOrderInvoicingPlan
            purchase_order_invoicing_p TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_INVOICING_P',
            "! _PurchaseOrderItem
            purchase_order_item_2      TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_ITEM_2',
          END OF navigation,
        END OF poinvoicing_plan_item_type,
        "! <p class="shorttext synchronized">Internal names for POSubcontractingComponent_Type</p>
        "! See also structure type {@link ..tys_posubcontracting_compone_2}
        BEGIN OF posubcontracting_compone_2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! _PurchaseOrder
            purchase_order_2      TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_2',
            "! _PurchaseOrderItem
            purchase_order_item_2 TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_ITEM_2',
            "! _ScheduleLine
            schedule_line_2       TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'SCHEDULE_LINE_2',
          END OF navigation,
        END OF posubcontracting_compone_2,
        "! <p class="shorttext synchronized">Internal names for PurchaseOrderAccountAssignment_Type</p>
        "! See also structure type {@link ..tys_purchase_order_account_a_2}
        BEGIN OF purchase_order_account_a_2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! _PurchaseOrder
            purchase_order_2      TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_2',
            "! _PurchaseOrderItem
            purchase_order_item_2 TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_ITEM_2',
          END OF navigation,
        END OF purchase_order_account_a_2,
        "! <p class="shorttext synchronized">Internal names for PurchaseOrderInvoicingPlan_Type</p>
        "! See also structure type {@link ..tys_purchase_order_invoicing_3}
        BEGIN OF purchase_order_invoicing_3,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! _POInvoicingPlanItem
            poinvoicing_plan_item TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'POINVOICING_PLAN_ITEM',
            "! _PurchaseOrder
            purchase_order_2      TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_2',
            "! _PurchaseOrderItem
            purchase_order_item_2 TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_ITEM_2',
          END OF navigation,
        END OF purchase_order_invoicing_3,
        "! <p class="shorttext synchronized">Internal names for PurchaseOrderItemNote_Type</p>
        "! See also structure type {@link ..tys_purchase_order_item_note_t}
        BEGIN OF purchase_order_item_note_t,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! _PurchaseOrder
            purchase_order_2      TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_2',
            "! _PurchaseOrderItem
            purchase_order_item_2 TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_ITEM_2',
          END OF navigation,
        END OF purchase_order_item_note_t,
        "! <p class="shorttext synchronized">Internal names for PurchaseOrderItem_Type</p>
        "! See also structure type {@link ..tys_purchase_order_item_type}
        BEGIN OF purchase_order_item_type,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! _DeliveryAddress
            delivery_address           TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'DELIVERY_ADDRESS',
            "! _PurchaseOrder
            purchase_order_2           TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_2',
            "! _PurchaseOrderInvoicingPlan
            purchase_order_invoicing_p TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_INVOICING_P',
            "! _PurchaseOrderItemNote
            purchase_order_item_note   TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_ITEM_NOTE',
            "! _PurchaseOrderScheduleLineTP
            purchase_order_schedule_li TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_SCHEDULE_LI',
            "! _PurOrdAccountAssignment
            pur_ord_account_assignment TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PUR_ORD_ACCOUNT_ASSIGNMENT',
            "! _PurOrdPricingElement
            pur_ord_pricing_element    TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PUR_ORD_PRICING_ELEMENT',
          END OF navigation,
        END OF purchase_order_item_type,
        "! <p class="shorttext synchronized">Internal names for PurchaseOrderNote_Type</p>
        "! See also structure type {@link ..tys_purchase_order_note_type}
        BEGIN OF purchase_order_note_type,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! _PurchaseOrder
            purchase_order_2 TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_2',
          END OF navigation,
        END OF purchase_order_note_type,
        "! <p class="shorttext synchronized">Internal names for PurchaseOrderPartner_Type</p>
        "! See also structure type {@link ..tys_purchase_order_partner_typ}
        BEGIN OF purchase_order_partner_typ,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! _PurchaseOrderTP
            purchase_order_tp TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_TP',
          END OF navigation,
        END OF purchase_order_partner_typ,
        "! <p class="shorttext synchronized">Internal names for PurchaseOrderScheduleLine_Type</p>
        "! See also structure type {@link ..tys_purchase_order_schedule__2}
        BEGIN OF purchase_order_schedule__2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! _PurchaseOrder
            purchase_order_2         TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_2',
            "! _PurchaseOrderItem
            purchase_order_item_2    TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_ITEM_2',
            "! _SubcontractingComponent
            subcontracting_component TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'SUBCONTRACTING_COMPONENT',
          END OF navigation,
        END OF purchase_order_schedule__2,
        "! <p class="shorttext synchronized">Internal names for PurchaseOrderSupplierAddress_Type</p>
        "! See also structure type {@link ..tys_purchase_order_supplier__2}
        BEGIN OF purchase_order_supplier__2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! _PurchaseOrderTP
            purchase_order_tp TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_TP',
          END OF navigation,
        END OF purchase_order_supplier__2,
        "! <p class="shorttext synchronized">Internal names for PurchaseOrder_Type</p>
        "! See also structure type {@link ..tys_purchase_order_type}
        BEGIN OF purchase_order_type,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! _PurchaseOrderItem
            purchase_order_item    TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_ITEM',
            "! _PurchaseOrderNote
            purchase_order_note    TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_NOTE',
            "! _PurchaseOrderPartner
            purchase_order_partner TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_PARTNER',
            "! _SupplierAddress
            supplier_address       TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'SUPPLIER_ADDRESS',
          END OF navigation,
        END OF purchase_order_type,
        "! <p class="shorttext synchronized">Internal names for PurOrderItemDeliveryAddress_Type</p>
        "! See also structure type {@link ..tys_pur_order_item_delivery__2}
        BEGIN OF pur_order_item_delivery__2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! _PurchaseOrder
            purchase_order_2      TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_2',
            "! _PurchaseOrderItem
            purchase_order_item_2 TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_ITEM_2',
          END OF navigation,
        END OF pur_order_item_delivery__2,
        "! <p class="shorttext synchronized">Internal names for PurOrderItemPricingElement_Type</p>
        "! See also structure type {@link ..tys_pur_order_item_pricing_e_2}
        BEGIN OF pur_order_item_pricing_e_2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! _PurchaseOrder
            purchase_order_2      TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_2',
            "! _PurchaseOrderItem
            purchase_order_item_2 TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PURCHASE_ORDER_ITEM_2',
          END OF navigation,
        END OF pur_order_item_pricing_e_2,
      END OF gcs_entity_type.


    METHODS /iwbep/if_v4_mp_basic_pm~define REDEFINITION.

