@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View : Table Item PR'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_TABLE_ITEM_PR as projection on ZI_TABLE_ITEM_PR
{
    key UuidPr,
    key Itemno,
    Description,
    LocalLastChangedAt,
    /* Associations */
    _GB_HEAD01 : redirected to ZC_GLOBAL_HEAD, 
    _Table_HEAD_PR : redirected to parent ZC_TABLE_HEAD_PR
}
