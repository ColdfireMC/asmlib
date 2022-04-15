;--------------------------------------
;
; mkAttr.asm
;
; make an attribute byte
;
; receives: 
; Byte foreground color
; Byte background color
; Byte intensity
; Byte blink on off
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

    .Code

;--------------------------------------
;
; mkAttr(unsigned char fore_color,
;        unsigned char back_color,
;        unsigned char intensity,
;        unsigned char blink);


mkAttr PROC Pascal PUBLIC USES es ds di, a:PByte, 
                                         f_c:Word, 
                                         b_c:Word, 
                                         i_t:Word, 
                                         b_t:Word

IF mdl eq 3
   les     di,a
ELSE
   mov     di,a
   push    ds
   pop     es
ENDIF
    xor    ax,ax    ; 0 -> AX
    mov    ax,b_c   ; back ground color to AL
    mov    cl,4     ; prep shift 4 left
    shl    ax,cl    ; means AL * 16
    or     ax,f_c   ; or foreground color
    or     ax,i_t   ; or intensity
    or     ax,b_t   ; or blink

    mov    es:[di],al

    ret
mkAttr ENDP


    END
;
;--------------------------------------
