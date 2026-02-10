@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View : Table Attach'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_TABLE_ATTACH as projection on zi_table_attach
{
    key Uuid,
    key Itemno,
    key Attach,
    /* Associations */
//    _Table_item : redirected to parent ZC_TABLE_ITEM
    _Table_head : redirected to parent ZC_TABLE_HEAD
}
