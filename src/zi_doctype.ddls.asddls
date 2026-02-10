@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View : Doc Type Search Help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_DOCTYPE
  as select distinct from zglobal_head01
{
       @ObjectModel.text.element: ['DocumentType']
  key  document_type as DocumentType
}
where
  document_type is not initial
