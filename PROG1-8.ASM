;--------------------------------------
;
; prog1-8.asm
;
; Demonstration of MASM 6.0 PROTO, PROC
; and INVOKE directives
;

; defines here

WRITE_STRING        equ    13h
SCROLL_WINDOW       equ    06h
CLEAR_WINDOW        equ    00h
NORMAL_ATTR         equ    07h
SET_CURSOR_POSITION equ    02h

;--------------------------------------
;
; procedure prototypes
;

IF mdl EQ 3
    mvCur      PROTO FAR C, row:BYTE, col:BYTE
    clrScrn    PROTO FAR C, s_attr:BYTE
    bdWrite    PROTO FAR C, row:BYTE, col:BYTE
ELSE
    mvCur      PROTO NEAR C, row:BYTE, col:BYTE
    clrScrn    PROTO NEAR C, s_attr:BYTE
    bdWrite    PROTO NEAR C, row:BYTE, col:BYTE
ENDIF


;--------------------------------------
;
; macros
;

;--------------------------------------
;
; PREPARE_STRING
;
; This macro MUST be invoked before any
; string routines are invoked
;

PREPARE_STRING MACRO name

; if large model then set es register
; to @FARDATA

  IF mdl eq 3
    push   es
    push   ax
    mov    ax,@FARDATA
    mov    es,ax
    mov    es:[wparam1],SEG name     
    mov    es:[wparam2],OFFSET name
    pop    ax
    pop    es
  ELSE

; if small model then use default ds
; register

    mov    [wparam1],SEG name
    mov    [wparam2],OFFSET name
  ENDIF
    ENDM


;--------------------------------------
;
; select memory model
;

IF mdl EQ 3
    .Model large,C
ELSE
    .Model small,C
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

IF mdl EQ 3
    .FARDATA
ELSE
    .DATA
ENDIF

hello      db    'Hello Chuck!',0
counter    db    0                ; loop counter
wparam1    dw    ?
wparam2    dw    ?

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

mvCur PROC C PUBLIC, row:BYTE, col:BYTE
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

clrScrn PROC C PUBLIC, s_attr:BYTE
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

bdWrite PROC C PUBLIC USES es ds si, row:BYTE, col:BYTE
    INVOKE  mvCur,row,col
  IF mdl eq 3
    mov    ax,@FARDATA
    mov    es,ax
    mov    ax,es:[wparam1]
    mov    ds,ax
    mov    ax,es:[wparam2]
    mov    si,ax
  ELSE
    mov    ax,[wparam1]
    mov    ds,ax
    mov    ax,[wparam2]
    mov    si,ax
  ENDIF
    mov    ah,0eh
    mov    bh,0
  .WHILE 1
    lodsb
  .BREAK .IF (al==0)
    int    10h
  .ENDW
    ret                           ; return to caller
bdWrite    ENDP

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

IF mdl EQ 3
    push   ds                     ; save ds register
    mov    ax,SEG hello           ; set ds register to
    mov    ds,ax                  ; far data segment of
    assume ds:SEG hello           ; hello
ENDIF

; create loop which goes through 20 iterations

  .WHILE 1                        ; repeat in endless loop
    PREPARE_STRING hello
    INVOKE bdWrite, counter, counter
    inc    counter                ; increment counter by 1
   .BREAK .IF (counter==20)       ; break out of loop if counter == 20
  .ENDW                           ; end while

IF mdl EQ 3
    pop    ds                     ; restore ds
ENDIF

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