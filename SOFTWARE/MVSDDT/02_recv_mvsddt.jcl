//MVSDDTRE  JOB (TSO),
//             'Install DDT Server',
//             REGION=2048K,
//             CLASS=A,
//             MSGCLASS=A,
//             MSGLEVEL=(1,1),
//             USER=IBMUSER,PASSWORD=SYS1
//*
//******************************************************************/
//*                                                                */
//* This JCL will create private load module and macro libraries   */
//* and load the DDT server elements into them. See the comments   */
//* below for information on changes you might wish to make to use */
//* existing libraries instead.                                    */
//*                                                                */
//******************************************************************/
//*
//*
//DDTLMOD  EXEC PGM=IEBCOPY
//******************************************************************/
//*                                                                */
//* This step will allocate and copy the DDT server load modules   */
//* into the PDS specified by the LOADLIB DD. If you choose to use */
//* an existing library, modify the LOADLIB DD accordingly. Note   */
//* that you must still move or copy the DDT SVC module (IGC0023C) */
//* from this library to SYS1.LPALIB.                              */
//*                                                                */
//******************************************************************/
//TAPE     DD   DSN=MVSDDT,UNIT=TAPE,VOL=(,RETAIN,SER=MVSDDT),
//  DISP=(,KEEP)
//LOADLIB  DD   DSN=SYSGEN.DDT.LOAD,UNIT=SYSDA,VOL=SER=PUB001,
//  SPACE=(CYL,(1,0,1)),DISP=(,CATLG)
//SYSPRINT DD   SYSOUT=*
//SYSIN    DD   *
 COPY I=TAPE,O=LOADLIB
/*
//*
//*
//DDTMAC   EXEC PGM=IEBCOPY
//******************************************************************/
//*                                                                */
//* This step will allocate and copy the DDT server macros into    */
//* the PDS specified by the MACLIB DD. If you choose to use an    */
//* existing library, modify the MACLIB DD accordingly. If you do  */
//* do not plan to imbed hard-coded breakpoints in any of your     */
//* code using the DDTBRK macro, you can remove this installation  */
//* step.                                                          */
//*                                                                */
//******************************************************************/
//TAPE     DD   DSN=MVSDDT,UNIT=TAPE,VOL=SER=MVSDDT,
//  LABEL=2,DISP=(,KEEP)
//MACLIB   DD   DSN=SYSGEN.DDT.MACLIB,UNIT=SYSDA,VOL=SER=PUB001,
//  SPACE=(TRK,(2,0,1)),DISP=(,CATLG)
//SYSPRINT DD   SYSOUT=*
//SYSIN    DD   *
 COPY I=TAPE,O=MACLIB
/*
//******************************************************************/
//* COPY THE SVC TO LPALIB                                         */
//******************************************************************/
//COPYSVC  EXEC PGM=IEBCOPY
//LPALIB   DD  DISP=SHR,DSN=SYS1.LPALIB
//DDTLOAD  DD  DISP=SHR,DSN=SYSGEN.DDT.LOAD
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  *
 COPY INDD=((DDTLOAD,R)),OUTDD=LPALIB
 SELECT MEMBER=(IGC0023C)
/*
//******************************************************************/
//* COPY PROGRAMS TO LINKLIB                                       */
//******************************************************************/
//COPYLINK EXEC PGM=IEBCOPY
//LINKLIB   DD  DISP=SHR,DSN=SYS1.LINKLIB
//DDTLOAD   DD  DISP=SHR,DSN=SYSGEN.DDT.LOAD
//SYSPRINT  DD  SYSOUT=*
//SYSIN     DD  *
 COPY INDD=((DDTLOAD,R)),OUTDD=LINKLIB
 SELECT MEMBER=(MVSDDT,DDTSYM,DDT)
/*