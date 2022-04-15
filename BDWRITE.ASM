;--------------------------------------
;
; bdwrite.asm
;
; write text to screen in teletype 
; fashion at a specified row and column
; location via the BIOS
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
; bdWrite(unsighed char row,
;         unsigned char col,
;         char *string)
;
; All string writes require that the
; PREPARE_STRING macro by invoked
; 

bdWrite PROC Pascal PUBLIC USES ds si, row:Byte, col:Byte, str1:PByte

; move the cursor to row, col

    INVOKE  mvCur, row, col

; set ds:[si] to point to address of string

 IF mdl eq 3
        lds     si,str1
  ELSE
        mov     si,str1
  ENDIF

; set regs for BIOS print 

    mov    ah,0eh                 ; print char BIOS function
    mov    bh,0                   ; on page 0

;  print until end of string (0) reached

  .WHILE 1                        ; initiate endless loop
    lodsb                         ; get char from string to al
  .BREAK .IF    (al==0)           ; 0 => end loop
    int    10h                    ; invoke BIOS for print
  .ENDW                           ; end of .WHILE loop
    ret                           ; return to caller
bdWrite ENDP

;
; end of bdWrite procedure
;

    END
;
;--------------------------------------


