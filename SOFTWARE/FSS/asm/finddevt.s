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
