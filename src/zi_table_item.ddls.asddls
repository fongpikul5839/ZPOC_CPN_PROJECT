@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View : Table Item Final'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_TABLE_ITEM as select from ztable_item01 as Table_item
association to parent ZI_TABLE_HEAD as _Table_head on _Table_head.Uuid = $projection.Uuid
//composition [1..*] of zi_table_attach as _Table_attach 
{
    key uuid as Uuid,
    key itemno as Itemno,
    description as Description,
    
    _Table_head 
}
