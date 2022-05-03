//RECVFTPD JOB (FTPD),
//            'FTPD XMI',
//            CLASS=A,
//            MSGCLASS=A,
//            REGION=8M,
//            MSGLEVEL=(1,1),
//            USER=IBMUSER,PASSWORD=SYS1
//FTDELETE EXEC PGM=IDCAMS,REGION=1024K
//SYSPRINT DD  SYSOUT=A
//SYSIN    DD  *
 DELETE SYSGEN.FTPD.LOADLIB NONVSAM SCRATCH PURGE
 DELETE SYS2.PROCLIB(FTPD)
 DELETE SYS2.LINKLIB(FTPD)
 DELETE SYS2.LINKLIB(FTPDXCTL)
 /* IF THERE WAS NO DATASET TO DELETE, RESET CC           */
 IF LASTCC = 8 THEN
   DO
       SET LASTCC = 0
       SET MAXCC = 0
   END
/*
//* RECV370 DDNAMEs:
//* ----------------
//*
//*     RECVLOG    RECV370 output messages (required)
//*
//*     RECVDBUG   Optional, specifies debugging options.
//*
//*     XMITIN     input XMIT file to be received (required)
//*
//*     SYSPRINT   IEBCOPY output messages (required for DSORG=PO
//*                input datasets on SYSUT1)
//*
//*     SYSUT1     Work dataset for IEBCOPY (not needed for sequential
//*                XMITs; required for partitioned XMITs)
//*
//*     SYSUT2     Output dataset - sequential or partitioned
//*
//*     SYSIN      IEBCOPY input dataset (required for DSORG=PO XMITs)
//*                A DUMMY dataset.
//*
//RECV370 EXEC PGM=RECV370
//STEPLIB  DD  DISP=SHR,DSN=SYSC.LINKLIB
//XMITIN   DD  UNIT=01C,DCB=(RECFM=FB,LRECL=80,BLKSIZE=80)
//RECVLOG  DD  SYSOUT=*
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  DUMMY
//* Work temp dataset
//SYSUT1   DD  DSN=&&SYSUT1,
//             UNIT=VIO,
//             SPACE=(CYL,(5,1)),
//             DISP=(NEW,DELETE,DELETE)
//* Output dataset
//SYSUT2   DD  DSN=SYSGEN.FTPD.LOADLIB,
//             UNIT=SYSALLDA,VOL=SER=PUB001,
//             SPACE=(CYL,(15,2,20),RLSE),
//             DISP=(NEW,CATLG,DELETE)
//*
//* Copy FTPD/FTPDXCTL to SYS2.LINKLIB
//*
//STEP2CPY EXEC PGM=IEBCOPY
//SYSPRINT DD  SYSOUT=*
//SYSUT1   DD  DSN=SYSGEN.FTPD.LOADLIB,DISP=SHR
//SYSUT2   DD  DSN=SYS2.LINKLIB,DISP=SHR
//SYSIN    DD  *
  COPY INDD=((SYSUT1,R)),OUTDD=SYSUT2
/*
//*
//* Add FTPD to SYS2.PROCLIB
//*
//FTPDPROC EXEC PGM=IEBGENER
//SYSUT1   DD DATA,DLM=@@
//FTPD   PROC
//********************************************************************
//*
//* MVS3.8j RAKF Enabled FTP server PROC
//* To use: in Hercules console issue /s FTPD to start FTP server
//*
//* To change settings edit config file SYS1.PARMLIB(FTPDPM00)
//*
//********************************************************************
//FTPD   EXEC PGM=FTPDXCTL,TIME=1440,REGION=4096K,
// PARM='DD=AAINTRDR'
//AAINTRDR DD SYSOUT=(A,INTRDR),DCB=(RECFM=FB,LRECL=80,BLKSIZE=80)
//STDOUT   DD SYSOUT=*
@@
//SYSUT2   DD DISP=SHR,DSN=SYS2.PROCLIB(FTPD)
//SYSPRINT DD SYSOUT=*
//SYSIN    DD DUMMY
//* Adds FTPDPARM
//FTPDPARM EXEC PGM=IEBGENER
//SYSUT1   DD DATA,DLM=@@
//FTPDPARM PROC SRVPORT='2121',AUTHUSR='IBMUSER'
//********************************************************************
//*
//* MVS3.8j RAKF Enabled FTP server PROC with custom arguments
//* To use: in Hercules console issue
//*    /s FTPDPARM,srvport=54321,srvip=10.10.10.10
//*
//********************************************************************
//FTPD   EXEC PGM=FTPDXCTL,TIME=1440,REGION=4096K,
// PARM='SRVPORT=&SRVPORT DD=AAINTRDR AUTHUSR=&AUTHUSR'
//AAINTRDR DD SYSOUT=(A,INTRDR),DCB=(RECFM=FB,LRECL=80,BLKSIZE=80)
//STDOUT   DD SYSOUT=*
@@
//SYSUT2   DD DISP=SHR,DSN=SYS2.PROCLIB(FTPDPARM)
//SYSPRINT DD SYSOUT=*
//SYSIN    DD DUMMY
//*
//* Add FTPDPM00 to SYS1.PARMLIB
//*
//FTPDDEVC EXEC PGM=IEBGENER
//SYSUT1   DD DATA,DLM=@@
# FTPD Configuration file
# These settings are used by the FTP server
# Each setting may be overridden by using an equivalent PARM in the
# FTPDPARM PROC as desribed in the README.
#  S FTPDPARM,SRVPORT=12345
# Or directly in JCL:
#  //FTPD EXEC PGM=FTPDXCTL,
#  // PARM='SRVPORT=21021'
#
# To use a custom configuration file use the argument PARMLIB=
#  //FTPD EXEC PGM=FTPDXCTL,
#  // PARM='PARMLIB=SYS2.PARMLIB(FTPDPARM)'
#
# The default parmlib location is SYS1.PARMLIB(FTPDPM00)
#
######################
#      Settings      #
######################
#
# These settings can be in any order, including the DASD
#
# SRVPORT - The port that the FTPD server will listen on.
SRVPORT=2121
# SRVIP - The IP address of the hercules host machine to listen on.
#         The default is 'any' which is the equivalent of 'all' or
#         '0.0.0.0'.
SRVIP=ANY
# PASVADR - IP address to return for passive mode, comma separated. The
#           default is '127,0,0,1'. This address is used only if
#           getsockname doesnt return a suitable value.
PASVADR=127,0,0,1
# FAST - Uncomment this line to enable Library Optimisation Extensions
#FAST=TRUE
# The AUTHUSER can stop ftp daemon from a client session using
# the "quote term" or 'quote terminate' FTP client command.
AUTHUSER=IBMUSER
# The FTP server will scan and read the VTOC of the following
# DASD. The format is 'SERIAL,UNIT COMMENT'. You can copy the
# the devices from SYS1.PARMLIB(VATLST00) and edit them to match
# the entries below.
MVSRES,3350         SYSTEM RESIDENCE (PRIVATE)
MVS000,3350         SYSTEM DATASETS (PRIVATE)
PUB000,3380         PUBLIC DATASETS (PRIVATE)
PUB001,3390         PUBLIC DATASETS (PRIVATE)
SYSCPK,3350         COMPILER/TOOLS (PRIVATE)
@@
//SYSUT2   DD DISP=SHR,DSN=SYS1.PARMLIB(FTPDPM00)
//SYSPRINT DD SYSOUT=*
//SYSIN    DD DUMMY

