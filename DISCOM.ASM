;--------------------------------------
;
; discom.asm

; .COM file disassembler
;

; defines here

include tab6.inc


; prototypes

print_reg16      PROTO PASCAL,num:BYTE
print_reg8       PROTO PASCAL,num:BYTE
is_ascii         PROTO PASCAL,aval:BYTE
print_offset     PROTO PASCAL,off100:WORD
print_comment    PROTO PASCAL
pass1            PROTO PASCAL
create_label     PROTO PASCAL,val:WORD
s_search         PROTO PASCAL,val:WORD
insert_sort      PROTO PASCAL,val:WORD
get_short_offset PROTO
get_16bit_offset PROTO

; Create stack

    .STACK                         ; 1 K by default


; Declare EXTERNDEFS

EXTERNDEF com_img:BYTE  ; in DISCOM1.ASM

; defines
LODSB_COM       EQU     20
RET_COM         EQU     20
JMP_COM         EQU     15
MOV_X_COM       EQU     11
MOV_H_COM       EQU     13
DB_COM          EQU     16
INT_COM         EQU     16

JMP_SHORT_COM   EQU     -1
CALL_DIRECT_COM EQU     -2

        .FARDATA

com_img         db      64000 DUP(0)

; Declare data segment

        .DATA

buff_32         db      80 DUP(' ')
ascii_char      db      ?
int_char        db      ?
com_opt         db      ?
flag            db      ?

label_array     dw      5000 DUP(0)
label_total     dw      0
label_buff      db      'L'
label_buff_num  db      '0000',0
low_pt          dw      ?
mid_pt          dw      ?
high_pt         dw      ?
full_dash       db      '; ---------------------------------;'
int_msg_1       db      'Single Step Interrupt'
int_msg_2       db      'Non-MaskableInterrupt'
int_msg_3       db      'Breakpoint Interrupt'
int_msg_5       db      'Print Screen Interrupt'
int_msg_8       db      'System Timer Interrupt'
int_msg_9       db      'Keyboard Interrupt'
int_msg_b       db      'Serial Port Interrupt'
int_msg_c       db      'Serial Port Interrupt'
int_msg_d       db      'Hard Disk Interrupt'
int_msg_e       db      'Floppy Disk Interrupt'
int_msg_f       db      'Printer Interrupt'
int_msg_10      db      'BIOS Video Services'
int_msg_11      db      'Get Equip. Status Int.'
int_msg_12      db      'Get Memory Size Int.'
int_msg_13      db      'Reset Floppy Disk Int.'
int_msg_14      db      'COMM Port Interrupt'
int_msg_15      db      'BIOS (Check Reference)'
int_msg_16      db      'Keyboard Management Int.'
int_msg_17      db      'Printer Management Int.'
int_msg_18      db      'Execute ROM Basic Int.'
int_msg_19      db      'System Warm Boot Int.'
int_msg_1a      db      'Clock Management Int.'
int_msg_1b      db      'Control-Break Addr. Int.'
int_msg_1c      db      'Tick Timer Interrupt'
int_msg_21      db      'DOS Services Interrupt'
int_chk_ref     db      'Check DOS Reference'
ret_msg_1       db      'Return from subroutine'
jmp_msg_1       db      'Jump Short (+ or - 128 bytes)'
call_msg_1      db      'Call Subroutine (direct)'

zero_dat        db      '0'
ax_dat          db      'ax'
bx_dat          db      'bx'
cx_dat          db      'cx'
dx_dat          db      'dx'
al_dat          db      'al'
bl_dat          db      'bl'
cl_dat          db      'cl'
dl_dat          db      'dl'
ah_dat          db      'ah'
bh_dat          db      'bh'
ch_dat          db      'ch'
dh_dat          db      'dh'
cs_dat          db      'cs'
es_dat          db      'es'
ds_dat          db      'ds'
si_dat          db      'si'
di_dat          db      'di'
sp_dat          db      'sp'
bp_dat          db      'bp'
ss_dat          db      'ss'

holdal          db      ?
holdax          dw      ?
holdsi          dw      ?
temp_dw         dw      ?
temp_db         db      ?
temp_ctr        dw      ?

pass_number     dw      1

a_scrn          db      ?
i_scrn          db      ?
t_scrn          db      ?
file_length     dw      0
off_counter     dw      0
start_counter   dw      ?
label_counter   dw      0
handle          dw      ?
itoa_buff       db      12 DUP(0)
itoa_buff1      db      12 DUP(0)
        
      
; program message

aaa_msg         db      '        aaa    '
aad_msg         db      '        aad         00ah'
aam_msg         db      '        aam         00ah'
aas_msg         db      '        aas    '
add_msg         db      '        add    '
call_msg        db      '        call   '
cbw_msg         db      '        cbw    '
clc_msg         db      '        clc    '
cld_msg         db      '        cld    '
cli_msg         db      '        cli    '
cmc_msg         db      '        cmc    '
cmp_msg         db      '        cmp    '
cwd_msg         db      '        cwd    '
daa_msg         db      '        daa    '
das_msg         db      '        das    '
hlt_msg         db      '        hlt    '
int_msg         db      '        int    0'
into_msg        db      '        into   '
iret_msg        db      '        iret   '
ja_msg          db      '        ja     '
jbe_msg         db      '        jbe    '
jc_msg          db      '        jc     '
jcxz_msg        db      '        jcxz   '
je_msg          db      '        je     '
jg_msg          db      '        jg     '
jl_msg          db      '        jl     '
jle_msg         db      '        jle    '
jmp_msg         db      '        jmp    '
jae_msg         db      '        jae    '
jne_msg         db      '        jne    '
jno_msg         db      '        jno    '
jns_msg         db      '        jns    '
jnp_msg         db      '        jnp    '
jo_msg          db      '        jo     '
jpe_msg         db      '        jpe    '
js_msg          db      '        js     '
lahf_msg        db      '        lahf   '
les_msg         db      '        les    '
lock_msg        db      '        lock   '
lodsb_msg       db      '        lodsb  '
lodsw_msg       db      '        lodsw  '
mov_msg         db      '        mov    '
nop_msg         db      '        nop    '
pop_msg         db      '        pop    '
push_msg        db      '        push   '
ret_msg         db      '        ret    '
rep_movsb       db      '        rep    movsb'
rep_movsw       db      '        rep    movsw'
rep_stosb       db      '        rep    stosb'
rep_stosw       db      '        rep    stosw'
shr_msg         db      '        shr    '
stc_msg         db      '        stc    '
std_msg         db      '        std    '
sti_msg         db      '        sti    '
stosb_msg       db      '        stosb  '
stosw_msg       db      '        stosw  '


