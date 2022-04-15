;
; hello.asm
;

        .MODEL TINY

        .CODE

        ORG 100h

start:
        jmp over_data

msg1    db      'Hello Chuck!','$'
loc_1:  jmp     loc_2
over_data:


        mov dx,OFFSET msg1
        mov ah,09h
        int 21h
        jmp     loc_1
loc_2:
        mov ah,4ch 
        int 21h

        END start



                                                      
