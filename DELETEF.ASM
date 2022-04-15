;--------------------------------------
;
; deletef.asm
; 
; delete file via DOS
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

deleteFile PROC PASCAL USES ds dx,filename:PBYTE

; delete file DOS function to ah

        mov     ah,41h

; ds:dx points to filename

        IF mdl eq 3
        lds     dx,filename
        ELSE
        push    ds
        pop     es
        mov     dx,filename
        ENDIF

; delete file via int 21h

        int     21h

; carry set on error / branch on error

        jc      dos_error

; no error return 0 to caller via ax
        sub     ax,ax
        ret

; on error return 0 to handle and
; error code via ax

dos_error:

        ret

deleteFile ENDP

        END

;
; end of deletef.asm
;--------------------------------------



