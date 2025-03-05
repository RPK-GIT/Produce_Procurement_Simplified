unmanaged implementation in class zcl_pr_i_consignment unique;
strict ( 1 );

define behavior for ZPR_I_CONSIGNMENT alias consign
//persistent table <???>
lock master
authorization master ( instance )
//etag master <field_name>
{
//  create;
//  update;
//  delete;
  field ( readonly ) MaterialDocument, MaterialDocumentYear, MaterialDocumentItem;

//  action ( features : instance ) Post result [1] $self;
action Post;
}