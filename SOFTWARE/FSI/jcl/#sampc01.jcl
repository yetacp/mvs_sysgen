//SAMPC01  JOB 5222,'SPRINKLE',CLASS=A,MSGCLASS=A,
//        MSGLEVEL=(1,1)
//COB      EXEC  PGM=IKFCBL00,REGION=4096K,
//         PARM='LOAD,SUPMAP,SIZE=2048K,BUF=1024K'
//STEPLIB  DD    DISP=SHR,DSN=SYSC.LINKLIB
//SYSLIB   DD    DISP=SHR,DSN=SYS1.MACLIB
//         DD    DISP=SHR,DSN=SYS1.AMODGEN
//         DD    DISP=SHR,DSN=SYSGEN.FSI.ASM
//SYSUT1   DD    DSN=&&SYSUT1,UNIT=VIO,SPACE=(1700,(600,100))
//SYSUT2   DD    DSN=&&SYSUT2,UNIT=VIO,SPACE=(1700,(300,50))
//SYSUT3   DD    DSN=&&SYSUT3,UNIT=VIO,SPACE=(1700,(300,50))
//SYSUT4   DD    DSN=&&SYSUT3,UNIT=VIO,SPACE=(1700,(300,50))
//SYSPRINT DD    SYSOUT=*
//SYSIN    DD    DISP=SHR,DSN=SYSGEN.FSI.SAMP(SAMPC01)
//SYSLIN   DD    DISP=SHR,DSN=SYSGEN.FSI.OBJ(SAMPC01)
//SYSPUNCH DD    DUMMY
//*-------------------------
//COPY     EXEC PGM=IEBGENER
//SYSPRINT DD SYSOUT=*
//SYSIN    DD DUMMY
//SYSUT1   DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(SAMPC01)
//         DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSISTUB)
//SYSUT2   DD DSN=&&TEMPLINK,
//         DISP=(NEW,PASS,DELETE),
//         DCB=(BLKSIZE=80,LRECL=80,RECFM=F),
//         UNIT=SYSALLDA,VOL=SER=PUB001,
//         SPACE=(CYL,(1,1))
//*-------------------------
//LKED     EXEC PGM=IEWL,PARM='XREF,LIST,LET',REGION=1024K
//SYSPRINT DD  SYSOUT=A
//SYSLIB   DD  DISP=SHR,DSN=SYSC.COBLIB
//         DD  DISP=SHR,DSN=SYS1.LINKLIB
//SYSLIN   DD  DSN=&&TEMPLINK,DISP=(OLD,DELETE,DELETE)
//SYSLMOD  DD  DISP=SHR,DSN=SYSGEN.FSI.LOAD(SAMPC01)
//SYSUT1   DD  UNIT=SYSALLDA,VOL=SER=PUB001,
//         SPACE=(1024,(200,20))
//
