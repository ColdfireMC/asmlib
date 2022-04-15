;--------------------------------------
;
; itoh.asm
;
; Convert word to ASCII hex
;


;--------------------------------------
;
; include defs, prototypes and macros
;

include tab6.inc

p_ascii_string PROTO PASCAL,ascii_val:BYTE
hex_to_ascii   PROTO PASCAL,num:WORD

;--------------------------------------
;
; begin data segment
;

        .DATA

ascii_index     dw      0
ascii_string    db      8 DUP(?)


;--------------------------------------
;
; begin code segment
;

    .CODE

;--------------------------------------
;
; begin procedure
;


itoh PROC PASCAL USES es ds si di,buffer:PBYTE,num:WORD,num_bits:BYTE
        mov     ax,num
        mov    ascii_index, 0
        .IF (num_bits == HEX_16_BIT)
        xchg    al, ah
        INVOKE    hex_to_ascii,ax
        xchg    al, ah
        .ENDIF
        INVOKE    hex_to_ascii,ax

;
; Move the digit string out onto the heap and return a pointer to it in
; es:si.
;
        mov    bx, ascii_index

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
;
itoh ENDP
;
;
;
hex_to_ascii  PROC PASCAL,num:WORD
        LOCAL   holder:WORD
        mov     holder,ax
;        push    ax
        mov    ah, al
        shr    al, 1
        shr    al, 1
        shr    al, 1
        shr    al, 1
        add    al, 90h
        daa
        adc    al, 40h
        daa
        INVOKE  p_ascii_string,al
        mov    al, ah
        and    al, 0fh
        add    al, 90h
        daa
        adc    al, 40h
        daa
        INVOKE  p_ascii_string,al
        mov     ax,holder
;        pop     ax
        ret
hex_to_ascii        endp

;--------------------------------------
; p_ascii_string writes the character 
; in al to ascii_string
;
p_ascii_string PROC USES di,ascii_val:BYTE
        mov    di, ascii_index
        mov     al,ascii_val
        mov    ascii_string[di], al
        mov    byte ptr ascii_string+1[di], 0
        inc     ascii_index
        ret
p_ascii_string ENDP


        END

;
; end of itoh.asm
;--------------------------------------



