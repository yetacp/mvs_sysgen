//BLKDISK JOB (TSO),
//             'Install SYS2 MACLIB',
//             CLASS=A,
//             MSGCLASS=A,
//             MSGLEVEL=(1,1),
//             USER=IBMUSER,
//             PASSWORD=SYS1
//*  ------ ------------------------------------------------------
//*  STEP     COMMENTS
//*  ------ ------------------------------------------------------
//* (INSTALL)
//*  ASM     ASSEMBLES BLKDISK (IEV90 OR IFOX00 MAY BE USED)
//*  LINK    LINKS BLKDISK INTO 'SYS1.CMDLIB(BLKDISK)'
//*          WITH ALIASES:  BLK23051, BLK23052, BLK2314,
//*                         BLK3330,  BLK33301, BLK3340,
//*                         BLK3350,  BLK3375,  BLK3380,
//*                         BLK3390,  BLK9345.
//* (BCOPY)
//*  COPY    COPIES BLKDISK HELP TO 'SYSE.HELP(BLKDISK)'
//*          USING IEBGENER AND SHARED ALLOCATION
//*          NOTE: SEE HELP INSTRUCTIONS BEFORE  //COPY.SYSUT1
//* (BXEQ)
//*  XEQ     EXECUTES THE ALIASES OF BLKDISK IN THE BACKGROUND
//*
//*
//*   BLKDISK VERSION 2.0:
//*               THE NAME BY WHICH THIS COMMAND PROCESSOR IS
//*               INVOKED DETERMINES THE DEVICE TYPE TO BE USED.
//*
//*               THIS COMMAND PROCESSOR USES PUTLINE OUTPUT --
//*               IT CAN BE USED AS A TSO COMMAND PROCESSOR OR
//*               IN BATCH MODE (SEE STEP XEQ).
//*
//*               THIS COMMAND PROCESSOR WILL USUALLY RECOMMEND A
//*               BLOCKSIZE NEAR A HALF-TRACK FIGURE FOR A GIVEN
//*               DEVICE.  IF THIS VIOLATES LOCAL GUIDELINES OR
//*               STANDARDS, THE PROGRAM (AND THE HELP TEXT) COULD
//*               BE CHANGED TO RECOMMEND THE LARGEST BLOCKSIZE
//*               FOR A LRECL BELOW A CERTAIN FIGURE (FOR EXAMPLE,
//*               6233 BYTES IS A COMMONLY USED MAXIMUM BLOCKSIZE).
//*
//INSTALL PROC
//ASM     EXEC PGM=IFOX00,REGION=2048K,
//             PARM=(DECK,NOOBJECT,NORLD,TERM,'XREF(SHORT)')
//SYSLIB   DD  DSN=SYS1.AMODGEN,DISP=SHR
//         DD  DSN=SYS1.MACLIB,DISP=SHR
//SYSUT1   DD  UNIT=VIO,SPACE=(CYL,(10,5))
//SYSUT2   DD  UNIT=VIO,SPACE=(CYL,(10,5))
//SYSUT3   DD  UNIT=VIO,SPACE=(CYL,(10,5))
//SYSPUNCH DD  UNIT=SYSDA,SPACE=(TRK,(5,5)),DISP=(,PASS),DSN=&&X,
//         DCB=BLKSIZE=3120
//SYSPRINT DD  SYSOUT=*
//SYSTERM  DD  SYSOUT=*
//LINK    EXEC PGM=IEWL,PARM='MAP',COND=(5,LT)
//SYSPRINT DD  SYSOUT=*
//SYSLMOD  DD  DISP=SHR,DSN=SYS2.CMDLIB
//SYSLIN   DD  DSN=&&X,DISP=(OLD,DELETE)
//SYSUT1   DD  UNIT=VIO,SPACE=(TRK,(5,5))
//         PEND
//**
//BCOPY   PROC  MEMBER='YOU.FORGOT.THE.MEMBER'
//COPY   EXEC PGM=IEBGENER
//SYSPRINT DD SYSOUT=*
//SYSUT2   DD  DISP=SHR,DSN=SYS2.HELP(&MEMBER)
//SYSIN    DD  DUMMY
//         PEND
//**
//BXEQ   PROC
//XEQ   EXEC  PGM=IKJEFT01,DYNAMNBR=30
//SYSTSPRT DD SYSOUT=*
//        PEND
//*
//*
//A       EXEC INSTALL       MEMBER=BLKDISK, ALIAS=(BLK3380,BLK3390)
//ASM.SYSIN DD *
BLKDISK TITLE ' DISK BLOCKSIZE PROGRAM VERSION 2.0   --   BRUCE LELAND'
*  DATA SET BLKDISK AT LEVEL 2.0 AS OF 8/18/82 (ASSEMBLER SOURCE)     *
*  DATA SET BLK3330 AT LEVEL 1.0 AS OF 1/03/78 (PL/I SOURCE)          *
*                                                                     *
*  PROGRAMMER:  A. BRUCE LELAND                                       *
*                                                                     *
*  DESCRIPTION:  THIS PROGRAM COMPUTES AN "OPTIMAL" BLOCKSIZE FOR     *
*      A DISK OR DRUM DATA SET GIVEN THE LOGICAL RECORD LENGTH.       *
*      INPUTS INCLUDE THE LRECL AND OPTIONALLY ANY OF THE             *
*      FOLLOWING:                                                     *
*      A.  A KEY LENGTH (ZERO, FOR NO KEY, IS THE DEFAULT)            *
*      B.  THE NUMBER OF RECORDS IN THE DATA SET (USED FOR AN         *
*          ALLOCATION COMPUTATION -- 100,000 IS THE DEFAULT)          *
*      C.  THE BLOCKSIZE TO USE FOR THE ALLOCATION COMPUTATION        *
*          (THE RECOMMENDED BLOCKSIZE VALUE IS THE DEFAULT)           *
*      D.  WHETHER OR NOT TO PROVIDE A TRACK CAPACITY REPORT          *
*      E.  WHETHER OR NOT TO VERIFY RESULTS AGAINST "TRKCALC"         *
*                                                                     *
*  SUPPORTED DEVICES:  THE NAME BY WHICH THIS COMMAND PROCESSOR       *
*      IS INVOKED DETERMINES THE DEVICE TYPE TO BE USED.              *
*                                                                     *
*      THE FIRST THREE CHARACTERS OF THE COMMAND NAME (USUALLY        *
*      "BLK") ARE IGNORED; THE REMAINING FOUR OR FIVE CHARACTERS      *
*      ARE COMPARED AGAINST A TABLE OF SUPPORTED DEVICES IN THE       *
*      PROGRAM.  THE VALID ALIAS NAMES FOR THE PROGRAM INCLUDE        *
*      THE FOLLOWING:                                                 *
*      A.  BLK23051  (FOR 2305-1 DRUMS)                               *
*      B.  BLK23052  (FOR 2305-2 DRUMS)                               *
*      C.  BLK2314   (FOR 2314 DISKS)                                 *
*      D.  BLK3330   (FOR 3330 DISKS)                                 *
*      E.  BLK33301  (FOR 3330 MODEL 11 DISKS)                        *
*      F.  BLK3340   (FOR 3340 DISKS)                                 *
*      G.  BLK3350   (FOR 3350 DISKS)                                 *
*      H.  BLK3375   (FOR 3375 DISKS)                                 *
*      I.  BLK3380   (FOR 3380 DISKS)                                 *
*      J.  BLK3390   (FOR 3390 DISKS)  (SEE BELOW - 12 MAR 90)        *
*      K.  BLK9345   (FOR 9345 DISKS)  (SEE BELOW - 6 JULY 93)        *
*                                                                     *
*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
*                                                                     *
* PLEASE REPORT ANY PROBLEMS, ENHANCEMENTS, SUGGESTIONS OR COMMENTS   *
* CONCERNING THIS PROGRAM TO:                                         *
*                                                                     *
*     A. BRUCE LELAND           OR         A. BRUCE LELAND            *
*     SERENA INTERNATIONAL                 1103 KENDAL COURT          *
*     500 AIRPORT BLVD. 2ND FLOOR          SAN JOSE, CALIF 95120      *
*     BURLINGAME, CA  94010                                           *
*     (415) 696-1800                       HOME (408) 997-2366        *
*     INTERNET: BRUCE_LELAND@SERENA.COM                               *
*                                                                     *
*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
*                                                                     *
* CHANGES: (12 MARCH 1990)                                            *
*     ADDED CODE TO SUPPORT 3390 DISKS. (DAVE GREENE, KWASHA LIPTON,  *
*      2100 NORTH CENTRAL ROAD, FORT LEE, NJ 07024)                   *
*                                                                     *
*     SUMMARY OF CHANGES:                                             *
*        A.  CODE IN 'MAXTRIAL' USES A TABLE FOR MAXIMUM BLOCKSIZES,  *
*            SINCE OVERHEAD IS NOT LINEAR.  NOT ELEGANT, BUT IT WORKS.*
*           (OUR 3390 MANUALS AT THIS TIME ARE SPARSE AND INCOMPLETE.)*
*            'DEVOKEY' AND 'DEVNOKEY' ARE '0' FOR 3390 IN             *
*            'UNITTBL' FOR 3390 (THEY ARE NOT USED IN THE CALCULATIONS*
*            IN THIS PROGRAM).                                        *
*        B.  'MAXBLOCK' USES THE VALUE OF 56,664 (MAXIMUM BLOCKSIZE   *
*            WITHOUT KEYS) REGARDLESS OF KEYLENGTH VALUE.  THIS IS    *
*            THE VALUE IBM SEEMS TO USE IN SC26-4574-0, 'USING IBM    *
*            3390 DIRECT ACCESS STORAGE IN AN MVS ENVIRONMENT',       *
*            APPENDIX B, FOR CALCULATING 'PERCENT SPACE USED'.        *
*        C.  THE 'TRKSUMM NOCYLS' WAS INCREASED BY 2 BYTES (BECAUSE   *
*            3390 HAS OVER 999 CYLINDERS PER VOLUME).                 *
*        D.  'TRKCALC' (VERIFY) ERROR MESSAGE IF DEVICE IS NOT        *
*            GENNED ON YOUR SYSTEM.  'VERIFY' IS THEN TURNED OFF FOR  *
*            REMAINDER OF COMMAND PROCESSING.                         *
*                                                                     *
* CHANGES: (10 MAY 1991)                                              *
*     FOR SOME LARGE LRECL VALUES (SAY IN THE 8000-10000 RANGE),      *
*      THE RECOMMENDED VALUE WOULD BE A BLOCKING FACTOR GREATER THAN  *
*      ONE (1), WHEN IN FACT A BLOCKING FACTOR OF ONE (1), I.E.       *
*      UNBLOCKED, WOULD MORE EFFICIENTLY UTILIZE THE TRACK.           *
*                                                                     *
* CHANGES: (04 NOV 1991)                                              *
*     FOR 3390S, THE DEFAULT 'KEYLEN' IS 0.  HOWEVER, IF 'KEYLEN(0)'  *
*      WAS SPECIFIED, IT WAS NOT PROCESSED CORRECTLY.  FIX WAS MADE   *
*      TO HANDLE CORRECTLY.                                           *
*                                                                     *
* CHANGES: (18 DEC 1992)                                              *
*     GLOBALIZE THE INITIAL CLEAR SCREEN - GP@FT                      *
*                                                                     *
* CHANGES: (6 JULY 1993)                                              *
*     ADDED CODE SIMILAR TO 3390 SUPPORT FOR 9345 DISKS - ABL)        *
*                                                                     *
*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
         EJECT
         MACRO
&NAME    MSG   &TEXT
&NAME    LA    R1,&TEXT
         LA    R15,L'&TEXT+4
         BAL   R14,$PUTLINE
         MEND
         SPACE 3
         MACRO
&NAME    EDIT  &REG,&LENGTH,&OUT,&DIGITS,&EQUAL=NO
&NAME    CVD   &REG,DOUBLE
         MVC   &OUT.(&LENGTH),EDITPIC+15-&LENGTH
         ED    &OUT-1(&LENGTH+1),DOUBLE+8-(&DIGITS+1)/2
         AIF   ('&EQUAL' EQ 'NO').MEND
         MVI   &OUT-1,C'='
         SPACE 1
BND&SYSNDX CLI &OUT,X'40'            BLANK?
         BNE   BCP&SYSNDX              NO, DONE
         MVC   &OUT.(&LENGTH),&OUT+1   YES, SLIDE CHARACTERS DOWN 1
         B     BND&SYSNDX              LOOP UNTIL FIRST NON-BLANK
BCP&SYSNDX DS  0H
.MEND    MEND
         SPACE 3
         MACRO
