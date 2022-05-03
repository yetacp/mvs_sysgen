//FSS   JOB (JOB),
//           'INSTALL FSS',
//           CLASS=A,
//           MSGCLASS=A,
//           MSGLEVEL=(1,1),
//           USER=IBMUSER,
//           PASSWORD=SYS1
//CLEANUP EXEC PGM=IDCAMS
//SYSIN    DD *
  DELETE SYSGEN.FSS.ASM
  DELETE SYSGEN.FSS.INCLUDE
  DELETE SYSGEN.FSS.OBJ
  DELETE SYSGEN.FSS.LOAD
  DELETE SYSGEN.FSS.SAMP
  SET MAXCC=0
//SYSPRINT DD  SYSOUT=*
//* -----------------------------------
//SASM    EXEC PGM=PDSLOAD
//STEPLIB  DD  DSN=SYSC.LINKLIB,DISP=SHR
//SYSPRINT DD  SYSOUT=*
//SYSUT2   DD  DSN=SYSGEN.FSS.ASM,
//             UNIT=SYSALLDA,VOL=SER=PUB001,
//             SPACE=(CYL,(15,2,20),RLSE),
//             DISP=(NEW,CATLG,DELETE)
//SYSUT1   DD  DATA,DLM='#@'
./ ADD NAME=ALLOC
         COPY  PDPTOP
         CSECT
         DS    0F
@@0      EQU   *
         DC    80X'00'
* Program text area
@@LC3    EQU   *
         DC    C'        '
         DC    X'0'
@@LC4    EQU   *
         DC    C'RC=%d ERR=%4.4X INFO=%4.4X'
         DC    X'0'
@@LC2    EQU   *
         DC    C'DEVICE Type too long'
         DC    X'0'
@@LC1    EQU   *
         DC    C'VOLSER too long'
         DC    X'0'
@@LC0    EQU   *
         DC    C'DSNAME too long'
         DC    X'0'
         DS    0F
* X-FUNC dynAlloc PROLOGUE
DYNALLOC PDPPRLG CINDEX=0,FRAME=312,BASER=12,ENTRY=YES
         B     @@FEN0
         LTORG
@@FEN0   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG0    EQU   *
         LR    11,1
         L     10,=A(@@PGT0)
* FUNCTION dynAlloc CODE
         L     7,0(11)
         L     8,8(11)
         L     9,12(11)
         LTR   7,7
         BE    @@L2
         ST    7,88(13)
         LA    1,88(,13)
         L     15,=V(STRLEN)
         BALR  14,15
         LR    6,15
         LA    3,44(0,0)
         CR    15,3
         BH    @@L17
@@L2     EQU   *
         LTR   8,8
         BE    @@L4
         ST    8,88(13)
         LA    1,88(,13)
         L     15,=V(STRLEN)
         BALR  14,15
         ST    15,304(13)
         LA    2,6(0,0)
         CR    15,2
         BH    @@L18
@@L4     EQU   *
         LTR   9,9
         BE    @@L6
         ST    9,88(13)
         LA    1,88(,13)
         L     15,=V(STRLEN)
         BALR  14,15
         ST    15,308(13)
         LA    2,8(0,0)
         CR    15,2
         BH    @@L19
@@L6     EQU   *
         LA    2,166(,13)
         ST    2,88(13)
         MVC   92(4,13),=F'64'
         MVC   96(4,13),=F'44'
         LA    1,88(,13)
         L     15,=V(MEMSET)
         BALR  14,15
         LTR   7,7
         BE    @@L8
         LR    4,2
         LR    5,6
         LR    2,7
         LR    3,6
         MVCL  4,2
@@L8     EQU   *
         LA    4,112(,13)
         ST    4,280(13)
         MVI   280(13),128
         MVI   112(13),20
         MVI   113(13),1
         MVC   114(2,13),=H'24576'
         MVC   116(2,13),=H'0'
         MVC   118(2,13),=H'0'
         LA    3,136(,13)
         ST    3,120(13)
         MVC   124(4,13),=F'0'
         MVC   128(4,13),=F'0'
         LTR   7,7
         BE    @@L9
         LA    5,160(,13)
         ST    5,136(13)
@@L10    EQU   *
         LA    5,288(,13)
         ST    5,140(13)
         LA    15,296(,13)
         ST    15,144(13)
         LA    7,216(,13)
         ST    7,148(13)
         LA    3,232(,13)
         ST    3,152(13)
         LA    6,248(,13)
         ST    6,156(13)
         MVI   156(13),128
         MVC   160(2,13),=H'2'
         MVC   162(2,13),=H'1'
         MVC   164(2,13),=H'44'
         MVC   288(2,13),=H'4'
         LA    2,2(0,0)
         LA    6,1(0,0)
         STH   6,0(2,5)
         LA    4,4(0,0)
         STH   6,0(4,5)
         LA    6,6(0,0)
         LA    7,8(0,0)
         STC   7,0(6,5)
         MVC   296(2,13),=H'5'
         LA    3,1(0,0)
         STH   3,0(2,15)
         STH   3,0(4,15)
         STC   7,0(6,15)
         MVC   216(2,13),=H'85'
         MVC   218(2,13),=H'1'
         MVC   220(2,13),=H'8'
         L     7,=A(@@LC3)
         MVC   222(8,13),0(7)
         LTR   8,8
         BE    @@L11
         LTR   9,9
         BE    @@L11
         ST    8,88(13)
         LA    1,88(,13)
         L     15,=V(STRLEN)
         BALR  14,15
         LTR   15,15
         BNE   @@L20
@@L11    EQU   *
         MVI   148(13),128
@@L12    EQU   *
         LA    15,280(,13)
         ST    15,268(13)
         MVC   88(4,13),=F'99'
         LA    9,264(,13)
         ST    9,92(13)
         LA    1,88(,13)
         L     15,=V(EXSVC)
         BALR  14,15
         L     15,272(13)
         LTR   15,15
         BNE   @@L21
         L     4,4(11)
         MVC   0(8,4),222(13)
         STC   15,8(4)
         B     @@L1
@@L21    EQU   *
         MVC   88(4,13),=A(@@0)
         MVC   92(4,13),=A(@@LC4)
         ST    15,96(13)
         LH    2,116(13)
         N     2,=XL4'0000FFFF'
         ST    2,100(13)
         LH    2,118(13)
         N     2,=XL4'0000FFFF'
         ST    2,104(13)
         LA    1,88(,13)
         L     15,=V(SPRINTF)
         BALR  14,15
@@L15    EQU   *
         L     15,=A(@@0)
         B     @@L1
@@L20    EQU   *
         ST    9,88(13)
         LA    1,88(,13)
         L     15,=V(STRLEN)
         BALR  14,15
         LTR   15,15
         BE    @@L11
         MVC   232(2,13),=H'16'
         MVC   234(2,13),=H'1'
         MVC   236(2,13),=H'6'
         LA    5,238(,13)
         ST    5,88(13)
         MVC   92(4,13),=F'64'
         ST    6,96(13)
         LA    1,88(,13)
         L     15,=V(MEMSET)
         BALR  14,15
         LR    4,5
         L     5,304(13)
         LR    2,8
         LR    3,5
         MVCL  4,2
         MVC   248(2,13),=H'21'
         MVC   250(2,13),=H'1'
         MVC   252(2,13),=H'8'
         LA    8,254(,13)
         ST    8,88(13)
         MVC   92(4,13),=F'64'
         MVC   96(4,13),=F'8'
         LA    1,88(,13)
         L     15,=V(MEMSET)
         BALR  14,15
         LR    4,8
         L     5,308(13)
         LR    2,9
         LR    3,5
         MVCL  4,2
         B     @@L12
@@L9     EQU   *
         ST    7,136(13)
         B     @@L10
@@L19    EQU   *
         MVC   88(4,13),=A(@@0)
         MVC   92(4,13),=A(@@LC2)
         LA    1,88(,13)
         L     15,=V(STRCPY)
         BALR  14,15
         B     @@L15
@@L18    EQU   *
         MVC   88(4,13),=A(@@0)
         MVC   92(4,13),=A(@@LC1)
@@L16    EQU   *
         LA    1,88(,13)
         L     15,=V(STRCPY)
         BALR  14,15
         B     @@L15
@@L17    EQU   *
         MVC   88(4,13),=A(@@0)
         MVC   92(4,13),=A(@@LC0)
         B     @@L16
@@L1     EQU   *
* FUNCTION dynAlloc EPILOGUE
         PDPEPIL
* FUNCTION dynAlloc LITERAL POOL
         DS    0F
         LTORG
* FUNCTION dynAlloc PAGE TABLE
         DS    0F
@@PGT0   EQU   *
         DC    A(@@PG0)
         DS    0F
@@1      EQU   *
         DC    80X'00'
@@LC5    EQU   *
         DC    C'DDNAME too long'
         DC    X'0'
         DS    0F
* X-FUNC dynFree PROLOGUE
DYNFREE  PDPPRLG CINDEX=1,FRAME=176,BASER=12,ENTRY=YES
         B     @@FEN1
         LTORG
@@FEN1   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG1    EQU   *
         LR    11,1
         L     10,=A(@@PGT1)
* FUNCTION dynFree CODE
         L     7,0(11)
         ST    7,88(13)
         LA    1,88(,13)
         L     15,=V(STRLEN)
         BALR  14,15
         LR    6,15
         LA    2,8(0,0)
         CR    15,2
         BNH   @@L23
         MVC   88(4,13),=A(@@1)
         MVC   92(4,13),=A(@@LC5)
         LA    1,88(,13)
         L     15,=V(STRCPY)
         BALR  14,15
@@L25    EQU   *
         L     15,=A(@@1)
         B     @@L22
@@L23    EQU   *
         LA    3,142(,13)
         ST    3,88(13)
         MVC   92(4,13),=F'64'
         MVC   96(4,13),=F'44'
         LA    1,88(,13)
         L     15,=V(MEMSET)
         BALR  14,15
         LR    4,3
         LR    5,6
         LR    2,7
         LR    3,6
         MVCL  4,2
         LA    6,112(,13)
         ST    6,168(13)
         MVI   168(13),128
         MVI   112(13),20
         MVI   113(13),2
         MVC   114(2,13),=H'24576'
         MVC   116(2,13),=H'0'
         MVC   118(2,13),=H'0'
         LA    4,172(,13)
         ST    4,120(13)
         MVC   124(4,13),=F'0'
         MVC   128(4,13),=F'0'
         LA    5,136(,13)
         ST    5,172(13)
         MVI   0(4),128
         MVC   136(2,13),=H'1'
         MVC   138(2,13),=H'1'
         MVC   140(2,13),=H'8'
         LA    3,168(,13)
         ST    3,156(13)
         MVC   88(4,13),=F'99'
         LA    3,152(,13)
         ST    3,92(13)
         LA    1,88(,13)
         L     15,=V(EXSVC)
         BALR  14,15
         L     15,160(13)
         LTR   15,15
         BE    @@L22
         MVC   88(4,13),=A(@@1)
         MVC   92(4,13),=A(@@LC4)
         ST    15,96(13)
         LH    2,116(13)
         N     2,=XL4'0000FFFF'
         ST    2,100(13)
         LH    2,118(13)
         N     2,=XL4'0000FFFF'
         ST    2,104(13)
         LA    1,88(,13)
         L     15,=V(SPRINTF)
         BALR  14,15
         B     @@L25
@@L22    EQU   *
* FUNCTION dynFree EPILOGUE
         PDPEPIL
* FUNCTION dynFree LITERAL POOL
         DS    0F
         LTORG
* FUNCTION dynFree PAGE TABLE
         DS    0F
@@PGT1   EQU   *
         DC    A(@@PG1)
         END
./ ADD NAME=CHAINR
         COPY  PDPTOP
         CSECT
* Program text area
@@LC2    EQU   *
         DC    C'CHAINR - Allocation Size Too Small'
         DC    X'15'
         DC    X'0'
@@LC3    EQU   *
         DC    C'CHNR'
         DC    X'0'
@@LC1    EQU   *
         DC    C'CHAINR - Invalid Key Length'
         DC    X'15'
         DC    X'0'
@@LC0    EQU   *
         DC    C'CHAINR - Invalid Key Type'
         DC    X'15'
         DC    X'0'
         DS    0F
* X-FUNC chainNewFunc PROLOGUE
CHAINNEW PDPPRLG CINDEX=0,FRAME=96,BASER=12,ENTRY=YES
         B     @@FEN0
         LTORG
@@FEN0   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG0    EQU   *
         LR    11,1
         L     10,=A(@@PGT0)
* FUNCTION chainNewFunc CODE
         SLR   4,4
         SLR   5,5
         L     8,0(11)
         L     7,4(11)
         L     9,8(11)
         L     6,12(11)
         MVC   88(4,13),=F'44'
         LA    1,88(,13)
         L     15,=V(MALLOC)
         BALR  14,15
         LR    3,15
         LA    4,2(0,0)
         CLR   7,4
         BH    @@L7
         LR    15,8
         BCTR  15,0
         LA    4,254(0,0)
         CLR   15,4
         BH    @@L8
         LA    4,511(0,0)
         CR    6,4
         BH    @@L4
         LA    6,512(0,0)
@@L4     EQU   *
         LR    4,6
         SRDA  4,32
         LA    2,5(0,0)
         DR    4,2
         CR    9,5
         BNH   @@L5
         LA    1,88(,13)
         L     15,=V(@@GTERR)
         BALR  14,15
         MVC   88(4,13),0(15)
         MVC   92(4,13),=A(@@LC2)
@@L6     EQU   *
         LA    1,88(,13)
         L     15,=V(FPRINTF)
         BALR  14,15
         SLR   15,15
         B     @@L1
@@L5     EQU   *
         L     15,=A(@@LC3)
         MVC   0(4,3),0(15)
         ST    7,4(3)
         ST    8,8(3)
         ST    9,12(3)
         ST    6,16(3)
         MVC   20(4,3),=F'0'
         MVC   36(4,3),=F'0'
         MVC   40(4,3),=F'0'
         ST    6,88(13)
         LA    1,88(,13)
         L     15,=V(MALLOC)
         BALR  14,15
         ST    15,24(3)
         ST    15,28(3)
         MVC   32(4,3),=F'0'
         MVC   0(4,15),=F'0'
         LR    5,15
         A     5,=F'12'
         ST    5,4(15)
         A     6,=F'-12'
         ST    6,8(15)
         LR    15,3
         B     @@L1
@@L8     EQU   *
         LA    1,88(,13)
         L     15,=V(@@GTERR)
         BALR  14,15
         MVC   88(4,13),0(15)
         MVC   92(4,13),=A(@@LC1)
         B     @@L6
@@L7     EQU   *
         LA    1,88(,13)
         L     15,=V(@@GTERR)
         BALR  14,15
         MVC   88(4,13),0(15)
         MVC   92(4,13),=A(@@LC0)
         B     @@L6
@@L1     EQU   *
* FUNCTION chainNewFunc EPILOGUE
         PDPEPIL
* FUNCTION chainNewFunc LITERAL POOL
         DS    0F
         LTORG
* FUNCTION chainNewFunc PAGE TABLE
         DS    0F
@@PGT0   EQU   *
         DC    A(@@PG0)
@@LC4    EQU   *
         DC    C'Invalid Chain Control Block - chainFree()'
         DC    X'15'
         DC    X'0'
         DS    0F
* X-FUNC chainReset PROLOGUE
CHAINRES PDPPRLG CINDEX=1,FRAME=96,BASER=12,ENTRY=YES
         B     @@FEN1
         LTORG
@@FEN1   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG1    EQU   *
         LR    11,1
         L     10,=A(@@PGT1)
* FUNCTION chainReset CODE
         L     4,0(11)
         L     3,=A(@@LC3)
         CLC   0(4,4),0(3)
         LA    5,1(0,0)
         BH    *+12
         BL    *+6
         SLR   5,5
         LNR   5,5
         LTR   5,5
         BNE   @@L17
         L     15,24(4)
         ST    15,28(4)
         LR    3,15
         A     3,=F'12'
         ST    3,4(15)
         L     3,16(4)
         A     3,=F'-12'
         ST    3,8(15)
         L     3,0(15)
         ST    5,0(15)
         LR    15,3
         LTR   3,3
         BE    @@L16
@@L14    EQU   *
         L     3,0(3)
         LR    5,15
         A     5,=F'12'
         ST    5,4(15)
         L     5,16(4)
         A     5,=F'-12'
         ST    5,8(15)
         MVC   0(4,15),32(4)
         ST    15,32(4)
         LR    15,3
         LTR   3,3
         BNE   @@L14
         B     @@L16
@@L17    EQU   *
         LA    1,88(,13)
         L     15,=V(@@GTERR)
         BALR  14,15
         MVC   88(4,13),0(15)
         MVC   92(4,13),=A(@@LC4)
         LA    1,88(,13)
         L     15,=V(FPRINTF)
         BALR  14,15
         LA    1,88(,13)
         L     15,=V(ABORT)
         BALR  14,15
