# Automated MVS3.8j Sysgen from Jay Moseley site
Origin: https://github.com/MVS-sysgen/sysgen
Fork:   https://github.com/moshix/sysgen

Welcome to the automated MVS 3.8j sysgen.

## Install

### **Hercules**
- Author: Roger Bowler.
- Mantainers: Jay Maynard, Jan Jaeger and others. 
- https://sdl-hercules-390.github.io/html/hercinst.html

## Debian/Ubuntu packages:

```bash
sudo apt-get -y install \
    autoconf automake build-essential c3270\
    cmake flex gawk git libbz2-dev libcap2-bin \
    libltdl-dev libtool-bin m4 make ncat time \
    unzip wget zlib1g-dev

sudo apt-get -y install libregina3-dev regina-rexx # **WARNING BELOW**
```
- Latest REXX version (3.9) is not working with Hercules.
- I am using REXX-Regina_3.6 5.00 31 Dec 2011
- https://sourceforge.net/projects/regina-rexx/files/regina-rexx/3.6/Regina-REXX-3.6.tar.gz/download

## Create a RAM disk to speed building

Increase speed and throughput of DASD volumes creating a RAM disk.

```bash
cd sysgen

# Create RAM disk
./00_ramdisk_create.sh
```

Execute Sysgen

```bash
# Create RAM disk
./sysgen.sh
```

After building, make a copy of DADS and execute

```bash
# Create a backup of RAM disk
mv dasds dads_backup

# Destroy ramdisk
./00_ramdisk_destroy.sh

# Restore content
mv dads_backup dads
```

## Running

Currently only Debian/Ubuntu based systems are supported. If your system requires a password for sudo commands you may get prompted for your password to install needed software.

```
Warning: DO NOT run this script as root, 
there is a bug in hercules which will cause it 
to eat up all your machine resources
```

*depending on your system this could take upward of two hours.* If you want to follow along you can use `tail -F ./sysgen/hercules.log`.

Running sysgen will:

- Compile the newest version of SDL Hercules and install it.
- Build the Jay Moseley sysgen MVS 3.8J automatically.
- Install RAKF
- Install MDDIAG8
- Install `INSTALL`, a clist that uses MDDIAG8 to install software contained in the [SOFTWARE](SOFTWARE) folder.
- Install Review Front End (RFE)
- Install Review Panel Frontend (RPF) 
- Install IND$FILE v205
- Install FTP server
- Install BREXX
- Install BLKDISK
- Install EZASMI (TCP/IP API)
- Install FSS/FSI (Full screen APIs)
- Install IMON370

`sysgen.sh` can take multiple arguments:

- `-h`/`--help` Display this help message.
- `-n`/`--no-install` This setting will prevent this script from installing any software other than RAKF.
- `--username <username>` This replaces the *HMVS01* user with the user id supplied
- `--password <password>` This replaces the *HMVS01* user password (CUL8TR) with the one supplied. If none is passed a random password is generated.

The remaining arguments will skip the previous steps and start the system generation process from the next step. 

It will remove the current `dasd` folder and extract the most recent backed up dasd folder from the previous step. 

For example, if you made changes to any of the `jcl/sysgen*.jcl` files you don't have to rebuild the whole environment, just use `./sysgen.sh --skip-distrib` and it will start rebuilding from the sysgen process onward.

- `--skip-hercules` Skip building Hercules, remove any dasd and start automated sysgen.
- `--skip-starter`  Skip building Hercules and building starter.
- `--skip-distrib`  Skip building Hercules, starter and distribution.
- `--skip-sysgen`   Skip building Hercules, starter, distribution and sysgen.
- `--skip-custom`   Skip building Hercules, starter, distribution, 
sysgen and custom.
- `--skip-rakf` Skip building Hercules, starter, distribution, sysgen, custom and RAKF. Install softwares.

Logs of both Hercules (hercules_log*) output and the Hercules printer (prt00e-*) is saved for each step. If a step fails you can review the log to see the error.

## Usernames/Passwords

**RAKF**

| Username | Password |
|:--------:|:--------:|
| IBMUSER  | SYS1     |
| HMVS01*  | CUL8TR   |
| HMVS02   | PASS4U   |

\* Can be replaced with the `--username` flag

**Without RAKF**

Without RAKF installed the account do not need a password

| Username | Password |
|:--------:|:--------:|
| HMVS01   | -        |
| HMVS02   | -        |

