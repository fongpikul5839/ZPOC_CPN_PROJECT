@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View : Table Item API02'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_TABLE_ITEM_API02
  as projection on ZI_TABLE_ITEM_API02
{
  key Uuid,
  key Itemno,
      Description,
      /* Associations */
      _Table_HEAD01 : redirected to parent ZC_TABLE_HEAD_API02,
      _GB_HEAD01    : redirected to ZC_GLOBAL_HEAD
}
