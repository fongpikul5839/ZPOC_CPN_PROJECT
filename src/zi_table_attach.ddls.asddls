@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View : Table Attach Final'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi_table_attach
  as select from ztable_attach as Table_attach 
association to parent ZI_TABLE_HEAD as _Table_head on _Table_head.Uuid = $projection.Uuid
//  association to parent ZI_TABLE_ITEM as _Table_item on  _Table_item.Uuid   = $projection.Uuid
//                                                     and _Table_item.Itemno = $projection.Itemno
{
  key uuid   as Uuid,
  key itemno as Itemno,
  key attach as Attach,

      _Table_head
}
