@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View : Table Header API02'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_TABLE_HEAD_PR
  as select from ztable_head_pr as Table_head_pr
  association to parent ZI_GLOBAL_HEAD as _GB_HEAD01 on _GB_HEAD01.Uuid = $projection.Uuid_pr
  
  composition [1..*] of ZI_TABLE_ITEM_PR   as _Table_item_pr
{
  key uuid_pr            as Uuid_pr,
      document_no_pr     as DocumentNo_pr,
      comment01          as Comment01,
      checkbox01         as Checkbox01,
      approval           as Approval,

      locallastchangedat as LocalLastChangedAt,
      _Table_item_pr,

      _GB_HEAD01

}
where
  _GB_HEAD01.DocumentType = 'PR'
