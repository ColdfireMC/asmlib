;--------------------------------------
;
; prog7-2.asm
;
; Menu Bar and Drop Down Window
; Demonstration Program
;

;--------------------------------------
;
; include all defines, macros, 
; prototypes and set up memory model
;

include tab6.inc

wait_key PROTO PASCAL
initMB    PROTO PASCAL,mbptr:Ptr DROP_DOWN,attr:Byte,i_attr:Byte,k_attr:Byte
displayMB PROTO PASCAL,mbptr:Ptr MENU_BAR,miptr:Ptr M_ITEM

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
        
scrn1    dw     2000 DUP(0)
attr1    db	?
attr1a	 db	?
attr1i	 db	?
attr1b	 db	?
attr1k	 db	?
mb_attr	 db	?
mbi_attr db	?
mbk_attr db	?
scrn_a   db     ?


; temp 
xdat    db 'xxxxxx',0
ctemp1  db      ?

;--------------------------------------
;
; initialize not coded report window
;

not_coded WINDOW <10,8,15,40,S_S_S_S,TTC,' Function Not Coded ' >

;--------------------------------------
;
; initialization of menu bar
;

mbITEMS equ     9

mb1 MENU_BAR { mbITEMS, , , }

mbi M_ITEM   { 0,ALT_F,'File',1 },
             { 0,ALT_E,'Edit',7 },
             { 0,ALT_V,'View',13 },
             { 0,ALT_S,'Search',19 },
             { 0,ALT_R,'Run',27 },
             { 0,ALT_W,'Watch',32 },
             { 0,ALT_O,'Options',39 },
             { 0,ALT_C,'Calls',48 },
             { 0,ALT_H,'Help',75 }

;--------------------------------------
; not coded messages     

nc1    db      'Drop Down: File',0
nc11   db      'Selected:  Open Source...',0
nc12   db      'Selected:  Open Module...',0
nc13   db      'Selected:  Print...',0
nc14   db      'Selected:  DOS Shell...',0

nc2    db      'Drop Down: Edit',0
nc21   db      'Selected: Undo',0
nc22    db      'Selected: Copy',0
nc23    db      'Selected: Paste',0

nc3     db      'Drop Down: View',0
nc31    db      'Selected: Source',0
nc32    db      'Selected: Memory',0
nc33    db      'Selected: Register',0
nc34    db      'Selected: 8087',0
nc35    db      'Selected: Local',0
nc36    db      'Selected: Watch',0
nc37    db      'Selected: Command',0
nc38    db      'Selected: Help',0
nc39    db      'Selected: Output',0
nc310   db      'Selected: Maximize',0
nc311   db      'Selected: Size',0
nc312   db      'Selected: Close',0

nc4     db      'Drop Down: Search',0
nc41    db      'Selected: Find...',0
nc42    db      'Selected: Selected Text',0
nc43    db      'Selected: Repeat Last Find',0
nc44    db      'Selected: Label Function',0

nc5     db      'Selected: Run',0
nc51    db      'Restart',0
nc52    db      'Animate',0
nc53    db      'Set Runtime Arguments',0
nc54    db      'History On',0
nc55    db      'Undo',0
nc56    db      'Replay',0

nc6     db      'Selected: Watch',0
nc61    db      'Add Watch',0
nc62    db      'Delete Watch',0
nc63    db      'Set Breakpoints',0
nc64    db      'Edit Breakpoints',0
nc65    db      'Quick Watch',0

nc7     db      'Selected: Options',0
nc71    db      'Source Window',0
nc72    db      'Memory Window',0
nc73    db      'Language...',0
nc74    db      'Screen Swap',0
nc75    db      'Replay...',0
nc76    db      'Case Sensitivity',0
nc77    db      '386 Instructions',0

nc9     db      'Selected: Help',0
nc91    db      'Index',0
nc92    db      'Contents',0
nc93    db      'Topic',0
nc94    db      'Help on Help',0
nc95    db      'About',0

