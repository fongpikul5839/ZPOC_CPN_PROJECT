@EndUserText.label: 'Table Header Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.semanticKey: [ 'SingletonID' ]
@UI: {
  headerInfo: {
    typeName: 'TableHeaderAll'
  }
}
define root view entity ZI_TableHeader_S
  as select from I_Language
    left outer join I_CstmBizConfignLastChgd on I_CstmBizConfignLastChgd.ViewEntityName = 'ZI_TABLEHEADER'
  association [0..*] to I_ABAPTransportRequestText as _ABAPTransportRequestText on $projection.TransportRequestID = _ABAPTransportRequestText.TransportRequestID
  composition [0..*] of ZI_TableHeader as _TableHeader
{
  @UI.facet: [ {
    id: 'Transport', 
    purpose: #STANDARD, 
    type: #IDENTIFICATION_REFERENCE, 
    label: 'Transport', 
    position: 1 , 
    hidden: #(HideTransport)
  }, {
    id: 'ZI_TableHeader', 
    purpose: #STANDARD, 
    type: #LINEITEM_REFERENCE, 
    label: 'Table Header', 
    position: 2 , 
    targetElement: '_TableHeader'
  } ]
  @UI.lineItem: [ {
    position: 1 
  } ]
  key 1 as SingletonID,
  _TableHeader,
  @UI.hidden: true
  I_CstmBizConfignLastChgd.LastChangedDateTime as LastChangedAtMax,
  @ObjectModel.text.association: '_ABAPTransportRequestText'
  @UI.identification: [ {
    position: 1 , 
    type: #WITH_INTENT_BASED_NAVIGATION, 
    semanticObjectAction: 'manage'
  }, {
    type: #FOR_ACTION, 
    dataAction: 'SelectCustomizingTransptReq', 
    label: 'Select Transport'
  } ]
  @Consumption.semanticObject: 'CustomizingTransport'
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  _ABAPTransportRequestText,
  @UI.hidden: true
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
}
where I_Language.Language = $session.system_language
