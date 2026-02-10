@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View : Table Header API02'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZC_TABLE_HEAD_API02
  as projection on ZI_TABLE_HEAD_API02
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

      _Table_item01 : redirected to composition child ZC_TABLE_ITEM_API02,
      _Table_attach : redirected to composition child ZC_TABLE_ATTACH_API02,
//      _Table_log    : redirected to composition child ZC_GLOBAL_LOG,

      _GB_HEAD01    : redirected to parent ZC_GLOBAL_HEAD
}
