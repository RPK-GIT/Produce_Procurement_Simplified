class-pool .
*"* class pool for class ZCL_PR_MNAME

*"* local type definitions
include ZCL_PR_MNAME==================ccdef.

*"* class ZCL_PR_MNAME definition
*"* public declarations
  include ZCL_PR_MNAME==================cu.
*"* protected declarations
  include ZCL_PR_MNAME==================co.
*"* private declarations
  include ZCL_PR_MNAME==================ci.
endclass. "ZCL_PR_MNAME definition

*"* macro definitions
include ZCL_PR_MNAME==================ccmac.
*"* local class implementation
include ZCL_PR_MNAME==================ccimp.

*"* test class
include ZCL_PR_MNAME==================ccau.

class ZCL_PR_MNAME implementation.
*"* method's implementations
  include methods.
endclass. "ZCL_PR_MNAME implementation
