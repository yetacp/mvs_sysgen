#!/usr/bin/python3
# -*- coding: utf-8 -*-
import os

with open("01_install_fss.jcl", "w") as out:
    out.write("""//FSS   JOB (JOB),
//           'INSTALL FSS',
//           CLASS=A,
//           MSGCLASS=A,
//           MSGLEVEL=(1,1),
//           USER=IBMUSER,
//           PASSWORD=SYS1
//CLEANUP EXEC PGM=IDCAMS
//SYSIN    DD *
  DELETE SYSGEN.FSS.ASM
  DELETE SYSGEN.FSS.INCLUDE
  DELETE SYSGEN.FSS.OBJ
  DELETE SYSGEN.FSS.LOAD
  DELETE SYSGEN.FSS.SAMP
  SET MAXCC=0
//SYSPRINT DD  SYSOUT=*
//* -----------------------------------\n""")
    folders = ["asm", "include"]
    for folder in folders:
        pds = folder.upper()
        out.write("""//S{pds:5}  EXEC PGM=PDSLOAD
//STEPLIB  DD  DSN=SYSC.LINKLIB,DISP=SHR
//SYSPRINT DD  SYSOUT=*
//SYSUT2   DD  DSN=SYSGEN.FSS.{pds},
//             UNIT=SYSALLDA,VOL=SER=PUB001,
//             SPACE=(CYL,(15,2,20),RLSE),
//             DISP=(NEW,CATLG,DELETE)
//SYSUT1   DD  DATA,DLM=\'#@\'\n""".format(pds=pds))
        files = os.listdir("./{folder}/".format(folder=folder))
        files.sort()
        for file in files:
            member = file.upper()
            pos = member.find('.')
            member = member[:pos]
            out.write('./ ADD NAME={member}\n'.format(member=member))
            with open('{folder}/{file}'.format(folder=folder, file=file), 'r') as dataset:
                out.write(dataset.read())
        out.write('#@\n')
    out.write("""//* -----------------------------------
//ALLOC EXEC PGM=IEFBR14
//OBJ    DD DSN=SYSGEN.FSS.OBJ,
//          DISP=(NEW,CATLG,DELETE),
//          UNIT=SYSALLDA,VOL=SER=PUB001,
//          SPACE=(CYL,(1,0,36))
//LOAD   DD DSN=SYSGEN.FSS.LOAD,
//          DISP=(NEW,CATLG,DELETE),
//          UNIT=SYSALLDA,VOL=SER=PUB001,
//          SPACE=(CYL,(1,0,36))
//* -----------------------------------
//TCSASM PROC M=
//ASSEMBL EXEC  PGM=IFOX00,REGION=1024K,
//         PARM='LINECOUNT(45)'
//SYSLIB   DD    DISP=SHR,DSN=SYS1.MACLIB
//         DD    DISP=SHR,DSN=SYS1.AMODGEN
//         DD    DISP=SHR,DSN=PDPCLIB.MACLIB
//         DD    DISP=SHR,DSN=SYSGEN.FSS.ASM
//SYSUT1   DD    DSN=&&SYSUT1,UNIT=VIO,SPACE=(1700,(600,100))
//SYSUT2   DD    DSN=&&SYSUT2,UNIT=VIO,SPACE=(1700,(300,50))
//SYSUT3   DD    DSN=&&SYSUT3,UNIT=VIO,SPACE=(1700,(300,50))
//SYSPRINT DD    SYSOUT=*
//SYSIN    DD    DISP=SHR,DSN=SYSGEN.FSS.ASM(&M)
//SYSPUNCH DD    DISP=SHR,DSN=SYSGEN.FSS.OBJ(&M)
//   PEND
//ALLOC     EXEC TCSASM,M=ALLOC
//CHAINR    EXEC TCSASM,M=CHAINR
//EXCP      EXEC TCSASM,M=EXCP
//EXEC      EXEC TCSASM,M=EXEC
//FINDDEVT  EXEC TCSASM,M=FINDDEVT
//FSS       EXEC TCSASM,M=FSS
//SVC#GCC   EXEC TCSASM,M=SVC#GCC
//SVC#JCC   EXEC TCSASM,M=SVC#JCC
//TSO       EXEC TCSASM,M=TSO
//
""")
