;--------------------------------------
;
; prog7-1.asm
;
; Drop Down Window Demonstration 
; Program
;  
;

;--------------------------------------
;
; include all defines, macros, 
; prototypes and set up memory model
;

include tab6.inc

press_any PROTO PASCAL

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
attr1k	db	?
attr2	db	?
attr3	db	?
attr4	db	?
attr5	db	?

; temp 
xdat    db 'xxxxxx',0
ctemp1  db      ?

;--------------------------------------
;
; initialization of windows
;


mi1 M_ITEM   { 0+MI_OFF,ALT_O,'Open' },
             { 0+MI_OFF,ALT_C,'Create New' },
             { 0+MI_OFF,ALT_S,'Save' },
             { 5+MI_OFF,ALT_A,'Save As...' },
             { 0+MI_OFF,ALT_M,'Menu Info' },
             { 1+MI_OFF,ALT_H,'Shell to DOS' },
             { 0+MI_OFF,ALT_Q,'Quit to DOS' }

miITEMS equ     7
 
dd1 DROP_DOWN { miITEMS,{ 1,1,9,16,S_S_S_S,FALSE,' Menu '} }
        
              
msg1    db      'Open Option selected...        ',0
msg2    db      'Create New Option Selected...  ',0
msg3    db      'Save Option Selected...        ',0
msg4    db      'Save As... Option Selected...  ',0
msg5    db      'Menu Info Option Selected...   ',0
msg6    db      'Shell To DOS Option Selected...',0
msg7    db      'Quit To DOS Option Selected... ',0
pressmsg db     'Press any key to continue...',0              
              

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
; clear the screen

        INVOKE  clrScrn,7

;
; prepare attributes

	INVOKE mkAttr,ADDR attr1,WHITE,BLUE,OFF_INTENSITY,OFF_BLINK
	INVOKE mkAttr,ADDR attr1i,BLACK,WHITE,OFF_INTENSITY,OFF_BLINK
	INVOKE mkAttr,ADDR attr1k,WHITE,BLUE,ON_INTENSITY,OFF_BLINK

	INVOKE mkAttr,ADDR attr1b,BLACK,RED,OFF_INTENSITY,OFF_BLINK
	INVOKE mkAttr,ADDR attr2,WHITE,BLUE,OFF_INTENSITY,OFF_BLINK
	INVOKE mkAttr,ADDR attr3,BLUE,GREEN,OFF_INTENSITY,OFF_BLINK
	INVOKE mkAttr,ADDR attr4,BLACK,WHITE,OFF_INTENSITY,OFF_BLINK
	INVOKE mkAttr,ADDR attr5,WHITE,MAGENTA,OFF_INTENSITY,OFF_BLINK

; Initialize window structures

        INVOKE  initDDW, ADDR dd1, ADDR mi1,attr1,attr1i,attr1k

no_exit:
        INVOKE  displayDDW, ADDR dd1, ADDR mi1

        .IF (ax == 1)
        INVOKE  vdWrite,12,0,0,ADDR msg1,7
        INVOKE  removeDDW, ADDR dd1
        INVOKE  press_any
        jmp     no_exit
        .ELSEIF (ax == 2)
        INVOKE  removeDDW, ADDR dd1
        INVOKE  vdWrite,12,0,0,ADDR msg2,7
        INVOKE  press_any
        jmp     no_exit
        .ELSEIF (ax == 3)
        INVOKE  removeDDW, ADDR dd1
        INVOKE  vdWrite,12,0,0,ADDR msg3,7
        INVOKE  press_any
        jmp     no_exit
        .ELSEIF (ax == 4)
        INVOKE  removeDDW, ADDR dd1
        INVOKE  vdWrite,12,0,0,ADDR msg4,7
        INVOKE  press_any
        jmp     no_exit
        .ELSEIF (ax == 5)
        INVOKE  removeDDW, ADDR dd1
        INVOKE  vdWrite,12,0,0,ADDR msg5,7
        INVOKE  press_any
        jmp     no_exit
        .ELSEIF (ax == 6)
        INVOKE  removeDDW, ADDR dd1
        INVOKE  vdWrite,12,0,0,ADDR msg6,7
        INVOKE  press_any
        jmp     no_exit
        .ELSEIF (ax == 7)
        INVOKE  removeDDW, ADDR dd1
        INVOKE  vdWrite,0,0,0,ADDR msg7,7
        .ENDIF

;
; free up memory allocated during initWind procedure call

        INVOKE  destroyDDW, ADDR dd1

;--------------------------------------
;
; turn on the cursor and move to
; row 22, column 0
;

	INVOKE	onCur
        INVOKE  mvCur,1,0

;--------------------------------------
;
; End program and return to DOS
;

	.EXIT


;--------------------------------------
;
; press any key to continue
;

press_any PROC PASCAL
        INVOKE  vdWrite,14,0,0,ADDR pressmsg,7
        xor     ax,ax
        int     16h
        INVOKE  vdHRep,12,0,60,' ',7
        INVOKE  vdHRep,14,0,60,' ',7
        ret
press_any ENDP
;--------------------------------------
;
; End of ASSEMBLY source file
;

	END
;
;
;--------------------------------------
