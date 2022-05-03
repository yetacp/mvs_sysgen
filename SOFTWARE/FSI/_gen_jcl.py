#!/usr/bin/python3
# -*- coding: utf-8 -*-
import os

with open("01_install_fsi.jcl", "w") as out:
    out.write("""//FSI   JOB (JOB),
//           'INSTALL FSI',
//           CLASS=A,
//           MSGCLASS=A,
//           MSGLEVEL=(1,1),
//           USER=IBMUSER,
//           PASSWORD=SYS1
//CLEANUP EXEC PGM=IDCAMS
//SYSIN    DD *
  DELETE SYSGEN.FSI.ASM
  DELETE SYSGEN.FSI.CLIST
  DELETE SYSGEN.FSI.JCL
  DELETE SYSGEN.FSI.MLIB
  DELETE SYSGEN.FSI.PLIB
  DELETE SYSGEN.FSI.SAMP
  DELETE SYSGEN.FSI.OBJ
  DELETE SYSGEN.FSI.LOAD
  SET MAXCC=0
//SYSPRINT DD  SYSOUT=*
//* -----------------------------------\n""")
    folders = ["asm", "clist", "jcl", "mlib", "plib", "samp"]
    for folder in folders:
        pds = folder.upper()
        out.write("""//S{pds:5}  EXEC PGM=PDSLOAD
//STEPLIB  DD  DSN=SYSC.LINKLIB,DISP=SHR
//SYSPRINT DD  SYSOUT=*
//SYSUT2   DD  DSN=SYSGEN.FSI.{pds},
//             UNIT=SYSALLDA,VOL=SER=PUB001,
//             SPACE=(CYL,(15,2,20),RLSE),
//             DISP=(NEW,CATLG,DELETE)
//SYSUT1   DD  DATA,DLM=@@\n""".format(pds=pds))
        files = os.listdir("./{folder}/".format(folder=folder))
        files.sort()
        for file in files:
            member = file.upper()
            pos = member.find('.')
            member = member[:pos]
            # print(member)
            out.write('./ ADD NAME={member}\n'.format(member=member))
            with open('{folder}/{file}'.format(folder=folder, file=file), 'r') as dataset:
                out.write(dataset.read())
        out.write('@@\n')
    out.write("""//* -----------------------------------
//ALLOC EXEC PGM=IEFBR14
//OBJ    DD DSN=SYSGEN.FSI.OBJ,
//          DISP=(NEW,CATLG,DELETE),
//          UNIT=SYSALLDA,VOL=SER=PUB001,
//          SPACE=(CYL,(1,0,36))
//LOAD   DD DSN=SYSGEN.FSI.LOAD,
//          DISP=(NEW,CATLG,DELETE),
//          UNIT=SYSALLDA,VOL=SER=PUB001,
//          SPACE=(CYL,(1,0,36))
//* -----------------------------------
//TCSASM PROC M=
//COMPILE EXEC  PGM=IFOX00,REGION=1024K,
//         PARM='LINECOUNT(45)'
//SYSLIB   DD    DISP=SHR,DSN=SYS1.MACLIB
//         DD    DISP=SHR,DSN=SYS1.AMODGEN
//         DD    DISP=SHR,DSN=SYSGEN.FSI.ASM
//SYSUT1   DD    DSN=&&SYSUT1,UNIT=VIO,SPACE=(1700,(600,100))
//SYSUT2   DD    DSN=&&SYSUT2,UNIT=VIO,SPACE=(1700,(300,50))
//SYSUT3   DD    DSN=&&SYSUT3,UNIT=VIO,SPACE=(1700,(300,50))
//SYSPRINT DD    SYSOUT=*
//SYSIN    DD    DISP=SHR,DSN=SYSGEN.FSI.ASM(&M)
//SYSPUNCH DD    DISP=SHR,DSN=SYSGEN.FSI.OBJ(&M)
//   PEND
//FSISTART EXEC TCSASM,M=FSISTART
//FSISTUB  EXEC TCSASM,M=FSISTUB
//FSIDSPLY EXEC TCSASM,M=FSIDSPLY
//FSIERMSG EXEC TCSASM,M=FSIERMSG
//FSIPANL  EXEC TCSASM,M=FSIPANL
//FSISCRN  EXEC TCSASM,M=FSISCRN
//FSIVPUT  EXEC TCSASM,M=FSIVPUT
//FSIVGET  EXEC TCSASM,M=FSIVGET
//FSIPDS   EXEC TCSASM,M=FSIPDS
//FSIFUNC  EXEC TCSASM,M=FSIFUNC
//FSIDFLT  EXEC TCSASM,M=FSIDFLT
//VARPOOL  EXEC TCSASM,M=VARPOOL
//FSIVDEF  EXEC TCSASM,M=FSIVDEF
//FSIVLOC  EXEC TCSASM,M=FSIVLOC
//FSIVSTO  EXEC TCSASM,M=FSIVSTO
//VARDEFS  EXEC TCSASM,M=VARDEFS
//FSIVDEF  EXEC TCSASM,M=FSIVDEF
//FSIVSTO  EXEC TCSASM,M=FSIVSTO
//FSIVLOC  EXEC TCSASM,M=FSIVLOC
//* -----------------------------------
//COPY     EXEC PGM=IEBGENER
//SYSPRINT   DD SYSOUT=*
//SYSIN      DD DUMMY
//SYSUT1     DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSISTART)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSISCRN)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSIPANL)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSIERMSG)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSIDSPLY)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSIVGET)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSIVPUT)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSIPDS)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSIVDEF)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSIVLOC)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSIVSTO)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(VARPOOL)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(VARDEFS)
//SYSUT2     DD DSN=&&FSISTART,
//           DISP=(NEW,PASS,DELETE),
//           DCB=(BLKSIZE=80,LRECL=80,RECFM=F),
//           UNIT=SYSALLDA,VOL=SER=PUB001,
//           SPACE=(CYL,(1,1))
//* -----------------------------------
//FSISTART EXEC PGM=IEWL,PARM='XREF,LIST,LET,NCAL',REGION=1024K
//SYSPRINT DD  SYSOUT=A
//SYSLIN   DD  DSN=&&FSISTART,DISP=(OLD,DELETE,DELETE)
//SYSLMOD  DD  DISP=SHR,DSN=SYSGEN.FSI.LOAD(FSISTART)
//SYSUT1   DD  UNIT=SYSALLDA,VOL=SER=PUB001,
//           SPACE=(1024,(200,20))
//* -----------------------------------
//COPY     EXEC PGM=IEBGENER
//SYSPRINT   DD SYSOUT=*
//SYSIN      DD DUMMY
//SYSUT1     DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSIFUNC)
//SYSUT2     DD DSN=&&FSIFUNC,
//           DISP=(NEW,PASS,DELETE),
//           DCB=(BLKSIZE=80,LRECL=80,RECFM=F),
//           UNIT=SYSALLDA,VOL=SER=PUB001,
//           SPACE=(CYL,(1,1))
//FSIFUNC  EXEC PGM=IEWL,PARM='XREF,LIST,LET,NCAL',REGION=1024K
//SYSPRINT DD  SYSOUT=A
//SYSLIN   DD  DSN=&&FSIFUNC,DISP=(OLD,DELETE,DELETE)
//SYSLMOD  DD  DISP=SHR,DSN=SYSGEN.FSI.LOAD(FSIFUNC)
//SYSUT1   DD  UNIT=SYSALLDA,VOL=SER=PUB001,
//           SPACE=(1024,(200,20))
//* -----------------------------------
//COPY     EXEC PGM=IEBGENER
//SYSPRINT   DD SYSOUT=*
//SYSIN      DD DUMMY
//SYSUT1     DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSIDFLT)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSISTUB)
//SYSUT2     DD DSN=&&FSIFUNC,
//           DISP=(NEW,PASS,DELETE),
//           DCB=(BLKSIZE=80,LRECL=80,RECFM=F),
//           UNIT=SYSALLDA,VOL=SER=PUB001,
//           SPACE=(CYL,(1,1))
//* -----------------------------------
//FSIDFLT  EXEC PGM=IEWL,PARM='XREF,LIST,LET,NCAL',REGION=1024K
//SYSPRINT DD  SYSOUT=A
//SYSLIN   DD  DSN=&&FSIFUNC,DISP=(OLD,DELETE,DELETE)
//SYSLMOD  DD  DISP=SHR,DSN=SYSGEN.FSI.LOAD(FSIDFLT)
//SYSUT1   DD  UNIT=SYSALLDA,VOL=SER=PUB001,
//           SPACE=(1024,(200,20))
//* -----------------------------------
//
""")
