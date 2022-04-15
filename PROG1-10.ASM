;--------------------------------------
;
; prog1-10.asm
;
; Demonstration of MASM 6.0 PROTO, PROC
; and INVOKE directives using PASCAL
; calling conventions with includes for
; both procedure prototypes and defines
;

; defines here

include def6.inc

;--------------------------------------
;
; procedure prototypes
;

IF mdl EQ 3
    include proto6l.inc
ELSE
    include proto6s.inc
ENDIF


;--------------------------------------
;
; include macros
;

include mac6.inc

;--------------------------------------
;
; select memory model
;

IF mdl EQ 3
    .Model large,PASCAL
ELSE
    .Model small,PASCAL
ENDIF  

;--------------------------------------
;
; Create stack
;

    .Stack                        ; 1 k by default

;--------------------------------------
;
; Declare data segment
;

    .Data

hello      db    'Hello Chuck!',0
counter    db    0                ; loop counter

;--------------------------------------
;
; Begin code segment
;

    .Code

;--------------------------------------
;
; mvCur(unsigned char row,
;       unsigned char col);
;

mvCur PROC PASCAL PUBLIC, row:BYTE, col:BYTE
    mov    dh,row                 ; set row
    mov    dl,col                 ; set column
    mov    bh,0                   ; on page 0
    mov    ah,SET_CURSOR_POSITION ; muve cursor function 02h
    int    10h                    ; via BIOS int 10h
    ret                           ; return to caller
mvCur ENDP

;
; end of mvCur procedure
;
;--------------------------------------

;--------------------------------------
;
; clrScrn(unsigned char attr)
;
; clears the screen via BIOS scroll
; function and allows attribute to be
; set
;

clrScrn PROC PASCAL PUBLIC, s_attr:BYTE
    mov    ah,SCROLL_WINDOW       ; scroll window function
    mov    al,CLEAR_WINDOW        ; used to clear window
    mov    bh,s_attr              ; with the designated attribute
    mov    ch,0                   ; window upper left row = 0
    mov    cl,0                   ; window upper left col = 0
    mov    dh,24                  ; window lower right row = 24
    mov    dl,79                  ; window lower right col = 79
    int    10h                    ; clear window via BIOS
    ret                           ; return to caller
clrScrn ENDP

;
; end of clrScrn procedure
;
;--------------------------------------

;--------------------------------------
;
; bdWrite(unsighed char row,
;         unsigned char col)
;
; All string writes require that the
; PREPARE_STRING macro by invoked
; 

bdWrite PROC PASCAL PUBLIC USES ds si, row:BYTE, col:BYTE, str1:PBYTE
    INVOKE mvCur, row, col
  IF mdl eq 3
    lds    si,str1
  ELSE
    mov    si,str1
  ENDIF
    mov    ah,0eh
    mov    bh,0
  .WHILE 1
    lodsb
  .BREAK .IF    (al==0)
    int    10h
  .ENDW
    ret                           ; return to caller
bdWrite ENDP

;
; end of bdWrite procedure
;
;--------------------------------------

;--------------------------------------
;
; Start program here
;

    .Startup

;--------------------------------------
;
; clear the screen via bios with the
; normal attribute
;

    INVOKE clrScrn, NORMAL_ATTR    

;--------------------------------------
;
; move cursor to row 0 column 0
;

    INVOKE mvCur, 0, 0


;--------------------------------------
;
; Main body of program here
; where DOS interrupt 21h function
; 09h is used to print the now-
; infamous "Hello CHuck!" message
; to the screen
;

; create loop which goes through 20 iterations

  .WHILE 1                        ; repeat in endless loop
    INVOKE bdWrite, ds:counter, ds:counter, ADDR hello
    inc    ds:counter             ; increment counter by 1
   .BREAK .IF (ds:counter==20)    ; break out of loop if counter == 20
  .ENDW                           ; end while

;--------------------------------------
;
; move the cursor to the bottom of
; the screen
;

    INVOKE mvCur, 23, 0           ; move cur row 23, col 0


;--------------------------------------
;
; End program and return to DOS
;

    .Exit

;--------------------------------------
;
; End of ASSEMBLY source file
;

    END


;
;--------------------------------------