&NAME    PCENT &OUT
&NAME    M     R0,=F'1000'
         A     R1,MAXROUND
         D     R0,MAXBLOCK
         CVD   R1,DOUBLE
         MVC   &OUT+0(7),=X'202021204B206C'
         ED    &OUT-1(7),DOUBLE+5
         MEND
         EJECT
BLKDISK  CSECT
         PRINT NOGEN
         SAVE  (14,12),,*
R0       EQU   0
R1       EQU   1
R2       EQU   2
R3       EQU   3
R4       EQU   4
R5       EQU   5
R6       EQU   6
R7       EQU   7
R8       EQU   8
R9       EQU   9
R10      EQU   10
R11      EQU   11
R12      EQU   12
R13      EQU   13
R14      EQU   14
R15      EQU   15
         LR    R11,R15
         LA    R12,2048
         LA    R12,2048(R11,R12)
         USING BLKDISK,R11,R12
         ST    R13,SAVE+4
         LR    R9,R13
         LA    R13,SAVE
         ST    R13,8(,R9)
         LR    R10,R1
         USING CPPL,R10
         SPACE 2
         L     R1,CPPLECT            ECT ADDRESS
         USING ECT,R1
         SPACE 2
***
***      FIND THE DEVICE TYPE FOR THIS INVOCATION
***
         SPACE 1
         LA    R15,UNITTBL-DEVENTL
NEXTUNIT LA    R15,DEVENTL(,R15)
         CLI   0(R15),X'FF'          END OF TABLE?
         BE    NOUNIT                YES, BRANCH
         CLC   0(5,R15),ECTPCMD+3    THIS UNIT NAME?
         BNE   NEXTUNIT              NO, BRANCH
         B     FOUNDUNI              YES, BRANCH
         SPACE 1
NOUNIT   MSG   ERRUNIT               UNIT NOT SUPPORTED
         B     RC12                  TERMINATE
         DROP  R1
         SPACE 1
FOUNDUNI MVC   DEVNAME(DEVENTL),0(R15)
************************************************************
*                                                          *
*        PROCESS 'PDSCALL' KEYWORD                         *
*                                                          *
************************************************************
         SPACE 1
         L     R1,CPPLCBUF           GET ADDRESS OF CBUF
         LH    R14,0(,R1)            GET THE LENGTH
         LA    R1,0(R14,R1)          POINT TO PDSCALL, MAYBE
         CLC   2(7,R1),=C'PDSCALL'   DID PDS CALL US?
         BNE   NOPDSCAL              NO
         MVC   PDSMSGA,10(R1)        MOVE THE ADDRESS
         MVC   PUTLCALL,=F'128'      NULLIFY SPACING BETWEEN SCREENS
NOPDSCAL EQU   *
         SPACE 3
***
***      INVOKE PARSE
***
         SPACE 1
         LA    R1,MYPPL
         USING PPL,R1
         MVC   PPLUPT(4),CPPLUPT
         MVC   PPLECT(4),CPPLECT
         LA    R0,MYECB
         ST    R0,PPLECB
         L     R0,=A(BLKPCL)
         ST    R0,PPLPCL
         LA    R0,MYANS
         ST    R0,PPLANS
         MVC   PPLCBUF(4),CPPLCBUF
         DROP  R1
         SPACE 2
         L     R15,16              CVTPTR
         L     R15,X'20C'(,R15)    CVTPARS
         BALR  R14,R15             CALL IKJPARS
         LTR   R15,R15
         BNZ   RC12
         SPACE 2
         L     R9,MYANS
         USING IKJPARMD,R9
         EJECT
***
***      PROCESS PARSE RESULTS
***
         SPACE 1
         LH    R15,LRE+4
         S     R15,=F'1'
         L     R1,LRE
PACKNUM  PACK  DOUBLE(8),0(*-*,R1)  <<EXECUTED>>
         EX    R15,PACKNUM
         CVB   R1,DOUBLE
         ST    R1,LRECL
         LTR   R1,R1               ANY BYTES IN THE RECORD?
         BP    NOLRE               YES, BRANCH
         CLI   TRACKKW+1,1         TRACK CAPACITY REPORT REQUESTED?
         BE    NOLRE               YES, BRANCH
         MSG   ERRNULL             NO, ERROR MESSAGE
         B     RC12                    AND QUIT
         SPACE 1
NOLRE    DS    0H
         XC    KEY3390,KEY3390     ZERO THIS
         LH    R15,KEY+4
         S     R15,=F'1'
         BM    NOKEY
         L     R1,KEY
         EX    R15,PACKNUM
         CVB   R1,DOUBLE
         ST    R1,KEYLEN
         C     R1,=F'255'          KEY LENGTH<256
         BNH   KEYINDX             YES, BRANCH
         MSG   ERRKEY              NO, ERROR
         B     RC12
         SPACE 1
CHKINDX  CLI   0(R15),*-*
KEYINDX  DS    0H
         CLC   DEVTYPE,TYPE9345    CHECK IF 9345
         BE    KEYIN00             YES, BRANCH
         CLC   DEVTYPE,TYPE3390    CHECK IF 3390
         BNE   NOKEY               BR IF NOT
* CALCULATE TBL3390 COLUMN INDEX FOR 3390 KEYLENGTH
* NOTE - FROM ABOVE TEST, KEY LENGTH < 256
* (WE COULD USE A TRANSLATE TABLE TO ACCOMPLISH THIS)
KEYIN00  LTR   R1,R1               CHECK FOR KEYLEN=0
         BNP   NOKEY               BR IF YES
         L     R0,=F'1'            INITIALIZE INDEX VALUE
         LA    R15,KDX3390         ADDRESS THE TABLE
KEYIN10  DS    0H
         EX    R1,CHKINDX          COMPARE R1 W/ HIGH RANGE KEY VALUE
         BNL   KEYIN20             BR IF RANGE FOUND
         LA    R15,1(,R15)         BUMP TO NEXT TABLE ENTRY
         A     R0,=F'1'            INCREMENT INDEX VALUE
         B     KEYIN10             CONTINUE
KEYIN20  DS    0H
         STH   R0,KEY3390          STORE THE INDEX VALUE
NOKEY    LH    R15,REC+4
         S     R15,=F'1'
         BM    NOREC
         L     R1,REC
         EX    R15,PACKNUM
         CVB   R1,DOUBLE
         ST    R1,RECNUM
         SPACE 1
NOREC    LH    R15,BLK+4
         S     R15,=F'1'
         BM    NOBLK
         L     R1,BLK
         EX    R15,PACKNUM
         CVB   R1,DOUBLE
         ST    R1,USEBLK
         SPACE 3
***
***      CLEAR THE SCREEN (IF IT IS 24X80 OR 27X132)
***                       (OR ANYTHING ELSE - GP@FT)
***                       (AND NOT CALLED BY PDSTOOLS - ABL)
         SPACE 1
NOBLK    DS    0H
         ICM   R15,15,PDSMSGA   DO NOT ISSUE A TPUT
         BNZ   MAXTRACK         IF INVOKED VIA PDSCALL(NN) KEYWORD
         STLINENO LINE=1        CLEAR ANY 3270 SCREEN          GP@FT
         EJECT
***
***      CALCULATE MAXIMUM TRACK CAPACITY FOR THIS KEYLENGTH
***
         SPACE 1
***   NOTE: THE TRACK CAPACITY TABLE IS COMPUTED BY GUESSING AT THE
***         MAXIMUM BLOCKSIZE FOR EACH OF THE 17 BLOCKING FACTORS
***         (IN TURN) AND CALLING DEVCALC UNTIL THE BLOCKSIZE IS
***         DECREMENTED TO THE CORRECT VALUE FOR THE BLOCKING FACTOR.
***
*     NOTE: FOR 3390 AND 9345, MAX. TRACK CAPACITY IS DERIVED FROM A
*             TABLE.  IT IS NOT ELEGANT.  THE OVERHEAD FOR VARIOUS
*             KEYLENGTHS AND BLOCKING FACTORS IS NOT LINEAR.  WHEN
*             THERE IS TIME (AND WE HAVE SOME ADDITIONAL 3390 MANUALS),
*             A CALCULATION COULD BE USED, PERHAPS, INSTEAD OF A TABLE
*             LOOKUP.
         SPACE 1
MAXTRACK LA    R3,18                  CALCULATE TRACK CAPACITY
         LA    R6,SAVEMAX-4           MAXIMUM BLOCKSIZE ARRAY -4
MAXLOOP  S     R3,=F'1'               BLOCKS/TRACK -- ZERO REACHED?
         BNP   MAXDONE                YES, BRANCH
         A     R6,=F'4'               NEXT MAX CELL
         CLC   DEVTYPE,TYPE3390       CHECK IF 3390
         BE    MAX3390                BR IF YES
         CLC   DEVTYPE,TYPE9345       CHECK IF 9345
         BE    MAX3390                BR IF YES
         LH    R1,DEVOKEY             ASSUME KEYED FILE
         CLI   KEYLEN+3,0             CORRECT?
         BH    MAXLOOPA               YES, BRANCH
         SH    R1,DEVNOKEY            NO, LESS KEY OVERHEAD AMOUNT
MAXLOOPA A     R1,KEYLEN              PLUS THE KEY LENGTH
         MR    R0,R3                  ACCUMULATED OVERHEAD
         SR    R5,R5
         ICM   R5,3,DEVTRACK          MAXIMUM TRACK SIZE
         SR    R5,R1                  ESTIMATED BYTES LEFT FOR RECORDS
         SR    R4,R4
         DR    R4,R3                  ESTIMATED MAXIMUM BLOCKSIZE
         CLI   VERIFYKW+1,1           VERIFY?
         BNE   MAXTRIAL               NO, BRANCH
         A     R5,=F'1'               YES, USE ONE HIGHER
         B     MAXTRIAL               CONTINUE
         SPACE 2
MAX3390  DS    0H
         LR    R15,R3                 FETCH BLOCKING FACTOR
         SH    R15,=H'1'              REDUCE BY 1
         SLR   R14,R14                CLEAR
         M     R14,TB3390RL           MULTIPLY BY ROW LENGTH
         LH    R14,KEY3390            FETCH KEYLENGTH INDEX
         SLL   R14,TB3390IT/2         MULTIPLY BY LENGTH OF ITEM
         ALR   R15,R14                COMPUTE INDEX TO MAX BLKSIZE
         L     R14,=A(TBL3390)        ADDRESS THE TABLE
         CLC   DEVTYPE,TYPE9345       9345?
         BNE   MX3390AA               NO, BRANCH
         L     R14,=A(TBL9345)        ADDRESS THE TABLE
MX3390AA ALR   R14,R15                ADDRESS THE BLKSIZE
         SLR   R5,R5                  CLEAR R5
         ICM   R5,TB3390IC,0(R14)     FETCH MAX. BLKSIZE
         CLI   VERIFYKW+1,1           CHECK FOR VERIFY
         BNE   MAXTRL50               BR IF NOT
         LR    R1,R5                  MOVE VALUE TO R1
         OI    FLG3390,MXT3390        INDICATE CALLER
MX3390TA DS    0H
         A     R1,=F'1'               BUMP BLKSIZE BY 1
         ST    R1,0(,R6)              SAVE OVER CALL
         BAL   R14,DEVTRKCX           DO TRKCALC
         TM    FLG3390,NODEVG         MAYBE DEVICE NOT GENNED
         BNZ   MAXTRL50               EXIT IF NOT
         L     R1,TRKCALCN
         A     R1,=F'1'               COUNT CALLS TO TRKCALC
         ST    R1,TRKCALCN
         L     R1,0(,R6)              RESTORE BLKSIZE
*  FOR BLOCKING FACTOR = 1, R15 ^= 0 CAN BE EXPECTED.
         LTR   R15,R15                CHECK RETURN CODE
         BNZ   MX3390TC               BR IF NOT ZERO
         CR    R0,R3                  CHECK BLOCKING FACTOR
         BE    MX3390TA               SAME, BUMP IT UP
         BL    MX3390TC               BR IF LOW
*  BLOCKING FACTOR HIGH, SHOULD NOT HAPPEN.
*  TABLE MUST REALLY BE OFF, BETTER CHECK IT.
         MSG   ER3390CK               ISSUE ERROR MESSAGE
         LR    R2,R0                  FETCH R0
         ABEND 25,DUMP                QUIT
MX3390TC DS    0H
         S     R1,=F'1'               REDUCE BLKSIZE BY 1
         ST    R1,0(,R6)              SAVE OVER CALL
         BAL   R14,DEVTRKCX           DO TRKCALC
         L     R1,TRKCALCN
         A     R1,=F'1'               COUNT CALLS TO TRKCALC
         ST    R1,TRKCALCN
         L     R1,0(,R6)              RESTORE BLKSIZE
         LTR   R15,R15                CHECK RETURN CODE
         BNZ   MX3390TF               BR IF NOT ZERO
         CR    R0,R3                  CHECK BLOCKING FACTOR
         BL    MX3390TC               BR IF LOW, TRY AGAIN
         BE    MX3390TM               SAME, LET'S SAVE IT
