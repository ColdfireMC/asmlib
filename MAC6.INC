;--------------------------------------
;
; mac6.inc
;
; MASM 6.0 macros listings for 
; libraries and functions
;

;--------------------------------------
;
; SAVE_ATTRIBUTE
;
; This macro MUST be invoked after
; mkAttr is INVOKED
;

SAVE_ATTRIBUTE MACRO name
   mov   name,al
   ENDM

;--------------------------------------
;
; SAVE_TOKEN
;
; This macro MUST be invoked after
; vrdchar is INVOKED
;

SAVE_TOKEN MACRO
   mov   char_value,al
   mov   attribute_value,ah
   mov   token_value,ax
   ENDM
