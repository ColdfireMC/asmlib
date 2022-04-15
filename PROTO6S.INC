;--------------------------------------
;
; proto6s.inc
;
; procedure prototypes for small model
; MASM 6.0 library
;

;--------------------------------------
;
; small modem typedefs
;

PBYTE TYPEDEF NEAR PTR BYTE
PWORD TYPEDEF NEAR PTR WORD


; chapter 1

mvCur       PROTO NEAR PASCAL, row:BYTE, col:BYTE
clrScrn     PROTO NEAR PASCAL, s_attr:BYTE
bdWrite     PROTO NEAR PASCAL, row:BYTE, col:BYTE, str1:PBYTE

; chapter 2

gtCur       PROTO NEAR PASCAL
setCur      PROTO NEAR PASCAL, c_start:BYTE, c_end:BYTE
onCur       PROTO NEAR PASCAL
offCur      PROTO NEAR PASCAL
restCur     PROTO NEAR PASCAL

; chapter 3

mkAttr      PROTO NEAR PASCAL, a:PBYTE, f_c:WORD, b_c:WORD, i_t:WORD, b_t:WORD
mkToken     PROTO NEAR PASCAL, kchar:byte, attr:byte
vidInit     PROTO NEAR PASCAL
vdWrite     PROTO NEAR PASCAL, row:BYTE, col:BYTE, lgth:WORD, str1:PBYTE, attr1:BYTE
vdChar      PROTO NEAR PASCAL, row:BYTE, col:BYTE, pchar:BYTE, pattr:BYTE
vdAttr      PROTO NEAR PASCAL, row:BYTE, col:BYTE, len:WORD, pattr:BYTE
vdHRep      PROTO NEAR PASCAL, row:BYTE, col:BYTE, lgth:BYTE, cval:BYTE, attr:BYTE
vdVRep      PROTO NEAR PASCAL, row:BYTE, col:BYTE, lgth:BYTE, cval:BYTE, attr:BYTE
saveScrn    PROTO NEAR PASCAL, buffer:PWORD
restScrn    PROTO NEAR PASCAL, buffer:PWORD
vrdChar     PROTO NEAR PASCAL, prow:BYTE, pcol:BYTE

; chapter 4

memset      PROTO NEAR PASCAL, srce:PBYTE, value:BYTE, number:WORD
strlen      PROTO NEAR PASCAL, srce:PBYTE
strcpy      PROTO NEAR PASCAL, dest:PBYTE, srce:PBYTE
strlwr      PROTO NEAR PASCAL, srce:PBYTE
strupr      PROTO NEAR PASCAL, srce:PBYTE
strcmp      PROTO NEAR PASCAL, srce:PBYTE, dest:PBYTE
strncmp     PROTO NEAR PASCAL, dest:PBYTE, srce:PBYTE, number:WORD
strswap     PROTO NEAR PASCAL, dest:PBYTE, srce:PBYTE
memncpy     PROTO NEAR PASCAL, dest:PBYTE, srce:PBYTE, n:WORD, d_i:WORD
strins      PROTO NEAR PASCAL, dest:PBYTE, srce:PBYTE, d_i:WORD
strsrch     PROTO NEAR PASCAL, dest:PBYTE, srce:PBYTE
strcat      PROTO NEAR PASCAL, dest:PBYTE, srce:PBYTE
itoa        PROTO NEAR PASCAL buffer:PBYTE, num:WORD
ltoa        PROTO NEAR PASCAL buffer:PBYTE, num:PWORD
itoh        PROTO NEAR PASCAL buffer:PBYTE, num:WORD, num_bits:BYTE

; chapter 5

error_abort PROTO NEAR PASCAL, num:Word
malloc      PROTO NEAR PASCAL byte_num:WORD
free        PROTO NEAR PASCAL mem_seg:WORD
vdBox       PROTO NEAR PASCAL, ur:BYTE, uc:BYTE, lr:BYTE, lc:BYTE, a:BYTE, s:BYTE
initWind    PROTO NEAR PASCAL, wptr:Ptr WINDOW,  attr:BYTE
destroyWind PROTO NEAR PASCAL, wptr:Ptr WINDOW
displayWind PROTO NEAR PASCAL, wptr:Ptr Window
removeWind  PROTO NEAR PASCAL, wptr:Ptr Window
wvdWrite    PROTO NEAR PASCAL, wptr:Ptr WINDOW, row:BYTE, col:BYTE, lgth:WORD, str1:PBYTE, attr1:BYTE
wvdAttr     PROTO NEAR PASCAL, wptr:Ptr WINDOW, row:BYTE, col:BYTE, len:WORD, pattr:BYTE
wvdChar     PROTO NEAR PASCAL, wptr:Ptr WINDOW, row:BYTE, col:BYTE, pchar:BYTE, pattr:BYTE


; chapter 6 - mouse & keyboard

msInit      PROTO NEAR PASCAL
msOn        PROTO NEAR PASCAL
msOff       PROTO NEAR PASCAL
msStat      PROTO NEAR PASCAL,  x_loc:PWORD, y_loc:PWORD
kbStat      PROTO NEAR PASCAL 
kbRead      PROTO NEAR PASCAL 


; chapter 7

displayDDW  PROTO NEAR PASCAL, ddptr:Ptr DROP_DOWN, miptr:Ptr M_ITEM
initDDW     PROTO NEAR PASCAL, ddptr:Ptr DROP_DOWN, miptr:Ptr M_ITEM, attr:Byte, i_attr:Byte, k_attr:Byte
removeDDW   PROTO NEAR PASCAL, ddptr:Ptr DROP_DOWN
destroyDDW  PROTO NEAR PASCAL, ddptr:Ptr DROP_DOWN
displayMB   PROTO NEAR PASCAL, mbptr:Ptr MENU_BAR, miptr:Ptr M_ITEM

; chapter 6

createFile  PROTO NEAR PASCAL, handle:PWORD, filename:PBYTE, attr:WORD
openFile    PROTO NEAR PASCAL, handle:PWORD, filename:PBYTE, access:BYTE
closeFile   PROTO NEAR PASCAL, handle:WORD
readFile    PROTO NEAR PASCAL, filename:PBYTE, handle:WORD, bytes_read:WORD
writeFile   PROTO NEAR PASCAL, buffer:PBYTE, handle:WORD, bytes_read:WORD
deleteFile  PROTO NEAR PASCAL, filename:PBYTE
moveFilePtr PROTO NEAR PASCAL, hdl:WORD, m:BYTE, offs:PWORD, noff:PWORD




; chapter 7


; chapter 10

add32       PROTO NEAR PASCAL, dest:PWORD, srce:PWORD




