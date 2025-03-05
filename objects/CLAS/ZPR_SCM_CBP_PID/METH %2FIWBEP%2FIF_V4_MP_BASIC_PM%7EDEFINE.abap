  METHOD /iwbep/if_v4_mp_basic_pm~define.

    mo_model = io_model.
    mo_model->set_schema_namespace( 'API_PHYSICAL_INVENTORY_DOC_SRV' ) ##NO_TEXT.

    def_a_phys_inventory_doc_hea_2( ).
    def_a_phys_inventory_doc_ite_2( ).
    def_a_serial_number_phys_inv_2( ).
    def_initiate_recount( ).
    def_initiate_recount_on_item( ).
    def_post_differences( ).
    def_post_differences_on_item( ).
    define_primitive_types( ).

  ENDMETHOD.