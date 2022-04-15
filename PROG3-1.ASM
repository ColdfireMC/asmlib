;--------------------------------------
;
; prog13.asm
;
; Demonstration of 
;   vdAttr
;   vidInit
;   vdWrite
;  
;

;--------------------------------------
;
; include all defines, macros, 
; prototypes and set up memory model
;

include tab6.inc


;--------------------------------------
;
; Create stack
;

    .Stack                         ; 1 k by default

;--------------------------------------
;
; Declare data segment
;

    .Data

scrn_b   dw      2000 DUP(0)

attr1    db    ?
attr2    db    ?
attr3    db    ?
attr4    db    ?
message0 db    '                              ', 0
message1 db    '  Direct Video Demonstration  ', 0
message2 db    '                              ', 0

;--------------------------------------
;
; Begin code segment
;

    .Code


;--------------------------------------
;
; Start program here
;

    .Startup

;--------------------------------------
;

    INVOKE vidInit

;--------------------------------------
; 
; save the screen image
;

    INVOKE saveScrn, ADDR scrn_b

;--------------------------------------
;
; make the attributes
;

    INVOKE mkAttr, ADDR attr1, WHITE, RED, OFF_INTENSITY, OFF_BLINK

    INVOKE mkAttr, ADDR attr2, WHITE, BLUE, ON_INTENSITY, OFF_BLINK

    INVOKE mkAttr, ADDR attr3, WHITE, GREEN, ON_INTENSITY, OFF_BLINK

    INVOKE mkAttr, ADDR attr4, WHITE, MAGENTA, ON_INTENSITY, OFF_BLINK

;--------------------------------------
;
; save the cursor shape and location
;

    INVOKE gtCur

;--------------------------------------
;
; turn off the cursor
;

    INVOKE offCur

;--------------------------------------
;
; clear the screen via bios with the
; attr1
;

    INVOKE clrScrn, attr1    

;--------------------------------------
; prepare string for string write via 
;         BIOS and
; write program messages at 3 locations

; location 1

    INVOKE vdWrite, 11, 30, 0, ADDR message0, attr2

    INVOKE vdWrite, 12, 30, 0, ADDR message1, attr2

    INVOKE vdWrite, 13, 30, 0, ADDR message2, attr2

; location 2

    INVOKE vdWrite, 20, 46, 0, ADDR message0, attr3

    INVOKE vdWrite, 21, 46, 0, ADDR message1, attr3

    INVOKE vdWrite, 22, 46, 0, ADDR message2, attr3

; location 3

    INVOKE vdWrite, 3, 3, 0, ADDR message0, attr4

    INVOKE vdWrite, 4, 3, 0, ADDR message1, attr4

    INVOKE vdWrite, 5, 3, 0, ADDR message2, attr4

;--------------------------------------
;
; write the four screen border 
; characters
;

    INVOKE vdChar, 0, 0, 201, attr1   ;UL
    INVOKE vdChar, 24, 0, 200, attr1  ;LL
    INVOKE vdChar, 0, 79, 187, attr1  ;UR
    INVOKE vdChar, 24, 79, 188, attr1 ;LR

;--------------------------------------
;
; write top and bottom bars
;

    INVOKE vdHRep, 0, 1, 78, 205, attr1
    INVOKE vdHRep, 24, 1, 78, 205, attr1

;--------------------------------------
;
; write the left and write bars
;

    INVOKE vdVRep, 1, 0, 23, 186, attr1
    INVOKE vdVRep, 1, 79, 23, 186, attr1

;--------------------------------------
;
; test vrdChar
;

    INVOKE vrdChar, 0, 0
    SAVE_TOKEN
    INVOKE vdChar, 1, 1, char_value, attribute_value

    INVOKE vrdChar, 24, 0
    SAVE_TOKEN
    INVOKE vdChar, 23, 1, char_value, attribute_value

    INVOKE vrdChar, 0, 79
    SAVE_TOKEN
    INVOKE vdChar, 1, 78, char_value, attribute_value

    INVOKE vrdChar, 24, 79
    SAVE_TOKEN
    INVOKE vdChar, 23, 78, char_value, attribute_value

;--------------------------------------
; wait for key press

    mov   ax, 0                   ;  stop and wait 
    int   16h                    ; for keypress via BIOS

;--------------------------------------
;
; restore the screen
;

    INVOKE restScrn, ADDR scrn_b

;--------------------------------------
;
; turn on the cursor
;

    INVOKE onCur

;--------------------------------------
; restore the cursor size and lcoation

    INVOKE restCur

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