CLASS lhc_ZI_TABLE_HEAD DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    DATA:
      lt_head    TYPE TABLE OF ztable_head01,
      lt_item    TYPE TABLE OF ztable_item01,
      lt_attach  TYPE TABLE OF ztable_attach,
      lt_gb_head TYPE TABLE OF zglobal_head01,
      lt_gb_log  TYPE TABLE OF zglobal_log01,
      lt_gb_cf   TYPE TABLE OF zglobal_config01,
      lt_head_pr TYPE TABLE OF ztable_head_pr,
      lt_item_pr TYPE TABLE OF ztable_item_pr.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_table_head RESULT result.

    METHODS GetData FOR MODIFY
      IMPORTING keys FOR ACTION zi_table_head~GetData RESULT result.

    METHODS CreateData FOR MODIFY
      IMPORTING keys FOR ACTION zi_table_head~CreateData RESULT result.

    METHODS DeleteData FOR MODIFY
      IMPORTING keys FOR ACTION zi_table_head~DeleteData RESULT result.

    METHODS CreatePR FOR MODIFY
      IMPORTING keys FOR ACTION zi_table_head~CreatePR RESULT result.

    METHODS DeletePR FOR MODIFY
      IMPORTING keys FOR ACTION zi_table_head~DeletePR RESULT result.

ENDCLASS.

CLASS lhc_ZI_TABLE_HEAD IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD CreateData.

    DATA: lt_head_en      TYPE TABLE FOR CREATE zi_table_head01,
          lt_item_en      TYPE TABLE FOR CREATE zi_table_head01\_Table_item01,
          lv_number_range TYPE c LENGTH 7,
          lv_num_next     TYPE n LENGTH 7,
          lv_create       TYPE c,
          lv_update       TYPE c,
          lv_activity     TYPE c LENGTH 10.

    CLEAR: lv_number_range , lv_num_next , lv_create , lv_update , lv_activity.

    TRY.

        DATA(lw_key) = keys[ 1 ].

        SELECT SINGLE document_no
            FROM ztable_head01
            WHERE uuid = @lw_key-%param-zuuid
            INTO @DATA(lv_doc).
        IF sy-subrc EQ 0 AND lv_doc IS NOT INITIAL.
          lv_update = abap_true.
        ELSE.
          lv_create = abap_true.
        ENDIF.

        IF lv_doc IS INITIAL.
          SELECT SINGLE MAX( document_no ) FROM ztable_head01
          INTO @DATA(lv_document_no).
          IF sy-subrc EQ 0.
            lv_num_next = lv_document_no+3(7).
            lv_num_next = lv_num_next + 1.
            lv_number_range = |{ lv_num_next ALPHA = IN }|.
*          lv_document_no+3(7) = lv_number_range.
            lv_document_no = |DOC| & |{ lv_number_range  }|.

          ELSE.
            lv_num_next = 1.
            lv_number_range = |{ lv_num_next ALPHA = IN }|.

            lv_document_no = |DOC| & |{ lv_number_range  }|.
          ENDIF.
        ELSE.
          lv_document_no = lv_doc.
        ENDIF.

        lt_head = VALUE #( ( Uuid = lw_key-%param-zuuid
                             document_no = lv_document_no
                             Single01 = lw_key-%param-Single01
                             Single02 = lw_key-%param-Single02
                             Comment01 = lw_key-%param-Comment01
*                             rb_choice01 = lw_key-%param-rb_choice01
*                             rb_choice02 = lw_key-%param-rb_choice02
*                             rb_choice03 = lw_key-%param-rb_choice03
                             rb_requestor = lw_key-%param-rb_requestor
                             Checkbox01 = lw_key-%param-Checkbox01
                             Approval = lw_key-%param-Approval ) ).

        IF lt_head[] IS NOT INITIAL.
          lt_gb_head = VALUE #( ( Uuid = lw_key-%param-zuuid
                                  document_no = lv_document_no
                                  document_type = 'PO'
                                  current_status = 'Approve'
                                  create_by = sy-uname
                                  create_date = sy-datum
                                  create_time = sy-uzeit ) ).

          CASE abap_true.
            WHEN lv_create.
              lv_activity = 'CREATE'.
            WHEN lv_update.
              lv_activity = 'UPDATE'.
          ENDCASE.

          lt_gb_log = VALUE #( ( Uuid = lw_key-%param-zuuid
                                  document_no = lv_document_no
                                  approver = 'Siwakorn'
                                  change_date = sy-datum
                                  change_time = sy-uzeit
                                  change_user = sy-uname
                                  activity = lv_activity ) ).

          lt_gb_cf = VALUE #( ( document_type = 'PO'
                                table_name = 'ZBCT0010_TA01' )
                               (  document_type = 'PR'
                                  table_name = 'ZBCT0010_TA02' ) ).


        ENDIF.


