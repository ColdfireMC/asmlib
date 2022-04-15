;--------------------------------------
;
; dispmb.asm 
;
; 1) Display menu bar
;

;--------------------------------------
;
; include all defines, macros, 
; prototypes and set up memory model
;

include tab6.inc

;--------------------------------------
;
; Declare Code segment
;

        .CODE

;--------------------------------------
; displayMB mbptr:Ptr MBP,miptr:Ptr M_ITEM
;

displayMB PROC PASCAL PUBLIC USES DS ES BX DI SI,mbptr:Ptr MENU_BAR,miptr:Ptr M_ITEM
        LOCAL   counter:Byte,c_dup:Byte
        LOCAL   old_item:Byte
        LOCAL   ctr:Byte
        LOCAL   holddi:Word
        LOCAL   k_off:Byte


;
; relocate Window structure data to locals
   IF mdl eq 1
        mov     bx,mbptr
   ELSE
        lds     bx,mbptr
   ENDIF

;
; write top row to the screen

        mov     dl,(MBP [bx]).attr
        INVOKE  vdHrep,0,0,80,' ',dl

;
; set es:[di] to point to M_ITEM structure
   IF mdl eq 1
        push    ds
        pop     es
        mov     di,miptr
   ELSE
        les     di,miptr
   ENDIF

;
; write menu items to the menubar

        mov     al,(MBP [bx]).inum
        mov     counter,al
        mov     c_dup,al
        mov     ctr,1

        mov     holddi,di

        .REPEAT
        
        INVOKE  vdWrite,0,(MIP es:[di]).i_off,0,ADDR (MIP es:[di]).i_name,(MBP [bx]).attr
        mov    al,(MIP es:[di]).k_off
        add    al,(MIP es:[di]).i_off
        mov    k_off,al
        INVOKE vdAttr,0,k_off,1,(MBP [bx]).k_attr
        add    di,LM_ITEM
        inc    ctr
        dec    counter
        mov    al,counter
        .UNTIL ( al == 0 )

;
; key menu item select loop


main_key_loop:


;
; set es:[di] to point to M_ITEM structure
   IF mdl eq 1
        push    ds
        pop     es
        mov     di,miptr
   ELSE
        les     di,miptr
   ENDIF

        mov     ctr,1        ; menu item to first row

        mov     al,(MBP [bx]).inum
        mov     counter,al
        mov     ctr,1

no_event:
        INVOKE  kbStat           ; get key stroke
        .IF ( ax == 0 )          ; no key
        jmp     no_event
        .ENDIF

;--------------------
; process key stroke

        .REPEAT

        mov     dx,(MIP es:[di]).k_code
        add     di,LM_ITEM

        .IF (ax == dx)
        xor     ax,ax
        mov     al,ctr
        jmp     all_done
        .ENDIF

        inc     ctr
        dec     counter
        .UNTIL ( counter == 0 )

bar_move:
        jmp     main_key_loop

all_done:
        ret
displayMB ENDP

;
; End of source file

        END

;
;--------------------------------------
 
