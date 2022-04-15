;--------------------------------------
;
; ltoa.asm
;
; Convert signed long to ASCII
;


;--------------------------------------
;
; include defs, prototypes and macros
;

include tab6.inc

;--------------------------------------
;
; local prototypes
;

print_integer    PROTO PASCAL,number:WORD
divide_by_10     PROTO PASCAL,ms_word:WORD,ls_word:WORD
put_ascii_string PROTO PASCAL,ascii_val:BYTE

;--------------------------------------
;
; begin data segment
;

        .DATA

ascii_index     dw      0
ascii_string    db      12 DUP(?)

;--------------------------------------
;
; begin code segment
;

    .CODE

;--------------------------------------
;
; begin procedure
;

ltoa PROC PASCAL USES es ds si di,buffer:PBYTE,num:PWORD

; set ds:bx to point to binary number
; set es:si to point to ascii_buffer

        IF mdl eq 3
        mov     ax,SEG ascii_index
        mov     es,ax
        mov     si,OFFSET ascii_index
        lds     bx,num
        ELSE
        push    ds
        pop     es
        mov     si,ascii_index
        mov     bx,num
        ENDIF


; transfer long to DX:AX for Binary to ASCII xlation

        mov     ax,Word Ptr ds:[bx]
        inc     bx
        inc     bx
        mov     dx,Word Ptr ds:[bx]

; initialize index to 0        

        mov     ascii_index,0

; if long's MSW is 0 
; bypass writing minus sign

        cmp     dx, 0
        jge     bypass_minus
        push    ax
        INVOKE  put_ascii_string,'-'
        pop     ax
        neg     dx
        neg     ax
        sbb     dx, 0

bypass_minus:        

        INVOKE  print_integer,ax


; set es:[di] to point to buffer

        IF mdl eq 3
        les     di,buffer
        ELSE
        push    ds
        pop     es
        mov     di,buffer
        ENDIF

; set bx to number of digits

        mov     bx,ascii_index

; copy ascii_string to buffer (pointer)

copy_ascii_to_pointer:
        mov     al,ascii_string[bx]
        mov     es:[di][bx],al
        dec     bx
        jns     copy_ascii_to_pointer
        ret
ltoa    ENDP


;--------------------------------------
;
; print_integer converts AX ax binary 
; to ASCII integer
;

print_integer PROC PASCAL,number:WORD
        INVOKE  divide_by_10,dx,number
        cmp     ax, dx  
        jnz     continue_print_integer
        or      ax, ax
        jz      print_integer_done
continue_print_integer:
        push    bx
        INVOKE  print_integer,ax
        pop     bx
print_integer_done:
        mov     al, bl
        or      al, '0'
        INVOKE  put_ascii_string,al
        ret
print_integer ENDP


;--------------------------------------
; divide_by_10 divides DX:AX by 10 
; leaving the remainder in bl and the 
; quotient in DX:AX
;

divide_by_10 PROC PASCAL,ms_word:WORD,ls_word:WORD
        mov     dx,ms_word
        mov     ax,ls_word
        mov     cx,10
        mov     bx,ax
        xchg    ax,dx
        xor     dx,dx
        div     cx
        xchg    bx,ax
        div     cx
        xchg    dx,bx
        ret
divide_by_10 ENDP

;--------------------------------------
;
; put_ascii_string writes the 
; character in al to "ascii_string" .
;

put_ascii_string PROC USES di,ascii_val:BYTE
        mov     di,ascii_index
        mov     al,ascii_val
        mov     ascii_string[di],al
        mov     byte ptr ascii_string+1[di],0
        inc     ascii_index
        ret
put_ascii_string ENDP

        END

;
; end of ltoa.asm
;--------------------------------------
