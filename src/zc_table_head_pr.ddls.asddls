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
define view entity ZC_TABLE_HEAD_PR
  as projection on ZI_TABLE_HEAD_PR
{
  key Uuid_pr,
      DocumentNo_pr,
      //    Single01,
      //    Single02,
      Comment01,
      //    RbRequestor,
      Checkbox01,
      Approval,
      //    /* Associations */
      _Table_item_pr : redirected to composition child ZC_TABLE_ITEM_PR,
      _GB_HEAD01     : redirected to parent ZC_GLOBAL_HEAD
}
