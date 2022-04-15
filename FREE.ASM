;--------------------------------------
;
; free.asm
;
; free(int size)
;
; int size    size in bytes of mem allocation request
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

free PROC PASCAL PUBLIC USES es ds bx,mem_seg:WORD
        mov     ax,mem_seg  ; transfer segment to
        mov     es,ax       ; es register
        mov     ax,4900h    ; release memory via DOS function
        int     21h         ; Invoke DOS interrupt
        jc      free_err    ; Jump on free allocation error
        ret                 ; AX holds Segment of allocated block
free_err:                   ; Return -8 on insufficient memory
        cmp     AX,8        ; ERROR -> Insufficient Memory?
        je      code_8      ; Branch to return -8
        mov     ax,-7       ; ERROR -> MCBs destroyed
        ret                 ; return code
code_8:                     ; prep code
        mov     ax,-8       ; -8
        ret                 ; and return to caller

free	ENDP

	END

;
;--------------------------------------
	
	