cnc     db      'Selected: Calls',0
cnc1    db      'No Drop Down For Calls',0


;--------------------------------------
;
; initialization of windows
;

;-----------------------
; File drop down window

mi1 M_ITEM   { 0+MI_OFF,ALT_O,'Open Source...' },
             { 5+MI_OFF,ALT_M,'Open Module...' },
             { 0+MI_OFF,ALT_P,'Print...' },
             { 5+MI_OFF,ALT_H,'DOS Shell...' },
             { 1+MI_OFF,ALT_X,'Exit' }
miITEMS equ     5
dd1 DROP_DOWN { miITEMS,{ 1,0,7,17,S_S_S_S,FALSE,' Menu '} }

;-----------------------
; Edit drop down window

mi2 M_ITEM   { 0+MI_OFF,ALT_U,'Undo     Alt+Bksp' },
             { 0+MI_OFF,ALT_C,'Copy     Ctrl+Ins' },
             { 0+MI_OFF,ALT_P,'Paste   Shift+Ins' }
miITEMS2 equ     3
dd2 DROP_DOWN { miITEMS2,{ 1,6,5,27,S_S_S_S,FALSE,' Menu '} }

;-----------------------
; View drop down window

mi3 M_ITEM   { 0+MI_OFF,ALT_S },
             { 0+MI_OFF,ALT_M },
             { 0+MI_OFF,ALT_R },
             { 3+MI_OFF,ALT_7 },
             { 0+MI_OFF,ALT_L },
             { 0+MI_OFF,ALT_W },
             { 0+MI_OFF,ALT_C },
             { 0+MI_OFF,ALT_H },
             { 0+MI_OFF,ALT_O },
             { 2+MI_OFF,ALT_X },
             { 2+MI_OFF,ALT_Z },
             { 4+MI_OFF,ALT_E }

mi3msg1  db  'Source',0
mi3msg2  db  'Memory',0
mi3msg3  db  'Register        F2',0
mi3msg4  db  '8087',0
mi3msg5  db  'Local',0
mi3msg6  db  'Watch',0
mi3msg7  db  'Command',0
mi3msg8  db  'Help',0
mi3msg9  db  'Output          F4',0
mi3msg10 db  'Maximize  Ctrl+F10',0
mi3msg11 db  'Size       Ctrl+F8',0
mi3msg12 db  'Close      Ctrl+F4',0


miITEMS3 equ     12

dd3 DROP_DOWN { miITEMS3,{ 1,12,14,33,S_S_S_S,FALSE,' Menu '} }

;-----------------------
; Search drop down window

