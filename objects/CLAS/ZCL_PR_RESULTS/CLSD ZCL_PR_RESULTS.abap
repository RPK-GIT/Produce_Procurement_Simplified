class-pool .
*"* class pool for class ZCL_PR_RESULTS

*"* local type definitions
include ZCL_PR_RESULTS================ccdef.

*"* class ZCL_PR_RESULTS definition
*"* public declarations
  include ZCL_PR_RESULTS================cu.
*"* protected declarations
  include ZCL_PR_RESULTS================co.
*"* private declarations
  include ZCL_PR_RESULTS================ci.
endclass. "ZCL_PR_RESULTS definition

*"* macro definitions
include ZCL_PR_RESULTS================ccmac.
*"* local class implementation
include ZCL_PR_RESULTS================ccimp.

*"* test class
include ZCL_PR_RESULTS================ccau.

class ZCL_PR_RESULTS implementation.
*"* method's implementations
  include methods.
endclass. "ZCL_PR_RESULTS implementation
