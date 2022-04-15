; ---------------------------------;
;
; TEST.ASM
;

        .MODEL TINY

        .CODE

        ORG 100h

start:
        jmp    L0000               ; 0100  Jump Short (+ or - 128 bytes)
; ---------------------------------;

        db     'Hello Chuck!$'               ; 0102
        db     'Hello Baxter!'
        db     000h               ; 011C
        db     'Hello Friskie!'

L0000:  ;--------------------------;
        mov    bh,007h             ; 012B
        call   L0008               ; 012D  Call Subroutine (direct)

        mov    dh,000h             ; 0130
        mov    dl,000h             ; 0132
        mov    bh,000h             ; 0134
        call   L0007               ; 0136  Call Subroutine (direct)

        mov    dx,00102h           ; 0139
        mov    ah,009h             ; 013C
        int    021h                ; 013E  DOS Services Interrupt

        mov    dh,001h             ; 0140
        mov    dl,000h             ; 0142
        mov    bh,000h             ; 0144
        call   L0007               ; 0146  Call Subroutine (direct)

        mov    si,0010Fh           ; 0149
        call   L0009               ; 014C  Call Subroutine (direct)

        mov    dh,002h             ; 014F
        mov    dl,000h             ; 0151
        mov    cx,0000Eh           ; 0153
        mov    bx,0011Dh           ; 0156
        call   L0012               ; 0159  Call Subroutine (direct)

        mov    dh,004h             ; 015C
        mov    dl,014h             ; 015E
        mov    bh,000h             ; 0160
        call   L0007               ; 0162  Call Subroutine (direct)

        mov    cx,00028h           ; 0165
        mov    al,0C4h             ; 0168
        mov    ah,00Ah             ; 016A
        int    010h                ; 016C  BIOS Video Services

        mov    dh,010h             ; 016E
        mov    dl,014h             ; 0170
        mov    bh,000h             ; 0172
        call   L0007               ; 0174  Call Subroutine (direct)

        mov    cx,00028h           ; 0177
        mov    al,0C4h             ; 017A
        mov    ah,00Ah             ; 017C
        int    010h                ; 017E  BIOS Video Services

        mov    cx,0000Ch           ; 0180
        mov    dh,004h             ; 0183
        mov    dl,014h             ; 0185
        call   L0013               ; 0187  Call Subroutine (direct)

        mov    cx,0000Ch           ; 018A

L0004:  ;--------------------------;
        mov    dh,004h             ; 018D

L0005:  ;--------------------------;
        mov    dl,03Ch             ; 018F
        call   L0013               ; 0191  Call Subroutine (direct)

        mov    ah,04Ch             ; 0194
        int    021h                ; 0196  DOS Services Interrupt


L0007:  ;--------------------------;
        mov    ah,002h             ; 0198
        int    010h                ; 019A  BIOS Video Services

        ret                        ; 019C  Return from subroutine

L0008:  ;--------------------------;
        mov    ah,006h             ; 019D
        mov    al,000h             ; 019F
        mov    cx,00000h           ; 01A1
        mov    dx,0184Fh           ; 01A4
        int    010h                ; 01A7  BIOS Video Services

        ret                        ; 01A9  Return from subroutine

L0009:  ;--------------------------;
        mov    ah,00Eh             ; 01AA
        mov    bh,000h             ; 01AC

L0010:  ;--------------------------;
        lodsb                      ; 01AE
        cmp    al,00h               ; 01AF
        je     L0011               ; 01B1
        int    010h                ; 01B3  BIOS Video Services

        jmp    L0010               ; 01B5  Jump Short (+ or - 128 bytes)
; ---------------------------------;


L0011:  ;--------------------------;
        ret                        ; 01B7  Return from subroutine

L0012:  ;--------------------------;
        push   bp
        mov    bp,bx
        mov    bh,000h             ; 01BB
        mov    bl,007h             ; 01BD
        mov    ah,013h             ; 01BF
        mov    al,001h             ; 01C1
        int    010h                ; 01C3  BIOS Video Services

        pop    bp
        ret                        ; 01C6  Return from subroutine

L0013:  ;--------------------------;
        push   cx
        mov    bh,000h             ; 01C8
        call   L0007               ; 01CA  Call Subroutine (direct)

        mov    ah,009h             ; 01CD
        mov    al,0B3h             ; 01CF
        mov    bl,007h             ; 01D1
        mov    cx,00001h           ; 01D3
        int    010h                ; 01D6  BIOS Video Services

        db     0FEh                ; 01D8
        db     0C6h                ; 01D9
        pop    cx
        db     0E2h                ; 01DB
        db     0EAh                ; 01DC
        ret                        ; 01DD  Return from subroutine
; ---------------------------------;

        END start

; ---------------------------------;