@@L16    EQU   *
         MVC   36(4,4),=F'0'
         MVC   40(4,4),=F'0'
         MVC   20(4,4),=F'0'
         SLR   15,15
* FUNCTION chainReset EPILOGUE
         PDPEPIL
* FUNCTION chainReset LITERAL POOL
         DS    0F
         LTORG
* FUNCTION chainReset PAGE TABLE
         DS    0F
@@PGT1   EQU   *
         DC    A(@@PG1)
         DS    0F
* X-FUNC chainFree PROLOGUE
CHAINFRE PDPPRLG CINDEX=2,FRAME=96,BASER=12,ENTRY=YES
         B     @@FEN2
         LTORG
@@FEN2   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG2    EQU   *
         LR    11,1
         L     10,=A(@@PGT2)
* FUNCTION chainFree CODE
         L     4,0(11)
         L     15,=A(@@LC3)
         CLC   0(4,4),0(15)
         LA    3,1(0,0)
         BH    *+12
         BL    *+6
         SLR   3,3
         LNR   3,3
         LTR   3,3
         BNE   @@L32
         L     2,24(4)
         LTR   2,2
         BE    @@L29
@@L23    EQU   *
         L     3,0(2)
         MVC   0(4,2),=F'0'
         MVC   4(4,2),=F'0'
         MVC   8(4,2),=F'0'
         ST    2,88(13)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         LR    2,3
         LTR   3,3
         BNE   @@L23
@@L29    EQU   *
         L     2,32(4)
         LTR   2,2
         BE    @@L31
@@L27    EQU   *
         L     3,0(2)
         MVC   0(4,2),=F'0'
         MVC   4(4,2),=F'0'
         MVC   8(4,2),=F'0'
         ST    2,88(13)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         LR    2,3
         LTR   3,3
         BNE   @@L27
         B     @@L31
@@L32    EQU   *
         LA    1,88(,13)
         L     15,=V(@@GTERR)
         BALR  14,15
         MVC   88(4,13),0(15)
         MVC   92(4,13),=A(@@LC4)
         LA    1,88(,13)
         L     15,=V(FPRINTF)
         BALR  14,15
         LA    1,88(,13)
         L     15,=V(ABORT)
         BALR  14,15
@@L31    EQU   *
         MVC   36(4,4),=F'0'
         MVC   40(4,4),=F'0'
         MVC   24(4,4),=F'0'
         MVC   28(4,4),=F'0'
         ST    4,88(13)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         SLR   15,15
* FUNCTION chainFree EPILOGUE
         PDPEPIL
* FUNCTION chainFree LITERAL POOL
         DS    0F
         LTORG
* FUNCTION chainFree PAGE TABLE
         DS    0F
@@PGT2   EQU   *
         DC    A(@@PG2)
@@LC5    EQU   *
         DC    C'Invalid Chain Control Block - chainFind()'
         DC    X'15'
         DC    X'0'
         DS    0F
* X-FUNC chainFindFunc PROLOGUE
CHAINFIN PDPPRLG CINDEX=3,FRAME=360,BASER=12,ENTRY=YES
         B     @@FEN3
         LTORG
@@FEN3   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG3    EQU   *
         LR    11,1
         L     10,=A(@@PGT3)
* FUNCTION chainFindFunc CODE
         L     7,0(11)
         L     4,=A(@@LC3)
         CLC   0(4,7),0(4)
         LA    3,1(0,0)
         BH    *+12
         BL    *+6
         SLR   3,3
         LNR   3,3
         LTR   3,3
         BNE   @@L49
         L     2,4(7)
         LA    8,4(,11)
         LTR   2,2
         BE    @@L36
         LA    5,1(0,0)
         CLR   2,5
         BE    @@L50
         L     8,4(11)
@@L36    EQU   *
         L     15,36(7)
         LTR   15,15
         BE    @@L47
         L     7,8(7)
@@L45    EQU   *
         LR    4,8
         LR    5,7
         LR    2,15
         A     2,=F'8'
         LR    3,7
         LA    6,1(0,0)
         CLCL  4,2
         BH    *+12
         BL    *+6
         SLR   6,6
         LNR   6,6
         LTR   6,6
         BE    @@L33
         L     15,0(15)
         LTR   15,15
         BNE   @@L45
@@L47    EQU   *
         SLR   15,15
         B     @@L33
@@L50    EQU   *
         MVC   88(4,13),4(11)
         LA    1,88(,13)
         L     15,=V(STRLEN)
         BALR  14,15
         LR    6,15
         L     2,8(7)
         CR    15,2
         BL    @@L38
         LA    4,104(,13)
         LR    5,15
         L     2,4(11)
         LR    3,15
         MVCL  4,2
         LA    8,104(,13)
         B     @@L36
@@L38    EQU   *
         LA    8,104(,13)
         ST    8,88(13)
         MVC   92(4,13),=F'64'
         ST    2,96(13)
         LA    1,88(,13)
         L     15,=V(MEMSET)
         BALR  14,15
         LR    4,8
         LR    5,6
         L     2,4(11)
         LR    3,6
         MVCL  4,2
         B     @@L36
@@L49    EQU   *
         LA    1,88(,13)
         L     15,=V(@@GTERR)
         BALR  14,15
         MVC   88(4,13),0(15)
         MVC   92(4,13),=A(@@LC5)
         LA    1,88(,13)
         L     15,=V(FPRINTF)
         BALR  14,15
         LA    1,88(,13)
         L     15,=V(ABORT)
         BALR  14,15
@@L33    EQU   *
* FUNCTION chainFindFunc EPILOGUE
         PDPEPIL
* FUNCTION chainFindFunc LITERAL POOL
         DS    0F
         LTORG
* FUNCTION chainFindFunc PAGE TABLE
         DS    0F
@@PGT3   EQU   *
         DC    A(@@PG3)
@@LC8    EQU   *
         DC    C'CHAINR - Logic Error 101'
         DC    X'15'
         DC    X'0'
@@LC7    EQU   *
         DC    C'+++DUPLICATE+++'
         DC    X'15'
         DC    X'0'
@@LC6    EQU   *
         DC    C'Invalid Chain Control Block - chainAdd()'
         DC    X'15'
         DC    X'0'
         DS    0F
* X-FUNC chainAddFunc PROLOGUE
CHAINADD PDPPRLG CINDEX=4,FRAME=368,BASER=12,ENTRY=YES
         B     @@FEN4
         LTORG
@@FEN4   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG4    EQU   *
         LR    11,1
         L     10,=A(@@PGT4)
* FUNCTION chainAddFunc CODE
         L     5,=A(@@LC3)
         L     2,0(11)
         CLC   0(4,2),0(5)
         LA    4,1(0,0)
         BH    *+12
         BL    *+6
         SLR   4,4
         LNR   4,4
         LTR   4,4
         BNE   @@L77
         L     6,0(11)
         L     2,4(6)
         LA    4,4(,11)
         ST    4,360(13)
         LTR   2,2
         BE    @@L54
         LA    7,1(0,0)
         CR    2,7
         BE    @@L78
         MVC   360(4,13),4(11)
@@L54    EQU   *
         L     2,0(11)
         L     15,28(2)
         L     3,12(2)
         C     3,8(15)
         BNH   @@L59
         L     15,32(2)
         LTR   15,15
         BE    @@L60
         MVC   32(4,2),0(15)
@@L61    EQU   *
         MVC   0(4,15),=F'0'
         LR    7,15
         A     7,=F'12'
         ST    7,4(15)
         L     4,0(11)
         L     6,16(4)
         A     6,=F'-12'
         ST    6,8(15)
         L     3,28(4)
         ST    15,0(3)
         ST    15,28(4)
         L     3,12(4)
@@L59    EQU   *
         L     9,4(15)
         LR    4,9
         AR    4,3
         ST    4,4(15)
         L     8,8(15)
         SR    8,3
         ST    8,8(15)
         L     15,0(11)
         MVC   364(4,13),40(15)
         L     8,8(15)
         L     4,360(13)
         LR    5,8
         L     2,364(13)
         A     2,=F'8'
         LR    3,8
         LA    15,1(0,0)
         CLCL  4,2
         BH    *+12
         BL    *+6
         SLR   15,15
         LNR   15,15
         L     5,0(11)
         L     6,36(5)
         L     4,360(13)
         LR    5,8
         LR    2,6
         A     2,=F'8'
         LR    3,8
         LA    7,1(0,0)
         CLCL  4,2
         BH    *+12
         BL    *+6
         SLR   7,7
         LNR   7,7
         LTR   6,6
         BE    @@L79
         LTR   15,15
         BNH   @@L64
         MVC   4(4,9),364(13)
         L     6,0(11)
         L     3,40(6)
         ST    9,0(3)
         ST    9,40(6)
         MVC   0(4,9),=F'0'
@@L63    EQU   *
         L     4,0(11)
         L     6,20(4)
         A     6,=F'1'
         ST    6,20(4)
         LR    4,9
         A     4,=F'8'
         LR    5,8
         L     2,360(13)
         LR    3,8
         MVCL  4,2
         LR    15,9
         B     @@L51
@@L64    EQU   *
         LTR   7,7
         BL    @@L80
@@L74    EQU   *
         L     4,360(13)
         LR    5,8
         LR    2,6
         A     2,=F'8'
         LR    3,8
         LA    7,1(0,0)
         CLCL  4,2
         BH    *+12
         BL    *+6
         SLR   7,7
         LNR   7,7
         LTR   7,7
         BE    @@L75
         BL    @@L69
         L     6,0(6)
         LTR   6,6
         BNE   @@L74
         LA    1,88(,13)
         L     15,=V(@@GTERR)
         BALR  14,15
         MVC   88(4,13),0(15)
         MVC   92(4,13),=A(@@LC8)
@@L76    EQU   *
         LA    1,88(,13)
         L     15,=V(FPRINTF)
         BALR  14,15
         LA    1,88(,13)
         L     15,=V(ABORT)
         BALR  14,15
@@L69    EQU   *
         MVC   4(4,9),4(6)
         ST    6,0(9)
         L     15,4(6)
         ST    9,0(15)
         ST    9,4(6)
         B     @@L63
@@L75    EQU   *
         MVC   88(4,13),=A(@@LC7)
         LA    1,88(,13)
         L     15,=V(PRINTF)
         BALR  14,15
         LR    15,7
         B     @@L51
@@L80    EQU   *
         ST    6,0(9)
         L     7,0(11)
         L     5,36(7)
         ST    9,4(5)
         ST    9,36(7)
         MVC   4(4,9),=F'0'
         B     @@L63
@@L79    EQU   *
         L     2,0(11)
         ST    9,36(2)
         ST    9,40(2)
         ST    6,0(9)
         ST    6,4(9)
         B     @@L63
@@L60    EQU   *
         L     9,0(11)
         MVC   88(4,13),16(9)
         LA    1,88(,13)
         L     15,=V(MALLOC)
         BALR  14,15
         B     @@L61
@@L78    EQU   *
         MVC   88(4,13),4(11)
         LA    1,88(,13)
         L     15,=V(STRLEN)
         BALR  14,15
         LR    7,15
         L     8,0(11)
         L     2,8(8)
         CR    15,2
         BL    @@L56
         LA    4,104(,13)
         LR    5,15
         L     2,4(11)
         LR    3,15
         MVCL  4,2
         LA    6,104(,13)
@@L57    EQU   *
         ST    6,360(13)
         B     @@L54
@@L56    EQU   *
         LA    6,104(,13)
         ST    6,88(13)
         MVC   92(4,13),=F'64'
         ST    2,96(13)
         LA    1,88(,13)
         L     15,=V(MEMSET)
         BALR  14,15
         LR    4,6
         LR    5,7
         L     2,4(11)
         LR    3,7
         MVCL  4,2
         B     @@L57
@@L77    EQU   *
         LA    1,88(,13)
         L     15,=V(@@GTERR)
         BALR  14,15
         MVC   88(4,13),0(15)
         MVC   92(4,13),=A(@@LC6)
         B     @@L76
@@L51    EQU   *
* FUNCTION chainAddFunc EPILOGUE
         PDPEPIL
* FUNCTION chainAddFunc LITERAL POOL
         DS    0F
         LTORG
* FUNCTION chainAddFunc PAGE TABLE
         DS    0F
@@PGT4   EQU   *
         DC    A(@@PG4)
@@LC9    EQU   *
         DC    C'Invalid Chain Control Block - chainFirst()'
         DC    X'15'
         DC    X'0'
         DS    0F
* X-FUNC chainFirst PROLOGUE
CHAINFIR PDPPRLG CINDEX=5,FRAME=96,BASER=12,ENTRY=YES
         B     @@FEN5
         LTORG
@@FEN5   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG5    EQU   *
         LR    11,1
         L     10,=A(@@PGT5)
* FUNCTION chainFirst CODE
         L     15,0(11)
         L     2,=A(@@LC3)
         CLC   0(4,15),0(2)
         LA    2,1(0,0)
         BH    *+12
         BL    *+6
         SLR   2,2
         LNR   2,2
         LTR   2,2
         BE    @@L82
         LA    1,88(,13)
         L     15,=V(@@GTERR)
         BALR  14,15
         MVC   88(4,13),0(15)
         MVC   92(4,13),=A(@@LC9)
         LA    1,88(,13)
         L     15,=V(FPRINTF)
         BALR  14,15
         LA    1,88(,13)
         L     15,=V(ABORT)
         BALR  14,15
@@L82    EQU   *
         L     15,36(15)
* FUNCTION chainFirst EPILOGUE
         PDPEPIL
* FUNCTION chainFirst LITERAL POOL
         DS    0F
         LTORG
* FUNCTION chainFirst PAGE TABLE
         DS    0F
@@PGT5   EQU   *
         DC    A(@@PG5)
         DS    0F
* X-FUNC chainLast PROLOGUE
CHAINLAS PDPPRLG CINDEX=6,FRAME=96,BASER=12,ENTRY=YES
         B     @@FEN6
         LTORG
@@FEN6   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG6    EQU   *
         LR    11,1
         L     10,=A(@@PGT6)
* FUNCTION chainLast CODE
         L     15,0(11)
         L     2,=A(@@LC3)
         CLC   0(4,15),0(2)
         LA    2,1(0,0)
         BH    *+12
         BL    *+6
         SLR   2,2
         LNR   2,2
         LTR   2,2
         BE    @@L84
         LA    1,88(,13)
         L     15,=V(@@GTERR)
         BALR  14,15
         MVC   88(4,13),0(15)
         MVC   92(4,13),=A(@@LC9)
         LA    1,88(,13)
         L     15,=V(FPRINTF)
         BALR  14,15
         LA    1,88(,13)
         L     15,=V(ABORT)
         BALR  14,15
@@L84    EQU   *
         L     15,40(15)
* FUNCTION chainLast EPILOGUE
         PDPEPIL
* FUNCTION chainLast LITERAL POOL
         DS    0F
         LTORG
* FUNCTION chainLast PAGE TABLE
         DS    0F
@@PGT6   EQU   *
         DC    A(@@PG6)
@@LC10   EQU   *
         DC    C'Invalid Chain Control Block - chainCount()'
         DC    X'15'
         DC    X'0'
         DS    0F
* X-FUNC chainCount PROLOGUE
CHAINCOU PDPPRLG CINDEX=7,FRAME=96,BASER=12,ENTRY=YES
         B     @@FEN7
         LTORG
@@FEN7   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG7    EQU   *
         LR    11,1
         L     10,=A(@@PGT7)
* FUNCTION chainCount CODE
         L     15,0(11)
         L     2,=A(@@LC3)
         CLC   0(4,15),0(2)
         LA    2,1(0,0)
         BH    *+12
         BL    *+6
         SLR   2,2
         LNR   2,2
         LTR   2,2
         BE    @@L86
         LA    1,88(,13)
         L     15,=V(@@GTERR)
         BALR  14,15
         MVC   88(4,13),0(15)
         MVC   92(4,13),=A(@@LC10)
         LA    1,88(,13)
         L     15,=V(FPRINTF)
         BALR  14,15
         LA    1,88(,13)
         L     15,=V(ABORT)
         BALR  14,15
@@L86    EQU   *
         L     15,20(15)
* FUNCTION chainCount EPILOGUE
         PDPEPIL
* FUNCTION chainCount LITERAL POOL
         DS    0F
         LTORG
* FUNCTION chainCount PAGE TABLE
         DS    0F
@@PGT7   EQU   *
         DC    A(@@PG7)
         END
./ ADD NAME=EXCP
         COPY  PDPTOP
         CSECT
* Program text area
@@LC0    EQU   *
         DC    C'EXCPFILE'
         DC    X'0'
         DS    0F
