# S37X macros and instruction
- See https://bixoft.nl/english/opl_bbbm.htm
- https://www.ibm.com/docs/en/SSQ2R2_15.0.0/com.ibm.tpf.toolkit.hlasm.doc/dz9zr006.pdf
- http://zseries.marist.edu/enterprisesystemseducation/assemblerlanguageresources/Assembler.V2.alntext%20V2.00.pdf

## Definitions

### BFP - Binary Floating Register
Binary floating-point (BFP), which defines short, long, and extended binary-floating point (BFP) data formats and provides 87 
new instructions to operate on data in these formats. The BFP formats and operations provide everything necessary to conform to
the IEEE standard (ANSI/IEEE Standard 754-1985, IEEE Standard for Binary Floating-Point Arithmetic, dated August 12, 1985)
except for conversion between binary-floating-point numbers and decimal strings, which must be provided in software.

### HFP - Hexadecimal Floating Point Register
Hexadecimal-floating-point (HFP) extensions, which provides 26 new instructions to operate on data in the HFP format. All of
these are counterparts to new instructions provided by the BFP facility, including conversion between floating-point and fixedpoint formats, and a more complete set of operations on the extended format.

## Macros

### ASMLEAVE
### ASMMREL

### DO
### ENDDO
### ITERATE
### DOEXIT

### IF
### ELSE
### ELSEIF
### ENDIF
### IFERR
### IFGLO
### IFPRO

### EXIT


## Instructions
### A5OP
### A7OP
### ADB
ED1A Add Double Bfp
### ADBR
B31A Add Double Bfp Register
### AEB
ED0A Add Exponential Bfp
### AEBR
B30A Add Exponential Bfp Register
### AFI
C29 Add Fullword Immediate
### AGSI
EB7A Add Grande with Signed Immediate
### AHI
A7A Add Halfword Immediate
### AHIK
ECD8 Add Halfword Immediate Keeping source data
### AHY
E37A Add Halfword Yonder
### ALC
E398 Add Logical with Carry
### ALCR
B998 Add Logical with Carry Register
### ALFI
C2B Add Logical Fullword Immediate
### ALGSI
EB7E Add Logical Grande with Signed Immediate
### ALHSIK
ECDA Add Logical with Halfword Signed Immediate Keeping source data
### ALRK
### ALSI
### ALY
E35E Add Logical Yonder
### ARK
B9F8 Add Register Keeping source data
### ASI
EB6A Add with Signed Immediate
### AXBR
### AY
### BASSM
### BRAS
### BRASL
### BRC
### BRCL
### BRCT
### BRE
### BREL
### BRH
### BRHL
### BRL
### BRLL
### BRM
### BRML
### BRNE
### BRNEL
### BRNH
### BRNHL
### BRNL
### BRNLL
### BRNM
### BRNML
### BRNO
### BRNOL
### BRNP
### BRNPL
### BRNZ
### BRNZL
### BRO
### BROL
### BRP
### BRPL
### BRU
### BRUL
### BRXH
### BRXLE
### BRZ
### BRZL
### BSM
### C0OP
### C2OP
### C4OP
### C6OP
### C8OP
### CDB
### CDBR
### CDFBR
### CDFR
### CEB
### CEBR
### CEFBR
### CEFR
### CFC
### CFDBR
### CFDR
### CFEBR
### CFER
### CFI
### CFXBR
### CFXR
### CGHSI
### CHHSI
### CHI
### CHRL
### CHSI
### CHY
### CIB
### CIBE
### CIBH
### CIBL
### CIBNE
### CIBNH
### CIBNL
### CIJ
### CIJE
### CIJH
### CIJL
### CIJNE
### CIJNH
### CIJNL
### CIT
### CKSM
### CLCLE
### CLCLU
### CLFHSI
### CLFI
### CLFIT
### CLGHSI
### CLHHSI
### CLHRL
### CLIB
### CLIBE
### CLIBH
### CLIBL
### CLIBNE
### CLIBNH
### CLIBNL
### CLIJ
### CLIJE
### CLIJH
### CLIJL
### CLIJNE
### CLIJNH
### CLIJNL
### CLRB
### CLRBE
### CLRBH
### CLRBL
### CLRBNE
### CLRBNH
### CLRBNL
### CLRJ
### CLRJE
### CLRJH
### CLRJL
### CLRJNE
### CLRJNH
### CLRJNL
### CLRL
### CLRT
### CLST
### CLY
### CMPSC
### CPSDR
### CRB
### CRBE
### CRBH
### CRBL
### CRBNE
### CRBNH
### CRBNL
### CRJ
### CRJE
### CRJH
### CRJL
### CRJNE
### CRJNH
### CRJNL
### CRL
### CRT
### CSST
### CU12
### CU14
### CU21
### CU24
### CU41
### CU42
### CUSE
### CUTFU
### CUUTF
### CVBY
### CVDY
### CXBR
### CXFBR
### CXFR
### CXR
### CY
### DDB
### DDBR
### DEB
### DEBR
### DIDBR
### DIEBR
### DL
### DLR
### DXBR
### E3OP
### EBOP
### EDOP
### EDOP2
### EFPC
B38C Extract Floating Point Control register
### EPSW
### EXRL
### FIDBR
B35F load Floating point Integer from Double Bfp Register
### FIDR
load Floating point Integer from Double hfp Register
### FIEBR
B357 load Floating point Integer from Exponential Bfp Register
### FIER
### FIXBR
### FIXR
### IILF
### IILH
### IILL
### IPM
### J
### JAS
### JASL
### JCT
### JE
### JH
### JL
### JLE
### JLH
### JLL
### JLM
### JLNE
### JLNH
### JLNL
### JLNM
### JLNO
### JLNOP
### JLNP
### JLNZ
### JLO
### JLP
### JLU
### JLZ
### JM
### JNE
A74 0111 Jump on Not Equal
### JNH
A74 1101 Jump on Not High
### JNL
A74 1011 Jump on Not Low
### JNM
A74 1011 Jump on Not Mixed / Minus
### JNO
A74 1110 Jump on Not Ones / Overflow
### JNOP
A74 0000 Jump No-OPeration
### JNP
A74 1101 Jump on Not Plus
### JNZ
A74 0111 Jump on Not Zero
### JO
A74 0001 Jump on Ones / Overflow
### JP
A74 0010 Jump on Plus
### JXH
84 Jump on indeX High
### JXLE
85 Jump on indeX Low or Equal
### JZ
A74 1000 Jump on Zero
### KDB
### KDBR
### KEB
### KEBR
### KIMD
### KLMD
### KM
### KMAC
### KMC
### KMCTR
### KMF
### KMO
### KXBR
### LAA
### LAAL
### LAN
### LAO
### LARL
### LAX
### LB
E376 Load Byte
### LBR
B926 Load Byte from Register
### LCDBR
### LCDFR
### LCEBR
### LCXBR
### LCXR
### LDE
### LDEB
### LDEBR
### LDER
### LDXBR
### LEDBR
### LEXBR
### LEXR
### LFAS
### LFPC
### LHI
### LHR
### LHRL
### LHY
### LLC
### LLCR
### LLH
### LLHR
### LLHRL
### LLILF
### LLILH
### LLILL
### LNDBR
### LNDFR
### LNEBR
### LNXBR
### LNXR
### LOC
### LOCM
### LOCNM
### LOCNO
### LOCNP
### LOCNZ
### LOCO
### LOCP
### LOCR
### LOCRM
### LOCRNM
### LOCRNO
### LOCRNP
### LOCRNZ
### LOCRO
### LOCRP
### LOCRZ
### LOCZ
### LPD
### LPDBR
### LPDFR
### LPEBR
### LPXBR
### LPXR
### LRL
### LRV
### LRVH
### LRVR

