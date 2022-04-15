;--------------------------------------
;
; initmb.asm 
;
; initialize menu bar
;  
;

;--------------------------------------
;
; include all defines, macros, 
; prototypes and set up memory model
;

include tab6.inc

;--------------------------------------
;
; Declare Code segment
;

        .CODE

initMB PROC PASCAL PUBLIC USES DS ES BX DI SI,mbptr:Ptr MENU_BAR,attr:Byte,i_attr:Byte,k_attr:Byte
        LOCAL   c8:Byte
;
; relocate Window structure data to locals
   IF mdl eq 1
        mov     bx,mbptr
   ELSE
        lds     bx,mbptr
   ENDIF
        mov     al,attr
        mov     (MBP [bx]).attr,al
        mov     al,i_attr
        mov     (MBP [bx]).iattr, al
        mov     al,k_attr
        mov     (MBP [bx]).k_attr,al
        ret
initMB ENDP

;
; End of source file

        END

;
;--------------------------------------
 
