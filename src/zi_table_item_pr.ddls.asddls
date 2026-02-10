@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View : Table Item PR'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_TABLE_ITEM_PR
  as select from ztable_item_pr as Table_item
  association to ZI_GLOBAL_HEAD          as _GB_HEAD01     on _GB_HEAD01.Uuid = $projection.UuidPr
  association to parent ZI_TABLE_HEAD_PR as _Table_HEAD_PR on _Table_HEAD_PR.Uuid_pr = $projection.UuidPr
{
  key uuid_pr            as UuidPr,
  key itemno             as Itemno,
      description        as Description,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      locallastchangedat as LocalLastChangedAt,

      _GB_HEAD01,
      _Table_HEAD_PR
}
