  PRIVATE SECTION.

    "! <p class="shorttext synchronized">Model</p>
    DATA mo_model TYPE REF TO /iwbep/if_v4_pm_model.


    "! <p class="shorttext synchronized">Define D_PurOrdGetOutputBinaryDataR</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_d_pur_ord_get_output_binar RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define SAP__Message</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_sap_message RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define POInvoicingPlanItem_Type</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_poinvoicing_plan_item_type RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define POSubcontractingComponent_Type</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_posubcontracting_compone_2 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define PurchaseOrderAccountAssignment_Type</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_purchase_order_account_a_2 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define PurchaseOrderInvoicingPlan_Type</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_purchase_order_invoicing_3 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define PurchaseOrderItemNote_Type</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_purchase_order_item_note_t RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define PurchaseOrderItem_Type</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_purchase_order_item_type RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define PurchaseOrderNote_Type</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_purchase_order_note_type RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define PurchaseOrderPartner_Type</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_purchase_order_partner_typ RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define PurchaseOrderScheduleLine_Type</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_purchase_order_schedule__2 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define PurchaseOrderSupplierAddress_Type</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_purchase_order_supplier__2 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define PurchaseOrder_Type</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_purchase_order_type RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define PurOrderItemDeliveryAddress_Type</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_pur_order_item_delivery__2 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define PurOrderItemPricingElement_Type</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_pur_order_item_pricing_e_2 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define GetOutputBinaryData</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_get_output_binary_data RAISING /iwbep/cx_gateway.
