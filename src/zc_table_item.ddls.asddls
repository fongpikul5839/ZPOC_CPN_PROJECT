@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View : Table Item'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_TABLE_ITEM as projection on ZI_TABLE_ITEM
{
    key Uuid,
    key Itemno,
    Description,
    /* Associations */
    _Table_head : redirected to parent ZC_TABLE_HEAD
//    _Table_attach : redirected to composition child ZC_TABLE_ATTACH
}