* X-FUNC xOPENV PROLOGUE
XOPENV   PDPPRLG CINDEX=0,FRAME=104,BASER=12,ENTRY=YES
         B     @@FEN0
         LTORG
@@FEN0   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG0    EQU   *
         LR    11,1
         L     10,=A(@@PGT0)
* FUNCTION xOPENV CODE
         MVC   88(4,13),=F'44'
         LA    1,88(,13)
         L     15,=V(MALLOC)
         BALR  14,15
         LR    3,15
         L     15,=A(@@LC0)
         MVC   0(8,3),0(15)
         MVC   88(4,13),=F'176'
         LA    1,88(,13)
         L     15,=V(MALLOC)
         BALR  14,15
         ST    15,16(3)
         MVC   88(4,13),=F'52'
         LA    1,88(,13)
         L     15,=V(MALLOC)
         BALR  14,15
         ST    15,8(3)
         MVC   88(4,13),=F'40'
         LA    1,88(,13)
         L     15,=V(MALLOC)
         BALR  14,15
         ST    15,32(3)
         MVC   88(4,13),=F'24'
         LA    1,88(,13)
         L     15,=V(MALLOC)
         BALR  14,15
         ST    15,20(3)
         MVC   88(4,13),=F'47968'
         LA    1,88(,13)
         L     15,=V(MALLOC)
         BALR  14,15
         ST    15,24(3)
         L     15,16(3)
         O     15,=F'-2030043136'
         ST    15,12(3)
         MVC   88(4,13),8(3)
         MVC   92(4,13),0(11)
         A     3,=F'12'
         ST    3,96(13)
         A     3,=F'-12'
         LA    1,88(,13)
         L     15,=A(@@0)
         BALR  14,15
         LR    2,15
         MVC   88(4,13),8(3)
         LA    1,88(,13)
         L     15,=A(@@1)
         BALR  14,15
         MVC   88(4,13),16(3)
         MVC   92(4,13),=F'4'
         MVC   96(4,13),=F'44'
         LA    1,88(,13)
         L     15,=V(MEMSET)
         BALR  14,15
         LTR   2,2
         BE    @@L4
@@L2     EQU   *
         LTR   2,2
         BNE   @@L5
         LR    15,3
         B     @@L1
@@L5     EQU   *
         MVC   88(4,13),16(3)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         MVC   88(4,13),8(3)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         MVC   88(4,13),32(3)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         MVC   88(4,13),20(3)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         MVC   88(4,13),24(3)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         ST    3,88(13)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         SLR   15,15
         B     @@L1
@@L4     EQU   *
         MVC   88(4,13),8(3)
         LA    1,88(,13)
         L     15,=A(@@2)
         BALR  14,15
         LR    2,15
         B     @@L2
@@L1     EQU   *
* FUNCTION xOPENV EPILOGUE
         PDPEPIL
* FUNCTION xOPENV LITERAL POOL
         DS    0F
         LTORG
* FUNCTION xOPENV PAGE TABLE
         DS    0F
@@PGT0   EQU   *
         DC    A(@@PG0)
         DS    0F
* S-FUNC makeDCB PROLOGUE
@@0      PDPPRLG CINDEX=1,FRAME=104,BASER=12,ENTRY=NO
         B     @@FEN1
         LTORG
@@FEN1   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG1    EQU   *
         LR    11,1
         L     10,=A(@@PGT1)
* FUNCTION makeDCB CODE
         L     2,0(11)
         L     6,4(11)
         ST    2,88(13)
         MVC   92(4,13),=F'0'
         MVC   96(4,13),=F'52'
         LA    1,88(,13)
         L     15,=V(MEMSET)
         BALR  14,15
         MVI   23(2),1
         MVI   26(2),64
         MVI   31(2),1
         MVI   35(2),1
         MVI   48(2),2
         MVI   50(2),208
         MVI   51(2),8
         MVC   36(4,2),8(11)
         A     2,=F'40'
         ST    2,88(13)
         MVC   92(4,13),=F'64'
         MVC   96(4,13),=F'8'
         LA    1,88(,13)
         L     15,=V(MEMSET)
         BALR  14,15
         ST    6,88(13)
         LA    1,88(,13)
         L     15,=V(STRLEN)
         BALR  14,15
         L     3,=F'-1'
         LA    5,8(0,0)
         CR    15,5
         BH    @@L6
         LR    4,2
         LR    5,15
         LR    2,6
         LR    3,15
         MVCL  4,2
         SLR   3,3
@@L6     EQU   *
         LR    15,3
* FUNCTION makeDCB EPILOGUE
         PDPEPIL
* FUNCTION makeDCB LITERAL POOL
         DS    0F
         LTORG
* FUNCTION makeDCB PAGE TABLE
         DS    0F
@@PGT1   EQU   *
         DC    A(@@PG1)
         DS    0F
* S-FUNC openJDCB PROLOGUE
@@2      PDPPRLG CINDEX=2,FRAME=120,BASER=12,ENTRY=NO
         B     @@FEN2
         LTORG
@@FEN2   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG2    EQU   *
         LR    11,1
         L     10,=A(@@PGT2)
* FUNCTION openJDCB CODE
         L     3,0(11)
         ST    3,112(13)
         LR    15,3
         O     15,=F'-2147483648'
         ST    15,112(13)
         LA    15,112(,13)
         ST    15,100(13)
         MVC   88(4,13),=F'22'
         LA    15,96(,13)
         ST    15,92(13)
         LA    1,88(,13)
         L     15,=V(EXSVC)
         BALR  14,15
         IC    15,48(3)
         N     15,=F'16'
         N     15,=XL4'000000FF'
         BCTR  15,0
         SRL   15,31
         SLL   15,3
* FUNCTION openJDCB EPILOGUE
         PDPEPIL
* FUNCTION openJDCB LITERAL POOL
         DS    0F
         LTORG
* FUNCTION openJDCB PAGE TABLE
         DS    0F
@@PGT2   EQU   *
         DC    A(@@PG2)
         DS    0F
* S-FUNC readJFCB PROLOGUE
@@1      PDPPRLG CINDEX=3,FRAME=120,BASER=12,ENTRY=NO
         B     @@FEN3
         LTORG
@@FEN3   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG3    EQU   *
         LR    11,1
         L     10,=A(@@PGT3)
* FUNCTION readJFCB CODE
         L     15,0(11)
         ST    15,112(13)
         O     15,=F'-2147483648'
         ST    15,112(13)
         LA    15,112(,13)
         ST    15,100(13)
         MVC   88(4,13),=F'64'
         LA    15,96(,13)
         ST    15,92(13)
         LA    1,88(,13)
         L     15,=V(EXSVC)
         BALR  14,15
         LA    15,8(0,0)
* FUNCTION readJFCB EPILOGUE
         PDPEPIL
* FUNCTION readJFCB LITERAL POOL
         DS    0F
         LTORG
* FUNCTION readJFCB PAGE TABLE
         DS    0F
@@PGT3   EQU   *
         DC    A(@@PG3)
         DS    0F
* X-FUNC xOPEN PROLOGUE
XOPEN    PDPPRLG CINDEX=4,FRAME=128,BASER=12,ENTRY=YES
         B     @@FEN4
         LTORG
@@FEN4   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG4    EQU   *
         LR    11,1
         L     10,=A(@@PGT4)
* FUNCTION xOPEN CODE
         MVC   88(4,13),=F'44'
         LA    1,88(,13)
         L     15,=V(MALLOC)
         BALR  14,15
         LR    4,15
         L     3,=A(@@LC0)
         MVC   0(8,15),0(3)
         MVC   88(4,13),=F'176'
         LA    1,88(,13)
         L     15,=V(MALLOC)
         BALR  14,15
         ST    15,16(4)
         MVC   88(4,13),=F'52'
         LA    1,88(,13)
         L     15,=V(MALLOC)
         BALR  14,15
         ST    15,8(4)
         MVC   88(4,13),=F'40'
         LA    1,88(,13)
         L     15,=V(MALLOC)
         BALR  14,15
         ST    15,32(4)
         MVC   88(4,13),=F'24'
         LA    1,88(,13)
         L     15,=V(MALLOC)
         BALR  14,15
         ST    15,20(4)
         MVC   88(4,13),=F'47968'
         LA    1,88(,13)
         L     15,=V(MALLOC)
         BALR  14,15
         ST    15,24(4)
         L     3,16(4)
         O     3,=F'-2030043136'
         ST    3,12(4)
         MVC   88(4,13),8(4)
         MVC   92(4,13),0(11)
         A     4,=F'12'
         ST    4,96(13)
         A     4,=F'-12'
         LA    1,88(,13)
         L     15,=A(@@0)
         BALR  14,15
         LTR   15,15
         BE    @@L36
@@L32    EQU   *
         LTR   15,15
         BNE   @@L37
         LR    15,4
         B     @@L31
@@L37    EQU   *
         MVC   88(4,13),16(4)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         MVC   88(4,13),8(4)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         MVC   88(4,13),32(4)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         MVC   88(4,13),20(4)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         MVC   88(4,13),24(4)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         ST    4,88(13)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         SLR   15,15
         B     @@L31
@@L36    EQU   *
         L     3,8(4)
         ST    3,120(13)
         LR    15,3
         O     15,=F'-2147483648'
         ST    15,120(13)
         LA    15,120(,13)
         ST    15,108(13)
         MVC   88(4,13),=F'19'
         LA    15,104(,13)
         ST    15,92(13)
         LA    1,88(,13)
         L     15,=V(EXSVC)
         BALR  14,15
         IC    2,48(3)
         N     2,=F'16'
         LR    15,2
         N     15,=XL4'000000FF'
         BCTR  15,0
         SRL   15,31
         SLL   15,3
         B     @@L32
@@L31    EQU   *
* FUNCTION xOPEN EPILOGUE
         PDPEPIL
* FUNCTION xOPEN LITERAL POOL
         DS    0F
         LTORG
* FUNCTION xOPEN PAGE TABLE
         DS    0F
@@PGT4   EQU   *
         DC    A(@@PG4)
         DS    0F
* X-FUNC xCLOSE PROLOGUE
XCLOSE   PDPPRLG CINDEX=5,FRAME=120,BASER=12,ENTRY=YES
         B     @@FEN5
         LTORG
@@FEN5   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG5    EQU   *
         LR    11,1
         L     10,=A(@@PGT5)
* FUNCTION xCLOSE CODE
         L     3,0(11)
         L     15,=A(@@LC0)
         CLC   0(8,3),0(15)
         LA    4,1(0,0)
         BH    *+12
         BL    *+6
         SLR   4,4
         LNR   4,4
         LTR   4,4
         BE    @@L39
         L     15,=F'-100'
         B     @@L38
@@L39    EQU   *
         L     15,8(3)
         ST    15,112(13)
         O     15,=F'-2147483648'
         ST    15,112(13)
         LA    15,112(,13)
         ST    15,100(13)
         MVC   88(4,13),=F'20'
         LA    15,96(,13)
         ST    15,92(13)
         LA    1,88(,13)
         L     15,=V(EXSVC)
         BALR  14,15
         MVC   88(4,13),16(3)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         MVC   88(4,13),8(3)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         MVC   88(4,13),32(3)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         MVC   88(4,13),20(3)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         MVC   88(4,13),24(3)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         ST    3,88(13)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         LR    15,4
@@L38    EQU   *
* FUNCTION xCLOSE EPILOGUE
         PDPEPIL
* FUNCTION xCLOSE LITERAL POOL
         DS    0F
         LTORG
* FUNCTION xCLOSE PAGE TABLE
         DS    0F
@@PGT5   EQU   *
         DC    A(@@PG5)
         DS    0F
* X-FUNC xREAD PROLOGUE
XREAD    PDPPRLG CINDEX=6,FRAME=104,BASER=12,ENTRY=YES
         B     @@FEN6
         LTORG
@@FEN6   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG6    EQU   *
         LR    11,1
         L     10,=A(@@PGT6)
* FUNCTION xREAD CODE
         L     5,0(11)
         L     7,4(11)
         L     3,8(11)
         L     4,12(11)
         L     8,=A(@@LC0)
         CLC   0(8,5),0(8)
         LA    6,1(0,0)
         BH    *+12
         BL    *+6
         SLR   6,6
         LNR   6,6
         LTR   6,6
         BE    @@L42
         L     15,=F'-100'
         B     @@L41
@@L42    EQU   *
         L     15,=F'-101'
         LTR   4,4
         BNH   @@L41
         MVC   88(4,13),8(5)
         SLL   3,8
         AR    3,4
         BCTR  3,0
         ST    3,92(13)
         LR    8,5
         A     8,=F'36'
         ST    8,96(13)
         LA    1,88(,13)
         L     15,=A(@@5)
         BALR  14,15
         LR    6,15
         LTR   15,15
         BNE   @@L41
         L     2,32(5)
         L     3,8(5)
         L     4,20(5)
         ST    2,88(13)
         ST    15,92(13)
         MVC   96(4,13),=F'40'
         LA    1,88(,13)
         L     15,=V(MEMSET)
         BALR  14,15
         ST    3,20(2)
         A     5,=F'28'
         ST    5,4(2)
         A     5,=F'-28'
         ST    4,16(2)
         MVI   0(2),67
         MVC   32(8,2),0(8)
         L     15,20(5)
         L     2,24(5)
         L     3,32(5)
         A     3,=F'35'
         ST    3,0(15)
         MVI   0(15),49
         MVI   4(15),64
         STC   6,5(15)
         STC   6,6(15)
         MVI   7(15),5
         LR    3,15
         A     15,=F'8'
         ST    3,0(15)
         MVI   0(15),8
         MVI   4(15),64
         STC   6,5(15)
         STC   6,6(15)
         MVI   7(15),1
         A     15,=F'8'
         ST    2,0(15)
         MVI   0(15),30
         MVI   4(15),32
         STC   6,5(15)
         MVI   6(15),187
         MVI   7(15),96
         MVC   88(4,13),32(5)
         MVC   92(4,13),24(5)
         LR    3,7
         A     3,=F'8'
         ST    3,96(13)
         A     7,=F'12'
         ST    7,100(13)
         A     7,=F'-12'
         LA    1,88(,13)
         L     15,=A(@@9)
         BALR  14,15
         LR    6,15
         LTR   15,15
         BNE   @@L47
         MVC   16(4,7),24(5)
         L     4,24(5)
         A     4,=F'8'
         ST    4,20(7)
         L     15,24(5)
         A     15,0(3)
         A     15,=F'8'
         ST    15,24(7)
         MVC   0(3,7),0(8)
         L     4,24(5)
         MVC   3(5,7),0(4)
@@L47    EQU   *
         LR    15,6
@@L41    EQU   *
* FUNCTION xREAD EPILOGUE
         PDPEPIL
* FUNCTION xREAD LITERAL POOL
         DS    0F
         LTORG
* FUNCTION xREAD PAGE TABLE
         DS    0F
@@PGT6   EQU   *
         DC    A(@@PG6)
         DS    0F
* X-FUNC xTREAD PROLOGUE
XTREAD   PDPPRLG CINDEX=7,FRAME=104,BASER=12,ENTRY=YES
         B     @@FEN7
         LTORG
@@FEN7   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG7    EQU   *
         LR    11,1
         L     10,=A(@@PGT7)
* FUNCTION xTREAD CODE
         L     5,0(11)
         L     6,4(11)
         L     3,8(11)
         L     7,=A(@@LC0)
         CLC   0(8,5),0(7)
         LA    4,1(0,0)
         BH    *+12
         BL    *+6
         SLR   4,4
         LNR   4,4
         LTR   4,4
         BE    @@L49
         L     15,=F'-100'
         B     @@L48
@@L49    EQU   *
         MVC   88(4,13),8(5)
         SLL   3,8
         ST    3,92(13)
         LR    8,5
         A     8,=F'36'
         ST    8,96(13)
         LA    1,88(,13)
         L     15,=A(@@5)
         BALR  14,15
         LR    7,15
         LTR   15,15
         BNE   @@L48
         L     2,32(5)
         L     3,8(5)
         L     4,20(5)
         ST    2,88(13)
         ST    15,92(13)
         MVC   96(4,13),=F'40'
         LA    1,88(,13)
         L     15,=V(MEMSET)
         BALR  14,15
         ST    3,20(2)
         A     5,=F'28'
         ST    5,4(2)
         A     5,=F'-28'
         ST    4,16(2)
         MVI   0(2),67
         MVC   32(8,2),0(8)
         L     15,20(5)
         L     2,24(5)
         L     3,32(5)
         A     3,=F'35'
         ST    3,0(15)
         MVI   0(15),49
         MVI   4(15),64
         STC   7,5(15)
         STC   7,6(15)
         MVI   7(15),5
         LR    3,15
         A     15,=F'8'
         ST    3,0(15)
         MVI   0(15),8
         MVI   4(15),64
         STC   7,5(15)
         STC   7,6(15)
         MVI   7(15),1
         A     15,=F'8'
         ST    2,0(15)
         MVI   0(15),94
         MVI   4(15),32
         STC   7,5(15)
         MVI   6(15),187
         MVI   7(15),96
         MVC   88(4,13),32(5)
         MVC   92(4,13),24(5)
         A     6,=F'8'
         ST    6,96(13)
         A     6,=F'4'
         ST    6,100(13)
         A     6,=F'-12'
         LA    1,88(,13)
         L     15,=A(@@10)
         BALR  14,15
         LR    7,15
         LTR   15,15
         BNE   @@L53
         MVC   16(4,6),24(5)
         MVC   20(4,6),24(5)
         MVC   24(4,6),24(5)
         MVC   0(3,6),0(8)
         L     4,24(5)
         MVC   3(5,6),0(4)