### LT
E312 Load and Test
### LTDBR
B312 Load and Test Double Bfp Register
### LTEBR
B302 Load and Test short Bfp Register
### LTXBR
B342 Load and Test eXtended Bfp Register
### LTXR
B362 Load and Test eXtended HFP Register

### LXD
### LXDB
### LXDBR
### LXDR
### LXE
### LXEB
### LXEBR
### LXER
### LXR
### LY
### LZDR
### LZER
### LZXR

### MAD
ED3E Multiply and Add Double hfp
### MADB
ED1E Multiply and Add Double Bfp
### MADBR
B31E Multiply and Add Double Bfp Register
### MADR
B33E Multiply and Add Double hfp Register
### MAE
ED2E Multiply and Add Exponential hfp
### MAEB
ED0E Multiply and Add Exponential Bfp
### MAEBR
B30E Multiply and Add Exponential Bfp Register
### MAER
B32E Multiply and Add Exponential hfp Register
### MAY
ED3A Multiply and Add unnormalized extended (Yucky) hfp from long hfp
### MAYH
ED3C Multiply and Add unnormalized extended (Yucky) hfp High from long hfp
### MAYHR
### MAYL
### MAYLR
### MAYR
### MDB
ED1C Multiply Double Bfp
### MDBR
### MDEB
### MDEBR
### MEE
### MEEB
### MEEBR
### MEER
### MFY
### MHI
### MHY
### ML
### MLR
### MS
### MSD
### MSDB
### MSDBR
### MSDR
### MSE
### MSEB
### MSEBR
### MSER
### MSFI
### MSR
### MSY
### MVCLE
### MVCLU
### MVGHI
### MVHHI
### MVHI
### MVST
### MXBR
### MXDB
### MXDBR
### MY
### MYH
### MYHR
### MYL
### MYLR
### MYR
### NILF
### NILH
### NILL
### NRK
### NY
### OILF
### OILH
### OILL
### ORK
B9F6 Or Register Keeping source data
### OY
E356 Or Yonder
### PCC
B92C Perform Cryptographic Computation
### PCKMO
B928 Perform Cryptographic Key Management Operation
### PFD
### PFDRL
### PKA
### PKU
### RLL
### S37XOPS
### SAM24
### SAM31
### SDB
ED1B Subtract Double Bfp
### SDBR
B31B Subtract Double Bfp Register
### SEB
### SEBR
### SFASR
### SFPC
### SHY
E37B Subtract Halfword Yonder
### SLAK
### SLB
### SLBR
### SLFI
### SLLK
### SLRK
### SLY

### SQD
 ED35 SQuare root of Double hfp
### SQDB
### SQDBR
### SQDR
### SQE
### SQEB
### SQEBR
### SQER
### SQXBR
### SQXR

### SRAK
### SRK
### SRLK
### SRNM
### SRST
### SRSTU

### STFPC
### STHRL
### STOC
### STOCM
### STOCNM
### STOCNO
### STOCNP
### STOCNZ
### STOCO
### STOCP
### STOCZ
### STRL
### STRV
### STRVH
### STY
### SXBR
### SY
### TAM
### TBDR
### TBEDR
### TCDB
### TCEB
### TCXB
### THDER
### THDR
### TMH
### TML
### TMLH
### TMLL
### TP
### TRE
### TROO
### TROT
### TRTE
### TRTO
### TRTR
### TRTRE
### TRTT
### UNPKA
### UNPKU
### XILF
### XRK
B9F7 eXclusive-or Register Keeping source data
### XY
E357 eXclusive-or Yonder