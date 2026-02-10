CLASS lhc_ZI_TABLE_HEAD01 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR TableHead RESULT result.



    METHODS CreateData FOR MODIFY
      IMPORTING keys FOR ACTION TableHead~CreateData RESULT result.

*    METHODS delete FOR MODIFY
*      IMPORTING keys FOR DELETE TableHead .

ENDCLASS.

CLASS lhc_ZI_TABLE_HEAD01 IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD CreateData.
    DATA: lt_head_en      TYPE TABLE FOR CREATE zi_table_head01,
          lt_item_en      TYPE TABLE FOR CREATE zi_table_head01\_Table_item01,
          lt_head         TYPE TABLE OF ztable_head01,
          lt_item         TYPE TABLE OF ztable_item01,
          lv_number_range TYPE c LENGTH 7,
          lv_num_next     TYPE n LENGTH 7.

    CLEAR: lv_number_range , lv_num_next.

    TRY.

        DATA(lw_key) = keys[ 1 ].

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

        lt_head_en = VALUE #( ( %cid = 'CID_271'
                                Uuid = lw_key-%param-zuuid
                                DocumentNo = lv_document_no
                                Single01 = lw_key-%param-Single01
                                Single02 = lw_key-%param-Single02
                                Comment01 = lw_key-%param-Comment01
*                                RbChoice01 = lw_key-%param-rb_choice01
*                                RbChoice02 = lw_key-%param-rb_choice02
*                                RbChoice03 = lw_key-%param-rb_choice03
                                rb_requestor = lw_key-%param-rb_requestor
                                Checkbox01 = lw_key-%param-Checkbox01
                                Approval = lw_key-%param-Approval
                                    %control = VALUE #(
                                    Uuid = if_abap_behv=>mk-on
                                    DocumentNo = if_abap_behv=>mk-on
                                    Single01 = if_abap_behv=>mk-on
                                    Single02 = if_abap_behv=>mk-on
                                    Comment01 = if_abap_behv=>mk-on
*                                    RbChoice01 = if_abap_behv=>mk-on
*                                    RbChoice02 = if_abap_behv=>mk-on
*                                    RbChoice03 = if_abap_behv=>mk-on
                                    rb_requestor = if_abap_behv=>mk-on
                                    Checkbox01 = if_abap_behv=>mk-on
                                    Approval = if_abap_behv=>mk-on ) ) ).




        LOOP AT lw_key-%param-_item ASSIGNING FIELD-SYMBOL(<lfs_item>).


          APPEND INITIAL LINE TO lt_item ASSIGNING FIELD-SYMBOL(<lfs_Ztab_Item>).

*          APPEND INITIAL LINE TO lt_item_en ASSIGNING FIELD-SYMBOL(<lfs_Item_en>).
          APPEND VALUE #( %cid_ref = 'CID_271' )
                          TO lt_item_en
                          ASSIGNING FIELD-SYMBOL(<lfs_Item_en>).

          <lfs_Ztab_Item> = VALUE #( Uuid = <lfs_item>-zuuid
                          Itemno = <lfs_item>-itemno
                          Description = <lfs_item>-description ).

          APPEND VALUE #( Uuid = <lfs_item>-zuuid
                          Itemno = <lfs_item>-itemno
                          Description = <lfs_item>-description
                          %control = VALUE #(
                              Uuid = if_abap_behv=>mk-on
                              Itemno = if_abap_behv=>mk-on
                              Description = if_abap_behv=>mk-on  ) )
                          TO <lfs_Item_en>-%target.

        ENDLOOP.

*        IF lt_head[] IS NOT INITIAL.
*          MODIFY ztable_head01 FROM TABLE @lt_head.
*          IF sy-subrc EQ 0 AND lt_item[] IS NOT INITIAL.
**            COMMIt .
*            MODIFY ztable_item01 FROM TABLE @lt_item.
*            IF sy-subrc EQ 0.
**              COMMIT WORK.
*            ENDIF.
*          ENDIF.
*        ENDIF.

        MODIFY ENTITIES OF zi_table_head01 IN LOCAL MODE
          ENTITY TableHead
          CREATE FROM lt_head_en
          ENTITY TableHead
          CREATE BY \_Table_item01
          FROM lt_item_en
          MAPPED DATA(lw_mapped)
          FAILED DATA(lw_failed)
          REPORTED DATA(lw_reported).

        LOOP AT lw_reported-tablehead INTO DATA(lw_report_head).
          APPEND VALUE #( %msg = lw_report_head-%msg ) TO reported-tablehead.
        ENDLOOP.

        LOOP AT lw_reported-tableitem INTO DATA(lw_report_item).
          APPEND VALUE #( %msg = lw_report_item-%msg ) TO reported-tableitem.
        ENDLOOP.

        IF lw_failed-tablehead IS INITIAL AND
        lw_failed-tableitem IS INITIAL.

          APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<lfs_result>).
          <lfs_result>-%cid = lw_key-%cid.

          <lfs_result>-%param = CORRESPONDING #( DEEP lw_key-%param ).
          <lfs_result>-%param-document_no = lv_document_no.

        ELSE.
          failed-tablehead[] = lw_failed-tablehead[].
          failed-tableitem[] = lw_failed-tableitem[].
        ENDIF.

      CATCH cx_root INTO DATA(lo_root).
        DATA(lv_exc_text) = lo_root->get_longtext(  ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
