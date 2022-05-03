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