*        lt_head_en = VALUE #( ( %cid = 'CID_271'
*                                Uuid = lw_key-%param-zuuid
*                                DocumentNo = lv_document_no
*                                Single01 = lw_key-%param-Single01
*                                Single02 = lw_key-%param-Single02
*                                Comment01 = lw_key-%param-Comment01
**                                RbChoice01 = lw_key-%param-rb_choice01
**                                RbChoice02 = lw_key-%param-rb_choice02
**                                RbChoice03 = lw_key-%param-rb_choice03
*                                rb_requestor = lw_key-%param-rb_requestor
*                                Checkbox01 = lw_key-%param-Checkbox01
*                                Approval = lw_key-%param-Approval
*                                    %control = VALUE #(
*                                    Uuid = if_abap_behv=>mk-on
*                                    DocumentNo = if_abap_behv=>mk-on
*                                    Single01 = if_abap_behv=>mk-on
*                                    Single02 = if_abap_behv=>mk-on
*                                    Comment01 = if_abap_behv=>mk-on
**                                    RbChoice01 = if_abap_behv=>mk-on
**                                    RbChoice02 = if_abap_behv=>mk-on
**                                    RbChoice03 = if_abap_behv=>mk-on
*                                    rb_requestor = if_abap_behv=>mk-on
*                                    Checkbox01 = if_abap_behv=>mk-on
*                                    Approval = if_abap_behv=>mk-on ) ) ).




        LOOP AT lw_key-%param-_item ASSIGNING FIELD-SYMBOL(<lfs_item>).


          APPEND INITIAL LINE TO lt_item ASSIGNING FIELD-SYMBOL(<lfs_Ztab_Item>).

*          APPEND INITIAL LINE TO lt_item_en ASSIGNING FIELD-SYMBOL(<lfs_Item_en>).
*          APPEND VALUE #( %cid_ref = 'CID_271' )
*                          TO lt_item_en
*                          ASSIGNING FIELD-SYMBOL(<lfs_Item_en>).
*
          <lfs_Ztab_Item> = VALUE #( Uuid = <lfs_item>-zuuid
                          Itemno = <lfs_item>-itemno
                          Description = <lfs_item>-description ).

*          APPEND VALUE #( Uuid = <lfs_item>-zuuid
*                          Itemno = <lfs_item>-itemno
*                          Description = <lfs_item>-description
*                          %control = VALUE #(
*                              Uuid = if_abap_behv=>mk-on
*                              Itemno = if_abap_behv=>mk-on
*                              Description = if_abap_behv=>mk-on  ) )
*                          TO <lfs_Item_en>-%target.

        ENDLOOP.

        LOOP AT lw_key-%param-_attach ASSIGNING FIELD-SYMBOL(<lfs_attach>).

          APPEND INITIAL LINE TO lt_attach ASSIGNING FIELD-SYMBOL(<lfs_Ztab_Attach>).

          <lfs_Ztab_Attach> = VALUE #( Uuid = <lfs_attach>-zuuid
                                       Itemno = <lfs_attach>-itemno
                                       attach = <lfs_attach>-attach ).

        ENDLOOP.

        IF lt_head[] IS NOT INITIAL.
          MODIFY ztable_head01 FROM TABLE @lt_head.
          IF sy-subrc EQ 0 .
            IF lt_item[] IS NOT INITIAL.
              MODIFY ztable_item01 FROM TABLE @lt_item.
            ENDIF.

            IF lt_attach[] IS NOT INITIAL.
              MODIFY ztable_attach FROM TABLE @lt_attach.
            ENDIF.

            IF lt_gb_head[] IS NOT INITIAL.
              MODIFY zglobal_head01 FROM TABLE @lt_gb_head.
            ENDIF.

            IF lt_gb_log[] IS NOT INITIAL.
              MODIFY zglobal_log01 FROM TABLE @lt_gb_log.
            ENDIF.

            IF lt_gb_cf[] IS NOT INITIAL.
              MODIFY zglobal_config01 FROM TABLE @lt_gb_cf.
            ENDIF.
          ENDIF.
        ENDIF.

