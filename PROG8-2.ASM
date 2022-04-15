;------------------------------------------------+
; prog8-2.asm                                    |
;                                                |
;                                                |
; Pop up character set                           |
;                                                |
; Link Line:                                     |
;                                                |
; ml prog8-2.asm install.obj handlers.obj        |
;                                                |
; Where:                                         |
; ------                                         |
; prog8-2.asm:  installs TSR                     |
;               sets hot key                     |
;               Hot Key routine code             |
;                                                |
; install.obj:  Supplied with MSC 6.0            |
;                                                |
; handlers.obj: Supplie with MSC 6.0             |
;                                                |
;------------------------------------------------+

        .Model  Small, Pascal
        .Seq

;---------------------------------------+
;  include definition inc files         |
;---------------------------------------+


        INCLUDE demo.inc
        INCLUDE tsr.inc
        INCLUDE scan.inc

;---------------------------------------+
;  Beginning of Code segment            |
;---------------------------------------+

        .Code


;---------------------------------------+
;  Beginning of Data segment            |
;---------------------------------------+

        .Data

;---------------------------------------+
;  Beginning of INSTALLData and         |
;  INSTALLCode segments                 |
;---------------------------------------+

INSTALLData SEGMENT Word PUBLIC 'I_Data'
INSTALLData ENDS

INSTALLCode SEGMENT PARA PUBLIC 'I_Code'
INSTALLCode ENDS

;---------------------------------------+
; set stack to default                  |
;---------------------------------------+

        .Stack

        .Data

DEFAULT_COLR    EQU     1Eh             ; Default = white on blue (color)
DEFAULT_MONO    EQU     70h             ; Default = reverse video (mono)

;---------------------------------------+
; Set ALT+LEFT SHIFT+S as hot key       |
; combination.                          |
;---------------------------------------+

HOT_SCAN        EQU     SCAN_K_5        ; Hot key scan code (5)
HOT_SHIFT       EQU     shAlt OR shLeft ; Shift value (ALT+LEFT SHIFT)
HOT_MASK        EQU     (shIns OR shCaps OR shNum OR shScroll) XOR 0FFh

counter Word    ?                       ; loop counter
save_es Word    ?                       ; stores es register
save_di Word    ?                       ; stores di register
save_si Word    ?                       ; stores si register
page_n  Byte    ?                       ; stores video page
hold_cx Word    ?                       ; stores cx register
hold_dx Word    ?                       ; stores dx register
vid_seg Word    ?                       ; stores video seg address
InstallVidMode Byte    DEFAULT_MONO     ; Assume monochrome
Buffer  Byte    ((80 * 25) * 2) DUP(?)  ; buffer to save screen info

;---------------------------------------+
; character set screen data             |
;---------------------------------------+

