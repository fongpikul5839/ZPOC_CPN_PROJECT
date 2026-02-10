@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View : Table Attach API02'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_TABLE_ATTACH_API02
  as projection on ZI_TABLE_ATTACH_API02
{
  key Uuid,
  key Itemno,
      Attach,
      /* Associations */
      _Table_HEAD01 : redirected to parent ZC_TABLE_HEAD_API02,
      _GB_HEAD01    : redirected to ZC_GLOBAL_HEAD
}