*        MODIFY ENTITIES OF zi_table_head01 IN LOCAL MODE
*          ENTITY TableHead
*          CREATE FROM lt_head_en
*          ENTITY TableHead
*          CREATE BY \_Table_item01
*          FROM lt_item_en
*          MAPPED DATA(lw_mapped)
*          FAILED DATA(lw_failed)
*          REPORTED DATA(lw_reported).
*
*        LOOP AT lw_reported-tablehead INTO DATA(lw_report_head).
*          APPEND VALUE #( %msg = lw_report_head-%msg ) TO reported-tablehead.
*        ENDLOOP.
*
*        LOOP AT lw_reported-tableitem INTO DATA(lw_report_item).
*          APPEND VALUE #( %msg = lw_report_item-%msg ) TO reported-tableitem.
*        ENDLOOP.
*
*        IF lw_failed-tablehead IS INITIAL AND
*        lw_failed-tableitem IS INITIAL.
        IF sy-subrc EQ 0.
          APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<lfs_result>).
          <lfs_result>-%cid = lw_key-%cid.

          <lfs_result>-%param = CORRESPONDING #( DEEP lw_key-%param ).
          <lfs_result>-%param-document_no = lv_document_no.
          CASE abap_true.
            WHEN lv_create.
              <lfs_result>-%param-msg = 'Create successful.'.
            WHEN lv_update.
              <lfs_result>-%param-msg = 'Update successful'.
          ENDCASE.

        ELSE.
          APPEND INITIAL LINE TO result ASSIGNING <lfs_result>.
          <lfs_result>-%cid = lw_key-%cid.

          <lfs_result>-%param = CORRESPONDING #( DEEP lw_key-%param ).
          <lfs_result>-%param-document_no = lv_document_no.
          <lfs_result>-%param-msg = 'Create fail!.'.
        ENDIF.
*
*        ELSE.
*          failed-tablehead[] = lw_failed-tablehead[].
*          failed-tableitem[] = lw_failed-tableitem[].

      CATCH cx_root INTO DATA(lo_root).
        DATA(lv_exc_text) = lo_root->get_longtext(  ).
    ENDTRY.

  ENDMETHOD.

  METHOD DeleteData.
    TRY.
        DATA(lw_key) = keys[ 1 ].

        SELECT SINGLE @abap_true
        FROM ztable_head01
        WHERE uuid = @lw_key-%param-zuuid
        INTO @DATA(lv_head01).
        IF sy-subrc EQ 0 AND lv_head01 IS NOT INITIAL.
          DELETE FROM ztable_head01 WHERE uuid = @lw_key-%param-zuuid.
          DELETE FROM ztable_item01 WHERE uuid = @lw_key-%param-zuuid.
          DELETE FROM ztable_attach WHERE uuid = @lw_key-%param-zuuid.
          DELETE FROM zglobal_head01 WHERE uuid = @lw_key-%param-zuuid.
          DELETE FROM zglobal_log01 WHERE uuid = @lw_key-%param-zuuid.

          IF sy-subrc EQ 0.
            APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<lfs_result>).
            <lfs_result>-%cid = lw_key-%cid.

            <lfs_result>-%param = CORRESPONDING #( DEEP lw_key-%param ).
            <lfs_result>-%param-msg = 'Delete successful.'.
          ENDIF.
        ENDIF.

      CATCH cx_root INTO DATA(lo_root).
        DATA(lv_exc_text) = lo_root->get_longtext(  ).
    ENDTRY.

  ENDMETHOD.


  METHOD CreatePR.

    DATA:lv_number_range TYPE c LENGTH 8,
         lv_num_next     TYPE n LENGTH 8,
         lv_create       TYPE c,
         lv_update       TYPE c,
         lv_activity     TYPE c LENGTH 10.

    CLEAR: lv_number_range , lv_num_next , lv_create , lv_update , lv_activity.

    TRY.

        DATA(lw_key) = keys[ 1 ].

        SELECT SINGLE document_no
            FROM ztable_head01
            WHERE uuid = @lw_key-%param-zuuid
            INTO @DATA(lv_doc).
        IF sy-subrc EQ 0 AND lv_doc IS NOT INITIAL.
          lv_update = abap_true.
        ELSE.
          lv_create = abap_true.
        ENDIF.

        IF lv_doc IS INITIAL.
          SELECT SINGLE MAX( document_no_pr ) FROM ztable_head_pr
          INTO @DATA(lv_document_no).
          IF sy-subrc EQ 0.
            lv_num_next = lv_document_no+2(8).
            lv_num_next = lv_num_next + 1.
            lv_number_range = |{ lv_num_next ALPHA = IN }|.
