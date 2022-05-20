//IMDATA  JOB (001),'IBMUSER',                             
//             CLASS=A,                                     
//             MSGCLASS=A,                                  
//             MSGLEVEL=(1,1),
//             USER=IBMUSER,PASSWORD=SYS1,                              
//             NOTIFY=IBMUSER                               
//RECV370 EXEC PGM=RECV370                                  
//STEPLIB  DD  DISP=SHR,DSN=SYSC.LINKLIB                    
//XMITIN   DD  UNIT=01C,DCB=(RECFM=FB,LRECL=80,BLKSIZE=80)  
//RECVLOG  DD  SYSOUT=*                                     
//SYSPRINT DD  SYSOUT=*                                     
//SYSIN    DD  DUMMY                                        
//SYSUT1   DD  DSN=&&SYSUT1,                                
//             UNIT=VIO,                                    
//             SPACE=(CYL,(5,1)),                           
//             DISP=(NEW,DELETE,DELETE)                     
//SYSUT2   DD  DSN=SYSGEN.IMON370.DATA,                     
//             UNIT=SYSALLDA,VOL=SER=PUB001,                
//             SPACE=(CYL,(15,2,20),RLSE),                  
//             DISP=(NEW,CATLG,DELETE)                      
//                                                          