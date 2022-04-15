;--------------------------------------
;
; mkToken.asm
;
; make an attribute Byte
;
; receives: 
; Byte character
; Byte attribute
;

;--------------------------------------
;
; include defs, prototypes and macros
;

include tab6.inc

;--------------------------------------
;
; begin code segment
;

    .CODE

;--------------------------------------
;
; mkToken(unsigned char char,
;         unsigned char attribute)

mkToken PROC Pascal PUBLIC, kchar:Byte, attr:Byte
        mov     al,kchar               ; char goes in LSB
        mov     ah,attr                ; attribute in MSB
        ret                            ; return to caller
mkToken ENDP

    END
;
;--------------------------------------




