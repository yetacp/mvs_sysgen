//FSI   JOB (JOB),
//           'INSTALL FSI',
//           CLASS=A,
//           MSGCLASS=A,
//           MSGLEVEL=(1,1),
//           USER=IBMUSER,
//           PASSWORD=SYS1
//CLEANUP EXEC PGM=IDCAMS
//SYSIN    DD *
  DELETE SYSGEN.FSI.ASM
  DELETE SYSGEN.FSI.CLIST
  DELETE SYSGEN.FSI.JCL
  DELETE SYSGEN.FSI.MLIB
  DELETE SYSGEN.FSI.PLIB
  DELETE SYSGEN.FSI.SAMP
  DELETE SYSGEN.FSI.OBJ
  DELETE SYSGEN.FSI.LOAD
  SET MAXCC=0
//SYSPRINT DD  SYSOUT=*
//* -----------------------------------
//SASM    EXEC PGM=PDSLOAD
//STEPLIB  DD  DSN=SYSC.LINKLIB,DISP=SHR
//SYSPRINT DD  SYSOUT=*
//SYSUT2   DD  DSN=SYSGEN.FSI.ASM,
//             UNIT=SYSALLDA,VOL=SER=PUB001,
//             SPACE=(CYL,(15,2,20),RLSE),
//             DISP=(NEW,CATLG,DELETE)
//SYSUT1   DD  DATA,DLM=@@
./ ADD NAME=$DISPLAY
         MACRO
&ID      $DISPLAY &PARMS
         LCLC  &NDX
         LCLC  &PANEL,&MSGID,&CURSOR
         LCLC  &PNL,&MSG,&CSR
         LCLC  &PNLK,&MSGK,&CSRK
         LCLB  &PNLB,&MSGB,&CSRB
