  METHOD def_d_pur_ord_get_output_binar.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_complex_type        TYPE REF TO /iwbep/if_v4_pm_cplx_type,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_complex_type = mo_model->create_complex_type_by_struct(
                                    iv_complex_type_name      = 'D_PUR_ORD_GET_OUTPUT_BINAR'
                                    is_structure              = VALUE tys_d_pur_ord_get_output_binar( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_complex_type->set_edm_name( 'D_PurOrdGetOutputBinaryDataR' ) ##NO_TEXT.


    lo_primitive_property = lo_complex_type->get_primitive_property( 'MIME_TYPE' ).
    lo_primitive_property->set_edm_name( 'MimeType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 128 ) ##NUMBER_OK.

    lo_primitive_property = lo_complex_type->get_primitive_property( 'OUTPUT_BINARY_DATA' ).
    lo_primitive_property->set_edm_name( 'OutputBinaryData' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Binary' ) ##NO_TEXT.

    lo_primitive_property = lo_complex_type->get_primitive_property( 'OUTPUT_CHANNEL' ).
    lo_primitive_property->set_edm_name( 'OutputChannel' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 5 ) ##NUMBER_OK.

    lo_primitive_property = lo_complex_type->get_primitive_property( 'OUTPUT_DOCUMENT_NAME' ).
    lo_primitive_property->set_edm_name( 'OutputDocumentName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 120 ) ##NUMBER_OK.

    lo_primitive_property = lo_complex_type->get_primitive_property( 'RECIPIENT' ).
    lo_primitive_property->set_edm_name( 'Recipient' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.

    lo_primitive_property = lo_complex_type->get_primitive_property( 'RECIPIENT_ROLE' ).
    lo_primitive_property->set_edm_name( 'RecipientRole' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.

  ENDMETHOD.