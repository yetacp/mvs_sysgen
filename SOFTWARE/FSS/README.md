# FSS - TSO Full Screen Services

Author: Tommy Sprinkle
Homepage: http://tommysprinkle.com/mvs/fss/index.html

```bash
                            Dataset Browser                                   
 Command ===>                                                                   
 Dataset ---- TCS3.MVS.LOAD                                              
 TTR     ===> 000001  Show Key ===> Y     Key ---- 8     Data ---- 256   
      Offset   0...2... 4...6... 8...A... C...E...                       
      000000   C5E2E3C1 C5404040 00FEC1D3 D3D6C340   * ESTAE   ..ALLOC  *
      000010   40400102 052C0103 0B000000 000002E2   *   .............S *
      000020   01188838 78000000 88000001 0000C2D7   * ..h.....h.....BP *
      000030   D6C5C2D3 C4D30003 1C2C0004 01000000   * OEBLDL.......... *
      000040   000002E2 001A901A 90000000 88000001   * ...S........h... *
      000050   0000C2D7 D6C5E3C5 E2E30003 042C0003   * ..BPOETEST...... *
      000060   09000000 000002E2 000FE00F E0000000   * .......S..\.\... *
      000070   88000001 0000C3C2 E3F9F7F3 40400053   * h.....CBT973  .. *
      000080   182C0053 1D000000 000002E2 00053005   * ...........S.... *
      000090   30000000 88000001 0000C4C2 C3E3C5E2   * ....h.....DBCTES *
      0000A0   E340001D 1C2C001D 21000000 000002E2   * T .............S *
      0000B0   000B400B 40000000 88000001 0000C4C2   * .. . ...h.....DB *
      0000C0   E4E7E3C5 E2E30003 142C0003 19000000   * UXTEST.......... *
      0000D0   000002E2 00071807 18000000 88000001   * ...S........h... *
      0000E0   0000C5E2 E3C1C540 4040001C 112C001D   * ..ESTAE   ...... *
      0000F0   04000000 000002E2 00015001 50000000   * .......S..&.&... *
      000100   88000001 00000000                     * h.......         *
```	   

FSS is a C library for displaying formatted screens on a 3270 terminal under TSO. Above is a screen shot of an actual 3270 full-screen application using FSS.

FSS was developed using the JCC compiler and MVS 3.8 running on Hercules. Most of the code should easily port to other compilers.

FSS is implemented in three layers each contained in its own source file. First is the SVC layer. It provides the ability to issue a SVC instruction to request MVS Supervisor services. The SVC layer is written in 370 assembler and is specific to JCC.

The second layer is TSO. It is written in C and calls the SVC layer when MVS Supervisor services are needed. The TSO layer implements an interface to basic TSO functions necessary for full screen access.

The third layer is FSS. FSS manages a group of fields that make up a screen. It constructs a 3270 data stream and calls the TSO layer to write it (TPUT) to the TSO terminal. It also manages mapping input data from the terminal.
