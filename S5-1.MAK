OBJECTS=prog5-1.obj errmsg.obj free.obj malloc.obj vdbox.obj initw.obj destw.obj dispw.obj remvw.obj
ASMFLAGS=/Zi /c /D mdl=1
LINKFLAGS=/Zi /D mdl=1
prog5-1.exe : $(OBJECTS)
 ml $(LINKFLAGS) prog5-1.obj /link /CP:32768 tab60.lib

prog5-1.obj : prog5-1.asm
   ml $(ASMFLAGS) prog5-1.asm

errmsg.obj : errmsg.asm
   ml $(ASMFLAGS) errmsg.asm
   lib tab60 -+errmsg;

free.obj : free.asm
   ml $(ASMFLAGS) free.asm
   lib tab60 -+free;

malloc.obj : malloc.asm
   ml $(ASMFLAGS) malloc.asm
   lib tab60 -+malloc;

vdbox.obj : vdbox.asm
   ml $(ASMFLAGS) vdbox.asm
   lib tab60 -+vdbox;

destw.obj : destw.asm
   ml $(ASMFLAGS) destw.asm
   lib tab60 -+destw;

initw.obj : initw.asm
   ml $(ASMFLAGS) initw.asm
   lib tab60 -+initw;

dispw.obj : dispw.asm
   ml $(ASMFLAGS) dispw.asm
   lib tab60 -+dispw;

remvw.obj : remvw.asm
   ml $(ASMFLAGS) remvw.asm
   lib tab60 -+remvw;


