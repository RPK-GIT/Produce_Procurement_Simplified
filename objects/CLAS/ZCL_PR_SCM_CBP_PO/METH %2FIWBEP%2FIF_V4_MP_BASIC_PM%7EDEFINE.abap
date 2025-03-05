  METHOD /iwbep/if_v4_mp_basic_pm~define.

    mo_model = io_model.
    mo_model->set_schema_namespace( 'com.sap.gateway.srvd_a2x.api_purchaseorder_2.v0001' ) ##NO_TEXT.

    def_d_pur_ord_get_output_binar( ).
    def_sap_message( ).
    def_poinvoicing_plan_item_type( ).
    def_posubcontracting_compone_2( ).
    def_purchase_order_account_a_2( ).
    def_purchase_order_invoicing_3( ).
    def_purchase_order_item_note_t( ).
    def_purchase_order_item_type( ).
    def_purchase_order_note_type( ).
    def_purchase_order_partner_typ( ).
    def_purchase_order_schedule__2( ).
    def_purchase_order_supplier__2( ).
    def_purchase_order_type( ).
    def_pur_order_item_delivery__2( ).
    def_pur_order_item_pricing_e_2( ).
    def_get_output_binary_data( ).

  ENDMETHOD.