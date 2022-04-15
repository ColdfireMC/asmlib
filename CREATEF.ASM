;--------------------------------------
;
; createf.asm
; 
; create file via DOS
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

createFile PROC PASCAL USES ds dx es di,handle:PWORD,filename:PBYTE,attr:WORD

; create file DOS function to ah

        mov     ah,3ch

; create file attribute to cx

        mov     cx,attr

; ds:dx points to filename

        IF mdl eq 3
        lds     dx,filename
        ELSE
        push    ds
        pop     es
        mov     dx,filename
        ENDIF

; create file via int 21h

        int     21h

; carry set on error / branch on error

        jc      dos_error

; no error so return file handle
; and return 0 to caller via ax

        IF mdl eq 3
        les     di,handle
        ELSE
        push    ds
        pop     es
        mov     di,handle
        ENDIF

        mov     Word Ptr es:[di],ax
        sub     ax,ax
        ret

; on error return 0 to handle and
; error code via ax

dos_error:

        IF mdl eq 3
        les     di,handle
        ELSE
        push    ds
        pop     es
        mov     di,handle
        ENDIF

        mov     Word Ptr es:[di],0
        ret

createFile ENDP

        END

;
; end of createf.asm
;--------------------------------------



