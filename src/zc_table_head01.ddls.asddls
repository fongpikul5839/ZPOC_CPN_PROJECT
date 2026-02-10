@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View : Table Header'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_TABLE_HEAD01 as projection on ZI_TABLE_HEAD01
{
    key Uuid,
    DocumentNo,
    Single01,
    Single02,
    Comment01, 
    Rb_Requestor,
    Checkbox01,
    Approval,
    /* Associations */
    _Table_item01 : redirected to composition child ZC_TABLE_ITEM01
}
