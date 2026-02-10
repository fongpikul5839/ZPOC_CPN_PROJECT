@EndUserText.label: 'ZTABLE Item Parameter'
define abstract entity ZA_PARAM_ZTABLE_ITEM
{
  zuuid        : zde_uuid;
  itemno      : abap.numc(6);
  description : abap.char(50);

  _Header     : association to parent ZA_PARAM_ZTABLE_HEAD;
}