four_zeros      db      '0000',0
apost_dat       db      27h
dollar_dat      db      '$'
colon_dat       db      ':'
semi_c_dat      db      '; '
comma_dat       db      ','
comma_1_dat     db      ',1'
dash_dat        db      '---------------------------------'
crlf            db      13,10,0
h_dat           db      'h',13,10,0
db_hdr0         db      '        db     0'
db_hdr1         db      '        db     ',39
db_hex          db      5 DUP(0),0

source_hdr1     db      ';',13,10,'; '
source_hdr2     db      13,10,';',13,10,13,10
                db      '        .MODEL TINY',13,10,13,10
                db      '        .CODE',13,10,13,10
                db      '        ORG 100h',13,10,13,10
                db      'start:',13,10,0

source_ftr1     db      13,10,13,10,'        END start',13,10,13,10,0

source_name     db      16 DUP(0)

file_not_found  db      '** ERROR ** COM File open error.',0
file_ext        db      '.COM',0
bax_help        db      '/H',0
command_line    db      128 DUP(0)
command_count   db      ?
prog_name       db      ' Baby Bax COM Disassembler '
jumping         db      'Jumping Instructions:'
branching       db      'Branching Instructions:'
looping         db      'Looping Instructions:'
num_labels      db      'Number of Memory References:'
file_name       db      'File Name:'
error_intro     db      'Baby BAX COM Dissambler Version 1.0',0
error_under     db      '-----------------------------------',0
not_com         db      'DISCOM requires that .COM extender be used.',0
not_com_1       db      'ex: DISCOM FOO.COM <enter>',0
help1           db      'Syntax: DISCOM FOO.COM (.COM must be present)',0
flen_msg        db      'File Length:',0
pass_msg        db      'Pass Number:',0
percent_msg     db      '% Complete:            ',0



L_prog_name     EQU     LENGTHOF prog_name
L_jumping       EQU     LENGTHOF jumping
L_branching     EQU     LENGTHOF branching
L_looping       EQU     LENGTHOF looping
L_num_labels    EQU     LENGTHOF num_labels
L_file_name     EQU     LENGTHOF file_name
L_source_hdr1   EQU     LENGTHOF source_hdr1



; Begin code segment

        .CODE

; Start program here

        .STARTUP


; copy command line to command line buffer

        mov     bx,COMMAND_LENGTH
        mov     al,byte ptr es:[bx]
        mov     command_count,al
        mov     bx,COMMAND_START
        mov     si,OFFSET command_line

        .REPEAT
        mov     al,byte ptr es:[bx]

        .IF (al > 20h)
        mov     byte ptr ds:[si],al
        inc     si
        .ENDIF

        inc     bx
        dec     command_count

        .UNTIL (command_count == 0)

        INVOKE  strupr,ADDR command_line

        INVOKE  strsrch,ADDR command_line,ADDR bax_help

        .IF (ax > 0)
        call    prog_help
        mov     ax,4c00h
        int     21h
        .ENDIF

        INVOKE  strsrch,ADDR command_line,ADDR file_ext
        .IF (ax == 0)
        call     prog_help
        mov     ax,4c00h
        int     21h
        .ENDIF
        

; open .COM file for read

        INVOKE openFile,ADDR handle,ADDR command_line,O_RDWR

; if AX != 0 then error

        .IF (ax != 0)
        INVOKE  clrScrn,7
        INVOKE  bdwrite,0,0,ADDR file_not_found
        INVOKE  mvCur,3,0
        mov     ax,4c00h
        int     21h
        .ENDIF

; read the file => ax holds .COM bytes read

        INVOKE readFile,ADDR com_img,handle,64000

        mov     file_length,ax

; close the open file

        INVOKE closeFile,handle


; create .ASM name

        INVOKE  strcpy,ADDR source_name,ADDR command_line

        mov     si,OFFSET source_name
        mov     di,OFFSET source_name

        .REPEAT
        lodsb   
        .UNTIL (al == '.')
        mov     Byte Ptr ds:[si],'A'
        inc     si
        mov     Byte Ptr ds:[si],'S'
        inc     si
        mov     Byte Ptr ds:[si],'M'
        inc     si
        mov     Byte Ptr ds:[si],0


; create and open file named source name

        INVOKE  createFile,ADDR handle,ADDR source_name,NORMAL_FILE
        INVOKE  writeFile,ADDR full_dash,handle,LENGTHOF full_dash
        INVOKE  writeFile,ADDR crlf,handle,2
        INVOKE  writeFile,ADDR source_hdr1,handle,L_source_hdr1
        INVOKE  strlen,ADDR source_name
        mov     holdax,ax
        INVOKE  writeFile,ADDR source_name,handle,holdax
        INVOKE  strlen,ADDR source_hdr2
        mov     holdax,ax
        INVOKE  writeFile,ADDR source_hdr2,handle,holdax

        


; Initialize video

        INVOKE  vidInit

; Turn off the cursor

        INVOKE  offCur


; prepare attributes

        INVOKE  mkAttr,ADDR t_scrn,BLACK,WHITE,OFF_INTENSITY,OFF_BLINK
        INVOKE  mkAttr,ADDR a_scrn,WHITE,BLUE,OFF_INTENSITY,OFF_BLINK
        INVOKE  mkAttr,ADDR i_scrn,WHITE,BLUE,ON_INTENSITY,OFF_BLINK

; prepare main screen

        INVOKE  clrScrn,a_scrn

; box screen here

        INVOKE  vdBox,0,0,23,79,a_scrn,D_D_S_S
        INVOKE  vdWrite,0,26,L_prog_name,ADDR prog_name,t_scrn

; print file name here

        INVOKE  vdWrite,24,0,L_file_name,ADDR file_name,t_scrn
        INVOKE  vdWrite,24,L_file_name+1,0,ADDR command_line,i_scrn
        INVOKE  vdWrite,24,L_file_name+16,0,ADDR flen_msg,t_scrn
        INVOKE  vdWrite,24,L_file_name+38,0,ADDR pass_msg,t_scrn
        
