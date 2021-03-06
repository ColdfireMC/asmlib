
; 
;  keyboard char and scan codes

INSERT		EQU		000005200h
DELETE		EQU		000005300h
SPACE		EQU		000003920h
ESCAPE		EQU		00000011bh
PGDN		EQU		000005100h
PGUP		EQU		000004900h
PERIOD		EQU		00000342eh
TAB		EQU		000000f09h
RT_SQUARE		EQU		000001b5dh
LT_SQUARE		EQU		000001a5bh
RT_BRACKET		EQU		000001b7dh
LT_BRACKET		EQU		000001a7bh
CNTL_HOME		EQU		000007700h
CNTL_END		EQU		000007500h
CNTL_ENTER		EQU		000001c0ah
CNTL_BS		EQU		000000e7fh
HOME		EQU		000004700h
END		EQU		000004f00h
s_BS		EQU		000000008h
BS		EQU		000000e08h
BACKSPACE		EQU		000000e08h
s_CR		EQU		00000000dh
CR		EQU		000001c0dh
ENTER		EQU		000001c0dh
UP_ARROW		EQU		000004800h
RIGHT_ARROW		EQU		000004d00h
LEFT_ARROW		EQU		000004b00h
DOWN_ARROW		EQU		000005000h
F1		EQU		000003b00h
F2		EQU		000003c00h
F3		EQU		000003d00h
F4		EQU		000003e00h
F5		EQU		000003f00h
F6		EQU		000004000h
F7		EQU		000004100h
F8		EQU		000004200h
F9		EQU		000004300h
F10		EQU		000004400h
SHIFT_TAB		EQU		000000f00h
SHIFT_HOME		EQU		000004737h
SHIFT_END		EQU		000004f31h
SHIFT_INSERT		EQU		000005230h
SHIFT_DELETE		EQU		00000532eh
SHFT_INSERT		EQU		000005230h
SHFT_F1		EQU		000005400h
SHFT_F2		EQU		000005500h
SHFT_F3		EQU		000005600h
SHFT_F4		EQU		000005700h
SHFT_F5		EQU		000005800h
SHFT_F6		EQU		000005900h
SHFT_F7		EQU		000005a00h
SHFT_F8		EQU		000005b00h
SHFT_F9		EQU		000005c00h
SHFT_F10		EQU		000005d00h
SH_R_ARROW		EQU		000004d36h
SH_L_ARROW		EQU		000004b34h
SH_U_ARROW		EQU		000004838h
SH_D_ARROW		EQU		000005032h
CNTL_F1		EQU		000005e00h
CNTL_F2		EQU		000005f00h
CNTL_F3		EQU		000006000h
CNTL_F4		EQU		000006100h
CNTL_F5		EQU		000006200h
CNTL_F6		EQU		000006300h
CNTL_F7		EQU		000006400h
CNTL_F8		EQU		000006500h
CNTL_F9		EQU		000006600h
CNTL_F10		EQU		000006700h
CNTL_LEFTA		EQU		000007300h
CNTL_RIGHTA		EQU		000007400h
ALT_F1		EQU		000006800h
ALT_F2		EQU		000006900h
ALT_F3		EQU		000006a00h
ALT_F4		EQU		000006b00h
ALT_F5		EQU		000006c00h
ALT_F6		EQU		000006d00h
ALT_F7		EQU		000006e00h
ALT_F8		EQU		000006f00h
ALT_F9		EQU		000007000h
ALT_F10		EQU		000007100h
ALT_A		EQU		000001e00h
ALT_B		EQU		000003000h
ALT_C		EQU		000002e00h
ALT_D		EQU		000002000h
ALT_E		EQU		000001200h
ALT_F		EQU		000002100h
ALT_G		EQU		000002200h
ALT_H		EQU		000002300h
ALT_I		EQU		000001700h
ALT_J		EQU		000002400h
ALT_K		EQU		000002500h
ALT_L		EQU		000002600h
ALT_M		EQU		000003200h
ALT_N		EQU		000003100h
ALT_O		EQU		000001800h
ALT_P		EQU		000001900h
ALT_Q		EQU		000001000h
ALT_R		EQU		000001300h
ALT_S		EQU		000001f00h
ALT_T		EQU		000001400h
ALT_U		EQU		000001600h
ALT_V		EQU		000002f00h
ALT_W		EQU		000001100h
ALT_X		EQU		000002d00h
ALT_Y		EQU		000001500h
ALT_Z		EQU		000002c00h
CNTL_A		EQU		000001e01h
CNTL_B		EQU		000003002h
CNTL_C		EQU		000002e03h
CNTL_D		EQU		000002004h
CNTL_E		EQU		000001205h
CNTL_F		EQU		000002106h
CNTL_G		EQU		000002207h
CNTL_H		EQU		000002308h
CNTL_I		EQU		000001709h
CNTL_J		EQU		00000240ah
CNTL_K		EQU		00000250bh
CNTL_L		EQU		00000260ch
CNTL_M		EQU		00000320dh
CNTL_N		EQU		00000310eh
CNTL_O		EQU		00000180fh
CNTL_P		EQU		000001910h
CNTL_Q		EQU		000001011h
CNTL_R		EQU		000001312h
CNTL_S		EQU		000001f13h
CNTL_T		EQU		000001414h
CNTL_U		EQU		000001615h
CNTL_V		EQU		000002f16h
CNTL_W		EQU		000001117h
CNTL_X		EQU		000002d18h
CNTL_Y		EQU		000001519h
CNTL_Z		EQU		000002c1ah
K_0		EQU		000000b30h
K_1		EQU		000000231h
K_2		EQU		000000332h
K_3		EQU		000000433h
K_4		EQU		000000534h
K_5		EQU		000000635h
K_6		EQU		000000736h
K_7		EQU		000000837h
K_8		EQU		000000938h
K_9		EQU		000000a39h
ALT_0		EQU		000008100h
ALT_1		EQU		000007800h
ALT_2		EQU		000007900h
ALT_3		EQU		000007a00h
ALT_4		EQU		000007b00h
ALT_5		EQU		000007c00h
ALT_6		EQU		000007d00h
ALT_7		EQU		000007e00h
ALT_8		EQU		000007f00h
ALT_9		EQU		000008000h
K_SPACE		EQU		000003920h
K_EXCLAM		EQU		000000221h
K_QUOTE		EQU		000002822h
K_POUND		EQU		000000423h
K_DOLLAR		EQU		000000524h
K_PERCENT		EQU		000000625h
K_AND		EQU		000000826h
K_APOST		EQU		000002827h
K_LPAREN		EQU		000000a28h
K_RPAREN		EQU		000000b29h
K_STAR		EQU		00000092ah
K_PLUS		EQU		000000d2bh
K_COMMA		EQU		00000332ch
K_MINUS		EQU		000000c2dh
K_PERIOD		EQU		00000342eh
K_FSLASH		EQU		00000352fh
K_COLON		EQU		00000273ah
K_SCOLON		EQU		00000273bh
K_LESS		EQU		00000333ch
K_EQUAL		EQU		000000d3dh
K_GREAT		EQU		00000343eh
K_QUEST		EQU		00000353fh
K_AMPER		EQU		000000340h
K_A		EQU		000001e41h
K_B		EQU		000003042h
K_C		EQU		000002e43h
K_D		EQU		000002044h
K_E		EQU		000001245h
K_F		EQU		000002146h
K_G		EQU		000002247h
K_H		EQU		000002348h
K_I		EQU		000001749h
K_J		EQU		00000244ah
K_K		EQU		00000254bh
K_L		EQU		00000264ch
K_M		EQU		00000324dh
K_N		EQU		00000314eh
K_O		EQU		00000184fh
K_P		EQU		000001950h
K_Q		EQU		000001051h
K_R		EQU		000001352h
K_S		EQU		000001f53h
K_T		EQU		000001454h
K_U		EQU		000001655h
K_V		EQU		000002f56h
K_W		EQU		000001157h
K_X		EQU		000002d58h
K_Y		EQU		000001559h
K_Z		EQU		000002c5ah
K_LBRACK		EQU		000001a5bh
K_BSLASH		EQU		000002b5ch
K_RBRACK		EQU		000001b5dh
K_KARAT		EQU		00000075eh
K_UNDER		EQU		000000c5ch
K_a		EQU		000001e61h
K_b		EQU		000003062h
K_c		EQU		000002e63h
K_d		EQU		000002064h
K_e		EQU		000001265h
K_f		EQU		000002166h
K_g		EQU		000002267h
K_h		EQU		000002368h
K_i		EQU		000001769h
K_j		EQU		00000246ah
K_k		EQU		00000256bh
K_l		EQU		00000266ch
K_m		EQU		00000326dh
K_n		EQU		00000316eh
K_o		EQU		00000186fh
K_p		EQU		000001970h
K_q		EQU		000001071h
K_r		EQU		000001372h
K_s		EQU		000001f73h
K_t		EQU		000001474h
K_u		EQU		000001675h
K_v		EQU		000002f76h
K_w		EQU		000001177h
K_x		EQU		000002d78h
K_y		EQU		000001579h
K_z		EQU		000002c7ah