*          lv_document_no+3(7) = lv_number_range.
            lv_document_no = |PR| & |{ lv_number_range  }|.

          ELSE.
            lv_num_next = 1.
            lv_number_range = |{ lv_num_next ALPHA = IN }|.

            lv_document_no = |PR| & |{ lv_number_range  }|.
          ENDIF.
        ELSE.
          lv_document_no = lv_doc.
        ENDIF.

        lt_head_pr = VALUE #( ( uuid_pr = lw_key-%param-zuuid
                             document_no_pr = lv_document_no
                             Comment01 = lw_key-%param-Comment01
                             Checkbox01 = lw_key-%param-Checkbox01
                             Approval = lw_key-%param-Approval ) ).

        IF lt_head_pr[] IS NOT INITIAL.
          lt_gb_head = VALUE #( ( Uuid = lw_key-%param-zuuid
                                  document_no = lv_document_no
                                  document_type = 'PR'
                                  current_status = 'Approve'
                                  create_by = sy-uname
                                  create_date = sy-datum
                                  create_time = sy-uzeit ) ).

          CASE abap_true.
            WHEN lv_create.
              lv_activity = 'CREATE'.
            WHEN lv_update.
              lv_activity = 'UPDATE'.
          ENDCASE.

          lt_gb_log = VALUE #( ( Uuid = lw_key-%param-zuuid
                                  document_no = lv_document_no
                                  approver = 'Siwakorn'
                                  change_date = sy-datum
                                  change_time = sy-uzeit
                                  change_user = sy-uname
                                  activity = lv_activity ) ).



        ENDIF.



        LOOP AT lw_key-%param-_item ASSIGNING FIELD-SYMBOL(<lfs_item>).


          APPEND INITIAL LINE TO lt_item_pr ASSIGNING FIELD-SYMBOL(<lfs_Ztab_Item_Pr>).

          <lfs_Ztab_Item_Pr> = VALUE #( uuid_pr = <lfs_item>-zuuid
                Itemno = <lfs_item>-itemno
                Description = <lfs_item>-description ).

        ENDLOOP.


        IF lt_head_pr[] IS NOT INITIAL.
          MODIFY ztable_head_pr FROM TABLE @lt_head_pr.
          IF sy-subrc EQ 0 .
            IF lt_item_pr[] IS NOT INITIAL.
              MODIFY ztable_item_pr FROM TABLE @lt_item_pr.
            ENDIF.


            IF lt_gb_head[] IS NOT INITIAL.
              MODIFY zglobal_head01 FROM TABLE @lt_gb_head.
            ENDIF.

            IF lt_gb_log[] IS NOT INITIAL.
              MODIFY zglobal_log01 FROM TABLE @lt_gb_log.
            ENDIF.

          ENDIF.
        ENDIF.

        IF sy-subrc EQ 0.
          APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<lfs_result>).
          <lfs_result>-%cid = lw_key-%cid.

          <lfs_result>-%param = CORRESPONDING #( DEEP lw_key-%param ).
          <lfs_result>-%param-document_no = lv_document_no.
          CASE abap_true.
            WHEN lv_create.
              <lfs_result>-%param-msg = 'Create successful.'.
            WHEN lv_update.
              <lfs_result>-%param-msg = 'Update successful'.
          ENDCASE.

        ELSE.
          APPEND INITIAL LINE TO result ASSIGNING <lfs_result>.
          <lfs_result>-%cid = lw_key-%cid.

          <lfs_result>-%param = CORRESPONDING #( DEEP lw_key-%param ).
          <lfs_result>-%param-document_no = lv_document_no.
          <lfs_result>-%param-msg = 'Create fail!.'.
        ENDIF.

      CATCH cx_root INTO DATA(lo_root).
        DATA(lv_exc_text) = lo_root->get_longtext(  ).
    ENDTRY.

  ENDMETHOD.

  METHOD DeletePR.
    TRY.
        DATA(lw_key) = keys[ 1 ].

        SELECT SINGLE @abap_true
        FROM ztable_head01
        WHERE uuid = @lw_key-%param-zuuid
        INTO @DATA(lv_head01).
        IF sy-subrc EQ 0 AND lv_head01 IS NOT INITIAL.
          DELETE FROM ztable_head_pr WHERE uuid_pr = @lw_key-%param-zuuid.
          DELETE FROM ztable_item_pr WHERE uuid_pr = @lw_key-%param-zuuid.
          DELETE FROM zglobal_head01 WHERE uuid = @lw_key-%param-zuuid.
          DELETE FROM zglobal_log01 WHERE uuid = @lw_key-%param-zuuid.

          IF sy-subrc EQ 0.
            APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<lfs_result>).
            <lfs_result>-%cid = lw_key-%cid.

            <lfs_result>-%param = CORRESPONDING #( DEEP lw_key-%param ).
            <lfs_result>-%param-msg = 'Delete successful.'.
          ENDIF.
        ENDIF.

      CATCH cx_root INTO DATA(lo_root).
        DATA(lv_exc_text) = lo_root->get_longtext(  ).
    ENDTRY.

  ENDMETHOD.

  METHOD GetData.
    TRY.
        DATA(lw_key) = keys[ 1 ].

        IF lw_key-%param-zuuid IS NOT INITIAL.

          SELECT *
          FROM ztable_head01
          WHERE uuid = @lw_key-%param-zuuid
          INTO TABLE @DATA(lt_head01).

        ELSE.

          SELECT *
          FROM ztable_head01
          INTO TABLE @lt_head01.

        ENDIF.

        IF sy-subrc EQ 0 AND lt_head01[] IS NOT INITIAL.
          SELECT *
          FROM ztable_item01
          FOR ALL ENTRIES IN @lt_head01
