;--------------------------------------
;
; def6.inc
;
; MASM 6.0 defines for libraries
;

; MISC defines

TRUE                equ      01h
FALSE               equ      00h

; code conversion defines

HEX_8_BIT           equ      00h
HEX_16_BIT          equ      01h

; single user file access codes
; and file attributes

O_READ              equ      00h
O_WRITE             equ      01h
O_RDWR              equ      02h

NORMAL_FILE         equ      00h
HIDDEN_FILE         equ      02h
SYSTEM_FILE         equ      04h
HIDDEN_SYSTEM_FILE  equ      06h

BEGINNING_OFFSET    equ      00h
CURRENT_OFFSET      equ      01h
END_OFFSET          equ      02h

; command line defines

COMMAND_LENGTH      equ      80h
COMMAND_START       equ      81h    

; option expr32

WRITE_STRING        equ      13h
SCROLL_WINDOW       equ      06h
CLEAR_WINDOW        equ      00h
NORMAL_ATTR         equ      07h
SET_CURSOR_SHAPE    equ      01h
SET_CURSOR_POSITION equ      02h
GET_CURSOR_CONFIG   equ      03h

; error codes

MALLOC_ERROR        equ      00h
FREE_ERROR          equ      01h

; defines for BOX display options

S_S_S_S             equ      00h        ; T & B & L & R Single
D_D_D_D             equ      01h        ; T & B & L & R Double
D_D_S_S             equ      02h        ; T & B Double, L & R Single

; define title location options

TTL                 equ      01h        ; top left
TTC                 equ      02h        ; top center
TBL                 equ      03h        ; bottom left
TBC                 equ      04h        ; bottom center

;  attribute define values

BLACK               equ      0t
BLUE                equ      1t
GREEN               equ      2t
CYAN                equ      3t
RED                 equ      4t
MAGENTA             equ      5t
BROWN               equ      6t
WHITE               equ      7t
NORMAL              equ      7t
REVERSE             equ      112t
ON_INTENSITY        equ      8t
OFF_INTENSITY       equ      0t
ON_BLINK            equ      128t
OFF_BLINK           equ      0t

; ascii

aNUL                equ      0t         ;       null 0 delimeter
aSOH                equ      1t         ;   ^A - start of heading
aSTX                equ      2t         ;   ^B - start of text
aETX                equ      3          ;   ^C - end of text
aEOT                equ      4t         ;   ^D - end of transmission
aENQ                equ      5t         ;   ^E - inquiry
aACK                equ      6t         ;   ^F - affirm acknowledgement
aBEL                equ      7t         ;   ^G - audible bell
aBS                 equ      8t         ;   ^H - backspace
aTAB                equ      9t         ;   ^I - horizontal tab
aLF                 equ      10t        ;   ^J - line feed
aVT                 equ      11t        ;   ^K - vertical tab
aFF                 equ      12t        ;   ^L - form feed
aCR                 equ      13t        ;   ^M - carriage return
aSO                 equ      14t        ;   ^N - shift out
aSI                 equ      15t        ;   ^O - shift in
aDCE                equ      16t        ;   ^P - data link escape
aDC1                equ      17t        ;   ^Q - device control 1
aDC2                equ      18t        ;   ^R - device control 2
aDC3                equ      19t        ;   ^S - device control 3
aDC4                equ      20t        ;   ^T - device control 4
aNAK                equ      21t        ;   ^U - neg acknowledge 
aSYN                equ      22t        ;   ^V - synchronous idle
aETB                equ      23t        ;   ^W - end of transmission
aCAN                equ      24t        ;   ^X - cancel
aEM                 equ      25t        ;   ^Y - end of medium
aSUB                equ      26t        ;   ^Z - substitute
aESC                equ      27t        ;        escape
aFS                 equ      28t        ;        file separator 
aGS                 equ      29t        ;        group separator 
aRS                 equ      30t        ;        record separator 
aUS                 equ      31t        ;        unlinked separator 
aSPC                equ      32t        ;        space 
aCODE               equ      94t        ; printer command follows // 
aHCR                equ      04h        ; Hard carriage return
aCENTER             equ      43h        ; code to center line
aDOUBLE             equ      44h        ; double strike toggle
aEXPAND             equ      45h        ; emphasize toggle
aSUPERS             equ      53h        ; superscript toggle
aITALIC             equ      49h        ; italics toggle
aBOLD               equ      42h        ; bold toggle
aTRUE               equ      1t         ; true
aFALSE              equ      0t         ; false

