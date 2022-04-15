; ---------------------------------;
;
; HACK24.ASM
;

        .MODEL TINY

        .CODE

        ORG 100h

start:
        jmp    L0004               ; 0100  Jump Short (+ or - 128 bytes)
; ---------------------------------;

        nop                        ; 0102  Return from subroutine
        db     000h                    ; 0103  Return from subroutine
        sti                        ; 0104  Return from subroutine
        db     '.'
        db     080h                    ; 0106  Return from subroutine
        db     '>'
        db     003h                    ; 0108  Return from subroutine
        db     001h                    ; 0109  Return from subroutine
        db     003h                    ; 010A  Return from subroutine
        jc     L0000               ; 010B
        mov    al,003h             ; 010D
        iret                       ; 010F  Return from subroutine

L0000:  ;--------------------------;
        mov    al,000h             ; 0110
        iret                       ; 0112  Return from subroutine
        db     0EAh                    ; 0113  Return from subroutine
        db     004h                    ; 0114  Return from subroutine
        db     001h                    ; 0115  Return from subroutine
        db     000h                    ; 0116  Return from subroutine
        db     000h                    ; 0117  Return from subroutine
        db     00Ah                    ; 0118  Return from subroutine
        db     00Dh                    ; 0119  Return from subroutine
        db     'Critical Error now Selects New Drive ...>  '
        db     00Ah                    ; 0145  Return from subroutine
        db     00Dh                    ; 0146  Return from subroutine
        db     00Dh                    ; 0147  Return from subroutine
        db     00Ah                    ; 0148  Return from subroutine

L0001:  ;--------------------------;
        db     '$'               ; 0149
        db     'Hack24 requires DOS 2.0 or later'
        db     00Dh               ; 016A
        db     00Ah               ; 016B
        db     '$'               ; 016C

L0004:  ;--------------------------;
        mov    ah,030h             ; 016D
        int    021h                ; 016F  DOS Services Interrupt

        mov    cs:00103h,al                ; 0171
        cmp    al,02h                ; 0174  Check DOS Reference

        jae    L0007               ; 0176

L0005:  ;--------------------------;
        mov    dx,0014Ah           ; 0178
        mov    ah,009h             ; 017B
        int    021h                ; 017D  DOS Services Interrupt

        mov    al,001h             ; 017F
        mov    ah,04Ch             ; 0181
        int    021h                ; 0183  DOS Services Interrupt


L0007:  ;--------------------------;
        mov    dx,00118h           ; 0185

L0009:  ;--------------------------;
        mov    ah,009h             ; 0188
        int    021h                ; 018A  DOS Services Interrupt

        mov    ax,cs                ; 018C
        mov    cs:00116h,ax                ; 018E
        mov    si,00113h           ; 0191
        les    di,cs:00012h           ; 0194

L0010:  ;--------------------------;
        mov    cx,00005h           ; 0198
        cld                        ; 019B  Return from subroutine
        cli                        ; 019C  Return from subroutine
        rep    movsb                    ; 019D  Return from subroutine
        sti                        ; 019F  Return from subroutine
        mov    ax,00113h           ; 01A0

L0011:  ;--------------------------;
        add    ax,0000Fh           ; 01A3
        shr    ax,1           ; 01A6
        shr    ax,1           ; 01A8
        shr    ax,1           ; 01AA
        shr    ax,1           ; 01AC
        mov    dx,ax
        mov    ah,031h             ; 01B0
        mov    al,000h             ; 01B2
        int    021h                ; 01B4  DOS Services Interrupt

; ---------------------------------;

        END start

; ---------------------------------;