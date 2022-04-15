;--------------------------------------
;
; prog5-1.asm
;
; Window Demonstration Program
;  
;

;--------------------------------------
;
; include all defines, macros, 
; prototypes and set up memory model
;

include tab6.inc

;--------------------------------------
;  procedure prototypes

wait_keypress PROTO 
open_window1 PROTO 
open_window2 PROTO 
open_window3 PROTO 
open_window4 PROTO 
open_window5 PROTO 

;--------------------------------------
;
; Create stack
;

	.STACK                         ; 1 k by default

;--------------------------------------
;
; Declare data segment
;

	.DATA
        

attr1	db	?
attr1a	db	?
attr1i	db	?
attr1b	db	?
attr2	db	?
attr3	db	?
attr4	db	?
attr5	db	?

;--------------------------------------
;
; initialization of windows
;

wind1 WINDOW <3,10,8,41,D_D_S_S,TBC,' Error Report '>
wind2 WINDOW <2,4,22,60,D_D_D_D,TTL,' Second Window '>
wind3 WINDOW <0,0,24,79,S_S_S_S,TTC,' Third Window '>
wind4 WINDOW <3,10,15,40,D_D_S_S,TBL,' Fourth Window '>
wind5 WINDOW <18,40,22,60,D_D_S_S,TBC,' Fifth Window '>


msg11   db      '    ERROR  #2002    ',0
msg11a  db      '*',0
msg12   db      '--------------------',0
msg13   db      'See P. 313 in Guide ',0

;--------------------------------------
;
; Begin code segment
;

	.CODE


;--------------------------------------
;
; Start program here
;

	.STARTUP

;--------------------------------------
;

	INVOKE	vidInit

; turn off the cursor
;

	INVOKE	offCur

;
; prepare attributes

	INVOKE mkAttr,ADDR attr1,GREEN,RED,ON_INTENSITY,OFF_BLINK
	INVOKE mkAttr,ADDR attr1a,BLACK,RED,ON_INTENSITY,ON_BLINK
	INVOKE mkAttr,ADDR attr1i,WHITE,RED,ON_INTENSITY,OFF_BLINK
	INVOKE mkAttr,ADDR attr1b,BLACK,RED,OFF_INTENSITY,OFF_BLINK
	INVOKE mkAttr,ADDR attr2,WHITE,BLUE,OFF_INTENSITY,OFF_BLINK
	INVOKE mkAttr,ADDR attr3,BLUE,GREEN,OFF_INTENSITY,OFF_BLINK
	INVOKE mkAttr,ADDR attr4,BLACK,WHITE,OFF_INTENSITY,OFF_BLINK
	INVOKE mkAttr,ADDR attr5,WHITE,MAGENTA,OFF_INTENSITY,OFF_BLINK

; Initialize window structures

        INVOKE  initWind, ADDR wind1,attr1
        INVOKE  initWind, ADDR wind2,attr2
        INVOKE  initWind, ADDR wind3,attr3
        INVOKE  initWind, ADDR wind4,attr4
        INVOKE  initWind, ADDR wind5,attr5

; Open the first window

        INVOKE  open_window1

; wait for key press

        INVOKE  wait_keypress

; Open the window

        INVOKE  open_window2

; wait for key press

        INVOKE  wait_keypress

; Open the window

        INVOKE  open_window3


; wait for key press

        INVOKE  wait_keypress

; Open the window

        INVOKE  open_window4


; wait for key press

        INVOKE  wait_keypress

; Open the window

        INVOKE  open_window5

; wait for key press

        INVOKE  wait_keypress

; close window

        INVOKE  removeWind, ADDR wind5

; wait for key press

        INVOKE  wait_keypress

; close window

        INVOKE  removeWind, ADDR wind4

; wait for key press

        INVOKE  wait_keypress

; close window

        INVOKE  removeWind, ADDR wind3

; wait for key press

        INVOKE  wait_keypress

; close window

        INVOKE  removeWind, ADDR wind2

; wait for key press

        INVOKE  wait_keypress

; close window

        INVOKE  removeWind, ADDR wind1

;
; rapid window display and removal

        INVOKE  displayWind, ADDR wind1
        INVOKE  displayWind, ADDR wind2
        INVOKE  displayWind, ADDR wind3
        INVOKE  displayWind, ADDR wind4
        INVOKE  displayWind, ADDR wind5
        INVOKE  removeWind, ADDR wind5
        INVOKE  removeWind, ADDR wind4
        INVOKE  removeWind, ADDR wind3
        INVOKE  removeWind, ADDR wind2
        INVOKE  removeWind, ADDR wind1

;
; free up memory allocated during initWind procedure call

        INVOKE  destroyWind, ADDR wind1
        INVOKE  destroyWind, ADDR wind2
        INVOKE  destroyWind, ADDR wind3
        INVOKE  destroyWind, ADDR wind4
        INVOKE  destroyWind, ADDR wind5

;--------------------------------------
;
; turn on the cursor
;

	INVOKE	onCur

;--------------------------------------
;
; End program and return to DOS
;

	.EXIT

;--------------------------------------
;
;  wait for key press
;

wait_keypress PROC PASCAL

        xor     ax,ax
        int     16h
        ret

wait_keypress ENDP

;--------------------------------------
;
; open the first window
;

open_window1 PROC PASCAL

        INVOKE  displayWind, ADDR wind1
        INVOKE  wvdWrite, ADDR wind1, 1, 5, 0, ADDR msg11, attr1
        INVOKE  wvdAttr, ADDR wind1, 1, 5, 9, attr1i
        INVOKE  wvdWrite, ADDR wind1, 2, 5, 0, ADDR msg12, attr1
        INVOKE  wvdWrite, ADDR wind1, 3, 5, 0, ADDR msg13, attr1
        INVOKE  wvdAttr, ADDR wind1, 3, 12, 3, attr1b
        INVOKE  wvdChar, ADDR wind1, 1, 5, msg11a,attr1a
        ret

open_window1 ENDP


;--------------------------------------
;
; open window shells
;

open_window2 PROC PASCAL

        INVOKE  displayWind, ADDR wind2
        ret

open_window2 ENDP

open_window3 PROC PASCAL

        INVOKE  displayWind, ADDR wind3
        ret

open_window3 ENDP

open_window4 PROC PASCAL

        INVOKE  displayWind, ADDR wind4
        ret

open_window4 ENDP

open_window5 PROC PASCAL

        INVOKE  displayWind, ADDR wind5
        ret

open_window5 ENDP





;--------------------------------------
;
; End of ASSEMBLY source file
;

	END


;
; End of prog11.asm
;
;--------------------------------------
