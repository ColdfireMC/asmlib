;--------------------------------------
;
; add32.asm
;
; add 32 bit srce value to 32 bit dest
; value and place result in 32 bit
; dest value
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
; add32(value,number);
;
; add32 requires that the
; PREPARE_STRING macro be utilized
; before add32 is INVOKED
; 

add32	PROC PASCAL PUBLIC USES ds es si di bx cx dx,dest:PWORD,srce:PWORD

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

; ax:bx holds srce operand

        mov     ax,Word Ptr ds:[si] ; upper 16 bit srce
        add     si,2                ; point to lower 16 bits
        mov     bx,Word Ptr ds:[si] ; lower 16 bit srce

; cx:dx holds dest operand 

        mov     cx,Word Ptr es:[di] ; upper 16 bit dest
        add     di,2                ; point to lower 16 bits
        mov     dx,Word Ptr es:[di] ; lower 16 bit dest
        sub     di,2

; add srce to dest and place result
; in dest (cx:dx)

        add     dx,bx               ; add lower 16 bits
        adc     cx,ax               ; add upper i6 bits

; place result in dest

        mov     Word Ptr es:[di],cx ; move upper 16 bits to dest
        add     di,2                ; point to lower 16 bits
        mov     Word Ptr es:[di],dx ; move lower 16 bits to dest
        ret

add32	ENDP

;
; end of add32 procedure
;
;--------------------------------------

	END

;
; end of add32.asm
;
;--------------------------------------


