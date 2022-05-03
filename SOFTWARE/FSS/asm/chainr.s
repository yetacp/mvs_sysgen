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