*  BLOCKING FACTOR TOO HIGH, SHOULD NOT HAPPEN
         MSG   ER3390CK               ISSUE ERROR MESSAGE
         LR    R2,R0                  FETCH R0
         ABEND 26,DUMP                INDICATE ERROR, CHECK TABLE
*  ERROR FROM TRKCALC,  BETTER CHECK OUR TABLE.
MX3390TF DS    0H
         MSG   ER3390CK               ISSUE ERROR MESSAGE
         LR    R2,R0                  FETCH R0
         ABEND 27,DUMP
MX3390TM DS    0H
         LR    R5,R1                  FETCH BLKSIZE
         B     MAXTRL50               BR TO SAVE IT
         SPACE 2
MAXTRIAL LR    R0,R5
         BAL   R14,DEVCALC            CALCULATE TRACK CAPACITY
         L     R1,TRKCALCN
         A     R1,=F'1'               COUNT CALLS TO TRKCALC
         ST    R1,TRKCALCN
         S     R5,=F'1'               ASSUME IT FAILED
         LTR   R15,R15                CORRECT?
         BNZ   MAXTRIAL               YES, BRANCH
         SPACE 1
         CR    R0,R3                  CORRECT BLOCKING FACTOR?
         BL    MAXTRIAL               NO, NOT YET
         BH    CAPERROR               NO, BLOCKED HIGHER THAN ESTIMATED
         A     R5,=F'1'
MAXTRL50 DS    0H
         NI    FLG3390,255-MXT3390    INDICATE CALLER
         ST    R5,0(,R6)              SAVE MAXIMUM BLOCKSIZE
         B     MAXLOOP
         SPACE 3
CAPERROR LR    R2,R0
         MSG   ERRPROG
         ABEND 10,DUMP
         EJECT
***
***      CALCULATE OPTIMAL BLOCKSIZES USING THE PROVIDED LRECL
***
*  3390 PERCENT-SPACE-USED CALCULATIONS USE THE MAXIMUM BLKSIZE
*  PER TRACK, W/O KEYS, AS THE BASE.  THIS MAY NOT BE CORRECT, BUT IT
*  IS CONSISTENT WITH THE CALCULATIONS IN SC26-4574-0, 'USING IBM
*  3390 DIRECT ACCESS STORAGE IN AN MVS ENVIRONMENT', APPENDIX B.
         SPACE 1
MAXDONE  DS    0H
         CLC   DEVTYPE,TYPE3390 IS THIS FOR 3390?
         BNE   MAXD0100         BR IF NOT
         SLR   R5,R5            CLEAR REG.
         ICM   R5,TB3390IC,TBL3390    FETCH MAX. BLKSIZE
MAXD0100 DS    0H
         CLC   DEVTYPE,TYPE9345 IS THIS FOR 9345?
         BNE   MAXD0200         BR IF NOT
         SLR   R5,R5            CLEAR REG.
         ICM   R5,TB3390IC,TBL9345    FETCH MAX. BLKSIZE
MAXD0200 DS    0H
         ST    R5,MAXBLOCK      MAXIMUM BLOCKSIZE
         SRL   R5,1             1/2 MAXBLOCK FOR ROUNDING TO 1/10
         ST    R5,MAXROUND      SAVE FOR LATER
         ICM   R0,15,LRECL      ANY BYTES IN THE RECORD?
         BP    UNBLOCK          YES, BRANCH
         MSG   ERRNULL          NO, ERROR MESSAGE
         B     TRKCHECK
         SPACE 2
UNBLOCK  SR    R1,R1
         ICM   R1,3,DEVTRACK    MAXIMUM TRACK SIZE
         CR    R0,R1            LRECL>DEVICE TRACK CAPACITY?
         BH    TRKLRECL         YES, BRANCH
         C     R0,=F'32760'     LRECL>32760?
         BH    TRKERR           YES, BRANCH
         BAL   R14,DEVCALC      COMPUTE NUMBER PER TRACK
*
         LTR   R15,R15          DO ANY FIT ON A TRACK?
         BNZ   TRKLRECL         NO, BRANCH
         LR    R2,R0            YES, SAVE THE UNBLOCKED NUMBER
         SPACE 3
         L     R3,=F'1'         BLOCKING FACTOR
         L     R4,LRECL         TRIAL BLOCKSIZE
         LA    R5,17*4          BLOCKS PER TRACK *4
         LA    R6,SAVEMAX-4     BLOCKSIZE RANGE ARRAY START -4
         SPACE 2
NEWBLK   S     R5,=F'4'         DONE ALL ELEMENTS?
         BNP   DONEBLK          YES, BRANCH
         A     R6,=F'4'         CURRENT BLOCKSIZE RANGE
         B     OLDLRECL
         SPACE 1
NEWLRECL A     R3,=F'1'         BLOCKING FACTOR
         A     R4,LRECL         TRIAL BLOCKSIZE
         SPACE 1
OLDLRECL C     R4,=F'32760'     ABOVE MAXIMUM BLOCKSIZE?
         BH    DONEBLK          YES, BRANCH
         C     R4,0(,R6)        IN THE LOWER RANGE?
         BNH   NEWLRECL         NO, BRANCH -- NEXT LRECL
         C     R4,4(,R6)        INSIDE THE UPPER RANGE?
         BH    NEWBLK           NO, BRANCH -- NEXT RANGE
         ST    R3,SAVEBLOK(R5)  SAVE THIS BLOCKING FACTOR
         B     NEWLRECL         GET THE NEXT LRECL
         EJECT
***
***      OUTPUT THE SUMMARY BLOCKSIZE HEADERS AND FIRST OUTPUT LINE
***
         SPACE 1
