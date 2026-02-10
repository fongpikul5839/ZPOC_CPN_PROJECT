@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View : Table Global Header API02'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_GLOBAL_HEAD
  as projection on ZI_GLOBAL_HEAD
{
  key     Uuid,
          DocumentNo,
          //      @ObjectModel.text.element: ['DocumentType']
          @Consumption.valueHelpDefinition: [{ entity:{ name: 'ZI_DOCTYPE', element: 'DocumentType' } }]
          //      @EndUserText.label: 'DocumentType'
          DocumentType,
          CurrentStatus,
          CreateBy,
          CreateDate,
          CreateTime,
          PoHidden2,
          PrHidden2,


          @ObjectModel.virtualElementCalculatedBy: 'ABAP:Z_SHOWFIELD'
  virtual IsPoHidden :abap_boolean,
          // Use case
          //          case DocumentType
          //          when 'PO' then ' '
          //          else 'X'
          //          end as


          @ObjectModel.virtualElementCalculatedBy: 'ABAP:Z_SHOWFIELD'
  virtual IsPrHidden :abap_boolean,


          /* Associations */

          _Table_head01  : redirected to composition child ZC_TABLE_HEAD_API02,
          _Table_head_pr : redirected to composition child ZC_TABLE_HEAD_PR,

          _Table_item01  : redirected to ZC_TABLE_ITEM_API02,
          _Table_attach  : redirected to ZC_TABLE_ATTACH_API02,
          _Table_log     : redirected to composition child ZC_GLOBAL_LOG,
          _Table_item_pr : redirected to ZC_TABLE_ITEM_PR
}
