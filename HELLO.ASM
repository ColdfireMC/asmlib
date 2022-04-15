; ---------------------------------;
;
; HELLO.ASM
;

        .MODEL TINY

        .CODE

        ORG 100h

start:
        jmp    L0000               ; 0100  Jump Short (+ or - 128 bytes)
; ---------------------------------;

        db     'Hello Chuck!$'               ; 0102

L0000:  ;--------------------------;
        mov    dx,00102h           ; 010F
        mov    ah,009h             ; 0112
        int    021h                ; 0114  DOS Services Interrupt

        mov    ah,04Ch             ; 0116
        int    021h                ; 0118  DOS Services Interrupt

; ---------------------------------;

        END start

; ---------------------------------;