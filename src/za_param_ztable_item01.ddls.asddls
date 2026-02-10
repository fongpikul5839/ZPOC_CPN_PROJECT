@EndUserText.label: 'ZTABLE Item Parameter'
define abstract entity za_param_ztable_item01
{
  zuuid        : zde_uuid;
  itemno      : abap.numc(6);
  description : abap.char(50);

  _Header     : association to parent ZA_Param_Ztable_Head01;
}
