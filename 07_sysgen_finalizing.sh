# Installs SYSGEN Software
# For use with Jay Moseley sysgen MVS only

source 00_sysgen_functions.sh

cd sysgen
chmod +x submit.sh

echo_step "Starting Hercules: hercules -f conf/local.cnf -r ../07_sysgen_finalizing.rc"
$HERCULES -f conf/local.cnf -r ../07_sysgen_finalizing.rc > hercules.log

echo_step "Backing up hercules.log to hercules_log.finalizing.$date_time.log"
mv hercules.log hercules_log.finalizing.$date_time.log
echo_step "Backing up prt00e.txt to prt00e_finalizing.$date_time.txt"
cp prt00e.txt prt00e_finalizing.$date_time.txt