DONEBLK  MVC   BLOCKHED(6),DEVCHAR   DEVICE TYPE
         L     R1,LRECL              LRECL
         EDIT  R1,6,BLOCKHED+35,5,EQUAL=YES
         L     R1,KEYLEN             KEY LENGTH
         EDIT  R1,3,BLOCKHED+56,3,EQUAL=YES
         MSG   BLOCKHED
         MSG   BLOCKLIN
         MSG   BLOCKUNL
         SPACE 2
         C     R2,=F'16'             MORE THAN 16 BLOCKS?
         BNH   OPTSKIP               NO, BRANCH
         MVC   OUTLINE+1(L'OUTLINE-1),OUTLINE
         L     R1,LRECL              BLOCKSIZE
         EDIT  R1,6,OUTLINE+15,5     BLKSIZE
         EDIT  R2,6,OUTLINE+31,5     BLOCKS/TRACK
         EDIT  R2,6,OUTLINE+47,5     RECORDS/TRACK
         LR    R1,R2                 RECORDS/TRACK
         MH    R1,LRECL+2            BYTES/TRACK
         PCENT OUTLINE+61            CONVERT TO % UTILIZED
*  MVI OUTLINE+31,C'$'
         MSG   OUTLINE
***
***
***  NOTE: THE FOLLOWING STATEMENTS BIAS THE ORDER OF CHOICE FOR
***        "OPTIMAL" BLOCKING.  CURRENTLY, THESE STATEMENTS ARE
***        BIASED FOR A 1/2 TRACK BLOCK, FOLLOWED BY 1/3, 1/4,
***        1/5, ... 1/16 (WITH NO FULL-TRACKING RECOMMENDED).
***
         SPACE 1
OPTSKIP  L     R4,=F'1'
         LR    R5,R4
         SR    R1,R1
OPT      LH    R2,BLKPREF(R1)        NEXT INDEX
         A     R1,=F'2'              ADVANCE POINTER
         LTR   R2,R2                 POSITIVE?
         BNP   OPTDONE               NO, BRANCH
         LR    R3,R2
         SLL   R3,2                  TIMES FOUR
         L     R3,SAVEBLOK(R3)       SAVEBLOK ELEMENT
         C     R3,=F'1'              ANY BLOCKED QUANITITY?
         BNH   OPTA                  NO, BRANCH
         LR    R4,R2                 RECOMMENDS BLOCKED RECORDS
OPTA     C     R3,=F'0'              ANY UNBLOCKED QUANITITY?
         BNH   OPTB                  NO, BRANCH
         LR    R5,R2                 RECOMMENDS UNBLOCKED RECORDS
OPTB     B     OPT
         EJECT
***
***      OUTPUT THE REMAINDER OF THE SUMMARY BLOCKSIZE TABLE
***
         SPACE 1
OPTDONE  C     R4,=F'1'              ANY BLOCKED QUANTITY?
         BNE   OPTDA                 YES, BRANCH
         LR    R4,R5                 NO, USE THE UNBLOCKED QUANTITY
OPTDA    LR    R1,R4
         SLL   R1,2                  INDEX TO SAVEBLOK ENTRY
         L     R1,SAVEBLOK(R1)       BLOCKING FACTOR
         LR    R2,R1                 SAVE BLOCKING FACTOR
         MH    R1,LRECL+2            RECOMMENDED BLOCKSIZE
         ST    R1,RECOMEND           SAVE FOR LATER
         LR    R1,R2                 FETCH BLOCKING FACTOR
         MR    R0,R4                 CALC LRECL/TRACK
         MH    R1,LRECL+2            BYTES/TRACK
         ST    R1,RECBPT             SAVE THIS VALUE
         SPACE 1
         LA    R2,17                 LOOP CONTROL
OUTNEXT  S     R2,=F'1'
         BNP   ALLOC
         LR    R1,R2
         SLL   R1,2
         L     R3,SAVEBLOK(R1)
         LTR   R3,R3
         BNP   OUTNEXT
         SPACE 1
         MVC   OUTLINE+1(L'OUTLINE-1),OUTLINE
         SPACE 1
         C     R3,=F'1'              BLOCKING FACTOR = 1 ?
         BNE   OUTNB                 BR IF NOT
         LR    R1,R3                 FETCH B.F.
         MR    R0,R2                 LRECLS/TRACK
         MH    R1,LRECL+2            BYTES/TRACK
         C     R1,RECBPT             COMP. W/REC.BLK. BYTES/TRACK
         BNH   OUTNB                 BR IF NOT GREATER
         LR    R4,R2                 CHANGE RECOMMENDED VALUE
         LR    R1,R3                 FETCH BLOCKING FACTOR
         MH    R1,LRECL+2            CALCULATE BLOCKSIZE
         ST    R1,RECOMEND           STORE NEW RECOMMENDED VALUE
OUTNB    DS    0H
         LR    R1,R3
         MH    R1,LRECL+2            BLOCKSIZE
         EDIT  R1,6,OUTLINE+15,5
         CR    R2,R4                 RECOMMENDED VALUE?
         BNE   OUTNC                 NO, BRANCH
         MVC   OUTLINE(15),=C' RECOMMENDED-->'
OUTNC    EDIT  R2,6,OUTLINE+31,5
         LR    R1,R3
         MR    R0,R2                 LRECLS/TRACK
         EDIT  R1,6,OUTLINE+47,5
         MH    R1,LRECL+2            BYTES/TRACK
         PCENT OUTLINE+61            CONVERT TO % UTILIZED
         MSG   OUTLINE
         B     OUTNEXT
         EJECT
***
***      CALCULATE ALLOCATION QUANTITIES
***
         SPACE 1
ALLOC    ICM   R5,15,RECNUM            ANY RECORDS?
         BZ    TRKCHECK                NO, BRANCH
         MSG   BLANKLNE
         ICM   R4,15,USEBLK            ANY BLOCKSIZE?
         BP    ALLOCBA                 YES, BRANCH
         L     R4,RECOMEND             NO, USE RECOMMENDED VALUE
ALLOCBA  SR    R1,R1
         ICM   R1,3,DEVTRACK
         CR    R4,R1                   BLOCKSIZE>TRACK CAPACITY?
         BH    TRKCAPTY                YES, BRANCH
         C     R4,=F'32760'            BLOCKSIZE>32760?
         BH    TRKERR                  YES, BRANCH
         LR    R3,R4
         SR    R2,R2
         D     R2,LRECL
         LTR   R2,R2                   BLOCKSIZE EVENLY DIVISIBLE?
         BZ    ALLOC2                  YES, BRANCH
         MSG   ERRBLOCK                BLOCKSIZE NOT EVENLY DIVISIBLE
         B     TRKCHECK
         SPACE 1
ALLOC2   LR    R0,R4                   DD OF RKDD
         BAL   R14,DEVCALC             COMPUTE THE NUMBER PER TRACK
         LTR   R15,R15                 DID IT FIT?
         BNZ   TRKCAPTY                NO, BRANCH
         LR    R2,R0                   BLOCKS/TRACK
         EDIT  R4,6,ALLOCH+12,5
         EDIT  R5,9,ALLOCH+24,7
         MSG   ALLOCH
         SR    R4,R4
         DR    R4,R3
         LTR   R4,R4
         BZ    ALLOC2A
         A     R5,=F'1'                BLOCKS
ALLOC2A  EDIT  R5,9,ALLOCL+1,7
         SR    R4,R4
         DR    R4,R2
         LTR   R4,R4
         BZ    ALLOC2B
         A     R5,=F'1'                TRACKS
ALLOC2B  EDIT  R5,9,ALLOCL+19,7
         LH    R2,DEVTRKCL             TRACKS PER CYLINDER
         SR    R4,R4
         DR    R4,R2
         LTR   R4,R4
         BZ    ALLOC2C
         A     R5,=F'1'
ALLOC2C  EDIT  R5,9,ALLOCL+40,7
         MSG   ALLOCL
         EJECT
***
***      OUTPUT THE TRACK CAPACITY TABLE IF NEEDED
***
         SPACE 1
TRKCHECK CLI   TRACKKW+1,1            TRACK CAPACITY REPORT REQUESTED?
         BNE   TRKCALLS               NO, BRANCH
         B     TRKCAP
         SPACE 1
TRKERR   MSG   ERR32760               BLOCKSIZE EXCEEDS 32,760 BYTES
         B     TRKNOCAP
         SPACE 1
TRKLRECL MVC   USEBLK,LRECL           LRECL EXCEEDS DEVICE MAXIMUM
TRKCAPTY L     R1,USEBLK              BLKSIZE EXCEEDS DEVICE MAXIMUM
         EDIT  R1,6,ERRSIZE+16,5
         MSG   ERRSIZE
         SPACE 1
TRKNOCAP CLI   TRACKKW+1,2            TRACK CAPACITY REPORT DISALLOWED?
         BE    TRKCALLS               YES, BRANCH
         SPACE 2
TRKCAP   CLC   PUTLCALL,=F'1'         JUST ONE LINE SO FAR?
         BE    TRKCAP4                YES, BRANCH
TRKCAP2  MSG   BLANKLNE
         CLC   PUTLCALL,LINES         FILLED THE SCREEN?
         BL    TRKCAP2                NO, BRANCH
         SPACE 1
TRKCAP4  MVC   TRKCAPH(6),DEVCHAR     DEVICE TYPE
         L     R1,KEYLEN              KEY LENGTH
         EDIT  R1,3,TRKCAPH+37,3,EQUAL=YES
         MSG   TRKCAPH
         MSG   TRKCAPM
         MSG   TRKCAPU
         MVC   OUTLINE+1(L'OUTLINE-1),OUTLINE
         SPACE 1
         SR    R3,R3
         LA    R6,SAVEMAX+16*4        MAXIMUM BLOCKSIZE POSITITION
NEXTMAX  A     R3,=F'1'               NEXT BLOCK/TRACK MULTIPLE
         EDIT  R3,6,OUTLINE+13,5      BLOCKS/TRACK
         L     R5,0(,R6)              BLOCKSIZE
         EDIT  R5,6,OUTLINE+25,5
         MR    R4,R3                  BYTES/TRACK
         EDIT  R5,6,OUTLINE+41,5
         LR    R1,R5                  BYTES/TRACK
         PCENT OUTLINE+56             CONVERT TO % UTILIZED
         MSG   OUTLINE
         S     R6,=F'4'               NEXT MAXIMUM BLOCKSIZE POSTITION
         C     R3,=F'16'
         BL    NEXTMAX
         EJECT
***
***      OUTPUT DEVICE SUMMARY LINE ONE
***
         SPACE 1
         MSG   BLANKLNE
         SR    R0,R0
         ICM   R0,3,DEVTRACK          MAXIMUM TRACK LENGTH
         SH    R0,DEVOKEY             LESS RECORD AND KEY OVERHEAD
         AH    R0,DEVNOKEY            PLUS KEY OVERHEAD AMOUNT
         CLI   DEVTYPE,X'0E'          3380 DEVICE?
         BE    SUM3380                YES, BRANCH
         CLI   DEVTYPE,X'0F'          3390 DEVICE?
         BE    SUM3390                YES, BRANCH
         CLI   DEVTYPE,X'04'          9345 DEVICE?
         BE    SUM9345                YES, BRANCH
         CLI   DEVTYPE,X'0C'          3375 DEVICE?
         BNE   SUMDONE                NO, BRANCH
         SPACE 1
SUM3375  L     R0,=F'35616'           3375 DISK
         B     SUMDONE
         SPACE 1
SUM3380  L     R0,=F'47476'           3380 DISK
         B     SUMDONE
         SPACE 1
SUM3390  L     R0,=F'56664'           3390 DISK
         B     SUMDONE
         SPACE 1
SUM9345  L     R0,=F'46456'           9345 DISK
         B     SUMDONE
         SPACE 2
SUMDONE  EDIT  R0,6,TRKDEVS+30,5,EQUAL=YES
         SPACE 1
         LH    R1,DEVCYL              TOTAL CYLINDERS
         MH    R1,DEVTRKCL            TOTAL TRACKS
         EDIT  R1,6,TRKDEVS+46,5,EQUAL=YES
         SPACE 1
         MR    R0,R0                  TOTAL BYTES
         EDIT  R1,14,TRKDEVS+61,11,EQUAL=YES
         SPACE 1
         MSG   TRKDEVS
         EJECT
***
***      OUTPUT DEVICE SUMMARY LINE TWO
***
         SPACE 1
         LH    R1,DEVCYL
         EDIT  R1,6,TRKSUMM+07,6,EQUAL=YES
         LH    R1,DEVTRKCL
         EDIT  R1,3,OUTLINE+1,3
         MVC   TRKSUMM+24(1),OUTLINE+3
         CLI   OUTLINE+2,X'40'
         BE    SUMDA
         MVC   TRKSUMM+24(2),OUTLINE+2
SUMDA    ICM   R1,3,DEVTRACK
         EDIT  R1,6,TRKSUMM+37,5,EQUAL=YES
         SPACE 1
         LA    R0,96                  DD OF RKDD
         MVI   KEYLEN+3,44            K  OF RKDD
         BAL   R14,DEVCALC            COMPUTE THE NUMBER THAT FIT
         EDIT  R0,3,OUTLINE+1,3
         MVC   TRKSUMM+55(1),OUTLINE+3
         CLI   OUTLINE+2,X'40'
         BE    SUMDB
         MVC   TRKSUMM+55(2),OUTLINE+2
         SPACE 1
SUMDB    LA    R0,256                 DD OF RKDD
         MVI   KEYLEN+3,8             K  OF RKDD
         BAL   R14,DEVCALC            COMPUTE THE NUMBER THAT FIT
         EDIT  R0,3,OUTLINE+1,3
         MVC   TRKSUMM+68(1),OUTLINE+3
         CLI   OUTLINE+2,X'40'
         BE    SUMDC
         MVC   TRKSUMM+68(2),OUTLINE+2
SUMDC    MSG   TRKSUMM
         SPACE 3
TRKCALLS CLI   VERIFYKW+1,1           VERIFY?
         BNE   RC0                    NO, BRANCH
         L     R3,TRKCALCN            TOTAL NUMBER OF TRKCALC CALLS
         EDIT  R3,9,TOTCALLS+1,7
         SPACE 1
         MSG   BLANKLNE
         MSG   TOTCALLS
         B     RC0
         EJECT
***
***      DEVCALC COMPUTATIONS
***
         SPACE 1
DEVCALC  STM   R14,R0,DEVREGS         SAVE INITIAL REGISTERS
         SR    R15,R15
         IC    R15,DEVTYPE            DEVTYPE CHARACTER
         MH    R15,=H'4'              ADJUST TO BRANCH INDEX
         SPACE 1
         B     DEVBRCH(R15)           BRANCH TO PROCESSING ROUTINE
DEVBRCH  EX    R0,*            X'00'  INVALID
         EX    R0,*            X'01'  INVALID
         EX    R0,*            X'02'  INVALID
         EX    R0,*            X'03'  INVALID
         B     DEV9345         X'04'  9345
         EX    R0,*            X'05'  INVALID
         B     DEV23051        X'06'  2305-1
         B     DEV23052        X'07'  2305-2
         B     DEV2314         X'08'  2314
         B     DEV3330         X'09'  3330
         B     DEV3340         X'0A'  3340
         B     DEV3350         X'0B'  3350
         B     DEV3375         X'0C'  3375
         B     DEV33301        X'0D'  3330-1
         B     DEV3380         X'0E'  3380
         B     DEV3390         X'0F'  3390
         SPACE 1
DEV23051 DS    0H
DEV23052 DS    0H
DEV3330  DS    0H
DEV3340  DS    0H
DEV3350  DS    0H
DEV33301 LH    R15,DEVOKEY            NORMAL DEVICE CALCULATIONS
         CLI   KEYLEN+3,0             ANY KEY?
         BH    DEV33A                 YES, BRANCH
         SH    R15,DEVNOKEY           NO, LESS KEYED PORTION
DEV33A   A     R15,KEYLEN             ADD KEY LENGTH
         AR    R15,R0                 KEY AND RECORD OVERHEAD
         B     DEVDIVID
         SPACE 1
DEV2314  L     R15,KEYLEN             KEY LENGTH
         AR    R15,R0                 KEY AND RECORD LENGTH
         LH    R1,DEVTRACK            TRACK CAPACITY
         SR    R1,R15                 BYTES REMAINING LESS KEY OVERHEAD
         CLI   KEYLEN+3,0             ANY KEY?
         BNH   DEV2314A               NO, BRANCH
         S     R1,=F'45'              BYTES REMAINING ON TRACK
DEV2314A LTR   R1,R1                  ANY RECORD FIT ON THE TRACK?
         BM    DEVDONE2               NO, BRANCH
         M     R14,=F'534'
         D     R14,=F'512'
         A     R15,=F'146'            NORMAL KEY AND RECORD OVERHEAD
         CLI   KEYLEN+3,0             ANY KEY?
         BH    DEV2314B               YES, BRANCH
         S     R15,=F'45'             NO, LESS KEYED PORTION
DEV2314B SR    R0,R0
         DR    R0,R15                 NUMBER OF RECORDS THAT FIT -1
         A     R1,=F'1'               NUMBER OF RECORDS THAT FIT
         B     DEVDONE
         EJECT
DEV3375  ICM   R15,15,KEYLEN          ANY KEY?
         BZ    DEV3375R               NO, BRANCH
         A     R15,=F'191'
         SR    R14,R14
         D     R14,=F'32'
         M     R14,=F'32'
DEV3375R LR    R1,R15                 SAVE KEY AND OVERHEAD LENGTH
         LR    R15,R0                 RECORD LENGTH
         A     R15,=F'191'
         SR    R14,R14
         D     R14,=F'32'
         M     R14,=F'32'
         AR    R15,R1                 RECORD AND KEY LENGTH
         A     R15,=F'224'            BASIC OVERHEAD AMOUNT
         B     DEVDIVID
         SPACE 2
DEV3380  ICM   R15,15,KEYLEN          ANY KEY?
         BZ    DEV3380R               NO, BRANCH
         A     R15,=F'267'
         SR    R14,R14
         D     R14,=F'32'
         M     R14,=F'32'
DEV3380R LR    R1,R15                 SAVE KEY AND OVERHEAD LENGTH
         LR    R15,R0                 RECORD LENGTH
         A     R15,=F'267'
         SR    R14,R14
         D     R14,=F'32'
         M     R14,=F'32'
         AR    R15,R1                 RECORD AND KEY LENGTH
         A     R15,=F'256'            BASIC OVERHEAD AMOUNT
         B     DEVDIVID
*
*  3390 CALCULATIONS
DEV3390  DS    0H
         STM   R4,R7,DEVREGX          SAVE ADDITIONAL REGISTERS
*  CALCULATE 'K' VALUE
         ICM   R1,15,KEYLEN           FETCH KEYLEN
         BZ    DEV3390G               BR IF NONE
         LR    R6,R1                  SAVE KEYLENGTH
         BAL   R14,DEV3390T           CALCULATE 'K'
         LR    R1,R5                  MOVE IT TO REG. 1
*  CALCULATE 'D' VALUE
DEV3390G DS    0H
         LR    R6,R0                  FETCH LRECL ('DL')
         BAL   R14,DEV3390T
         ALR   R5,R1                  CALCULATE 'D' + 'K'
         AH    R5,=H'10'              ADD THE CONSTANT '10'
         SLR   R4,R4                  CLEAR R4
         M     R4,=F'34'              CONVERT RECORDS TO BYTES
         LR    R15,R5                 MOVE TO REG. 15
         LM    R4,R7,DEVREGX          RESTORE REGS.
         B     DEVDIVID
*
*  PERFORM ACTUAL 'D' OR 'K' CALCULATION
*  VALUE OF 'KL' OR 'DL' IS IN REG. 6 (INPUT)
*  VALUE OF 'K' OR 'D' IS IN REG. 5 (OUTPUT)
*  RETURN ADDRESS IS IN R14
*
DEV3390T DS    0H
         LR    R5,R6                  FETCH VALUE
         A     R5,=F'6'               ADD 6
         SLR   R4,R4                  ZERO REG.
         D     R4,=F'232'             DIVIDE
         LTR   R4,R4                  CHECK IF ANY REMAINDER
         BZ    DEV3390U               BR IF NONE
         AH    R5,=H'1'               ELSE ROUND UP TO NEXT INTEGER
DEV3390U DS    0H
         SLR   R4,R4                  CLEAR REG
         M     R4,=F'6'               KN * 6   (OR DN * 6)
         ALR   R5,R6                  ADD 'KL' (OR 'DL')
         A     R5,=F'6'               ADD 6
         SLR   R4,R4                  CLEAR REG
         D     R4,=F'34'              DIVIDE
         LTR   R4,R4                  CHECK IF REMAINDER IS 0
         BZ    DEV3390W               BR IF YES
         AH    R5,=H'1'               ELSE ROUND UP TO NEXT INTEGER
DEV3390W DS    0H
         AH    R5,=H'9'               CALCULATE 'K' (OR 'D')
         BR    R14                    RETURN TO CALLER
*
*
*  9345 CALCULATIONS
DEV9345  DS    0H
         STM   R4,R7,DEVREGX          SAVE ADDITIONAL REGISTERS
*  CALCULATE 'K' VALUE
         ICM   R1,15,KEYLEN           FETCH KEYLEN
         BZ    DEV9345G               BR IF NONE
         LR    R6,R1                  SAVE KEYLENGTH
         BAL   R14,DEV9345T           CALCULATE 'K'
         LR    R1,R5                  MOVE IT TO REG. 1
         AH    R1,=H'7'               ADD 7
*  CALCULATE 'D' VALUE
DEV9345G DS    0H
         LR    R6,R0                  FETCH LRECL ('DL')
         BAL   R14,DEV9345T
         ALR   R5,R1                  CALCULATE 'D' + 'K'
         AH    R5,=H'18'              ADD THE CONSTANT '18'
         SLR   R4,R4                  CLEAR R4
         M     R4,=F'34'              CONVERT RECORDS TO BYTES
         LR    R15,R5                 MOVE TO REG. 15
         LM    R4,R7,DEVREGX          RESTORE REGS.
         B     DEVDIVID
*
*  PERFORM ACTUAL 'D' OR 'K' CALCULATION
*  VALUE OF 'KL' OR 'DL' IS IN REG. 6 (INPUT)
*  VALUE OF 'K' OR 'D' IS IN REG. 5 (OUTPUT)
*  RETURN ADDRESS IS IN R14
*
DEV9345T DS    0H
         LR    R5,R6                  FETCH VALUE
         A     R5,=F'6'               ADD 6
         SLR   R4,R4                  ZERO REG.
         D     R4,=F'232'             DIVIDE
         LTR   R4,R4                  CHECK IF ANY REMAINDER
         BZ    DEV9345U               BR IF NONE
         AH    R5,=H'1'               ELSE ROUND UP TO NEXT INTEGER
DEV9345U DS    0H
         SLR   R4,R4                  CLEAR REG
         M     R4,=F'6'               KN * 6   (OR DN * 6)
         ALR   R5,R6                  ADD 'KL' (OR 'DL')
         A     R5,=F'6'               ADD 6
         SLR   R4,R4                  CLEAR REG
         D     R4,=F'34'              DIVIDE
         LTR   R4,R4                  CHECK IF REMAINDER IS 0
         BZ    DEV9345W               BR IF YES
         AH    R5,=H'1'               ELSE ROUND UP TO NEXT INTEGER
DEV9345W DS    0H
         BR    R14                    RETURN TO CALLER
*
         EJECT
DEVDIVID SR    R0,R0
         SR    R1,R1
         ICM   R1,3,DEVTRACK          MAXIMUM TRACK SIZE
         DR    R0,R15                 NUMBER OF RECORDS THAT FIT
         SPACE 2
DEVDONE  SR    R15,R15                RETURN CODE ZERO
         LTR   R0,R1                  ANY RECORDS FIT?
         BNZ   DEVNDN                 YES, BRANCH
DEVDONE2 LA    R15,4                  NO, RETURN CODE FOUR
         SPACE 1
DEVNDN   L     R14,DEVREGS            RELOAD REGISTER 14
         CLI   VERIFYKW+1,1           VERIFY WITH TRKCALC?
         BNER  R14                    NO, RETURN
         SPACE 2
         L     R1,DEVREGS+8           RESTORE RECORD LENGTH
DEVTRKCX DS    0H
         STM   R14,R0,DEVREGS         SAVE RESULTS FOR NOW
         SPACE 3
         LR    R0,R1                  DD OF RKDD
         ICM   R0,B'0100',KEYLEN+3    K  OF RKDD
         ICM   R0,B'1000',=X'01'      R  OF RKDD
         TRKCALC FUNCTN=TRKCAP,TYPE=DEVTYPE,REGSAVE=YES,RKDD=(0)
         L     R14,DEVREGS            RELOAD REGISTER 14
         LTR   R15,R15                FIT?
         BNZ   DEVNOFIT               NO, BRANCH
         TM    FLG3390,MXT3390        CHECK IF MAXTRIAL 3390 CALL
         BNZR  R14                    RETURN IF YES
         C     R15,DEVREGS+4          YES -- OTHER RETURN CODE ZERO?
         BNE   DEVERROR               NO, BRANCH
         C     R0,DEVREGS+8           SAME NUMBER OF RECORDS?
         BNE   DEVERROR               NO, ERROR
         BR    R14
         SPACE 1
DEVNOFIT DS    0H
         CH    R15,TRKNODEV           CHECK IF DEVICE GENNED
         BNE   DEVNO100               BR IF NOT 'DEVICE NOT GENNED'
         MSG   ERRNODEV               TELL USER DEVICE NOT GENNED
         MVI   VERIFYKW+1,0           TURN OFF VERIFY
         OI    FLG3390,NODEVG         FLAG NO DEVICE GENNED.
         LM    R14,R0,DEVREGS         RESTORE REGS
         BR    R14                    RETURN TO CALLER
DEVNO100 DS    0H
         TM    FLG3390,MXT3390        MAXTRIAL 3390 CALL?
         BNZR  R14                    YES, RETURN
         ICM   R1,15,DEVREGS+4        OTHER RETURN CODE ZERO?
         BNZR  R14                    NO, RETURN
         SPACE 2
DEVERROR LM    R2,R3,DEVREGS+4        FIRST RETURN CODE; # OF RECORDS
         LR    R4,R15                 SECOND RETURN CODE
         LR    R5,R0                  SECOND NUMBER OF RECORDS
         MSG   ERRVERFY               VERIFY ERROR
         ABEND 20,DUMP
         EJECT
***
***      PUTLINE OUTPUT ROUTINE
***
         SPACE 1
$PUTLINE ST    R14,R14SAVE
         SPACE
         MVC   PUTLINE+4(80),=CL80' '  CLEAR INPUT LINE
         LR    R0,R15
         SLL   R0,16
         STCM  R0,B'1111',PUTLINE      SAVE LENGTH
         S     R15,=F'5'               MACHINE LENGTH
         MVC   PUTLINE+4(*-*),0(R1)    <<EXECUTED>>
         EX    R15,*-6                 MOVE IN THE TEXT
*
         L     R1,PUTLCALL
         A     R1,=F'1'
         ST    R1,PUTLCALL
         ICM   R15,15,PDSMSGA          LOAD ADDRESS OF PDS
         BZ    NOTPDS                  NO
         LA    R1,PUTLINE+4-1          START OF MESSAGE
         BALR  R14,R15                 INVOKE THE PDS OUTPUT ROUTINE
         LTR   R15,R15                 SUCCESSFUL OUTPUT?
         BNZ   RC0                     NO, **ATTENTION** EXIT
         B     EXITPUT                 YES, BRANCH
NOTPDS   DS    0H
         LA    R1,PUTLPARM
         USING IOPL,R1
         L     R14,CPPLUPT
         L     R15,CPPLECT
         LA    R0,MYECB
         STM   R14,R0,IOPLUPT         INITIALIZE IOPLUPT, IOPLECT
*                                                AND IOPLECB
         SPACE
         LA    R0,PUTLINE             DATA LINE POINTER
         L     R15,16                 CVT ADDRESS
         L     R15,X'1BC'(,R15)       PUTLINE ROUTINE
         SPACE
         PUTLINE PARM=PUTLPARM+16,ENTRY=(15),MF=(E,(1)),               X
               OUTPUT=((0),TERM,SINGLE,DATA),                          X
               TERMPUT=(EDIT,WAIT,NOHOLD,NOBREAK)
         SPACE
         DROP  R1
         TM    MYECB,X'40'           ATTN OCCUR?
         BO    RC12                  YES, BRANCH
         SPACE
EXITPUT  DS    0H
         L     R14,R14SAVE
         LTR   R15,R15               SUCCESSFUL?
         BZR   R14                   YES, DONE
         SPACE 1
         EDIT  R15,3,ERRPUTL+23,3,EQUAL=YES
         TPUT  ERRPUTL,L'ERRPUTL
         SPACE 5
RC12     LA    R15,12
         B     BYPRC0
         SPACE 1
RC0      SR    R15,R15
BYPRC0   L     R13,4(,R13)
         RETURN (14,12),RC=(15)
$PUTMOVE MVC   PUTLINE+4(*-*),0(R1)
         EJECT
***
***      CURRENT DEVICE CHARACTERISTICS (COPIED FROM UNITTBL):
***
*  NOTE FOR 3390, THE 'DEVOKEY' AND 'DEVNOKEY' FIELDS ARE NOT USED.
*       ALSO THE 'DEVTRACK' IS THE MAXIMUM NUMBER OF TRACK CELLS
*       WITH IBM STANDARD R0 PROVIDED AND R0 IS NOT INCLUDED IN
*       CALCULATIONS.
         SPACE 1
         DS    0H
DEVNAME  DC    CL5'ABCDE'          ALIAS NAME OF THIS ROUTINE(XXXABCDE)
DEVCHAR  DC    CL6'123456'         RIGHT-ADJUSTED NAME FOR THIS DEVICE
DEVTYPE  DC    X'12'               DEVTYPE CHARACTER
DEVTRKCL DC    H'12'               TRACKS TO A CYLINDER
DEVCYL   DC    H'123'              NUMBER OF CYLINDERS FOR THE DEVICE
DEVOKEY  DC    H'123'              MINIMUM BLOCK OVERHEAD WITH A KEY
DEVNOKEY DC    H'123'              KEYED AMOUNT OF BLOCK OVERHEAD
DEVTRACK DC    H'12345'            MAXIMUM TRACK LENGTH
*  NOTE - 3390 CALCULATIONS DO NOT USE 'DEVOKEY' AND 'DEVNOKEY'.
DEVXEND  DS    0X                  END OF TABLE ENTRY
DEVENTL  EQU   DEVXEND-DEVNAME
         SPACE 5
***
***      DEVICES CURRENTLY SUPPORTED:
***
         SPACE 1
UNITTBL  DS    0H
***    NAME      CHAR  TYPE TRKCL     CYL   OKEY  NOKEY   TRACK
 DC C'9345 ',C'  9345',X'04',H'15',H'1440',X'000',X'000',X'BC98'
 DC C'23051',C'2305-1',X'06',H'08',H'0048',X'27A',X'0CA',X'38E8'
 DC C'23052',C'2305-2',X'07',H'08',H'0096',X'121',X'05B',X'3A0A'
 DC C'2314 ',C'  2314',X'08',H'20',H'0200',X'000',X'000',X'1C7E'
 DC C'3330 ',C'  3330',X'09',H'19',H'0404',X'0BF',X'038',X'336D'
 DC C'33301',C'3330-1',X'0D',H'19',H'0808',X'0BF',X'038',X'336D'
 DC C'3340 ',C'  3340',X'0A',H'12',H'0696',X'0F2',X'04B',X'2157'
 DC C'3350 ',C'  3350',X'0B',H'30',H'0555',X'10B',X'052',X'4B36'
 DC C'3375 ',C'  3375',X'0C',H'12',H'0959',X'220',X'0A0',X'8CA0'
 DC C'3380 ',C'  3380',X'0E',H'15',H'0885',X'2D8',X'0EC',X'BB60'
 DC C'3390 ',C'  3390',X'0F',H'15',H'1113',X'000',X'000',X'E5A2'
 DC  X'FF'
         EJECT
***
***      PROGRAM VARIABLES
***
         SPACE 1
DOUBLE   DC    D'0'             WORKAREA
F6       DC    F'6'             CONSTANT
F9       DC    F'9'             CONSTANT
F10      DC    F'10'            CONSTANT
F34      DC    F'34'            CONSTANT
F232     DC    F'232'           CONSTANT
SAVE     DC    18F'0'           PROGRAM SAVE AREA
PDSMSGA  DC    A(0)             REENTRY ADDRESS FOR PDSCALL KEYWORD
TRKCALCN DC    F'0'             CALLS TO TRKCALC FOR TRACK CAPACITY
DEVREGS  DC    3F'0'            DEVCALC HOLD AREA FOR R14, R15 AND R0
DEVREGX  DC    4F'0'            DEVCALC HOLD AREA (3390 CALCULATIONS)
KEYLEN   DC    F'0'             KEY LENGTH
LRECL    DC    F'0'             LRECL
RECNUM   DC    F'100000'        NUMBER OF ALLOCATED RECORDS
USEBLK   DC    F'0'             BLOCKSIZE TO USE
RECOMEND DC    F'0'             RECOMMENDED BLOCKSIZE
RECBPT   DC    F'0'             BYTES/TRACK FOR RECOMMENDED BLKSIZE
SAVEBLOK DC    18F'0'           SAVED BLOCKSIZE ARRAY
SAVEMAX  DC    18F'0'           TRACK CAPACITY ARRAY
LINES    DC    F'0'             LINES TO A SCREEN
MAXBLOCK DC    F'0'             MAXIMUM BLOCKSIZE FOR THIS KEY & TRACK
MAXROUND DC    F'0'             1/2 OF MAXBLOCK FOR ROUNDING TO 1/10
MYPPL    DC    7A(0)            PPL FOR PARSE
PUTLPARM DC    8A(0)            PARMS FOR PUTLINE
PUTLCALL DC    A(0)             PARMS FOR PUTLINE
MYANS    DC    A(0)             PARSE ANSWER AREA
MYECB    DC    F'0'             ECB FOR PARSE AND PUTLINE
R14SAVE  DC    F'0'             SAVE AREA FOR PARSE
TRKNODEV DC    H'12'            TRKCALC (TRKCAP) - DEVICE NOT GENNED
KEY3390  DC    H'0'             KEYLEN INDEX FOR 3390
TYPE3390 DC    X'0F'            DEVICE TYPE FOR 3390
TYPE9345 DC    X'04'            DEVICE TYPE FOR 9345
FLG3390  DC    X'00'            USED FOR 3390 PROCESSING
*  BIT SETTINGS FOR FLG3390
MXT3390  EQU   X'80'            MAXTRIAL 3390 CALL
NODEVG   EQU   X'40'            DEVICE NOT GENNED
         DS    0H
*
         SPACE 3
* BLOCKING FACTOR PREFERENCE TABLE -- ENTRIES TO THE RIGHT ARE FAVORED:
         SPACE 1
BLKPREF  DC    AL2(16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,0)
         EJECT
***
***      PROGRAM HEADERS
***
         SPACE 1
EDITPIC  DC    X'2020206B2020206B2020206B202120'
BLOCKHED DC    C'XXXXXX BLOCKSIZE SUMMARY;    LRECL 123456    KEY LENGTX
               H 123 '
BLOCKLIN DC C'            BLOCKSIZE    BLOCKS/TRACK    LRECLS/TRACK    X
               UTILIZATION'
BLOCKUNL DC C'            ---------    ------------    ------------    X
               -----------'
BLANKLNE DC    C' '
ALLOCH   DC    C'FOR BLKSIZE 12,345  AND 1,234,567 RECORDS, ALLOCATE:'
ALLOCL   DC    C' 1,234,567 BLOCKS, 1,234,567 TRACKS, OR 1,234,567 CYLIX
               NDERS'
PUTLINE  DC    CL84' '
TRKCAPH  DC    C'XXXXXX TRACK CAPACITY;    KEY LENGTH 123 '
TRKCAPM  DC    C'       BLOCKS/TRACK     BLKSIZE     BYTES/TRACK     UTX
               ILIZATION'
TRKCAPU  DC    C'       ------------     -------     -----------     --X
               ---------'
OUTLINE  DC    CL80' '
TRKDEVS  DC   C'DEVICE SUMMARY: MAX BLOCKSIZE 12,345   TRACKS 12,345   X
               BYTES 1,234,567,890  '
TRKSUMM  DC     C'NOCYLS 1,123   TRKS/CYL=2    TRKSIZE 12,345   DSCB/TRX
               K=2    PDS/TRK=2  '
TOTCALLS DC    C' 1,234,567 CALLS WERE MADE TO COMPUTE TRACK CAPACITY; X
               34 IS THE BASELINE NUMBER'
ERRVERFY DC    C'*** VERIFICATION ERROR, COMPARE R2 && R3 WITH R4 && R5X
               ; CORRESPONDS TO R15 && R0'
ERRNODEV DC    C'*** VERIFICATION ERROR, DEVICE NOT GENNED ON YOUR SYST+
               EM ***.'
ER3390CK DC    C'*** TRKCALC RESULTS UNEXPECTED, CHECK TABLE ***'
ERRPUTL  DC    C'*** PUTLINE ERROR, R15 123 '
ERRSIZE  DC    C'*** RECORD SIZE 12,345 DOES NOT FIT ON A TRACK'
ERR32760 DC    C'*** 32,760 IS THE MAXIMUM ALLOWED RECORD SIZE'
ERRBLOCK DC    C'*** YOUR BLOCKSIZE IS NOT A MULTIPLE OF YOUR LOGICAL RX
               ECORD LENGTH'
ERRNULL  DC    C'*** NULL RECORDS ARE NOT SUPPORTED'
ERRKEY   DC    C'*** THE MAXIMUM LEGAL KEY LENGTH IS 255 CHARACTERS'
ERRUNIT  DC    C'*** THIS DEVICE NAME IS NOT SUPPORTED'
ERRPROG  DC    C'*** PROGRAM ERROR, LOOK AT R2 AND R3'
         EJECT
***
***      PROGRAM LITERALS
***
         SPACE 1
         LTORG
         EJECT
***
***      PARSE CONTROL DATA
***
         SPACE 1
BLKPCL   IKJPARM
LRE      IKJIDENT 'LRECL',                                             +
               FIRST=NUMERIC,OTHER=NUMERIC,MAXLNTH=5,                  +
               PROMPT='LOGICAL RECORD LENGTH'
KEYKW    IKJKEYWD
         IKJNAME 'KEYLENGTH',SUBFLD=KEYSF
RECKW    IKJKEYWD
         IKJNAME 'RECORDS',SUBFLD=RECSF
NUMKW    IKJKEYWD
         IKJNAME 'NUMBER',SUBFLD=RECSF
BLKKW    IKJKEYWD
         IKJNAME 'BLKSIZE',SUBFLD=BLKSF
TRACKKW  IKJKEYWD
         IKJNAME 'TRACKCAP'
         IKJNAME 'NOTRACKCAP'
VERIFYKW IKJKEYWD
         IKJNAME 'VERIFY'
KEYSF    IKJSUBF
KEY      IKJIDENT 'KEY LENGTH',                                        +
               FIRST=NUMERIC,OTHER=NUMERIC,MAXLNTH=3,                  +
               PROMPT='THE RECORD KEY LENGTH'
RECSF    IKJSUBF
REC      IKJIDENT 'NUMBER OF RECORDS',                                 +
               FIRST=NUMERIC,OTHER=NUMERIC,MAXLNTH=7,PROMPT='THE NUMBER+
                OF RECORDS FOR AN ALLOCATION COMPUTATION'
BLKSF    IKJSUBF
BLK      IKJIDENT 'BLOCKSIZE TO USE',                                  +
               FIRST=NUMERIC,OTHER=NUMERIC,MAXLNTH=5,PROMPT='THE BLOCKS+
               IZE TO USE FOR AN ALLOCATION COMPUTATION'
         IKJENDP
*  3390 KEY INDEX TABLE
KDX3390  DC    AL1(22)     *  KEYLEN = 1-22
         DC    AL1(56)     *  KEYLEN = 23-56
         DC    AL1(90)     *  KEYLEN = 57-90
         DC    AL1(124)    *  KEYLEN = 91-124
         DC    AL1(158)    *  KEYLEN = 125-158
         DC    AL1(192)    *  KEYLEN = 159-192
         DC    AL1(226)    *  KEYLEN = 193-226
         DC    AL1(254)    *  KEYLEN = 227-254
         DC    AL1(255)    *  KEYLEN = 255
*
*  3390 BLKSIZE TABLE
*   DEFINE MAX. BLOCKS FOR BLOCKING FACTORS 1 - 17.
*   EACH ROW CONTAINS MAX. BLOCK FOR KEYS OF 0, 1-22, 23-56, 57-90,
*         91-124, 125-158, 159-192, 193-226, 227-254, 255
*         (RESPECTIVELY).
*   NOT ELEGANT, BUT WILL WORK FOR TIME BEING.
*
*   EACH ENTRY IS DEFINED WITH 'AL2' SO AS TO OCCUPY TWO BYTES,
*   SINCE THE LARGEST ENTRY IS 56664 (X'FFFF' IS 65535).
**
TBL3390  DS    0F        ALIGN ON FULLWORD BOUNDARY
*  BLOCKING FACTOR =  1
*                    0,  -22,  -56,  -90, -124, -158, -192, -226, -254
         DC  AL2(56664,56336,56302,56268,56234,56200,56166,56138)
         DC  AL2(56104,56070)                       BLOCKING FACTOR #1
TBL3390F DS    0H
         DC  AL2(27998,27664,27630,27602,27568,27534,27500,27466)
         DC  AL2(27432,27398)                                       #2
         DC  AL2(18452,18118,18090,18056,18022,17988,17954,17920)
         DC  AL2(17886,17858)                                       #3
         DC  AL2(13682,13348,13314,13280,13246,13218,13184,13150)
         DC  AL2(13116,13082)                                       #4
         DC  AL2(10796,10462,10434,10400,10366,10332,10298,10264)
         DC  AL2(10230,10202)                                       #5
         DC  AL2(8906,8578,8544,8510,8476,8442,8408,8374,8346,8312) #6
         DC  AL2(7548,7214,7186,7152,7118,7084,7050,7016,6982,6954) #7
         DC  AL2(6518,6190,6156,6122,6088,6054,6026,5992,5958,5924) #8
         DC  AL2(5726,5392,5358,5330,5296,5262,5228,5194,5160,5126) #9
         DC  AL2(5064,4730,4696,4662,4634,4600,4566,4532,4498,4464) #10
         DC  AL2(4566,4232,4198,4170,4136,4102,4068,4034,4000,3966) #11
         DC  AL2(4136,3802,3768,3734,3706,3672,3638,3604,3570,3536) #12
         DC  AL2(3768,3440,3406,3372,3338,3304,3270,3242,3208,3174) #13
         DC  AL2(3440,3106,3072,3038,3010,2976,2942,2908,2874,2840) #14
         DC  AL2(3174,2840,2806,2778,2744,2710,2676,2642,2608,2574) #15
         DC  AL2(2942,2608,2574,2546,2512,2478,2444,2410,2376,2342) #16
         DC  AL2(2710,2376,2342,2314,2280,2246,2212,2178,2144,2110) #17
TBL3390Z DS    0X           * END OF TABLE *
*  FOLLOWING PLACED HERE SO IFOX00 WILL WORK WITH THIS.
*  NOTE - 'TB3390IC' IS USED BY 'ICM' INSTRUCTION.  IT MUST
*      CORRESPOND TO LENGTH OF EACH TABLE ITEM.
*      IF TABLE ITEM IS 4 BYTES, THEN DEFINE AS  B'1111' ,
*      IF TABLE ITEM IS 3 BYTES, THEN DEFINE AS  B'0111' ,
*      IF TABLE ITEM IS 2 BYTES, THEN DEFINE AS  B'0011' .
TB3390IT EQU   2            LENGTH OF EACH TABLE ITEM.
TB3390IC EQU   B'0011'      USE FOR 'ICM' INSTRUCTIONS
TBL3390C EQU   (TBL3390F-TBL3390)
TB3390RL DC    A(TBL3390C)               LENGTH OF EACH ROW
TB3390CL DC    A(TBL3390C/TB3390IT)      NUMBER OF COLUMNS
TBL3390R EQU   (TBL3390Z-TBL3390)/TBL3390C
TB3390RW DC    A(TBL3390R)               NUMBER OF ROWS
*
*
*
TBL9345  DS    0F        ALIGN ON FULLWORD BOUNDARY
*                    0,  -22,  -56,  -90, -124, -158, -192, -226, -254
         DC  AL2(46456,46190,46162,46128,46094,46060,46026,45992)
         DC  AL2(45958,45930)                       BLOCKING FACTOR #1
TBL9345F DS    0H
         DC  AL2(22928,22662,22628,22594,22560,22526,22498,22464)
         DC  AL2(22430,22396)                                       #2
         DC  AL2(15074,14808,14774,14740,14706,14672,14638,14610)
         DC  AL2(14576,14542)                                       #3
         DC  AL2(11158,10898,10864,10830,10796,10762,10728,10694)
         DC  AL2(10666,10632)                                       #4
         DC  AL2(8810,8544,8510,8476,8442,8408,8374,8346,8312,8278) #5
         DC  AL2(7214,6954,6920,6886,6852,6818,6784,6750,6722,6688) #6
         DC  AL2(6088,5822,5794,5760,5726,5692,5658,5624,5590,5562) #7
         DC  AL2(5262,4996,4962,4928,4894,4866,4832,4798,4764,4730) #8
         DC  AL2(4600,4334,4300,4266,4232,4198,4170,4136,4102,4068) #9
         DC  AL2(4102,3836,3802,3768,3734,3706,3672,3638,3604,3570) #10
         DC  AL2(3672,3406,3372,3338,3304,3270,3242,3208,3174,3140) #11
         DC  AL2(3304,3038,3010,2976,2942,2908,2874,2840,2806,2778) #12
         DC  AL2(3010,2744,2710,2676,2642,2608,2574,2546,2512,2478) #13
         DC  AL2(2744,2478,2444,2410,2376,2342,2314,2280,2246,2212) #14
         DC  AL2(2512,2246,2212,2178,2144,2110,2082,2048,2014,1980) #15
         DC  AL2(2314,2048,2014,1980,1946,1912,1878,1850,1816,1782) #16
         DC  AL2(2144,1878,1850,2546,2512,2478,2444,2410,2376,2342) #17
TBL9345Z DS    0X           * END OF TABLE *
*
*
         PRINT GEN
         EJECT
         IKJCPPL
         SPACE 3
         IKJPPL
         SPACE 3
         IKJIOPL
         EJECT
         IKJECT
         SPACE 3
         END   BLKDISK
//*
//*  ALIAS NAMES FOR DEVICES YOU HAVE
//LINK.SYSLIN  DD
//             DD     *
 ALIAS BLK3390
 ALIAS BLK3380
 NAME BLKDISK(R)
//*
//*
//*
//*  NOTE: MAKE A VERSION OF THE FOLLOWING HELP DATA FOR EACH
//*        DEVICE TYPE TO BE SUPPORTED AT YOUR INSTALLATION.
//*
//*        FOR EACH DISK TYPE, CREATE A HELP MEMBER CALLED BLKXXXX
//*        WHERE XXXX IS ONE OF THE FOLLOWING: 23051, 23052,
//*        2314, 3330, 33301, 3340, 3350, 3375 OR 3380;
//*        THESE NAMES CORRESPOND TO DASD TYPES: 2305-1, 2305-2,
//*        2314, 3330, 3330-11, 3340, 3350, 3375 OR 3380.
//*
//*        COPY MEMBER BLKDISK, REPLACING YYYY IN THE TEXT WITH THE
//*        NAME OF ONE OF THE SUPPORTED DEVICE TYPES: 2305-1, 2305-2,
//*        2314, 3330, 3330-11, 3340, 3350, 3375 OR 3380.
//*
//*        ALSO, REPLACE BLKXXXX IN THE HELP TEXT WITH THE NAME OF
//*        THIS MEMBER (BLKXXXX OCCURS TWICE IN THE TEXT).
//*
//BDISK EXEC BCOPY,MEMBER=BLKDISK
//COPY.SYSUT1 DD *
)F FUNCTION -
  THE BLKDISK COMMAND COMPUTES AN OPTIMAL BLOCKSIZE FOR A DATA SET
  TO BE PLACED ON A YYYY DISK PACK.  THE PROGRAM OUTPUT INCLUDES
  THE FOLLOWING REPORTS:
     1.  A SUMMARY BLOCKSIZE REPORT FOR THE GIVEN LRECL AND KEY
         LENGTH WHICH INCLUDES THE RECOMMENDED BLOCKSIZE TO USE.
     2.  A RECOMMENDED DATA SET SPACE ALLOCATION.
     3.  A OPTIONAL TRACK CAPACITY REPORT FOR THE PROVIDED KEY LENGTH.

  THE RECOMMENDED BLOCKSIZE VALUE IS FOR DATA SETS IN WHICH THE
  PREDOMINANT ACCESS IS SEQUENTIAL; FOR DATA SETS WHERE RANDOM
  ACCESS TIME IS CRITICAL OR THE USUAL ACCESS IS RANDOM, A SMALL
  BLOCKSIZE (500-2000 BYTES) SHOULD PROBABLY BE USED.

  THE RECOMMENDED BLOCKSIZE WILL USUALLY TEND TO BE NEAR A HALF-TRACK
  FIGURE AS THIS IS CONSIDERED TO BE THE MOST EFFICIENT IN TERMS OF
  THE TRADE-OFFS AMONG BUFFER SIZE, SECONDARY STORAGE REQUIREMENTS,
  CHANNEL USE, NUMBER OF INPUT/OUTPUTS AND OVERALL PROCESSING TIME.
  THIS FIGURE IS ONLY A GENERAL GUIDE; FOR MAXIMAL EFFICIENCY
  CONSIDERING OTHER FACTORS, STUDY THE GENERATED BLOCKSIZE SUMMARY
  REPORT OR A TRACK CAPACITY REPORT.

  THE PROGRAM'S RECOMMENDATIONS ASSUME A FAIRLY LARGE AMOUNT OF DATA
  IS TO BE STORED; DATA SETS WHICH OCCUPY ONLY A FEW TRACKS SHOULD
  PROBABLY BE PLACED IN PARTITIONED DATA SETS.  IN CASES WHERE THIS
  IS NOT FEASIBLE, THE USE OF A SMALL BLOCKSIZE (2400 - 4000 BYTES)
  MAY BE A GOOD ALTERNATIVE PRACTICE.
)X SYNTAX  -
         BLKDISK  'LRECL'  KEYLENGTH('INTEGER')
                           TRACKCAP / NOTRACKCAP
                           BLKSIZE('INTEGER')
                           NUMBER('INTEGER') / RECORDS('INTEGER')
                           VERIFY
  REQUIRED - LRECL
  DEFAULTS - KEYLENGTH(0),
             NOTRACKCAP,
             BLKSIZE(RECOMMENDED VALUE),
             NUMBER(100000)
)O OPERANDS -
 'LRECL'  - THE LOGICAL RECORD LENGTH OF THE DATA WHICH IS TO BE
            PLACED IN THE DATA SET.
))KEYLENGTH('INTEGER')
          - THE KEY LENGTH, IN BYTES, OF THE KEYS TO BE USED IN THE
            DATA SET.  THE MAXIMUM LEGAL KEY LENGTH IS 255.
))TRACKCAP
          - SPECIFIES THAT A TRACK CAPACITY REPORT IS TO BE PROVIDED
            FOR THE DEVICE USING THE SPECIFIED (OR DEFAULT) KEY LENGTH.

            NOTE THAT A TRACK CAPACITY REPORT IS ALSO PROVIDED IF
            NOTRACKCAP IS NOT SPECIFIED AND LRECL EXCEEDS THE MAXIMUM
            BLOCKSIZE FOR A TRACK OR BLKSIZE EXCEEDS THE MAXIMUM
            BLOCKSIZE FOR A TRACK.
))NOTRACKCAP
          - SPECIFIES THAT A TRACK CAPACITY REPORT IS NOT DESIRED.
))BLKSIZE('INTEGER')
          - THE BLOCKSIZE TO USE FOR THE ALLOCATION COMPUTATION; IF
            BLKSIZE IS NOT ENTERED (OR ZERO IS ENTERED), THE PROGRAM'S
            RECOMMENDED BLOCKSIZE WILL BE USED.
))NUMBER('INTEGER')
          - THE NUMBER OF LOGICAL RECORDS THAT WILL BE IN THE DATA SET.
))RECORDS('INTEGER')
          - THE NUMBER OF LOGICAL RECORDS THAT WILL BE IN THE DATA SET.
))VERIFY  - SPECIFIES THAT THE MVS "TRKCALC" ROUTINE IS TO BE USED TO
            VERIFY TRACK CAPACITY CALCULATIONS.  IF VERIFY IS USED,
            THE NUMBER OF CALLS TO "TRKCALC" TO DETERMINE A TRACK
            CAPACITY TABLE IS OUTPUT AT THE END OF THE OUTPUT.

            NOTE: WITH VERIFY ON, A MINIMUM OF 34 CALLS IS REQUIRED TO
            DETERMINE A TRACK CAPACITY TABLE; OTHERWISE A MINIMUM OF
            17 CALLS IS REQUIRED TO DETERMINE THE TRACK CAPACITY TABLE.
