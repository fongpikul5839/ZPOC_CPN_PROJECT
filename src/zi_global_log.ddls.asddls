@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View : Table Global Log API02'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_GLOBAL_LOG
  as select from zglobal_log01 as GB_LOG
  association to parent ZI_GLOBAL_HEAD as _GB_HEAD01 on _GB_HEAD01.Uuid = $projection.Uuid
//  association to ZI_TABLE_HEAD_API02 as _Table_HEAD01 on _Table_HEAD01.Uuid = $projection.Uuid
{
  key uuid               as Uuid,
      document_no        as DocumentNo,
      approver           as Approver,
      change_date        as ChangeDate,
      change_time        as ChangeTime,
      change_user        as ChangeUser,
      activity           as Activity,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      locallastchangedat as LocalLastChangedAt,

      _GB_HEAD01
//      _Table_HEAD01
}
