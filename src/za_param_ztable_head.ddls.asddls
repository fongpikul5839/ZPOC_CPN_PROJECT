@EndUserText.label: 'ZTABLE HEADER Parameter'
define root abstract entity ZA_PARAM_ZTABLE_HEAD
{
  zuuid        : zde_uuid;
  msg          : abap.char(50);
  document_no  : abap.char(10);
  single01     : abap.char(1);
  single02     : abap.char(1);
  comment01    : abap.char(255);
  rb_requestor : abap.char(10);
  checkbox01   : abap.char(1);
  approval     : abap.char(255);

  _Item        : composition [0..*] of ZA_PARAM_ZTABLE_ITEM;
  _Attach      : composition [0..*] of ZA_PARAM_ZTABLE_attach;


}
