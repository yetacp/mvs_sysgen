//UPDTRAKF JOB (FTPD),
//            'FTPD XMI',
//            CLASS=A,
//            MSGCLASS=A,
//            REGION=8M,
//            MSGLEVEL=(1,1),
//            USER=IBMUSER,PASSWORD=SYS1
//SORTU   EXEC PGM=SORT,REGION=512K,PARM='MSG=AP'
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
//SORTIN DD DSN=SYS1.SECURE.CNTL(USERS),DISP=SHR
//       DD *
FTPD     FTPD     EK$VZYHS N                                            00000100
/*
//SORTP   EXEC PGM=SORT,REGION=512K,PARM='MSG=AP'
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
//SORTIN DD DSN=SYS1.SECURE.CNTL(PROFILES),DISP=SHR
//       DD *
FACILITYSVC244                                      FTPD    READ        00002900
FACILITYFTPAUTH                                             NONE        00002210
FACILITYFTPAUTH                                     ADMIN   READ        00002220
/*
//* Reload user/profile tables
//RAKFUSER EXEC RAKFUSER
//RAKFPROF EXEC RAKFPROF