&NDX     SETC  '&SYSNDX'
.*
.*-----------------------------------------------------------
.*
         AIF   (N'&PARMS GE 1).PNL0
         MNOTE 8,'PANEL NAME NOT SPECIFIED'
         MEXIT ,
.PNL0    ANOP  ,
&PANEL   SETC  '&PARMS(1)'
         AIF   ('&PANEL'(1,1) EQ '''').PNL1
&PNL     SETC  '&PANEL'
         AGO   .PNL2
.*
.PNL1    ANOP  ,
&PNL     SETC  'IHB2&NDX'
&PNLK    SETC  '&PANEL'
&PNLB    SETB  1
.PNL2    ANOP  ,
.*
.*-----------------------------------------------------------
.*
         AIF   (N'&PARMS GE 2).MSG0
&MSG     SETC  '0'
         AGO   .MSG2
.MSG0    ANOP  ,
&MSGID   SETC  '&PARMS(2)'
         AIF   ('&MSGID'(1,1) EQ '''').MSG1
&MSG     SETC  '&MSGID'
         AGO   .MSG2
.*
.MSG1    ANOP  ,
&MSG     SETC  'IHB3&NDX'
&MSGK    SETC  '&MSGID'
&MSGB    SETB  1
.MSG2    ANOP  ,
.*
.*-----------------------------------------------------------
.*
         AIF   (N'&PARMS GE 3).CSR0
&CSR     SETC  '0'
         AGO   .CSR2
.CSR0    ANOP  ,
&CURSOR  SETC  '&PARMS(3)'
         AIF   ('&CURSOR'(1,1) EQ '''').CSR1
&CSR     SETC  '&CURSOR'
         AGO   .CSR2
.*
.CSR1    ANOP  ,
&CSR     SETC  'IHB4&NDX'
&CSRK    SETC  '&MSGID'
&CSRB    SETB  1
.CSR2    ANOP  ,
.*
.*-----------------------------------------------------------
.*
         CNOP  0,4
&ID      BAL   1,IHB1&SYSNDX
         DC    A(&PNL)
         DC    A(&MSG)
         DC    A(&CSR)
         AIF   (&PNLB EQ 0).PNL3
IHB2&NDX DC    CL8&PNLK
.PNL3    AIF   (&MSGB EQ 0).MSG3
IHB3&NDX DC    CL8&MSGK
.MSG3    AIF   (&CSRB EQ 0).CSR3
IHB4&NDX DC    CL8&CSRK
.CSR3    ANOP  ,
IHB1&NDX DS    0H
         L     15,=V(DISPLAY)
         BALR  14,15
         MEND  ,
./ ADD NAME=$FSIECT
         MACRO
         $FSIECT
*
* ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** **
*
ECT$IO   EQU   B'00000011'        TYPE MASK
ECT$IN   EQU   B'00000001'        TYPE(INPUT)
ECT$OUT  EQU   B'00000011'        TYPE(OUTPUT)
ECT$TEXT EQU   B'00000010'        TYPE(TEXT)
*
*
ECT$INTN EQU   B'00001100'        INTENSITY MASK
ECT$LOW  EQU   B'00001100'        INTENS(LOW)
ECT$HI   EQU   B'00000100'        INTENS(HIGH)
ECT$NON  EQU   B'00001000'        INTENS(NON)
*
ECT$OUTL EQU   B'00001111'
ECT$INL  EQU   B'00001101'
ECT$TXTL EQU   B'00001110'
ECT$OUTH EQU   B'00000111'
ECT$INH  EQU   B'00000101'
ECT$TXTH EQU   B'00000110'
ECT$INN  EQU   B'00001001'
*
* ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** **
*
         MEND  ,
./ ADD NAME=$FSISCR
         MACRO
         $FSISCR
SCR      DSECT ,
SCRATTRS DS    A             ATTR CHAR ARRAY  C' ',X'ATTR'
*                            X'FFFF' MARKS END OF LIST
SCRPANEL DS    A             PANEL INPUT 24CL80
SCRZVARS DS    A             ARRAY OF ZVAR NAMES CL8' '
*                            X'FFFFFFFFFFFFFFFF' MARKS END OF LIST
SCRMSG   DS    A             MESSAGE TO BE DISPLAYED
*                            NULL OR POINTER TO (H'LEN',C'DATA')
SCRAID   DS    CL8           ACTION ID
SCRCSR   DS    CL8           CURSOR FIELD
SCRELEN  EQU   *-SCR
         MEND  ,
./ ADD NAME=$VDEF
         MACRO
&ID      $VDEF &PARMS
         LCLC  &NDX
         LCLC  &NAME,&LEN,&AREA,&TYPE,&OPT
         LCLC  &NM,&LN,&AR,&TP,&OP
         LCLC  &NMK,&LNK,&ARK,&TPK,&OPK
         LCLB  &NMB,&LNB,&ARB,&TPB,&OPB
&NDX     SETC  '&SYSNDX'
         AIF   (N'&PARMS EQ 5).OK1
         MNOTE 8,'INVALID NUMBER OF PARAMETERS SPECIFIED'
         MEXIT ,
.*
.OK1     ANOP  ,
&NAME    SETC  '&PARMS(1)'
&AREA    SETC  '&PARMS(2)'
&TYPE    SETC  '&PARMS(3)'
&LEN     SETC  '&PARMS(4)'
&OPT     SETC  '&PARMS(5)'
.*
         AIF   ('&NAME'(1,1) EQ '''').NM1
&NM      SETC  '&NAME'
         AGO   .NM2
.NM1     ANOP  ,
&NM      SETC  'IHB2&NDX'
&NMK     SETC  '&NAME'
&NMB     SETB  1
.NM2     ANOP  ,
.* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
         AIF   ('&LEN'(1,1) EQ '''').LN1
         AIF   ('&LEN'(1,1) GE '0').LN1A
&LN      SETC  '&LEN'
         AGO   .LN2
.LN1     ANOP  ,
&LN      SETC  'IHB3&NDX'
&LNK     SETC  '&LEN'
&LNB     SETB  1
         AGO   .LN2
.LN1A    ANOP  ,
&LN      SETC  'IHB3&NDX'
&LNK     SETC  '''&LEN'''
&LNB     SETB  1
         AGO   .LN2
.LN2     ANOP  ,
.* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
         AIF   ('&AREA'(1,1) EQ '''').AR1
&AR      SETC  '&AREA'
         AGO   .AR2
.AR1     ANOP  ,
         MNOTE 8,'INVALID OPERAND SPECIFIED FOR AREA'
         MEXIT ,
.AR2     ANOP  ,
.* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
         CNOP  0,4
&ID      BAL   1,IHB1&SYSNDX
         DC    A(&NM)
         DC    A(&AR)
         DC    A(IHB5&NDX)
         DC    A(&LN)
         DC    A(IHB6&NDX)
         AIF   (&NMB EQ 0).GN1
IHB2&NDX DC    CL8&NMK
.GN1     AIF   (&LNB EQ 0).GN2
IHB3&NDX DC    F&LNK
.GN2     AIF   (&ARB EQ 0).GN3
IHB4&NDX DC    A(&ARK)
.GN3     ANOP  ,
IHB5&NDX DC    F'&TYPE'
IHB6&NDX DC    F'0'
IHB1&NDX DS    0H
         L     15,=V(VDEFINE)
         BALR  14,15
         MEND  ,
./ ADD NAME=$VGET
         MACRO
&ID      $VGET &PARMS
         LCLC  &NDX
         LCLC  &NAME,&LEN,&AREA
         LCLC  &NM,&LN,&AR
         LCLC  &NMK,&LNK,&ARK
         LCLB  &NMB,&LNB,&ARB
&NDX     SETC  '&SYSNDX'
         AIF   (N'&PARMS EQ 3).OK1
         MNOTE 8,'INVALID NUMBER OF PARAMETERS SPECIFIED'
         MEXIT ,
.*
.OK1     ANOP  ,
&NAME    SETC  '&PARMS(1)'
&LEN     SETC  '&PARMS(2)'
&AREA    SETC  '&PARMS(3)'
.*
         AIF   ('&NAME'(1,1) EQ '''').NM1
&NM      SETC  '&NAME'
         AGO   .NM2
.NM1     ANOP  ,
&NM      SETC  'IHB2&NDX'
&NMK     SETC  '&NAME'
&NMB     SETB  1
.NM2     ANOP  ,
.* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
         AIF   ('&LEN'(1,1) EQ '''').LN1
         AIF   ('&LEN'(1,1) GE '0').LN1A
&LN      SETC  '&LEN'
         AGO   .LN2
.LN1     ANOP  ,
&LN      SETC  'IHB3&NDX'
&LNK     SETC  '&LEN'
&LNB     SETB  1
         AGO   .LN2
.LN1A    ANOP  ,
&LN      SETC  'IHB3&NDX'
&LNK     SETC  '''&LEN'''
&LNB     SETB  1
         AGO   .LN2
.LN2     ANOP  ,
.* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
         AIF   ('&AREA'(1,1) EQ '''').AR1
&AR      SETC  '&AREA'
         AGO   .AR2
.AR1     ANOP  ,
         MNOTE 8,'INVALID OPERAND SPECIFIED FOR AREA'
         MEXIT ,
.AR2     ANOP  ,
.* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
         CNOP  0,4
&ID      BAL   1,IHB1&SYSNDX
         DC    A(&NM)
         DC    A(&LN)
         DC    A(&AR)
         AIF   (&NMB EQ 0).GN1
IHB2&NDX DC    CL8&NMK
.GN1     AIF   (&LNB EQ 0).GN2
IHB3&NDX DC    F&LNK
.GN2     AIF   (&ARB EQ 0).GN3
IHB4&NDX DC    A(&ARK)
.GN3     ANOP  ,
IHB1&NDX DS    0H
         L     15,=V(VGET)
         BALR  14,15
         MEND  ,
./ ADD NAME=$VLOC
         MACRO
&ID      $VLOC &PARMS
         LCLC  &NDX
         LCLC  &NAME,&LEN,&AREA
         LCLC  &NM,&LN,&AR
         LCLC  &NMK,&LNK,&ARK
         LCLB  &NMB,&LNB,&ARB
&NDX     SETC  '&SYSNDX'
         AIF   (N'&PARMS EQ 3).OK1
         MNOTE 8,'INVALID NUMBER OF PARAMETERS SPECIFIED'
         MEXIT ,
.*
.OK1     ANOP  ,
&NAME    SETC  '&PARMS(1)'
&LEN     SETC  '&PARMS(2)'
&AREA    SETC  '&PARMS(3)'
.*
         AIF   ('&NAME'(1,1) EQ '''').NM1
&NM      SETC  '&NAME'
         AGO   .NM2
.NM1     ANOP  ,
&NM      SETC  'IHB2&NDX'
&NMK     SETC  '&NAME'
&NMB     SETB  1
.NM2     ANOP  ,
.* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
         AIF   ('&LEN'(1,1) EQ '''').LN1
         AIF   ('&LEN'(1,1) GE '0').LN1A
&LN      SETC  '&LEN'
         AGO   .LN2
.LN1     ANOP  ,
&LN      SETC  'IHB3&NDX'
&LNK     SETC  '&LEN'
&LNB     SETB  1
         AGO   .LN2
.LN1A    ANOP  ,
&LN      SETC  'IHB3&NDX'
&LNK     SETC  '''&LEN'''
&LNB     SETB  1
         AGO   .LN2
.LN2     ANOP  ,
.* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
         AIF   ('&AREA'(1,1) EQ '''').AR1
&AR      SETC  '&AREA'
         AGO   .AR2
.AR1     ANOP  ,
         MNOTE 8,'INVALID OPERAND SPECIFIED FOR AREA'
         MEXIT ,
.AR2     ANOP  ,
.* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
         CNOP  0,4
&ID      BAL   1,IHB1&SYSNDX
         DC    A(&NM)
         DC    A(&LN)
         DC    A(&AR)
         AIF   (&NMB EQ 0).GN1
IHB2&NDX DC    CL8&NMK
.GN1     AIF   (&LNB EQ 0).GN2
IHB3&NDX DC    F&LNK
.GN2     AIF   (&ARB EQ 0).GN3
IHB4&NDX DC    A(&ARK)
.GN3     ANOP  ,
IHB1&NDX DS    0H
         L     15,=V(VLOC)
         BALR  14,15
         MEND  ,
./ ADD NAME=$VPUT
         MACRO
&ID      $VPUT &PARMS
         LCLC  &NDX
         LCLC  &NAME,&LEN,&AREA
         LCLC  &NM,&LN,&AR
         LCLC  &NMK,&LNK,&ARK
         LCLB  &NMB,&LNB,&ARB
&NDX     SETC  '&SYSNDX'
         AIF   (N'&PARMS EQ 3).OK1
         MNOTE 8,'INVALID NUMBER OF PARAMETERS SPECIFIED'
         MEXIT ,
.*
.OK1     ANOP  ,
&NAME    SETC  '&PARMS(1)'
&LEN     SETC  '&PARMS(2)'
&AREA    SETC  '&PARMS(3)'
.*
         AIF   ('&NAME'(1,1) EQ '''').NM1
&NM      SETC  '&NAME'
         AGO   .NM2
.NM1     ANOP  ,
&NM      SETC  'IHB2&NDX'
&NMK     SETC  '&NAME'
&NMB     SETB  1
.NM2     ANOP  ,
.* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
         AIF   ('&LEN'(1,1) EQ '''').LN1
         AIF   ('&LEN'(1,1) GE '0').LN1A
&LN      SETC  '&LEN'
         AGO   .LN2
.LN1     ANOP  ,
&LN      SETC  'IHB3&NDX'
&LNK     SETC  '&LEN'
&LNB     SETB  1
         AGO   .LN2
.LN1A    ANOP  ,
&LN      SETC  'IHB3&NDX'
&LNK     SETC  '''&LEN'''
&LNB     SETB  1
         AGO   .LN2
.LN2     ANOP  ,
.* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
         AIF   ('&AREA'(1,1) EQ '''').AR1
&AR      SETC  '&AREA'
         AGO   .AR2
.AR1     ANOP  ,
&AR      SETC  'IHB4&NDX'
&ARK     SETC  '&AREA'
&ARB     SETB  1
.AR2     ANOP  ,
.* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
         CNOP  0,4
&ID      BAL   1,IHB1&SYSNDX
         DC    A(&NM)
         DC    A(&LN)
         DC    A(&AR)
         AIF   (&NMB EQ 0).GN1
IHB2&NDX DC    CL8&NMK
.GN1     AIF   (&LNB EQ 0).GN2
IHB3&NDX DC    F&LNK
.GN2     AIF   (&ARB EQ 0).GN3
IHB4&NDX DC    C&ARK
.GN3     ANOP  ,
IHB1&NDX DS    0H
         L     15,=V(VPUT)
         BALR  14,15
         MEND  ,
./ ADD NAME=$VSTO
         MACRO
&ID      $VSTO &PARMS
         LCLC  &NDX
         LCLC  &NAME,&LEN,&AREA
         LCLC  &NM,&LN,&AR
         LCLC  &NMK,&LNK,&ARK
         LCLB  &NMB,&LNB,&ARB
&NDX     SETC  '&SYSNDX'
         AIF   (N'&PARMS EQ 3).OK1
         MNOTE 8,'INVALID NUMBER OF PARAMETERS SPECIFIED'
         MEXIT ,
.*
.OK1     ANOP  ,
&NAME    SETC  '&PARMS(1)'
&LEN     SETC  '&PARMS(2)'
&AREA    SETC  '&PARMS(3)'
.*
         AIF   ('&NAME'(1,1) EQ '''').NM1
&NM      SETC  '&NAME'
         AGO   .NM2
.NM1     ANOP  ,
&NM      SETC  'IHB2&NDX'
&NMK     SETC  '&NAME'
&NMB     SETB  1
.NM2     ANOP  ,
.* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
         AIF   ('&LEN'(1,1) EQ '''').LN1
         AIF   ('&LEN'(1,1) GE '0').LN1A
&LN      SETC  '&LEN'
         AGO   .LN2
.LN1     ANOP  ,
&LN      SETC  'IHB3&NDX'
&LNK     SETC  '&LEN'
&LNB     SETB  1
         AGO   .LN2
.LN1A    ANOP  ,
&LN      SETC  'IHB3&NDX'
&LNK     SETC  '''&LEN'''
&LNB     SETB  1
         AGO   .LN2
.LN2     ANOP  ,
.* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
         AIF   ('&AREA'(1,1) EQ '''').AR1
&AR      SETC  '&AREA'
         AGO   .AR2
.AR1     ANOP  ,
&AR      SETC  'IHB4&NDX'
&ARK     SETC  '&AREA'
&ARB     SETB  1
.AR2     ANOP  ,
.* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
         CNOP  0,4
&ID      BAL   1,IHB1&SYSNDX
         DC    A(&NM)
         DC    A(&LN)
         DC    A(&AR)
         AIF   (&NMB EQ 0).GN1
IHB2&NDX DC    CL8&NMK
.GN1     AIF   (&LNB EQ 0).GN2
IHB3&NDX DC    F&LNK
.GN2     AIF   (&ARB EQ 0).GN3
IHB4&NDX DC    C&ARK
.GN3     ANOP  ,
IHB1&NDX DS    0H
         L     15,=V(VSTO)
         BALR  14,15
         MEND  ,
./ ADD NAME=FSIDFLT
FSIDFLT  CSECT ,
         SAVE  (14,12),,*
*
         LR    R12,R15
         USING FSIDFLT,R12
*
         LA    R11,SAVEA
         ST    R13,4(,R11)
         ST    R11,8(,R13)
         LR    R13,R11
*
*
*/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z
*
*
DISPLAY  DS    0H
         $DISPLAY ('FSIDFLT')
*
*
         $VGET ('ZCMD','50',ZCMD)
*
*
         OC    ZCMD,=CL50' '
         CLC   =C'END ',ZCMD
         B     EXIT
         B     DISPLAY
*
*
EXIT      DS    0H
          L     R13,4(,R13)
          LM    R14,R12,12(R13)
          SLR   R15,R15
          BR    R14
*
*
          LTORG ,
*
*
MSG       DC    CL8' '
CSR       DC    CL8' '
*
*
SAVEA     DC    18F'0'
*
*
ZCMD      DC    CL50' '
*
*
R0        EQU   0
R1        EQU   1
R2        EQU   2
R3        EQU   3
R4        EQU   4
R5        EQU   5
R6        EQU   6
R7        EQU   7
R8        EQU   8
R9        EQU   9
R10       EQU   10
R11       EQU   11
R12       EQU   12
R13       EQU   13
R14       EQU   14
R15       EQU   15
*
*
          END   ,
./ ADD NAME=FSIDSPLY
DISPLAY  CSECT ,
         SAVE  (14,12),,*
         LR    R12,R15
         USING DISPLAY,R12
*
         LA    R11,SAVEA
         ST    R13,4(,R11)
         ST    R11,8(,R13)
         LR    R13,R11
*
         LR    R11,R1             PARAMETER LIST
*
         L     R1,0(,R11)
         ST    R1,PNLPARM+0
         L     R1,8(,R11)
         ST    R1,PNLPARM+8
*
         L     R1,4(,R11)        POINT TO MESSAGE
         LTR   R1,R1             ANY
         BZ    MSG010
*
         LA    R1,4(,R11)
         L     R15,=V(FSIERMSG)
         BALR  R14,R15
         L     R1,0(,R1)
*
MSG010   DS    0H
         ST    R1,PNLPARM+4
*
         LA    R1,PNLPARM
         L     R15,=V(FSIPANL)
         BALR  R14,R15
*
         L     R13,4(,R13)
         L     R14,12(,R13)
         LM    R0,12,20(R13)
         BR    R14
*
SAVEA    DS    18F
PNLPARM  DC    A(0,0,0)
*
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
         END   ,
./ ADD NAME=FSIERMSG
FSIERMSG CSECT ,
         SAVE  (14,12),,*
         LR    R12,R15
         USING FSIERMSG,R12
*
         LA    R11,SAVEA
         ST    R13,4(,R11)
         ST    R11,8(,R13)
         LR    R13,R11
*
         LR    R11,R1             SAVE INPUT PARM LIST
*
         L     R2,0(,R11)         GET MESSAGE ID
         LA    R3,8               MAX LENGTH
         LA    R9,0
         MVC   PDSMBR,=CL8' '
         LA    R4,PDSMBR
*
INIT010  DS    0H
         CLI   0(R2),C' '         END OF MESSAGE ID?
         BE    INIT022
*
         LTR   R3,R3              CHECK LENGTH
         BNP   INIT022            -- TOO LONG
*
         MVC   0(1,R4),0(R2)
         LA    R2,1(,R2)
         LA    R4,1(,R4)
         S     R3,=F'1'
         LA    R9,1(,R9)
         B     INIT010
*
*
INIT020  DS    0H
         LA    R1,1               INVALID MESSAGE ID
         B     ERRORXIT
*
*
INIT022  DS    0H
         CLC   =CL8' ',PDSMBR
         BE    INIT020
*
         MVC   MSGID,PDSMBR
         BCTR  R4,0
         MVI   0(R4),C' '         REMOVE LAST CHAR
*
INIT025  DS    0H
         LA    R1,PDSPARAM        POINT TO PARAM LIST
         L     R15,=V(FSIPDS)
         BALR  R14,R15            CALL ROUTINE
         B     *+4(R15)           CHECK RC
         B     INIT060            OK
         B     INIT180            EOF
         B     INIT030            ERROR
*
INIT030  DS    0H
         LR    R1,R0
         B     *+4(R1)
         B     INIT040
         B     INIT040
         B     INIT050
*
*
INIT040  DS    0H
         LA    R1,2          PDS MEMBER NOT FOUND
         B     ERRORXIT
*
*
INIT050  DS    0H            FILE FAILED TO OPEN
         LA    R1,3
         B     ERRORXIT
*
*
INIT060  DS    0H            FILE FAILED TO OPEN
         L     R1,PDSLRECL
         C     R1,=F'80'     VERIFY LRECL
         BE    INIT070       BRANCH IF OK
*
         LA    R1,4          INVALID LRECL
         B     ERRORXIT
*
*
INIT070  DS    0H
         L     R2,PDSREC
         LR    R1,R9
         BCTR  R1,0
         EX    R1,INITCLC
*INITCLC CLC   0(1,R2),MSGID
         BNE   INIT025
*
         LA    R3,80
INIT080  DS    0H
         CLI   0(R2),C' '
         BE    INIT100
         LA    R2,1(,R2)
         BCT   R3,INIT080
*
INIT090  DS    0H
         LA    R1,5          INVALID MESSAGE FORMAT
         B     ERRORXIT
*
*
INIT100  DS    0H
         LA    R2,1(,R2)
         S     R3,=F'1'
         BNP   INIT090
*
INIT110  DS    0H
         CLI   0(R2),C' '
         BNE   INIT120
         LA    R2,1(,R2)
         BCT   R3,INIT110
         B     INIT090
*
*
INIT120  DS    0H
         CLI   0(R2),C''''        EXPECTING A QUOTE
         BNE   INIT090
*
         LA    R2,1(,R2)
         S     R3,=F'1'
         BNP   INIT090
*
         MVI   SHORTMSG,C' '
         MVC   SHORTMSG+1(L'SHORTMSG-1),SHORTMSG
         MVI   LONGMSG,C' '
         MVC   LONGMSG+1(L'LONGMSG-1),LONGMSG
         LA    R4,SHORTMSG
         LA    R5,L'SHORTMSG
*
INIT130  DS    0H
         CLI   0(R2),C''''        END OF MESSAGE?
         BNE   INIT135            NO - BRANCH
*
         CLI   1(R2),C''''        DOUBLE QUOTES?
         BNE   INIT140            YES - BRANCH
*
         LA    R2,1(,R2)          SKIP OVER SECOND QUOTE
         S     R3,=F'1'           SUBTRACT ONE FROM LENGTH
         BNP   INIT090
*
INIT135  DS    0H
         LTR   R5,R5
         BNP   INIT090
*
         MVC   0(1,R4),0(R2)
         LA    R4,1(,R4)
         LA    R2,1(,R2)
         S     R5,=F'1'
         BCT   R3,INIT130
         B     INIT090
*
*
INIT140  DS    0H
         LA    R1,PDSPARAM        POINT TO PARAM LIST
         L     R15,=V(FSIPDS)
         BALR  R14,R15            CALL ROUTINE
         B     *+4(R15)           CHECK RC
         B     INIT150            OK
         B     INIT175            EOF
         B     INIT030            ERROR
*
*
INIT150  DS    0H
         L     R2,PDSREC          POINT TO INPUT RECORD
         CLI   0(R2),C''''        EXPECTING ONLY A QUOTE
         BNE   INIT175            NO -  NO LONG MESSAGE
*
         LA    R2,1(,R2)
         L     R3,PDSLRECL
         BCTR  R3,0
         LA    R4,LONGMSG
         LA    R5,L'LONGMSG
*
INIT160  DS    0H
         CLI   0(R2),C''''         LOOK FOR END OF MSG
         BNE   INIT170             NO - MOVE IT
*
         CLI   1(R2),C''''         TWO SIDE-BY-SIDE?
         BNE   INIT175             NO - END OF THE MSG
*
         LA    R2,1(,R2)
         S     R3,=F'1'
*
INIT170  DS    0H
         LTR   R5,R5
         BNP   INIT090
*
         MVC   0(1,R4),0(R2)
         LA    R2,1(,R2)
         LA    R4,1(,R4)
         S     R3,=F'1'
         S     R5,=F'1'
         BNP   INIT090
         B     INIT160
*
*
INIT175  DS    0H
         MVC   PDSMBR,=CL8'********'
         LA    R1,PDSPARAM        POINT TO PARAM LIST
         L     R15,=V(FSIPDS)
         BALR  R14,R15            CALL ROUTINE
*
         B     VARS010            GO PLUG IN VARIABLES...
*
*
INIT180  DS    0H
         LA    R1,6               MESSAGE NOT FOUND
         B     ERRORXIT
*
*
VARS010  DS    0H
         B     SCAN010            GO DETERMINE MESSAGE LENGTHS
*
*
SCAN010  DS    0H
         LA    R4,SHORTMSG
         LA    R4,L'SHORTMSG-1(,R4)  POINT TO END OF MSG
         LA    R5,L'SHORTMSG
*
SCAN020  DS    0H
         CLI   0(R4),C' '
         BNE   SCAN030            FOUND END OF MSG
*
         BCTR  R4,0
         BCT   R5,SCAN020
*
SCAN030  DS    0H
         STH   R5,SHORTLEN        SAVE MSG LENGTH
*
         LA    R4,LONGMSG
         LA    R4,L'LONGMSG-1(,R4)  POINT TO END OF MSG
         LA    R5,L'LONGMSG
*
SCAN040  DS    0H
         CLI   0(R4),C' '
         BNE   SCAN050            FOUND END OF MSG
*
         BCTR  R4,0
         BCT   R5,SCAN040
*
SCAN050  DS    0H
         STH   R5,LONGLEN        SAVE MSG LENGTH
*
*
         LA    R1,RETPARM
         L     R13,4(,R13)        UNCHAIN SA
         L     R14,12(,R13)
         LM    R2,R12,28(R13)
         SLR   R15,R15
         BR    R14                RETURN TO CALLER
*
*
ERRORXIT DS    0H
         LR    R0,R1              SAVE ERROR CODE
         XC    SHORTLEN,SHORTLEN
         XC    LONGLEN,LONGLEN
         LA    R1,RETPARM
         L     R13,4(,R13)        UNCHAIN SA
         L     R14,12(,R13)
         LM    R2,R12,28(R13)
         LA    R15,8
         BR    R14                RETURN TO CALLER
*
*
INITCLC  CLC   0(1,R2),MSGID       EXECUTED COMPARE
*
*
RETPARM  DC    A(SHORTLEN,LONGLEN)
*
PDSPARAM DC    A(PDSMBR,PDSREC,PDSLRECL,PDSDDN)
PDSREC   DC    A(0)
PDSLRECL DC    F'0'
PDSMBR   DC    CL8' '
PDSDDN   DC    CL8'FSIMLIB'
*
MSGID    DC    CL8' '
*
SHORTLEN DC    H'0'
SHORTMSG DC    CL70' '
LONGLEN  DC    H'0'
LONGMSG  DC    CL70' '
*
*
SAVEA    DC    18F'0'
*
*
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
*
         END   ,
./ ADD NAME=FSIFUNC
FSIFUNC  CSECT ,
         DC    A(0)     VGET
         DC    A(0)     VPUT
         DC    A(0)     DISPLAY
         DC    A(0)     VDEFINE
         END   ,
./ ADD NAME=FSIPANL
FSIPANL  CSECT ,
         SAVE  (14,12),,*
*
         LR    R12,R15
         USING FSIPANL,R12
*
         LA    R11,SAVEA
         ST    R13,4(,R11)
         ST    R11,8(,R13)
         LR    R13,R11
*
         LR    R11,R1             SAVE INPUT PARMS
*
         MVI   ATTRLIST,0
         MVC   ATTRLIST+1(L'ATTRLIST-1),ATTRLIST
         MVI   ATTRLIST+0,C'%'
         MVI   ATTRLIST+1,ECT$TXTH
         MVI   ATTRLIST+2,C'+'
         MVI   ATTRLIST+3,ECT$TXTL
         MVI   ATTRLIST+4,C'_'
         MVI   ATTRLIST+5,ECT$INL
*
         MVI   ATTRLIST+6,X'FF'
         MVI   ATTRLIST+7,X'FF'
*
         L     R10,0(,R11)        GET PANEL NAME
         MVC   PDSMBR,0(R10)      MOVE IN PANEL NAME
         MVC   PDSDDNM,=CL8'FSIPLIB'  MOVE IN DDNAME
*
         LA    R1,PDSPARM
         L     R15,=V(FSIPDS)     PDS READER
         BALR  R14,R15            OPEN/READ
         B     *+4(R15)           CHECK RC
         B     START000           OK
         B     ERROR01            EOF
         B     ERROR02            ERROR
*
*
START000 DS    0H
         L     R4,PDSREC          POINT TO RECORD
         CLC   =C')ATTR ',0(R4)   ATTR SECTION ?
         BE    ATTR010            YES - BRANCH
*
         CLC   =C')BODY ',0(R4)   BODY SECTION ?
         BE    BODY010            YES - BRANCH
*
         B     ERROR03            ELSE - ERROR
*
*
ATTR010  DS    0H
         LA    R4,6(,R4)          SKIP OVER )BODY
         LA    R5,74              LENGTH
ATTR020  DS    0H
         CLI   0(R4),C' '         SKIP OVER SPACES
         BNE   ATTR030
         LA    R4,1(,R4)
         BCT   R5,ATTR020         LOOP BACK
         B     ATTR040            NO DEFAULT ATTRS...
*
*
ATTR030  DS    0H
         C     R5,=F'12'          OUT OF ROOM?
         BL    ERROR04
*
         CLC   =C'DEFAULT(',0(R4)   WHAT WE EXPECT
         BNE   ERROR05
*
         LA    R4,8(,R4)
         S     R5,=F'8'
         CLC   =C') ',3(R4)       CLOSING PAREN?
         BNE   ERROR06
*
         MVC   ATTRLIST+0(1),0(R4)
         MVC   ATTRLIST+2(1),1(R4)
         MVC   ATTRLIST+4(1),2(R4)
*
ATTR040  DS    0H
         LA    R1,PDSPARM
         L     R15,=V(FSIPDS)     PDS READER
         BALR  R14,R15            OPEN/READ
         B     *+4(R15)           CHECK RC
         B     ATTR050            OK
         B     ERROR07            EOF
         B     ERROR08            ERROR
*
*
ATTR050  DS    0H
         L     R4,PDSREC          POINT TO INPUT RECORD
         LA    R5,80
*
         CLC   =C')BODY ',0(R4)   START OF BODY SECTION?
         BE    BODY010            YES - BRANCH
*
ATTR060  DS    0H
         CLI   0(R4),C' '         SKIP OVER BLANKS
         BNE   ATTR070
         LA    R4,1(,R4)
         BCT   R5,ATTR060
         B     ATTR050            BLANK LINE / IGNORE
*
*
ATTR070  DS    0H
         CLI   1(R4),C' '         MUST BE SINGLE CHAR
         BNE   ERROR09
*
         MVC   ATTRCHAR,0(R4)     SAVE IT
         MVI   ATTRTYPE,ECT$TEXT  DEFAULT IS TEXT
         MVI   ATTRINTN,ECT$LOW   DEFAULT IS LOW
         MVI   ATTRCAPS,C'Y'      DEFAULT IS YES
*
         LA    R4,2(,R4)
         S     R5,=F'2'
         BNP   ATTR210            BRANCH IF DONE
*
ATTR080  DS    0H
         CLI   0(R4),C' '
         BNE   ATTR090
         LA    R4,1(,R4)
         BCT   R5,ATTR080
         B     ATTR210
*
*
ATTR090  DS    0H
         CLC   =C'TYPE(',0(R4)
         BE    ATTR100
*
         CLC   =C'INTENS(',0(R4)
         BE    ATTR140
*
         CLC   =C'CAPS(',0(R4)
         BE    ATTR180
*
         B     ERROR10
*
*
ATTR100  DS    0H
         LA    R4,5(,R4)
         S     R5,=F'5'
         BNP   ERROR11
*
         CLC   =C'TEXT)',0(R4)
         BE    ATTR110
*
         CLC   =C'INPUT)',0(R4)
         BE    ATTR120
*
         CLC   =C'OUTPUT)',0(R4)
         BE    ATTR130
*
         B     ERROR12
*
*
ATTR110  DS    0H
         MVI   ATTRTYPE,ECT$TEXT
         LA    R4,5(,R4)
         S     R5,=F'5'
         BNP   ERROR13
         B     ATTR080
*
ATTR120  DS    0H
         MVI   ATTRTYPE,ECT$IN
         LA    R4,6(,R4)
         S     R5,=F'6'
         BNP   ERROR14
         B     ATTR080
*
ATTR130  DS    0H
         MVI   ATTRTYPE,ECT$OUT
         LA    R4,7(,R4)
         S     R5,=F'7'
         BNP   ERROR15
         B     ATTR080
*
*
ATTR140  DS    0H
         LA    R4,7(,R4)
         S     R5,=F'7'
         BNP   ERROR41
*
         CLC   =C'HIGH)',0(R4)
         BE    ATTR150
*
         CLC   =C'LOW)',0(R4)
         BE    ATTR160
*
         CLC   =C'NON)',0(R4)
         BE    ATTR170
*
         B     ERROR16
*
*
ATTR150  DS    0H
         MVI   ATTRINTN,ECT$HI
         LA    R4,5(,R4)
         S     R5,=F'5'
         BNP   ERROR17
         B     ATTR080
*
ATTR160  DS    0H
         MVI   ATTRINTN,ECT$LOW
         LA    R4,4(,R4)
         S     R5,=F'4'
         BNP   ERROR18
         B     ATTR080
*
ATTR170  DS    0H
         MVI   ATTRINTN,ECT$NON
         LA    R4,4(,R4)
         S     R5,=F'4'
         BNP   ERROR19
         B     ATTR080
*
*
ATTR180  DS    0H
         CLC   =C'OFF)',0(R4)
         BE    ATTR190
*
         CLC   =C'ON)',0(R4)
         BE    ATTR200
*
         B     ERROR20
*
*
ATTR190  DS    0H
         MVI   ATTRCAPS,C'N'
         LA    R4,4(,R4)
         S     R5,=F'4'
         BNP   ERROR21
         B     ATTR080
*
ATTR200  DS    0H
         MVI   ATTRCAPS,C'7'
         LA    R4,3(,R4)
         S     R5,=F'3'
         BNP   ERROR22
         B     ATTR080
*
*
ATTR210  DS    0H
         LA    R1,ATTRLIST
ATTR220  DS    0H
         CLI   0(R1),X'FF'
         BE    ATTR230
*
         LA    R1,2(,R1)
         B     ATTR220
*
*
ATTR230  DS    0H
         MVC   0(1,R1),ATTRCHAR
         MVC   1(1,R1),ATTRTYPE
         OC    1(1,R1),ATTRINTN
*
         MVI   2(R1),X'FF'
         MVI   3(R1),X'FF'
*
*
         B     ATTR040
BODY010  DS    0H
         GETMAIN R,LV=1920    GETMAIN BODY AREA
         ST    R1,PANEL
         LR    R0,R1
         LA    R1,1920
         SLR   R14,R15
         SLR   R15,R15
         MVCL  R0,R14
*
         L     R4,PANEL
         LA    R5,0
*
BODY020  DS    0H
         LA    R1,PDSPARM
         L     R15,=V(FSIPDS)     PDS READER
         BALR  R14,R15            OPEN/READ
         B     *+4(R15)           CHECK RC
         B     BODY030            OK
         B     END010             EOF
         B     ERROR23            ERROR
*
*
BODY030  DS    0H
         L     R2,PDSREC          POINT TO INPUT RECORD
         CLC   =C')END ',0(R2)    END OF PANEL DEF?
         BE    END010             YES -BRANCH
*
         CLC   =C')PROC ',0(R2)
         BE    PROC010
*
         C     R5,=F'24'
         BNL   ERROR23            TOO MANY LINES....
*
*
         MVC   0(80,R4),0(R2)
         LA    R4,80(,R4)
         LA    R5,1(,R5)
         B     BODY020
*
*
PROC010  DS    0H
         GETMAIN R,LV=8000
         ST    R1,ZVARS
         LR    R6,R1
         LR    R0,R1
         L     R1,=A(8000)
         SLR   R14,R15
         SLR   R15,R15
         MVCL  R0,R14
*
         MVC   0(8,R6),=XL8'FFFFFFFFFFFFFFFF'
*
         LA    R1,PDSPARM
         L     R15,=V(FSIPDS)     PDS READER
         BALR  R14,R15            OPEN/READ
         B     *+4(R15)           CHECK RC
         B     PROC020            OK
         B     END010             EOF
         B     ERROR24            ERROR
*
*
PROC020  DS    0H
         L     R4,PDSREC
         LA    R5,80
         CLC   =C')END ',0(R4)
         BE    END010
*
PROC030  DS    0H
         CLI   0(R4),C' '
         BNE   PROC040
         LA    R4,1(,R4)
         BCT   R5,PROC030
         B     PROC010
*
*
PROC040  DS    0H
         CLC   =C'.ZVARS',0(R4)
         BNE   ERROR25
*
         LA    R4,6(,R4)
         S     R5,=F'6'
         BNP   ERROR26
*
PROC050  DS    0H
         CLI   0(R4),C' '
         BNE   PROC070
         LA    R4,1(,R4)
         BCT   R5,PROC050
*
         LA    R1,PDSPARM
         L     R15,=V(FSIPDS)     PDS READER
         BALR  R14,R15            OPEN/READ
         B     *+4(R15)           CHECK RC
         B     PROC060            OK
         B     ERROR27            EOF
         B     ERROR28            ERROR
*
*
PROC060  DS    0H
         L     R4,PDSREC
         LA    R5,80
         B     PROC050
*
*
PROC070  DS    0H
         CLI   0(R4),C'='
         BNE   ERROR29
*
         LA    R4,1(,R4)
         S     R5,=F'1'
         BNP   ERROR30
*
PROC080  DS    0H
         CLI   0(R4),C' '
         BNE   PROC100
         LA    R4,1(,R4)
         BCT   R5,PROC080
*
         LA    R1,PDSPARM
         L     R15,=V(FSIPDS)     PDS READER
         BALR  R14,R15            OPEN/READ
         B     *+4(R15)           CHECK RC
         B     PROC090            OK
         B     ERROR31            EOF
         B     ERROR32            ERROR
*
*
PROC090  DS    0H
         L     R4,PDSREC
         LA    R5,80
         B     PROC080
*
*
PROC100  DS    0H
         CLC   =C'''(',0(R4)
         BNE   ERROR33
*
         LA    R4,2(,R4)
         S     R5,=F'2'
         BNP   ERROR34
*
PROC110  DS    0H
         CLI   0(R4),C' '
         BNE   PROC120
*
         LA    R4,1(,R4)
         BCT   R5,PROC110
*
PROC115  DS    0H
         LA    R1,PDSPARM
         L     R15,=V(FSIPDS)     PDS READER
         BALR  R14,R15            OPEN/READ
         B     *+4(R15)           CHECK RC
         B     PROC118            OK
         B     ERROR35            EOF
         B     ERROR36            ERROR
*
*
PROC118  DS    0H
         L     R4,PDSREC
         LA    R5,80
         B     PROC110
*
*
PROC120  DS    0H
         MVC   WORKVAR,=CL8' '    CLEAR OUT WORK VAR
         LA    R2,WORKVAR
         LA    R3,0               VAR NAME LENGTH
*
PROC130  DS    0H
         C     R3,=F'8'           MAX LENGTH?
         BNL   ERROR37
*
         MVC   0(1,R2),0(R4)      COPY IN CHAR
         LA    R4,1(,R4)
         S     R5,=F'1'
         BNP   PROC140            BRANCH IF END...
*
         LA    R2,1(,R2)
         LA    R3,1(,R3)
*
         CLI   0(R4),C' '         END OF VAR NAME?
         BE    PROC140            YES - BRANCH
*
         CLI   0(R4),C')'         END OF VAR LIST?
         BE    PROC150            YES - BRANCH
         B     PROC130
*
*
PROC140  DS    0H
         MVC   0(8,R6),WORKVAR    MOVE INTO VECTOR LIST
         MVC   8(8,R6),=XL8'FFFFFFFFFFFFFFFF'
         LA    R6,8(,R6)          POINT TO NEXT SLOT
         LTR   R5,R5
         BNP   PROC115
         B     PROC110
*
*
PROC150  DS    0H
         CLC   =C')''',0(R4)
         BNE   ERROR38
*
         MVC   0(8,R6),WORKVAR    MOVE INTO VECTOR LIST
         MVC   8(8,R6),=XL8'FFFFFFFFFFFFFFFF'
*
PROC160  DS    0H
         LA    R1,PDSPARM
         L     R15,=V(FSIPDS)     PDS READER
         BALR  R14,R15            OPEN/READ
         B     *+4(R15)           CHECK RC
         B     PROC170            OK
         B     END010             EOF
         B     ERROR39            ERROR
*
*
PROC170  DS    0H
         L     R4,PDSREC
         CLC   =C')END ',0(R4)
         BE    END010
*
         CLC   =CL80' ',0(R4)
         BNE   ERROR40
*
         B     PROC170
*
*
END010   DS    0H
         MVC   PDSMBR,=CL8'********'
         L     R15,=V(FSIPDS)     PDS READER
         BALR  R14,R15            OPEN/READ
*
         LA    R1,ATTRLIST
         ST    R1,SCRNPARM+0
         L     R1,PANEL
         ST    R1,SCRNPARM+4
         L     R1,ZVARS
         ST    R1,SCRNPARM+8
         L     R1,4(,R11)
         ST    R1,SCRNPARM+12
         MVC   SCRNPARM+16(8),=CL8' '
         L     R1,8(,R11)
         MVC   SCRNPARM+24(8),0(R1)
*
*
*        $VSTO ('ZCMD','1',' ')   CLEAR THE ZCMD VARIABLE
*
*
         LA    R1,SCRNPARM
         L     R15,=V(FSISCRN)
         BALR  R14,R15
*
*
         LA    R6,SCRNPARM
         USING SCR,R6
*
         MVC   AID,SCRAID
         DROP  R6
*
         CLC   =CL8' ',AID       EMPTY ?
         BE    CMD040
*
         MVI   AIDCMD,C' '
         MVC   AIDCMD+1(L'AIDCMD-1),AIDCMD
*
         $VLOC (AID,'128',AIDCMD)
*
         $VLOC ('ZCMD','128',ZCMD)
*
CMD010   DS    0H
         LA    R2,AIDCMD+127
         LA    R3,AIDCMD
*
CMD020   DS    0H
         CR    R2,R3
         BNH   CMD040
*
         CLI   0(R2),C' '
         BNE   CMD030
*
         BCT   R2,CMD020
*
*
CMD030   DS    0H
         LA    R2,2(,R2)
         LR    R1,R2
         SR    R1,R3
         LA    R3,127
         SR    R3,R1
         BCTR  R3,0
         EX    R3,CMDMVC
*CMDMVC  MVC   0(1,R2),ZCMD
*
         $VSTO ('ZCMD','128',AIDCMD)
*
*
         B     CMD040
*
CMDMVC   MVC   0(1,R2),ZCMD       EXECUTED INSTRUCTION
*
CMD040   DS    0H
         L     R4,ZVARS
         LTR   R4,R4
         BZ    FREE010
*
         FREEMAIN R,LV=8000,A=(R4)
         XC    ZVARS,ZVARS
*
FREE010  DS    0H
         L     R4,PANEL
         FREEMAIN R,LV=1920,A=(R4)
         XC    PANEL,PANEL
*
         L     R13,4(,R13)
         LM    R14,R12,12(R13)
         SLR   R15,R15
         BR    R14
*
*
ERROR01  LA    R2,1
         B     ERROR00
ERROR02  LA    R2,2
         B     ERROR00
ERROR03  LA    R2,3
         B     ERROR00
ERROR04  LA    R2,4
         B     ERROR00
ERROR05  LA    R2,5
         B     ERROR00
ERROR06  LA    R2,6
         B     ERROR00
ERROR07  LA    R2,7
         B     ERROR00
ERROR08  LA    R2,8
         B     ERROR00
ERROR09  LA    R2,9
         B     ERROR00
ERROR10  LA    R2,10
         B     ERROR00
ERROR11  LA    R2,11
         B     ERROR00
ERROR12  LA    R2,12
         B     ERROR00
ERROR13  LA    R2,13
         B     ERROR00
ERROR14  LA    R2,14
         B     ERROR00
ERROR15  LA    R2,15
         B     ERROR00
ERROR16  LA    R2,16
         B     ERROR00
ERROR17  LA    R2,17
         B     ERROR00
ERROR18  LA    R2,18
         B     ERROR00
ERROR19  LA    R2,19
         B     ERROR00
ERROR20  LA    R2,20
         B     ERROR00
ERROR21  LA    R2,21
         B     ERROR00
ERROR22  LA    R2,22
         B     ERROR00
ERROR23  LA    R2,23
         B     ERROR00
ERROR24  LA    R2,24
         B     ERROR00
ERROR25  LA    R2,25
         B     ERROR00
ERROR26  LA    R2,26
         B     ERROR00
ERROR27  LA    R2,27
         B     ERROR00
ERROR28  LA    R2,28
         B     ERROR00
ERROR29  LA    R2,29
         B     ERROR00
ERROR30  LA    R2,30
         B     ERROR00
ERROR31  LA    R2,31
         B     ERROR00
ERROR32  LA    R2,32
         B     ERROR00
ERROR33  LA    R2,33
         B     ERROR00
ERROR34  LA    R2,34
         B     ERROR00
ERROR35  LA    R2,35
         B     ERROR00
ERROR36  LA    R2,36
         B     ERROR00
ERROR37  LA    R2,37
         B     ERROR00
ERROR38  LA    R2,38
         B     ERROR00
ERROR39  LA    R2,39
         B     ERROR00
ERROR40  LA    R2,40
         B     ERROR00
ERROR41  LA    R2,41
         B     ERROR00
ERROR00  ABEND 303
*
*
SAVEA    DC    18F'0'
*
PDSPARM  DC    A(PDSMBR,PDSREC,PDSLRECL,PDSDDNM)
PDSMBR   DC    CL8' '
PDSDDNM  DC    CL8'FSIPLIB'
PDSREC   DC    A(0)
PDSLRECL DC    F'0'
*
WORKVAR  DC    CL8' '
PANEL    DC    A(0)
ZVARS    DC    A(0)
*
SCRNPARM DC    A(0),A(0),A(0),A(0),CL8' ',CL8' '
*
ATTRCHAR DC    C' '
ATTRTYPE DC    X'00'
ATTRINTN DC    X'00'
ATTRCAPS DC    X'00'
*
*
AID      DC    CL8' '
*
*
         LTORG ,
*
AIDCMD   DS    CL128
ZCMD     DS    CL128
*
ATTRLIST DC    XL128'00'
*
*
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
*
*
         $FSIECT ,
         $FSISCR ,
*
         END   ,
./ ADD NAME=FSIPDS
FSIPDS   TITLE 'READ A PDS MEMBER AND DEBLOCK'
***********************************************************************
*       THIS JOB WILL READ AND DEBLOCK A PDS MEMBER                   *
*                                                                     *
*       UPON ENTRY REGISTER ONE POINTS TO A PARAMETER LIST            *
*                                                                     *
*        WORD ONE  POINTER TO MEMBER NAME TO BE PROCESSED             *
*        WORD TWO  POINTER TO A FULL WORD IN WHICH THE RECORD ADDRESS *
*                  WILL BE PLACED                                     *
*        WORD THREE POINTER TO A FULL WORD IN WHICH THE LRECL WILL BE *
*                  PLACED                                             *
*        WORD FOUR POINTER TO DD NAME                                 *
*                                                                     *
*        IF THE MEMBER NAME IS CHANGED, ON THE NEXT CALL PROCESSING   *
*        WILL BEGIN FOR A NEW MEMBER                                  *
*                                                                     *
*        IF THE MEMBER NAME IS C'********' THE CURRENT PROCESSING WILL*
*        BE TERMINATED AND THE DCB CLOSED. THIS SHOULD BE DONE AT THE *
*        END OF ALL PROCESSING                                        *
*                                                                     *
*                                                                     *
*             UPON RETURN, REGISTER 15 CONTAINS A RETURN CODE         *
*                 AND REGISTER 0 CONTAINS A REASON CODE.              *
*                                                                     *
*              R15    R0                                              *
*              ---    --                                              *
*               0    N/A     REQUEST COMPLETED SUCESSFULLY            *
*               4    N/A     END OF FILE  CURRENT MEMBER              *
*               8     4      DD STATEMENT NOT FOUND                   *
*               8     8      MEMBER NOT FOUND                         *
*                                                                     *
***********************************************************************
         TITLE '*** P R O G R A M    E N T R Y'
***********************************************************************
*                  P R O G R A M   E N T R Y                          *
***********************************************************************
         SPACE 3
FSIPDS   CSECT
         SAVE  (14,12),,FSIPDS_V2_&SYSDATE_&SYSTIME_TCS3_12/82
         LR    R12,R15            SET BASE
         USING FSIPDS,R12
         LA    R15,SAVEA          POINT TO SAVEA
         ST    R13,4(,R15)        CHAIN
         ST    R15,8(,R13)             SAVE
         LR    R13,R15                     AREAS
         LR    R11,R1             SAVE PARM PTR
         TITLE '*** I N I T I A L   P R O C E S S I N G'
***********************************************************************
*                I N I T I A L   P R O C E S S I N G                  *
***********************************************************************
         SPACE 3
         L     R2,0(,R11)         FIND MEMBER NAME
         CLC   ASTRK,0(R2)        IS IT CLOSE REQUEST
         BE    CLOSE              YES - BRANCH
         L     R2,12(,R11)        FIND DD NAME
         CLC   DDNAME,0(R2)       CHECK FOR NEW DD NAME
         BNE   NEWDD              YES - GO PROCESS
         TM    DCB+48,X'10'       IS DCB OPEN
         BO    INIT010            YES - CONTINUE
         B     NEWDD              ELSE - PROCESS NEW DD
INIT010  DS    0H
         TITLE '*** P R O C E S S   R E A D'
***********************************************************************
*                     P R O C E S S   R E A D                         *
***********************************************************************
         SPACE 3
READ     DS    0H
         L     R2,0(,R11)         POINT TO MEMBER
         CLC   MEMBER,0(R2)       IS IT NEW MEMBER
         BE    READ010            NO - CONTINUE
         MVC   MEMBER,0(R2)       SAVE MEM NAME
         XC    RECPTR,RECPTR      ZERO POINTER
         FIND  DCB,MEMBER,D
         LTR   R15,R15            WAS IT FOUND ?
         BZ    READ010            YES - CONTINUE
         LA    R15,8              RC = 8
         LA    R0,8               CODE = 8
         B     RETURN             AND EXIT
READ010  DS    0H
         L     R2,RECPTR          GET RECORD POINTER
         LTR   R2,R2              DO WE NEED A READ
         BNZ   READ020            NO-CONTINUE
         L     R7,BUF             POINT TO INPUT BUFFER
         READ  READDECB,SF,DCB,(R7)
         CHECK READDECB
         LH    R2,DCB+62          GET BLOCKSIZE
         L     R1,READDECB+16     POINT TO IOB
         SH    R2,14(,R1)         COMPUTE ACTUAL BLOCKSIZE
         ST    R2,BLKLEN          SAVE
         LR    R2,R7              POINT TO INPUT BUFFER
READ020  DS    0H
         LR    R8,R2              CURRENT RECORD ADDRESS IN R8
         LH    R9,DCB+82          GET LRECL
         LA    R2,0(R9,R2)        BUMP TO NEXT RECORD
         ST    R2,RECPTR          SAVE ADDRESS
         L     R2,BLKLEN          GET LEN REMAINING
         SR    R2,R9              ADJUST
         BP    READ030            BRANCH IN NOT END OF BLOCK
         XC    RECPTR,RECPTR      RESET BUFFER POINTER
READ030  DS    0H
         ST    R2,BLKLEN          SAVE BLK LEN
         L     R2,4(,R11)         RECORD RETURN
         ST    R8,0(R2)           RETURN RECORD
         L     R2,8(,R11)         BLOCK LEN
         ST    R9,0(,R2)          RETURN RECORD LEN
         LA    R15,0              SET RC
         LA    R0,0
         B     RETURN
         TITLE '*** P R O C E S S   C L O S E   R E Q U E S T'
***********************************************************************
*             P R O C E S S   C L O S E   R E Q U E S T               *
***********************************************************************
         SPACE 3
CLOSE    DS    0H
         TM    DCB+48,X'10'       IS DCB OPEN
         BNO   CLOSE010           NO - SKIP CLOSE
         LH    R2,DCB+62          POINT TO BLKSIZE
         L     R3,BUF             ADDRESS
         FREEMAIN R,LV=(R2),A=(R3)
         CLOSE (DCB)
CLOSE010 DS    0H
         MVC   DDNAME,=8XL1'FF'   RESET DDNAME
         MVC   MEMBER,=8XL1'FF'   RESET MEMBER NAME
         LA    R15,0              SET RC
         LA    R0,0
         B     RETURN
         TITLE '*** P R O C E S S   E N D   O F   F I L E'
***********************************************************************
*             P R O C E S S   E N D   O F   F I L E                   *
***********************************************************************
         SPACE 3
EOF      DS    0H
         LA    R15,4              SET RC
         LA    R0,0
         MVC   MEMBER,=8XL1'FF'   RESET MEMBER NAME
         B     RETURN
         TITLE '*** P R O C E S S   N E W   D D N A M E'
***********************************************************************
*             P R O C E S S   N E  W   D D N A M E                    *
***********************************************************************
         SPACE 3
NEWDD    DS    0H
         TM    DCB+48,X'10'       IS DCB OPEN
         BNO   NEWDD010           NO - SKIP CLOSE
         LH    R2,DCB+62          GET BLKSIZE
         L     R3,BUF             POINT TO BUFFER
         FREEMAIN R,LV=(R2),A=(R3)
         CLOSE (DCB)
NEWDD010 DS    0H
         L     R2,12(,R11)        POINT TO DDNAME
         EXTRACT FWORD,FIELDS=TIOT
         L     R1,FWORD           POINT TO TIOT
         LA    R1,24(,R1)         POINT TO DD SECTION
         SLR   R0,R0              CLEAR WORK REG
NEWDD020 DS    0H
         IC    R0,0(,R1)          GET ENTRY LENGTH
         LR    R3,R1              SAVE PTR TO ENTRY IN R3
         CLC   0(8,R2),4(R1)      IS THE THE ENTRY
         BXLE  R1,R0,NEWDD030     BRANCH IF NO MORE
         BNE   NEWDD020           NO - TRY NEXT
         B     NEWDD040           CONTINUE ON
NEWDD030 DS    0H
         LA    R15,8              RC
         LA    R0,4               REASON CODE
         B     RETURN             AND EXIT
NEWDD040 DS    0H
         MVC   DCB+40(8),0(R2)    PLUG IN NEW DDNAME
         MVC   DDNAME,0(R2)       SAVE DDNAME
         OPEN  (DCB,INPUT)
         LH    R2,DCB+62          GET BLKSIZE
         GETMAIN R,LV=(R2)        GET A BUFFER
         ST    R1,BUF             SAVE ADDRESS
         MVC   MEMBER,FFS         RESET MEMBER NAME
         B     READ               GO PROCESS IT
         TITLE '*** R E T U R N    T O   C A L L E R'
***********************************************************************
*             R E T U R N   T O    C A L L E R                        *
***********************************************************************
         SPACE 3
RETURN   DS    0H
         L     R13,4(,R13)        UNCHAIN
         L     R14,12(,R13)
         LM    R1,R12,24(R13)
         BR    R14                RETURN
         TITLE '*** D A T A   A R E A S'
***********************************************************************
*                       D A T A    A R E A S                          *
***********************************************************************
         SPACE 3
BUF      DC    F'0'
BLKLEN   DC    F'0'
RECPTR   DC    F'0'
FWORD    DC    F'-1'
SAVEA    DS    18F
ASTRK    DC    C'********'
FFS      DC    X'FFFFFFFFFFFFFFFF'
         PRINT NOGEN
DCB      DCB   DSORG=PO,                                               X
               MACRF=R,                                                X
               DDNAME=XXXXXXXX,                                        X
               EODAD=EOF
         SPACE 2
MEMBER   DC    X'FFFFFFFFFFFFFFFF'
DDNAME   DC    X'FFFFFFFFFFFFFFFF'
         SPACE 5
         TITLE '***  R E G I S T E R   E Q U A T E S ***'
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
         END
./ ADD NAME=FSISCRN
FSISCRN   CSECT ,
          SAVE  (14,12),,*
*
          LR    R12,R15
          USING FSISCRN,R12
*
*
         LA    R11,SAVEA
         ST    R13,4(,R11)
         ST    R11,8(,R13)
         LR    R13,R11
*
*
         LR    R11,R1
         USING SCR,R11
*
*
         XC    CSRPOS,CSRPOS
         XC    TRTAB,TRTAB
*
         L     R4,=A(TRTAB)
         L     R2,SCRATTRS        PONIT TO ATTR ARRAY
ATTR010  DS    0H
         CLC   =X'FFFF',0(R2)     END OF LIST
         BE    ATTR020            YES - DONE
*
         SLR   R1,R1              ZERO R1
         IC    R1,0(,R2)          GET ATTR CHAR
         LA    R1,0(R1,R4)        CALC OFFSET INTO TABLE
         MVC   0(1,R1),1(R2)      MOVE IN ENCODED ATTRIBUTES
         LA    R2,2(,R2)          POINT TO NEXT ENTRY
         B     ATTR010            LOOP BACK
*
*
ATTR020  DS    0H
         GETMAIN R,LV=4096
         ST      R1,BUFFER
         ST      R1,BUFFERP
*
         GETMAIN R,LV=4096
         ST      R1,INBUF
*
         L     R3,=A(SVARSIZE*200)
         GETMAIN R,LV=(R3)
         ST    R1,VARTAB
*
         LR    R0,R1            CLEAR THE SCREEN VAR TABLE
         LR    R1,R3
         SLR   R14,R14
         SLR   R15,R15
         MVCL  R0,R14
*
*
         L     R1,SCRPANEL        GET POINTER TO PANEL
         ST    R1,PANELP          SAVE
*
         LA    R1,1               PRIME ROW
         ST    R1,ROW
         LA    R1,0               PRIME COL
         ST    R1,COL
*
         LA    R4,=X'27F5C31140403C404040'
         LA    R5,10
*
PREFIX   DS    0H
         ICM   R1,B'0001',0(R4)
         BAL   R14,PUTCHAR
         LA    R4,1(,R4)
         BCT   R5,PREFIX
*
*
TXTLOOP  DS    0H
         BAL   R14,GETCHAR
         LTR   R15,R15
         BNZ   DONE
*
TXTLOP10 DS    0H
         CLI   CHARTYPE,0       FIELD DEFINITION CHAR?
         BE    TXTLOP20         NO - BRANCH
*
         TM    CHARTYPE,X'03'  OUTPUT FIELD ?
         BO    INPT            PROCESS INPUT/OUTPUT FIELD
         TM    CHARTYPE,X'01'  INPUT FIELD ?
         BO    INPT            PROCESS INPUT/OUTPUT FIELD
         B     TXT             PROCESS TEXT FIELD
*
*
TXTLOP20 DS    0H
         BAL   R14,PUTCHAR
         B     TXTLOOP
***********************************************************************
*
*
***********************************************************************
TXT      DS    0H
         IC    R1,=X'11'   START FIELD
         BAL   R14,PUTCHAR
*
         L     R0,ROW
         L     R1,COL
         BAL   R14,CNVTSBA
*
         LR    R5,R15
         LR    R1,R15
         SRL   R1,8
         BAL   R14,PUTCHAR
*
         LR    R1,R5
         BAL   R14,PUTCHAR
*
         IC    R1,=X'1D'       START FIELD
         BAL   R14,PUTCHAR
         IC    R1,CHARATTR     GET 3270 ATTRIB CHAR
         BAL   R14,PUTCHAR
*
         B     TXTLOOP
***********************************************************************
* INPUT / OUTPUT FIELD
***********************************************************************
INPT     DS    0H
         IC    R1,=X'11'   START FIELD
         BAL   R14,PUTCHAR
*
         L     R0,ROW
         L     R1,COL
         BAL   R14,CNVTSBA
*
         LR    R5,R15
         LR    R1,R15
         SRL   R1,8
         BAL   R14,PUTCHAR
*
         LR    R1,R5
         BAL   R14,PUTCHAR
*
         IC    R1,=X'1D'       START FIELD
         BAL   R14,PUTCHAR
         IC    R1,CHARATTR     GET 3270 ATTRIB CHAR
         BAL   R14,PUTCHAR
*
* START A SVAR TABLE ENTRY
*
         L     R10,VARTAB
         USING SVAR,R10
*
INPT002  DS    0H
         CLC   SVARBUFA,=XL2'0000'
         BE    INPT004              FOUND EMPTY SLOT
*
         LA    R10,SVARSIZE(,R10)      POINT TO NEXT ENTRY
         B     INPT002
*
*
INPT004  DS    0H
         L     R0,ROW
         L     R1,COL
         LA    R1,1(,R1)
         BAL   R14,CNVTSBA
*
         STCM  R15,B'0011',SVARBUFA
*
         TM    CHARTYPE,X'03'      OUTPUT FIELD?
         BO    INPT006             YES - DON'T SET DEFAULT CSR
         CLC   =X'0000',CSRPOS     SAVED CSR POSITION?
         BNE   INPT006             YES - BRANCH
*
         STCM  R15,B'0011',CSRPOS  SAVE
INPT006  DS    0H
*
* PROCESS VAR NAME
*
INPT010  DS    0H
         LA    R4,WORKNAME
         LA    R5,8              MAX VAR NAME LENGTH
         SLR   R3,R3             FIELD LENGTH
         MVC   WORKNAME,=CL8' '
INPT020  DS    0H
         BAL   R14,GETCHAR       GET NEXT CHAR
         LTR   R15,R15           CHECK FOR EOF
         BNZ   INPT040           YES - BRANCH
*
         CLI   CHARTYPE,X'00'
         BNE   INPT050
*
         CLI   CHAR,C' '      END OF NAME?
         BE    INPT030
*
         C     R5,=F'1'       NAME TOO LONG
         BL    INPT030        YES -  BRANCH
*
         MVC   0(1,R4),CHAR   COPY VAR NAME
         LA    R4,1(,R4)
         S     R5,=F'1'
*
         LA    R3,1(,R3)          INCREMENT FIELD LENGTH
         B     INPT020
*
*
INPT030  DS    0H
         LA    R3,1(,R3)       INCREMENT FIELD LENGTH
INPT035  DS    0H
         BAL   R14,GETCHAR
         LTR   R15,R15
         BNZ   INPT040
*
         CLI   CHARTYPE,X'00'
         BNE   INPT050
*
         LA    R3,1(,R3)       INCREMENT FIELD LENGTH
         B     INPT035
*
*
INPT040  DS    0H
         MVI   CHAR,X'FF'
*
INPT050  DS    0H
         MVC   SVARNAME,WORKNAME
         STH   R3,SVARLEN
*
*
         CLI   CHAR,X'FF'
         BE    DONE                BRANCH IF EOF
*
         B     TXTLOP10            GO START NEXT FIELD
*
         DROP  R10
*
*
*--------------------------------------------------------------------
*
*
*
*--------------------------------------------------------------------
*
DONE     DS    0H
         L     R10,VARTAB
         USING SVAR,R10
         L     R9,SCRZVARS
ZVARS010 DS    0H
         CLC   SVARBUFA,=XL2'0000'  END OF VAR TABLE?
         BE    ZVARS040             YES - BRANCH
*
         CLC   =CL8'Z',SVARNAME     IS THIS A ZVAR ?
         BNE   ZVARS020             NO - SKIP IT
*
         CLC   =XL8'FFFFFFFFFFFFFFFF',0(R9)  END OF LIST?
         BE    ZVARS030             YES - TOO BAD...
*
         MVC   SVARNAME,0(R9)       MOVE IN NAME
         LA    R9,8(,R9)            NEXT NAME IN VECTOR
*
ZVARS020 DS    0H
         LA    R10,SVARSIZE(,R10)       POINT TO NEXT ENTRY
         B     ZVARS010
*
*
ZVARS030 DS    0H
         ABEND 111
*
*
         DROP  R10
ZVARS040 DS    0H
*
         L     R10,VARTAB
         USING SVAR,R10
INSV010  DS    0H
         CLC   SVARBUFA,=XL2'0000'  END OF VAR TABLE?
         BE    INSV050              YES - BRANCH
*
         LA    R1,SVARNAME          VAR NAME
         ST    R1,VPARAM
         LH    R1,SVARLEN
         ST    R1,VPLEN
         LA    R1,VPLEN
         ST    R1,VPARAM+4
         LA    R1,VWORK
         ST    R1,VPARAM+8
*
         LA    R1,VPARAM
         L     R15,=V(VLOC)
         BALR  R14,R15
*
         LTR   R15,R15
         BNZ   INSV040            NOT FOUND
*
         IC    R1,=X'11'            SBA
         BAL   R14,PUTCHAR
         IC    R1,SVARBUFA
         BAL   R14,PUTCHAR
         IC    R1,SVARBUFA+1
         BAL   R14,PUTCHAR
*
INSV020  DS    0H
         LH    R3,SVARLEN        VAR AREA LENGTH
         LA    R4,VWORK
INSV030  DS    0H
         IC    R1,0(,R4)
         BAL   R14,PUTCHAR
         LA    R4,1(,R4)
         BCT   R3,INSV030
*
INSV040  DS    0H
         LA    R10,SVARSIZE(,R10)       POINT TO NEXT ENTRY
         B     INSV010
*
*
         DROP  R10
*
*
INSV050  DS    0H
         L     R3,SCRMSG          ANY MESSAGE TO DISPLAY?
         LTR   R3,R3
         BZ    INSV080            NO - BRANCH
*
         LA    R2,2(,R3)          POINT TO DATA
         LH    R3,0(,R3)          GET LENGTH
*
         LTR   R3,R3              ZERO LENGTH?
         BZ    INSV080            YES - NO MESSAGE...
         C     R3,=F'70'          MAX LENGTH
         BNH   INSV060
*
         LA    R3,70
INSV060  DS    0H
         LA    R1,79
         SR    R1,R3              STARTING COL
         BCTR  R1,0               BACK UP 1 MORE
         LA    R0,1
         BAL   R14,CNVTSBA        GO CALC BUFFER POS
         LR    R5,R15             SAVE BUFFER ADDR
         IC    R1,=X'11'
         BAL   R14,PUTCHAR
*
         LR    R1,R5
         SRL   R1,8
         BAL   R14,PUTCHAR
         LR    R1,R5
         BAL   R14,PUTCHAR
*
         IC    R1,=X'1D'       START FIELD
         BAL   R14,PUTCHAR
         IC    R1,=X'F8'
         BAL   R14,PUTCHAR
         IC    R1,=C' '
         BAL   R14,PUTCHAR
*
INSV070  DS    0H
         IC    R1,0(R2)
         BAL   R14,PUTCHAR
         LA    R2,1(,R2)
         BCT   R3,INSV070
*
INSV080  DS    0H
         CLC   SCRCSR,=CL8' '     ANY CURSOR FIELD SPECIFIED?
         BE    CSRP030            NO - USE A DEFAULT
*
         L     R10,VARTAB         POINT TO SCREEN VAR TABLE
         USING SVAR,R10
*
CSRP010  DS    0H
         CLC   SVARBUFA,=XL2'0000'  END OF TABLE?
         BE    CSRP030            YES - USE DEFAULT CSR POS
*
         CLC   SCRCSR,SVARNAME    IS THIS OUR FIELD?
         BE    CSRP020            YES, USE IT
*
         LA    R10,SVARSIZE(,R10) TRY NEXT FIELD
         B     CSRP010
*
*
CSRP020  DS    0H
         MVC   CSRPOS,SVARBUFA    SET CURSOR POSITION
*
CSRP030  DS    0H
         CLC   =X'0000',CSRPOS    ANY CURSOR POSITION?
         BE    DONE010            NO - BRANCH
*
         IC    R1,=X'11'
         BAL   R14,PUTCHAR
         IC    R1,CSRPOS
         BAL   R14,PUTCHAR
         IC    R1,CSRPOS+1
         BAL   R14,PUTCHAR
         IC    R1,=X'13'
         BAL   R14,PUTCHAR
*
         DROP  R10
*
DONE010  DS    0H
         L     R5,BUFFERP
         S     R5,BUFFER
         L     R4,BUFFER
         TPUT  (R4),(R5),FULLSCR
*
*
         LTR   R15,R15
         BZ    TPUTOK
*
         ABEND 101
TPUTOK   DS    0H
*
*
         L     R4,INBUF
         L     R5,=A(4096)
         TGET  (R4),(R5),ASIS
*
*
INVAR    DS    0H
         LR    R5,R1         SAVE INPUT LENGTH
         MVC   AID,0(R4)     SAVE AID VALUE
         LA    R4,3(,R4)     SKIP OVER AID/CSR POS
         S     R5,=F'3'      ADJUST LENGTH
         BNP   INVAR070      BRANCH IF DONE
         CLI   0(R4),X'11'   START FLD?
         BNE   INVAR060      SOME TYPE OF ERROR
*
INVAR010 DS    0H
         LA    R6,1(,R4)     SAVE START OF FIELD
         LA    R4,3(,R4)     POINT TO FLD DATA
         SLR   R3,R3         ZERO FIELD LENGTH
         S     R5,=F'3'      SKIP OVER SF+BUFADR
         BNP   INVAR030      BRANCH IF AT END
*
INVAR020 DS    0H
         CLI   0(R4),X'11'   START OF NEW FIELD ?
         BE    INVAR030      YES - BRANCH
*
         LA    R3,1(,R3)     ADD ONE TO FIELD LENGTH
         LA    R4,1(,R4)
         BCT   R5,INVAR020   LOOP BACK
*
INVAR030 DS    0H
         L     R10,VARTAB     SVAR START
         USING SVAR,R10
*
INVAR040 DS    0H
         CLC   =XL2'0000',SVARBUFA   END OF TABLE ?
         BE    INVAR060              VAR NOT FOUND
*
         CLC   SVARBUFA,0(R6)        IS THIS OUR VAR
         BE    INVAR050              YES - BRANCH
*
         LA    R10,SVARSIZE(,R10)      INCREMENT TO NEXT
         B     INVAR040              LOOP BACK
*
*
INVAR050 DS    0H
         LA    R1,SVARNAME
         ST    R1,VPARAM
         ST    R3,VPLEN
         LA    R1,VPLEN
         ST    R1,VPARAM+4
         LA    R1,2(,R6)
         ST    R1,VPARAM+8
*
         LA    R1,VPARAM
         L     R15,=V(VSTO)
         BALR  R14,R15
*
         LTR   R5,R5              END OF DATA STREAM ?
         BNE   INVAR010           NO - START NEW FIELD
         B     INVAR070
*
*
INVAR060 DS    0H
         ABEND 103
*
*
INVAR070 DS    0H
         MVC   SCRAID,=CL8' '     CLEAR AID VALUE
         LA    R1,AIDTABLE        POINT TO LIST OF AID VALUES
INVAR080 DS    0H
         CLI   0(R1),X'FF'        END OF TABLE?
         BE    INVAR090           YES - BRANCH
*
         CLC   AID,0(R1)          IS THIS OUR ENTRY
         BE    INVAR090
*
         LA    R1,5(,R1)
         B     INVAR080
*
*
INVAR090 DS    0H
         MVC   SCRAID(4),1(R1)
*
*
         DROP  R10
*
*
         L     R2,BUFFER
         FREEMAIN R,LV=4096,A=(R2)
*
         L     R2,INBUF
         FREEMAIN R,LV=4096,A=(R2)
*
         L     R3,=A(SVARSIZE*200)
         L     R2,VARTAB
         FREEMAIN R,LV=(R3),A=(R2)
*
*
          L     R13,4(,R13)
          LM    R14,R12,12(R13)
          SLR   R15,R15
          BR    R14
*
*
*
*
*
***********************************************************************
*
* OUTPUT: R15 = RC (4=EOF)  R1=XXXC
*
***********************************************************************
GETCHAR   DS    0H
          L     R1,COL
          LA    R1,1(,R1)
          ST    R1,COL
*
          C     R1,=F'80'
          BNH   NEXTCH10
*
          LA    R1,1
          ST    R1,COL
          L     R1,ROW
          LA    R1,1(,R1)
          ST    R1,ROW
*
          C     R1,=F'24'
          BH    NEXTCH20
*
*
NEXTCH10  DS    0H
          L     R15,PANELP
          ICM   R1,B'0001',0(R15)
          MVC   CHAR,0(R15)
*
          MVC   CHARTYPE,0(R15)
          TR    CHARTYPE,TRTAB
*
          LA    R15,1(,R15)
          ST    R15,PANELP
*
         SLR   R15,R15
*
         CLI   CHARTYPE,0
         BER   R14
*
          MVC   CHARATTR,CHARTYPE
          NI    CHARATTR,X'0F'
          TR    CHARATTR,ATTRTAB
*
          SLR   R15,R15
          BR    R14
*
*
NEXTCH20  DS    0H
          LA    R15,4
          BR    R14
*
*
***********************************************************************
*
* INPUT: R1 = XXXC
*
***********************************************************************
PUTCHAR  DS    0H
         L     R15,BUFFERP
         STCM  R1,B'0001',0(R15)
         LA    R15,1(,R15)
         ST    R15,BUFFERP
         BR    R14
*
*
***********************************************************************
*
* INPUT: R0=ROW, R1=COL
* OUTPUT: R15 = SBA ADDR
*
***********************************************************************
CNVTSBA   DS   0H
          BCTR R0,0
          BCTR R1,0
          MH   R0,=H'80'
          AR   R1,R0
          SLL  R1,2
          STCM R1,B'0010',SBACMD
          SRL  R1,2
          STCM R1,B'0001',SBACMD+1
          NC   SBACMD(2),=X'3F3F'
          TR   SBACMD(2),TBL3270
          SLR  R15,R15
          ICM  R15,B'0011',SBACMD
          BR   R14
*
SBACMD    DC   XL2'0000'
*
*
AIDTABLE DS    0C
         DC    X'7D',C'    '      ENTER
         DC    X'F1',C'PF01'
         DC    X'F2',C'PF02'
         DC    X'F3',C'PF03'
         DC    X'F4',C'PF04'
         DC    X'F5',C'PF05'
         DC    X'F6',C'PF06'
         DC    X'F7',C'PF07'
         DC    X'F8',C'PF08'
         DC    X'F9',C'PF09'
         DC    X'7A',C'PF10'
         DC    X'7B',C'PF11'
         DC    X'7C',C'PF12'
         DC    X'C1',C'PF13'
         DC    X'C2',C'PF14'
         DC    X'C3',C'PF15'
         DC    X'C4',C'PF16'
         DC    X'C5',C'PF17'
         DC    X'C6',C'PF18'
         DC    X'C7',C'PF19'
         DC    X'C8',C'PF20'
         DC    X'C9',C'PF21'
         DC    X'4A',C'PF22'
         DC    X'4B',C'PF23'
         DC    X'4C',C'PF24'
         DC    X'6C',C'PA1 '
         DC    X'6E',C'PA2 '
         DC    X'6B',C'PA3 '
         DC    X'FF',CL4' '
*
*
ROW       DC    F'1'
COL       DC    F'0'
PANELP    DC    A(0)
BUFFER    DC    A(0)
BUFFERP   DC    A(0)
INBUF     DC    A(0)
CSRPOS    DC    X'0000'
VARTAB    DC    A(0)
VPARAM    DC    A(0,0,0)     VPUT/VGET PARM LIST
VPLEN     DC    F'0'
AID       DC    X'00'
CHAR      DC    C' '
CHARTYPE  DC    C' '
CHARATTR  DC    C' '
WORKNAME  DC    CL8' '
VWORK     DC    CL256' '
*
*
TBL3270   DC   X'40C1C2C3C4C5C6C7C8C94A4B4C4D4E4F'
          DC   X'50D1D2D3D4D5D6D7D8D95A5B5C5D5E5F'
          DC   X'6061E2E3E4E5E6E7E8E96A6B6C6D6E6F'
          DC   X'F0F1F2F3F4F5F6F7F8F97A7B7C7D7E7F'
*
*
ATTRTAB   DC   X'F040F0F0F8C8F8F87C4C7C7CF040F0F0'
*
*
CLEARSCR  DC   X'27F5C31140403C404040'
*
*
          LTORG ,
*
*
SAVEA     DC    18F'0'
*
*
TRTAB    DC    XL256'00'          ESCAPE CHAR TRANSLATE TABLE
*
*
*
*
R0        EQU   0
R1        EQU   1
R2        EQU   2
R3        EQU   3
R4        EQU   4
R5        EQU   5
R6        EQU   6
R7        EQU   7
R8        EQU   8
R9        EQU   9
R10       EQU   10
R11       EQU   11
R12       EQU   12
R13       EQU   13
R14       EQU   14
R15       EQU   15
*
* ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** **
*
         $FSIECT ,
*
* ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** **
*
SVAR     DSECT ,
SVARBUFA DS    XL2
SVARLEN  DS    XL2
SVARZNUM DS    XL2
         DS    XL2
SVARNAME DS    CL8
SVARSIZE EQU   *-SVAR
*
*
         $FSISCR ,
*
*
          END   ,
./ ADD NAME=FSISTART
FSISTART CSECT ,
         SAVE  (14,12),,*
*
         LR    R12,R15
         USING FSISTART,R12
*
         LA    R11,SAVEA
         ST    R11,8(,R13)
         ST    R13,4(,R11)
         LR    R13,R11
*
         LR    R11,R1             SAVE CALLING PARM
*
***********************************************************************
*                       LOOK FOR FSILLIB DD CARD
***********************************************************************
*
         L     R1,16              ==>CVT
         L     R1,0(,R1)          ==>OLD/NEW
         L     R1,4(,R1)          ==>TCB
         L     R1,12(,R1)         ==>TIOT
*
         LA    R1,24(,R1)         DD SECTION OF TIOT
         SLR   R0,R0
*
FINDD010 DS    0H
         ICM   R0,B'0001',0(R1)   GET LENGTH OF DD ENTRY
         BZ    FINDD030           DD NOT FOUND
*
         CLC   =CL8'FSILLIB',4(R1)  FIND OUR DD ENTRY?
         BE    FINDD030
*
         AR    R1,R0              POINT TO NEXT ENTRY
         B     FINDD010           LOOP BACK
*
*
FINDD020 DS    0H
         OPEN  (FSILLIB,INPUT)
*
*
FINDD030 DS    0H
         TM    FSILLIB+48,X'10'   IS DCB OPEN
         BNO   LOAD010            NO - CAN USE
*
         LOAD  EP=FSIFUNC,DCB=FSILLIB
         LR    R10,R0             SAVE EP
         B     LOAD020
*
*
LOAD010  DS    0H
         LOAD  EP=FSIFUNC
         LR    R10,R0             SAVE EP
*
LOAD020  DS    0H
         L     R1,=V(VPUT)
         ST    R1,0(,R10)
         L     R1,=V(VGET)
         ST    R1,4(,R10)
         L     R1,=V(DISPLAY)
         ST    R1,8(,R10)
         L     R1,=V(VDEFINE)
         ST    R1,12(,R10)
*
*
         TM    0(R11),X'80'       OS TYPE PARM LIST?
         BNO   CMD000             NO - MUST BE TSO PARM LIST
*
         L     R2,0(,R11)         POINT TO PARM LIST
         LH    R3,0(,R2)          GET PARM LENGTH
         LA    R2,2(,R2)          POINT TO DATA
         B     CMD030
*
*
CMD000   DS    0H
         L     R2,0(,R11)         POINT TO CBUF
         LH    R3,0(,R2)          GET BUF LENGTH
         LA    R2,4(,R2)          POINT TO DATA
         S     R3,=F'4'           ADJUST LENGTH
         BNP   CMD050             NO - OPERAND
*
CMD010   DS    0H
         CLI   0(R2),C' '         LOOK FOR A SPACE
         BE    CMD020
         LA    R2,1(,R2)
         BCT   R3,CMD010
         B     CMD050             NO OPERAND FOUND
*
*
CMD020   DS    0H
         CLI   0(R2),C' '
         BNE   CMD030
         LA    R2,1(,R2)
         BCT   R3,CMD020
         B     CMD050             NO OPERAND FOUND
*
*
CMD030   DS    0H
         MVC   STARTPGM,=CL8' '
         LA    R4,STARTPGM
         LA    R5,8
*
CMD040   DS    0H
         CLI   0(R2),C' '         END ?
         BE    CMD050             YES - ALL DONE
*
         LTR   R5,R5
         BNP   CMD050
*
         MVC   0(1,R4),0(R2)
         LA    R4,1(,R4)
         LA    R2,1(,R2)
         S     R5,=F'1'
         BCT   R3,CMD040
CMD050   DS    0H
*
*
         STFSMODE ON,INITIAL=YES
         STTMPMD ON
*
         OC     STARTPGM,=CL8' '
*
         TM    FSILLIB+48,X'10'   DCB OPEN?
         BNO   ATTCH010           NO - CANT USE IT
*
         LA     R1,PARM
         ATTACH EPLOC=STARTPGM,ECB=ECB,DCB=FSILLIB
         ST     R1,TCB
*
         B     WAIT
*
*
ATTCH010 DS    0H
         LA     R1,PARM
         ATTACH EPLOC=STARTPGM,ECB=ECB
         ST     R1,TCB
*
*
WAIT     DS     0H
         WAIT   1,ECB=ECB
*
         DETACH TCB
*
         STLINENO LINE=1
         STFSMODE OFF
         STTMPMD OFF
*
*
         TM    FSILLIB+48,X'10'   DCB OPEN?
         BNO   EXIT               NO - SKIP CLOSE
*
         CLOSE (FSILLIB)
*
*
EXIT     DS    0H
*
*
         L     R13,4(,R13)
         LM    R14,R12,12(R13)
         SLR   R15,R15
         BR    R14
*
*
ECB      DC    F'0'
TCB      DC    F'0'
*
*
         DS    0F
PARM     DC    X'80',AL3(PARM2)
         DS    H'0'
PARM2    DS    H'0'
*
*
STARTPGM DC    CL8'FSIDFLT'
*
SAVEA    DS    18F
*
*
         PRINT NOGEN
FSILLIB  DCB   DSORG=PO,MACRF=R,DDNAME=FSILLIB
*
*
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
         END   ,
./ ADD NAME=FSISTUB
FSISTUB  CSECT ,
         ENTRY VPUT
VPUT     DS    0H
         SAVE  (14,12),,FSI_VPUT
         USING VPUT,R15
         L     R12,=A(FSISTUB)
         LA    R10,0
         B     COMMON
*
*
         ENTRY VGET
VGET     DS    0H
         SAVE  (14,12),,FSI_VGET
         USING VGET,R15
         L     R12,=A(FSISTUB)
         LA    R10,4
         B     COMMON
*
*
         ENTRY DISPLAY
DISPLAY  DS    0H
         SAVE  (14,12),,FSI_DISPLAY
         USING DISPLAY,R15
         L     R12,=A(FSISTUB)
         LA    R10,8
         B     COMMON
*
*
         ENTRY VDEFINE
VDEFINE  DS    0H
         SAVE  (14,12),,FSI_VDEFINE
         USING VDEFINE,R15
         L     R12,=A(FSISTUB)
         LA    R10,12
         B     COMMON
*
*
COMMON   DS    0H
         DROP  R15
         USING FSISTUB,R12
         LR    R11,R1            SAVE CALLING PARMS
*
         LA    R1,SAVEA
         ST    R13,4(,R1)
         ST    R1,8(,R13)
         LR    R13,R1
*
         L     R4,16              CVT
         L     R4,0(,R4)          OLD/NEW
         L     R4,4(,R4)          CURRENT TCB
*
LOK010   DS    0H
         L     R5,X'2C'(,R4)      JPQ (CDE CHAIN)
*
LOK020   DS    0H
         LTR   R5,R5              ANYTHING THERE?
         BZ    LOK030             NO - GO UP ONE TCB
*
         CLC   =CL8'FSIFUNC',8(R5)  LOOK FOR OUR INTERFACE MODULE
         BE    LOK050             GOODIE, WE FOUND IT
*
         L     R5,0(,R5)          NEXT CDE
         B     LOK020             LOOP BACK
*
*
LOK030   DS    0H
         L     R1,X'7C'(,R4)      JSTCB
         N     R1,=A(X'FFFFFF')
         N     R4,=A(X'FFFFFF')
         CR    R1,R4              END OF LIST?
         BE    LOK040             YES -
*
         L     R4,X'84'(,R4)      ATTACHING TCB
         B     LOK010
*
*
LOK040   DS    0H
         TPUT  ERRMSG,L'ERRMSG
         ABEND 888      NOT RUNNING IN A FSI ENVIRONMENT
*
*
LOK050   DS    0H
         L     R15,X'10'(,R5)     GET EP
         L     R15,0(R10,R15)     GET FUNC EP
         L     R13,4(,R13)
         L     R14,12(,R13)
         LM    R0,R12,20(R13)
         BR    R15
*
*
*
ERRMSG   DC    C'FSI888 - NOT RUNNING IN A FSI ENVIRONMENT'
*
*
SAVEA    DS    18F
*
*
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
         END   ,
./ ADD NAME=FSIVDEF
VDEFINE  CSECT ,
         SAVE  (14,12),,*
*
         LR    R12,R15
         USING VDEFINE,R12
*
         LA    R11,SAVEA
         ST    R13,4(,R11)
         ST    R11,8(,R13)
         LR    R13,R11
*
         L     R8,0(,R1)          VAR NAME
         L     R9,12(,R1)         VAR LENGTH
         L     R9,0(,R9)
         L     R10,4(,R1)         VAR DATA
         L     R7,8(,R1)          VAR TYPE
         L     R7,0(,R7)
*
*
         C     R7,=F'1'           FIXED/NUMERIC
         BL    ERROR              BRANCH IF ERROR
         C     R7,=F'2'           CHAR
         BH    ERROR
*
*
         L     R11,=V(VARDEFS)
*
         USING VARP,R11
*
FIND010  DS    0H
         CLC   VARPNAME,0(R8)     SEARCH FOR MATCHING NAME
         BE    UPDVAR             BRANCH IF FOUND
*
         CLC   VARPNAME,=X'0000000000000000'  EMPTY SLOT?
         BE    NEWVAR             YES - GO CREATE VAR ENTRY
*
         LA    R11,16(,R11)       POINT TO NEXT ENTRY
         B     FIND010            AND LOOP BACK
*
*
UPDVAR   DS    0H
NEWVAR   DS    0H
         MVC   VARPNAME,0(R8)     COPY IN VAR NAME
         C     R9,=F'256'         CHECK MAX LENGTH
         BNH   NEWV010            BRANCH IF OK
*
         LA    R9,256             TRUNC TO MAX LEN
NEWV010  DS    0H
         STH   R9,VARPLEN         SAVE VAR LENGTH
         STC   R7,VARPTYPE        SAVE VAR TYPE
         ST    R10,VARPDATA       SAVE DATA ADDRESS
*
         L     R13,4(,R13)
         LM    R14,R12,12(R13)
         SLR   R15,R15
         BR    R14
*
*
ERROR    DS    0H
         L     R13,4(,R13)
         LM    R14,R12,12(R13)
         LA    R15,8
         BR    R14
*
*
* ---------------------------------------------------------------------
*
*
         LTORG ,
*
*
SAVEA    DC    18F'0'
*
*
VARP     DSECT ,
VARPNAME DS    CL8      VAR NAME
VARPDATA DS    A        POINTER TO DATA
VARPLEN  DS    H        VAR LENGTH
VARPTYPE DS    X        TYPE: 1=FIXED, 2=CHAR
         DS    X
VARPELEN EQU   *-VARP
*
*
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
         END   ,
./ ADD NAME=FSIVGET
VGET     CSECT ,
         SAVE  (14,12),,*
*
         LR    R12,R15
         USING VGET,R12
*
         LA    R11,SAVEA
         ST    R13,4(,R11)
         ST    R11,8(,R13)
         LR    R13,R11
*
         L     R8,0(,R1)          VAR NAME
         L     R9,4(,R1)          VAR LENGTH
         L     R9,0(,R9)
         L     R10,8(,R1)         VAR DATA
*
         L     R11,=V(VARPOOL)
*
         USING VARP,R11
*
FIND010  DS    0H
         CLC   VARPNAME,0(R8)     SEARCH FOR MATCHING NAME
         BE    GETVAR             BRANCH IF FOUND
*
         CLC   VARPNAME,=X'0000000000000000'  EMPTY SLOT?
         BE    FIND020            YES - VAR NOT FOUND
*
         LA    R11,16(,R11)       POINT TO NEXT ENTRY
         B     FIND010            AND LOOP BACK
*
*
FIND020  DS    0H
*
         L     R13,4(,R13)
         LM    R14,R12,12(R13)
         LA    R15,8
         BR    R14
*
*
*----------------------------------------------------------------------
*
*
GETVAR   DS    0H
         C     R9,=F'256'         CHECK MAX LENGTH
         BNH   GETV010            BRANCH IF OK
*
         LA    R9,256             TRUNC TO MAX LEN
GETV010  DS    0H
         MVI   0(R10),C' '        START CLEARING TARGET AREA
         LR    R1,R9              COPY LENGTH
         BCTR  R1,0               SUBTRACT ONE
         LTR   R1,R1              CHECK FOR ZERO
         BZ    GETV020            YES - SKIP CLAER
         BCTR  R1,0
         EX    R1,GETVMVC1        CLEAR AREA
*ETVMVC1 MVC   1(0,R10),0(R10)    EXECUTED MOVE
*
GETV020  DS    0H
         LR    R1,R9              TARGET AREA LENGTH
         LH    R2,VARPLEN         GET VAR LENGTH
         CR    R1,R2
         BL    GETV030            USE SMALLEST OF SRC / TGT
*
         LR    R1,R2              SET LENGTH
*
GETV030  DS    0H
         L     R4,VARPDATA        POINT TO VAR DATA
         BCTR  R1,0               FOR EX
         EX    R1,GETVMVC2
*ETVMVC2 MVC   0(1,R10),0(R4)
*
*
         L     R13,4(,R13)
         LM    R14,R12,12(R13)
         SLR   R15,R15
         BR    R14
*
*
GETVMVC1 MVC   1(0,R10),0(R10)    EXECUTED MOVE
GETVMVC2 MVC   0(1,R10),0(R4)
*
*
* ---------------------------------------------------------------------
*
*
         LTORG ,
*
*
SAVEA    DC    18F'0'
*
*
VARP     DSECT ,
VARPNAME DS    CL8
VARPLEN  DS    H
         DS    XL2
VARPDATA DS    A
VARPELEN EQU   *-VARP
*
*
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
         END   ,
./ ADD NAME=FSIVLOC
VLOC     CSECT ,
         SAVE  (14,12),,*
*
         LR    R12,R15
         USING VLOC,R12
*
         LA    R11,SAVEA
         ST    R13,4(,R11)
         ST    R11,8(,R13)
         LR    R13,R11
*
         L     R8,0(,R1)          VAR NAME
         L     R9,4(,R1)          VAR LENGTH
         L     R9,0(,R9)
         L     R10,8(,R1)         VAR DATA
*
         L     R11,=V(VARDEFS)
*
         USING VARP,R11
*
FIND010  DS    0H
         CLC   VARPNAME,0(R8)     SEARCH FOR MATCHING NAME
         BE    GETVAR             BRANCH IF FOUND
*
         CLC   VARPNAME,=X'0000000000000000'  EMPTY SLOT?
         BE    FIND020            YES - VAR NOT FOUND
*
         LA    R11,16(,R11)       POINT TO NEXT ENTRY
         B     FIND010            AND LOOP BACK
*
*
FIND020  DS    0H
*
         L     R13,4(,R13)
         LM    R14,R12,12(R13)
         LA    R15,8
         BR    R14
*
*
*----------------------------------------------------------------------
*
*
GETVAR   DS    0H
         CLI   VARPTYPE,X'1'      FIXED/NUMERIC ?
         BE    NUMVAR             YES - BRANCH
*
         C     R9,=F'256'         CHECK MAX LENGTH
         BNH   GETV010            BRANCH IF OK
*
         LA    R9,256             TRUNC TO MAX LEN
GETV010  DS    0H
         MVI   0(R10),C' '        START CLEARING TARGET AREA
         LR    R1,R9              COPY LENGTH
         BCTR  R1,0               SUBTRACT ONE
         LTR   R1,R1              CHECK FOR ZERO
         BZ    GETV020            YES - SKIP CLAER
         BCTR  R1,0
         EX    R1,GETVMVC1        CLEAR AREA
*ETVMVC1 MVC   1(0,R10),0(R10)    EXECUTED MOVE
*
GETV020  DS    0H
         LR    R1,R9              TARGET AREA LENGTH
         LH    R2,VARPLEN         GET VAR LENGTH
         CR    R1,R2
         BL    GETV030            USE SMALLEST OF SRC / TGT
*
         LR    R1,R2              SET LENGTH
*
GETV030  DS    0H
         L     R4,VARPDATA        POINT TO VAR DATA
         BCTR  R1,0               FOR EX
         EX    R1,GETVMVC2
*ETVMVC2 MVC   0(1,R10),0(R4)
*
*
         L     R13,4(,R13)
         LM    R14,R12,12(R13)
         SLR   R15,R15
         BR    R14
*
*
GETVMVC1 MVC   1(0,R10),0(R10)    EXECUTED MOVE
GETVMVC2 MVC   0(1,R10),0(R4)
*
*
*----------------------------------------------------------------------
*
*
NUMVAR   DS    0H
         C     R9,=F'256'         CHECK MAX LENGTH
         BNH   NUMV010            BRANCH IF OK
*
         LA    R9,256             TRUNC TO MAX LEN
NUMV010  DS    0H
         MVI   0(R10),C' '        START CLEARING TARGET AREA
         LR    R1,R9              COPY LENGTH
         BCTR  R1,0               SUBTRACT ONE
*
         LTR   R1,R1              CHECK FOR ZERO
         BZ    NUMV020            YES - SKIP CLAER
*
         BCTR  R1,0
         EX    R1,NUMVMVC1        CLEAR AREA
*UMVMVC1 MVC   1(0,R10),0(R10)    EXECUTED MOVE
*
NUMV020  DS    0H
         L     R4,VARPDATA        ADDRESS OF DATA
         L     R2,0(,R4)          GET BINARY DATA VALUE
         CVD   R2,DOUBLE          CONVERT TO PACKED DECIMAL
         LA    R1,EDWK+15
         MVC   EDWK,=X'40202020202020202020202020202120'
         EDMK  EDWK,DOUBLE
         LR    R5,R1              SAVE ADDR OF 1ST DIGIT
         LA    R2,EDWK+15
         SR    R2,R1              GET THE LENGTH OF THE DATA
         LA    R2,1(,R2)          ADJUST AND PLACE IN R2
*
         LR    R1,R9              TARGET AREA LENGTH
         CR    R1,R2              COMPARE TARGET TO SOURCE LENGTH
         BL    NUMV030            BRANCH IF SOURCE IS LARGER
*
         LA    R4,0(R1,R10)       POINT TO END OF TGT FIELD
         SR    R4,R2              BACK UP LENGTH OF SRC FIELD
         BCTR  R2,0               ADJUST FOR EX
         EX    R2,NUMVMVC3        MOVE IN DATA
*UMVMVC3 MVC   0(1,R4),0(R5)
         B     EXIT               AND WE ARE DONE!
*
*
*
NUMV030  DS    0H
         BCTR  R1,0               ADJUST FOR EX
         EX    R1,NUMVMVC3        MOVE IN DATA
*UMVMVC2 MVC   0(1,R10),0(R5)
         B     EXIT               AND WE ARE DONE!
*
*
EXIT     DS    0H
         L     R13,4(,R13)
         LM    R14,R12,12(R13)
         SLR   R15,R15
         BR    R14
*
*
NUMVMVC1 MVC   1(0,R10),0(R10)    EXECUTED MOVE
NUMVMVC2 MVC   0(1,R10),0(R5)
NUMVMVC3 MVC   0(1,R4),0(R5)
*
*
* ---------------------------------------------------------------------
*
*
         LTORG ,
*
*
DOUBLE   DC    D'0'
EDWK     DC    XL16'00'
*
*
SAVEA    DC    18F'0'
*
*
VARP     DSECT ,
VARPNAME DS    CL8
VARPDATA DS    A
VARPLEN  DS    H
VARPTYPE DS    X
         DS    X
VARPELEN EQU   *-VARP
*
*
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
         END   ,
./ ADD NAME=FSIVPUT
VPUT     CSECT ,
         SAVE  (14,12),,*
*
         LR    R12,R15
         USING VPUT,R12
*
         LA    R11,SAVEA
         ST    R13,4(,R11)
         ST    R11,8(,R13)
         LR    R13,R11
*
         L     R8,0(,R1)          VAR NAME
         L     R9,4(,R1)          VAR LENGTH
         L     R9,0(,R9)
         L     R10,8(,R1)         VAR DATA
*
         L     R11,=V(VARPOOL)
*
         USING VARP,R11
*
FIND010  DS    0H
         CLC   VARPNAME,0(R8)     SEARCH FOR MATCHING NAME
         BE    UPDVAR             BRANCH IF FOUND
*
         CLC   VARPNAME,=X'0000000000000000'  EMPTY SLOT?
         BE    NEWVAR             YES - GO CREATE VAR ENTRY
*
         LA    R11,16(,R11)       POINT TO NEXT ENTRY
         B     FIND010            AND LOOP BACK
*
*
NEWVAR   DS    0H
         MVC   VARPNAME,0(R8)     COPY IN VAR NAME
         C     R9,=F'256'         CHECK MAX LENGTH
         BNH   NEWV010            BRANCH IF OK
*
         LA    R9,256             TRUNC TO MAX LEN
NEWV010  DS    0H
         STH   R9,VARPLEN         SAVE VAR LENGTH
         GETMAIN R,LV=256         ALLOC STORAGE
         ST    R1,VARPDATA        SAVE ADDRESS
         MVI   0(R1),C' '         CLEAR
         MVC   1(255,R1),0(R1)         OUT AREA
*
         LR    R3,R9
         BCTR  R3,0
         EX    R3,NEWVMVC         MOVE DATA
*
         L     R13,4(,R13)
         LM    R14,R12,12(R13)
         SLR   R15,R15
         BR    R14
*
*
NEWVMVC  MVC   0(1,R1),0(R10)     EXECUTED MOVE
*
*
*----------------------------------------------------------------------
*
*
UPDVAR   DS    0H
         MVC   VARPNAME,0(R8)     COPY IN VAR NAME
         C     R9,=F'256'         CHECK MAX LENGTH
         BNH   UPDV010            BRANCH IF OK
*
         LA    R9,256             TRUNC TO MAX LEN
UPDV010  DS    0H
         STH   R9,VARPLEN         SAVE VAR LENGTH
         L     R1,VARPDATA        GET DATA ADDRESS
         MVI   0(R1),C' '         CLEAR
         MVC   1(255,R1),0(R1)         OUT AREA
*
         LR    R3,R9
         BCTR  R3,0
         EX    R3,UPDVMVC         MOVE DATA
*
         L     R13,4(,R13)
         LM    R14,R12,12(R13)
         SLR   R15,R15
         BR    R14
*
*
UPDVMVC  MVC   0(1,R1),0(R10)     EXECUTED MOVE
*
*
* ---------------------------------------------------------------------
*
*
         LTORG ,
*
*
SAVEA    DC    18F'0'
*
*
VARP     DSECT ,
VARPNAME DS    CL8
VARPLEN  DS    H
         DS    XL2
VARPDATA DS    A
VARPELEN EQU   *-VARP
*
*
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
         END   ,
./ ADD NAME=FSIVSTO
VSTO     CSECT ,
         SAVE  (14,12),,*
*
         LR    R12,R15
         USING VSTO,R12
*
         LA    R11,SAVEA
         ST    R13,4(,R11)
         ST    R11,8(,R13)
         LR    R13,R11
*
         L     R8,0(,R1)          VAR NAME
         L     R9,4(,R1)          VAR LENGTH
         L     R9,0(,R9)
         L     R10,8(,R1)         VAR DATA
*
         L     R11,=V(VARDEFS)
*
         USING VARP,R11
*
FIND010  DS    0H
         CLC   VARPNAME,0(R8)     SEARCH FOR MATCHING NAME
         BE    GETVAR             BRANCH IF FOUND
*
         CLC   VARPNAME,=X'0000000000000000'  EMPTY SLOT?
         BE    FIND020            YES - VAR NOT FOUND
*
         LA    R11,16(,R11)       POINT TO NEXT ENTRY
         B     FIND010            AND LOOP BACK
*
*
FIND020  DS    0H
*
         L     R13,4(,R13)
         LM    R14,R12,12(R13)
         LA    R15,8
         BR    R14
*
*
*----------------------------------------------------------------------
*
*
GETVAR   DS    0H
         CLI   VARPTYPE,1         IS IT NUMERIC ?
         BE    NUMVAR             YES - BRANCH
*
         CLI   VARPTYPE,2         CHAR DATA ?
         BNE   ERROR              NO - DON'T KNOW WHAT IT IS
*
         L     R6,VARPDATA
         LH    R5,VARPLEN
         C     R9,=F'256'         CHECK MAX LENGTH
         BNH   GETV010            BRANCH IF OK
*
         LA    R9,256             TRUNC TO MAX LEN
GETV010  DS    0H
         MVI   0(R6),C' '         START CLEARING TARGET AREA
         LR    R1,R5              COPY LENGTH
         BCTR  R1,0               SUBTRACT ONE
         LTR   R1,R1              CHECK FOR ZERO
         BZ    GETV020            YES - SKIP CLAER
         BCTR  R1,0
         EX    R1,GETVMVC1        CLEAR AREA
*ETVMVC1 MVC   1(0,R6),0(R6)      EXECUTED MOVE
*
GETV020  DS    0H
         LR    R2,R9              AREA LENGTH
         LH    R1,VARPLEN         GET VAR LENGTH
         CR    R1,R2
         BL    GETV030            USE SMALLEST OF SRC / TGT
*
         LR    R1,R2              SET LENGTH
*
GETV030  DS    0H
         BCTR  R1,0               FOR EX
         EX    R1,GETVMVC2
*ETVMVC2 MVC   0(1,R6),0(R10)
*
*
         L     R13,4(,R13)
         LM    R14,R12,12(R13)
         SLR   R15,R15
         BR    R14
*
*
*----------------------------------------------------------------------
*
*
NUMVAR   DS    0H
         LA    R1,0
         ST    R1,ACCUM           CLEAR ACCUMULATOR
*
NUMV010  DS    0H
         CLI   0(R10),C'0'        CHECK FOR VALID NUMBER
         BL    NUMV020
         CLI   0(R10),C'9'
         BH    NUMV020
*
         MH    R1,=H'10'          SHIFT OVER
         SLR   R2,R2
         IC    R2,0(R10)
         N     R2,=A(X'0F')
         AR    R1,R2
         ST    R1,ACCUM           SAVE NEW VALUE
*
         LA    R10,1(,R10)
         BCT   R9,NUMV010         LOOP BACK
*
NUMV020  DS    0H
         L     R1,ACCUM
         L     R2,VARPDATA
         ST    R1,0(,R2)          SAVE NEW VALUE
*
         L     R13,4(,R13)
         LM    R14,R12,12(R13)
         SLR   R15,R15            SET ERROR RC
         BR    R14
*
*
*
*----------------------------------------------------------------------
*
*
ERROR    DS    0H
         L     R13,4(,R13)
         LM    R14,R12,12(R13)
         LA    R15,8              SET ERROR RC
         BR    R14
*
*
GETVMVC1 MVC   1(0,R6),0(R6)      EXECUTED MOVE
GETVMVC2 MVC   0(1,R6),0(R10)
*
*
* ---------------------------------------------------------------------
*
*
ACCUM    DC    F'0'
*
*
         LTORG ,
*
*
SAVEA    DC    18F'0'
*
*
VARP     DSECT ,
VARPNAME DS    CL8
VARPDATA DS    A
VARPLEN  DS    H
VARPTYPE DS    X
         DS    X
VARPELEN EQU   *-VARP
*
*
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
         END   ,
./ ADD NAME=VARDEFS
VARDEFS  CSECT ,
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         END   ,
./ ADD NAME=VARPOOL
VARPOOL  CSECT ,
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         DC    XL20'00'
         END   ,
@@
//SCLIST  EXEC PGM=PDSLOAD
//STEPLIB  DD  DSN=SYSC.LINKLIB,DISP=SHR
//SYSPRINT DD  SYSOUT=*
//SYSUT2   DD  DSN=SYSGEN.FSI.CLIST,
//             UNIT=SYSALLDA,VOL=SER=PUB001,
//             SPACE=(CYL,(15,2,20),RLSE),
//             DISP=(NEW,CATLG,DELETE)
//SYSUT1   DD  DATA,DLM=@@
./ ADD NAME=SAMP01
PROC 0
    ALLOC FI(SYSIN)    DA(*)
    ALLOC FI(SYSPRINT) DA(*)
    ALLOC FI(SYSTERM)  DA(*)
    ALLOC FI(FSIMLIB)  DA('SYSGEN.FSI.MLIB') SHR
    ALLOC FI(FSIPLIB)  DA('SYSGEN.FSI.PLIB') SHR
    ALLOC FI(FSILLIB)  DA('SYSGEN.FSI.LOAD') SHR 
    CALL 'SYSGEN.FSI.LOAD(FSISTART)' 'SAMP01'
    FREE FI(SYSIN,SYSPRINT,SYSTERM,FSIMLIB,FSIPLIB,FSILLIB)
EXIT
./ ADD NAME=SAMP02
PROC 0
    ALLOC FI(SYSIN)    DA(*)
    ALLOC FI(SYSPRINT) DA(*)
    ALLOC FI(SYSTERM)  DA(*)
    ALLOC FI(FSIMLIB)  DA('SYSGEN.FSI.MLIB') SHR
    ALLOC FI(FSIPLIB)  DA('SYSGEN.FSI.PLIB') SHR
    ALLOC FI(FSILLIB)  DA('SYSGEN.FSI.LOAD') SHR 
    CALL 'SYSGEN.FSI.LOAD(FSISTART)' 'SAMP02'
    FREE FI(SYSIN,SYSPRINT,SYSTERM,FSIMLIB,FSIPLIB,FSILLIB)
EXIT
./ ADD NAME=SAMP03
PROC 0
    ALLOC FI(SYSIN)    DA(*)
    ALLOC FI(SYSPRINT) DA(*)
    ALLOC FI(SYSTERM)  DA(*)
    ALLOC FI(FSIMLIB)  DA('SYSGEN.FSI.MLIB') SHR
    ALLOC FI(FSIPLIB)  DA('SYSGEN.FSI.PLIB') SHR
    ALLOC FI(FSILLIB)  DA('SYSGEN.FSI.LOAD') SHR 
    CALL 'SYSGEN.FSI.LOAD(FSISTART)' 'SAMP03'
    FREE FI(SYSIN,SYSPRINT,SYSTERM,FSIMLIB,FSIPLIB,FSILLIB)
EXIT
./ ADD NAME=SAMPC01
PROC 0
    ALLOC FI(SYSIN)    DA(*)
    ALLOC FI(SYSPRINT) DA(*)
    ALLOC FI(SYSTERM)  DA(*)
    ALLOC FI(FSIMLIB)  DA('SYSGEN.FSI.MLIB') SHR
    ALLOC FI(FSIPLIB)  DA('SYSGEN.FSI.PLIB') SHR
    ALLOC FI(FSILLIB)  DA('SYSGEN.FSI.LOAD') SHR 
    CALL 'SYSGEN.FSI.LOAD(FSISTART)' 'SAMPC01'
    FREE FI(SYSIN,SYSPRINT,SYSTERM,FSIMLIB,FSIPLIB,FSILLIB)
EXIT
@@
//SJCL    EXEC PGM=PDSLOAD
//STEPLIB  DD  DSN=SYSC.LINKLIB,DISP=SHR
//SYSPRINT DD  SYSOUT=*
//SYSUT2   DD  DSN=SYSGEN.FSI.JCL,
//             UNIT=SYSALLDA,VOL=SER=PUB001,
//             SPACE=(CYL,(15,2,20),RLSE),
//             DISP=(NEW,CATLG,DELETE)
//SYSUT1   DD  DATA,DLM=@@
./ ADD NAME=##LOAD
//FSILOAD JOB (5222),'TOMMY SPRINKLE',
//        CLASS=A,MSGCLASS=A
//*
//FSILOAD PROC PFX=FSI,
//        VRM=V1R2M0,
//        VOLSER=WORK01,
//        UNIT=3350
//IEBCOPY EXEC PGM=IEBCOPY
//SYSPRINT  DD SYSOUT=*
//*
//ASM       DD DSN=&PFX..&VRM..ASM,
            DISP=(NEW,CATLG,DELETE),
            UNIT=&UNIT,VOL=SER=&VOLSER,
            SPACE=(CYL,(1,0,36))
//OBJ       DD DSN=&PFX..&VRM..OBJ,
            DISP=(NEW,CATLG,DELETE),
            UNIT=&UNIT,VOL=SER=&VOLSER,
            SPACE=(CYL,(1,0,36))
//LOAD      DD DSN=&PFX..&VRM..LOAD,
            DISP=(NEW,CATLG,DELETE),
            UNIT=&UNIT,VOL=SER=&VOLSER,
            SPACE=(CYL,(1,0,36))
//PLIB      DD DSN=&PFX..&VRM..PLIB,
            DISP=(NEW,CATLG,DELETE),
            UNIT=&UNIT,VOL=SER=&VOLSER,
            SPACE=(CYL,(1,0,36))
//MLIB      DD DSN=&PFX..&VRM..MLIB,
            DISP=(NEW,CATLG,DELETE),
            UNIT=&UNIT,VOL=SER=&VOLSER,
            SPACE=(CYL,(1,0,36))
//*
//*
//*
//ASMT      DD DSN=FSI.&VRM..ASMT,
//          DISP=(OLD,KEEP,KEEP),
//          UNIT=TAPE,LABEL=(1,SL),
//          VOL=(,RETAIN,SER=FSI120)
//OBJT      DD DSN=FSI.&VRM..OBJT,
//          DISP=(OLD,KEEP,KEEP),
//          UNIT=TAPE,LABEL=(2,SL),
//          VOL=(,RETAIN,REF=*.ASMT)
//LOADT     DD DSN=FSI.&VRM..LOADT,
//          DISP=(OLD,KEEP,KEEP),
//          UNIT=TAPE,LABEL=(3,SL),
//          VOL=(,RETAIN,REF=*.OBJT)
//PLIBT     DD DSN=FSI.&VRM..PLIBT,
//          DISP=(OLD,KEEP,KEEP),
//          UNIT=TAPE,LABEL=(4,SL),
//          VOL=(,RETAIN,REF=*.LOADT)
//MLIBT     DD DSN=FSI.&VRM..MLIBT,
//          DISP=(OLD,KEEP,KEEP),
//          UNIT=TAPE,LABEL=(5,SL),
//          VOL=REF=*.PLIBT
// PEND
//*
//UNLOAD EXEC PROC=FSIUNLD
//IEBCOPY.SYSIN DD *
  C O=ASM,I=ASMT
  C O=OBJ,I=OBJT
  C O=LOAD,I=LOADT
  C O=MLIB,I=MLIBT
  C O=PLIB,I=PLIBT
/*
//
./ ADD NAME=##UNLOAD
//FSIUNLD JOB (5222),'TOMMY SPRINKLE',
//        CLASS=A,MSGCLASS=A
//*
//FSIUNLD PROC  PFX=FSI,
//        VRM=V1R2M0
//IEBCOPY EXEC PGM=IEBCOPY
//SYSPRINT  DD SYSOUT=*
//ASM       DD DISP=SHR,DSN=&PFX..&VRM..ASM
//OBJ       DD DISP=SHR,DSN=&PFX..&VRM..OBJ
//LOAD      DD DISP=SHR,DSN=&PFX..&VRM..LOAD
//PLIB      DD DISP=SHR,DSN=&PFX..&VRM..PLIB
//MLIB      DD DISP=SHR,DSN=&PFX..&VRM..MLIB
//ASMT      DD DSN=&PFX..&VRM..ASMT,
//          DISP=(NEW,KEEP,KEEP),
//          UNIT=TAPE,LABEL=(1,SL),
//          VOL=(,RETAIN,SER=FSI120)
//OBJT      DD DSN=&PFX..&VRM..OBJT,
//          DISP=(NEW,KEEP,KEEP),
//          UNIT=TAPE,LABEL=(2,SL),
//          VOL=(,RETAIN,REF=*.ASMT)
//LOADT     DD DSN=&PFX..&VRM..LOADT,
//          DISP=(NEW,KEEP,KEEP),
//          UNIT=TAPE,LABEL=(3,SL),
//          VOL=(,RETAIN,REF=*.OBJT)
//PLIBT     DD DSN=&PFX..&VRM..PLIBT,
//          DISP=(NEW,KEEP,KEEP),
//          UNIT=TAPE,LABEL=(4,SL),
//          VOL=(,RETAIN,REF=*.LOADT)
//MLIBT     DD DSN=&PFX..&VRM..MLIBT,
//          DISP=(NEW,KEEP,KEEP),
//          UNIT=TAPE,LABEL=(5,SL),
//          VOL=REF=*.PLIBT
// PEND
//*
//UNLOAD EXEC PROC=FSIUNLD
//IEBCOPY.SYSIN DD *
  C I=ASM,O=ASMT
  C I=OBJ,O=OBJT
  C I=LOAD,O=LOADT
  C I=PLIB,O=PLIBT
  C I=MLIB,O=MLIBT
/*
//
./ ADD NAME=#ASM
//FSIASM   JOB 5222,'SPRINKLE',CLASS=A,MSGCLASS=A,
//        MSGLEVEL=(1,1)
//TCSASM PROC M=
//ASM      EXEC  PGM=IFOX00,REGION=1024K,
//         PARM='LINECOUNT(45)'
//SYSLIB   DD    DISP=SHR,DSN=SYS1.MACLIB
//         DD    DISP=SHR,DSN=SYS1.AMODGEN
//         DD    DISP=SHR,DSN=SYSGEN.FSI.ASM
//SYSUT1   DD    DSN=&&SYSUT1,UNIT=VIO,SPACE=(1700,(600,100))
//SYSUT2   DD    DSN=&&SYSUT2,UNIT=VIO,SPACE=(1700,(300,50))
//SYSUT3   DD    DSN=&&SYSUT3,UNIT=VIO,SPACE=(1700,(300,50))
//SYSPRINT DD    SYSOUT=*
//SYSPUNCH DD    DISP=SHR,DSN=SYSGEN.FSI.OBJ(&M)
//SYSIN    DD    DISP=SHR,DSN=SYSGEN.FSI.ASM(&M)
//   PEND
//FSISTART EXEC TCSASM,M=FSISTART
//FSISTUB  EXEC TCSASM,M=FSISTUB
//FSIDSPLY EXEC TCSASM,M=FSIDSPLY
//FSIERMSG EXEC TCSASM,M=FSIERMSG
//FSIPANL  EXEC TCSASM,M=FSIPANL
//FSISCRN  EXEC TCSASM,M=FSISCRN
//FSIVPUT  EXEC TCSASM,M=FSIVPUT
//FSIVGET  EXEC TCSASM,M=FSIVGET
//FSIPDS   EXEC TCSASM,M=FSIPDS
//FSIFUNC  EXEC TCSASM,M=FSIFUNC
//FSIDFLT  EXEC TCSASM,M=FSIDFLT
//VARPOOL  EXEC TCSASM,M=VARPOOL
//FSIVDEF  EXEC TCSASM,M=FSIVDEF
//FSIVLOC  EXEC TCSASM,M=FSIVLOC
//FSIVSTO  EXEC TCSASM,M=FSIVSTO
//VARDEFS  EXEC TCSASM,M=VARDEFS
//FSIVDEF  EXEC TCSASM,M=FSIVDEF
//FSIVSTO  EXEC TCSASM,M=FSIVSTO
//FSIVLOC  EXEC TCSASM,M=FSIVLOC
//
//*
./ ADD NAME=#CMP
//COMPRESS JOB (5222),'SPRINKLE',CLASS=A,MSGCLASS=A
//COMPRESS EXEC PGM=IEBCOPY
//SYSPRINT DD   SYSOUT=*
//ASM      DD   DISP=SHR,DSN= SYSGEN.FSI.ASM
//OBJ      DD   DISP=SHR,DSN= SYSGEN.FSI.OBJ
//MLIB     DD   DISP=SHR,DSN= SYSGEN.FSI.MLIB
//PLIB     DD   DISP=SHR,DSN= SYSGEN.FSI.PLIB
//LOAD     DD   DISP=SHR,DSN= SYSGEN.FSI.LOAD
//SYSIN    DD   *
 C I=ASM,O=ASM
 C I=OBJ,O=OBJ
 C I=MLIB,O=MLIB
 C I=PLIB,O=PLIB
 C I=LOAD,O=LOAD
/*
./ ADD NAME=#LINK
//TCS3LINK JOB 5222,'LINK EDIT',CLASS=A,MSGCLASS=A,
//         MSGLEVEL=(1,1) NOTIFY=TCS3
//*
//COPY     EXEC PGM=IEBGENER
//SYSPRINT   DD SYSOUT=*
//SYSIN      DD DUMMY
//SYSUT1     DD DISP=SHR,DSN=TCS3.FSI.OBJ(TESTR1)
//           DD DISP=SHR,DSN=TCS3.FSI.OBJ(FSISTUB)
//SYSUT2     DD DSN=TCS3.MVS.TEMPLINK,
//           DISP=(NEW,CATLG,DELETE),
//           DCB=(BLKSIZE=80,LRECL=80,RECFM=F),
//           UNIT=3350,SPACE=(CYL,(1,1))
//*
//*
//LKED     EXEC PGM=IEWL,PARM='XREF,LIST,LET,NCAL',REGION=1024K
//SYSPRINT DD  SYSOUT=A
//SYSLIN   DD  DSN=TCS3.MVS.TEMPLINK,DISP=(OLD,DELETE,DELETE)
//SYSLMOD  DD  DISP=SHR,DSN=TCS3.FSI.LOAD(T)
//SYSUT1   DD  UNIT=3350,
//         SPACE=(1024,(200,20))
//*
//
./ ADD NAME=#LINKENV
//TCS3LINK JOB 5222,'LINK FSISTART',CLASS=A,MSGCLASS=A,
//         MSGLEVEL=(1,1)
//*
//COPY     EXEC PGM=IEBGENER
//SYSPRINT   DD SYSOUT=*
//SYSIN      DD DUMMY
//SYSUT1     DD DISP=SHR,DSN= SYSGEN.FSI.OBJ(FSISTART)
//           DD DISP=SHR,DSN= SYSGEN.FSI.OBJ(FSISCRN)
//           DD DISP=SHR,DSN= SYSGEN.FSI.OBJ(FSIPANL)
//           DD DISP=SHR,DSN= SYSGEN.FSI.OBJ(FSIERMSG)
//           DD DISP=SHR,DSN= SYSGEN.FSI.OBJ(FSIDSPLY)
//           DD DISP=SHR,DSN= SYSGEN.FSI.OBJ(FSIVGET)
//           DD DISP=SHR,DSN= SYSGEN.FSI.OBJ(FSIVPUT)
//           DD DISP=SHR,DSN= SYSGEN.FSI.OBJ(FSIPDS)
//           DD DISP=SHR,DSN= SYSGEN.FSI.OBJ(FSIVDEF)
//           DD DISP=SHR,DSN= SYSGEN.FSI.OBJ(FSIVLOC)
//           DD DISP=SHR,DSN= SYSGEN.FSI.OBJ(FSIVSTO)
//           DD DISP=SHR,DSN= SYSGEN.FSI.OBJ(VARPOOL)
//           DD DISP=SHR,DSN= SYSGEN.FSI.OBJ(VARDEFS)
//SYSUT2     DD DSN=&&FSISTART,
//           DISP=(NEW,PASS,DELETE),
//           DCB=(BLKSIZE=80,LRECL=80,RECFM=F),
//           UNIT=3350,SPACE=(CYL,(1,1))
//*
//*
//FSISTART EXEC PGM=IEWL,PARM='XREF,LIST,LET,NCAL',REGION=1024K
//SYSPRINT DD  SYSOUT=A
//SYSLIN   DD  DSN=&&FSISTART,DISP=(OLD,DELETE,DELETE)
//SYSLMOD  DD  DISP=SHR,DSN= SYSGEN.FSI.LOAD(FSISTART)
//SYSUT1   DD  UNIT=3350,
//         SPACE=(1024,(200,20))
//*
//*-------------------------------------------------------------------
//*
//COPY     EXEC PGM=IEBGENER
//SYSPRINT   DD SYSOUT=*
//SYSIN      DD DUMMY
//SYSUT1     DD DISP=SHR,DSN= SYSGEN.FSI.OBJ(FSIFUNC)
//SYSUT2     DD DSN=&&FSIFUNC,
//           DISP=(NEW,PASS,DELETE),
//           DCB=(BLKSIZE=80,LRECL=80,RECFM=F),
//           UNIT=3350,SPACE=(CYL,(1,1))
//*
//*
//FSIFUNC  EXEC PGM=IEWL,PARM='XREF,LIST,LET,NCAL',REGION=1024K
//SYSPRINT DD  SYSOUT=A
//SYSLIN   DD  DSN=&&FSIFUNC,DISP=(OLD,DELETE,DELETE)
//SYSLMOD  DD  DISP=SHR,DSN= SYSGEN.FSI.LOAD(FSIFUNC)
//SYSUT1   DD  UNIT=3350,
//         SPACE=(1024,(200,20))
//*
//*-------------------------------------------------------------------
//*
//COPY     EXEC PGM=IEBGENER
//SYSPRINT   DD SYSOUT=*
//SYSIN      DD DUMMY
//SYSUT1     DD DISP=SHR,DSN= SYSGEN.FSI.OBJ(FSIDFLT)
//           DD DISP=SHR,DSN= SYSGEN.FSI.OBJ(FSISTUB)
//SYSUT2     DD DSN=&&FSIFUNC,
//           DISP=(NEW,PASS,DELETE),
//           DCB=(BLKSIZE=80,LRECL=80,RECFM=F),
//           UNIT=3350,SPACE=(CYL,(1,1))
//*
//*
//FSIDFLT  EXEC PGM=IEWL,PARM='XREF,LIST,LET,NCAL',REGION=1024K
//SYSPRINT DD  SYSOUT=A
//SYSLIN   DD  DSN=&&FSIFUNC,DISP=(OLD,DELETE,DELETE)
//SYSLMOD  DD  DISP=SHR,DSN= SYSGEN.FSI.LOAD(FSIDFLT)
//SYSUT1   DD  UNIT=3350,
//         SPACE=(1024,(200,20))
//*
//
./ ADD NAME=#SAMP01
//SAMP01 JOB 5222,'SPRINKLE',
//        CLASS=A,MSGCLASS=A,
//        MSGLEVEL=(1,1)
//ASM      EXEC  PGM=IFOX00,REGION=1024K,
//         PARM='LINECOUNT(45)'
//SYSLIB   DD    DISP=SHR,DSN=SYS1.MACLIB
//         DD    DISP=SHR,DSN=SYS1.AMODGEN
//         DD    DISP=SHR,DSN=SYSGEN.FSI.ASM
//SYSUT1   DD    DSN=&&SYSUT1,UNIT=VIO,SPACE=(1700,(600,100))
//SYSUT2   DD    DSN=&&SYSUT2,UNIT=VIO,SPACE=(1700,(300,50))
//SYSUT3   DD    DSN=&&SYSUT3,UNIT=VIO,SPACE=(1700,(300,50))
//SYSPRINT DD    SYSOUT=*
//SYSIN    DD    DISP=SHR,DSN=SYSGEN.FSI.SAMP(SAMP01)
//SYSPUNCH DD    DISP=SHR,DSN=SYSGEN.FSI.OBJ(SAMP01)
//*-------------------------
//COPY     EXEC PGM=IEBGENER
//SYSPRINT DD SYSOUT=*
//SYSIN    DD DUMMY
//SYSUT1   DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(SAMP01)
//         DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSISTUB)
//SYSUT2   DD DSN=&&TEMPLINK,
//         DISP=(NEW,PASS,DELETE),
//         DCB=(BLKSIZE=80,LRECL=80,RECFM=F),
//         UNIT=SYSALLDA,VOL=SER=PUB001,
//         SPACE=(CYL,(1,1))
//*-------------------------
//LKED     EXEC PGM=IEWL,PARM='XREF,LIST,LET,NCAL',REGION=1024K
//SYSPRINT DD  SYSOUT=A
//SYSLIN   DD  DSN=&&TEMPLINK,DISP=(OLD,DELETE,DELETE)
//SYSLMOD  DD  DISP=SHR,DSN=SYSGEN.FSI.LOAD(SAMP01)
//SYSUT1   DD  UNIT=SYSALLDA,VOL=SER=PUB001,
//         SPACE=(1024,(200,20))
//
./ ADD NAME=#SAMP02
//SAMP02 JOB 5222,'SPRINKLE',
//        CLASS=A,MSGCLASS=A,
//        MSGLEVEL=(1,1)
//ASM      EXEC  PGM=IFOX00,REGION=1024K,
//         PARM='LINECOUNT(45)'
//SYSLIB   DD    DISP=SHR,DSN=SYS1.MACLIB
//         DD    DISP=SHR,DSN=SYS1.AMODGEN
//         DD    DISP=SHR,DSN=SYSGEN.FSI.ASM
//SYSUT1   DD    DSN=&&SYSUT1,UNIT=VIO,SPACE=(1700,(600,100))
//SYSUT2   DD    DSN=&&SYSUT2,UNIT=VIO,SPACE=(1700,(300,50))
//SYSUT3   DD    DSN=&&SYSUT3,UNIT=VIO,SPACE=(1700,(300,50))
//SYSPRINT DD    SYSOUT=*
//SYSIN    DD    DISP=SHR,DSN=SYSGEN.FSI.SAMP(SAMP02)
//SYSPUNCH DD    DISP=SHR,DSN=SYSGEN.FSI.OBJ(SAMP02)
//*-------------------------
//COPY     EXEC PGM=IEBGENER
//SYSPRINT DD SYSOUT=*
//SYSIN    DD DUMMY
//SYSUT1   DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(SAMP02)
//         DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSISTUB)
//SYSUT2   DD DSN=&&TEMPLINK,
//         DISP=(NEW,PASS,DELETE),
//         DCB=(BLKSIZE=80,LRECL=80,RECFM=F),
//         UNIT=SYSALLDA,VOL=SER=PUB001,
//         SPACE=(CYL,(1,1))
//*-------------------------
//LKED     EXEC PGM=IEWL,PARM='XREF,LIST,LET,NCAL',REGION=1024K
//SYSPRINT DD  SYSOUT=A
//SYSLIN   DD  DSN=&&TEMPLINK,DISP=(OLD,DELETE,DELETE)
//SYSLMOD  DD  DISP=SHR,DSN=SYSGEN.FSI.LOAD(SAMP02)
//SYSUT1   DD  UNIT=SYSALLDA,VOL=SER=PUB001,
//         SPACE=(1024,(200,20))
//
./ ADD NAME=#SAMP03
//SAMP03 JOB 5222,'SPRINKLE',
//        CLASS=A,MSGCLASS=A,
//        MSGLEVEL=(1,1)
//ASM      EXEC  PGM=IFOX00,REGION=1024K,
//         PARM='LINECOUNT(45)'
//SYSLIB   DD    DISP=SHR,DSN=SYS1.MACLIB
//         DD    DISP=SHR,DSN=SYS1.AMODGEN
//         DD    DISP=SHR,DSN=SYSGEN.FSI.ASM
//SYSUT1   DD    DSN=&&SYSUT1,UNIT=VIO,SPACE=(1700,(600,100))
//SYSUT2   DD    DSN=&&SYSUT2,UNIT=VIO,SPACE=(1700,(300,50))
//SYSUT3   DD    DSN=&&SYSUT3,UNIT=VIO,SPACE=(1700,(300,50))
//SYSPRINT DD    SYSOUT=*
//SYSIN    DD    DISP=SHR,DSN=SYSGEN.FSI.SAMP(SAMP03)
//SYSPUNCH DD    DISP=SHR,DSN=SYSGEN.FSI.OBJ(SAMP03)
//*-------------------------
//COPY     EXEC PGM=IEBGENER
//SYSPRINT DD SYSOUT=*
//SYSIN    DD DUMMY
//SYSUT1   DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(SAMP03)
//         DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSISTUB)
//SYSUT2   DD DSN=&&TEMPLINK,
//         DISP=(NEW,PASS,DELETE),
//         DCB=(BLKSIZE=80,LRECL=80,RECFM=F),
//         UNIT=SYSALLDA,VOL=SER=PUB001,
//         SPACE=(CYL,(1,1))
//*-------------------------
//LKED     EXEC PGM=IEWL,PARM='XREF,LIST,LET,NCAL',REGION=1024K
//SYSPRINT DD  SYSOUT=A
//SYSLIN   DD  DSN=&&TEMPLINK,DISP=(OLD,DELETE,DELETE)
//SYSLMOD  DD  DISP=SHR,DSN=SYSGEN.FSI.LOAD(SAMP03)
//SYSUT1   DD  UNIT=SYSALLDA,VOL=SER=PUB001,
//         SPACE=(1024,(200,20))
//
./ ADD NAME=#SAMPC01
//SAMPC01  JOB 5222,'SPRINKLE',CLASS=A,MSGCLASS=A,
//        MSGLEVEL=(1,1)
//COB      EXEC  PGM=IKFCBL00,REGION=4096K,
//         PARM='LOAD,SUPMAP,SIZE=2048K,BUF=1024K'
//STEPLIB  DD    DISP=SHR,DSN=SYSC.LINKLIB
//SYSLIB   DD    DISP=SHR,DSN=SYS1.MACLIB
//         DD    DISP=SHR,DSN=SYS1.AMODGEN
//         DD    DISP=SHR,DSN=SYSGEN.FSI.ASM
//SYSUT1   DD    DSN=&&SYSUT1,UNIT=VIO,SPACE=(1700,(600,100))
//SYSUT2   DD    DSN=&&SYSUT2,UNIT=VIO,SPACE=(1700,(300,50))
//SYSUT3   DD    DSN=&&SYSUT3,UNIT=VIO,SPACE=(1700,(300,50))
//SYSUT4   DD    DSN=&&SYSUT3,UNIT=VIO,SPACE=(1700,(300,50))
//SYSPRINT DD    SYSOUT=*
//SYSIN    DD    DISP=SHR,DSN=SYSGEN.FSI.SAMP(SAMPC01)
//SYSLIN   DD    DISP=SHR,DSN=SYSGEN.FSI.OBJ(SAMPC01)
//SYSPUNCH DD    DUMMY
//*-------------------------
//COPY     EXEC PGM=IEBGENER
//SYSPRINT DD SYSOUT=*
//SYSIN    DD DUMMY
//SYSUT1   DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(SAMPC01)
//         DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSISTUB)
//SYSUT2   DD DSN=&&TEMPLINK,
//         DISP=(NEW,PASS,DELETE),
//         DCB=(BLKSIZE=80,LRECL=80,RECFM=F),
//         UNIT=SYSALLDA,VOL=SER=PUB001,
//         SPACE=(CYL,(1,1))
//*-------------------------
//LKED     EXEC PGM=IEWL,PARM='XREF,LIST,LET',REGION=1024K
//SYSPRINT DD  SYSOUT=A
//SYSLIB   DD  DISP=SHR,DSN=SYSC.COBLIB
//         DD  DISP=SHR,DSN=SYS1.LINKLIB
//SYSLIN   DD  DSN=&&TEMPLINK,DISP=(OLD,DELETE,DELETE)
//SYSLMOD  DD  DISP=SHR,DSN=SYSGEN.FSI.LOAD(SAMPC01)
//SYSUT1   DD  UNIT=SYSALLDA,VOL=SER=PUB001,
//         SPACE=(1024,(200,20))
//
@@
//SMLIB   EXEC PGM=PDSLOAD
//STEPLIB  DD  DSN=SYSC.LINKLIB,DISP=SHR
//SYSPRINT DD  SYSOUT=*
//SYSUT2   DD  DSN=SYSGEN.FSI.MLIB,
//             UNIT=SYSALLDA,VOL=SER=PUB001,
//             SPACE=(CYL,(15,2,20),RLSE),
//             DISP=(NEW,CATLG,DELETE)
//SYSUT1   DD  DATA,DLM=@@
./ ADD NAME=SAMP010
SAMP0101 'INVALID USERID ENTERED'
SAMP0102 'HINT: USE ANYTHING FOR THE USERID'
SAMP0103 'INVALID PASSWORD ENTERED'
SAMP0104 'HINT: TRY USING ''SECRET'' FOR THE PASSWORD'
SAMP0105 'HINT: TRY USING ''END'' FOR A COMMAND'
./ ADD NAME=SAMP020
SAMP0201 'COMMAND NOT IMPLEMENTED'
SAMP0202 'INVALID COMMAND'
@@
//SPLIB   EXEC PGM=PDSLOAD
//STEPLIB  DD  DSN=SYSC.LINKLIB,DISP=SHR
//SYSPRINT DD  SYSOUT=*
//SYSUT2   DD  DSN=SYSGEN.FSI.PLIB,
//             UNIT=SYSALLDA,VOL=SER=PUB001,
//             SPACE=(CYL,(15,2,20),RLSE),
//             DISP=(NEW,CATLG,DELETE)
//SYSUT1   DD  DATA,DLM=@@
./ ADD NAME=FSIDFLT
)ATTR DEFAULT(%+_)
 ! TYPE(OUTPUT) INTENS(HIGH)
 : TYPE(INPUT)  INTENS(NON)
)BODY
+-----------------------------------------------------------------------
+
+
+
+
+               %@@@@@@@@@@@@@@     @@@@@@@@@@@    @@@@@@@@@@@@
+              %@@@@@@@@@@@@@@    @@@@@@@@@@@@    @@@@@@@@@@@@
+             %@@@@              @@@@                @@@@
+            %@@@@@@@@@@         @@@@@@@@@@         @@@@
+           %@@@@@@@@@@                @@@@        @@@@
+          %@@@@              @@@@@@@@@@@@    @@@@@@@@@@@@
+         %@@@@              @@@@@@@@@@@     @@@@@@@@@@@@
+
+
+
+              -----------------------------------------------
+              |                                             |
+              |    %NO INITIAL PROGRAM SPECIFIED TO RUN+    |
+              |                                             |
+              -----------------------------------------------
+
+
+
%===>_ZCMD                                                             +
)END
./ ADD NAME=SAMP01A
)ATTR DEFAULT(%+_)
 ! TYPE(OUTPUT) INTENS(HIGH)
 : TYPE(INPUT)  INTENS(NON)
)BODY
+
+                                 +TEST PANEL
+
+
+
+               %@@@@@@@@@@@@@@     @@@@@@@@@@@    @@@@@@@@@@@@
+              %@@@@@@@@@@@@@@    @@@@@@@@@@@@    @@@@@@@@@@@@
+             %@@@@              @@@@                @@@@
+            %@@@@@@@@@@         @@@@@@@@@@         @@@@
+           %@@@@@@@@@@                @@@@        @@@@
+          %@@@@              @@@@@@@@@@@@    @@@@@@@@@@@@
+         %@@@@              @@@@@@@@@@@     @@@@@@@@@@@@
+
+       !Z       +
+                           +USERID%===>_Z       +
+
+                           +PASSWD%===>:Z       +
+
+
+
+
+
!HITS    %HITS+
%===>_ZCMD                                                             +
)PROC
 .ZVARS = '(ZSTAT USERID
                  PASSWD)'
)END
./ ADD NAME=SAMP01B
)ATTR DEFAULT(%+_)
 ! TYPE(OUTPUT) INTENS(HIGH)
)BODY
+
+
+
+
+
+
+
+
+
+ WELCOME TO FSI TEST SYSTEM
+
+     PLEASE ENTER A COMMAND TO CONTINUE
+
+     CURRENTLY THE ONLY%VALID+COMMANDS ARE:
+         %END+
+
+
+
+
+
+
+
!HITS    %HITS+
%===>_ZCMD                                                             +
)END
./ ADD NAME=SAMP02A
)ATTR DEFAULT(%+:)
 # TYPE(OUTPUT) INTENS(LOW)
)BODY
%--------------------------------- FSI MAIN MENU -----------------------
%OPTION ===>:ZCMD
+                                                            USERID  -#Z
   %0 +DEFAULTS    - ALTER / DISPLAY SESSION DEFAULS         TIME    -#Z
   %1 +VIEW        - DISPLAY SOURCE DATA OR OUTPUT LISTINGS  SYSTEM  -#Z
   %2 +EDIT        - UPDATE / CREATE A MEMBER OR DATASET     TSO-PROC-#Z
   %3 +UTILITY     - ENTER UTILITY
   %4 +ASSEMBLER   - FOREGROUND ASSEMBLER AND LINK
   %5 +USER        - EXECUTE RPF USER ROUTINE
   %6 +TSO         - EXECUTE TSO COMMANDS
   %7 +TUTORIAL    - DISPLAY HELP INFORMATION
   %8 +TEST        - ENTER TEST MODE (AUTHORIZED)
   %9 +OPERATOR    - ENTER OPERATOR MODE
   %X +EXIT        - TERMINATE FSI
+
+HIT%PF03/15+TO TERMINATE FSI
% ____________________________
%|                            |
%| FSI VERSION 1 RELEASE 1.0  |
%|                            |
%| WRITTEN BY TOMMY SPRINKLE  |
%| TOMMY@TOMMYSPRINKLE.COM    |
%|____________________________|                                        +
+
)END
./ ADD NAME=SAMP03A
)ATTR DEFAULT(%+:)
 # TYPE(OUTPUT) INTENS(LOW)
)BODY
%--------------------------------- FSI TEST PANEL ----------------------
%OPTION ===>:ZCMD
+
+  +A NUMERIC FIELD%==>:NUMBER+
+
+  +THE NUMERIC FIELD (#NUMBER+)
+
+
+
+
+
+
+
+
+
+HIT%PF03/15+TO TERMINATE FSI
+
+
+
+
+
+
+
+
)END
@@
//SSAMP   EXEC PGM=PDSLOAD
//STEPLIB  DD  DSN=SYSC.LINKLIB,DISP=SHR
//SYSPRINT DD  SYSOUT=*
//SYSUT2   DD  DSN=SYSGEN.FSI.SAMP,
//             UNIT=SYSALLDA,VOL=SER=PUB001,
//             SPACE=(CYL,(15,2,20),RLSE),
//             DISP=(NEW,CATLG,DELETE)
//SYSUT1   DD  DATA,DLM=@@
./ ADD NAME=SAMP01
SAMP01   CSECT ,
         SAVE  (14,12),,*
*
         LR    R12,R15
         USING SAMP01,R12
*
         LA    R11,SAVEA
         ST    R13,4(,R11)
         ST    R11,8(,R13)
         LR    R13,R11
*
*
         $VDEF ('PF03',PF03,2,8,0)
*
         $VDEF ('PF15',PF15,2,8,0)
*
*
         $VDEF ('ZSTAT',ZSTAT,2,2,0)
*
         $VDEF ('USERID',USERID,2,8,0)
*
         $VDEF ('PASSWD',PASSWD,2,8,0)
*
         $VDEF ('ZCMD',ZCMD,2,50,0)
*
         $VDEF ('HITS',HITS,1,4,0)
*
*/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z
*
         XC    ERRSTAT,ERRSTAT
LOGIN    DS    0H
         MVC   ERRSTAT1,ERRSTAT
         XC    ERRSTAT,ERRSTAT
*
         $DISPLAY ('SAMP01A',MSGID,CSRFLD)
*
         L     R1,HITS
         LA    R1,1(,R1)
         ST    R1,HITS
*
         MVC   MSGID,=CL8' '
         MVC   CSRFLD,=CL8' '
*
*
         OC    ZCMD,=CL50' '
         CLC   =C'END ',ZCMD
         BE    GOOD900
*
*
         CLC   =CL8' ',USERID
         BE    LOG010
*
         OC    PASSWD,=CL8' '
         CLC   =CL8'SECRET',PASSWD
         BNE   LOG020
*
         B     GOOD010
*
*
LOG010   DS    0H
         MVI   ERRSTAT,C'U'
         CLI   ERRSTAT1,C'U'
         BE    LOG015
*
         MVC   MSGID,=CL8'SAMP0101'
         B     LOGIN
*
*
LOG015   DS    0H
         MVC   MSGID,=CL8'SAMP0102'
         B     LOGIN
*
*
LOG020   DS    0H
         MVC   PASSWD,=CL8' '
*
         MVI   ERRSTAT,C'P'
         CLI   ERRSTAT1,C'P'
         BE    LOG025
*
         MVC   MSGID,=CL8'SAMP0103'
         MVC   CSRFLD,=CL8'PASSWD'
         B     LOGIN
*
*
LOG025   DS    0H
         MVC   MSGID,=CL8'SAMP0104'
         MVC   CSRFLD,=CL8'PASSWD'
         B     LOGIN
*
*
*
*/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z
*
*
GOOD010  DS    0H
*
GOOD020  DS    0H
         $DISPLAY ('SAMP01B',MSGID,CSRFLD)
*
         L     R1,HITS
         LA    R1,1(,R1)
         ST    R1,HITS
*
         MVC   MSGID,=CL8' '
         MVC   CSRFLD,=CL8' '
*
         OC    ZCMD,=CL50' '
         CLC   =C'END ',ZCMD
         BE    GOOD900
*
         MVC   MSGID,=CL8'SAMP0105'
         B     GOOD020
*
*
GOOD900  DS    0H
         TPUT  HELLOMSG,HELLOLEN
*
*
          L     R13,4(,R13)
          LM    R14,R12,12(R13)
          SLR   R15,R15
          BR    R14
*
*
*
*
*
*
*
PDSMBR   DC    CL8'TEST01'
CSRFLD   DC    CL8' '
*
*
MSGID    DC    CL8' '
*
*
*
*
HITS     DC    F'0'
*
PF03     DC    CL8'END'
PF15     DC    CL8'END'
ZSTAT    DC    CL2'OK'
USERID   DC    CL8' '
PASSWD   DC    CL8' '
ZCMD     DC    CL50' '
*
*
ERRSTAT  DC    C' '
ERRSTAT1 DC    C' '
*
*
         DS    0H
HELLOMSG DC    C'THE USERID=<'
HELLOUSR DC    CL8' ',C'> PASSWORD=<'
HELLOPWD DC    CL8' ',C'>'
HELLOLEN EQU   *-HELLOMSG
*
*
          LTORG ,
*
*
SAVEA     DC    18F'0'
*
*
*
*
R0        EQU   0
R1        EQU   1
R2        EQU   2
R3        EQU   3
R4        EQU   4
R5        EQU   5
R6        EQU   6
R7        EQU   7
R8        EQU   8
R9        EQU   9
R10       EQU   10
R11       EQU   11
R12       EQU   12
R13       EQU   13
R14       EQU   14
R15       EQU   15
*
*
          END   ,
./ ADD NAME=SAMP02
SAMP02   CSECT ,
         SAVE  (14,12),,*
*
         LR    R12,R15
         USING SAMP02,R12
*
         LA    R11,SAVEA
         ST    R13,4(,R11)
         ST    R11,8(,R13)
         LR    R13,R11
*
*
         L     R1,16              CVT
         L     R1,0(,R1)          OLD/NEW
         L     R1,4(,R1)          TCB
         L     R1,12(,R1)         TIOT
         MVC   JOB,0(R1)
         MVC   PROC,16(R1)
*
         $VDEF ('ZUSER',JOB,1,8,0)
*
         $VDEF ('ZPROC',PROC,2,8,0)
*
         $VDEF ('PF03',PFK03,2,8,0)
*
         $VDEF ('PF15',PFK15,2,8,0)
*
         $VDEF ('PF01',PFK01,2,8,0)
*
         $VDEF ('PF13',PFK13,2,8,0)
*
         $VDEF ('PF04',PFK04,2,8,0)
*
         $VDEF ('PF16',PFK16,2,8,0)
*
         $VDEF ('ZCMD',ZCMD,2,50,0)
*
*
*/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z
*
*
LOOP     DS    0H
*
         $DISPLAY ('SAMP02A',MSGID)
*
         MVC   MSGID,=CL8' '
*
         OC    ZCMD,=CL50' '
         CLC   =C'END ',ZCMD
         BE    EXIT
*
*
         CLC   =C'X ',ZCMD
         BE    EXIT
*
         CLC   ZCMD(2),=C'0 '
         BL    BADCMD
*
         CLC   ZCMD(2),=C'9 '
         BH    BADCMD
*
*
         MVI   ZCMD,C' '
         MVC   ZCMD+1(L'ZCMD-1),ZCMD
         MVC   MSGID,=CL8'SAMP0201'
         B     LOOP
*
*
BADCMD   DS    0H
         MVC   MSGID,=CL8'SAMP0202'
         B     LOOP
*
*
*/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z
*
*
EXIT     DS    0H
*
         L     R13,4(,R13)
         LM    R14,R12,12(R13)
         SLR   R15,R15
         BR    R14
*
*
ZCMD     DC    CL50' '
*
*
         LTORG ,
*
*
MSGID    DC    CL8' '
JOB      DC    CL8' '
PROC     DC    CL8' '
PFK01    DC    CL8'HELP    '
PFK13    DC    CL8'HELP    '
PFK03    DC    CL8'END     '
PFK15    DC    CL8'END     '
PFK04    DC    CL8'RETN    '
PFK16    DC    CL8'RETN    '
*
*
SAVEA    DC    18F'0'
*
*
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
*
*
         END   ,
./ ADD NAME=SAMP03
SAMP03   CSECT ,
         SAVE  (14,12),,*
*
         LR    R12,R15
         USING SAMP03,R12
*
         LA    R11,SAVEA
         ST    R13,4(,R11)
         ST    R11,8(,R13)
         LR    R13,R11
*
*
         $VDEF ('PF03',PFK03,2,8,0)
*
         $VDEF ('PF15',PFK15,2,8,0)
*
         $VDEF ('PF01',PFK01,2,8,0)
*
         $VDEF ('PF13',PFK13,2,8,0)
*
         $VDEF ('PF04',PFK04,2,8,0)
*
         $VDEF ('PF16',PFK16,2,8,0)
*
         $VDEF ('ZCMD',ZCMD,2,50,0)
*
         $VDEF ('NUMBER',NUMBER,1,4,0)
*
*
*/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z
*
*
LOOP     DS    0H
*
         $DISPLAY ('SAMP03A',MSGID)
*
         MVC   MSGID,=CL8' '
*
         OC    ZCMD,=CL50' '
         CLC   =C'END ',ZCMD
         BE    EXIT
*
*
         CLC   =C'X ',ZCMD
         BE    EXIT
*
         B     LOOP
*
*
*/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z
*
*
EXIT     DS    0H
*
         L     R13,4(,R13)
         LM    R14,R12,12(R13)
         SLR   R15,R15
         BR    R14
*
*
ZCMD     DC    CL50' '
*
*
         LTORG ,
*
*
MSGID    DC    CL8' '
PFK01    DC    CL8'HELP    '
PFK13    DC    CL8'HELP    '
PFK03    DC    CL8'END     '
PFK15    DC    CL8'END     '
PFK04    DC    CL8'RETN    '
PFK16    DC    CL8'RETN    '
NUMBER   DC    F'0'
*
*
SAVEA    DC    18F'0'
*
*
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
*
*
         END   ,
./ ADD NAME=SAMPC01
       IDENTIFICATION DIVISION.
       PROGRAM-ID. 'SAMPC01'.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-360.
       OBJECT-COMPUTER. IBM-360.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77  STOP-FLAG  PIC 9 VALUE 0.
       77  LOGIN-FLAG PIC 9 VALUE 0.
       77  ERRSTAT    PIC X VALUE SPACES.
       77  ERRSTAT1   PIC X VALUE SPACES.
       01  DISPLAY-PARMS.
           10 SCREEN-NAME  PIC X(8) VALUE 'SAMP01A'.
           10 MESSAGE-ID   PIC X(8) VALUE SPACES.
           10 CURSOR-FIELD PIC X(8) VALUE SPACES.
       01  SCREEN-VARS.
           10 PF01 PIC X(8) VALUE 'HELP'.
           10 PF13 PIC X(8) VALUE 'HELP'.
           10 PF03 PIC X(8) VALUE 'END'.
           10 PF15 PIC X(8) VALUE 'END'.
           10 PF04 PIC X(8) VALUE 'RETN'.
           10 PF16 PIC X(8) VALUE 'RETN'.
           10 ZSTAT PIC X(2) VALUE SPACES.
           10 USERID PIC X(8) VALUE SPACES.
           10 PASSWD PIC X(8) VALUE SPACES.
           10 ZCMD   PIC X(50) VALUE SPACES.
           10 HITS  PIC S9(5) COMP VALUE +0.
           10 LPF01 PIC X(8) VALUE 'PF01'.
           10 LPF13 PIC X(8) VALUE 'PF13'.
           10 LPF03 PIC X(8) VALUE 'PF03'.
           10 LPF15 PIC X(8) VALUE 'PF15'.
           10 LPF04 PIC X(8) VALUE 'PF04'.
           10 LPF16 PIC X(8) VALUE 'PF16'.
           10 LZSTAT  PIC X(8) VALUE 'ZSTAT'.
           10 LUSERID PIC X(8) VALUE 'USERID'.
           10 LPASSWD PIC X(8) VALUE 'PASSWD'.
           10 LZCMD   PIC X(8) VALUE 'ZCMD'.
           10 LHITS   PIC X(8) VALUE 'HITS'.
           10 VDEF-LEN  PIC S9(5) COMP VALUE +1.
           10 VDEF-TYPE PIC S9(5) COMP VALUE +2.
           10 VDEF-TYPE-NUM  PIC S9(5) COMP VALUE +1.
           10 VDEF-TYPE-CHAR PIC S9(5) COMP VALUE +2.
           10 VDEF-OPT  PIC S9(5) COMP VALUE +0.
       PROCEDURE DIVISION.
       000-START-RUN.
           PERFORM 000-DEFINE-VARS.
           PERFORM 000-LOGIN-LOOP THRU 000-LOGIN-LOOP-EXIT
                   UNTIL STOP-FLAG = 1 OR
                         LOGIN-FLAG = 1.
           IF STOP-FLAG = 1
              GO TO 999-END-RUN.
           MOVE 'SAMP01B' TO SCREEN-NAME.
           PERFORM 000-PROCESS-LOOP THRU 000-PROCESS-LOOP-EXIT
                   UNTIL STOP-FLAG = 1.
           GO TO 999-END-RUN.
       000-LOGIN-LOOP.
           MOVE ERRSTAT TO ERRSTAT1.
           MOVE SPACES  TO ERRSTAT.
           PERFORM 000-DISPLAY THRU 000-DISPLAY-EXIT.
           MOVE 'SAMP0105' TO MESSAGE-ID.
           IF USERID = SPACES
              PERFORM 000-VALIDATE-USERID THRU
                      000-VALIDATE-USERID-EXIT
              GO TO 000-LOGIN-LOOP-EXIT.
           IF PASSWD NOT = 'SECRET'
              PERFORM 000-VALIDATE-PASSWD THRU
                      000-VALIDATE-PASSWD-EXIT
              GO TO 000-LOGIN-LOOP-EXIT.
           MOVE 1 TO LOGIN-FLAG.
       000-LOGIN-LOOP-EXIT.
       000-PROCESS-LOOP.
           MOVE SPACES  TO ERRSTAT.
           PERFORM 000-DISPLAY THRU 000-DISPLAY-EXIT.
           MOVE 'SAMP0105' TO MESSAGE-ID.
       000-PROCESS-LOOP-EXIT.
       000-VALIDATE-USERID.
           MOVE 'USERID' TO CURSOR-FIELD.
           MOVE 'U' TO ERRSTAT.
           IF ERRSTAT1 = 'U'
              MOVE 'SAMP0102' TO MESSAGE-ID
           ELSE
              MOVE 'SAMP0101' TO MESSAGE-ID.
       000-VALIDATE-USERID-EXIT.
       000-VALIDATE-PASSWD.
           MOVE 'PASSWD' TO CURSOR-FIELD.
           MOVE SPACES TO PASSWD.
           MOVE 'P' TO ERRSTAT.
           IF ERRSTAT1 = 'P'
              MOVE 'SAMP0104' TO MESSAGE-ID
           ELSE
              MOVE 'SAMP0103' TO MESSAGE-ID.
       000-VALIDATE-PASSWD-EXIT.
       000-DISPLAY.
           MOVE SPACES TO ZCMD.
           CALL 'DISPLAY' USING SCREEN-NAME,
                                MESSAGE-ID,
                                CURSOR-FIELD.
           ADD +1 TO HITS.
           MOVE SPACES  TO MESSAGE-ID.
           MOVE SPACES  TO CURSOR-FIELD.
           IF ZCMD = 'END' MOVE 1 TO STOP-FLAG.
       000-DISPLAY-EXIT.
       000-DEFINE-VARS.
           MOVE 8 TO VDEF-LEN.
           CALL 'VDEFINE' USING LPF01, PF01,
                                 VDEF-TYPE, VDEF-LEN, VDEF-OPT.
           CALL 'VDEFINE' USING LPF03, PF03,
                                 VDEF-TYPE, VDEF-LEN, VDEF-OPT.
           CALL 'VDEFINE' USING LPF04, PF04,
                                 VDEF-TYPE, VDEF-LEN, VDEF-OPT.
           CALL 'VDEFINE' USING LPF13, PF13,
                                 VDEF-TYPE, VDEF-LEN, VDEF-OPT.
           CALL 'VDEFINE' USING LPF15, PF15,
                                 VDEF-TYPE, VDEF-LEN, VDEF-OPT.
           CALL 'VDEFINE' USING LPF16, PF16,
                                 VDEF-TYPE, VDEF-LEN, VDEF-OPT.
           CALL 'VDEFINE' USING LUSERID, USERID,
                                 VDEF-TYPE, VDEF-LEN, VDEF-OPT.
           CALL 'VDEFINE' USING LPASSWD, PASSWD,
                                 VDEF-TYPE, VDEF-LEN, VDEF-OPT.
           MOVE 2 TO VDEF-LEN.
           CALL 'VDEFINE' USING LZSTAT, ZSTAT,
                                 VDEF-TYPE, VDEF-LEN, VDEF-OPT.
           MOVE 50 TO VDEF-LEN.
           CALL 'VDEFINE' USING LZCMD, ZCMD,
                                 VDEF-TYPE, VDEF-LEN, VDEF-OPT.
           MOVE 4 TO VDEF-LEN.
           CALL 'VDEFINE' USING LHITS, HITS,
                                 VDEF-TYPE-NUM, VDEF-LEN, VDEF-OPT.
       999-END-RUN.
           STOP RUN.
@@
//* -----------------------------------
//ALLOC EXEC PGM=IEFBR14
//OBJ    DD DSN=SYSGEN.FSI.OBJ,
//          DISP=(NEW,CATLG,DELETE),
//          UNIT=SYSALLDA,VOL=SER=PUB001,
//          SPACE=(CYL,(1,0,36))
//LOAD   DD DSN=SYSGEN.FSI.LOAD,
//          DISP=(NEW,CATLG,DELETE),
//          UNIT=SYSALLDA,VOL=SER=PUB001,
//          SPACE=(CYL,(1,0,36))
//* -----------------------------------
//TCSASM PROC M=
//COMPILE EXEC  PGM=IFOX00,REGION=1024K,
//         PARM='LINECOUNT(45)'
//SYSLIB   DD    DISP=SHR,DSN=SYS1.MACLIB
//         DD    DISP=SHR,DSN=SYS1.AMODGEN
//         DD    DISP=SHR,DSN=SYSGEN.FSI.ASM
//SYSUT1   DD    DSN=&&SYSUT1,UNIT=VIO,SPACE=(1700,(600,100))
//SYSUT2   DD    DSN=&&SYSUT2,UNIT=VIO,SPACE=(1700,(300,50))
//SYSUT3   DD    DSN=&&SYSUT3,UNIT=VIO,SPACE=(1700,(300,50))
//SYSPRINT DD    SYSOUT=*
//SYSIN    DD    DISP=SHR,DSN=SYSGEN.FSI.ASM(&M)
//SYSPUNCH DD    DISP=SHR,DSN=SYSGEN.FSI.OBJ(&M)
//   PEND
//FSISTART EXEC TCSASM,M=FSISTART
//FSISTUB  EXEC TCSASM,M=FSISTUB
//FSIDSPLY EXEC TCSASM,M=FSIDSPLY
//FSIERMSG EXEC TCSASM,M=FSIERMSG
//FSIPANL  EXEC TCSASM,M=FSIPANL
//FSISCRN  EXEC TCSASM,M=FSISCRN
//FSIVPUT  EXEC TCSASM,M=FSIVPUT
//FSIVGET  EXEC TCSASM,M=FSIVGET
//FSIPDS   EXEC TCSASM,M=FSIPDS
//FSIFUNC  EXEC TCSASM,M=FSIFUNC
//FSIDFLT  EXEC TCSASM,M=FSIDFLT
//VARPOOL  EXEC TCSASM,M=VARPOOL
//FSIVDEF  EXEC TCSASM,M=FSIVDEF
//FSIVLOC  EXEC TCSASM,M=FSIVLOC
//FSIVSTO  EXEC TCSASM,M=FSIVSTO
//VARDEFS  EXEC TCSASM,M=VARDEFS
//FSIVDEF  EXEC TCSASM,M=FSIVDEF
//FSIVSTO  EXEC TCSASM,M=FSIVSTO
//FSIVLOC  EXEC TCSASM,M=FSIVLOC
//* -----------------------------------
//COPY     EXEC PGM=IEBGENER
//SYSPRINT   DD SYSOUT=*
//SYSIN      DD DUMMY
//SYSUT1     DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSISTART)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSISCRN)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSIPANL)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSIERMSG)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSIDSPLY)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSIVGET)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSIVPUT)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSIPDS)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSIVDEF)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSIVLOC)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSIVSTO)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(VARPOOL)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(VARDEFS)
//SYSUT2     DD DSN=&&FSISTART,
//           DISP=(NEW,PASS,DELETE),
//           DCB=(BLKSIZE=80,LRECL=80,RECFM=F),
//           UNIT=SYSALLDA,VOL=SER=PUB001,
//           SPACE=(CYL,(1,1))
//* -----------------------------------
//FSISTART EXEC PGM=IEWL,PARM='XREF,LIST,LET,NCAL',REGION=1024K
//SYSPRINT DD  SYSOUT=A
//SYSLIN   DD  DSN=&&FSISTART,DISP=(OLD,DELETE,DELETE)
//SYSLMOD  DD  DISP=SHR,DSN=SYSGEN.FSI.LOAD(FSISTART)
//SYSUT1   DD  UNIT=SYSALLDA,VOL=SER=PUB001,
//           SPACE=(1024,(200,20))
//* -----------------------------------
//COPY     EXEC PGM=IEBGENER
//SYSPRINT   DD SYSOUT=*
//SYSIN      DD DUMMY
//SYSUT1     DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSIFUNC)
//SYSUT2     DD DSN=&&FSIFUNC,
//           DISP=(NEW,PASS,DELETE),
//           DCB=(BLKSIZE=80,LRECL=80,RECFM=F),
//           UNIT=SYSALLDA,VOL=SER=PUB001,
//           SPACE=(CYL,(1,1))
//FSIFUNC  EXEC PGM=IEWL,PARM='XREF,LIST,LET,NCAL',REGION=1024K
//SYSPRINT DD  SYSOUT=A
//SYSLIN   DD  DSN=&&FSIFUNC,DISP=(OLD,DELETE,DELETE)
//SYSLMOD  DD  DISP=SHR,DSN=SYSGEN.FSI.LOAD(FSIFUNC)
//SYSUT1   DD  UNIT=SYSALLDA,VOL=SER=PUB001,
//           SPACE=(1024,(200,20))
//* -----------------------------------
//COPY     EXEC PGM=IEBGENER
//SYSPRINT   DD SYSOUT=*
//SYSIN      DD DUMMY
//SYSUT1     DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSIDFLT)
//           DD DISP=SHR,DSN=SYSGEN.FSI.OBJ(FSISTUB)
//SYSUT2     DD DSN=&&FSIFUNC,
//           DISP=(NEW,PASS,DELETE),
//           DCB=(BLKSIZE=80,LRECL=80,RECFM=F),
//           UNIT=SYSALLDA,VOL=SER=PUB001,
//           SPACE=(CYL,(1,1))
//* -----------------------------------
//FSIDFLT  EXEC PGM=IEWL,PARM='XREF,LIST,LET,NCAL',REGION=1024K
//SYSPRINT DD  SYSOUT=A
//SYSLIN   DD  DSN=&&FSIFUNC,DISP=(OLD,DELETE,DELETE)
//SYSLMOD  DD  DISP=SHR,DSN=SYSGEN.FSI.LOAD(FSIDFLT)
//SYSUT1   DD  UNIT=SYSALLDA,VOL=SER=PUB001,
//           SPACE=(1024,(200,20))
//* -----------------------------------
//
