@EndUserText.label: 'Table Header'
@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
define view entity ZI_TableHeader
  as select from ztable_head01
  association to parent ZI_TableHeader_S as _TableHeaderAll on $projection.SingletonID = _TableHeaderAll.SingletonID
{
  key uuid         as Uuid,
      document_no  as DocumentNo,
      single01     as Single01,
      single02     as Single02,
      comment01    as Comment01,
      rb_requestor as Rb_Requestor,
      checkbox01   as Checkbox01,
      approval     as Approval,
      @Consumption.hidden: true
      1            as SingletonID,
      _TableHeaderAll
}
