;--------------------------------------
;
; initddw.asm 
;
; initialize drop down window structure
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

initDDW PROC PASCAL PUBLIC USES DS ES BX DI SI,ddptr:Ptr DROP_DOWN,miptr:Ptr M_ITEM,attr:Byte,i_attr:Byte,k_attr:Byte
        LOCAL   c8:Byte
;
; relocate Window structure data to locals
   IF mdl eq 1
        mov     bx,ddptr
   ELSE
        lds     bx,ddptr
   ENDIF
        mov     al,k_attr
        mov     (DDP [bx]).k_attr,al
        mov     al,i_attr
        mov     (DDP [bx]).iattr, al
        mov     al,(DDP [bx]).ddwind.lc
        mov     dl,(DDP [bx]).ddwind.uc
        sub     al,dl
        dec     al
        mov     (DDP [bx]).i_len,al 
        INVOKE  initWind, ADDR (DDP [bx]).ddwind,attr

        ret
initDDW ENDP

;
; End of source file

        END

;
;--------------------------------------
 
