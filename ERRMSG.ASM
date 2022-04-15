;--------------------------------------
;
; errmsg.asm
;
; Window Demonstration Program
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
; Declare data segment
;

	.DATA
        
emsg0   db      10,13
        db      '************************************',10,13
        db      '**                                **',10,13
        db      '**    MALLOC Procedure Failed     **',10,13
        db      '**   Memory Allocation Error 8    **',10,13
        db      '** DOS Interrupt 21h Function 48h **',10,13
        db      '**                                **',10,13
        db      '************************************',10,13
        db      10,13,'$'

emsg1   db      10,13
        db      '************************************',10,13
        db      '**                                **',10,13
        db      '**     FREE Procedure Failed      **',10,13
        db      '**   Memory Allocation Error 8    **',10,13
        db      '** DOS Interrupt 21h Function 49h **',10,13
        db      '**                                **',10,13
        db      '************************************',10,13
        db      10,13,'$'
 
;--------------------------------------
;
; Declare Code segment
;

        .CODE

;--------------------------------------
;
; error_abort procedure
;
; Prints error message and returns to
; DOS via Function 4Ch
;

error_abort PROC PASCAL PUBLIC,num:Word
	INVOKE	onCur
        .IF (num == 0)
IF mdl eq 1
        mov     dx,Offset emsg0
ELSE
        mov     dx,Offset emsg0
        mov     ax,Seg emsg0
        mov     ds,ax
ENDIF
        .ELSEIF (num == 1)
IF mdl eq 1
        mov     dx,Offset emsg0
ELSE
        mov     dx,Offset emsg0
        mov     ax,Seg emsg0
        mov     ds,ax
ENDIF
        .ENDIF
        mov     ah,09h
        int     21h
        mov     ah,4ch
        int     21h
error_abort ENDP

;
; End of source file

        END

;
;--------------------------------------
 
