;--------------------------------------
;
; malloc.asm
;
; malloc(int size)
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

malloc PROC PASCAL PUBLIC USES es ds bx,byte_num:WORD

        mov     ax,byte_num ; Buffer size converter is
        shr     ax,1        ; converted to 16 byte paragraphs
        shr     ax,1        ; by dividing by 16 and adding 1
        shr     ax,1        ; for remainder correction.
        shr     ax,1        ; BX receives the number of
        inc     ax          ; round up one paragraph
        mov     bx,ax       ; paragraphs to allocate.
        mov     ah,48h      ; Allocate memory via DOS function
        int     21h         ; Invoke DOS interrupt
        jc      malloc_err  ; Jump on malloc allocation error
        ret                 ; AX holds Segment of allocated block
malloc_err:                 ; Return -8 on insufficient memory
        cmp     AX,8        ; ERROR -> Insufficient Memory?
        je      code_8      ; Branch to return -8
        mov     ax,-7       ; ERROR -> MCBs destroyed
        ret                 ; return code
code_8:                     ; prep code
        mov     ax,-8       ; -8
        ret                 ; and return to caller

malloc	ENDP

	END

;
;--------------------------------------
	
	

