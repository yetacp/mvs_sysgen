//BREXXINS JOB (TSO),
//             'Receive XMI',
//             CLASS=A,
//             MSGCLASS=A,
//             MSGLEVEL=(1,1),
//             USER=IBMUSER,PASSWORD=SYS1
//* Do not modify this JCL file, modify the .template file
//* ------------------------------------------------------------------
//* COPY BREXX MODULE(S) INTO SYS2.LINKLIB
//* ------------------------------------------------------------------
//STEP10  EXEC  PGM=IEBCOPY
//SYSPRINT  DD  SYSOUT=*
//DDIN      DD  DSN=BREXX.LINKLIB,DISP=SHR
//DDOUT     DD  DSN=SYS2.LINKLIB,DISP=SHR
//SYSIN     DD  *
  COPY INDD=((DDIN,R)),OUTDD=DDOUT
/*
//* ------------------------------------------------------------------
//* COPY BREXX MODULE(S) INTO SYS2.PROCLIB
//* ------------------------------------------------------------------
//STEP20  EXEC  PGM=IEBCOPY
//SYSPRINT  DD  SYSOUT=*
//DDIN      DD  DSN=BREXX.PROCLIB,DISP=SHR
//DDOUT     DD  DSN=SYS2.PROCLIB,DISP=SHR
//SYSIN     DD  *
  COPY INDD=((DDIN,R)),OUTDD=DDOUT
/*