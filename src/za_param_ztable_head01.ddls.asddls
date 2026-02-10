@EndUserText.label: 'ZTABLE Header Parameter'
define root abstract entity ZA_Param_Ztable_Head01
{
  zuuid          : zde_uuid;
  document_no   : abap.char(10);
  single01      : abap.char(1);
  single02      : abap.char(1);
  comment01     : abap.char(10); 
  rb_requestor  : abap.char(10);
  checkbox01    : abap.char(1);
  approval      : abap.char(1);

  _Item : composition [0..*] of za_param_ztable_item01;


}
