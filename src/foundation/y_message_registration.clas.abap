CLASS y_message_registration DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS add_message
      IMPORTING
        !check_name     TYPE csequence
        !text           TYPE itex132
        !pseudo_comment TYPE sci_pcom OPTIONAL
      CHANGING
        !messages       TYPE scimessages .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS y_message_registration IMPLEMENTATION.


  METHOD add_message.
    INSERT VALUE #( test = check_name
                    code = y_check_base=>c_code-error
                    kind = cl_ci_test_root=>c_error
                    text = text
                    pcom = pseudo_comment+5 ) INTO TABLE messages[].
    INSERT VALUE #( test = check_name
                    code = y_check_base=>c_code-warning
                    kind = cl_ci_test_root=>c_warning
                    text = text
                    pcom = pseudo_comment+5 ) INTO TABLE messages[].
    INSERT VALUE #( test = check_name
                    code = y_check_base=>c_code-notification
                    kind = cl_ci_test_root=>c_note
                    text = text
                    pcom = pseudo_comment+5 ) INTO TABLE messages[].
  ENDMETHOD.
ENDCLASS.