## Available Software

Included with this repo:

- BREXX*
- EXTRAS
- INDFILE*
- MDDIAG8*
- OFFLOAD
- QUEUE
- REVIEW*
- RPF

In External Repos:

- [RAKF](https://github.com/MVS-sysgen/RAKF)*
- [FTPD](https://github.com/MVS-sysgen/FTPD)*


To install any of these login and run `INSTALL THING` where *THING* is any of the folders in `SOFTWARE`.


\* These items are installed automatically unless disabled by passing the sysgen script `--no-install` and `--no-rakf`

In the [SOFTWARE](SOFTWARE) folder is software that comes with this SYSGEN. Other software, such as FTPD and RAKF exist in other repos but can be installed by cloning the repo to the `SOFTWARE` folder and following their instructions.

## Changes From Jay Moseley Sysgen

* Edited `create.dasd.sh`: removed read to ask for compression. Always compress now.
* Edited `condcode.rexx`: returns non-zero if any jobs have a return code greater than 0004. Can now be used in scripts.
* Edited `sysgen01.jcl`, `smp1.cnf`, `smp2.cnf`, and `sysgen.cnf` to change 3215 console to 3215-C for automation
* Added `SYSGEN` alias to `UCPUB001` for software installs in `jcl/mvs01.jcl`
* Modified `jcl/sysgen05.jcl` changing `,DYNAMNBR=20` to `,DYNAMNBR=64`

## Info

This repo is heavily based on Jay Moseley sysgen. His writeup is a wonderful resource and you should read the site here: http://www.jaymoseley.com/hercules/installMVS/iMVSintroV7.htm

A lot of the information contained on this repo is directly from his sysgen walkthrough.

There are lots of files and folders. Each folder has a readme explaining from a high level what each file does.

## System Setup Information:

From: http://www.jaymoseley.com/hercules/installMVS/iCUSTv7.htm

Much of the operation of MVS is controlled by JES2 and the parameters that affect JES2 are contained in the member JES2PM00 in SYS1.PARMLIB.  The three main functions are job entry (readers), job execution (job classes), and output (printers and punches).

**Card Readers**

There is one Hercules emulated card reader that is controlled by JES2 - the 2540R at address `x'00c'`. There are other card readers generated into the system and one of those is also defined in the Hercules configuration file - the 2540R at address `x'01c'`.

**Printers**

There are two emulated printers controlled by JES2 - the 1403 at address `x'00e'` and the 3211 at address `x'00f'`. The 1403 printer defined at address `x'015'` is a special case as it defined as, and dedicated to the hardcopy log; it is not controlled by JES2. There are other printers generated into the system, but they are not defined in the configuration file; they are simply 'extra' printers.

**Card Punch**

There is one emulated card punch that is controlled by JES2 - the 2540P at address `x'00d'`.  There are other card punches generated into the system and one of those is also definied in the Hercules configuration file - the 2540P at address `x'01d'`.

**CLASS**

The `CLASS=` parameter on the JOB card determines the class that the job is intended to be run in.

There are six initiators defined to JES2, three are not active when MVS is IPLed, but three of them are automatically started.  The initiators select a job for execution when the `CLASS=` parameter on the JOB card matches one of the CLASSES the initiator is set to process.  Currently the initiators are set to process these classes (listed in order by highest priority first):

| Initiator 1 | Initiator 2 | Initiator 3 | Initiator 4 (not started) | Initiator 5 (not started) | Initiator 6 (not started) |
|:-----------:|:-----------:|:-----------:|:-------------------------:|:-------------------------:|:-------------------------:|
| A           |     B,A     |      S      |         D,C,B,A           |  E,C,B,A                  |   F,E,C,B,A               |


Class **S** is intended for use for System Programming tasks, so some of the control has been loosened on that class, which is why you don't have to 'approve' embedded console commands.  It is not a good idea to simply use S for all of your jobs, however, as there are good reasons for those controls being in place.

The two printers controlled by JES2 are set to select non-held printer output in class **A** (the 1403 at x'00e') and class M (the 3211 at x'00f').

The card punch controlled by JES2 is set to select non-held punch output in class **B**.

Some of the parameters for JES2 may be changed from the MVS console and the changes will only remain in effect until the next IPL.  Some of the parameters must be changed by altering the JES2PM00 member in SYS1.PARMLIB, then stopping and restarting JES2.