; box and print process labels

        INVOKE  vdBox,1,1,5,5+L_num_labels+6,a_scrn,S_S_S_S   
        INVOKE  vdWrite,2,4,L_jumping,ADDR jumping,a_scrn
        INVOKE  vdWrite,3,4,L_branching,ADDR branching,a_scrn
        INVOKE  vdWrite,4,4,L_num_labels,ADDR num_labels,a_scrn
        INVOKE  vdWrite,24,64,11,ADDR percent_msg,t_scrn

; print the file length and pass number

        INVOKE  itoa,ADDR itoa_buff,file_length
        INVOKE  vdWrite,24,39,0,ADDR itoa_buff,i_scrn        
        INVOKE  itoa,ADDR itoa_buff,pass_number
        INVOKE  vdWrite,24,61,0,ADDR itoa_buff,i_scrn


;--------------------------------------
; disassembly loop

        INVOKE  pass1

; set 100h offset counter to 0

        mov     off_counter,0
        mov     label_counter,0

; begin db test loop

        push    es
        mov     si,OFFSET com_img
        mov     ax,SEG com_img
        mov     es,ax

; initialize comment variables

        mov     ascii_char,0
        mov     int_char,0

        .REPEAT

; set write length to 0 for comment write

        mov     write_length,0

; check to see if the label is being printer

check_new_label:
        
        mov     bx,label_counter
        shl     bx,1
        mov     ax,Word Ptr label_array[bx]

        .IF (ax == 0)
        jmp     no_check_label
        .ENDIF

        .IF (ax < off_counter)
        inc     label_counter
        jmp     check_new_label
        .ENDIF

no_check_label:

        .IF (ax == off_counter)
        INVOKE  writeFile,ADDR crlf,handle,2
        INVOKE  create_label,label_counter
        inc     label_counter
        INVOKE  writeFile,ADDR label_buff,handle,5
        INVOKE  writeFile,ADDR colon_dat,handle,1
        INVOKE  writeFile,ADDR buff_32,handle,2
        INVOKE  writeFile,ADDR semi_c_dat,handle,1
        INVOKE  writeFile,ADDR dash_dat,handle,26
        INVOKE  writeFile,ADDR semi_c_dat,handle,1
        INVOKE  writeFile,ADDR crlf,handle,2
        .ENDIF

; get byte from .COM file and increment index

        mov     al,Byte Ptr es:[si]
        inc     si

; save si and ax

        mov     holdsi,si
        mov     holdax,ax

; increment .COM offset counter

        push    off_counter
        pop     start_counter
        add     start_counter,0100h
        inc     off_counter

; int  xxh

        .IF( al == 0cdh) 
        mov     com_opt,INT_COM
        INVOKE  writeFile,ADDR int_msg,handle,16
        jmp     is_instruction
        .ENDIF

; les reg,address
        .IF (al == 0c4h)
        INVOKE  writeFile,ADDR les_msg,handle,15
        mov     si,holdsi
        mov     al, Byte Ptr es:[si]
        inc     si
        inc     holdsi
        inc     off_counter
        mov     holdal,al
        and     holdal,0c0h
        .IF (holdal == 0)
        mov     holdal,al
        shr     holdal,1        
        shr     holdal,1        
        shr     holdal,1
        and     holdal,7
        INVOKE  print_reg16,holdal
        INVOKE  writeFile,ADDR comma_dat,handle,1
        INVOKE  writeFile,ADDR cs_dat,handle,2
        INVOKE  writeFile,ADDR colon_dat,handle,1
        mov     ax, Word Ptr es:[si]
        add     si,2
        add     holdsi,2
        add     off_counter,2
        mov     temp_dw,ax
        INVOKE  memset,ADDR db_hex,0,5
        INVOKE  itoh,ADDR db_hex,temp_dw,HEX_16_BIT
        INVOKE  strlen,ADDR db_hex
        mov     temp_dw,ax
        INVOKE  writeFile,ADDR zero_dat,handle,1
        INVOKE  writeFile,ADDR db_hex,handle,temp_dw
        INVOKE  writeFile,ADDR h_dat,handle,1
        .ENDIF
        jmp     write_c
        .ENDIF

; cmp   al or ax with immediate

        .IF (al == 3ch)  ; al
        INVOKE  writeFile,ADDR cmp_msg,handle,15
        INVOKE  writeFile,ADDR al_dat,handle,2
        INVOKE  writeFile,ADDR comma_dat,handle,1
        jmp     is_instruction
        .ENDIF

        .IF (al == 3dh)  ; ax
        INVOKE  writeFile,ADDR cmp_msg,handle,15
        INVOKE  writeFile,ADDR ax_dat,handle,2
        INVOKE  writeFile,ADDR comma_dat,handle,1
        jmp     is_16_instruction
        .ENDIF
; push reg

       mov     holdal,al
       and     holdal,0f8h
       .IF (holdal == 50h)
       INVOKE  writeFile,ADDR push_msg,handle,15
       mov     ax,holdax
       mov     holdal,al
       and     holdal,7
       INVOKE  print_reg16,holdal
       jmp     write_crlf
       .ENDIF

; pop reg

       mov     holdal,al
       and     holdal,0f8h
       .IF (holdal == 58h)
       INVOKE  writeFile,ADDR pop_msg,handle,15
       mov     ax,holdax
       mov     holdal,al
       and     holdal,7
       INVOKE  print_reg16,holdal
       jmp     write_crlf
       .ENDIF

; mov al to memory
        .IF (al == 0a2h)
        INVOKE  writeFile,ADDR mov_msg,handle,15
        INVOKE  writeFile,ADDR cs_dat,handle,2
        INVOKE  writeFile,ADDR colon_dat,handle,1
        mov     si,holdsi
        mov     ax, Word Ptr es:[si]
        mov     temp_dw,ax
        INVOKE  memset,ADDR db_hex,0,5
        INVOKE  itoh,ADDR db_hex,temp_dw,HEX_16_BIT
        INVOKE  strlen,ADDR db_hex
        mov     temp_dw,ax
        INVOKE  writeFile,ADDR zero_dat,handle,1
        INVOKE  writeFile,ADDR db_hex,handle,temp_dw
        INVOKE  writeFile,ADDR h_dat,handle,1
        INVOKE  writeFile,ADDR comma_dat,handle,1
        INVOKE  writeFile,ADDR al_dat,handle,2
        add     holdsi,2
        add     si,2
        add     off_counter,2
        jmp     write_c
        .ENDIF
 