@@L53    EQU   *
         LR    15,7
@@L48    EQU   *
* FUNCTION xTREAD EPILOGUE
         PDPEPIL
* FUNCTION xTREAD LITERAL POOL
         DS    0F
         LTORG
* FUNCTION xTREAD PAGE TABLE
         DS    0F
@@PGT7   EQU   *
         DC    A(@@PG7)
         DS    0F
* S-FUNC cnvtTTR PROLOGUE
@@5      PDPPRLG CINDEX=8,FRAME=112,BASER=12,ENTRY=NO
         B     @@FEN8
         LTORG
@@FEN8   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG8    EQU   *
         LR    11,1
         L     10,=A(@@PGT8)
* FUNCTION cnvtTTR CODE
         SLR   6,6
         SLR   7,7
         LR    8,6
         LR    9,7
         L     4,4(11)
         LR    2,4
         N     2,=F'255'
         ST    2,108(13)
         LR    5,4
         SRA   5,8
         N     5,=F'65535'
         L     3,0(11)
         A     3,=F'44'
         L     2,0(3)
         SLR   4,4
         IC    4,16(2)
         A     2,=F'32'
         MVC   104(4,13),=F'0'
         LTR   4,4
         BE    @@L13
         LH    3,14(2)
         N     3,=XL4'0000FFFF'
         CR    5,3
         BL    @@L13
@@L16    EQU   *
         SR    5,3
         A     2,=F'16'
         L     6,104(13)
         A     6,=F'1'
         ST    6,104(13)
         BCTR  4,0
         LTR   4,4
         BE    @@L13
         LH    3,14(2)
         N     3,=XL4'0000FFFF'
         CR    5,3
         BNL   @@L16
@@L13    EQU   *
         LA    15,12(0,0)
         LTR   4,4
         BE    @@L11
         LH    3,6(2)
         N     3,=XL4'0000FFFF'
         LH    2,8(2)
         N     2,=XL4'0000FFFF'
         AR    2,5
         LR    6,2
         SRDA  6,32
         LA    5,30(0,0)
         DR    6,5
         AR    3,7
         LR    8,2
         SRDA  8,32
         DR    8,5
         MVC   88(4,13),8(11)
         MVC   92(4,13),=F'0'
         MVC   96(4,13),=F'8'
         LA    1,88(,13)
         L     15,=V(MEMSET)
         BALR  14,15
         L     7,8(11)
         MVC   0(1,7),107(13)
         LR    2,3
         SRA   2,8
         STC   2,3(7)
         STC   3,4(7)
         LR    2,8
         SRA   2,8
         STC   2,5(7)
         STC   8,6(7)
         MVC   7(1,7),111(13)
         SLR   15,15
@@L11    EQU   *
* FUNCTION cnvtTTR EPILOGUE
         PDPEPIL
* FUNCTION cnvtTTR LITERAL POOL
         DS    0F
         LTORG
* FUNCTION cnvtTTR PAGE TABLE
         DS    0F
@@PGT8   EQU   *
         DC    A(@@PG8)
         DS    0F
* S-FUNC doEXCP PROLOGUE
@@9      PDPPRLG CINDEX=9,FRAME=112,BASER=12,ENTRY=NO
         B     @@FEN9
         LTORG
@@FEN9   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG9    EQU   *
         LR    11,1
         L     10,=A(@@PGT9)
* FUNCTION doEXCP CODE
         L     4,0(11)
         L     5,4(11)
         L     2,4(4)
         MVC   0(4,2),=F'0'
         ST    4,100(13)
         MVC   88(4,13),=F'0'
         LA    3,96(,13)
         ST    3,92(13)
         LA    1,88(,13)
         L     15,=V(EXSVC)
         BALR  14,15
         ST    2,100(13)
         MVC   96(4,13),=F'1'
         MVC   88(4,13),=F'1'
         ST    3,92(13)
         LA    1,88(,13)
         L     15,=V(EXSVC)
         BALR  14,15
         SLR   15,15
         IC    15,0(2)
         LR    2,15
         LA    15,8(0,0)
         LA    3,66(0,0)
         CLR   2,3
         BE    @@L18
         LA    15,65(0,0)
         CLR   2,15
         BE    @@L61
         LA    15,16(0,0)
         LA    3,127(0,0)
         CLR   2,3
         BNE   @@L18
         SLR   3,3
         IC    3,39(4)
         A     3,=F'1'
         SLR   4,4
         IC    4,4(5)
         LA    15,4(0,0)
         CLR   3,4
         BNE   @@L18
         SLR   2,2
         IC    2,5(5)
         L     4,8(11)
         ST    2,0(4)
         SLR   15,15
         IC    15,6(5)
         SLL   15,8
         SLR   2,2
         IC    2,7(5)
         L     5,12(11)
         OR    2,15
         ST    2,0(5)
         SLR   15,15
         B     @@L18
@@L61    EQU   *
         IC    3,12(4)
         LR    2,3
         N     2,=F'2'
         LA    15,4(0,0)
         CLM   2,1,=XL1'00'
         BNE   @@L18
         N     3,=F'1'
         LA    15,8(0,0)
         CLM   3,1,=XL1'00'
         BNE   @@L18
         LA    15,16(0,0)
@@L18    EQU   *
* FUNCTION doEXCP EPILOGUE
         PDPEPIL
* FUNCTION doEXCP LITERAL POOL
         DS    0F
         LTORG
* FUNCTION doEXCP PAGE TABLE
         DS    0F
@@PGT9   EQU   *
         DC    A(@@PG9)
         DS    0F
* S-FUNC doEXCPTRK PROLOGUE
@@10     PDPPRLG CINDEX=10,FRAME=112,BASER=12,ENTRY=NO
         B     @@FEN10
         LTORG
@@FEN10  EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG10   EQU   *
         LR    11,1
         L     10,=A(@@PGT10)
* FUNCTION doEXCPTRK CODE
         L     4,0(11)
         L     2,4(4)
         MVC   0(4,2),=F'0'
         ST    4,100(13)
         MVC   88(4,13),=F'0'
         LA    3,96(,13)
         ST    3,92(13)
         LA    1,88(,13)
         L     15,=V(EXSVC)
         BALR  14,15
         ST    2,100(13)
         MVC   96(4,13),=F'1'
         MVC   88(4,13),=F'1'
         ST    3,92(13)
         LA    1,88(,13)
         L     15,=V(EXSVC)
         BALR  14,15
         SLR   15,15
         IC    15,0(2)
         LR    2,15
         LA    15,8(0,0)
         LA    3,66(0,0)
         CLR   2,3
         BE    @@L25
         LA    15,65(0,0)
         CLR   2,15
         BE    @@L62
         LA    15,16(0,0)
         LA    3,127(0,0)
         CLR   2,3
         BNE   @@L25
         L     3,8(11)
         MVC   0(4,3),=F'0'
         LH    2,14(4)
         N     2,=XL4'0000FFFF'
         L     15,=F'47968'
         SR    15,2
         L     4,12(11)
         ST    15,0(4)
         SLR   15,15
         B     @@L25
@@L62    EQU   *
         IC    3,12(4)
         LR    2,3
         N     2,=F'2'
         LA    15,4(0,0)
         CLM   2,1,=XL1'00'
         BNE   @@L25
         N     3,=F'1'
         LA    15,8(0,0)
         CLM   3,1,=XL1'00'
         BNE   @@L25
         LA    15,16(0,0)
@@L25    EQU   *
* FUNCTION doEXCPTRK EPILOGUE
         PDPEPIL
* FUNCTION doEXCPTRK LITERAL POOL
         DS    0F
         LTORG
* FUNCTION doEXCPTRK PAGE TABLE
         DS    0F
@@PGT10  EQU   *
         DC    A(@@PG10)
         END
./ ADD NAME=EXEC
********************************************
* struct REGS
* {
*   unsigned int R0;
*   unsigned int R1;
*   unsigned int R15;
* };
* void EXEC(struct REGS *regs);
********************************************
         COPY  PDPTOP
         CSECT
* Program text area
         DS    0F
* X-func EXEC prologue
EXEC     PDPPRLG CINDEX=0,FRAME=88,BASER=12,ENTRY=YES
         B     @@FEN0
         LTORG
@@FEN0   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG0    EQU   *
         LR    11,1
         L     10,=A(@@PGT0)
* Function EXEC code
* Initialize registers
         L     2,4(11) *  regs
         L     0,0(3)  *  regs->R0
         L     1,4(3)  *  regs->R1
         L     15,8(3) *  regs->R15
* Execute service
         BALR  14,15
* Return registers
         ST    0,0(3)  *  regs->R0
         ST    1,4(3)  *  regs->R1
         ST    15,8(3) *  regs->R15
         L     15,0
* Function EXEC epilogue
         PDPEPIL
* Function EXEC literal pool
         DS    0F
         LTORG
* Function EXEC page table
         DS    0F
@@PGT0   EQU   *
         DC    A(@@PG0)
         END
./ ADD NAME=FINDDEVT
         COPY  PDPTOP
         CSECT
* Program text area
@@LC0    EQU   *
         DC    C'3211'
         DC    X'0'
@@LC1    EQU   *
         DC    C'2301'
         DC    X'0'
@@LC2    EQU   *
         DC    C'2303'
         DC    X'0'
@@LC3    EQU   *
         DC    C'2302'
         DC    X'0'
@@LC4    EQU   *
         DC    C'2321'
         DC    X'0'
@@LC5    EQU   *
         DC    C'2305'
         DC    X'0'
@@LC6    EQU   *
         DC    C'2314'
         DC    X'0'
@@LC7    EQU   *
         DC    C'3330'
         DC    X'0'
@@LC8    EQU   *
         DC    C'3340'
         DC    X'0'
@@LC9    EQU   *
         DC    C'3350'
         DC    X'0'
@@LC10   EQU   *
         DC    X'0'
* Program data area
         DS    0F
@@1      EQU   *
         DC    X'01'
         DC    3X'00'
         DC    A(@@LC0)
         DC    X'02'
         DC    3X'00'
         DC    A(@@LC1)
         DC    X'03'
         DC    3X'00'
         DC    A(@@LC2)
         DC    X'04'
         DC    3X'00'
         DC    A(@@LC3)
         DC    X'05'
         DC    3X'00'
         DC    A(@@LC4)
         DC    X'06'
         DC    3X'00'
         DC    A(@@LC5)
         DC    X'07'
         DC    3X'00'
         DC    A(@@LC5)
         DC    X'08'
         DC    3X'00'
         DC    A(@@LC6)
         DC    X'09'
         DC    3X'00'
         DC    A(@@LC7)
         DC    X'0A'
         DC    3X'00'
         DC    A(@@LC8)
         DC    X'0B'
         DC    3X'00'
         DC    A(@@LC9)
         DC    X'0D'
         DC    3X'00'
         DC    A(@@LC7)
         DC    X'FF'
         DC    3X'00'
         DC    A(@@LC10)
* Program text area
         DS    0F
* X-FUNC finddevt PROLOGUE
FINDDEVT PDPPRLG CINDEX=0,FRAME=88,BASER=12,ENTRY=YES
         B     @@FEN0
         LTORG
@@FEN0   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG0    EQU   *
         LR    11,1
         L     10,=A(@@PGT0)
* FUNCTION finddevt CODE
         L     8,0(11)
         LA    4,16(0,0)
         L     3,0(4)
         L     4,40(3)
         LA    9,4(0,0)
@@L16    EQU   *
         SLR   3,3
         IC    3,0(4)
         SLL   3,8
         SLR   6,6
         IC    6,1(4)
         AR    3,6
         SLR   15,15
         L     5,=F'65535'
         CLR   3,5
         BE    @@L1
         LTR   3,3
         BE    @@L6
         CLI   18(3),32
         BE    @@L19
@@L8     EQU   *
         LTR   15,15
         BNE   @@L1
@@L6     EQU   *
         A     4,=F'2'
         B     @@L16
@@L19    EQU   *
         CLC   0(6,8),28(3)
         LA    2,1(0,0)
         BH    *+12
         BL    *+6
         SLR   2,2
         LNR   2,2
         LTR   2,2
         BE    @@L9
         SLR   15,15
         B     @@L8
@@L9     EQU   *
         LR    6,2
         L     5,=A(@@1)
@@L10    EQU   *
         LR    7,6
         MH    7,=H'8'
         IC    2,0(5)
         SLR   15,15
         CLM   2,1,=XL1'FF'
         BE    @@L8
         CLM   2,1,19(3)
         BE    @@L18
         A     5,=F'8'
         A     6,=F'1'
         B     @@L10
@@L18    EQU   *
         A     7,=A(@@1)
         L     15,0(9,7)
         B     @@L8
@@L1     EQU   *
* FUNCTION finddevt EPILOGUE
         PDPEPIL
* FUNCTION finddevt LITERAL POOL
         DS    0F
         LTORG
* FUNCTION finddevt PAGE TABLE
         DS    0F
@@PGT0   EQU   *
         DC    A(@@PG0)
         END
./ ADD NAME=FSS
         COPY  PDPTOP
         CSECT
* Program text area
         DS    0F
* X-FUNC fssRefresh PROLOGUE
FSSREFRE PDPPRLG CINDEX=0,FRAME=128,BASER=12,ENTRY=YES
         B     @@FEN0
         LTORG
@@FEN0   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG0    EQU   *
         LR    11,1
         L     10,=A(@@PGT0)
* FUNCTION fssRefresh CODE
         LA    4,3840(0,0)
         ST    4,88(13)
         LA    1,88(,13)
         L     15,=V(MALLOC)
         BALR  14,15
         ST    15,100(13)
         ST    4,88(13)
         LA    1,88(,13)
         L     15,=V(MALLOC)
         BALR  14,15
         ST    15,104(13)
         L     3,100(13)
         MVI   0(3),39
         MVI   1(3),245
         MVI   2(3),195
         LR    4,3
         A     4,=F'3'
         MVC   96(4,13),=F'0'
         L     5,=A(@@8)
         SLR   2,2
         C     2,0(5)
         BNL   @@L44
         MVC   112(4,13),=A(@@9)
         L     5,=A(@@9+4)
@@L36    EQU   *
         L     8,0(5)
         BCTR  8,0
         SRA   8,6
         N     8,=F'63'
         ST    8,88(13)
         LA    1,88(,13)
         L     15,=V(XLATE327)
         BALR  14,15
         LR    6,15
         SLL   6,8
         L     7,0(5)
         BCTR  7,0
         N     7,=F'63'
         ST    7,88(13)
         LA    1,88(,13)
         L     15,=V(XLATE327)
         BALR  14,15
         OR    15,6
         MVI   0(4),17
         A     4,=F'1'
         LR    2,15
         SRA   2,8
         STC   2,0(4)
         A     4,=F'1'
         STC   15,0(4)
         A     4,=F'1'
         MVI   0(4),29
         A     4,=F'1'
         MVC   0(1,4),7(5)
         A     4,=F'1'
         SLR   8,8
         IC    8,5(5)
         SLR   9,9
         IC    9,6(5)
         LTR   8,8
         BE    @@L30
         MVI   0(4),40
         A     4,=F'1'
         MVI   0(4),65
         A     4,=F'1'
         STC   8,0(4)
         A     4,=F'1'
@@L30    EQU   *
         LTR   9,9
         BE    @@L31
         MVI   0(4),40
         A     4,=F'1'
         MVI   0(4),66
         A     4,=F'1'
         STC   9,0(4)
         A     4,=F'1'
@@L31    EQU   *
         L     2,112(13)
         A     2,=F'16'
         ST    2,108(13)
         L     2,12(5)
         LTR   2,2
         BNE   @@L45
