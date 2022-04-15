;--------------------------------------
;
; initw.asm 
;
; initialize window structure
;  
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
; initWind(ur,uc,lr,lc,attr,style)
;

initWind PROC PASCAL USES DS BX,wptr:Ptr WINDOW, attr:Byte
        LOCAL   amount:Word
        LOCAL   ur:Byte,uc:Byte,lr:Byte,lc:Byte
        LOCAL   w_width:Byte,w_height:Byte
        LOCAL   len:Byte

;
; relocate Window structure data to locals
   IF mdl eq 1
        mov     bx,wptr
   ELSE
        lds     bx,wptr
   ENDIF
        mov     al,(WINDOW Ptr [bx]).ur   ; save upper row
        mov     ur,al
        mov     al,(WINDOW Ptr [bx]).uc   ; save upper col
        mov     uc,al
        mov     al,(WINDOW Ptr [bx]).lr   ; save lower row
        mov     lr,al
        mov     al,(WINDOW Ptr [bx]).lc   ; save lower column
        mov     lc,al
        mov     al,attr                   ; store attribute
        mov     (WINDOW Ptr [bx]).attr,al ; save lower column
        

;
; calculate window row and column height
        mov     al,lr
        mov     dl,ur
        sub     al,dl
        mov     w_height,al
        mov     al,lc
        mov     dl,uc
        sub     al,dl
        mov     w_width,al

;
; calculate title center offset
; (width-title_length)/2

        INVOKE  strlen,ADDR (WINDOW Ptr [bx]).w_name
        mov     dl,al
        mov     al,w_width
        sub     al,dl
        shr     al,1
        mov     (WINDOW Ptr [bx]).center,al

;
; calculate amount of memory to allocate for window
        xor     ax,ax
        xor     dx,dx
        mov     al,w_height
        inc     al
        mov     dl,w_width
        inc     dl
        mul     dl
        shl     ax,1
        mov     amount,ax 
        INVOKE  malloc,amount
   .IF (ax == -8)
        INVOKE  error_abort,MALLOC_ERROR
   .ENDIF       
        mov     (WINDOW Ptr [bx]).s_img,ax
        INVOKE  malloc,amount
   .IF (ax == -8)
        INVOKE  error_abort,MALLOC_ERROR
   .ENDIF       
        mov     (WINDOW Ptr [bx]).w_img,ax
        ret
initWind ENDP

;
; End of source file

        END

;
;--------------------------------------
 
