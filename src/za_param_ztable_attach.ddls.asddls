@EndUserText.label: 'ZTABLE Item Parameter'
define abstract entity ZA_PARAM_ZTABLE_attach
{
  zuuid   : zde_uuid;
  itemno  : abap.numc(6);
  attach  : abap.char(100);

  _Header : association to parent ZA_PARAM_ZTABLE_HEAD;
}
