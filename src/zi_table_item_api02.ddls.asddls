@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View : Table Item API02'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_TABLE_ITEM_API02
  as select from ztable_item01 as Table_item
  association to ZI_GLOBAL_HEAD as _GB_HEAD01 on _GB_HEAD01.Uuid = $projection.Uuid
  association to parent ZI_TABLE_HEAD_API02 as _Table_HEAD01 on _Table_HEAD01.Uuid = $projection.Uuid
{
  key uuid               as Uuid,
  key itemno             as Itemno,
      description        as Description,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      locallastchangedat as LocalLastChangedAt,

      _GB_HEAD01,
      _Table_HEAD01
}
