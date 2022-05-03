//TESTMVSD  JOB (TSO),
//             'Test DDT Server',
//             REGION=2048K,
//             CLASS=A,
//             MSGCLASS=A,
//             MSGLEVEL=(1,1),
//             USER=IBMUSER,PASSWORD=SYS1
//TEST     EXEC PGM=MVSDDT,PARM=(IEFBR14)
//STEPLIB  DD   DSN=SYS2.LINKLIB,DISP=SHR
//#DDTCMD  DD   UNIT=610
//#DDTDATA DD   UNIT=611
