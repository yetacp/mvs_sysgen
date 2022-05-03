# Build starter system
source ./00_sysgen_functions.sh
trap 'check_return' 0

set -e

cd gz
echo_step "Extracting SYSCPK.tar.gz"
tar xvzf SYSCPK.tar.gz

cd ../sysgen
rm -rf dasd/*
prev_dasd=$(ls -Art dasd.03.sysgen.*.tar | tail -n 1)
echo_step "Untarring $prev_dasd"
tar -xvf $prev_dasd

echo_step "Compressing syscpk.3350"
dasdcopy -z ../gz/dasd/syscpk.3350 dasd/syscpk.3350
rm ../gz/dasd/syscpk.3350

echo_step "Creating user dasd"
bash ./create.dasd.sh user

chmod +x submit.sh
echo_step "Starting Hercules: hercules -f conf/mvs.cnf -r ../05_sysgen_system_customization.rc"
$HERCULES -f conf/mvs.cnf -r ../05_sysgen_system_customization.rc > hercules.log

echo_step "Backing up hercules.log to hercules_log.customization.$date_time.log"
mv hercules.log hercules_log.customization.$date_time.log
echo_step "Backing up prt00e.txt to prt00e_customization.$date_time.txt"
cp prt00e.txt prt00e_customization.$date_time.txt
echo_step "Checking Job Return Codes"
if [[ ! -z "${TERM}" ]]; then
    tput bold
    tput setaf 2
fi
chmod +x ./condcode.rexx
./condcode.rexx prt00e.txt mvs00
./condcode.rexx prt00e.txt mvs01
./condcode.rexx prt00e.txt mvs02
if [[ ! -z "${TERM}" ]]; then
    tput sgr0
fi
echo_step "backing up DASD folder to dasd.customization.$date_time.tar"
tar cvf dasd.04.customization.$date_time.tar ./dasd
cd ..

trap : 0