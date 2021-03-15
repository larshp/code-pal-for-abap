"https://help.sap.com/saphelp_me150/helpdata/en/49/268dc67b6716b4e10000000a42189d/content.htm?no_cache=true

CLASS ltc_assert_equals DEFINITION INHERITING FROM y_unit_test_base FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.
  PROTECTED SECTION.
    METHODS get_cut REDEFINITION.
    METHODS get_code_with_issue REDEFINITION.
    METHODS get_code_without_issue REDEFINITION.
    METHODS get_code_with_exemption REDEFINITION.
ENDCLASS.

CLASS ltc_assert_equals IMPLEMENTATION.

  METHOD get_cut.
    result ?= NEW y_check_invalid_unit_test( ).
  ENDMETHOD.

  METHOD get_code_with_issue.
    result = VALUE #(
      ( ' REPORT y_example. ' )

      ( ' CLASS y_example DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT. ' )
      ( '   PUBLIC SECTION. ' )
      ( '     METHODS sum FOR TESTING. ' )
      ( ' ENDCLASS. ' )

      ( ' CLASS y_example IMPLEMENTATION. ' )
      ( '   METHOD sum. ' )
      ( '     " given ' )
      ( '     DATA(first) = 10. ' )
      ( '     DATA(second) = 10. ' )
      ( '     " when ' )
      ( '     DATA(sum) = first + second. ' )
      ( '     " then ' )
      ( '     cl_abap_unit_assert=>assert_equals( act = sum  ' )
      ( '                                         exp = sum ). ' )
      ( '   ENDMETHOD. ' )
      ( ' ENDCLASS. ' )
    ).
  ENDMETHOD.

  METHOD get_code_without_issue.
    result = VALUE #(
      ( ' REPORT y_example. ' )

      ( ' CLASS y_example DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT. ' )
      ( '   PUBLIC SECTION. ' )
      ( '     METHODS sum FOR TESTING. ' )
      ( ' ENDCLASS. ' )

      ( ' CLASS y_example IMPLEMENTATION. ' )
      ( '   METHOD sum. ' )
      ( '     " given ' )
      ( '     DATA(first) = 10. ' )
      ( '     DATA(second) = 10. ' )
      ( '     " when ' )
      ( '     DATA(sum) = first + second. ' )
      ( '     " then ' )
      ( '     cl_abap_unit_assert=>assert_equals( act = sum  ' )
      ( '                                         exp = 20 ). ' )
      ( '   ENDMETHOD. ' )
      ( ' ENDCLASS. ' )
    ).
  ENDMETHOD.

  METHOD get_code_with_exemption.
    result = VALUE #(
      ( ' REPORT y_example. ' )

      ( ' CLASS y_example DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT. ' )
      ( '   PUBLIC SECTION. ' )
      ( '     METHODS sum FOR TESTING. ' )
      ( ' ENDCLASS. ' )

      ( ' CLASS y_example IMPLEMENTATION. ' )
      ( '   METHOD sum. ' )
      ( '     " given ' )
      ( '     DATA(first) = 10. ' )
      ( '     DATA(second) = 10. ' )
      ( '     " when ' )
      ( '     DATA(sum) = first + second. ' )
      ( '     " then ' )
      ( '     cl_abap_unit_assert=>assert_equals( act = sum  ' )
      ( '                                         exp = sum ). "#EC INVAL_UT ' )
      ( '   ENDMETHOD. ' )
      ( ' ENDCLASS. ' )
    ).
  ENDMETHOD.

ENDCLASS.
