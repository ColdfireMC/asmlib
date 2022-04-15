;--------------------------------------
;
; kbRead.asm
;
; Gets current status of the keyboard
; (stops and waits for key press)
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

kbRead  PROC PASCAL PUBLIC 
        xor     ax,ax   ; invoke func. 00h to
        int     16h     ; retrieve key waiting
        ret             ; return to caller
kbRead  ENDP

        END

;
;--------------------------------------