c_scrn  Byte    ' 00 ',0,'  25 ',25,'  50 ',50,'  75 ',75  ;** row 1
        Byte    '  100 ',100,'  125 ',125,'  150 ',150,'  175 ',175
        Byte    '  200 ',200,'  225 ',225,'  250 ',250,'        '

        Byte    ' 01 ',1,'  26 ',26,'  51 ',51,'  76 ',76  ;** row 2
        Byte    '  101 ',101,'  126 ',126,'  151 ',151,'  176 ',176
        Byte    '  201 ',201,'  226 ',226,'  251 ',251,'        '

        Byte    ' 02 ',2,'  27 ',27,'  52 ',52,'  77 ',77  ;** row 3
        Byte    '  102 ',102,'  127 ',127,'  152 ',152,'  177 ',177
        Byte    '  202 ',202,'  227 ',227,'  252 ',252,'        '

        Byte    ' 03 ',3,'  28 ',28,'  53 ',53,'  78 ',78  ;** row 4
        Byte    '  103 ',103,'  128 ',128,'  153 ',153,'  178 ',178
        Byte    '  203 ',203,'  228 ',229,'  253 ',253,'        '

        Byte    ' 04 ',4,'  29 ',29,'  54 ',54,'  79 ',79  ;** row 5
        Byte    '  104 ',104,'  129 ',129,'  154 ',154,'  179 ',179
        Byte    '  204 ',204,'  229 ',229,'  254 ',254,'        '

        Byte    ' 05 ',5,'  30 ',30,'  55 ',55,'  80 ',80  ;** row 6
        Byte    '  105 ',105,'  130 ',130,'  155 ',155,'  180 ',180
        Byte    '  205 ',205,'  230 ',230,'  255 ',255,'        '

        Byte    ' 06 ',6,'  31 ',31,'  56 ',56,'  81 ',81  ;** row 7
        Byte    '  106 ',106,'  131 ',131,'  156 ',156,'  181 ',181
        Byte    '  206 ',206,'  231 ',231,'               '

        Byte    ' 07 ',7,'  32 ',32,'  57 ',57,'  82 ',82  ;** row 8
        Byte    '  107 ',107,'  132 ',132,'  157 ',157,'  182 ',182
        Byte    '  207 ',207,'  232 ',232,'               '

        Byte    ' 08 ',8,'  33 ',33,'  58 ',58,'  83 ',83  ;** row 9
        Byte    '  108 ',108,'  133 ',133,'  158 ',158,'  183 ',183
        Byte    '  208 ',208,'  233 ',233,'               '

        Byte    ' 09 ',9,'  34 ',34,'  59 ',59,'  84 ',84  ;** row 10
        Byte    '  109 ',109,'  134 ',134,'  159 ',159,'  184 ',184
        Byte    '  209 ',209,'  234 ',234,'               '

        Byte    ' 10 ',10,'  35 ',35,'  60 ',60,'  85 ',85  ;** row 11
        Byte    '  110 ',110,'  135 ',135,'  160 ',160,'  185 ',185
        Byte    '  210 ',210,'  235 ',235,'               '

        Byte    ' 11 ',11,'  36 ',36,'  61 ',61,'  86 ',86  ;** row 12
        Byte    '  111 ',111,'  136 ',136,'  161 ',161,'  186 ',186
        Byte    '  211 ',211,'  236 ',236,'               '

        Byte    ' 12 ',12,'  37 ',37,'  62 ',62,'  87 ',87  ;** row 13
        Byte    '  112 ',112,'  137 ',137,'  162 ',162,'  187 ',187
        Byte    '  212 ',212,'  237 ',237,'               '

        Byte    ' 13 ',13,'  38 ',38,'  63 ',63,'  88 ',88  ;** row 14
        Byte    '  113 ',113,'  138 ',138,'  163 ',163,'  188 ',188
        Byte    '  213 ',213,'  238 ',238,'               '

        Byte    ' 14 ',14,'  39 ',39,'  64 ',64,'  89 ',89  ;** row 15
        Byte    '  114 ',114,'  139 ',139,'  164 ',164,'  189 ',189
        Byte    '  214 ',214,'  239 ',239,'               '

        Byte    ' 15 ',15,'  40 ',40,'  65 ',65,'  90 ',90  ;** row 16
        Byte    '  115 ',115,'  140 ',140,'  165 ',165,'  190 ',190
        Byte    '  215 ',215,'  240 ',240,'               '

        Byte    ' 16 ',16,'  41 ',41,'  66 ',66,'  91 ',91  ;** row 17
        Byte    '  116 ',116,'  141 ',141,'  166 ',166,'  191 ',191
        Byte    '  216 ',216,'  241 ',241,'               '

        Byte    ' 17 ',18,'  42 ',42,'  67 ',67,'  92 ',92  ;** row 18
        Byte    '  117 ',117,'  142 ',142,'  167 ',167,'  192 ',192
        Byte    '  217 ',217,'  242 ',242,'               '

        Byte    ' 18 ',18,'  43 ',43,'  68 ',68,'  93 ',93  ;** row 19
        Byte    '  118 ',118,'  143 ',143,'  168 ',168,'  193 ',193
        Byte    '  218 ',218,'  243 ',243,'               '

        Byte    ' 19 ',19,'  44 ',44,'  69 ',69,'  94 ',94  ;** row 20
        Byte    '  119 ',119,'  144 ',144,'  169 ',169,'  194 ',194
        Byte    '  219 ',219,'  244 ',244,'               '

        Byte    ' 20 ',20,'  45 ',45,'  70 ',70,'  95 ',95  ;** row 21
        Byte    '  120 ',120,'  145 ',145,'  170 ',170,'  195 ',195
        Byte    '  220 ',220,'  245 ',245,'               '

        Byte    ' 21 ',21,'  46 ',46,'  71 ',71,'  96 ',96  ;** row 22
        Byte    '  121 ',121,'  146 ',146,'  171 ',171,'  196 ',196
        Byte    '  221 ',221,'  246 ',246,'               '

        Byte    ' 22 ',22,'  47 ',47,'  72 ',72,'  97 ',97  ;** row 23
        Byte    '  122 ',122,'  147 ',147,'  172 ',172,'  197 ',197
        Byte    '  222 ',222,'  237 ',247,'               '

        Byte    ' 23 ',23,'  48 ',48,'  73 ',73,'  98 ',98  ;** row 24
        Byte    '  123 ',123,'  148 ',148,'  173 ',173,'  198 ',198
        Byte    '  223 ',223,'  248 ',248,'               '

        Byte    ' 24 ',24,'  49 ',49,'  74 ',74,'  99 ',99  ;** row 25
        Byte    '  124 ',124,'  149 ',149,'  174 ',174,'  199 ',199
        Byte    '  224 ',224,'  249 ',249,'               '


