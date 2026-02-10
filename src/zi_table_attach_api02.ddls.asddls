@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View : Table Attach API02'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_TABLE_ATTACH_API02
  as select from ztable_attach as Table_attach
  association to ZI_GLOBAL_HEAD as _GB_HEAD01 on _GB_HEAD01.Uuid = $projection.Uuid
  association to parent ZI_TABLE_HEAD_API02 as _Table_HEAD01 on _Table_HEAD01.Uuid = $projection.Uuid
{
  key uuid               as Uuid,
  key itemno             as Itemno,
      attach             as Attach,
      locallastchangedat as LocalLastChangedAt,

      _GB_HEAD01,
      _Table_HEAD01
}
