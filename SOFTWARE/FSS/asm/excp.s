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
