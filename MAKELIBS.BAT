del *.lib
del *.bak

ml /c /Cx /D mdl=1 global6.asm
ml /c /Cx /D mdl=1 mvcur.asm
ml /c /Cx /D mdl=1 clrscrn.asm
ml /c /Cx /D mdl=1 bdwrite.asm
ml /c /Cx /D mdl=1 gtcur.asm
ml /c /Cx /D mdl=1 setcur.asm
ml /c /Cx /D mdl=1 oncur.asm
ml /c /Cx /D mdl=1 offcur.asm
ml /c /Cx /D mdl=1 restcur.asm
ml /c /Cx /D mdl=1 mkattr.asm
ml /c /Cx /D mdl=1 mktoken.asm
ml /c /Cx /D mdl=1 vidinit.asm
ml /c /Cx /D mdl=1 vdwrite.asm
ml /c /Cx /D mdl=1 vdchar.asm
ml /c /Cx /D mdl=1 vdattr.asm
ml /c /Cx /D mdl=1 vdhrep.asm
ml /c /Cx /D mdl=1 vdvrep.asm
ml /c /Cx /D mdl=1 savescrn.asm
ml /c /Cx /D mdl=1 restscrn.asm
ml /c /Cx /D mdl=1 vrdchar.asm
ml /c /Cx /D mdl=1 memset.asm
ml /c /Cx /D mdl=1 strlen.asm
ml /c /Cx /D mdl=1 strcpy.asm
ml /c /Cx /D mdl=1 strupr.asm
ml /c /Cx /D mdl=1 strlwr.asm
ml /c /Cx /D mdl=1 strcmp.asm
ml /c /Cx /D mdl=1 strncmp.asm
ml /c /Cx /D mdl=1 strswap.asm
ml /c /Cx /D mdl=1 memncpy.asm
ml /c /Cx /D mdl=1 strins.asm
ml /c /Cx /D mdl=1 strsrch.asm
ml /c /Cx /D mdl=1 strcat.asm
ml /c /Cx /D mdl=1 itoa.asm
ml /c /Cx /D mdl=1 itoh.asm
ml /c /Cx /D mdl=1 ltoa.asm
ml /c /Cx /D mdl=1 errmsg.asm
ml /c /Cx /D mdl=1 free.asm
ml /c /Cx /D mdl=1 malloc.asm
ml /c /Cx /D mdl=1 vdbox.asm
ml /c /Cx /D mdl=1 initw.asm
ml /c /Cx /D mdl=1 destw.asm
ml /c /Cx /D mdl=1 dispw.asm
ml /c /Cx /D mdl=1 remvw.asm
ml /c /Cx /D mdl=1 wvdwrite.asm
ml /c /Cx /D mdl=1 wvdattr.asm
ml /c /Cx /D mdl=1 wvdchar.asm
ml /c /Cx /D mdl=1 msinit.asm
ml /c /Cx /D mdl=1 mson.asm
ml /c /Cx /D mdl=1 msoff.asm
ml /c /Cx /D mdl=1 msstat.asm
ml /c /Cx /D mdl=1 kbstat.asm
ml /c /Cx /D mdl=1 kbread.asm
ml /c /Cx /D mdl=1 dispddw.asm
ml /c /Cx /D mdl=1 initddw.asm
ml /c /Cx /D mdl=1 dispmb.asm
ml /c /Cx /D mdl=1 initmb.asm
ml /c /Cx /D mdl=1 remvddw.asm
ml /c /Cx /D mdl=1 destddw.asm

lib tab60 +global6;
lib tab60 +mvcur;
lib tab60 +clrscrn;
lib tab60 +bdwrite;
lib tab60 +gtcur;
lib tab60 +setcur;
lib tab60 +oncur;
lib tab60 +offcur;
lib tab60 +restcur;
lib tab60 +mkattr;
lib tab60 +mktoken;
lib tab60 +vidinit;
lib tab60 +vdwrite;
lib tab60 +vdchar;
lib tab60 +vdattr;
lib tab60 +vdhrep;
lib tab60 +vdvrep;
lib tab60 +savescrn;
lib tab60 +restscrn;
lib tab60 +vrdchar;
lib tab60 +memset;
lib tab60 +strlen;
lib tab60 +strcpy;
lib tab60 +strupr;
lib tab60 +strlwr;
lib tab60 +strcmp;
lib tab60 +strncmp;
lib tab60 +strswap;
lib tab60 +memncpy;
lib tab60 +strins;
lib tab60 +strsrch;
lib tab60 +strcat;
lib tab60 +itoa;
lib tab60 +itoh;
lib tab60 +ltoa;
lib tab60 +errmsg;
lib tab60 +free;
lib tab60 +malloc;
lib tab60 +vdbox;
lib tab60 +initw;
lib tab60 +destw;
lib tab60 +dispw;
lib tab60 +remvw;
lib tab60 +wvdwrite;
lib tab60 +wvdattr;
lib tab60 +wvdchar;
lib tab60 +msinit;
lib tab60 +mson;
lib tab60 +msoff;
lib tab60 +msstat;
lib tab60 +kbstat;
lib tab60 +kbread;
lib tab60 +initddw;
lib tab60 +dispddw;
lib tab60 +remvddw;
lib tab60 +destddw;
lib tab60 +dispmb;
lib tab60 +initmb;


