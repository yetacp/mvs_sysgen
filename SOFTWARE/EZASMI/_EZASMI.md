# EZASMI

- Version: 1.0.0
- Maintainer: Shelby Beach
- Depends: SXMACLIB
- Homepage: https://github.com/MVS-sysgen/SOFTWARE/EZASMI

## Description
Adds EZASMI Macros to MVS 3.8j.

TCP/IP for MVS 3.8 Assembler is built upon the original EZASOKET
interface developed by Jason Winter. 

It has been extended to provide
additional functionality, improved error detection, and compatibility
with the EZASMI macros. 

Author: Shelby Beach. Ms. Kitty Programming Werks

## Usage [TODO]
### **INITAPI**. Initialize EZASMI interface
```bash
XC    EZASMTIE(TIELENTH),EZASMTIE # Clear EZASMI storage
EZASMI TYPE=INITAPI,MAXSNO=MAXSNO,ERRNO=ERRCD,RETCODE=RETCD
```
### **PTON**. Try converting hostname/IP addr to network binary format
```bash
EZASMI TYPE=PTON,AF='INET',SRCADDR=HOSTIN,SRCLEN=NAMELEN+2, +
    DSTADDR=IPADDR,ERRNO=ERRCD,RETCODE=RETCD
```

### **NTOP**. Convert IP address to dotted decimal format
```bash
EZASMI TYPE=NTOP,AF='INET',SRCADDR=IPADDR,DSTADDR=ADDR, +
    DSTLEN=ADDRLEN,ERRNO=ERRCD,RETCODE=RETCD
```

### **GETHOSTBYADDR**. Resolve IP address to hostname
```bash
EZASMI TYPE=GETHOSTBYADDR,HOSTADR=IPADDR,HOSTENT=HOSTENT, +
RETCODE=RETCD
```

### **GETHOSTBYNAME**. Resolve hostname to IP address.
```bash
EZASMI TYPE=GETHOSTBYNAME,NAMELEN=NAMELEN,NAME=HOSTNAME, +
    HOSTENT=HOSTENT,RETCODE=RETCD
```

### **SOCKET**. Create socket
```bash
EZASMI TYPE=SOCKET,AF='INET',SOCTYPE='STREAM', +
ERRNO=ERRCD,RETCODE=SOCKDESC
```

### **BIND**. Listen
```bash
EZASMI TYPE=BIND,S=SOCKDESC+2,NAME=SOCKADDR, +
ERRNO=ERRCD,RETCODE=RETCD
```

## Datasets

- SYS2.MACLIB [EZASMI, EZASMIA, EZASMIC, EZASMIP, TPIMASK]
- SYS2.LINKLIB [EZACIC04, EZACIC05, EZASOH03]
- SYSGEN.TCPIP.SAMPLIB []

## ISSUES

- In NCAT, there is a link to IJKPARS that throws an error.