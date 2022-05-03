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
