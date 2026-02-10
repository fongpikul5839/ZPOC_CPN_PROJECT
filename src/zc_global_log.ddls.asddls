@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View : Table Global Log API02'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_GLOBAL_LOG
  as projection on ZI_GLOBAL_LOG
{
  key Uuid,
      DocumentNo,
      Approver,
      ChangeDate,
      ChangeTime,
      ChangeUser,
      Activity,
      /* Associations */
//      _Table_HEAD01 : redirected to parent ZC_TABLE_HEAD_API02,
      _GB_HEAD01    : redirected to parent ZC_GLOBAL_HEAD
}