;---------------------------------------+
; Hot Key routine code segment          |
;---------------------------------------+

        .Code


;---------------------------------------+
; HotKeyRoutine                         |
;                                       |
; When Hot Key is pressed the           |
; HotKeyRoutine is Invoked              |
;                                       |
; Segments on Call: DS = @data          |
;                   ES = @data          |
;                                       |
; Returns:          Nothing             |
;                                       |
;---------------------------------------+

HotKeyRoutine    PROC    FAR

;---------------------------------------+
; save registers to memory              |
;---------------------------------------+

        mov     save_es,es
        mov     save_di,di
        mov     save_si,si

;---------------------------------------+
; set video segment: 0b800h color       |
;                    0b000h mono        |
;---------------------------------------+

        mov     ah,15
        int     10h
        .IF (al == 7)
        mov     vid_seg,0b000h
        .ELSE
        mov     vid_seg,0b800h
        .ENDIF

;---------------------------------------+
; save cursor configuration             |
;---------------------------------------+

        mov     ah,3
        mov     bh,0
        int     10h
        mov     hold_dx,dx
        mov     hold_cx,cx

;---------------------------------------+
; turn the cursor off                   |
;---------------------------------------+

        or      ch,20h
        mov     ah,1
        int     10h

;---------------------------------------+
; save page information                 |
;---------------------------------------+

        mov     ah,15
        int     10h
        mov     page_n,bh

;---------------------------------------+
; set to page 0                         |
;---------------------------------------+

        mov     ah,5
        mov     al,0
        int     10h

;---------------------------------------+
; save page 0 screen to buffer          |
;---------------------------------------+

        mov     es,vid_seg
        mov     di,Offset Buffer
        mov     si,0
        mov     counter,4000
        .REPEAT
        mov     al,Byte Ptr es:[si]
        mov     Byte Ptr ds:[di],al
        inc     di
        inc     si
        dec     counter
        .UNTIL (counter == 0)

;---------------------------------------+
; print the character set to page       |
; 0b800h if color and 0b000 if mono     |
;---------------------------------------+

        mov     di,Offset c_scrn
        mov     es,vid_seg ;ax
        mov     si,0
        mov     counter,(80 * 25)
        .REPEAT
        mov     ah,7
        mov     al,Byte Ptr ds:[di]
        inc     di
        mov     Word Ptr es:[si],ax
        inc     si
        inc     si
        dec     counter
        .UNTIL (counter == 0)

;---------------------------------------+
; wait for key press                    |
;---------------------------------------+

        mov     ax,0
        int     16h

;---------------------------------------+
; restore page 0 screen to buffer       |
;---------------------------------------+

        mov     es,vid_seg ;ax
        mov     di,Offset Buffer
        mov     si,0
        mov     counter,4000
        .REPEAT
        mov     al,Byte Ptr ds:[di]
        mov     Byte Ptr es:[si],al
        inc     di
        inc     si
        dec     counter
        .UNTIL (counter == 0)