ml /c /Cx /D mdl=3 global6.asm
ml /c /Cx /D mdl=3 mvcur.asm
ml /c /Cx /D mdl=3 clrscrn.asm
ml /c /Cx /D mdl=3 bdwrite.asm
ml /c /Cx /D mdl=3 gtcur.asm
ml /c /Cx /D mdl=3 setcur.asm
ml /c /Cx /D mdl=3 oncur.asm
ml /c /Cx /D mdl=3 offcur.asm
ml /c /Cx /D mdl=3 restcur.asm
ml /c /Cx /D mdl=3 mkattr.asm
ml /c /Cx /D mdl=3 mktoken.asm
ml /c /Cx /D mdl=3 vidinit.asm
ml /c /Cx /D mdl=3 vdwrite.asm
ml /c /Cx /D mdl=3 vdchar.asm
ml /c /Cx /D mdl=3 vdattr.asm
ml /c /Cx /D mdl=3 vdhrep.asm
ml /c /Cx /D mdl=3 vdvrep.asm
ml /c /Cx /D mdl=3 savescrn.asm
ml /c /Cx /D mdl=3 restscrn.asm
ml /c /Cx /D mdl=3 vrdchar.asm
ml /c /Cx /D mdl=3 memset.asm
ml /c /Cx /D mdl=3 strlen.asm
ml /c /Cx /D mdl=3 strcpy.asm
ml /c /Cx /D mdl=3 strupr.asm
ml /c /Cx /D mdl=3 strlwr.asm
ml /c /Cx /D mdl=3 strcmp.asm
ml /c /Cx /D mdl=3 strncmp.asm
ml /c /Cx /D mdl=3 strswap.asm
ml /c /Cx /D mdl=3 memncpy.asm
ml /c /Cx /D mdl=3 strins.asm
ml /c /Cx /D mdl=3 strsrch.asm
ml /c /Cx /D mdl=3 strcat.asm
ml /c /Cx /D mdl=3 itoa.asm
ml /c /Cx /D mdl=3 itoh.asm
ml /c /Cx /D mdl=3 ltoa.asm
ml /c /Cx /D mdl=3 errmsg.asm
ml /c /Cx /D mdl=3 free.asm
ml /c /Cx /D mdl=3 malloc.asm
ml /c /Cx /D mdl=3 vdbox.asm
ml /c /Cx /D mdl=3 initw.asm
ml /c /Cx /D mdl=3 destw.asm
ml /c /Cx /D mdl=3 dispw.asm
ml /c /Cx /D mdl=3 remvw.asm
ml /c /Cx /D mdl=3 wvdwrite.asm
ml /c /Cx /D mdl=3 wvdattr.asm
ml /c /Cx /D mdl=3 wvdchar.asm
ml /c /Cx /D mdl=3 msinit.asm
ml /c /Cx /D mdl=3 mson.asm
ml /c /Cx /D mdl=3 msoff.asm
ml /c /Cx /D mdl=3 msstat.asm
ml /c /Cx /D mdl=3 kbstat.asm
ml /c /Cx /D mdl=3 kbread.asm
ml /c /Cx /D mdl=3 dispddw.asm
ml /c /Cx /D mdl=3 initddw.asm
ml /c /Cx /D mdl=3 remvddw.asm
ml /c /Cx /D mdl=3 destddw.asm
ml /c /Cx /D mdl=3 dispmb.asm
ml /c /Cx /D mdl=3 initmb.asm


lib tab60l +global6;
lib tab60l +mvcur;
lib tab60l +clrscrn;
lib tab60l +bdwrite;
lib tab60l +gtcur;
lib tab60l +setcur;
lib tab60l +oncur;
lib tab60l +offcur;
lib tab60l +restcur;
lib tab60l +mkattr;
lib tab60l +mktoken;
lib tab60l +vidinit;
lib tab60l +vdwrite;
lib tab60l +vdchar;
lib tab60l +vdattr;
lib tab60l +vdhrep;
lib tab60l +vdvrep;
lib tab60l +savescrn;
lib tab60l +restscrn;
lib tab60l +vrdchar;
lib tab60l +memset;
lib tab60l +strlen;
lib tab60l +strcpy;
lib tab60l +strupr;
lib tab60l +strlwr;
lib tab60l +strcmp;
lib tab60l +strncmp;
lib tab60l +strswap;
lib tab60l +memncpy;
lib tab60l +strins;
lib tab60l +strsrch;
lib tab60l +strcat;
lib tab60l +itoa;
lib tab60l +itoh;
lib tab60l +ltoa;
lib tab60l +errmsg;
lib tab60l +free;
lib tab60l +malloc;
lib tab60l +vdbox;
lib tab60l +initw;
lib tab60l +destw;
lib tab60l +dispw;
lib tab60l +remvw;
lib tab60l +wvdwrite;
lib tab60l +wvdattr;
lib tab60l +wvdchar;
lib tab60l +msinit;
lib tab60l +mson;
lib tab60l +msoff;
lib tab60l +msstat;
lib tab60l +kbstat;
lib tab60l +kbread;
lib tab60l +dispddw;
lib tab60l +initddw;
lib tab60l +remvddw;
lib tab60l +destddw;
lib tab60l +dispmb;
lib tab60l +initmb;


del *.bak
del *.obj
del *.map
