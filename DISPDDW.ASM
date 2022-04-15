;--------------------------------------
;
; dispddw.asm 
;
; 1) Save screen image under window
; 2) Display window, border and title
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
; displayDDW ddptr:Ptr DROP_DOWN,miptr:Ptr M_ITEM
;

displayDDW PROC PASCAL PUBLIC USES DS ES BX DI SI,ddptr:Ptr DROP_DOWN,miptr:Ptr M_ITEM
        LOCAL   counter:Byte,c_dup:Byte
        LOCAL   old_row:Byte
        LOCAL   ctr:Byte
        LOCAL   holddi:Word
        LOCAL   k_off:Byte

;
; set inverse bar row location variables

        mov     old_row,1

;
; relocate Window structure data to locals
   IF mdl eq 1
        mov     bx,ddptr
   ELSE
        lds     bx,ddptr
   ENDIF

        INVOKE  displayWind, ADDR (DDP [bx]).ddwind

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
; write menu items to the drop down window

        mov     al,(DDP [bx]).inum
        mov     counter,al
        mov     c_dup,al
        mov     ctr,1

        mov     holddi,di

        .REPEAT
        
        INVOKE  wvdWrite,ADDR (DDP [bx]).ddwind,ctr,2,0,ADDR (MIP es:[di]).i_name,(DDP [bx]).ddwind.attr
        mov     al,(MIP es:[di]).k_off
        mov     k_off,al
        INVOKE  wvdAttr,ADDR (DDP [bx]).ddwind,ctr,k_off,1,(DDP [bx]).k_attr
        add     di,LM_ITEM
        inc     ctr
        dec     counter
        mov     al,counter
        .UNTIL ( al == 0 )

;
; key menu item select loop

        INVOKE  wvdAttr,ADDR (DDP [bx]).ddwind,old_row,1,(DDP [bx]).i_len,(DDP [bx]).iattr

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

        mov     al,(DDP [bx]).inum
        mov     counter,al
        mov     ctr,1

no_event:
        INVOKE  kbStat           ; get key stroke
        .IF ( ax == 0 )          ; no key
        jmp     no_event
        .ENDIF


        .IF ( ax == DOWN_ARROW )
        INVOKE  wvdAttr,ADDR (DDP [bx]).ddwind,old_row,1,(DDP [bx]).i_len,(DDP [bx]).ddwind.attr
        xor     ax,ax
        xor     dx,dx
        mov     al,old_row
        dec     al
        mov     dl,LM_ITEM
        mul     dl
        add     di,ax
        mov     al,(MIP es:[di]).k_off
        mov     k_off,al
        INVOKE  wvdAttr,ADDR (DDP [bx]).ddwind,old_row,k_off,1,(DDP [bx]).k_attr
        mov     cl,c_dup
        .IF ( old_row == cl )
        mov     old_row,1
        .ELSE
        inc     old_row
        .ENDIF
        INVOKE  wvdAttr,ADDR (DDP [bx]).ddwind,old_row,1,(DDP [bx]).i_len,(DDP [bx]).iattr
        jmp     bar_move

        .ELSEIF ( ax == UP_ARROW )
        INVOKE  wvdAttr,ADDR (DDP [bx]).ddwind,old_row,1,(DDP [bx]).i_len,(DDP [bx]).ddwind.attr
        xor     ax,ax
        xor     dx,dx
        mov     al,old_row
        dec     al
        mov     dl,LM_ITEM
        mul     dl
        add     di,ax
        mov     al,(MIP es:[di]).k_off
        mov     k_off,al
        INVOKE  wvdAttr,ADDR (DDP [bx]).ddwind,old_row,k_off,1,(DDP [bx]).k_attr
        .IF ( old_row == 1)
        mov     cl,c_dup
        mov     old_row,cl
        .ELSE
        dec     old_row
        .ENDIF
        INVOKE  wvdAttr,ADDR (DDP [bx]).ddwind,old_row,1,(DDP [bx]).i_len,(DDP [bx]).iattr
        jmp     bar_move
       .ENDIF

        .IF ( ax == ENTERKEY )
        xor     ax,ax
        mov     al,old_row
        jmp     all_done
        .ENDIF

        .IF ( ax == ESCAPE )
        xor     ax,ax
        jmp     all_done
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
displayDDW ENDP

;
; End of source file

        END

;
;--------------------------------------
 
