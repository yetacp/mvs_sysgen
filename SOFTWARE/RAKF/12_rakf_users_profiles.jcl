//RAKFUPST JOB (TSO),
//             'UP',
//             CLASS=S,
//             MSGCLASS=A,
//             REGION=8192K,
//             MSGLEVEL=(1,1),
//             USER=IBMUSER,PASSWORD=SYS1
//*
//* RAKF requires these files be in sorted order
//* we use to do it with GNU sort but it places
//* numbers before alpha which make RAKF upset
//* so we use MVTSORT instead
//*
//SORT    EXEC PGM=SORT,REGION=512K,PARM='MSG=AP'
//STEPLIB DD   DSN=SYSC.LINKLIB,DISP=SHR
//SYSOUT  DD   SYSOUT=A
//SYSPRINT DD  SYSOUT=A
//SORTLIB DD   DSNAME=SYSC.SORTLIB,DISP=SHR
//SORTOUT DD   DSN=SYS1.SECURE.CNTL(USERS),
//             DISP=SHR,DCB=(BLKSIZE=80,RECFM=F)
//SORTWK01 DD  UNIT=2314,SPACE=(CYL,(5,5)),VOL=SER=SORTW1
//SORTWK02 DD  UNIT=2314,SPACE=(CYL,(5,5)),VOL=SER=SORTW2
//SORTWK03 DD  UNIT=2314,SPACE=(CYL,(5,5)),VOL=SER=SORTW3
//SORTWK04 DD  UNIT=2314,SPACE=(CYL,(5,5)),VOL=SER=SORTW5
//SORTWK05 DD  UNIT=2314,SPACE=(CYL,(5,5)),VOL=SER=SORTW6
//SYSIN  DD    *
 SORT FIELDS=(1,80,CH,A)
 RECORD TYPE=F,LENGTH=(80)
 END
/*
//SORTIN DD *
HMVS01   ADMIN   *CUL8TR   Y                                            00000100
HMVS01   RAKFADM  CUL8TR   Y                                            00000200
HMVS02   USER     PASS4U   N                                            00000300
IBMUSER  ADMIN   *SYS1     Y                                            00000400
IBMUSER  RAKFADM *SYS1     Y                                            00000500
/*
//SORT    EXEC PGM=SORT,REGION=512K,PARM='MSG=AP'
//STEPLIB DD   DSN=SYSC.LINKLIB,DISP=SHR
//SYSOUT  DD   SYSOUT=A
//SYSPRINT DD  SYSOUT=A
//SORTLIB DD   DSNAME=SYSC.SORTLIB,DISP=SHR
//SORTOUT DD   DSN=SYS1.SECURE.CNTL(PROFILES),
//             DISP=SHR,DCB=(BLKSIZE=80,RECFM=F)
//SORTWK01 DD  UNIT=2314,SPACE=(CYL,(5,5)),VOL=SER=SORTW1
//SORTWK02 DD  UNIT=2314,SPACE=(CYL,(5,5)),VOL=SER=SORTW2
//SORTWK03 DD  UNIT=2314,SPACE=(CYL,(5,5)),VOL=SER=SORTW3
//SORTWK04 DD  UNIT=2314,SPACE=(CYL,(5,5)),VOL=SER=SORTW5
//SORTWK05 DD  UNIT=2314,SPACE=(CYL,(5,5)),VOL=SER=SORTW6
//SYSIN  DD    *
 SORT FIELDS=(1,80,CH,A)
 RECORD TYPE=F,LENGTH=(80)
 END
/*
//SORTIN DD *
DASDVOL *                                                   READ        00000100
DASDVOL *                                           ADMIN   ALTER       00000200
DASDVOL *                                           STCGROUPALTER       00000300
DATASET *                                                   READ        00000400
DATASET *                                           ADMIN   ALTER       00000500
DATASET *                                           STCGROUPALTER       00000600
DATASET RPF.V1R5M3.SRPFPROF                                 UPDATE      00000700
DATASET SYS1.BRODCAST                                       UPDATE      00000800
DATASET SYS1.DUPLEX                                         NONE        00000900
DATASET SYS1.PAGECSA                                        NONE        00001000
DATASET SYS1.PAGELPA                                        NONE        00001100
DATASET SYS1.PAGEL01                                        NONE        00001200
DATASET SYS1.PAGEL02                                        NONE        00001300
DATASET SYS1.PAGES01                                        NONE        00001400
DATASET SYS1.SECURE.*                                       NONE        00001500
DATASET SYS1.SECURE.*                               ADMIN   NONE        00001600
DATASET SYS1.SECURE.*                               RAKFADM UPDATE      00001700
DATASET SYS1.STGINDEX                                       NONE        00001800
DATASET SYS1.UCAT.TSO                                       UPDATE      00001900
FACILITYDIAG8                                               NONE        00002000
FACILITYDIAG8                                       ADMIN   READ        00002100
FACILITYDIAG8                                       STCGROUPREAD        00002200
FACILITYRAKFADM                                             NONE        00002300
FACILITYRAKFADM                                     ADMIN   NONE        00002400
FACILITYRAKFADM                                     RAKFADM READ        00002500
FACILITYRAKFADM                                     STCGROUPREAD        00002600
FACILITYSVC244                                              NONE        00002700
FACILITYSVC244                                      ADMIN   READ        00002800
FACILITYSVC244                                      STCGROUPREAD        00002900
TAPEVOL *                                                   READ        00003000
TAPEVOL *                                           ADMIN   ALTER       00003100
TAPEVOL *                                           STCGROUPALTER       00003200
TERMINAL*                                                   READ        00003300
/*