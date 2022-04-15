;--------------------------------------
;
; clrscrn.asm
;
; clear the screen with attribute
;

;--------------------------------------
;
; include defs, prototypes and macros
;

include tab6.inc

;--------------------------------------
;
; begin code segment
;


      .Code

;--------------------------------------
;
; clrScrn(unsigned char attr)
;
; clears the screen via BIOS scroll
; function and allows attribute to be
; set
;

clrScrn PROC Pascal PUBLIC, s_attr:Byte
      mov      ah,SCROLL_WINDOW       ; scroll window function
      mov      al,CLEAR_WINDOW        ; used to clear window
      mov      bh,s_attr              ; with the designated attribute
      mov      ch,0                   ; window upper left row = 0
      mov      cl,0                   ; window upper left col = 0
      mov      dh,24                  ; window lower right row = 24
      mov      dl,79                  ; window lower right col = 79
      int      10h                    ; clear window via BIOS
      ret                             ; return to caller
clrScrn ENDP

;
; end of clrScrn procedure
;

      END
;
;--------------------------------------


