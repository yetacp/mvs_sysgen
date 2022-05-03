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