;  keyboard char and scan codes

INSERT              equ      5200h
DELETE              equ      5300h
SPACE               equ      3920h
ESCAPE              equ      011bh
PGDN                equ      5100h
PGUP                equ      4900h
PERIOD              equ      342eh
TAB                 equ      0f09h
RT_SQUARE           equ      1b5dh
LT_SQUARE           equ      1a5bh
RT_BRACKET          equ      1b7dh
LT_BRACKET          equ      1a7bh
CNTL_HOME           equ      7700h
CNTL_END            equ      7500h
CNTL_ENTER          equ      1c0ah
CNTL_BS             equ      0e7fh
HOME                equ      4700h
ENDKEY              equ      4f00h
s_BS                equ      0008h
BS                  equ      0e08h
BACKSPACE           equ      0e08h
s_CR                equ      000dh
CR                  equ      1c0dh
ENTERKEY            equ      1c0dh
UP_ARROW            equ      4800h
RIGHT_ARROW         equ      4d00h
LEFT_ARROW          equ      4b00h
DOWN_ARROW          equ      5000h
F1                  equ      3b00h
F2                  equ      3c00h
F3                  equ      3d00h
F4                  equ      3e00h
F5                  equ      3f00h
F6                  equ      4000h
F7                  equ      4100h
F8                  equ      4200h
F9                  equ      4300h
F10                 equ      4400h
SHIFT_TAB           equ      0f00h
SHIFT_HOME          equ      4737h
SHIFT_END           equ      4f31h
SHIFT_INSERT        equ      5230h
SHIFT_DELETE        equ      532eh
SHFT_INSERT         equ      5230h
SHFT_F1             equ      5400h
SHFT_F2             equ      5500h
SHFT_F3             equ      5600h
SHFT_F4             equ      5700h
SHFT_F5             equ      5800h
SHFT_F6             equ      5900h
SHFT_F7             equ      5a00h
SHFT_F8             equ      5b00h
SHFT_F9             equ      5c00h
SHFT_F10            equ      5d00h
SH_R_ARROW          equ      4d36h
SH_L_ARROW          equ      4b34h
SH_U_ARROW          equ      4838h
SH_D_ARROW          equ      5032h
CNTL_F1             equ      5e00h
CNTL_F2             equ      5f00h
CNTL_F3             equ      6000h
CNTL_F4             equ      6100h
CNTL_F5             equ      6200h
CNTL_F6             equ      6300h
CNTL_F7             equ      6400h
CNTL_F8             equ      6500h
CNTL_F9             equ      6600h
CNTL_F10            equ      6700h
CNTL_LEFTA          equ      7300h
CNTL_RIGHTA         equ      7400h
ALT_F1              equ      6800h
ALT_F2              equ      6900h
ALT_F3              equ      6a00h
ALT_F4              equ      6b00h
ALT_F5              equ      6c00h
ALT_F6              equ      6d00h
ALT_F7              equ      6e00h
ALT_F8              equ      6f00h
ALT_F9              equ      7000h
ALT_F10             equ      7100h
ALT_A               equ      1e00h
ALT_B               equ      3000h
ALT_C               equ      2e00h
ALT_D               equ      2000h
ALT_E               equ      1200h
ALT_F               equ      2100h
ALT_G               equ      2200h
ALT_H               equ      2300h
ALT_I               equ      1700h
ALT_J               equ      2400h
ALT_K               equ      2500h
ALT_L               equ      2600h
ALT_M               equ      3200h
ALT_N               equ      3100h
ALT_O               equ      1800h
ALT_P               equ      1900h
ALT_Q               equ      1000h
ALT_R               equ      1300h
ALT_S               equ      1f00h
ALT_T               equ      1400h
ALT_U               equ      1600h
ALT_V               equ      2f00h
ALT_W               equ      1100h
ALT_X               equ      2d00h
ALT_Y               equ      1500h
ALT_Z               equ      2c00h
CNTL_A              equ      1e01h
CNTL_B              equ      3002h
CNTL_C              equ      2e03h
CNTL_D              equ      2004h
CNTL_E              equ      1205h
CNTL_F              equ      2106h
CNTL_G              equ      2207h
CNTL_H              equ      2308h
CNTL_I              equ      1709h
CNTL_J              equ      240ah
CNTL_K              equ      250bh
CNTL_L              equ      260ch
CNTL_M              equ      320dh
CNTL_N              equ      310eh
CNTL_O              equ      180fh
CNTL_P              equ      1910h
CNTL_Q              equ      1011h
CNTL_R              equ      1312h
CNTL_S              equ      1f13h
CNTL_T              equ      1414h
CNTL_U              equ      1615h
CNTL_V              equ      2f16h
CNTL_W              equ      1117h
CNTL_X              equ      2d18h
CNTL_Y              equ      1519h
CNTL_Z              equ      2c1ah
K_0                 equ      0b30h
K_1                 equ      0231h
K_2                 equ      0332h
K_3                 equ      0433h
K_4                 equ      0534h
K_5                 equ      0635h
K_6                 equ      0736h
K_7                 equ      0837h
K_8                 equ      0938h
K_9                 equ      0a39h
ALT_0               equ      8100h
ALT_1               equ      7800h
ALT_2               equ      7900h
ALT_3               equ      7a00h
ALT_4               equ      7b00h
ALT_5               equ      7c00h
ALT_6               equ      7d00h
ALT_7               equ      7e00h
ALT_8               equ      7f00h
ALT_9               equ      8000h
K_SPACE             equ      3920h
K_EXCLAM            equ      0221h
K_QUOTE             equ      2822h
K_POUND             equ      0423h
K_DOLLAR            equ      0524h
K_PERCENT           equ      0625h
K_AND               equ      0826h
K_APOST             equ      2827h
K_LPAREN            equ      0a28h
K_RPAREN            equ      0b29h
K_STAR              equ      092ah
K_PLUS              equ      0d2bh
K_COMMA             equ      332ch
K_MINUS             equ      0c2dh
K_PERIOD            equ      342eh
K_FSLASH            equ      352fh
K_COLON             equ      273ah
K_SCOLON            equ      273bh
K_LESS              equ      333ch
K_equAL             equ      0d3dh
K_GREAT             equ      343eh
K_QUEST             equ      353fh
K_AMPER             equ      0340h
K_A                 equ      1e41h
K_B                 equ      3042h
K_C                 equ      2e43h
K_D                 equ      2044h
K_E                 equ      1245h
K_F                 equ      2146h
K_G                 equ      2247h
K_H                 equ      2348h
K_I                 equ      1749h
K_J                 equ      244ah
K_K                 equ      254bh
K_L                 equ      264ch
K_M                 equ      324dh
K_N                 equ      314eh
K_O                 equ      184fh
K_P                 equ      1950h
K_Q                 equ      1051h
K_R                 equ      1352h
K_S                 equ      1f53h
K_T                 equ      1454h
K_U                 equ      1655h
K_V                 equ      2f56h
K_W                 equ      1157h
K_X                 equ      2d58h
K_Y                 equ      1559h
K_Z                 equ      2c5ah
K_LBRACK            equ      1a5bh
K_BSLASH            equ      2b5ch
K_RBRACK            equ      1b5dh
K_KARAT             equ      075eh
K_UNDER             equ      0c5ch
KLC_a               equ      1e61h
KLC_b               equ      3062h
KLC_c               equ      2e63h
KLC_d               equ      2064h
KLC_e               equ      1265h
KLC_f               equ      2166h
KLC_g               equ      2267h
KLC_h               equ      2368h
KLC_i               equ      1769h
KLC_j               equ      246ah
KLC_k               equ      256bh
KLC_l               equ      266ch
KLC_m               equ      326dh
KLC_n               equ      316eh
KLC_o               equ      186fh
KLC_p               equ      1970h
KLC_q               equ      1071h
KLC_r               equ      1372h
KLC_s               equ      1f73h
KLC_t               equ      1474h
KLC_u               equ      1675h
KLC_v               equ      2f76h
KLC_w               equ      1177h
KLC_x               equ      2d78h
KLC_y               equ      1579h
KLC_z               equ      2c7ah

