;--------------------------------------
;
; kbStat.asm
;
; Gets current status of the keyboard
; (does not stop and wait for key press)
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

kbStat  PROC PASCAL PUBLIC 
        mov     ax,0100h ; read keyboard status
        int     16h      ; via BIOS
        jnz     yes_key  ; yes key waiting
        mov     ax,00h   ; return 0 on no key
        ret              ; return to caller
yes_key:                  ; return 0 on
        xor     ax,ax    ; key press waiting
        int     16h      ; retrieve key press
        ret              ; return to caller
kbStat  ENDP

        END

;
;--------------------------------------