@@L32    EQU   *
         L     3,0(5)
         A     3,8(5)
         SRA   3,6
         N     3,=F'63'
         ST    3,88(13)
         LA    1,88(,13)
         L     15,=V(XLATE327)
         BALR  14,15
         LR    7,15
         SLL   7,8
         L     15,0(5)
         A     15,8(5)
         N     15,=F'63'
         ST    15,88(13)
         LA    1,88(,13)
         L     15,=V(XLATE327)
         BALR  14,15
         OR    15,7
         MVI   0(4),17
         A     4,=F'1'
         LR    2,15
         SRA   2,8
         STC   2,0(4)
         A     4,=F'1'
         STC   15,0(4)
         A     4,=F'1'
         MVI   0(4),29
         A     4,=F'1'
         MVC   88(4,13),=F'48'
         LR    6,4
         A     4,=F'1'
         LA    1,88(,13)
         L     15,=V(XLATE327)
         BALR  14,15
         STC   15,0(6)
         LTR   8,8
         BNE   @@L35
         LTR   9,9
         BE    @@L28
@@L35    EQU   *
         MVI   0(4),40
         A     4,=F'1'
         MVI   0(4),0
         A     4,=F'1'
         MVI   0(4),0
         A     4,=F'1'
@@L28    EQU   *
         A     5,=F'20'
         L     6,112(13)
         A     6,=F'20'
         ST    6,112(13)
         L     8,96(13)
         A     8,=F'1'
         ST    8,96(13)
         L     9,=A(@@8)
         C     8,0(9)
         BL    @@L36
@@L44    EQU   *
         L     3,=A(@@10)
         L     5,0(3)
         LTR   5,5
         BE    @@L37
         MVI   0(4),17
         A     4,=F'1'
         L     2,0(3)
         SRA   2,8
         STC   2,0(4)
         A     4,=F'1'
         MVC   0(1,4),3(3)
         A     4,=F'1'
         MVI   0(4),19
         A     4,=F'1'
         MVC   0(4,3),=F'0'
@@L37    EQU   *
         LR    2,4
         S     2,100(13)
@@L38    EQU   *
         MVC   88(4,13),100(13)
         ST    2,92(13)
         LA    1,88(,13)
         L     15,=V(TPUT@FUL)
         BALR  14,15
         MVC   88(4,13),104(13)
         MVC   92(4,13),=F'3840'
         LA    1,88(,13)
         L     15,=V(TGET@ASI)
         BALR  14,15
         L     3,104(13)
         CLI   0(3),110
         BE    @@L38
         B     @@L46
@@L45    EQU   *
         ST    2,88(13)
         LA    1,88(,13)
         L     15,=V(STRLEN)
         BALR  14,15
         ST    15,120(13)
         L     2,8(5)
         CR    2,15
         BNL   @@L33
         ST    2,120(13)
@@L33    EQU   *
         LR    6,4
         L     7,120(13)
         L     3,108(13)
         L     2,0(3)
         LR    3,7
         MVCL  6,2
         A     4,120(13)
         B     @@L32
@@L46    EQU   *
         ST    3,88(13)
         ST    15,92(13)
         LA    1,88(,13)
         L     15,=A(@@5)
         BALR  14,15
         MVC   88(4,13),100(13)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         MVC   88(4,13),104(13)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         SLR   15,15
* FUNCTION fssRefresh EPILOGUE
         PDPEPIL
* FUNCTION fssRefresh LITERAL POOL
         DS    0F
         LTORG
* FUNCTION fssRefresh PAGE TABLE
         DS    0F
@@PGT0   EQU   *
         DC    A(@@PG0)
         DS    0F
* X-FUNC fssIsNumeric PROLOGUE
FSSISNUM PDPPRLG CINDEX=1,FRAME=96,BASER=12,ENTRY=YES
         B     @@FEN1
         LTORG
@@FEN1   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG1    EQU   *
         LR    11,1
         L     10,=A(@@PGT1)
* FUNCTION fssIsNumeric CODE
         L     5,0(11)
         ST    5,88(13)
         LA    1,88(,13)
         L     15,=V(STRLEN)
         BALR  14,15
         SLR   2,2
         LTR   15,15
         BNH   @@L82
         SLR   3,3
         CR    3,15
         BNL   @@L91
         L     2,=V(@@ISBUF)
         L     4,0(2)
@@L89    EQU   *
         SLR   2,2
         IC    2,0(3,5)
         MH    2,=H'2'
         LH    2,0(2,4)
         N     2,=F'8'
         CH    2,=H'0'
         BE    @@L92
         A     3,=F'1'
         CR    3,15
         BL    @@L89
@@L91    EQU   *
         LA    2,1(0,0)
         B     @@L82
@@L92    EQU   *
         SLR   2,2
@@L82    EQU   *
         LR    15,2
* FUNCTION fssIsNumeric EPILOGUE
         PDPEPIL
* FUNCTION fssIsNumeric LITERAL POOL
         DS    0F
         LTORG
* FUNCTION fssIsNumeric PAGE TABLE
         DS    0F
@@PGT1   EQU   *
         DC    A(@@PG1)
         DS    0F
* X-FUNC fssIsHex PROLOGUE
FSSISHEX PDPPRLG CINDEX=2,FRAME=96,BASER=12,ENTRY=YES
         B     @@FEN2
         LTORG
@@FEN2   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG2    EQU   *
         LR    11,1
         L     10,=A(@@PGT2)
* FUNCTION fssIsHex CODE
         L     5,0(11)
         ST    5,88(13)
         LA    1,88(,13)
         L     15,=V(STRLEN)
         BALR  14,15
         SLR   2,2
         LTR   15,15
         BNH   @@L93
         SLR   3,3
         CR    3,15
         BNL   @@L102
         L     2,=V(@@ISBUF)
         L     4,0(2)
@@L100   EQU   *
         SLR   2,2
         IC    2,0(3,5)
         MH    2,=H'2'
         LH    2,0(2,4)
         N     2,=F'1024'
         CH    2,=H'0'
         BE    @@L103
         A     3,=F'1'
         CR    3,15
         BL    @@L100
@@L102   EQU   *
         LA    2,1(0,0)
         B     @@L93
@@L103   EQU   *
         SLR   2,2
@@L93    EQU   *
         LR    15,2
* FUNCTION fssIsHex EPILOGUE
         PDPEPIL
* FUNCTION fssIsHex LITERAL POOL
         DS    0F
         LTORG
* FUNCTION fssIsHex PAGE TABLE
         DS    0F
@@PGT2   EQU   *
         DC    A(@@PG2)
         DS    0F
* X-FUNC fssIsBlank PROLOGUE
FSSISBLA PDPPRLG CINDEX=3,FRAME=88,BASER=12,ENTRY=YES
         B     @@FEN3
         LTORG
@@FEN3   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG3    EQU   *
         LR    11,1
         L     10,=A(@@PGT3)
* FUNCTION fssIsBlank CODE
         L     4,0(11)
         SLR   3,3
@@L105   EQU   *
         IC    2,0(3,4)
         LA    15,1(0,0)
         CLM   2,1,=XL1'00'
         BE    @@L104
         SLR   15,15
         A     3,=F'1'
         CLM   2,1,=XL1'40'
         BE    @@L105
@@L104   EQU   *
* FUNCTION fssIsBlank EPILOGUE
         PDPEPIL
* FUNCTION fssIsBlank LITERAL POOL
         DS    0F
         LTORG
* FUNCTION fssIsBlank PAGE TABLE
         DS    0F
@@PGT3   EQU   *
         DC    A(@@PG3)
         DS    0F
* X-FUNC fssTrim PROLOGUE
FSSTRIM  PDPPRLG CINDEX=4,FRAME=96,BASER=12,ENTRY=YES
         B     @@FEN4
         LTORG
@@FEN4   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG4    EQU   *
         LR    11,1
         L     10,=A(@@PGT4)
* FUNCTION fssTrim CODE
         L     3,0(11)
         ST    3,88(13)
         LA    1,88(,13)
         L     15,=V(STRLEN)
         BALR  14,15
         LTR   15,15
         BE    @@L111
         LR    2,15
         AR    2,3
         BCTR  2,0
@@L117   EQU   *
         CLI   0(2),64
         BNE   @@L111
         MVI   0(2),0
         BCTR  2,0
         BCTR  15,0
         LTR   15,15
         BNE   @@L117
@@L111   EQU   *
         LR    15,3
* FUNCTION fssTrim EPILOGUE
         PDPEPIL
* FUNCTION fssTrim LITERAL POOL
         DS    0F
         LTORG
* FUNCTION fssTrim PAGE TABLE
         DS    0F
@@PGT4   EQU   *
         DC    A(@@PG4)
         DS    0F
* X-FUNC fssInit PROLOGUE
FSSINIT  PDPPRLG CINDEX=5,FRAME=96,BASER=12,ENTRY=YES
         B     @@FEN5
         LTORG
@@FEN5   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG5    EQU   *
         LR    11,1
         L     10,=A(@@PGT5)
* FUNCTION fssInit CODE
         L     15,=A(@@8)
         MVC   0(4,15),=F'0'
         L     15,=A(@@10)
         MVC   0(4,15),=F'0'
         MVC   88(4,13),=F'1'
         LA    1,88(,13)
         L     15,=V(STFSMODE)
         BALR  14,15
         MVC   88(4,13),=F'1'
         LA    1,88(,13)
         L     15,=V(STTMPMD)
         BALR  14,15
         SLR   15,15
* FUNCTION fssInit EPILOGUE
         PDPEPIL
* FUNCTION fssInit LITERAL POOL
         DS    0F
         LTORG
* FUNCTION fssInit PAGE TABLE
         DS    0F
@@PGT5   EQU   *
         DC    A(@@PG5)
         DS    0F
* X-FUNC fssReset PROLOGUE
FSSRESET PDPPRLG CINDEX=6,FRAME=96,BASER=12,ENTRY=YES
         B     @@FEN6
         LTORG
@@FEN6   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG6    EQU   *
         LR    11,1
         L     10,=A(@@PGT6)
* FUNCTION fssReset CODE
         SLR   4,4
         L     3,=A(@@8)
         C     4,0(3)
         BNL   @@L130
         L     3,=A(@@9)
@@L128   EQU   *
         L     2,0(3)
         LTR   2,2
         BNE   @@L131
@@L126   EQU   *
         L     2,16(3)
         LTR   2,2
         BNE   @@L132
@@L124   EQU   *
         A     3,=F'20'
         A     4,=F'1'
         L     15,=A(@@8)
         C     4,0(15)
         BL    @@L128
         B     @@L130
@@L132   EQU   *
         ST    2,88(13)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         B     @@L124
@@L131   EQU   *
         ST    2,88(13)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         B     @@L126
@@L130   EQU   *
         L     3,=A(@@8)
         MVC   0(4,3),=F'0'
         L     15,=A(@@6)
         MVC   0(4,15),=F'0'
         L     4,=A(@@7)
         MVC   0(4,4),=F'0'
         L     3,=A(@@10)
         MVC   0(4,3),=F'0'
         SLR   15,15
* FUNCTION fssReset EPILOGUE
         PDPEPIL
* FUNCTION fssReset LITERAL POOL
         DS    0F
         LTORG
* FUNCTION fssReset PAGE TABLE
         DS    0F
@@PGT6   EQU   *
         DC    A(@@PG6)
         DS    0F
* X-FUNC fssTerm PROLOGUE
FSSTERM  PDPPRLG CINDEX=7,FRAME=96,BASER=12,ENTRY=YES
         B     @@FEN7
         LTORG
@@FEN7   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG7    EQU   *
         LR    11,1
         L     10,=A(@@PGT7)
* FUNCTION fssTerm CODE
         SLR   4,4
         L     3,=A(@@8)
         C     4,0(3)
         BNL   @@L143
         L     3,=A(@@9)
@@L140   EQU   *
         L     2,0(3)
         LTR   2,2
         BNE   @@L144
@@L138   EQU   *
         L     2,16(3)
         LTR   2,2
         BNE   @@L145
@@L136   EQU   *
         A     3,=F'20'
         A     4,=F'1'
         L     15,=A(@@8)
         C     4,0(15)
         BL    @@L140
         B     @@L143
@@L145   EQU   *
         ST    2,88(13)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         B     @@L136
@@L144   EQU   *
         ST    2,88(13)
         LA    1,88(,13)
         L     15,=V(FREE)
         BALR  14,15
         B     @@L138
@@L143   EQU   *
         L     4,=A(@@8)
         MVC   0(4,4),=F'0'
         L     3,=A(@@6)
         MVC   0(4,3),=F'0'
         L     15,=A(@@7)
         MVC   0(4,15),=F'0'
         L     4,=A(@@10)
         MVC   0(4,4),=F'0'
         SLR   3,3
         MVC   88(4,13),=F'1'
         LA    1,88(,13)
         L     15,=V(STLINENO)
         BALR  14,15
         ST    3,88(13)
         LA    1,88(,13)
         L     15,=V(STFSMODE)
         BALR  14,15
         ST    3,88(13)
         LA    1,88(,13)
         L     15,=V(STTMPMD)
         BALR  14,15
         LR    15,3
* FUNCTION fssTerm EPILOGUE
         PDPEPIL
* FUNCTION fssTerm LITERAL POOL
         DS    0F
         LTORG
* FUNCTION fssTerm PAGE TABLE
         DS    0F
@@PGT7   EQU   *
         DC    A(@@PG7)
         DS    0F
* X-FUNC fssGetAID PROLOGUE
FSSGETAI PDPPRLG CINDEX=8,FRAME=88,BASER=12,ENTRY=YES
         B     @@FEN8
         LTORG
@@FEN8   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG8    EQU   *
         LR    11,1
         L     10,=A(@@PGT8)
* FUNCTION fssGetAID CODE
         L     2,=A(@@6)
         L     15,0(2)
* FUNCTION fssGetAID EPILOGUE
         PDPEPIL
* FUNCTION fssGetAID LITERAL POOL
         DS    0F
         LTORG
* FUNCTION fssGetAID PAGE TABLE
         DS    0F
@@PGT8   EQU   *
         DC    A(@@PG8)
         DS    0F
* X-FUNC fssAttr PROLOGUE
FSSATTR  PDPPRLG CINDEX=9,FRAME=96,BASER=12,ENTRY=YES
         B     @@FEN9
         LTORG
@@FEN9   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG9    EQU   *
         LR    11,1
         L     10,=A(@@PGT9)
* FUNCTION fssAttr CODE
         L     15,0(11)
         LR    3,15
         N     3,=F'16776960'
         N     15,=F'255'
         ST    15,88(13)
         LA    1,88(,13)
         L     15,=V(XLATE327)
         BALR  14,15
         OR    3,15
         LR    15,3
* FUNCTION fssAttr EPILOGUE
         PDPEPIL
* FUNCTION fssAttr LITERAL POOL
         DS    0F
         LTORG
* FUNCTION fssAttr PAGE TABLE
         DS    0F
@@PGT9   EQU   *
         DC    A(@@PG9)
         DS    0F
* X-FUNC fssTxt PROLOGUE
FSSTXT   PDPPRLG CINDEX=10,FRAME=96,BASER=12,ENTRY=YES
         B     @@FEN10
         LTORG
@@FEN10  EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG10   EQU   *
         LR    11,1
         L     10,=A(@@PGT10)
* FUNCTION fssTxt CODE
         L     7,0(11)
         L     8,4(11)
         L     9,8(11)
         L     5,12(11)
         LR    4,5
         IC    2,0(5)
         CLM   2,1,=XL1'00'
         BE    @@L159
         L     15,=V(@@ISBUF)
@@L153   EQU   *
         N     2,=XL4'000000FF'
         L     3,0(15)
         MH    2,=H'2'
         LH    6,0(2,3)
         N     6,=F'64'
         CH    6,=H'0'
         BNE   @@L152
         MVI   0(4),75
@@L152   EQU   *
         A     4,=F'1'
         IC    2,0(4)
         CLM   2,1,=XL1'00'
         BNE   @@L153
@@L159   EQU   *
         ST    5,88(13)
         LA    1,88(,13)
         L     15,=V(STRLEN)
         BALR  14,15
         LR    6,15
         LTR   7,7
         BNH   @@L156
         LA    3,1(0,0)
         CR    8,3
         BNH   @@L156
         LA    2,24(0,0)
         CR    7,2
         BH    @@L156
         LA    15,80(0,0)
         CR    8,15
         BNH   @@L155
@@L156   EQU   *
         L     15,=F'-1'
         B     @@L148
@@L155   EQU   *
         LR    3,6
         BCTR  3,0
         L     15,=F'-2'
         LA    4,78(0,0)
         CLR   3,4
         BH    @@L148
         L     15,=A(@@8)
         L     3,0(15)
         LR    4,3
         A     3,=F'1'
         ST    3,0(15)
         L     15,=A(@@9)
         LR    3,4
         SLL   3,2
         AR    3,4
         SLL   3,2
         SLR   4,4
         ST    4,0(3,15)
         AR    3,15
         LR    15,7
         SLL   15,2
         AR    15,7
         SLL   15,4
         AR    15,8
         A     15,=F'-81'
         ST    15,4(3)
         A     3,=F'8'
         LR    7,9
         N     7,=F'255'
         ST    7,88(13)
         LA    1,88(,13)
         L     15,=V(XLATE327)
         BALR  14,15
         N     9,=F'16776960'
         OR    9,15
         ST    9,0(3)
         A     3,=F'-8'
         ST    6,12(3)
         A     3,=F'16'
         A     6,=F'1'
         ST    6,88(13)
         LA    1,88(,13)
         L     15,=V(MALLOC)
         BALR  14,15
         ST    15,0(3)
         ST    15,88(13)
         ST    5,92(13)
         LA    1,88(,13)
         L     15,=V(STRCPY)
         BALR  14,15
         LR    15,4