; mov ax to memory
        .IF (al == 0a3h)
        INVOKE  writeFile,ADDR mov_msg,handle,15
        INVOKE  writeFile,ADDR cs_dat,handle,2
        INVOKE  writeFile,ADDR colon_dat,handle,1
        mov     si,holdsi
        mov     ax, Word Ptr es:[si]
        mov     temp_dw,ax
        INVOKE  memset,ADDR db_hex,0,5
        INVOKE  itoh,ADDR db_hex,temp_dw,HEX_16_BIT
        INVOKE  strlen,ADDR db_hex
        mov     temp_dw,ax
        INVOKE  writeFile,ADDR zero_dat,handle,1
        INVOKE  writeFile,ADDR db_hex,handle,temp_dw
        INVOKE  writeFile,ADDR h_dat,handle,1
        INVOKE  writeFile,ADDR comma_dat,handle,1
        INVOKE  writeFile,ADDR ax_dat,handle,2
        add     holdsi,2
        add     si,2
        add     off_counter,2
        jmp     write_c
        .ENDIF
        
 
; mov 16 bit seg or mem to reg

        .IF (al == 08ch)
        INVOKE  writeFile,ADDR mov_msg,handle,15
        mov     si,holdsi
        mov     al, Byte Ptr es:[si]
        mov     holdal,al
        and     holdal,0c0h
        .IF (holdal == 0c0h)
        mov     holdal,al
        and     holdal,7
        push    ax
        INVOKE  print_reg16,holdal
        INVOKE  writeFile,ADDR comma_dat,handle,1
        pop     ax
        mov     holdal,al
        shr     holdal,1        
        shr     holdal,1        
        shr     holdal,1        
        and     holdal,7
        .IF (holdal == 3)
        INVOKE  writeFile,ADDR ds_dat,handle,2
        .ELSEIF (holdal == 0)
        INVOKE  writeFile,ADDR es_dat,handle,2
        .ELSEIF (holdal == 1)
        INVOKE  writeFile,ADDR cs_dat,handle,2
        .ENDIF
        inc     off_counter
        inc     holdsi
        inc     si
        .ENDIF

        jmp     write_c
        .ENDIF

; mov 16 bit reg,data

        .IF (al == 08bh)
        INVOKE  writeFile,ADDR mov_msg,handle,15
        mov     si,holdsi
        mov     al, Byte Ptr es:[si]
        mov     holdal,al
        and     holdal,0c0h
        mov     holdal,al
        shr     holdal,1
        shr     holdal,1
        shr     holdal,1
        and     holdal,7
        push    ax
        INVOKE  print_reg16,holdal
        INVOKE  writeFile,ADDR comma_dat,handle,1
        pop     ax
        mov     holdal,al
        and     holdal,7
        INVOKE  print_reg16,holdal
        inc     off_counter
        inc     holdsi
        jmp     write_crlf
        .ENDIF

; mov   reg,data

        mov     holdal,al
        and     holdal,0f0h

        .IF (holdal == 0b0h)
        INVOKE  writeFile,ADDR mov_msg,handle,15
        mov     ax,holdax
        mov     holdal,al
        and     holdal,08h

        .IF (holdal == 00h)
        mov     com_opt,MOV_H_COM
        mov     ax,holdax
        mov     holdal,al
        and     holdal,7
        INVOKE  print_reg8,holdal
        INVOKE  writeFile,ADDR comma_dat,handle,1
        INVOKE  writeFile,ADDR zero_dat,handle,1
        jmp     is_instruction
        .ELSE
        mov     com_opt,MOV_X_COM
        mov     ax,holdax
        mov     holdal,al
        and     holdal,7
        INVOKE  print_reg16,holdal
        INVOKE  writeFile,ADDR comma_dat,handle,1
        jmp     is_16_instruction
        .ENDIF
        .ENDIF

; call label direct [low][high]

        .IF( al == 0e8h) 
        mov     com_opt,JMP_COM
        mov     ascii_char,CALL_DIRECT_COM
        INVOKE  writeFile,ADDR call_msg,handle,15
        call    get_16bit_offset
        jmp     write_c
        .ENDIF

; aaa

        .IF( al == 037h) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR aaa_msg,handle,15
        jmp     write_c
        .ENDIF

; aad

        .IF( al == 0d5h) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR aad_msg,handle,LENGTHOF aad_msg
        jmp     write_c
        .ENDIF

; aam

        .IF( al == 0d4h) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR aam_msg,handle,LENGTHOF aam_msg
        jmp     write_c
        .ENDIF

; aas

        .IF( al == 03fh) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR aas_msg,handle,15
        jmp     write_c
        .ENDIF

; add immediate word to register

        .IF (al == 83h)
        mov     al,Byte Ptr es:[si]
        inc     si
        inc     holdsi
        inc     off_counter
        mov     holdal,al
        and     holdal,0c0h
        .IF (holdal == 0c0h)
        INVOKE  writeFile,ADDR add_msg,handle,15
        INVOKE  writeFile,ADDR ax_dat,handle,2
        INVOKE  writeFile,ADDR comma_dat,handle,1
        mov     ax,Word Ptr es:[si]
        mov     temp_dw,ax
        INVOKE  memset,ADDR db_hex,0,5
        INVOKE  itoh,ADDR db_hex,temp_dw,HEX_8_BIT
        INVOKE  strlen,ADDR db_hex
        mov     temp_dw,ax
        INVOKE  writeFile,ADDR zero_dat,handle,1
        INVOKE  writeFile,ADDR db_hex,handle,temp_dw
        INVOKE  writeFile,ADDR h_dat,handle,1
        .ENDIF
        inc     off_counter
        inc     si
        inc     holdsi
        jmp     write_c
        .ENDIF

; add word to accumulator
        .IF (al == 5)
        INVOKE  writeFile,ADDR add_msg,handle,15
        INVOKE  writeFile,ADDR ax_dat,handle,2
        INVOKE  writeFile,ADDR comma_dat,handle,1
        mov     ax,Word Ptr es:[si]
        mov     temp_dw,ax
        INVOKE  memset,ADDR db_hex,0,5
        INVOKE  itoh,ADDR db_hex,temp_dw,HEX_16_BIT
        INVOKE  strlen,ADDR db_hex
        mov     temp_dw,ax
        INVOKE  writeFile,ADDR zero_dat,handle,1
        INVOKE  writeFile,ADDR db_hex,handle,temp_dw
        INVOKE  writeFile,ADDR h_dat,handle,1
        add     off_counter,2
        add     si,2
        add     holdsi,2
        jmp     write_c
        .ENDIF

        


