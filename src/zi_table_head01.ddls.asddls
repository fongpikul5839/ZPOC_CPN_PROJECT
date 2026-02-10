@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View : Table Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_TABLE_HEAD01 as select from ztable_head01 as Table_head01
composition [1..*] of ZI_TABLE_ITEM01 as _Table_item01
{
    key uuid as Uuid,
    document_no as DocumentNo,
    single01 as Single01,
    single02 as Single02,
    comment01 as Comment01,
    rb_requestor as Rb_Requestor,
    checkbox01 as Checkbox01,
    approval as Approval,
    
    _Table_item01
}
