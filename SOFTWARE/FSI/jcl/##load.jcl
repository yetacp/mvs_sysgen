//FSILOAD JOB (5222),'TOMMY SPRINKLE',
//        CLASS=A,MSGCLASS=A
//*
//FSILOAD PROC PFX=FSI,
//        VRM=V1R2M0,
//        VOLSER=WORK01,
//        UNIT=3350
//IEBCOPY EXEC PGM=IEBCOPY
//SYSPRINT  DD SYSOUT=*
//*
//ASM       DD DSN=&PFX..&VRM..ASM,
            DISP=(NEW,CATLG,DELETE),
            UNIT=&UNIT,VOL=SER=&VOLSER,
            SPACE=(CYL,(1,0,36))
//OBJ       DD DSN=&PFX..&VRM..OBJ,
            DISP=(NEW,CATLG,DELETE),
            UNIT=&UNIT,VOL=SER=&VOLSER,
            SPACE=(CYL,(1,0,36))
//LOAD      DD DSN=&PFX..&VRM..LOAD,
            DISP=(NEW,CATLG,DELETE),
            UNIT=&UNIT,VOL=SER=&VOLSER,
            SPACE=(CYL,(1,0,36))
//PLIB      DD DSN=&PFX..&VRM..PLIB,
            DISP=(NEW,CATLG,DELETE),
            UNIT=&UNIT,VOL=SER=&VOLSER,
            SPACE=(CYL,(1,0,36))
//MLIB      DD DSN=&PFX..&VRM..MLIB,
            DISP=(NEW,CATLG,DELETE),
            UNIT=&UNIT,VOL=SER=&VOLSER,
            SPACE=(CYL,(1,0,36))
//*
//*
//*
//ASMT      DD DSN=FSI.&VRM..ASMT,
//          DISP=(OLD,KEEP,KEEP),
//          UNIT=TAPE,LABEL=(1,SL),
//          VOL=(,RETAIN,SER=FSI120)
//OBJT      DD DSN=FSI.&VRM..OBJT,
//          DISP=(OLD,KEEP,KEEP),
//          UNIT=TAPE,LABEL=(2,SL),
//          VOL=(,RETAIN,REF=*.ASMT)
//LOADT     DD DSN=FSI.&VRM..LOADT,
//          DISP=(OLD,KEEP,KEEP),
//          UNIT=TAPE,LABEL=(3,SL),
//          VOL=(,RETAIN,REF=*.OBJT)
//PLIBT     DD DSN=FSI.&VRM..PLIBT,
//          DISP=(OLD,KEEP,KEEP),
//          UNIT=TAPE,LABEL=(4,SL),
//          VOL=(,RETAIN,REF=*.LOADT)
//MLIBT     DD DSN=FSI.&VRM..MLIBT,
//          DISP=(OLD,KEEP,KEEP),
//          UNIT=TAPE,LABEL=(5,SL),
//          VOL=REF=*.PLIBT
// PEND
//*
//UNLOAD EXEC PROC=FSIUNLD
//IEBCOPY.SYSIN DD *
  C O=ASM,I=ASMT
  C O=OBJ,I=OBJT
  C O=LOAD,I=LOADT
  C O=MLIB,I=MLIBT
  C O=PLIB,I=PLIBT
/*
//
