;--------------------------------------
;
; ascii.inc
;

aNUL         EQU      0t         ;       null 0 delimeter
aSOH         EQU      1t         ;   ^A - start of heading
aSTX         EQU      2t         ;   ^B - start of text
aETX         EQU      3          ;   ^C - end of text
aEOT         EQU      4t         ;   ^D - end of transmission
aENQ         EQU      5t         ;   ^E - inquiry
aACK         EQU      6t         ;   ^F - affirm acknowledgement
aBEL         EQU      7t         ;   ^G - audible bell
aBS          EQU      8t         ;   ^H - backspace
aTAB         EQU      9t         ;   ^I - horizontal tab
aLF          EQU      10t        ;   ^J - line feed
aVT          EQU      11t        ;   ^K - vertical tab
aFF          EQU      12t        ;   ^L - form feed
aCR          EQU      13t        ;   ^M - carriage return
aSO          EQU      14t        ;   ^N - shift out
aSI          EQU      15t        ;   ^O - shift in
aDCE         EQU      16t        ;   ^P - data link escape
aDC1         EQU      17t        ;   ^Q - device control 1
aDC2         EQU      18t        ;   ^R - device control 2
aDC3         EQU      19t        ;   ^S - device control 3
aDC4         EQU      20t        ;   ^T - device control 4
aNAK         EQU      21t        ;   ^U - neg acknowledge 
aSYN         EQU      22t        ;   ^V - synchronous idle
aETB         EQU      23t        ;   ^W - end of transmission
aCAN         EQU      24t        ;   ^X - cancel
aEM          EQU      25t        ;   ^Y - end of medium
aSUB         EQU      26t        ;   ^Z - substitute
aESC         EQU      27t        ;        escape
aFS          EQU      28t        ;        file separator 
aGS          EQU      29t        ;        group separator 
aRS          EQU      30t        ;        record separator 
aUS          EQU      31t        ;        unlinked separator 
aSPC         EQU      32t        ;        space 
aCODE        EQU      94t        ; printer command follows // 
aHCR         EQU      000000004h ; Hard carriage return
aCENTER      EQU      000000043h ; code to center line
aDOUBLE      EQU      000000044h ; double strike toggle
aEXPAND      EQU      000000045h ; emphasize toggle
aSUPERS      EQU      000000053h ; superscript toggle
aITALIC      EQU      000000049h ; italics toggle
aBOLD        EQU      000000042h ; bold toggle
aTRUE        EQU      1t         ; true
aFALSE       EQU      0t         ; false
