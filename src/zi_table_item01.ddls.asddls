@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View : Table Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_TABLE_ITEM01 as select from ztable_item01 as Table_item01
association to parent ZI_TABLE_HEAD01 as _Table_head01 on _Table_head01.Uuid = $projection.Uuid
{
    key uuid as Uuid,
    key itemno as Itemno,
    description as Description,
    
    _Table_head01
}