; cbw

        .IF( al == 098h) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR cbw_msg,handle,15
        jmp     write_c
        .ENDIF

; clc

        .IF( al == 0f8h) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR clc_msg,handle,15
        jmp     write_c
        .ENDIF


; cld 

        .IF( al == 0fch) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR cld_msg,handle,15
        jmp     write_c
        .ENDIF

; cli

        .IF( al == 0fah) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR cli_msg,handle,15
        jmp     write_c
        .ENDIF

; cmc

        .IF( al == 0f5h) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR cmc_msg,handle,15
        jmp     write_c
        .ENDIF

; cwd

        .IF( al == 099h) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR cwd_msg,handle,15
        jmp     write_c
        .ENDIF

; daa

        .IF( al == 027h) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR daa_msg,handle,15
        jmp     write_c
        .ENDIF

; das

        .IF( al == 02fh) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR das_msg,handle,15
        jmp     write_c
        .ENDIF

; hlt

        .IF( al == 0f4h) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR hlt_msg,handle,15
        jmp     write_c
        .ENDIF

; into

        .IF( al == 0ceh) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR into_msg,handle,15
        jmp     write_c
        .ENDIF

; iret

        .IF( al == 0cfh) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR iret_msg,handle,15
        jmp     write_c
        .ENDIF

; lahf

        .IF( al == 09fh) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR lahf_msg,handle,15
        jmp     write_c
        .ENDIF

; lock

        .IF( al == 0f0h) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR lock_msg,handle,15
        jmp     write_c
        .ENDIF



; lodsb   => mov    al,Byte Ptr ds:[si]        
;            inc    si

        .IF( al == 0ach) 
        mov     com_opt,JMP_COM
        mov     ascii_char,0
        INVOKE  writeFile,ADDR lodsb_msg,handle,20
        jmp     write_c
        .ENDIF

; lodsw   => mov    al,Word Ptr ds:[si]        
;            inc    si

        .IF( al == 0adh) 
        mov     com_opt,JMP_COM
        mov     ascii_char,0
        INVOKE  writeFile,ADDR lodsw_msg,handle,20
        jmp     write_c
        .ENDIF


; nop

        .IF( al == 090h) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR nop_msg,handle,15
        jmp     write_c
        .ENDIF

; rep
        .IF (al == 0f3h)
        mov     al,Byte Ptr es:[si]
        .IF (al == 0a4h)
        INVOKE  writeFile,ADDR rep_movsb,handle,LENGTHOF rep_movsb
        .ELSEIF (al == 0a5h)
        INVOKE  writeFile,ADDR rep_movsw,handle,LENGTHOF rep_movsw
        .ELSEIF (al == 0aah)
        INVOKE  writeFile,ADDR rep_stosb,handle,LENGTHOF rep_stosb
        .ELSE
        INVOKE  writeFile,ADDR rep_stosw,handle,LENGTHOF rep_stosw
        .ENDIF
        inc     si
        inc     holdsi
        inc     off_counter
        jmp     write_c
        .ENDIF        

; ret 
        .IF( al == 0c3h) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR ret_msg,handle,15
        jmp     write_c
        .ENDIF

; shr 16 bit by 1

        .IF (al == 0d1h)
        INVOKE  writeFile,ADDR shr_msg,handle,15
        mov     al,Byte Ptr es:[si]
        mov     temp_db,al
        and     temp_db,0f8h
        .IF (temp_db == 0e8h) 
        mov     temp_db,al
        and     temp_db,7
        INVOKE  print_reg16,temp_db
        .ENDIF
        INVOKE  writeFile,ADDR comma_1_dat,handle,2
        inc     si
        inc     holdsi
        inc     off_counter
        jmp     write_c
        .ENDIF


 

; stc

        .IF( al == 07dh) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR stc_msg,handle,15
        jmp     write_c
        .ENDIF

; std

        .IF( al == 0fdh) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR std_msg,handle,15
        jmp     write_c
        .ENDIF

; sti

        .IF( al == 0fbh) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR sti_msg,handle,15
        jmp     write_c
        .ENDIF

; stosb

        .IF( al == 0aah) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR stosb_msg,handle,15
        jmp     write_c
        .ENDIF

; stosw

        .IF( al == 0abh) 
        mov     com_opt,RET_COM
        mov     ascii_char,0
        mov     int_char,0
        INVOKE  writeFile,ADDR stosw_msg,handle,15
        jmp     write_c
        .ENDIF



; ja
        .IF (al == 77h)
        mov     com_opt,JMP_COM
        mov     ascii_char,0        
        INVOKE  writeFile,ADDR ja_msg,handle,15
        jmp     js1
        .ENDIF

; jae
        .IF (al == 73h)
        mov     com_opt,JMP_COM
        mov     ascii_char,0        
        INVOKE  writeFile,ADDR jae_msg,handle,15
        jmp     js1
        .ENDIF

; jbe
        .IF (al == 76h)
        mov     com_opt,JMP_COM
        mov     ascii_char,0        
        INVOKE  writeFile,ADDR jbe_msg,handle,15
        jmp     js1
        .ENDIF

; jc
        .IF (al == 72h)
        mov     com_opt,JMP_COM
        mov     ascii_char,0        
        INVOKE  writeFile,ADDR jc_msg,handle,15
        jmp     js1
        .ENDIF

; je
        .IF (al == 74h)
        mov     com_opt,JMP_COM
        mov     ascii_char,0        
        INVOKE  writeFile,ADDR je_msg,handle,15
        jmp     js1
        .ENDIF

; jg
        .IF (al == 7fh)
        mov     com_opt,JMP_COM
        mov     ascii_char,0        
        INVOKE  writeFile,ADDR jg_msg,handle,15
        jmp     js1
        .ENDIF

; jl
        .IF (al == 7ch)
        mov     com_opt,JMP_COM
        mov     ascii_char,0        
        INVOKE  writeFile,ADDR jl_msg,handle,15
        jmp     js1
        .ENDIF

; jle
        .IF (al == 7eh)
        mov     com_opt,JMP_COM
        mov     ascii_char,0        
        INVOKE  writeFile,ADDR jle_msg,handle,15
        jmp     js1
        .ENDIF

