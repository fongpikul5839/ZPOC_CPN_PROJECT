@EndUserText.label: 'ZTABLE Item Parameter'
define abstract entity ZA_PARAM_ZTABLE_ITEM_PR
{
  zuuid        : zde_uuid;
  itemno      : abap.numc(6);
  description : abap.char(50);

  _Header     : association to parent za_param_ztable_head_pr;
}
