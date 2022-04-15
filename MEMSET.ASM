;--------------------------------------
;
; memset.asm
;
; set designated number of memory bytes
; to a specidfied value
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

;--------------------------------------
;
; memset(value,number);
;
; memset requires that the
; PREPARE_STRING macro be utilized
; before memset is INVOKED
; 

memset	PROC PASCAL PUBLIC USES ds es,srce:PBYTE,value:BYTE,number:WORD

 IF mdl eq 3

        les     di,srce

  ELSE
        push    ds
        pop     es
        mov     di,srce

  ENDIF
	mov	al,value
	mov	cx,number
  .REPEAT
	mov	BYTE PTR es:[di],al
	inc	di
	dec	cx
  .UNTIL (cx==0)
	ret	                       ; return to caller
memset	ENDP

;
; end of memset procedure
;
;--------------------------------------

	END

;
; end of memset.asm
;
;--------------------------------------


