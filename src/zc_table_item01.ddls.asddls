@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View : Table Item'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_TABLE_ITEM01 as projection on ZI_TABLE_ITEM01
{
    key Uuid,
    key Itemno,
    Description,
    /* Associations */
    _Table_head01 : redirected to parent ZC_TABLE_HEAD01
}
