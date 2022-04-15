;--------------------------------------   
; charset.asm
;
;
; Display the character set TSR
;
;--------------------------------------

        .MODEL  small, pascal
        .SEQ
        INCLUDE demo.inc
        INCLUDE tsr.inc


        .CODE
        .DATA
INSTALLDATA SEGMENT WORD PUBLIC 'I_DATA'
INSTALLDATA ENDS

INSTALLCODE SEGMENT PARA PUBLIC 'I_CODE'
INSTALLCODE ENDS

        .STACK
        .DATA

DEFAULT_COLR    EQU     1Eh             ; Default = white on blue (color)
DEFAULT_MONO    EQU     70h             ; Default = reverse video (mono)

; Set ALT+LEFT SHIFT+S as hot key combination. To set multiple shift
; keys, OR the appropriate values together for the shift value (HOT_SHIFT).

HOT_SCAN        EQU     1Fh             ; Hot key scan code (S)
HOT_SHIFT       EQU     shAlt OR shLeft ; Shift value (ALT+LEFT SHIFT)
HOT_MASK        EQU     (shIns OR shCaps OR shNum OR shScroll) XOR 0FFh

OldPos  WORD    ?                       ; Original cursor position
Handle  WORD    ?                       ; File handle number

; Hold contains the screen text and attributes replaced by the query box.
; Buffer holds text captured from the screen, with room for 50 rows of 82
; characters, including carriage return/linefeed. To change Buffer's
; capacity, replace the dimensions with r * (c + 2) DUP(?), where r and
; c are row and column count respectively.

InstallVidMode BYTE    DEFAULT_MONO            ; Assume monochrome
Buffer  WORD     (80 * 25) DUP(?)


        .CODE

;* DisplayCharSet - Main procedure for resident program. Called from the Activate
;* procedure when TSR is invoked by the proper key combination.
;*
;* Params:  DS, ES = @data
;*
;* Return:  None

DisplayCharSet    PROC    FAR
        mov     ah,0eh
        mov     al,7
        mov     bh,0
        int     10h
        mov     ah,0eh
        mov     al,7
        mov     bh,0
        int     10h
        retf
DisplayCharSet    ENDP



@CurSeg ENDS

;------------------------------------------------
; INSTALLATION SECTION 
;
; The following code and data are used only 
; during the TSR's installation section. The
; memory for this code and data is freed after
; the TSR has been installed.
;
        
DGROUP  GROUP INSTALLCODE, INSTALLDATA

INSTALLDATA SEGMENT WORD PUBLIC 'I_DATA'

IDstr   BYTE    'CHARSET TSR', 0      ; Multiplex identifier string

INSTALLDATA ENDS

INSTALLCODE SEGMENT PARA PUBLIC 'I_CODE'
        ASSUME  ds:@data

Begin   PROC    NEAR

        mov     ax, DGROUP
        mov     ds, ax                  ; Initialize DS
        mov     ah, 15
        int     10h                     ; Get Video Mode
        .IF     al != 7                 ; If not default monochrome,
        .ENDIF

; Before calling any of the TSR procedures, initialize global data

        INVOKE  InitTsr,                ; Initialize data
                es,                     ; Segment of PSP
                ADDR IDstr,             ; Far address of multiplex ID string
                ADDR InstallVidMode            ; Far address of memory shared
                                        ;   with multiplex handler
        .IF     ax == WRONG_DOS         ; If DOS version less than 2.0,
        jmp     exit                    ;   exit with message
        .ENDIF

; This section gets the command-line argument to determine task:
;    No argument   = install
;    /D or -D      = deinstall
;    /Cx or -Cx    = change box-fill attribute to value x

        mov     al, 'd'                 ; Search command line for
        call    GetOptions              ;   /D or -D argument
        cmp     ax, NO_ARGUMENT         ; No argument?
        je      installtsr              ; If so, try to install
        cmp     ax, OK_ARGUMENT         ; /D argument found?
        je      deinstalltsr            ; If so, try to deinstall
        mov     al, 'c'                 ; Else search command line for
        call    GetOptions              ;   /C or -C argument
        cmp     ax, BAD_ARGUMENT        ; If neither /D or /C arguments,
        je      exit                    ;   quit with error message

; This section changes the fill attribute of SNAP's prompt box. It converts
; to binary the two-digit hex number following the /C argument, calls the
; multiplex handler to find the address of the attribute variable stored in
; shared memory, then resets the attribute to the new value. It does not
; verify that the value specified in the command line is a valid two-digit
; hex number.

        mov     ax, es:[di+1]           ; AH = low digit, AL = high digit
        mov     cx, 2                   ; Process two digits

        .REPEAT
        sub     al, '0'                 ; Convert digit to binary
        .IF     (al > 9)                ; If not digit 0-9,
        and     al, 00011111y           ;   mask out lower-case bit
        sub     al, 7                   ; Convert A to 10, B to 11, etc.
        .ENDIF
        xchg    ah, al                  ; Get next digit in AL
        .UNTILCXZ

        mov     cl, 4
        shl     al, cl                  ; Multiply high digit by 16
        or      al, ah                  ; AL = binary value of attribute
        push    ax                      ; Save new attribute

        mov     al, 2                   ; Request function 2
        call    CallMultiplex           ; Get shared memory addr in ES:DI
        .IF     ax != IS_INSTALLED      ; If TSR is not installed,
        pop     ax                      ;   clean stack and
        mov     ax, CANT_ACCESS         ;   quit with error message
        jmp     exit
        .ELSE                           ; If TSR is installed,
        pop     ax                      ;   recover new fill attribute in AL
        mov     es:[di], al             ; Write it to resident shared memory
        mov     ax, OK_ACCESS           ; Signal successful completion
        jmp     exit
        .ENDIF

; This section sets up the TSR's interrupt handlers and
; makes the program memory-resident

installtsr:
        push    es                      ; Preserve PSP address

        mov     ax, @code
        mov     es, ax
        mov     bx, OFFSET DisplayCharSet         ; ES:BX points to DisplayCharSet
        INVOKE  Install,                ; Install handlers
                HOT_SCAN,               ; Scan code of hot key
                HOT_SHIFT,              ; Bit value of hot key
                HOT_MASK,               ; Bit mask for shift hot key
                es::bx                  ; Far address of DisplayCharSet procedure

        pop     bx                      ; Recover PSP address
        or      ax, ax                  ; If nonzero return code,
        jnz     exit                    ;   exit with appropriate message
        mov     ax, INSTALLCODE         ; Bottom of resident section
        sub     ax, bx                  ; AX = number of paragraphs in
                                        ;   block to be made resident
        INVOKE  KeepTsr,                ; Make TSR memory-resident
                ax                      ; Resident paragraphs

; This section deinstalls the resident TSR from memory

deinstalltsr:

        INVOKE  Deinstall               ; Unchain interrupt handlers

        .IF     ax > OK_ARGUMENT        ; If successful,
        INVOKE  FreeTsr,                ;   deinstall TSR by freeing memory
                ax                      ; Address of resident seg
        .ENDIF                          ; Else exit with message
exit:
        INVOKE  FatalError,             ; Exit to DOS with message
                ax                      ; Error number

Begin   ENDP

INSTALLCODE ENDS

        END     Begin
