;--------------------------------------
;
; dispw.asm 
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
;
; displayWind ( WINDOW *wptr)
;

displayWind PROC PASCAL USES ES DI DS BX,wptr:Ptr Window
        LOCAL   amount:Word
        LOCAL   ur:Byte,uc:Byte,lr:Byte,lc:Byte
        LOCAL   attr:Byte,style:Byte
        LOCAL   c_ctr:Byte,r_ctr:Byte
        LOCAL   c_temp:Byte

;
; relocate Window structure data to locals
   IF mdl eq 1
        mov     bx,wptr
   ELSE
        lds     bx,wptr
   ENDIF
        push    bx
        mov     al,(WINDOW Ptr [bx]).ur ; relocate upper row
        mov     ur,al
        mov     al,(WINDOW Ptr [bx]).uc ; relocate upper col
        mov     uc,al
        mov     al,(WINDOW Ptr [bx]).lr ; relocate lower row
        mov     lr,al
        mov     al,(WINDOW Ptr [bx]).lc ; relocate lower column
        mov     lc,al
        mov     al,(WINDOW Ptr [bx]).lc ; relocate lower column
        mov     lc,al
        mov     al,(WINDOW Ptr [bx]).attr ; 
        mov     attr,al
        mov     al,(WINDOW Ptr [bx]).style ; 
        mov     style,al
;
; save the underneath screen image
        mov     ax,(WINDOW Ptr [bx]).s_img ; 
        mov     es,ax                     ;
        xor     di,di                     ;
        mov     al,ur                     ; set row start
        mov     r_ctr,al                  ; variable
        .REPEAT                           ; save by row loop
        mov     al,uc                     ; set column start
        mov     c_ctr,al                  ; variable
        .REPEAT                           ; save byt column loop

        INVOKE  vrdChar,r_ctr,c_ctr       ; read screen token
        mov     Word Ptr es:[di],ax
        inc     di
        inc     di
        INVOKE  vdChar,r_ctr,c_ctr,' ',attr
        mov     al,c_ctr                  ; xfer to al for UNTIL
        inc     c_ctr                     ; increment column counter
        .UNTIL (al == lc)              ; column loop done?

        inc     r_ctr                     ; increment row counter
        mov     al,r_ctr                  ; xfer to al for UNTIL
        .UNTIL (al > lr)               ; repeat until last row saved

        INVOKE  vdBox,ur,uc,lr,lc,attr,style
        pop     bx

        mov     al,(WINDOW Ptr [bx]).t_spot ; 

        .IF ( al == TTL )
        mov     al,uc
        inc     al
        mov     c_temp,al
        INVOKE  vdWrite,ur,c_temp,0,ADDR (WINDOW Ptr [bx]).w_name,attr
        .ELSEIF ( al == TBL )
        mov     al,uc
        inc     al
        mov     c_temp,al
        INVOKE  vdWrite,lr,c_temp,0,ADDR (WINDOW Ptr [bx]).w_name,attr
        .ELSEIF ( al == TTC )
        mov     al,(WINDOW Ptr [bx]).center
        add     al,uc
        mov     c_temp,al
        INVOKE  vdWrite,ur,c_temp,0,ADDR (WINDOW Ptr [bx]).w_name,attr
        .ELSEIF ( al == TBC )
        mov     al,(WINDOW Ptr [bx]).center
        add     al,uc
        mov     c_temp,al
        INVOKE  vdWrite,lr,c_temp,0,ADDR (WINDOW Ptr [bx]).w_name,attr
        .ENDIF

        ret
displayWind ENDP


;
; End of source file

        END

;
;--------------------------------------
 
