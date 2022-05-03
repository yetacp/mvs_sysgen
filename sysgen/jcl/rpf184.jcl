//RPF184$1 JOB (TSO),
//             'Install RPF',
//             CLASS=A,
//             MSGCLASS=A,
//             MSGLEVEL=(1,1)
//*********************************************************************
//*
//* DESC: Install RPF 1.8.4
//*
//*********************************************************************
//CLEANUP EXEC PGM=IDCAMS
//REPROIN  DD  *
99999999    SEED RECORD FOR THE RPF Profile cluster
//SYSPRINT DD  SYSOUT=*
//SYSIN  DD *
 PARM GRAPHICS(CHAIN(SN))
 /***********************************************************/
 /*                                                         */
 /* Desc:  Delete all RPF data sets of previous releases    */
 /*        and define the new RPF profile cluster.          */
 /*                                                         */
 /* Note:  you do not need this define alias if you do not  */
 /*        want to use a private user catalog               */
 /*                                                         */
 /* Note:  you need to update the relate parameter to       */
 /*        point to the catalog that you want to use        */
 /*                                                         */
 /***********************************************************/
   DEFINE ALIAS(NAME(RPF) RELATE(UCPUB001))
   SET LASTCC = 0
   SET MAXCC = 0
   DELETE RPF.V1R5M0.SRPFASM  NONVSAM
   DELETE RPF.V1R5M0.SRPFOBJ  NONVSAM
   DELETE RPF.V1R5M0.SRPFHELP NONVSAM
   DELETE RPF.V1R5M0.SRPFLOAD NONVSAM
   DELETE RPF.V1R5M0.CNTL     NONVSAM
   DELETE RPF.V1R5M0.SRPFPROF CLUSTER
   DELETE RPF.V1R5M1.SRPFASM  NONVSAM
   DELETE RPF.V1R5M1.SRPFOBJ  NONVSAM
   DELETE RPF.V1R5M1.SRPFHELP NONVSAM
   DELETE RPF.V1R5M1.SRPFLOAD NONVSAM
   DELETE RPF.V1R5M1.CNTL     NONVSAM
   DELETE RPF.V1R5M1.SRPFPROF CLUSTER
   DELETE RPF.V1R5M2.SRPFASM  NONVSAM
   DELETE RPF.V1R5M2.SRPFOBJ  NONVSAM
   DELETE RPF.V1R5M2.SRPFHELP NONVSAM
   DELETE RPF.V1R5M2.SRPFLOAD NONVSAM
   DELETE RPF.V1R5M2.CNTL     NONVSAM
   DELETE RPF.V1R5M2.SRPFPROF CLUSTER
   DELETE RPF.V1R5M3.SRPFASM  NONVSAM
   DELETE RPF.V1R5M3.SRPFOBJ  NONVSAM
   DELETE RPF.V1R5M3.SRPFHELP NONVSAM
   DELETE RPF.V1R5M3.SRPFLOAD NONVSAM
   DELETE RPF.V1R5M3.CNTL     NONVSAM
   DELETE RPF.V1R5M3.SRPFPROF CLUSTER
   DELETE RPF.V1R6M0.SRPFASM  NONVSAM
   DELETE RPF.V1R6M0.SRPFOBJ  NONVSAM
   DELETE RPF.V1R6M0.SRPFHELP NONVSAM
   DELETE RPF.V1R6M0.SRPFLOAD NONVSAM
   DELETE RPF.V1R6M0.SYS1MAC  NONVSAM
   DELETE RPF.V1R6M0.SRPFJCL  NONVSAM
   DELETE RPF.V1R6M0.SRPFPROF CLUSTER
   DELETE RPF.V1R6M1.SRPFASM  NONVSAM
   DELETE RPF.V1R6M1.SRPFOBJ  NONVSAM
   DELETE RPF.V1R6M1.SRPFHELP NONVSAM
   DELETE RPF.V1R6M1.SRPFLOAD NONVSAM
   DELETE RPF.V1R6M1.SYS1MAC  NONVSAM
   DELETE RPF.V1R6M1.SRPFJCL  NONVSAM
   DELETE RPF.V1R6M1.SRPFPROF CLUSTER
   DELETE RPF.V1R6M2.SRPFASM  NONVSAM
   DELETE RPF.V1R6M2.SRPFOBJ  NONVSAM
   DELETE RPF.V1R6M2.SRPFHELP NONVSAM
   DELETE RPF.V1R6M2.SRPFLOAD NONVSAM
   DELETE RPF.V1R6M2.SYS1MAC  NONVSAM
   DELETE RPF.V1R6M2.SRPFJCL  NONVSAM
   DELETE RPF.V1R6M2.SRPFPROF CLUSTER
   DELETE RPF.V1R7M0.SRPFASM  NONVSAM
   DELETE RPF.V1R7M0.SRPFOBJ  NONVSAM
   DELETE RPF.V1R7M0.SRPFHELP NONVSAM
   DELETE RPF.V1R7M0.SRPFLOAD NONVSAM
   DELETE RPF.V1R7M0.SYS1MAC  NONVSAM
   DELETE RPF.V1R7M0.SRPFJCL  NONVSAM
   DELETE RPF.V1R7M0.SRPFPROF CLUSTER
   DELETE RPF.V1R7M1.SRPFASM  NONVSAM
   DELETE RPF.V1R7M1.SRPFOBJ  NONVSAM
   DELETE RPF.V1R7M1.SRPFHELP NONVSAM
   DELETE RPF.V1R7M1.SRPFLOAD NONVSAM
   DELETE RPF.V1R7M1.SYS1MAC  NONVSAM
   DELETE RPF.V1R7M1.SRPFJCL  NONVSAM
   DELETE RPF.V1R7M1.SRPFPROF CLUSTER
   DELETE RPF.V1R7M2.SRPFASM  NONVSAM
   DELETE RPF.V1R7M2.SRPFOBJ  NONVSAM
   DELETE RPF.V1R7M2.SRPFHELP NONVSAM
   DELETE RPF.V1R7M2.SRPFLOAD NONVSAM
   DELETE RPF.V1R7M2.SYS1MAC  NONVSAM
   DELETE RPF.V1R7M2.SRPFJCL  NONVSAM
   DELETE RPF.V1R7M2.SRPFPROF CLUSTER
   DELETE RPF.V1R7M3.SRPFASM  NONVSAM
   DELETE RPF.V1R7M3.SRPFOBJ  NONVSAM
   DELETE RPF.V1R7M3.SRPFHELP NONVSAM
   DELETE RPF.V1R7M3.SRPFLOAD NONVSAM
   DELETE RPF.V1R7M3.SYS1MAC  NONVSAM
   DELETE RPF.V1R7M3.SRPFJCL  NONVSAM
   DELETE RPF.V1R7M3.SRPFPROF CLUSTER
   DELETE RPF.V1R7M4.SRPFASM  NONVSAM
   DELETE RPF.V1R7M4.SRPFOBJ  NONVSAM
   DELETE RPF.V1R7M4.SRPFHELP NONVSAM
   DELETE RPF.V1R7M4.SRPFLOAD NONVSAM
   DELETE RPF.V1R7M4.SYS1MAC  NONVSAM
   DELETE RPF.V1R7M4.SRPFJCL  NONVSAM
   DELETE RPF.V1R7M4.SRPFPROF CLUSTER
   DELETE RPF.V1R7M5.SRPFASM  NONVSAM
   DELETE RPF.V1R7M5.SRPFOBJ  NONVSAM
   DELETE RPF.V1R7M5.SRPFHELP NONVSAM
   DELETE RPF.V1R7M5.SRPFLOAD NONVSAM
   DELETE RPF.V1R7M5.SYS1MAC  NONVSAM
   DELETE RPF.V1R7M5.SRPFJCL  NONVSAM
   DELETE RPF.V1R7M5.SRPFPROF CLUSTER
   DELETE RPF.V1R7M6.SRPFASM  NONVSAM
   DELETE RPF.V1R7M6.SRPFOBJ  NONVSAM
   DELETE RPF.V1R7M6.SRPFHELP NONVSAM
   DELETE RPF.V1R7M6.SRPFLOAD NONVSAM
   DELETE RPF.V1R7M6.SYS1MAC  NONVSAM
   DELETE RPF.V1R7M6.SRPFJCL  NONVSAM
   DELETE RPF.V1R7M6.SRPFPROF CLUSTER
   DELETE RPF.V1R7M7.SRPFASM  NONVSAM
   DELETE RPF.V1R7M7.SRPFOBJ  NONVSAM
   DELETE RPF.V1R7M7.SRPFHELP NONVSAM
   DELETE RPF.V1R7M7.SRPFLOAD NONVSAM
   DELETE RPF.V1R7M7.SYS1MAC  NONVSAM
   DELETE RPF.V1R7M7.SRPFJCL  NONVSAM
   DELETE RPF.V1R7M7.SRPFPROF CLUSTER
   DELETE RPF.V1R7M8.SRPFASM  NONVSAM
   DELETE RPF.V1R7M8.SRPFOBJ  NONVSAM
   DELETE RPF.V1R7M8.SRPFHELP NONVSAM
   DELETE RPF.V1R7M8.SRPFLOAD NONVSAM
   DELETE RPF.V1R7M8.SYS1MAC  NONVSAM
   DELETE RPF.V1R7M8.SRPFJCL  NONVSAM
   DELETE RPF.V1R7M8.SRPFPROF CLUSTER
   DELETE RPF.V1R7M9.SRPFASM  NONVSAM
   DELETE RPF.V1R7M9.SRPFOBJ  NONVSAM
   DELETE RPF.V1R7M9.SRPFHELP NONVSAM
   DELETE RPF.V1R7M9.SRPFLOAD NONVSAM
   DELETE RPF.V1R7M9.SYS1MAC  NONVSAM
   DELETE RPF.V1R7M9.SRPFJCL  NONVSAM
   DELETE RPF.V1R7M9.SRPFPROF CLUSTER
   DELETE RPF.V1R8M0.SRPFASM  NONVSAM
   DELETE RPF.V1R8M0.SRPFOBJ  NONVSAM
   DELETE RPF.V1R8M0.SRPFHELP NONVSAM
   DELETE RPF.V1R8M0.SRPFLOAD NONVSAM
   DELETE RPF.V1R8M0.SYS1MAC  NONVSAM
   DELETE RPF.V1R8M0.SRPFJCL  NONVSAM
   DELETE RPF.V1R8M0.SRPFPROF CLUSTER
   DELETE RPF.V1R8M1.SRPFASM  NONVSAM
   DELETE RPF.V1R8M1.SRPFOBJ  NONVSAM
   DELETE RPF.V1R8M1.SRPFHELP NONVSAM
   DELETE RPF.V1R8M1.SRPFLOAD NONVSAM
   DELETE RPF.V1R8M1.SYS1MAC  NONVSAM
   DELETE RPF.V1R8M1.SRPFJCL  NONVSAM
   DELETE RPF.V1R8M1.SRPFPROF CLUSTER
   DELETE RPF.V1R8M2.SRPFASM  NONVSAM
   DELETE RPF.V1R8M2.SRPFOBJ  NONVSAM
   DELETE RPF.V1R8M2.SRPFHELP NONVSAM
   DELETE RPF.V1R8M2.SRPFLOAD NONVSAM
   DELETE RPF.V1R8M2.SYS1MAC  NONVSAM
   DELETE RPF.V1R8M2.SRPFJCL  NONVSAM
   DELETE RPF.V1R8M2.SRPFPROF CLUSTER
   DELETE RPF.V1R8M3.SRPFASM  NONVSAM
   DELETE RPF.V1R8M3.SRPFOBJ  NONVSAM
   DELETE RPF.V1R8M3.SRPFHELP NONVSAM
   DELETE RPF.V1R8M3.SRPFLOAD NONVSAM
   DELETE RPF.V1R8M3.SYS1MAC  NONVSAM
   DELETE RPF.V1R8M3.SRPFJCL  NONVSAM
   DELETE RPF.V1R8M3.SRPFPROF CLUSTER
   DELETE RPF.V1R8M4.SRPFASM  NONVSAM
   DELETE RPF.V1R8M4.SRPFOBJ  NONVSAM
   DELETE RPF.V1R8M4.SRPFHELP NONVSAM
   DELETE RPF.V1R8M4.SRPFLOAD NONVSAM
   DELETE RPF.V1R8M4.SYS1MAC  NONVSAM
   DELETE RPF.V1R8M4.SRPFJCL  NONVSAM
   DELETE RPF.V1R8M4.SRPFPROF CLUSTER
   SET LASTCC = 0
   SET MAXCC  = 0
 /***********************************************************/
 /*                                                         */
 /* Note:  You will have to modify the volume names         */
 /*        and the dataset high level qualifiers            */
 /*        to reflect your system environment               */
 /*                                                         */
 /* Note:  Do __not__ modify the low level qualifier, as    */
 /*        they will be needed as is if and when RPF        */
 /*        will be distributed in smp format                */
 /*                                                         */
 /***********************************************************/
  DEFINE CLUSTER ( NAME(RPF.V1R8M4.SRPFPROF) -
                   VOL(PUB000) -
                   FREESPACE(20 10) -
                   RECORDSIZE(1750 1750) -
                   INDEXED -
                   IMBED -
                   UNIQUE  -
                   KEYS(8 0) -
                   CYLINDERS(1 1) -
                 ) -
            DATA ( NAME(RPF.V1R8M4.SRPFPROF.DATA) -
                   SHR(3 3) -
                 ) -
           INDEX ( NAME(RPF.V1R8M4.SRPFPROF.INDEX) -
                   SHR(3 3) -
                 )
  IF LASTCC = 0 THEN -
     REPRO INFILE(REPROIN) -
           OUTDATASET(RPF.V1R8M4.SRPFPROF)
