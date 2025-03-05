class-pool .
*"* class pool for class ZCL_PR_CUSTOM_LOG

*"* local type definitions
include ZCL_PR_CUSTOM_LOG=============ccdef.

*"* class ZCL_PR_CUSTOM_LOG definition
*"* public declarations
  include ZCL_PR_CUSTOM_LOG=============cu.
*"* protected declarations
  include ZCL_PR_CUSTOM_LOG=============co.
*"* private declarations
  include ZCL_PR_CUSTOM_LOG=============ci.
endclass. "ZCL_PR_CUSTOM_LOG definition

*"* macro definitions
include ZCL_PR_CUSTOM_LOG=============ccmac.
*"* local class implementation
include ZCL_PR_CUSTOM_LOG=============ccimp.

*"* test class
include ZCL_PR_CUSTOM_LOG=============ccau.

class ZCL_PR_CUSTOM_LOG implementation.
*"* method's implementations
  include methods.
endclass. "ZCL_PR_CUSTOM_LOG implementation
