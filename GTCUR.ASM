;--------------------------------------
;
; gtcur.asm
;
; gets the cursor info
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


    .Code

;--------------------------------------
;
; gtCur(void)
;  
;

gtCur PROC Pascal PUBLIC
    mov    bh,0                   ; page 0 cursor
    mov    ah,GET_CURSOR_CONFIG   ; get cursor configuration
    int    10h                    ; via BIOS int 10h
    mov    cursor_start,ch        ; save shape start
    mov    cursor_end,cl          ; save shape end
    mov    cursor_row,dh          ; save row
    mov    cursor_column,dl       ; save column
    ret                           ; return to caller
gtCur ENDP

;
; end of gtCur procedure
;

    END
;
;--------------------------------------