/*
//ALLOC   EXEC PGM=IEBCOPY
//ASM      DD  DISP=(NEW,CATLG),
//             DSN=RPF.V1R8M4.SRPFASM,
//             DCB=SYS1.MACLIB,
//             SPACE=(CYL,(10,1,20)),
//             UNIT=SYSDA,
//             VOL=SER=PUB000
//LOAD     DD  DISP=(NEW,CATLG),
//             DSN=RPF.V1R8M4.SRPFLOAD,
//             DCB=(RECFM=U,BLKSIZE=6144),
//             SPACE=(CYL,(2,1,30)),
//             UNIT=SYSDA,
//             VOL=SER=PUB000
//HELP     DD  DISP=(NEW,CATLG),
//             DSN=RPF.V1R8M4.SRPFHELP,
//             DCB=SYS1.MACLIB,
//             SPACE=(CYL,(1,1,5)),
//             UNIT=SYSDA,
//             VOL=SER=PUB000
//JCL      DD  DISP=(NEW,CATLG),
//             DSN=RPF.V1R8M4.SRPFJCL,
//             DCB=SYS1.MACLIB,
//             SPACE=(CYL,(1,1,20)),
//             UNIT=SYSDA,
//             VOL=SER=PUB000
//MAC      DD  DISP=(NEW,CATLG),
//             DSN=RPF.V1R8M4.SYS1MAC,
//             DCB=SYS1.MACLIB,
//             SPACE=(CYL,(1,1,5)),
//             UNIT=SYSDA,
//             VOL=SER=PUB000
//OBJ      DD  DISP=(NEW,CATLG),
//             DSN=RPF.V1R8M4.SRPFOBJ,
//             DCB=(RECFM=FB,LRECL=80,BLKSIZE=3200),
//             SPACE=(CYL,(1,1,15)),
//             UNIT=SYSDA,
//             VOL=SER=PUB000
//ASMIN    DD  DISP=OLD,
//             DSN=TAPE.V1R8M4.SRPFASM,
//             UNIT=(TAPE,,DEFER),
//             VOL=SER=RPF184,
//             LABEL=(1,SL)
//LOADIN   DD  DISP=OLD,
//             DSN=TAPE.V1R8M4.SRPFLOAD,
//             UNIT=AFF=ASMIN,
//             VOL=REF=*.ASMIN,
//             LABEL=(2,SL)
//HELPIN   DD  DISP=OLD,
//             DSN=TAPE.V1R8M4.SRPFHELP,
//             UNIT=AFF=LOADIN,
//             VOL=REF=*.LOADIN,
//             LABEL=(3,SL)
//JCLIN   DD   DISP=OLD,
//             DSN=TAPE.V1R8M4.SRPFJCL,
//             UNIT=AFF=HELPIN,
//             LABEL=(4,SL),
//             VOL=REF=*.HELPIN
//MACIN   DD   DISP=OLD,
//             DSN=TAPE.V1R8M4.SYS1MAC,
//             UNIT=AFF=JCLIN,
//             LABEL=(5,SL),
//             VOL=REF=*.JCLIN
//OBJIN   DD   DISP=OLD,
//             DSN=TAPE.V1R8M4.SRPFOBJ,
//             UNIT=AFF=MACIN,
//             LABEL=(6,SL),
//             VOL=REF=*.MACIN
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  *
 COPY INDD=ASMIN,OUTDD=ASM
 COPY INDD=LOADIN,OUTDD=LOAD
 COPY INDD=HELPIN,OUTDD=HELP
 COPY INDD=JCLIN,OUTDD=JCL
 COPY INDD=MACIN,OUTDD=MAC
 COPY INDD=OBJIN,OUTDD=OBJ
//GENER   EXEC PGM=IEBUPDTE,PARM=NEW
//SYSUT2   DD  DISP=SHR,DSN=SYS1.PARMLIB
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  *
./ ADD NAME=RPFKEY00
RPF.V1R8M4.SRPFPROF
HELP=RPF.V1R8M4.SRPFHELP
//ALLOC   EXEC PGM=IEBCOPY
//LOAD     DD  DISP=SHR,DSN=RPF.V1R8M4.SRPFLOAD
//CMDLIB   DD  DISP=SHR,DSN=SYS2.CMDLIB
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  *
 COPY INDD=CMDLIB,OUTDD=CMDLIB
 COPY INDD=((LOAD,R)),OUTDD=CMDLIB
 COPY INDD=CMDLIB,OUTDD=CMDLIB
/*
//HELP    EXEC PGM=IEBCOPY
//ASM      DD  DISP=SHR,DSN=RPF.V1R8M4.SRPFASM
//HELP     DD  DISP=SHR,DSN=RPF.V1R8M4.SRPFHELP
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  *
 COPY INDD=((ASM,R)),OUTDD=HELP
 S M=(RPFHELP1,RPFHELP2,RPFHELP3,RPFHELP4,RPFHELP5)
/*
//

