  METHOD def_get_output_binary_data.

    DATA:
      lo_function        TYPE REF TO /iwbep/if_v4_pm_function,
      lo_function_import TYPE REF TO /iwbep/if_v4_pm_func_imp,
      lo_parameter       TYPE REF TO /iwbep/if_v4_pm_func_param,
      lo_return          TYPE REF TO /iwbep/if_v4_pm_func_return.


    lo_function = mo_model->create_function( 'GET_OUTPUT_BINARY_DATA' ).
    lo_function->set_edm_name( 'GetOutputBinaryData' ) ##NO_TEXT.


    lo_parameter = lo_function->create_parameter( 'IT' ).
    lo_parameter->set_edm_name( '_it' ) ##NO_TEXT.
    lo_parameter->set_entity_type( 'PURCHASE_ORDER_TYPE' ).
    lo_parameter->set_is_binding_parameter( ).

    lo_return = lo_function->create_return( ).
    lo_return->set_complex_type( 'D_PUR_ORD_GET_OUTPUT_BINAR' ).

  ENDMETHOD.