@@L148   EQU   *
* FUNCTION fssTxt EPILOGUE
         PDPEPIL
* FUNCTION fssTxt LITERAL POOL
         DS    0F
         LTORG
* FUNCTION fssTxt PAGE TABLE
         DS    0F
@@PGT10  EQU   *
         DC    A(@@PG10)
         DS    0F
* X-FUNC fssFld PROLOGUE
FSSFLD   PDPPRLG CINDEX=11,FRAME=112,BASER=12,ENTRY=YES
         B     @@FEN11
         LTORG
@@FEN11  EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG11   EQU   *
         LR    11,1
         L     10,=A(@@PGT11)
* FUNCTION fssFld CODE
         L     4,0(11)
         L     5,4(11)
         L     7,8(11)
         L     8,12(11)
         L     6,16(11)
         L     9,20(11)
         LTR   4,4
         BNH   @@L162
         LA    3,1(0,0)
         CR    5,3
         BNH   @@L162
         LA    2,24(0,0)
         CR    4,2
         BH    @@L162
         LA    3,80(0,0)
         CR    5,3
         BNH   @@L161
@@L162   EQU   *
         L     15,=F'-1'
         B     @@L160
@@L161   EQU   *
         LR    2,6
         BCTR  2,0
         L     15,=F'-2'
         LA    3,78(0,0)
         CLR   2,3
         BH    @@L160
         L     3,=A(@@8)
         L     2,0(3)
         SLR   3,3
         LTR   2,2
         BNH   @@L166
         SLR   3,3
         CR    3,2
         BNL   @@L182
         L     2,=A(@@9)
@@L172   EQU   *
         ST    8,88(13)
         MVC   92(4,13),0(2)
         LA    1,88(,13)
         L     15,=V(STRCMP)
         BALR  14,15
         LTR   15,15
         BE    @@L185
         A     2,=F'20'
         A     3,=F'1'
         L     15,=A(@@8)
         C     3,0(15)
         BL    @@L172
@@L182   EQU   *
         SLR   3,3
@@L166   EQU   *
         L     15,=F'-3'
         LTR   3,3
         BNE   @@L160
         L     15,=A(@@8)
         L     3,0(15)
         A     3,=F'1'
         ST    3,104(13)
         ST    3,0(15)
         BCTR  3,0
         ST    3,104(13)
         L     2,=A(@@9)
         SLL   3,2
         ST    3,108(13)
         A     3,104(13)
         SLL   3,2
         ST    8,88(13)
         LA    1,88(,13)
         L     15,=V(STRLEN)
         BALR  14,15
         A     15,=F'1'
         ST    15,88(13)
         LA    1,88(,13)
         L     15,=V(MALLOC)
         BALR  14,15
         ST    15,0(3,2)
         ST    15,88(13)
         ST    8,92(13)
         LA    1,88(,13)
         L     15,=V(STRCPY)
         BALR  14,15
         AR    3,2
         LR    8,4
         SLL   8,2
         AR    8,4
         SLL   8,4
         AR    8,5
         A     8,=F'-81'
         ST    8,4(3)
         A     3,=F'8'
         LR    4,7
         N     4,=F'255'
         ST    4,88(13)
         LA    1,88(,13)
         L     15,=V(XLATE327)
         BALR  14,15
         N     7,=F'16776960'
         OR    7,15
         ST    7,0(3)
         A     3,=F'-8'
         ST    6,12(3)
         A     3,=F'16'
         A     6,=F'1'
         ST    6,88(13)
         LA    1,88(,13)
         L     15,=V(MALLOC)
         BALR  14,15
         ST    15,0(3)
         LR    4,9
         IC    2,0(9)
         CLM   2,1,=XL1'00'
         BE    @@L184
         L     5,=V(@@ISBUF)
@@L177   EQU   *
         N     2,=XL4'000000FF'
         L     7,0(5)
         MH    2,=H'2'
         LH    6,0(2,7)
         N     6,=F'64'
         CH    6,=H'0'
         BNE   @@L176
         MVI   0(4),75
@@L176   EQU   *
         A     4,=F'1'
         IC    2,0(4)
         CLM   2,1,=XL1'00'
         BNE   @@L177
@@L184   EQU   *
         ST    9,88(13)
         LA    1,88(,13)
         L     15,=V(STRLEN)
         BALR  14,15
         L     2,108(13)
         A     2,104(13)
         SLL   2,2
         A     2,=A(@@9)
         LR    5,2
         A     5,=F'12'
         L     4,0(5)
         CLR   15,4
         BH    @@L179
         MVC   88(4,13),16(2)
         ST    9,92(13)
         LA    1,88(,13)
         L     15,=V(STRCPY)
         BALR  14,15
@@L180   EQU   *
         SLR   15,15
         B     @@L160
@@L179   EQU   *
         A     2,=F'16'
         MVC   88(4,13),0(2)
         ST    9,92(13)
         ST    4,96(13)
         LA    1,88(,13)
         L     15,=V(STRNCPY)
         BALR  14,15
         L     8,0(2)
         L     9,0(5)
         SLR   4,4
         STC   4,0(9,8)
         B     @@L180
@@L185   EQU   *
         A     3,=F'1'
         B     @@L166
@@L160   EQU   *
* FUNCTION fssFld EPILOGUE
         PDPEPIL
* FUNCTION fssFld LITERAL POOL
         DS    0F
         LTORG
* FUNCTION fssFld PAGE TABLE
         DS    0F
@@PGT11  EQU   *
         DC    A(@@PG11)
         DS    0F
* X-FUNC fssSetField PROLOGUE
FSSSETFI PDPPRLG CINDEX=12,FRAME=104,BASER=12,ENTRY=YES
         B     @@FEN12
         LTORG
@@FEN12  EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG12   EQU   *
         LR    11,1
         L     10,=A(@@PGT12)
* FUNCTION fssSetField CODE
         L     5,0(11)
         L     6,4(11)
         L     4,=A(@@8)
         L     2,0(4)
         SLR   3,3
         LTR   2,2
         BNH   @@L188
         SLR   3,3
         CR    3,2
         BNL   @@L205
         L     2,=A(@@9)
@@L194   EQU   *
         ST    5,88(13)
         MVC   92(4,13),0(2)
         LA    1,88(,13)
         L     15,=V(STRCMP)
         BALR  14,15
         LTR   15,15
         BE    @@L208
         A     2,=F'20'
         A     3,=F'1'
         C     3,0(4)
         BL    @@L194
@@L205   EQU   *
         SLR   3,3
@@L188   EQU   *
         LR    4,3
         L     15,=F'-4'
         LTR   3,3
         BE    @@L186
         BCTR  4,0
         LR    15,6
         IC    2,0(6)
         CLM   2,1,=XL1'00'
         BE    @@L207
         L     5,=V(@@ISBUF)
@@L200   EQU   *
         N     2,=XL4'000000FF'
         L     3,0(5)
         MH    2,=H'2'
         LH    2,0(2,3)
         N     2,=F'64'
         CH    2,=H'0'
         BNE   @@L199
         MVI   0(15),75
@@L199   EQU   *
         A     15,=F'1'
         IC    2,0(15)
         CLM   2,1,=XL1'00'
         BNE   @@L200
@@L207   EQU   *
         ST    6,88(13)
         LA    1,88(,13)
         L     15,=V(STRLEN)
         BALR  14,15
         LR    2,4
         SLL   2,2
         AR    2,4
         SLL   2,2
         A     2,=A(@@9)
         LR    4,2
         A     4,=F'12'
         L     3,0(4)
         CLR   15,3
         BH    @@L202
         MVC   88(4,13),16(2)
         ST    6,92(13)
         LA    1,88(,13)
         L     15,=V(STRCPY)
         BALR  14,15
@@L203   EQU   *
         SLR   15,15
         B     @@L186
@@L202   EQU   *
         A     2,=F'16'
         MVC   88(4,13),0(2)
         ST    6,92(13)
         ST    3,96(13)
         LA    1,88(,13)
         L     15,=V(STRNCPY)
         BALR  14,15
         L     6,0(2)
         L     5,0(4)
         SLR   4,4
         STC   4,0(5,6)
         B     @@L203
@@L208   EQU   *
         A     3,=F'1'
         B     @@L188
@@L186   EQU   *
* FUNCTION fssSetField EPILOGUE
         PDPEPIL
* FUNCTION fssSetField LITERAL POOL
         DS    0F
         LTORG
* FUNCTION fssSetField PAGE TABLE
         DS    0F
@@PGT12  EQU   *
         DC    A(@@PG12)
         DS    0F
* X-FUNC fssGetField PROLOGUE
FSSGETFI PDPPRLG CINDEX=13,FRAME=96,BASER=12,ENTRY=YES
         B     @@FEN13
         LTORG
@@FEN13  EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG13   EQU   *
         LR    11,1
         L     10,=A(@@PGT13)
* FUNCTION fssGetField CODE
         L     5,0(11)
         L     4,=A(@@8)
         L     2,0(4)
         SLR   3,3
         LTR   2,2
         BNH   @@L211
         SLR   3,3
         CR    3,2
         BNL   @@L220
         L     2,=A(@@9)
@@L217   EQU   *
         ST    5,88(13)
         MVC   92(4,13),0(2)
         LA    1,88(,13)
         L     15,=V(STRCMP)
         BALR  14,15
         LTR   15,15
         BE    @@L221
         A     2,=F'20'
         A     3,=F'1'
         C     3,0(4)
         BL    @@L217
@@L220   EQU   *
         SLR   3,3
@@L211   EQU   *
         LR    15,3
         LTR   3,3
         BE    @@L209
         LR    4,3
         SLL   4,2
         AR    4,3
         SLL   4,2
         A     4,=A(@@9-4)
         L     15,0(4)
         B     @@L209
@@L221   EQU   *
         A     3,=F'1'
         B     @@L211
@@L209   EQU   *
* FUNCTION fssGetField EPILOGUE
         PDPEPIL
* FUNCTION fssGetField LITERAL POOL
         DS    0F
         LTORG
* FUNCTION fssGetField PAGE TABLE
         DS    0F
@@PGT13  EQU   *
         DC    A(@@PG13)
         DS    0F
* X-FUNC fssSetCursor PROLOGUE
FSSSETCU PDPPRLG CINDEX=14,FRAME=96,BASER=12,ENTRY=YES
         B     @@FEN14
         LTORG
@@FEN14  EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG14   EQU   *
         LR    11,1
         L     10,=A(@@PGT14)
* FUNCTION fssSetCursor CODE
         L     5,0(11)
         L     15,=A(@@8)
         L     3,0(15)
         SLR   4,4
         LTR   3,3
         BNH   @@L224
         SLR   2,2
         CR    2,3
         BNL   @@L233
         L     3,=A(@@9)
         LR    4,15
@@L230   EQU   *
         ST    5,88(13)
         MVC   92(4,13),0(3)
         LA    1,88(,13)
         L     15,=V(STRCMP)
         BALR  14,15
         LTR   15,15
         BE    @@L234
         A     3,=F'20'
         A     2,=F'1'
         C     2,0(4)
         BL    @@L230
@@L233   EQU   *
         SLR   4,4
@@L224   EQU   *
         L     15,=F'-1'
         LTR   4,4
         BE    @@L222
         LR    2,4
         SLL   2,2
         AR    2,4
         SLL   2,2
         A     2,=A(@@9-16)
         L     4,0(2)
         SRA   4,6
         N     4,=F'63'
         ST    4,88(13)
         LA    1,88(,13)
         L     15,=V(XLATE327)
         BALR  14,15
         LR    5,15
         SLL   5,8
         L     3,0(2)
         N     3,=F'63'
         ST    3,88(13)
         LA    1,88(,13)
         L     15,=V(XLATE327)
         BALR  14,15
         L     4,=A(@@10)
         OR    5,15
         ST    5,0(4)
         SLR   15,15
         B     @@L222
@@L234   EQU   *
         LR    4,2
         A     4,=F'1'
         B     @@L224
@@L222   EQU   *
* FUNCTION fssSetCursor EPILOGUE
         PDPEPIL
* FUNCTION fssSetCursor LITERAL POOL
         DS    0F
         LTORG
* FUNCTION fssSetCursor PAGE TABLE
         DS    0F
@@PGT14  EQU   *
         DC    A(@@PG14)
         DS    0F
* X-FUNC fssSetAttr PROLOGUE
FSSSETAT PDPPRLG CINDEX=15,FRAME=96,BASER=12,ENTRY=YES
         B     @@FEN15
         LTORG
@@FEN15  EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG15   EQU   *
         LR    11,1
         L     10,=A(@@PGT15)
* FUNCTION fssSetAttr CODE
         L     6,0(11)
         L     5,4(11)
         L     15,=A(@@8)
         L     3,0(15)
         SLR   4,4
         LTR   3,3
         BNH   @@L237
         SLR   2,2
         CR    2,3
         BNL   @@L246
         L     3,=A(@@9)
         LR    4,15
@@L243   EQU   *
         ST    6,88(13)
         MVC   92(4,13),0(3)
         LA    1,88(,13)
         L     15,=V(STRCMP)
         BALR  14,15
         LTR   15,15
         BE    @@L247
         A     3,=F'20'
         A     2,=F'1'
         C     2,0(4)
         BL    @@L243
@@L246   EQU   *
         SLR   4,4
@@L237   EQU   *
         L     15,=F'-1'
         LTR   4,4
         BE    @@L235
         LR    6,4
         SLL   6,2
         AR    6,4
         SLL   6,2
         A     6,=A(@@9-12)
         LR    2,5
         N     2,=F'255'
         ST    2,88(13)
         LA    1,88(,13)
         L     15,=V(XLATE327)
         BALR  14,15
         N     5,=F'16776960'
         OR    5,15
         ST    5,0(6)
         SLR   15,15
         B     @@L235
@@L247   EQU   *
         LR    4,2
         A     4,=F'1'
         B     @@L237
@@L235   EQU   *
* FUNCTION fssSetAttr EPILOGUE
         PDPEPIL
* FUNCTION fssSetAttr LITERAL POOL
         DS    0F
         LTORG
* FUNCTION fssSetAttr PAGE TABLE
         DS    0F
@@PGT15  EQU   *
         DC    A(@@PG15)
         DS    0F
* X-FUNC fssSetColor PROLOGUE
FSSSETCO PDPPRLG CINDEX=16,FRAME=96,BASER=12,ENTRY=YES
         B     @@FEN16
         LTORG
@@FEN16  EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG16   EQU   *
         LR    11,1
         L     10,=A(@@PGT16)
* FUNCTION fssSetColor CODE
         L     6,0(11)
         L     5,4(11)
         L     15,=A(@@8)
         L     3,0(15)
         SLR   4,4
         LTR   3,3
         BNH   @@L250
         SLR   2,2
         CR    2,3
         BNL   @@L259
         L     3,=A(@@9)
         LR    4,15
@@L256   EQU   *
         ST    6,88(13)
         MVC   92(4,13),0(3)
         LA    1,88(,13)
         L     15,=V(STRCMP)
         BALR  14,15
         LTR   15,15
         BE    @@L260
         A     3,=F'20'
         A     2,=F'1'
         C     2,0(4)
         BL    @@L256
@@L259   EQU   *
         SLR   4,4
@@L250   EQU   *
         L     15,=F'-1'
         LTR   4,4
         BE    @@L248
         LR    6,4
         SLL   6,2
         AR    6,4
         SLL   6,2
         A     6,=A(@@9-12)
         L     2,0(6)
         N     2,=F'16711935'
         N     5,=F'65280'
         OR    2,5
         ST    2,0(6)
         SLR   15,15
         B     @@L248
@@L260   EQU   *
         LR    4,2
         A     4,=F'1'
         B     @@L250
@@L248   EQU   *
* FUNCTION fssSetColor EPILOGUE
         PDPEPIL
* FUNCTION fssSetColor LITERAL POOL
         DS    0F
         LTORG
* FUNCTION fssSetColor PAGE TABLE
         DS    0F
@@PGT16  EQU   *
         DC    A(@@PG16)
         DS    0F
* X-FUNC fssSetXH PROLOGUE
FSSSETXH PDPPRLG CINDEX=17,FRAME=96,BASER=12,ENTRY=YES
         B     @@FEN17
         LTORG
