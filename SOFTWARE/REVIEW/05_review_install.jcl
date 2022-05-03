//RFEINST5 JOB (TSO),
//             'Install Review',
//             CLASS=A,
//             MSGCLASS=A,
//             MSGLEVEL=(1,1),
//             USER=IBMUSER,PASSWORD=SYS1
//*
//*  THIS STEP COPIES THE REVIEW/RFE CLIST MEMBERS INTO SYS1.CMDPROC
//*
//STEP1CLS EXEC PGM=IEBCOPY
//SYSPRINT DD  SYSOUT=*
//SYSUT1   DD  DSN=SYSGEN.REVIEW.CLIST,DISP=SHR
//SYSUT2   DD  DSN=SYS1.CMDPROC,DISP=SHR
//SYSIN    DD  *
  COPY INDD=((SYSUT1,R)),OUTDD=SYSUT2
  COPY INDD=((SYSUT2,R)),OUTDD=SYSUT2
//*
//*  THIS STEP COPIES THE REVIEW/RFE TSO HELP MEMBERS INTO SYS2.HELP
//*
//STEP2HLP EXEC PGM=IEBCOPY
//SYSPRINT DD  SYSOUT=*
//SYSUT1   DD  DSN=SYSGEN.REVIEW.HELP,DISP=SHR
//SYSUT2   DD  DSN=SYS2.HELP,DISP=SHR
//SYSIN    DD  *
  COPY INDD=((SYSUT1,R)),OUTDD=SYSUT2
  COPY INDD=((SYSUT2,R)),OUTDD=SYSUT2
//*
//*  THIS JOB COPIES THE REVIEW/RFE TSO PROGRAMS INTO SYS2.CMDLIB
//*
//STEP3LD  EXEC PGM=IEBCOPY
//SYSPRINT DD  SYSOUT=*
//SYSUT1   DD  DSN=SYSGEN.REVIEW.LOAD,DISP=SHR
//SYSUT2   DD  DSN=SYS2.CMDLIB,DISP=SHR
//SYSIN    DD  *
  COPY INDD=((SYSUT1,R)),OUTDD=SYSUT2
  COPY INDD=((SYSUT2,R)),OUTDD=SYSUT2
//HMVS01   EXEC PGM=IEBGENER
//SYSUT1     DD DATA,DLM=$$
        PROC 0
CONTROL NOMSG,NOLIST,NOSYMLIST,NOCONLIST,NOFLUSH
CLS
WRITE ******************************************-
*************************************
WRITE *                                         -
                                    *
WRITE *                                         -
                                    *
WRITE *                    Welcome to the TSO sy-
stem                                *
WRITE *                    =====================-
====                                *
WRITE *                                         -
                                    *
WRITE *                                         -
                                    *
WRITE ******************************************-
*************************************
REVINIT
RFE
$$
//SYSUT2     DD DSN=HMVS01.CLIST(STDLOGON),DISP=SHR
//SYSPRINT   DD SYSOUT=*
//SYSOUT     DD SYSOUT=*
//SYSIN      DD *
/*