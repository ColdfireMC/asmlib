;--------------------------------------
;
; global6.asm
;
; public data for use in many routines
;

;--------------------------------------
;
; include all environment files

include tab6.inc

   .Data

scrn_seg          dw   ?
token_value       dw   ?
string_length     dw   ?
return_value      dw   ?
write_length      dw   ?
cursor_start      db   ?
cursor_end        db   ?
cursor_row        db   ?
cursor_column     db   ?
cursor_visible    db   1
char_value        db   ?
attribute_value   db   ?

   END

;
;--------------------------------------



