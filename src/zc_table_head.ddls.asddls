@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View : Table Header'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_TABLE_HEAD as projection on ZI_TABLE_HEAD

{
  key Uuid,
      DocumentNo,
      Single01,
      Single02,
      Comment01,
      RbRequestor,
      Checkbox01,
      Approval,
      /* Associations */
      _Table_item   : redirected to composition child ZC_TABLE_ITEM,
      _Table_attach   : redirected to composition child ZC_TABLE_attach
}