*          WHERE uuid = @lw_key-%param-zuuid
          WHERE uuid = @lt_head01-uuid
          INTO TABLE @DATA(lt_item01).

          SELECT *
          FROM ztable_attach
          FOR ALL ENTRIES IN @lt_head01
*          WHERE uuid = @lw_key-%param-zuuid
          WHERE uuid = @lt_head01-uuid
          INTO TABLE @DATA(lt_attach).

          IF sy-subrc EQ 0 AND lt_head01[] IS NOT INITIAL.
            LOOP AT lt_head01 INTO DATA(ls_head01).
              APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<lfs_result>).
              <lfs_result>-%cid = lw_key-%cid.

              <lfs_result>-%param = CORRESPONDING #( DEEP lw_key-%param ).
              MOVE-CORRESPONDING ls_head01 TO <lfs_result>-%param.

              IF lt_item01[] IS NOT INITIAL.
                DATA(lt_item_temp) = lt_item01[].
                DELETE lt_item_temp WHERE uuid NE ls_head01-uuid.
                IF lt_item_temp[] IS NOT INITIAL.
                  LOOP AT lt_item_temp INTO DATA(ls_item).

                    APPEND INITIAL LINE TO <lfs_result>-%param-_item ASSIGNING FIELD-SYMBOL(<lfs_item>).
                    MOVE-CORRESPONDING ls_item TO <lfs_item>.
                    <lfs_item>-zuuid = ls_item-uuid.

                  ENDLOOP.
                ENDIF.
              ENDIF.

              IF lt_attach[] IS NOT INITIAL.
                DATA(lt_attach_temp) = lt_attach[].
                DELETE lt_attach_temp WHERE uuid NE ls_head01-uuid.
                IF lt_attach_temp[] IS NOT INITIAL.
                  LOOP AT lt_attach_temp INTO DATA(ls_attach).

                    APPEND INITIAL LINE TO <lfs_result>-%param-_attach ASSIGNING FIELD-SYMBOL(<lfs_attach>).
                    MOVE-CORRESPONDING ls_attach TO <lfs_attach>.
                    <lfs_attach>-zuuid = ls_attach-uuid.

                  ENDLOOP.
                ENDIF.
              ENDIF.

              <lfs_result>-%param-msg = 'Get Data successful.'.
            ENDLOOP.
          ENDIF.
        ENDIF.

      CATCH cx_root INTO DATA(lo_root).
        DATA(lv_exc_text) = lo_root->get_longtext(  ).
    ENDTRY.
  ENDMETHOD.

ENDCLASS.
