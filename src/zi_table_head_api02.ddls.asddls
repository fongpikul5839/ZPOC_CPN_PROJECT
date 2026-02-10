@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View : Table Header API02'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_TABLE_HEAD_API02
  as select from ztable_head01 as Table_head
  association to parent ZI_GLOBAL_HEAD        as _GB_HEAD01 on _GB_HEAD01.Uuid = $projection.Uuid

  composition [1..*] of ZI_TABLE_ITEM_API02   as _Table_item01
  composition [1..*] of ZI_TABLE_ATTACH_API02 as _Table_attach
//  composition [1..1] of ZI_GLOBAL_LOG         as _Table_log
{
  key uuid               as Uuid,
      document_no        as DocumentNo,
      single01           as Single01,
      single02           as Single02,
      comment01          as Comment01,
      rb_requestor       as RbRequestor,
      checkbox01         as Checkbox01,
      approval           as Approval,
      
      locallastchangedat as LocalLastChangedAt,
      _Table_item01,
      _Table_attach,
//      _Table_log,

      _GB_HEAD01



}
where
  _GB_HEAD01.DocumentType = 'PO'