@@FEN17  EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG17   EQU   *
         LR    11,1
         L     10,=A(@@PGT17)
* FUNCTION fssSetXH CODE
         L     6,0(11)
         L     5,4(11)
         L     15,=A(@@8)
         L     3,0(15)
         SLR   4,4
         LTR   3,3
         BNH   @@L263
         SLR   2,2
         CR    2,3
         BNL   @@L272
         L     3,=A(@@9)
         LR    4,15
@@L269   EQU   *
         ST    6,88(13)
         MVC   92(4,13),0(3)
         LA    1,88(,13)
         L     15,=V(STRCMP)
         BALR  14,15
         LTR   15,15
         BE    @@L273
         A     3,=F'20'
         A     2,=F'1'
         C     2,0(4)
         BL    @@L269
@@L272   EQU   *
         SLR   4,4
@@L263   EQU   *
         L     15,=F'-1'
         LTR   4,4
         BE    @@L261
         LR    6,4
         SLL   6,2
         AR    6,4
         SLL   6,2
         A     6,=A(@@9-12)
         LH    3,2(6)
         N     3,=XL4'0000FFFF'
         N     5,=F'16711680'
         OR    3,5
         ST    3,0(6)
         SLR   15,15
         B     @@L261
@@L273   EQU   *
         LR    4,2
         A     4,=F'1'
         B     @@L263
@@L261   EQU   *
* FUNCTION fssSetXH EPILOGUE
         PDPEPIL
* FUNCTION fssSetXH LITERAL POOL
         DS    0F
         LTORG
* FUNCTION fssSetXH PAGE TABLE
         DS    0F
@@PGT17  EQU   *
         DC    A(@@PG17)
         DS    0F
@@9      EQU   *
         DC    20480X'00'
         DS    0F
@@8      EQU   *
         DC    4X'00'
         DS    0F
@@6      EQU   *
         DC    4X'00'
         DS    0F
@@7      EQU   *
         DC    4X'00'
         DS    0F
@@10     EQU   *
         DC    4X'00'
         DS    0F
* S-FUNC doInput PROLOGUE
@@5      PDPPRLG CINDEX=18,FRAME=104,BASER=12,ENTRY=NO
         B     @@FEN18
         LTORG
@@FEN18  EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG18   EQU   *
         LR    11,1
         L     10,=A(@@PGT18)
* FUNCTION doInput CODE
         L     5,0(11)
         L     6,4(11)
         LR    15,5
         LA    3,2(0,0)
         CR    6,3
         BH    @@L2
         L     4,=A(@@6)
         MVC   0(4,4),=F'0'
         L     3,=A(@@7)
         MVC   0(4,3),=F'0'
         L     15,=F'-1'
         B     @@L1
@@L2     EQU   *
         SLR   2,2
         IC    2,0(5)
         L     7,=A(@@6)
         ST    2,0(7)
         A     15,=F'1'
         SLR   8,8
         IC    8,0(15)
         SLL   8,8
         SLR   4,4
         IC    4,1(15)
         AR    8,4
         LR    9,8
         N     9,=F'16128'
         SRA   9,2
         N     8,=F'63'
         L     7,=A(@@7)
         OR    8,9
         ST    8,0(7)
         LR    15,5
         A     15,=F'3'
         LR    8,6
         A     8,=F'-3'
         LA    2,3(0,0)
         CR    8,2
         BNH   @@L275
@@L24    EQU   *
         CLI   0(15),17
         BNE   @@L279
         A     15,=F'1'
         SLR   9,9
         IC    9,0(15)
         SLL   9,8
         SLR   5,5
         IC    5,1(15)
         AR    9,5
         LR    6,9
         N     6,=F'16128'
         SRA   6,2
         LR    5,9
         N     5,=F'63'
         OR    5,6
         A     15,=F'2'
         A     8,=F'-3'
         ST    15,92(13)
         BE    @@L8
         CLI   0(15),17
         BE    @@L8
@@L11    EQU   *
         A     15,=F'1'
         BCTR  8,0
         LTR   8,8
         BE    @@L8
         IC    2,0(15)
         SLL   2,24
         SRA   2,24
         C     2,=F'17'
         BNE   @@L11
@@L8     EQU   *
         LR    3,15
         S     3,92(13)
         ST    3,88(13)
         L     4,=A(@@8)
         L     3,0(4)
         SLR   2,2
         LTR   3,3
         BNH   @@L13
         SLR   2,2
         CR    2,3
         BNL   @@L278
         LR    4,3
         L     3,=A(@@9+4)
@@L19    EQU   *
         C     5,0(3)
         BE    @@L280
         A     3,=F'20'
         A     2,=F'1'
         CR    2,4
         BL    @@L19
@@L278   EQU   *
         SLR   2,2
@@L13    EQU   *
         LTR   2,2
         BE    @@L3
         BCTR  2,0
         LR    3,2
         SLL   3,2
         AR    3,2
         SLL   3,2
         A     3,=A(@@9)
         LR    2,3
         A     2,=F'12'
         ST    2,96(13)
         L     9,0(2)
         L     4,88(13)
         CR    4,9
         BH    @@L22
         A     2,=F'4'
         L     6,0(2)
         LR    7,4
         L     4,92(13)
         LR    5,7
         MVCL  6,4
         L     6,0(2)
         SLR   4,4
         L     7,88(13)
         STC   4,0(7,6)
@@L3     EQU   *
         LA    4,3(0,0)
         CR    8,4
         BH    @@L24
@@L275   EQU   *
         SLR   15,15
         B     @@L1
@@L22    EQU   *
         LR    2,3
         A     2,=F'16'
         L     6,0(2)
         LR    7,9
         L     4,92(13)
         LR    5,9
         MVCL  6,4
         L     5,0(2)
         L     2,96(13)
         L     9,0(2)
         SLR   4,4
         STC   4,0(9,5)
         B     @@L3
@@L280   EQU   *
         A     2,=F'1'
         B     @@L13
@@L279   EQU   *
         L     15,=F'-2'
@@L1     EQU   *
* FUNCTION doInput EPILOGUE
         PDPEPIL
* FUNCTION doInput LITERAL POOL
         DS    0F
         LTORG
* FUNCTION doInput PAGE TABLE
         DS    0F
@@PGT18  EQU   *
         DC    A(@@PG18)
         END
./ ADD NAME=SVC
********************************************
* GCC version
* struct REGS
* {
*   unsigned int R0;
*   unsigned int R1;
*   unsigned int R15;
* };
* void EXSVC(int svc, struct REGS *regs);
********************************************
         COPY  PDPTOP
         CSECT
* Program text area
         DS    0F
* X-func EXSVC prologue
EXSVC    PDPPRLG CINDEX=0,FRAME=88,BASER=12,ENTRY=YES
         B     @@FEN0
         LTORG
@@FEN0   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG0    EQU   *
         LR    11,1
         L     10,=A(@@PGT0)
* Function EXSVC code
* Initialize registers
         L     2,0(11) *  svc
         L     3,4(11) *  regs
         L     0,0(3)  *  regs->R0
         L     1,4(3)  *  regs->R1
         L     15,8(3) *  regs->R15
* Execute service
         EX    2,DOSVC
* Return registers
         ST    0,0(3)  *  regs->R0
         ST    1,4(3)  *  regs->R1
         ST    15,8(3) *  regs->R15
         L     15,0
* Function EXSVC epilogue
         PDPEPIL
* Function EXSVC literal pool
         DS    0F
         LTORG
         DS    0F
DOSVC    SVC   0         * Executed Instruction
* Function EXSVC page table
         DS    0F
@@PGT0   EQU   *
         DC    A(@@PG0)
         END
./ ADD NAME=TSO
         COPY  PDPTOP
         CSECT
* Program text area
         DS    0F
* X-FUNC tput PROLOGUE
TPUT     PDPPRLG CINDEX=0,FRAME=112,BASER=12,ENTRY=YES
         B     @@FEN0
         LTORG
@@FEN0   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG0    EQU   *
         LR    11,1
         L     10,=A(@@PGT0)
* FUNCTION tput CODE
         MVC   96(4,13),4(11)
         L     15,0(11)
         N     15,=F'16777215'
         ST    15,100(13)
         MVC   88(4,13),=F'93'
         LA    15,96(,13)
         ST    15,92(13)
         LA    1,88(,13)
         L     15,=V(EXSVC)
         BALR  14,15
* FUNCTION tput EPILOGUE
         PDPEPIL
* FUNCTION tput LITERAL POOL
         DS    0F
         LTORG
* FUNCTION tput PAGE TABLE
         DS    0F
@@PGT0   EQU   *
         DC    A(@@PG0)
         DS    0F
* X-FUNC tget PROLOGUE
TGET     PDPPRLG CINDEX=1,FRAME=112,BASER=12,ENTRY=YES
         B     @@FEN1
         LTORG
@@FEN1   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG1    EQU   *
         LR    11,1
         L     10,=A(@@PGT1)
* FUNCTION tget CODE
         L     15,0(11)
         MVC   96(4,13),4(11)
         N     15,=F'16777215'
         O     15,=F'-2147483648'
         ST    15,100(13)
         MVC   88(4,13),=F'93'
         LA    15,96(,13)
         ST    15,92(13)
         LA    1,88(,13)
         L     15,=V(EXSVC)
         BALR  14,15
         L     15,100(13)
* FUNCTION tget EPILOGUE
         PDPEPIL
* FUNCTION tget LITERAL POOL
         DS    0F
         LTORG
* FUNCTION tget PAGE TABLE
         DS    0F
@@PGT1   EQU   *
         DC    A(@@PG1)
         DS    0F
* X-FUNC stfsmode PROLOGUE
STFSMODE PDPPRLG CINDEX=2,FRAME=112,BASER=12,ENTRY=YES
         B     @@FEN2
         LTORG
@@FEN2   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG2    EQU   *
         LR    11,1
         L     10,=A(@@PGT2)
* FUNCTION stfsmode CODE
         L     2,0(11)
         MVC   96(4,13),=F'301989888'
         LTR   2,2
         BE    @@L4
         MVC   100(4,13),=F'-1073741824'
         B     @@L5
@@L4     EQU   *
         ST    2,100(13)
@@L5     EQU   *
         MVC   88(4,13),=F'94'
         LA    15,96(,13)
         ST    15,92(13)
         LA    1,88(,13)
         L     15,=V(EXSVC)
         BALR  14,15
* FUNCTION stfsmode EPILOGUE
         PDPEPIL
* FUNCTION stfsmode LITERAL POOL
         DS    0F
         LTORG
* FUNCTION stfsmode PAGE TABLE
         DS    0F
@@PGT2   EQU   *
         DC    A(@@PG2)
         DS    0F
* X-FUNC sttmpmd PROLOGUE
STTMPMD  PDPPRLG CINDEX=3,FRAME=112,BASER=12,ENTRY=YES
         B     @@FEN3
         LTORG
@@FEN3   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG3    EQU   *
         LR    11,1
         L     10,=A(@@PGT3)
* FUNCTION sttmpmd CODE
         L     2,0(11)
         MVC   96(4,13),=F'335544320'
         LTR   2,2
         BE    @@L7
         MVC   100(4,13),=F'-2147483648'
         B     @@L8
@@L7     EQU   *
         ST    2,100(13)
@@L8     EQU   *
         MVC   88(4,13),=F'94'
         LA    15,96(,13)
         ST    15,92(13)
         LA    1,88(,13)
         L     15,=V(EXSVC)
         BALR  14,15
* FUNCTION sttmpmd EPILOGUE
         PDPEPIL
* FUNCTION sttmpmd LITERAL POOL
         DS    0F
         LTORG
* FUNCTION sttmpmd PAGE TABLE
         DS    0F
@@PGT3   EQU   *
         DC    A(@@PG3)
         DS    0F
* X-FUNC stlineno PROLOGUE
STLINENO PDPPRLG CINDEX=4,FRAME=112,BASER=12,ENTRY=YES
         B     @@FEN4
         LTORG
@@FEN4   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG4    EQU   *
         LR    11,1
         L     10,=A(@@PGT4)
* FUNCTION stlineno CODE
         MVC   96(4,13),=F'318767104'
         MVC   100(4,13),0(11)
         MVC   88(4,13),=F'94'
         LA    15,96(,13)
         ST    15,92(13)
         LA    1,88(,13)
         L     15,=V(EXSVC)
         BALR  14,15
* FUNCTION stlineno EPILOGUE
         PDPEPIL
* FUNCTION stlineno LITERAL POOL
         DS    0F
         LTORG
* FUNCTION stlineno PAGE TABLE
         DS    0F
@@PGT4   EQU   *
         DC    A(@@PG4)
         DS    0F
* X-FUNC tput_fullscr PROLOGUE
TPUT@FUL PDPPRLG CINDEX=5,FRAME=112,BASER=12,ENTRY=YES
         B     @@FEN5
         LTORG
@@FEN5   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG5    EQU   *
         LR    11,1
         L     10,=A(@@PGT5)
* FUNCTION tput_fullscr CODE
         L     15,0(11)
         MVC   96(4,13),4(11)
         N     15,=F'16777215'
         O     15,=F'50331648'
         ST    15,100(13)
         MVC   88(4,13),=F'93'
         LA    15,96(,13)
         ST    15,92(13)
         LA    1,88(,13)
         L     15,=V(EXSVC)
         BALR  14,15
         L     15,104(13)
* FUNCTION tput_fullscr EPILOGUE
         PDPEPIL
* FUNCTION tput_fullscr LITERAL POOL
         DS    0F
         LTORG
* FUNCTION tput_fullscr PAGE TABLE
         DS    0F
@@PGT5   EQU   *
         DC    A(@@PG5)
         DS    0F
* X-FUNC tget_asis PROLOGUE
TGET@ASI PDPPRLG CINDEX=6,FRAME=112,BASER=12,ENTRY=YES
         B     @@FEN6
         LTORG
@@FEN6   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG6    EQU   *
         LR    11,1
         L     10,=A(@@PGT6)
* FUNCTION tget_asis CODE
         L     15,0(11)
         MVC   96(4,13),4(11)
         N     15,=F'16777215'
         O     15,=F'-2130706432'
         ST    15,100(13)
         MVC   88(4,13),=F'93'
         LA    15,96(,13)
         ST    15,92(13)
         LA    1,88(,13)
         L     15,=V(EXSVC)
         BALR  14,15
         L     15,100(13)
* FUNCTION tget_asis EPILOGUE
         PDPEPIL
* FUNCTION tget_asis LITERAL POOL
         DS    0F
         LTORG
* FUNCTION tget_asis PAGE TABLE
         DS    0F
@@PGT6   EQU   *
         DC    A(@@PG6)
         DS    0F
* X-FUNC getBufOffset PROLOGUE
GETBUFOF PDPPRLG CINDEX=7,FRAME=88,BASER=12,ENTRY=YES
         B     @@FEN7
         LTORG
@@FEN7   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG7    EQU   *
         LR    11,1
         L     10,=A(@@PGT7)
* FUNCTION getBufOffset CODE
         L     15,0(11)
         LR    2,15
         N     2,=F'16128'
         SRA   2,2
         N     15,=F'63'
         OR    15,2
* FUNCTION getBufOffset EPILOGUE
         PDPEPIL
* FUNCTION getBufOffset LITERAL POOL
         DS    0F
         LTORG
* FUNCTION getBufOffset PAGE TABLE
         DS    0F
@@PGT7   EQU   *
         DC    A(@@PG7)
* Program data area
@@0      EQU   *
         DC    X'40'
         DC    X'C1'
         DC    X'C2'
         DC    X'C3'
         DC    X'C4'
         DC    X'C5'
         DC    X'C6'
         DC    X'C7'
         DC    X'C8'
         DC    X'C9'
         DC    X'4A'
         DC    X'4B'
         DC    X'4C'
         DC    X'4D'
         DC    X'4E'
         DC    X'4F'
         DC    X'50'
         DC    X'D1'
         DC    X'D2'
         DC    X'D3'
         DC    X'D4'
         DC    X'D5'
         DC    X'D6'
         DC    X'D7'
         DC    X'D8'
         DC    X'D9'
         DC    X'5A'
         DC    X'5B'
         DC    X'5C'
         DC    X'5D'
         DC    X'5E'
         DC    X'5F'
         DC    X'60'
         DC    X'61'
         DC    X'E2'
         DC    X'E3'
         DC    X'E4'
         DC    X'E5'
         DC    X'E6'
         DC    X'E7'
         DC    X'E8'
         DC    X'E9'
         DC    X'6A'
         DC    X'6B'
         DC    X'6C'
         DC    X'6D'
         DC    X'6E'
         DC    X'6F'
         DC    X'F0'
         DC    X'F1'
         DC    X'F2'
         DC    X'F3'
         DC    X'F4'
         DC    X'F5'
         DC    X'F6'
         DC    X'F7'
         DC    X'F8'
         DC    X'F9'
         DC    X'7A'
         DC    X'7B'
         DC    X'7C'
         DC    X'7D'
         DC    X'7E'
         DC    X'7F'