; jne
        .IF (al == 75h)
        mov     com_opt,JMP_COM
        mov     ascii_char,0        
        INVOKE  writeFile,ADDR jne_msg,handle,15
        jmp     js1
        .ENDIF

; jno
        .IF (al == 71h)
        mov     com_opt,JMP_COM
        mov     ascii_char,0        
        INVOKE  writeFile,ADDR jno_msg,handle,15
        jmp     js1
        .ENDIF

; jns
        .IF (al == 79h)
        mov     com_opt,JMP_COM
        mov     ascii_char,0        
        INVOKE  writeFile,ADDR jns_msg,handle,15
        jmp     js1
        .ENDIF

; jnp
        .IF (al == 76h)
        mov     com_opt,JMP_COM
        mov     ascii_char,0        
        INVOKE  writeFile,ADDR jnp_msg,handle,15
        jmp     js1
        .ENDIF

; jo
        .IF (al == 70h)
        mov     com_opt,JMP_COM
        mov     ascii_char,0        
        INVOKE  writeFile,ADDR jo_msg,handle,15
        jmp     js1
        .ENDIF

; jpe
        .IF (al == 7ah)
        mov     com_opt,JMP_COM
        mov     ascii_char,0        
        INVOKE  writeFile,ADDR jpe_msg,handle,15
        jmp     js1
        .ENDIF

; js
        .IF (al == 78h)
        mov     com_opt,JMP_COM
        mov     ascii_char,0        
        INVOKE  writeFile,ADDR js_msg,handle,15
        jmp     js1
        .ENDIF


; jmp short

        .IF( al == 0ebh) 
        mov     com_opt,JMP_COM
        mov     ascii_char,JMP_SHORT_COM
        INVOKE  writeFile,ADDR jmp_msg,handle,15
js1:
        call    get_short_offset
        jmp     write_c
        
is_instruction:
        mov     si,holdsi
        mov     al,Byte Ptr es:[si]
        sub     ah,ah
        .IF (com_opt == INT_COM)
        mov     int_char,al
        .ENDIF
        mov     holdax,ax
        inc     si
        mov     holdsi,si
        inc     off_counter
        jmp     mnemonic_header

is_16_instruction:
        mov     si,holdsi
        mov     al,Byte Ptr es:[si]
        inc     si
        mov     ah,Byte Ptr es:[si]
        mov     holdax,ax
        inc     si
        mov     holdsi,si
        add     off_counter,2
        INVOKE  memset,ADDR db_hex,0,5
        INVOKE  itoh,ADDR db_hex,holdax,HEX_16_BIT
        INVOKE  strlen,ADDR db_hex
        mov     holdax,ax
        INVOKE  writeFile,ADDR zero_dat,handle,1
        INVOKE  writeFile,ADDR db_hex,handle,holdax
        jmp     write_h
        .ENDIF

; write db header format to disk
        mov     ax,holdax
        INVOKE  is_ascii,al
        cmp     al,0
        jne     str_write0
        INVOKE  writeFile,ADDR db_hdr0,handle,16
        mov     ax,holdax
        jmp     mnemonic_header

str_write0:
        INVOKE  writeFile,ADDR db_hdr1,handle,16
        mov     ax,holdax
        sub     ah,ah
str_write:
        cmp     al,0
        je      str_write_done_0
        cmp     al,'$'
        je      str_write_done_$
        push    ax
        INVOKE  is_ascii,al
        cmp     al,0
        je      str_write_not_ascii
        pop     ax
        mov     ascii_char,al
        INVOKE  writeFile,ADDR ascii_char,handle,1
        mov     al,Byte Ptr es:[si]
        inc     holdsi
        mov     si,holdsi
        inc     off_counter
        jmp     str_write
str_write_done_$:
        INVOKE  writeFile,ADDR dollar_dat,handle,1
        mov     ascii_char,39
        INVOKE  writeFile,ADDR ascii_char,handle,1
        mov     com_opt,JMP_COM
        mov     ascii_char,0
        jmp     write_c

str_write_not_ascii:
        pop     holdax
        jmp     str_write_done_01
str_write_done_0:
        mov     holdax,0
str_write_done_01:
        mov     ascii_char,39
        INVOKE  writeFile,ADDR ascii_char,handle,1
;        INVOKE  writeFile,ADDR crlf,handle,2
;        INVOKE  writeFile,ADDR db_hdr0,handle,16
;        mov     com_opt,JMP_COM
        dec     holdsi
        dec     off_counter
        mov     ascii_char,0
        jmp     write_crlf

;---------------
mnemonic_header:
;---------------

; set db_hex to 0 and store hex ASCII in buffer
        INVOKE  memset,ADDR db_hex,0,5

; write hex ASCII to db_hex and write to disk
        INVOKE  itoh,ADDR db_hex,holdax,HEX_8_BIT
        INVOKE  strlen,ADDR db_hex
        mov     holdax,ax
        INVOKE  writeFile,ADDR db_hex,handle,holdax

; write 'h' 

write_h:

        INVOKE  writeFile,ADDR h_dat,handle,1

; comment field

write_c:

        INVOKE  writeFile,ADDR buff_32,handle,com_opt
        INVOKE  writeFile,ADDR semi_c_dat,handle,2
        INVOKE  print_offset,start_counter
        INVOKE  print_comment

; write crlf

write_crlf:

        INVOKE  writeFile,ADDR crlf,handle,2

        mov     si,holdsi

line_done:

        mov     ax,file_length
        mov     dx,off_counter

        .UNTIL (dx >= ax)

        pop     es


;
;--------------------------------------

        

; print closing footer

        INVOKE  writeFile,ADDR full_dash,handle,LENGTHOF full_dash
        INVOKE  strlen,ADDR source_ftr1
        mov     holdax,ax
        INVOKE  writeFile,ADDR source_ftr1,handle,holdax
        INVOKE  writeFile,ADDR full_dash,handle,LENGTHOF full_dash
        INVOKE  closeFile,handle

; Turn on the cursor

        INVOKE  onCur
        INVOKE  mvCur,0,0

; clear the screen

        INVOKE  clrScrn,7

; End program and return to DOS

        .EXIT