;---------------------------------------+
; restore cursor shape                  |
;---------------------------------------+

        mov     cx,hold_cx
        mov     ah,1
        mov     bh,0
        int     10h

;---------------------------------------+
; restore cursor lcoation               |
;---------------------------------------+

        mov     dx,hold_dx
        mov     ah,2
        mov     bh,0
        int     10h

;---------------------------------------+
; return to previous page               |
;---------------------------------------+

        mov     ah,5
        mov     al,page_n
        int     10h
        
;---------------------------------------+
; restore registers from memory         |
;---------------------------------------+

        mov     es,save_es
        mov     di,save_di
        mov     si,save_si

;---------------------------------------+
; release TSR's control to previously   |
; executing program                     |
;---------------------------------------+

        retf

HotKeyRoutine    ENDP

;
;----------------------------------------


;---------------------------------------+
; INSTALLATION SECTION                  |
;                                       |
; This is the TSR installation code     |
; which is provided by MASM 6.0.        |
;                                       |
; The memory holding this code is       |
; released after the TSR is installed   |
; for use by other DOS programs.        |
;---------------------------------------+
       
DGROUP  GROUP INSTALLCode, INSTALLData
INSTALLData SEGMENT Word PUBLIC 'I_Data'

;------------------------------------------------------------------+
; You should change the TSR_ID         ;                           |
; string for each TSR program which    ;                           |
; you create with whic shell           ;                           |
                                       ;                           |
                                       ;                           |                                                                   
TSR_ID   Byte    'PROG8-2 TSR', 0      ; TSR Identification string |
                                       ;                           |
;------------------------------------------------------------------+

;---------------------------------------+
; Check the MASM 6.0 TSR Demonstration  |
; programs for the comments for this    |
; section of the code.                  |
;---------------------------------------+
 
INSTALLData ENDS
INSTALLCode SEGMENT PARA PUBLIC 'I_Code'
        ASSUME  ds:@data
Begin   PROC    NEAR
        mov     ax, DGROUP
        mov     ds, ax                  
        mov     ah, 15
        int     10h                     
        .IF     al != 7                 
        .ENDIF
        INVOKE  InitTsr,                
                es,                     
                ADDR TSR_ID,            
                ADDR InstallVidMode     
                                        
        .IF     ax == WRONG_DOS         
        jmp     exit                    
        .ENDIF
        mov     al, 'd'                 
        call    GetOptions              
        cmp     ax, NO_ARGUMENT         
        je      installtsr              
        cmp     ax, OK_ARGUMENT         
        je      deinstalltsr            
        mov     al, 'c'                 
        call    GetOptions              
        cmp     ax, BAD_ARGUMENT        
        je      exit                    
        mov     ax, es:[di+1]           
        mov     cx, 2                   
        .REPEAT
        sub     al, '0'                 
        .IF     (al > 9)                
        and     al, 00011111y           
        sub     al, 7                   
        .ENDIF
        xchg    ah, al                  
        .UNTILCXZ
        mov     cl, 4
        shl     al, cl                  
        or      al, ah                  
        push    ax                      

        mov     al, 2                   
        call    CallMultiplex           
        .IF     ax != IS_INSTALLED      
        pop     ax                      
        mov     ax, CANT_ACCESS         
        jmp     exit
        .ELSE                           
        pop     ax                      
        mov     es:[di], al             
        mov     ax, OK_ACCESS           
        jmp     exit
        .ENDIF
installtsr:
        push    es                      

        mov     ax, @code
        mov     es, ax
        mov     bx, OFFSET HotKeyRoutine
        INVOKE  Install,                
                HOT_SCAN,               
                HOT_SHIFT,              
                HOT_MASK,               
                es::bx                  
        pop     bx                      
        or      ax, ax                  
        jnz     exit                    
        mov     ax, INSTALLCode         
        sub     ax, bx                  
        INVOKE  KeepTsr,                
                ax                      
deinstalltsr:
        INVOKE  Deinstall               
        .IF     ax > OK_ARGUMENT        
        INVOKE  FreeTsr,                
                ax                      
        .ENDIF                          
exit:
        INVOKE  FatalError,             
                ax                      
Begin   ENDP
INSTALLCode ENDS
        END     Begin

;------------------------------------------------+
; End of TSR program                             |
;------------------------------------------------+