//*
//B3380 EXEC BCOPY,MEMBER=BLK3380
//COPY.SYSUT1 DD *
)F FUNCTION -
  THE BLK3380 COMMAND COMPUTES AN OPTIMAL BLOCKSIZE FOR A DATA SET
  TO BE PLACED ON A 3380 DISK PACK.  THE PROGRAM OUTPUT INCLUDES
  THE FOLLOWING REPORTS:
     1.  A SUMMARY BLOCKSIZE REPORT FOR THE GIVEN LRECL AND KEY
         LENGTH WHICH INCLUDES THE RECOMMENDED BLOCKSIZE TO USE.
     2.  A RECOMMENDED DATA SET SPACE ALLOCATION.
     3.  A OPTIONAL TRACK CAPACITY REPORT FOR THE PROVIDED KEY LENGTH.

  THE RECOMMENDED BLOCKSIZE VALUE IS FOR DATA SETS IN WHICH THE
  PREDOMINANT ACCESS IS SEQUENTIAL; FOR DATA SETS WHERE RANDOM
  ACCESS TIME IS CRITICAL OR THE USUAL ACCESS IS RANDOM, A SMALL
  BLOCKSIZE (500-2000 BYTES) SHOULD PROBABLY BE USED.

  THE RECOMMENDED BLOCKSIZE WILL USUALLY TEND TO BE NEAR A HALF-TRACK
  FIGURE AS THIS IS CONSIDERED TO BE THE MOST EFFICIENT IN TERMS OF
  THE TRADE-OFFS AMONG BUFFER SIZE, SECONDARY STORAGE REQUIREMENTS,
  CHANNEL USE, NUMBER OF INPUT/OUTPUTS AND OVERALL PROCESSING TIME.
  THIS FIGURE IS ONLY A GENERAL GUIDE; FOR MAXIMAL EFFICIENCY
  CONSIDERING OTHER FACTORS, STUDY THE GENERATED BLOCKSIZE SUMMARY
  REPORT OR A TRACK CAPACITY REPORT.

  THE PROGRAM'S RECOMMENDATIONS ASSUME A FAIRLY LARGE AMOUNT OF DATA
  IS TO BE STORED; DATA SETS WHICH OCCUPY ONLY A FEW TRACKS SHOULD
  PROBABLY BE PLACED IN PARTITIONED DATA SETS.  IN CASES WHERE THIS
  IS NOT FEASIBLE, THE USE OF A SMALL BLOCKSIZE (2400 - 4000 BYTES)
  MAY BE A GOOD ALTERNATIVE PRACTICE.
)X SYNTAX  -
         BLK3380  'LRECL'  KEYLENGTH('INTEGER')
                           TRACKCAP / NOTRACKCAP
                           BLKSIZE('INTEGER')
                           NUMBER('INTEGER') / RECORDS('INTEGER')
                           VERIFY
  REQUIRED - LRECL
  DEFAULTS - KEYLENGTH(0),
             NOTRACKCAP,
             BLKSIZE(RECOMMENDED VALUE),
             NUMBER(100000)
)O OPERANDS -
 'LRECL'  - THE LOGICAL RECORD LENGTH OF THE DATA WHICH IS TO BE
            PLACED IN THE DATA SET.
))KEYLENGTH('INTEGER')
          - THE KEY LENGTH, IN BYTES, OF THE KEYS TO BE USED IN THE
            DATA SET.  THE MAXIMUM LEGAL KEY LENGTH IS 255.
))TRACKCAP
          - SPECIFIES THAT A TRACK CAPACITY REPORT IS TO BE PROVIDED
            FOR THE DEVICE USING THE SPECIFIED (OR DEFAULT) KEY LENGTH.

            NOTE THAT A TRACK CAPACITY REPORT IS ALSO PROVIDED IF
            NOTRACKCAP IS NOT SPECIFIED AND LRECL EXCEEDS THE MAXIMUM
            BLOCKSIZE FOR A TRACK OR BLKSIZE EXCEEDS THE MAXIMUM
            BLOCKSIZE FOR A TRACK.
))NOTRACKCAP
          - SPECIFIES THAT A TRACK CAPACITY REPORT IS NOT DESIRED.
))BLKSIZE('INTEGER')
          - THE BLOCKSIZE TO USE FOR THE ALLOCATION COMPUTATION; IF
            BLKSIZE IS NOT ENTERED (OR ZERO IS ENTERED), THE PROGRAM'S
            RECOMMENDED BLOCKSIZE WILL BE USED.
))NUMBER('INTEGER')
          - THE NUMBER OF LOGICAL RECORDS THAT WILL BE IN THE DATA SET.
))RECORDS('INTEGER')
          - THE NUMBER OF LOGICAL RECORDS THAT WILL BE IN THE DATA SET.
))VERIFY  - SPECIFIES THAT THE MVS "TRKCALC" ROUTINE IS TO BE USED TO
            VERIFY TRACK CAPACITY CALCULATIONS.  IF VERIFY IS USED,
            THE NUMBER OF CALLS TO "TRKCALC" TO DETERMINE A TRACK
            CAPACITY TABLE IS OUTPUT AT THE END OF THE OUTPUT.

            NOTE: WITH VERIFY ON, A MINIMUM OF 34 CALLS IS REQUIRED TO
            DETERMINE A TRACK CAPACITY TABLE; OTHERWISE A MINIMUM OF
            17 CALLS IS REQUIRED TO DETERMINE THE TRACK CAPACITY TABLE.