print_reg8 PROC PASCAL,num:BYTE
        .IF (num == 0)
        INVOKE  writeFile,ADDR al_dat,handle,2
        .ELSEIF (num == 1)
        INVOKE  writeFile,ADDR cl_dat,handle,2
        .ELSEIF (num == 2)
        INVOKE  writeFile,ADDR dl_dat,handle,2
        .ELSEIF (num == 3)
        INVOKE  writeFile,ADDR bl_dat,handle,2
        .ELSEIF (num == 4)
        INVOKE  writeFile,ADDR ah_dat,handle,2
        .ELSEIF (num == 5)
        INVOKE  writeFile,ADDR ch_dat,handle,2
        .ELSEIF (num == 6)
        INVOKE  writeFile,ADDR dh_dat,handle,2
        .ELSE 
        INVOKE  writeFile,ADDR bh_dat,handle,2
        .ENDIF

        ret

print_reg8 ENDP
 
print_reg16 PROC PASCAL,num:BYTE
        .IF (num == 0)
        INVOKE  writeFile,ADDR ax_dat,handle,2
        .ELSEIF (num == 1)
        INVOKE  writeFile,ADDR cx_dat,handle,2
        .ELSEIF (num == 2)
        INVOKE  writeFile,ADDR dx_dat,handle,2
        .ELSEIF (num == 3)
        INVOKE  writeFile,ADDR bx_dat,handle,2
        .ELSEIF (num == 4)
        INVOKE  writeFile,ADDR sp_dat,handle,2
        .ELSEIF (num == 5)
        INVOKE  writeFile,ADDR bp_dat,handle,2
        .ELSEIF (num == 6)
        INVOKE  writeFile,ADDR si_dat,handle,2
        .ELSE 
        INVOKE  writeFile,ADDR di_dat,handle,2
        .ENDIF

        ret

print_reg16 ENDP
        

prog_help PROC NEAR
        INVOKE  clrScrn,7
        INVOKE  bdWrite,0,0,ADDR error_intro
        INVOKE  bdWrite,1,0,ADDR error_under
        INVOKE  bdWrite,2,0,ADDR help1
        INVOKE  mvCur,4,0        
        ret
prog_help ENDP


is_ascii PROC PASCAL,aval:BYTE
        mov     al,aval
        .IF (al >= 20h)
        jmp     low_ascii_ok
        .ELSE
        sub     al,al
        ret
        .ENDIF

low_ascii_ok:
        .IF  (al <= 7fh)
        ret
        .ELSE
        sub     al,al
        ret
        .ENDIF
is_ascii ENDP

print_offset PROC PASCAL,off100:WORD
        INVOKE  memset,ADDR db_hex,0,5
        INVOKE  itoh,ADDR db_hex,off100,HEX_16_BIT
        INVOKE  strlen,ADDR db_hex
        mov     holdax,ax
        INVOKE  writeFile,ADDR db_hex,handle,holdax
        ret
print_offset ENDP


pass1 PROC PASCAL USES es di ds si ax bx cx dx
        LOCAL   pass_ctr:WORD
        LOCAL   temp:WORD
        mov     pass_ctr,0
        mov     ax,SEG com_img
        mov     es,ax
        mov     si,OFFSET com_img

        .WHILE 1
        sub     ah,ah
        mov     al,Byte Ptr es:[si]
        inc     si
        push    ax
        mov     ax,file_length
        .IF (ax <= pass_ctr )
        pop     ax
          .BREAK
        .ENDIF
        pop     ax

; ja

        .IF (al == 77h)
        jmp     jsd_1
        .ENDIF

; jae

        .IF (al == 73h)
        jmp     jsd_1
        .ENDIF

; jbe

        .IF (al == 72h)
        jmp     jsd_1
        .ENDIF

; jc

        .IF (al == 72h)
        jmp     jsd_1
        .ENDIF


; je

        .IF (al == 74h)
        jmp     jsd_1
        .ENDIF

; jg

        .IF (al == 7fh)
        jmp     jsd_1
        .ENDIF

; jl

        .IF (al == 7ch)
        jmp     jsd_1
        .ENDIF

; jle

        .IF (al == 7eh)
        jmp     jsd_1
        .ENDIF

; jne

        .IF (al == 75h)
        jmp     jsd_1
        .ENDIF

; jno

        .IF (al == 71h)
        jmp     jsd_1
        .ENDIF


; jns

        .IF (al == 79h)
        jmp     jsd_1
        .ENDIF

; jnp

        .IF (al == 76h)
        jmp     jsd_1
        .ENDIF

; jo

        .IF (al == 70h)
        jmp     jsd_1
        .ENDIF

; jpe

        .IF (al == 7ah)
        jmp     jsd_1
        .ENDIF

; js

        .IF (al == 78h)
        jmp     jsd_1
        .ENDIF




; jmp short direct

        .IF (al == 0ebh) ; jmp short
jsd_1:
        mov     al,Byte Ptr es:[si]
        .IF (al < 128)
        add     al,2
        add     ax,pass_ctr
        INVOKE  insert_sort,ax
        inc     pass_ctr
        inc     pass_ctr
        inc     si
        .ELSE
        neg     al
        sub     al,2
        mov     cx,pass_ctr
        mov     temp_dw,cx
        sub     temp_dw,ax
        INVOKE  insert_sort,temp_dw
        inc     pass_ctr
        inc     pass_ctr
        inc     si
        .ENDIF

; call direct [lo][high]

        .ELSEIF (al == 0e8h) 
        mov     ax,Word Ptr es:[si]
        .IF (ax < 32767)
        add     ax,pass_ctr
        add     ax,3
        INVOKE  insert_sort,ax
        inc     pass_ctr
        inc     pass_ctr
        inc     pass_ctr
        inc     si
        inc     si
        .ELSE
        neg     ax
        add     ax,2 ; test test test
        push    pass_ctr  
        pop     temp_dw
        sub     temp_dw,ax
        mov     ax,temp_dw
        INVOKE  insert_sort,ax
        inc     pass_ctr
        inc     pass_ctr
        inc     pass_ctr
        inc     si
        inc     si
        .ENDIF

; no label generated so bypass

        .ELSE
        inc     pass_ctr
        .ENDIF


        .ENDW

        ret
pass1   ENDP

;--------------------------------------

insert_sort PROC PASCAL USES es di ds si,val:WORD
        LOCAL   counter:WORD
        