mi4 M_ITEM   { 0+MI_OFF,ALT_F,'Find...                ' },
             { 0+MI_OFF,ALT_S,'Selected Text    Ctrl+\' },
             { 0+MI_OFF,ALT_P,'Repeat Last Find  Alt+/' },
             { 0+MI_OFF,ALT_L,'Label Function         ' }
miITEMS4 equ     4
dd4 DROP_DOWN { miITEMS4,{ 1,15,6,41,S_S_S_S,FALSE,' Menu '} }

;-----------------------
; Run drop down window

mi5 M_ITEM   { 0+MI_OFF,ALT_R,'Restart' },
             { 0+MI_OFF,ALT_A,'Animate' },
             { 0+MI_OFF,ALT_S,'Set Runtime Arguments' },
             { 0+MI_OFF,ALT_H,'History On' },
             { 0+MI_OFF,ALT_U,'Undo' },
             { 0+MI_OFF,ALT_R,'Replay' }

miITEMS5 equ     6
dd5 DROP_DOWN { miITEMS5,{ 1,26,8,50,S_S_S_S,FALSE,' Menu '} }

;-----------------------
; Watch drop down window

mi6 M_ITEM   { 0+MI_OFF,ALT_A,'Add Watch...    Cntrl+W' },
             { 0+MI_OFF,ALT_D,'Delete Watch... Cntrl+U' },
             { 0+MI_OFF,ALT_S,'Set Breakpoint...    F9' },
             { 0+MI_OFF,ALT_E,'Edit Breakpoints...    ' },
             { 0+MI_OFF,ALT_Q,'Quick Watch     Shft+F9' }

miITEMS6 equ     5
dd6 DROP_DOWN { miITEMS6,{ 1,31,7,57,S_S_S_S,FALSE,' Menu '} }

;-------------------------
; Options drop down window

mi7 M_ITEM   { 0+MI_OFF,ALT_S,'Source Window...' },
             { 0+MI_OFF,ALT_M,'Memory Window' },
             { 0+MI_OFF,ALT_L,'Language...' },
             { 2+MI_OFF,ALT_R,'Screen Swap...' },
             { 2+MI_OFF,ALT_P,'Replay...' },
             { 0+MI_OFF,ALT_C,'Case Sensitivity' },
             { 0+MI_OFF,ALT_3,'386 Instructions' }

miITEMS7 equ     7
dd7 DROP_DOWN { miITEMS7,{ 1,38,9,57,S_S_S_S,FALSE,' Menu '} }
        

;-----------------------
; Help drop down window

mi9 M_ITEM   { 0+MI_OFF,ALT_I,'Index' },
             { 0+MI_OFF,ALT_C,'Contents  Shft+F1' },
             { 0+MI_OFF,ALT_T,'Topic          F1' },
             { 0+MI_OFF,ALT_H,'Help On Help' },
             { 0+MI_OFF,ALT_A,'About' }

miITEMS9 equ     5
dd9 DROP_DOWN { miITEMS9,{ 1,59,7,79,S_S_S_S,FALSE,' Menu '} }
              
pressmsg db     'Press any key to continue...',0              
botmsg  db      '<F8=Trace>  <F10=Step>  <F5=Go>  <F6=Window>  <F3=Display>',0
locmsg  db      'local',0              
fnmsg   db      'source1 CP:IS prog7-2.asm (ACTIVE)',0
cmdmsg  db      'command',0

fmsg1   db      '153:       ;-------------------------',0
fmsg2   db      '154:       ;  Program beginning',0
fmsg3   db      '155:       ;',0
fmsg4   db      '156:       ;      .STARTUP',0
fmsg5   db      '157:       ;',0
fmsg6   db      '158:       ;-------------------------',0
fmsg7   db      '159:       ;  Initialize video',0
fmsg8   db      '160:       ;',0
fmsg9   db      '161:       ;       INVOKE   vidInit',0
fmsg10  db      '162:       ;',0
fmsg11  db      '163:       ;-------------------------',0
errmsg1 db      'CV1053  Warning: TOOLS.INI not found',0
errmsg2 db      'CV1063  Warning: Cannot create CURRENT.STS',0




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

;
; save the screen and cursor location

        INVOKE  saveScrn, ADDR scrn1
        INVOKE  gtCur

; turn off the cursor
;

	INVOKE	offCur

;
; prepare attributes

	INVOKE mkAttr,ADDR scrn_a,WHITE,BLUE,OFF_INTENSITY,OFF_BLINK
	INVOKE mkAttr,ADDR mb_attr,BLACK,WHITE,OFF_INTENSITY,OFF_BLINK
	INVOKE mkAttr,ADDR mbi_attr,WHITE,BLACK,OFF_INTENSITY,OFF_BLINK
	INVOKE mkAttr,ADDR mbk_attr,WHITE,WHITE,ON_INTENSITY,OFF_BLINK
	INVOKE mkAttr,ADDR attr1,BLACK,WHITE,OFF_INTENSITY,OFF_BLINK
	INVOKE mkAttr,ADDR attr1i,WHITE,BLACK,OFF_INTENSITY,OFF_BLINK
	INVOKE mkAttr,ADDR attr1k,WHITE,WHITE,ON_INTENSITY,OFF_BLINK
	INVOKE mkAttr,ADDR attr1b,WHITE,WHITE,ON_INTENSITY,OFF_BLINK
;
; prepare the screen

        INVOKE  clrScrn,scrn_a
        INVOKE  vdAttr,24,0,80,mb_attr
        INVOKE  vdWrite,24,0,0,ADDR botmsg,mb_attr
        INVOKE  vdBox,1,0,23,79,mbi_attr,S_S_S_S
        INVOKE  vdWrite,1,37,0,ADDR locmsg,7
        INVOKE  vdHRep,6,0,80,196,7
        INVOKE  vdWrite,6,23,0,ADDR fnmsg,7
        INVOKE  vdWrite,7,1,0,ADDR fmsg1,scrn_a
        INVOKE  vdWrite,8,1,0,ADDR fmsg2,scrn_a
        INVOKE  vdWrite,9,1,0,ADDR fmsg3,scrn_a
        INVOKE  vdWrite,10,1,0,ADDR fmsg4,scrn_a
        INVOKE  vdWrite,11,1,0,ADDR fmsg5,scrn_a
        INVOKE  vdAttr,11,1,78,mb_attr
        INVOKE  vdWrite,12,1,0,ADDR fmsg6,scrn_a
        INVOKE  vdWrite,13,1,0,ADDR fmsg7,scrn_a
        INVOKE  vdWrite,14,1,0,ADDR fmsg8,scrn_a
        INVOKE  vdWrite,15,1,0,ADDR fmsg9,scrn_a
        INVOKE  vdWrite,16,1,0,ADDR fmsg10,scrn_a
        INVOKE  vdWrite,17,1,0,ADDR fmsg11,scrn_a

        INVOKE  vdHRep,18,0,80,196,7
        INVOKE  vdWrite,18,36,0,ADDR cmdmsg,mb_attr
        INVOKE  vdWrite,19,1,0,ADDR errmsg1,scrn_a
        INVOKE  vdWrite,20,1,0,ADDR errmsg2,scrn_a
        INVOKE  vdChar,21,1,'>',scrn_a
        INVOKE  onCur
        INVOKE  mvCur,21,2
        INVOKE  vdChar,6,0,195,7
        INVOKE  vdChar,18,0,195,7
        INVOKE  vdChar,6,79,180,7
        INVOKE  vdChar,18,79,180,7
        INVOKE  vdChar,6,75,180,7
        INVOKE  vdChar,18,75,180,7
        INVOKE  vdChar,6,2,180,7
        INVOKE  vdChar,18,2,180,7
        INVOKE  vdChar,6,4,195,7
        INVOKE  vdChar,18,4,195,7
        INVOKE  vdChar,6,77,195,7
        INVOKE  vdChar,18,77,195,7
        INVOKE  vdChar,6,3,7,mb_attr
        INVOKE  vdChar,18,3,7,mb_attr
        INVOKE  vdChar,6,76,24,mb_attr
        INVOKE  vdChar,18,76,24,mb_attr
;
; create scroll bars for command window

        INVOKE  vdChar,23,1,27,mb_attr      ; horiz scroll bar left arrow
        INVOKE  vdChar,23,78,26,mb_attr     ; horiz scroll bar right arrow
        INVOKE  vdChar,19,79,24,mb_attr     ; vert scroll bar up arrow
        INVOKE  vdChar,20,79,176,mb_attr    ; horiz scroll bar 
        INVOKE  vdChar,21,79,' ',7          ; scroll bar button
        INVOKE  vdChar,22,79,176,mb_attr    ; horiz scroll bar 
        INVOKE  vdChar,23,79,176,mb_attr    ; horiz scroll bar 
        INVOKE  vdChar,23,2,' ',7           ; scroll bar button
        INVOKE  vdHRep,23,3,74,176,mb_attr  ; horiz scroll bar 
        INVOKE  vdChar,23,79,25,mb_attr     ; vert scroll bar down arrow

;
; initialize Not Coded window

        INVOKE  initWind, ADDR not_coded,mb_attr

;
; Initialize drop down window structures 

        INVOKE  initDDW, ADDR dd1, ADDR mi1,attr1,attr1i,attr1k
        INVOKE  initDDW, ADDR dd2, ADDR mi2,attr1,attr1i,attr1k
        INVOKE  initDDW, ADDR dd3, ADDR mi3,attr1,attr1i,attr1k
        INVOKE  strcpy, ADDR mi3.i_name, ADDR mi3msg1
        INVOKE  strcpy, ADDR mi3.i_name+(1*LM_ITEM), ADDR mi3msg2
        INVOKE  strcpy, ADDR mi3.i_name+(2*LM_ITEM), ADDR mi3msg3
        INVOKE  strcpy, ADDR mi3.i_name+(3*LM_ITEM), ADDR mi3msg4
        INVOKE  strcpy, ADDR mi3.i_name+(4*LM_ITEM), ADDR mi3msg5
        INVOKE  strcpy, ADDR mi3.i_name+(5*LM_ITEM), ADDR mi3msg6
        INVOKE  strcpy, ADDR mi3.i_name+(6*LM_ITEM), ADDR mi3msg7
        INVOKE  strcpy, ADDR mi3.i_name+(7*LM_ITEM), ADDR mi3msg8
        INVOKE  strcpy, ADDR mi3.i_name+(8*LM_ITEM), ADDR mi3msg9
        INVOKE  strcpy, ADDR mi3.i_name+(9*LM_ITEM), ADDR mi3msg10
        INVOKE  strcpy, ADDR mi3.i_name+(10*LM_ITEM), ADDR mi3msg11
        INVOKE  strcpy, ADDR mi3.i_name+(11*LM_ITEM), ADDR mi3msg12
        INVOKE  initDDW, ADDR dd4, ADDR mi4,attr1,attr1i,attr1k
        INVOKE  initDDW, ADDR dd5, ADDR mi5,attr1,attr1i,attr1k
        INVOKE  initDDW, ADDR dd6, ADDR mi6,attr1,attr1i,attr1k
        INVOKE  initDDW, ADDR dd7, ADDR mi7,attr1,attr1i,attr1k
        INVOKE  initDDW, ADDR dd9, ADDR mi7,attr1,attr1i,attr1k

no_exit:

        INVOKE  initMB, ADDR mb1,mb_attr, mbi_attr, mbk_attr
        INVOKE  displayMB,ADDR mb1, ADDR mbi

;----------------------------------------
; File drop down window has been selected
;----------------------------------------

        .IF (ax == 1)
        INVOKE  displayDDW, ADDR dd1, ADDR mi1      ; display File drop down
        push    ax
        INVOKE  removeDDW, ADDR dd1
        pop     ax

        ;------------------------------
        ;Open Source... Option selected

        .IF (ax == 1)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc1,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc11,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ;Open Module... Option selected

        .ELSEIF (ax == 2)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc1,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc12,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------
        ;Print... Option selected

        .ELSEIF (ax == 3)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc1,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc13,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;----------------------------
        ;DOS Shell... Option selected

        .ELSEIF (ax == 4)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc1,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc14,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;-----------------------------
        ; exit program option selected

        .ELSEIF (ax == 5)                           
        jmp     exit_program

        ;-------------------------------
        ; End If for File Drop Down

        .ENDIF

        jmp     no_exit


;------------------------------
; Edit Drop Down Selected
;------------------------------

        .ELSEIF (ax == 2)
        INVOKE  displayDDW, ADDR dd2, ADDR mi2
        push    ax
        INVOKE  removeDDW, ADDR dd2
        pop     ax

        ;------------------------------
        ;Undo Option selected

        .IF (ax == 1)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc2,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc21,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ;Copy Option selected

        .ELSEIF (ax == 2)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc2,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc22,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ;Paste Option selected

        .ELSEIF (ax == 3)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc2,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc23,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;-------------------------------
        ; End If for Edit Drop Down

        .ENDIF

        jmp     no_exit


;------------------------------
; View Drop Down Selected
;------------------------------

        .ELSEIF (ax == 3)
        INVOKE  displayDDW, ADDR dd3, ADDR mi3
        push    ax
        INVOKE  removeDDW, ADDR dd3
        pop     ax

        ;------------------------------
        ; Source Option selected

        .IF (ax == 1)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc3,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc31,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; Memory Option selected

        .ELSEIF (ax == 2)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc3,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc32,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; Register Option selected

        .ELSEIF (ax == 3)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc3,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc33,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; 8087 Option selected

        .ELSEIF (ax == 4)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc3,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc34,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; Local Option selected

        .ELSEIF (ax == 5)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc3,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc35,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; Watch Option selected

        .ELSEIF (ax == 6)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc3,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc36,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; Command Option selected

        .ELSEIF (ax == 7)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc3,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc37,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; Help Option selected

        .ELSEIF (ax == 8)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc3,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc38,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; Output Option selected

        .ELSEIF (ax == 9)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc3,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc39,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; Maximize Option selected

        .ELSEIF (ax == 10)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc3,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc310,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window


        ;------------------------------
        ; Size Option selected

        .ELSEIF (ax == 11)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc3,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc311,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; Close Option selected

        .ELSEIF (ax == 12)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc3,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc312,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------------
        ; End If for View Drop Down

        .ENDIF

        jmp     no_exit

;------------------------------
; Search Drop Down Selected
;------------------------------

        .ELSEIF (ax == 4)
        INVOKE  displayDDW, ADDR dd4, ADDR mi4
        push    ax
        INVOKE  removeDDW, ADDR dd4
        pop     ax

        ;------------------------------
        ; Find Option selected

        .IF (ax == 1)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc4,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc41,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; Selected Text Option selected

        .ELSEIF (ax == 2)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc4,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc42,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;---------------------------------
        ; Repeat Last Find Option selected

        .ELSEIF (ax == 3)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc4,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc43,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;-------------------------------
        ; Label Function Option selected

        .ELSEIF (ax == 4)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc4,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc44,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;-----------------------------
        ; End If for Search Drop Down

        .ENDIF

        jmp     no_exit

;------------------------------
; Run Drop Down Selected
;------------------------------

        .ELSEIF (ax == 5)
        INVOKE  displayDDW, ADDR dd5, ADDR mi5
        push    ax
        INVOKE  removeDDW, ADDR dd5
        pop     ax

        ;------------------------------
        ; Restart Option selected

        .IF (ax == 1)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc5,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc51,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; Animate Option selected

        .ELSEIF (ax == 2)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc5,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc52,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;--------------------------------------
        ; Set Runtime Arguments Option selected

        .ELSEIF (ax == 3)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc5,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc53,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; History On Option selected

        .ELSEIF (ax == 4)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc5,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc54,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; Undo Option selected

        .ELSEIF (ax == 5)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc5,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc55,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; Replay Option selected

        .ELSEIF (ax == 6)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc5,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc56,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;--------------------------
        ; End If for Run Drop Down

        .ENDIF

        jmp     no_exit

;------------------------------
; Watch Drop Down Selected
;------------------------------

        .ELSEIF (ax == 6)
        INVOKE  displayDDW, ADDR dd6, ADDR mi6
        push    ax
        INVOKE  removeDDW, ADDR dd6
        pop     ax

        ;------------------------------
        ; Add Watch Option selected

        .IF (ax == 1)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc6,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc61,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; Delete Watch Option selected

        .ELSEIF (ax == 2)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc6,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc62,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;--------------------------------
        ; Set Breakpoints Option selected

        .ELSEIF (ax == 3)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc6,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc63,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;---------------------------------
        ; Edit Breakpoints Option selected

        .ELSEIF (ax == 4)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc6,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc64,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; Quick Watch Option selected

        .ELSEIF (ax == 5)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc6,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc65,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;---------------------------
        ; End If for Watch Drop Down

        .ENDIF

        jmp     no_exit

;------------------------------
; Options Drop Down Selected
;------------------------------

        .ELSEIF (ax == 7)
        INVOKE  displayDDW, ADDR dd7, ADDR mi7
        push    ax
        INVOKE  removeDDW, ADDR dd7
        pop     ax

        ;------------------------------
        ; Source Window Option selected

        .IF (ax == 1)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc7,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc71,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; Memory Window Option selected

        .ELSEIF (ax == 2)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc7,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc72,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; Language Option selected

        .ELSEIF (ax == 3)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc7,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc73,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;-----------------------------------
        ; Screen Swap Window Option selected

        .ELSEIF (ax == 4)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc7,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc74,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; Replay Option selected

        .ELSEIF (ax == 5)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc7,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc75,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;---------------------------------
        ; Case Sensitivity Option selected

        .ELSEIF (ax == 6)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc7,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc76,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; 386 Option selected

        .ELSEIF (ax == 7)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc7,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc77,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------------
        ; End If for Options Drop Down Window

        .ENDIF

        jmp     no_exit

;------------------------------
; Calls Drop Down Selected
;------------------------------

        .ELSEIF (ax == 8)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR cnc,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR cnc1,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        jmp     no_exit


;------------------------------
; Help Drop Down Selected
;------------------------------

        .ELSEIF (ax == 9)
        INVOKE  displayDDW, ADDR dd9, ADDR mi9
        push    ax
        INVOKE  removeDDW, ADDR dd9
        pop     ax

        ;------------------------------
        ; Index Option selected

        .IF (ax == 1)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc9,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc91,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; Contents Option selected

        .ELSEIF (ax == 2)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc9,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc92,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; Topic Option selected

        .ELSEIF (ax == 3)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc9,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc93,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; Help on Help Option selected

        .ELSEIF (ax == 4)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc9,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc94,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;------------------------------
        ; About Option selected

        .ELSEIF (ax == 5)
        INVOKE  displayWind, ADDR not_coded         ; display window & write messages
        INVOKE  wvdWrite,ADDR not_coded,2,2,0,ADDR nc9,mb_attr
        INVOKE  wvdWrite,ADDR not_coded,3,2,0,ADDR nc95,mb_attr
        INVOKE  wait_key                            ; wait for key press
        INVOKE  removeWind, ADDR not_coded          ; remove window

        ;---------------------------------
        ; End If for Help Drop Down Window

        .ENDIF

        jmp     no_exit

        ;---------------------------------
        ; End If for Interface Polling 
        ; Loop

        .ENDIF

;-------------------------------------------
; exit from the program
;
; 1) free up dynamically allocated memory
; 2) restore original calling screen
; 3) turn on text cursor
; 4) restore original cursor position

exit_program:

;--------------------------------------------------------
; free up memory allocated during initWind procedure call

        INVOKE  destroyDDW, ADDR dd1
        INVOKE  destroyDDW, ADDR dd2
        INVOKE  destroyDDW, ADDR dd3
        INVOKE  destroyDDW, ADDR dd4
        INVOKE  destroyDDW, ADDR dd5
        INVOKE  destroyDDW, ADDR dd6
        INVOKE  destroyDDW, ADDR dd7
        INVOKE  destroyWind, ADDR not_coded


;---------------------------------------
; Restore the screen and cursor location

        INVOKE  restScrn, ADDR scrn1
        INVOKE  restCur
	INVOKE	onCur

;--------------------------------------
; End program and return to DOS

	.EXIT


;--------------------------------------
;
; press any key to continue procedure
;
;--------------------------------------

wait_key PROC PASCAL
        xor     ax,ax
        int     16h
        ret
wait_key ENDP

;--------------------------------------
;
; End of ASSEMBLY source file

	END
;
;
;--------------------------------------
