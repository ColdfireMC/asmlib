;--------------------------------------
;
; closef.asm
; 
; close file via DOS
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

closeFile PROC PASCAL USES ds dx es di,handle:WORD

; close file DOS function to ah

        mov     ah,3eh

; close file attribute to bx

        mov     bx,handle

; close file via int 21h

        int     21h

; carry set on error / branch on error

        jc      dos_error

; no error so return 0 to caller via ax

        sub     ax,ax
        ret

; on error return error code via ax
; error code via ax

dos_error:

        ret

closeFile ENDP

        END

;
; end of closef.asm
;--------------------------------------



