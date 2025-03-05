class-pool .
*"* class pool for class ZPR_CL_SCM_PO

*"* local type definitions
include ZPR_CL_SCM_PO=================ccdef.

*"* class ZPR_CL_SCM_PO definition
*"* public declarations
  include ZPR_CL_SCM_PO=================cu.
*"* protected declarations
  include ZPR_CL_SCM_PO=================co.
*"* private declarations
  include ZPR_CL_SCM_PO=================ci.
endclass. "ZPR_CL_SCM_PO definition

*"* macro definitions
include ZPR_CL_SCM_PO=================ccmac.
*"* local class implementation
include ZPR_CL_SCM_PO=================ccimp.

*"* test class
include ZPR_CL_SCM_PO=================ccau.

class ZPR_CL_SCM_PO implementation.
*"* method's implementations
  include methods.
endclass. "ZPR_CL_SCM_PO implementation
