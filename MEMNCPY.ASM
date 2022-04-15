;--------------------------------------
;
; memncpy.asm
;
; copy 'number' of bytes from source
; to destination string
;
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
; memncpy(value,number);
;
; memncpy requires that the
; PREPARE_STRING macro be utilized
; before memncpy is INVOKED
; 

memncpy	PROC PASCAL PUBLIC USES ds es si di cx,dest:PBYTE,srce:PBYTE,n:WORD,d_i:WORD

; initialize source

 IF mdl eq 3

; set dest es:[di]

        les     di,dest

; set srce ds:[si]

        lds     si,srce

  ELSE

        push    ds
        pop     es

; set dest es:[di]

        mov     di,dest

; set srce ds:[si]

        mov     si,srce

  ENDIF
	mov	cx,n
	add	di,d_i

	.WHILE 1
	mov	al,BYTE PTR ds:[si]
	mov	BYTE PTR es:[di],al
	inc	di
	inc	si
	dec	cx
	.BREAK .IF (cx==0)
	.ENDW
	ret	                       ; return to caller
memncpy	ENDP

;
; end of memncpy procedure
;
;--------------------------------------

	END

;
; end of memncpy.asm
;
;--------------------------------------


