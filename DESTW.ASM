;--------------------------------------
;
; destw.asm 
;
; 1) frees up memory previously
;    allocated in initWind(...)
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
; destroyWind (WINDOW *wptr)
;

destroyWind PROC PASCAL USES ES DI DS BX,wptr:Ptr Window

;
; relocate Window structure data to locals
   IF mdl eq 1
        mov     bx,wptr
   ELSE
        lds     bx,wptr
   ENDIF
        mov     ax,(WINDOW Ptr [bx]).s_img ; relocate image segment
        INVOKE  free,ax
   .IF (ax == -8)
        INVOKE  error_abort,FREE_ERROR
   .ENDIF       
        mov     ax,(WINDOW Ptr [bx]).w_img ; relocate image segment
        INVOKE  free,ax
   .IF (ax == -8)
        INVOKE  error_abort,FREE_ERROR
   .ENDIF       
        ret
destroyWind ENDP

;
; End of source file

        END

;
;--------------------------------------
 
