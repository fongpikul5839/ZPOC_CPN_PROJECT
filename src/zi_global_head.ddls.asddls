@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View : Table Global Header API02'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_GLOBAL_HEAD
  as select from zglobal_head01 as GB_HEAD01
  composition [1..1] of ZI_TABLE_HEAD_API02   as _Table_head01
  composition [1..1] of ZI_TABLE_HEAD_PR      as _Table_head_pr
  composition [1..1] of ZI_GLOBAL_LOG         as _Table_log

  association [0..*] to ZI_TABLE_ITEM_API02   as _Table_item01  on $projection.Uuid = _Table_item01.Uuid
  association [0..*] to ZI_TABLE_ATTACH_API02 as _Table_attach  on $projection.Uuid = _Table_attach.Uuid
  association [0..*] to ZI_TABLE_ITEM_PR      as _Table_item_pr on $projection.Uuid = _Table_item_pr.UuidPr
  association [0..1] to ZI_DOCTYPE            as _Doctype       on _Doctype.DocumentType = $projection.DocumentType

{
  key uuid               as Uuid,
      document_no        as DocumentNo,
      document_type      as DocumentType,
      current_status     as CurrentStatus,
      create_by          as CreateBy,
      create_date        as CreateDate,
      create_time        as CreateTime,

      //     cast( case when document_type = 'PO' then 0 else 1 end
      //            as abap_boolean
      //     ) as PoHidden2,

      //      case GB_HEAD01.document_type
      //      when 'PO' then ' '
      //      else 'X'
      //      end as PoHidden2,
      case
      when document_type = 'PO' then cast( '' as  abap_boolean ) 
      else cast ( 'X' as  abap_boolean ) 
      end                as PoHidden2,

      case document_type
      when 'PR' then cast ( '' as  abap_boolean ) 
      else cast ( 'X' as  abap_boolean ) 
      end                as PrHidden2,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      locallastchangedat as LocalLastChangedAt,

      _Table_head01,
      _Table_item01,
      _Table_attach,
      _Table_log,
      _Table_head_pr,
      _Table_item_pr

}