* Program text area
         DS    0F
* X-FUNC xlate3270 PROLOGUE
XLATE327 PDPPRLG CINDEX=8,FRAME=88,BASER=12,ENTRY=YES
         B     @@FEN8
         LTORG
@@FEN8   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG8    EQU   *
         LR    11,1
         L     10,=A(@@PGT8)
* FUNCTION xlate3270 CODE
         L     3,0(11)
         SLR   15,15
         LA    2,63(0,0)
         CLR   3,2
         BH    @@L13
         L     2,=A(@@0)
         SLR   15,15
         IC    15,0(2,3)
@@L13    EQU   *
* FUNCTION xlate3270 EPILOGUE
         PDPEPIL
* FUNCTION xlate3270 LITERAL POOL
         DS    0F
         LTORG
* FUNCTION xlate3270 PAGE TABLE
         DS    0F
@@PGT8   EQU   *
         DC    A(@@PG8)
         DS    0F
* X-FUNC getBufAddr PROLOGUE
GETBUFAD PDPPRLG CINDEX=9,FRAME=88,BASER=12,ENTRY=YES
         B     @@FEN9
         LTORG
@@FEN9   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG9    EQU   *
         LR    11,1
         L     10,=A(@@PGT9)
* FUNCTION getBufAddr CODE
         L     15,0(11)
         L     4,4(11)
         LR    2,15
         BCTR  2,0
         LA    3,23(0,0)
         CLR   2,3
         BH    @@L17
         LTR   4,4
         BNH   @@L17
         LA    3,80(0,0)
         CR    4,3
         BNH   @@L16
@@L17    EQU   *
         SLR   15,15
         B     @@L15
@@L16    EQU   *
         LR    3,15
         SLL   3,2
         AR    3,15
         SLL   3,4
         AR    3,4
         A     3,=F'-81'
         LR    4,3
         SRA   4,6
         N     4,=F'63'
         SLR   15,15
         LA    2,63(0,0)
         CLR   4,2
         BH    @@L19
         L     2,=A(@@0)
         SLR   15,15
         IC    15,0(2,4)
@@L19    EQU   *
         N     3,=F'63'
         SLR   2,2
         LA    4,63(0,0)
         CLR   3,4
         BH    @@L21
         L     2,=A(@@0)
         SLR   4,4
         IC    4,0(2,3)
         LR    2,4
@@L21    EQU   *
         SLL   15,8
         OR    15,2
@@L15    EQU   *
* FUNCTION getBufAddr EPILOGUE
         PDPEPIL
* FUNCTION getBufAddr LITERAL POOL
         DS    0F
         LTORG
* FUNCTION getBufAddr PAGE TABLE
         DS    0F
@@PGT9   EQU   *
         DC    A(@@PG9)
         DS    0F
* X-FUNC offToBuf PROLOGUE
OFFTOBUF PDPPRLG CINDEX=10,FRAME=88,BASER=12,ENTRY=YES
         B     @@FEN10
         LTORG
@@FEN10  EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG10   EQU   *
         LR    11,1
         L     10,=A(@@PGT10)
* FUNCTION offToBuf CODE
         L     4,0(11)
         LR    3,4
         SRA   3,6
         N     3,=F'63'
         SLR   15,15
         LA    2,63(0,0)
         CLR   3,2
         BH    @@L24
         L     2,=A(@@0)
         SLR   15,15
         IC    15,0(2,3)
@@L24    EQU   *
         LR    3,4
         N     3,=F'63'
         SLR   2,2
         LA    4,63(0,0)
         CLR   3,4
         BH    @@L26
         L     2,=A(@@0)
         SLR   4,4
         IC    4,0(2,3)
         LR    2,4
@@L26    EQU   *
         SLL   15,8
         OR    15,2
* FUNCTION offToBuf EPILOGUE
         PDPEPIL
* FUNCTION offToBuf LITERAL POOL
         DS    0F
         LTORG
* FUNCTION offToBuf PAGE TABLE
         DS    0F
@@PGT10  EQU   *
         DC    A(@@PG10)
         DS    0F
* X-FUNC rcToOff PROLOGUE
RCTOOFF  PDPPRLG CINDEX=11,FRAME=88,BASER=12,ENTRY=YES
         B     @@FEN11
         LTORG
@@FEN11  EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG11   EQU   *
         LR    11,1
         L     10,=A(@@PGT11)
* FUNCTION rcToOff CODE
         L     3,0(11)
         L     4,4(11)
         LR    5,3
         BCTR  5,0
         LA    15,23(0,0)
         CLR   5,15
         BH    @@L29
         LTR   4,4
         BNH   @@L29
         LR    15,3
         SLL   15,2
         AR    15,3
         SLL   15,4
         AR    15,4
         A     15,=F'-81'
         LA    3,80(0,0)
         CR    4,3
         BNH   @@L27
@@L29    EQU   *
         SLR   15,15
@@L27    EQU   *
* FUNCTION rcToOff EPILOGUE
         PDPEPIL
* FUNCTION rcToOff LITERAL POOL
         DS    0F
         LTORG
* FUNCTION rcToOff PAGE TABLE
         DS    0F
@@PGT11  EQU   *
         DC    A(@@PG11)
         END
#@
//SINCLUDE  EXEC PGM=PDSLOAD
//STEPLIB  DD  DSN=SYSC.LINKLIB,DISP=SHR
//SYSPRINT DD  SYSOUT=*
//SYSUT2   DD  DSN=SYSGEN.FSS.INCLUDE,
//             UNIT=SYSALLDA,VOL=SER=PUB001,
//             SPACE=(CYL,(15,2,20),RLSE),
//             DISP=(NEW,CATLG,DELETE)
//SYSUT1   DD  DATA,DLM='#@'
./ ADD NAME=ALLOC
/*-----------------------------------------------------------------
 |  Copyright (c) 2012-, Tommy Sprinkle (tommy@tommysprinkle.com)  
 |  Licensed under the NEW BSD Open Source License
  -----------------------------------------------------------------*/

char *dynAlloc(char *dsn, char *rtddn, char *volser, char *device);
char *dynFree(char *ddn);
./ ADD NAME=CHAINR
/*--------------------------------------------------------------------
 |  Copyright (c) 2012-2013, Tommy Sprinkle (tommy@tommysprinkle.com)  
 |  Licensed under the NEW BSD Open Source License
  --------------------------------------------------------------------*/

#ifndef CHAINR_H
#define CHAINR_H

struct sChainRhdr
{
	struct sChainRhdr *next;
	struct sChainRhdr *prev;
	char key;
};

struct sChainRblk
{
	struct sChainRblk *next;
	char *data;
	int free;
};

struct sChainR
{
	char eyeball[4];

	int keyType;
	int keyLen;
	int recSize;
	int allocSize;

	int entryCount;

	struct sChainRblk *firstBlk;
	struct sChainRblk *activeBlk;
	struct sChainRblk *freeBlk;

	struct sChainRhdr *first;
	struct sChainRhdr *last;
};

typedef struct sChainR *CHAINR;

#define chAdd(chainr, key) chainAddFunc(chainr, (void *)key)
#define chainAdd(chainr, key) chainAddFunc(chainr, (void *)key)
#define chainFind(chainr, key) chainFindFunc(chainr, (void *)key)

#define chainNewInt(recsize) chainNewFunc(4, 0, recsize, 4090)
#define chainNewChar(keyln, recsize) chainNewFunc(keyln, 1, recsize, 4090)
#define chainNewBin(keyln, recsize) chainNewFunc(keyln, 2, recsize, 4090)

CHAINR chainNewFunc(int keyLen, int keyType, int recSize, int allocSize);
char *chainAddFunc(CHAINR scr, void *key);

int chainFree(CHAINR scr);
int chainReset(CHAINR scr);

char *chainFirst(CHAINR scr);
char *chainLast(CHAINR scr);
char *chainFindFunc(CHAINR scr, void *key);
int chainCount(CHAINR scr);

#endif
./ ADD NAME=EXCP
/*-----------------------------------------------------------------
 |  Copyright (c) 2012-, Tommy Sprinkle (tommy@tommysprinkle.com)  
 |  Licensed under the NEW BSD Open Source License
  -----------------------------------------------------------------*/

#ifndef EXCP
#define EXCP

struct sEXCP
{
   unsigned char mbbcchhr[8];
   int keylen;
   int datalen;
   unsigned char *count;
   unsigned char *key;
   unsigned char *data;
};

typedef void *excpfile;

excpfile xOPEN(char *ddname);
excpfile xOPENV(char *ddname);
int xCLOSE(excpfile ef);
int xREAD(excpfile ef, struct sEXCP *excp, int tt, int r);
int xTREAD(excpfile ef, struct sEXCP *excp, int tt);

#endif
./ ADD NAME=FINDDEVT
/*--------------------------------------------------------------------
 |  Copyright (c) 2012-2013, Tommy Sprinkle (tommy@tommysprinkle.com)  
 |  Licensed under the NEW BSD Open Source License
  --------------------------------------------------------------------*/
#ifndef FINDDEVT_H
#define FINDDECT_H

char *finddevt(char *volser);

#endif
./ ADD NAME=FSS
/*-----------------------------------------------------------------
 |  Copyright (c) 2012-, Tommy Sprinkle (tommy@tommysprinkle.com)
 |  Licensed under the NEW BSD Open Source License
  -----------------------------------------------------------------*/

#ifndef FSS_H
#define FSS_H

int fssInit(void);
int fssTerm(void);
int fssReset(void);

int fssFld(int row, int col, int attr, char *fldName, int len, char *text);
int fssTxt(int row, int col, int attr, char *text);

int fssSetField(char *fldName, char *text);
char *fssGetField(char *fldName);
int fssGetAID(void);
int fssRefresh(void);
int fssSetCursor(char *fldName);
int fssSetAttr(char *fildName, int attr);
int fssSetColor(char *fldName, int color);
int fssSetXH(char *fldName, int attr);

char *fssTrim(char *data);
int fssIsNumeric(char *data);
int fssIsBlank(char *data);
int fssIsHex(char *data);

#define fssPROT 0x30
#define fssNUM 0x10
#define fssHI 0x08
#define fssNON 0x0C

#define fssBLUE 0xF100
#define fssRED 0xF200
#define fssPINK 0xF300
#define fssGREEN 0xF400
#define fssTURQ 0xF500
#define fssYELLOW 0xF600
#define fssWHITE 0xF700

#define fssBLINK 0xF10000
#define fssREVERSE 0xF20000
#define fssUSCORE 0xF40000

#define fssENTER 0x7D
#define fssPFK01 0xF1
#define fssPFK02 0xF2
#define fssPFK03 0xF3
#define fssPFK04 0xF4
#define fssPFK05 0xF5
#define fssPFK06 0xF6
#define fssPFK07 0xF7
#define fssPFK08 0xF8
#define fssPFK09 0xF9
#define fssPFK10 0x7A
#define fssPFK11 0x7B
#define fssPFK12 0x7C
#define fssPFK13 0xC1
#define fssPFK14 0xC2
#define fssPFK15 0xC3
#define fssPFK16 0xC4
#define fssPFK17 0xC5
#define fssPFK18 0xC6
#define fssPFK19 0xC7
#define fssPFK20 0xC8
#define fssPFK21 0xC9
#define fssPFK22 0x4A
#define fssPFK23 0x4B
#define fssPFK24 0x4C
#define fssCLEAR 0x6D
#define fssRESHOW 0x6E

#endif
./ ADD NAME=SVC
#ifndef SVC
#define SVC

typedef struct REGS
{
   unsigned int R0;
   unsigned int R1;
   unsigned int R15;
} REGS;

void EXSVC(int svc, REGS *regs);

void EXEC(REGS *regs);

#endif
./ ADD NAME=TSO
/*-----------------------------------------------------------------
 |  Copyright (c) 2012-, Tommy Sprinkle (tommy@tommysprinkle.com)
 |  Licensed under the NEW BSD Open Source License
  -----------------------------------------------------------------*/

#ifndef TSO_H
#define TSO_H

void tput(char *data, int length);
int tget(char *data, int length);

int tput_fullscr(char *data, int legnth);
int tget_asis(char *data, int length);

void stfsmode(int opt); /* 1-ON, 0-OFF */
void sttmpmd(int opt);  /* 1-ON, 0-Off */
void stlineno(int line);

int getBufOffset(int bufAddr);
int getBufAddr(int row, int col);
int offToBuf(int offset);
int rcToOff(int x, int y);
int xlate3270(int byte);

#define cmd3270_SF 0x1D
#define cmd3270_SBA 0x11
#define cmd3270_IC 0x13
#define cmd3270_PT 0x05
#define cmd3270_RA 0x3C
#define cmd3270_EUA 0x12

#define cmd3270_SA 0x28
#define cmd3270_SA_exth 0x41
#define cmd3270_SA_color 0x42

#define attr3270_protected 0x30
#define attr3270_numeric 0x10
#define attr3270_hi 0x08

#define color3270_Default 0x00
#define color3270_Blue 0xF1
#define color3270_Red 0xF2
#define color3270_Pink 0xF3
#define color2370_Green 0xF4
#define color3270_Turquoise 0xF5
#define color3270_Yellow 0xF6
#define color3270_White 0xF7

#define highlight3270_Default 0x00
#define highlight3270_Blink 0xF1
#define highlight3270_Reverse 0xF2
#define highlight3270_Underscore 0xF4

#define AID_Enter 0x7D
#define AID_PF01 0xF1
#define AID_PF02 0xF2
#define AID_PF03 0xF3
#define AID_PF04 0xF4
#define AID_PF05 0xF5
#define AID_PF06 0xF6
#define AID_PF07 0xF7
#define AID_PF08 0xF8
#define AID_PF09 0xF9
#define AID_PF10 0x7A
#define AID_PF11 0x7B
#define AID_PF12 0x7C
#define AID_PF13 0xC1
#define AID_PF14 0xC2
#define AID_PF15 0xC3
#define AID_PF16 0xC4
#define AID_PF17 0xC5
#define AID_PF18 0xC6
#define AID_PF19 0xC7
#define AID_PF20 0xC8
#define AID_PF21 0xC9
#define AID_PF22 0x4A
#define AID_PF23 0x4B
#define AID_PF24 0x4C
#define AID_PA1 0x6C
#define AID_PA2 0x6E
#define AID_PA3 0x6B
#define AID_Clear 0x6D
#define AID_Reshow 0x6E

#endif
#@
//* -----------------------------------
//ALLOC EXEC PGM=IEFBR14
//OBJ    DD DSN=SYSGEN.FSS.OBJ,
//          DISP=(NEW,CATLG,DELETE),
//          UNIT=SYSALLDA,VOL=SER=PUB001,
//          SPACE=(CYL,(1,0,36))
//LOAD   DD DSN=SYSGEN.FSS.LOAD,
//          DISP=(NEW,CATLG,DELETE),
//          UNIT=SYSALLDA,VOL=SER=PUB001,
//          SPACE=(CYL,(1,0,36))
//* -----------------------------------
//TCSASM PROC M=
//ASSEMBL EXEC  PGM=IFOX00,REGION=1024K,
//         PARM='LINECOUNT(45)'
//SYSLIB   DD    DISP=SHR,DSN=SYS1.MACLIB
//         DD    DISP=SHR,DSN=SYS1.AMODGEN
//         DD    DISP=SHR,DSN=PDPCLIB.MACLIB
//         DD    DISP=SHR,DSN=SYSGEN.FSS.ASM
//SYSUT1   DD    DSN=&&SYSUT1,UNIT=VIO,SPACE=(1700,(600,100))
//SYSUT2   DD    DSN=&&SYSUT2,UNIT=VIO,SPACE=(1700,(300,50))
//SYSUT3   DD    DSN=&&SYSUT3,UNIT=VIO,SPACE=(1700,(300,50))
//SYSPRINT DD    SYSOUT=*
//SYSIN    DD    DISP=SHR,DSN=SYSGEN.FSS.ASM(&M)
//SYSPUNCH DD    DISP=SHR,DSN=SYSGEN.FSS.OBJ(&M)
//   PEND
//ALLOC     EXEC TCSASM,M=ALLOC
//CHAINR    EXEC TCSASM,M=CHAINR
//EXCP      EXEC TCSASM,M=EXCP
//EXEC      EXEC TCSASM,M=EXEC
//FINDDEVT  EXEC TCSASM,M=FINDDEVT
//FSS       EXEC TCSASM,M=FSS
//SVC#GCC   EXEC TCSASM,M=SVC#GCC
//SVC#JCC   EXEC TCSASM,M=SVC#JCC
//TSO       EXEC TCSASM,M=TSO
//
