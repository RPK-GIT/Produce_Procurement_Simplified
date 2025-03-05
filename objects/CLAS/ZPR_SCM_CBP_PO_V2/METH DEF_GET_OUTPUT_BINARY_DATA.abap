  METHOD def_get_output_binary_data.

    DATA:
      lo_function        TYPE REF TO /iwbep/if_v4_pm_function,
      lo_function_import TYPE REF TO /iwbep/if_v4_pm_func_imp,
      lo_parameter       TYPE REF TO /iwbep/if_v4_pm_func_param,
      lo_return          TYPE REF TO /iwbep/if_v4_pm_func_return.


    lo_function = mo_model->create_function( 'GET_OUTPUT_BINARY_DATA' ).
    lo_function->set_edm_name( 'GetOutputBinaryData' ) ##NO_TEXT.

    lo_function_import = lo_function->create_function_import( 'GET_OUTPUT_BINARY_DATA' ).
    lo_function_import->set_edm_name( 'GetOutputBinaryData' ) ##NO_TEXT.


    lo_parameter = lo_function->create_parameter( 'PURCHASE_ORDER' ).
    lo_parameter->set_edm_name( 'PurchaseOrder' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'PURCHASE_ORDER' ).
    lo_parameter->set_is_nullable( ).

    lo_return = lo_function->create_return( ).
    lo_return->set_complex_type( 'GET_PDFRESULT' ).

  ENDMETHOD.