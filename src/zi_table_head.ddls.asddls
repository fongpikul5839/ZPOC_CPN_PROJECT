@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View : Table Header Final'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TABLE_HEAD
  as select from ztable_head01 as Table_head
  composition [1..*] of ZI_TABLE_ITEM   as _Table_item
  composition [1..*] of zi_table_attach as _Table_attach
{
  key uuid         as Uuid,
      document_no  as DocumentNo,
      single01     as Single01,
      single02     as Single02,
      comment01    as Comment01,
      rb_requestor as RbRequestor,
      checkbox01   as Checkbox01,
      approval     as Approval,

      _Table_item,
      _Table_attach
}
