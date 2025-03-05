  PRIVATE SECTION.

    "! <p class="shorttext synchronized">Model</p>
    DATA mo_model TYPE REF TO /iwbep/if_v4_pm_model.


    "! <p class="shorttext synchronized">Define A_PhysInventoryDocHeaderType</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_a_phys_inventory_doc_hea_2 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define A_PhysInventoryDocItemType</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_a_phys_inventory_doc_ite_2 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define A_SerialNumberPhysInventoryDocType</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_a_serial_number_phys_inv_2 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define InitiateRecount</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_initiate_recount RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define InitiateRecountOnItem</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_initiate_recount_on_item RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define PostDifferences</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_post_differences RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define PostDifferencesOnItem</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_post_differences_on_item RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define all primitive types</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS define_primitive_types RAISING /iwbep/cx_gateway.