//*
//B3390 EXEC BCOPY,MEMBER=BLK3390
//COPY.SYSUT1 DD *
)F FUNCTION -
  THE BLK3390 COMMAND COMPUTES AN OPTIMAL BLOCKSIZE FOR A DATA SET
  TO BE PLACED ON A 3390 DISK PACK.  THE PROGRAM OUTPUT INCLUDES
  THE FOLLOWING REPORTS:
     1.  A SUMMARY BLOCKSIZE REPORT FOR THE GIVEN LRECL AND KEY
         LENGTH WHICH INCLUDES THE RECOMMENDED BLOCKSIZE TO USE.
     2.  A RECOMMENDED DATA SET SPACE ALLOCATION.
     3.  A OPTIONAL TRACK CAPACITY REPORT FOR THE PROVIDED KEY LENGTH.

  THE RECOMMENDED BLOCKSIZE VALUE IS FOR DATA SETS IN WHICH THE
  PREDOMINANT ACCESS IS SEQUENTIAL; FOR DATA SETS WHERE RANDOM
  ACCESS TIME IS CRITICAL OR THE USUAL ACCESS IS RANDOM, A SMALL
  BLOCKSIZE (500-2000 BYTES) SHOULD PROBABLY BE USED.

  THE RECOMMENDED BLOCKSIZE WILL USUALLY TEND TO BE NEAR A HALF-TRACK
  FIGURE AS THIS IS CONSIDERED TO BE THE MOST EFFICIENT IN TERMS OF
  THE TRADE-OFFS AMONG BUFFER SIZE, SECONDARY STORAGE REQUIREMENTS,
  CHANNEL USE, NUMBER OF INPUT/OUTPUTS AND OVERALL PROCESSING TIME.
  THIS FIGURE IS ONLY A GENERAL GUIDE; FOR MAXIMAL EFFICIENCY
  CONSIDERING OTHER FACTORS, STUDY THE GENERATED BLOCKSIZE SUMMARY
  REPORT OR A TRACK CAPACITY REPORT.

  THE PROGRAM'S RECOMMENDATIONS ASSUME A FAIRLY LARGE AMOUNT OF DATA
  IS TO BE STORED; DATA SETS WHICH OCCUPY ONLY A FEW TRACKS SHOULD
  PROBABLY BE PLACED IN PARTITIONED DATA SETS.  IN CASES WHERE THIS
  IS NOT FEASIBLE, THE USE OF A SMALL BLOCKSIZE (2400 - 4000 BYTES)
  MAY BE A GOOD ALTERNATIVE PRACTICE.
)X SYNTAX  -
         BLK3390  'LRECL'  KEYLENGTH('INTEGER')
                           TRACKCAP / NOTRACKCAP
                           BLKSIZE('INTEGER')
                           NUMBER('INTEGER') / RECORDS('INTEGER')
                           VERIFY
  REQUIRED - LRECL
  DEFAULTS - KEYLENGTH(0),
             NOTRACKCAP,
             BLKSIZE(RECOMMENDED VALUE),
             NUMBER(100000)
)O OPERANDS -
 'LRECL'  - THE LOGICAL RECORD LENGTH OF THE DATA WHICH IS TO BE
            PLACED IN THE DATA SET.
))KEYLENGTH('INTEGER')
          - THE KEY LENGTH, IN BYTES, OF THE KEYS TO BE USED IN THE
            DATA SET.  THE MAXIMUM LEGAL KEY LENGTH IS 255.
))TRACKCAP
          - SPECIFIES THAT A TRACK CAPACITY REPORT IS TO BE PROVIDED
            FOR THE DEVICE USING THE SPECIFIED (OR DEFAULT) KEY LENGTH.

            NOTE THAT A TRACK CAPACITY REPORT IS ALSO PROVIDED IF
            NOTRACKCAP IS NOT SPECIFIED AND LRECL EXCEEDS THE MAXIMUM
            BLOCKSIZE FOR A TRACK OR BLKSIZE EXCEEDS THE MAXIMUM
            BLOCKSIZE FOR A TRACK.
))NOTRACKCAP
          - SPECIFIES THAT A TRACK CAPACITY REPORT IS NOT DESIRED.
))BLKSIZE('INTEGER')
          - THE BLOCKSIZE TO USE FOR THE ALLOCATION COMPUTATION; IF
            BLKSIZE IS NOT ENTERED (OR ZERO IS ENTERED), THE PROGRAM'S
            RECOMMENDED BLOCKSIZE WILL BE USED.
))NUMBER('INTEGER')
          - THE NUMBER OF LOGICAL RECORDS THAT WILL BE IN THE DATA SET.
))RECORDS('INTEGER')
          - THE NUMBER OF LOGICAL RECORDS THAT WILL BE IN THE DATA SET.
))VERIFY  - SPECIFIES THAT THE MVS "TRKCALC" ROUTINE IS TO BE USED TO
            VERIFY TRACK CAPACITY CALCULATIONS.  IF VERIFY IS USED,
            THE NUMBER OF CALLS TO "TRKCALC" TO DETERMINE A TRACK
            CAPACITY TABLE IS OUTPUT AT THE END OF THE OUTPUT.

            ** N O T E **  - NOT CURRENTLY SUPPORTED FOR 3390.

            NOTE: WITH VERIFY ON, A MINIMUM OF 34 CALLS IS REQUIRED TO
            DETERMINE A TRACK CAPACITY TABLE; OTHERWISE A MINIMUM OF
            17 CALLS IS REQUIRED TO DETERMINE THE TRACK CAPACITY TABLE.
