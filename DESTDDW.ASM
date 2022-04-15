;--------------------------------------
;
; destddw.asm 
;
; frees up memory previously
; allocated in initWind(...)
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

;--------------------------------------
;

destroyDDW  PROC PASCAL PUBLIC USES DS ES BX DI SI,ddptr:Ptr DROP_DOWN

;--------------------------------------
; relocate Window structure data to locals

  IF mdl eq 1
   mov     bx,ddptr
  ELSE
   lds     bx,ddptr
  ENDIF
   INVOKE  destroyWind, ADDR (DDP [bx]).ddwind
   ret

destroyDDW ENDP

   END
;
;--------------------------------------
 