; point es:[di] label_array end 
; point ds:[si] last label array entry

        mov     ax,SEG label_array
        mov     ds,ax
        mov     es,ax
        mov     di,OFFSET label_array
        mov     ax,label_total
        shl     ax,1
        add     di,ax
        mov     si,di
        sub     si,2

; initialize label_array counter and offset

        mov     counter,0
        sub     bx,bx

        .WHILE 1

; if reached the end of label_array
 
        mov     ax,counter
        .IF (ax == label_total)
        mov     ax,val
        mov     bx,counter
        shl     bx,1
        mov     label_array[bx],ax
        inc     label_total
        .BREAK
        .ENDIF

; if current label previously entered into label array

        mov     bx,counter
        shl     bx,1        
        mov     ax,label_array[bx]
        .IF (val == ax)      ; match found -> no insert
        ret

; if new entry greater than current entry continue

        .ELSEIF (val > ax)   ; as val > item -> no insert & continue
        add     bx,2

; new entry is less than current so insert

        .ELSEIF (val < ax)   ; val < item to insert
        mov     cx,label_total
        sub     cx,counter
        std
        rep     movsw
        mov     ax,val
        stosw
        inc     label_total
        .BREAK
        .ENDIF

        inc     counter

        .ENDW

        ret
insert_sort ENDP


create_label PROC PASCAL USES es ds si di bx cx dx,val:WORD
        LOCAL   l_off:WORD,ctr:WORD

        INVOKE  memset,ADDR label_buff_num,'0',4
        INVOKE  itoa,ADDR itoa_buff1,val
        INVOKE  strlen,ADDR itoa_buff1
        mov     ctr,ax
        mov     l_off,4
        sub     l_off,ax
        mov     bx,l_off
        mov     si,OFFSET itoa_buff1
        .REPEAT
        mov     al, Byte Ptr ds:[si]
        mov     label_buff_num[bx],al
        inc     si
        inc     bx
        dec     ctr
        .UNTIL (ctr == 0)
        ret
create_label ENDP

print_comment PROC PASCAL
;        mov     ax,36
;        sub     ax,write_length
;        mov     temp_dw,ax
;        INVOKE  writeFile,ADDR buff_32,handle,temp_dw

        .IF (ascii_char == JMP_SHORT_COM)
        INVOKE  writeFile,ADDR buff_32,handle,2
        INVOKE  writeFile,ADDR jmp_msg_1,handle,LENGTHOF jmp_msg_1
        INVOKE  writeFile,ADDR crlf,handle,2
        INVOKE  writeFile,ADDR semi_c_dat,handle,2
        INVOKE  writeFile,ADDR dash_dat,handle,33
        INVOKE  writeFile,ADDR semi_c_dat,handle,1
        INVOKE  writeFile,ADDR crlf,handle,2
        mov     ascii_char,0
        .ENDIF

        .IF (ascii_char == CALL_DIRECT_COM)
        INVOKE  writeFile,ADDR buff_32,handle,2
        INVOKE  writeFile,ADDR call_msg_1,handle,LENGTHOF call_msg_1
        INVOKE  writeFile,ADDR crlf,handle,2
        mov     ascii_char,0
        .ENDIF

        .IF (com_opt == RET_COM)
        INVOKE  writeFile,ADDR buff_32,handle,2
        INVOKE  writeFile,ADDR ret_msg_1,handle,LENGTHOF ret_msg_1
        .ENDIF

; data byte comment


        .IF (ascii_char != 0)
        INVOKE  is_ascii,ascii_char
        .IF (al != 0)
        INVOKE  writeFile,ADDR buff_32,handle,2
        INVOKE  writeFile,ADDR apost_dat,handle,1
        INVOKE  writeFile,ADDR ascii_char,handle,1
        INVOKE  writeFile,ADDR apost_dat,handle,1
        mov     ascii_char,0
        .ENDIF
        .ENDIF

; interrupt services comment
        .IF (int_char != 0)
        INVOKE  writeFile,ADDR buff_32,handle,2

        .IF (int_char == 21h)
        INVOKE  writeFile,ADDR int_msg_21,handle,LENGTHOF int_msg_21
        .ELSEIF (int_char == 10h)
        INVOKE  writeFile,ADDR int_msg_10,handle,LENGTHOF int_msg_10
        .ELSEIF (int_char == 16h)
        INVOKE  writeFile,ADDR int_msg_21,handle,LENGTHOF int_msg_16
        .ELSE
        INVOKE  writeFile,ADDR int_chk_ref,handle,LENGTHOF int_chk_ref
        .ENDIF
        INVOKE  writeFile,ADDR crlf,handle,2
         mov     int_char,0
        .ENDIF

        ret
print_comment ENDP

s_search PROC PASCAL USES bx,val:WORD
        LOCAL   index:WORD
        mov     index,0
        mov     bx,0
        .REPEAT
        mov     ax,label_array[bx]
        sub     ah,ah
        cmp     val,ax
        je      se_done
        inc     bx
        inc     bx
        inc     index
        mov     ax,index
        .UNTIL(ax == label_total)
se_done:
        mov     ax,index
        ret

s_search ENDP

get_short_offset PROC
        sub     ah,ah
        mov     al,Byte Ptr es:[si]
        .IF (al < 128)
        add     al,2
        add     ax,off_counter
        dec     ax
        .ELSE
        neg     al
        sub     al,2
        push    off_counter
        pop     temp_dw
        sub     temp_dw,ax
        mov     ax,temp_dw
        dec     ax
        .ENDIF
        INVOKE  s_search,ax
        mov     temp_dw,ax
        INVOKE  create_label,temp_dw
        INVOKE  writeFile,ADDR label_buff,handle,5
        inc     off_counter
        inc     holdsi
        ret
get_short_offset ENDP

get_16bit_offset PROC
        mov     ax,Word Ptr es:[si]
        .IF (ax < 32767)
        add     ax,2
        add     ax,off_counter
        .ELSE
        neg     ax
        sub     ax,2
        push    off_counter
        pop     temp_dw
        sub     temp_dw,ax
        mov     ax,temp_dw
        .ENDIF
        INVOKE  s_search,ax
        mov     temp_dw,ax
        INVOKE  create_label,temp_dw
        INVOKE  writeFile,ADDR label_buff,handle,5
        inc     off_counter
        inc     off_counter
        inc     holdsi
        inc     holdsi
        ret
get_16bit_offset ENDP

; End of ASSEMBLY source file

    END

;
; End of discom.asm
;
;--------------------------------------