//*
//B9345 EXEC BCOPY,MEMBER=BLK9345
//COPY.SYSUT1 DD *
)F FUNCTION -
  THE BLK9345 COMMAND COMPUTES AN OPTIMAL BLOCKSIZE FOR A DATA SET
  TO BE PLACED ON A 9345 DISK PACK.  THE PROGRAM OUTPUT INCLUDES
  THE FOLLOWING REPORTS:
     1.  A SUMMARY BLOCKSIZE REPORT FOR THE GIVEN LRECL AND KEY
         LENGTH WHICH INCLUDES THE RECOMMENDED BLOCKSIZE TO USE.
     2.  A RECOMMENDED DATA SET SPACE ALLOCATION.
     3.  A OPTIONAL TRACK CAPACITY REPORT FOR THE PROVIDED KEY LENGTH.

  THE RECOMMENDED BLOCKSIZE VALUE IS FOR DATA SETS IN WHICH THE
  PREDOMINANT ACCESS IS SEQUENTIAL; FOR DATA SETS WHERE RANDOM
  ACCESS TIME IS CRITICAL OR THE USUAL ACCESS IS RANDOM, A SMALL
  BLOCKSIZE (500-2000 BYTES) SHOULD PROBABLY BE USED.

  THE RECOMMENDED BLOCKSIZE WILL USUALLY TEND TO BE NEAR A HALF-TRACK
  FIGURE AS THIS IS CONSIDERED TO BE THE MOST EFFICIENT IN TERMS OF
  THE TRADE-OFFS AMONG BUFFER SIZE, SECONDARY STORAGE REQUIREMENTS,
  CHANNEL USE, NUMBER OF INPUT/OUTPUTS AND OVERALL PROCESSING TIME.
  THIS FIGURE IS ONLY A GENERAL GUIDE; FOR MAXIMAL EFFICIENCY
  CONSIDERING OTHER FACTORS, STUDY THE GENERATED BLOCKSIZE SUMMARY
  REPORT OR A TRACK CAPACITY REPORT.

  THE PROGRAM'S RECOMMENDATIONS ASSUME A FAIRLY LARGE AMOUNT OF DATA
  IS TO BE STORED; DATA SETS WHICH OCCUPY ONLY A FEW TRACKS SHOULD
  PROBABLY BE PLACED IN PARTITIONED DATA SETS.  IN CASES WHERE THIS
  IS NOT FEASIBLE, THE USE OF A SMALL BLOCKSIZE (2400 - 4000 BYTES)
  MAY BE A GOOD ALTERNATIVE PRACTICE.
)X SYNTAX  -
         BLK9345  'LRECL'  KEYLENGTH('INTEGER')
                           TRACKCAP / NOTRACKCAP
                           BLKSIZE('INTEGER')
                           NUMBER('INTEGER') / RECORDS('INTEGER')
                           VERIFY
  REQUIRED - LRECL
  DEFAULTS - KEYLENGTH(0),
             NOTRACKCAP,
             BLKSIZE(RECOMMENDED VALUE),
             NUMBER(100000)
)O OPERANDS -
 'LRECL'  - THE LOGICAL RECORD LENGTH OF THE DATA WHICH IS TO BE
            PLACED IN THE DATA SET.
))KEYLENGTH('INTEGER')
          - THE KEY LENGTH, IN BYTES, OF THE KEYS TO BE USED IN THE
            DATA SET.  THE MAXIMUM LEGAL KEY LENGTH IS 255.
))TRACKCAP
          - SPECIFIES THAT A TRACK CAPACITY REPORT IS TO BE PROVIDED
            FOR THE DEVICE USING THE SPECIFIED (OR DEFAULT) KEY LENGTH.

            NOTE THAT A TRACK CAPACITY REPORT IS ALSO PROVIDED IF
            NOTRACKCAP IS NOT SPECIFIED AND LRECL EXCEEDS THE MAXIMUM
            BLOCKSIZE FOR A TRACK OR BLKSIZE EXCEEDS THE MAXIMUM
            BLOCKSIZE FOR A TRACK.
))NOTRACKCAP
          - SPECIFIES THAT A TRACK CAPACITY REPORT IS NOT DESIRED.
))BLKSIZE('INTEGER')
          - THE BLOCKSIZE TO USE FOR THE ALLOCATION COMPUTATION; IF
            BLKSIZE IS NOT ENTERED (OR ZERO IS ENTERED), THE PROGRAM'S
            RECOMMENDED BLOCKSIZE WILL BE USED.
))NUMBER('INTEGER')
          - THE NUMBER OF LOGICAL RECORDS THAT WILL BE IN THE DATA SET.
))RECORDS('INTEGER')
          - THE NUMBER OF LOGICAL RECORDS THAT WILL BE IN THE DATA SET.
))VERIFY  - SPECIFIES THAT THE MVS "TRKCALC" ROUTINE IS TO BE USED TO
            VERIFY TRACK CAPACITY CALCULATIONS.  IF VERIFY IS USED,
            THE NUMBER OF CALLS TO "TRKCALC" TO DETERMINE A TRACK
            CAPACITY TABLE IS OUTPUT AT THE END OF THE OUTPUT.

            ** N O T E **  - NOT CURRENTLY SUPPORTED FOR 9345.

            NOTE: WITH VERIFY ON, A MINIMUM OF 34 CALLS IS REQUIRED TO
            DETERMINE A TRACK CAPACITY TABLE; OTHERWISE A MINIMUM OF
            17 CALLS IS REQUIRED TO DETERMINE THE TRACK CAPACITY TABLE.
//*
//BX EXEC BXEQ
//XEQ.SYSTSIN DD *
 BLK3380   80 TR VERIFY
 BLK3390   80 TR VERIFY
//*