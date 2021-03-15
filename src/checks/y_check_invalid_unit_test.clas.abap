CLASS y_check_invalid_unit_test DEFINITION PUBLIC INHERITING FROM y_check_base CREATE PUBLIC .
  PUBLIC SECTION.
    METHODS constructor.

  PROTECTED SECTION.
    METHODS inspect_tokens REDEFINITION.

  PRIVATE SECTION.
    METHODS get_act_and_exp IMPORTING statement TYPE sstmnt
                            EXPORTING act TYPE string
                                      exp TYPE string.

ENDCLASS.


CLASS y_check_invalid_unit_test IMPLEMENTATION.


  METHOD constructor.
    super->constructor( ).

    settings-pseudo_comment = '"#EC INVAL_UT' ##NO_TEXT.
    settings-disable_threshold_selection = abap_true.
    settings-apply_on_productive_code = abap_false.
    settings-apply_on_test_code = abap_true.
    settings-threshold = 0.
    settings-documentation = |{ c_docs_path-checks }invalid_unit_test.md|.

    relevant_statement_types = VALUE #( ( scan_struc_stmnt_type-method ) ).
    relevant_structure_types = VALUE #( ).

    set_check_message( 'Why?!' ).
  ENDMETHOD.


  METHOD inspect_tokens.
    CHECK get_token_abs( statement-from ) CP 'CL_ABAP_UNIT_ASSERT=>ASSERT_EQUALS*'.

    get_act_and_exp( EXPORTING statement = statement
                     IMPORTING act = DATA(act)
                               exp = DATA(exp) ).

    IF act <> exp.
      RETURN.
    ENDIF.

    DATA(check_configuration) = detect_check_configuration( statement ).

    IF check_configuration IS INITIAL.
      RETURN.
    ENDIF.

    raise_error( statement_level = statement-level
                 statement_index = index
                 statement_from  = statement-from
                 error_priority  = check_configuration-prio ).
  ENDMETHOD.


  METHOD get_act_and_exp.
    LOOP AT ref_scan_manager->tokens ASSIGNING FIELD-SYMBOL(<token>)
    FROM statement-from TO statement-to.
      DATA(tabix) = sy-tabix.
      CASE <token>-str.
        WHEN 'ACT'.
          act = get_token_abs( tabix + 2 ).
        WHEN 'EXP'.
          exp = get_token_abs( tabix + 2 ).
        WHEN OTHERS.
          CONTINUE.
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
