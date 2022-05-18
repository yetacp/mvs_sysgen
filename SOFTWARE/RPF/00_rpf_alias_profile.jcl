//RPFPROF0 JOB (SYS),'INSTALL RPF',
//             CLASS=A,
//             MSGCLASS=A,
//             MSGLEVEL=(1,1),
//             USER=IBMUSER,PASSWORD=SYS1
//*********************************************************************
//*
//* DESC: INSTALL RPF PROFILE CLUSTER.
//*
//*********************************************************************
//CLEANUP EXEC PGM=IDCAMS
//REPROIN  DD  *
99999999    SEED RECORD FOR THE RPF Profile cluster
//SYSPRINT DD  SYSOUT=*
//SYSIN  DD *
 PARM GRAPHICS(CHAIN(SN))
   DEFINE ALIAS(NAME(RPF) RELATE(UCPUB001))
 /***********************************************************/
 /*                                                         */
 /* Note:  you do not need this define alias if you do not  */
 /*        want to use a private user catalog               */
 /*                                                         */
 /* Note:  you need to update the relate parameter to       */
 /*        point to the catalog that you want to use        */
 /*                                                         */
 /***********************************************************/
   DELETE RPF.PROFILE CLUSTER
   SET LASTCC = 0
   SET MAXCC  = 0
 /***********************************************************/
 /*                                                         */
 /* Note:  You will have to modify the volume names         */
 /*        and the dataset high level qualifiers            */
 /*        to reflect your system environment               */
 /*                                                         */
 /***********************************************************/
  DEFINE CLUSTER ( NAME(RPF.PROFILE) -
                   VOL(PUB001) -
                   FREESPACE(20 10) -
                   RECORDSIZE(1750 1750) -
                   INDEXED -
                   IMBED -
                   UNIQUE  -
                   KEYS(8 0) -
                   CYLINDERS(1 1) -
                 ) -
            DATA ( NAME(RPF.PROFILE.DATA) -
                   SHR(3 3) -
                 ) -
           INDEX ( NAME(RPF.PROFILE.INDEX) -
                   SHR(3 3) -
                 )
  IF LASTCC = 0 THEN -
     REPRO INFILE(REPROIN) -
           OUTDATASET(RPF.PROFILE)
//*********************************************************************
//STEP1   EXEC PGM=PDSLOAD
//STEPLIB  DD  DSN=SYSC.LINKLIB,DISP=SHR
//SYSPRINT DD  SYSOUT=*
//SYSUT2   DD  DSN=SYS1.PROCLIB,DISP=SHR
//SYSUT1   DD  DATA,DLM=@@
./ ADD NAME=IKJACCNT
//IKJACCNT PROC
//IKJACCNT EXEC PGM=IKJEFT01,DYNAMNBR=64,
//             PARM='EX ''SYS1.CMDPROC(TSOLOGON)'''
//SYSHELP  DD  DISP=SHR,DSN=SYS1.HELP
//         DD  DISP=SHR,DSN=SYS2.HELP
//SYSPROC  DD  DISP=SHR,DSN=SYS1.CMDPROC
//DD1      DD  DYNAM
//DD2      DD  DYNAM
//DD3      DD  DYNAM
//DD4      DD  DYNAM
//DD5      DD  DYNAM
//DD6      DD  DYNAM
//DD7      DD  DYNAM
//DD8      DD  DYNAM
//DD9      DD  DYNAM
//DDA      DD  DYNAM
//DDB      DD  DYNAM
//DDC      DD  DYNAM
//DDD      DD  DYNAM
//DDE      DD  DYNAM
//DDF      DD  DYNAM
//RPFPROF  DD  DISP=SHR,DSN=RPF.PROFILE
@@
//
