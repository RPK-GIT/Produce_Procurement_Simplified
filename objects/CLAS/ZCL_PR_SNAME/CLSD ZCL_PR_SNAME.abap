class-pool .
*"* class pool for class ZCL_PR_SNAME

*"* local type definitions
include ZCL_PR_SNAME==================ccdef.

*"* class ZCL_PR_SNAME definition
*"* public declarations
  include ZCL_PR_SNAME==================cu.
*"* protected declarations
  include ZCL_PR_SNAME==================co.
*"* private declarations
  include ZCL_PR_SNAME==================ci.
endclass. "ZCL_PR_SNAME definition

*"* macro definitions
include ZCL_PR_SNAME==================ccmac.
*"* local class implementation
include ZCL_PR_SNAME==================ccimp.

*"* test class
include ZCL_PR_SNAME==================ccau.

class ZCL_PR_SNAME implementation.
*"* method's implementations
  include methods.
endclass. "ZCL_PR_SNAME implementation
