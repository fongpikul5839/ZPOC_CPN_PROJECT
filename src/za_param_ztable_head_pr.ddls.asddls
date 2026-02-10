@EndUserText.label: 'ZTABLE HEADER Parameter'
define root abstract entity ZA_PARAM_ZTABLE_HEAD_PR
{
  zuuid        : zde_uuid;
  msg          : abap.char(50);
  document_no  : abap.char(10);
  comment01    : abap.char(255);
  checkbox01   : abap.char(1);
  approval     : abap.char(255);

  _Item        : composition [0..*] of ZA_PARAM_ZTABLE_ITEM_PR; 


}
