//COPYHLP4 JOB (TSO),
//             'Receive XMI',
//             CLASS=A,
//             MSGCLASS=A,
//             MSGLEVEL=(1,1),
//             USER=IBMUSER,PASSWORD=SYS1
//*
//* DESC: COPY THE TSO HELP MEMBERS OF RPF
//*       THE DATASET REPRESENTED IN //HELPOUT SHOULD
//*       BE A TSO HELP LIBRARY IN //SYSHELP DD STATEMENT IN YOUR
//*       TSO LOGON PROCEDURE.
//*
//STEP01  EXEC PGM=IEBCOPY
//SYSPRINT DD  SYSOUT=*
//HELPIN   DD  DISP=SHR,DSN=SYSGEN.RPF.SRPFHELP
//HELPOUT  DD  DISP=SHR,DSN=SYS2.HELP
//SYSIN    DD  *
 COPY INDD=((HELPIN,R)),OUTDD=HELPOUT
 S M=RPF,RPFED
/*
//
