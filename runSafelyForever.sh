#!/bin/bash

# `apt install moreutils` if you want the console output saving to work, 
# or you can change the method to not use `ts`
# requires gzip as well
# maybe other

# config
servername=slaynville
gameserverdir=/home/ubuntu/otserv
consolelogdir=data/logs/console
binaryPath=$gameserverdir/slaynville
binaryName=slaynville
databaseuser=otadmin
databasename=otserv
databasebackupdir=/home/ubuntu/otserv/backups/database

# ensure required files, dirs & users exist
mkdir -p $consolelogdir
mkdir -p $databasebackupdir
if [ ! -d "$gameserverdir" ]; then
  echo "Cannot find game server directory!"
  exit 1
fi
if [ ! -f "$binaryPath" ]; then
  echo "Cannot find game binary!"
  exit 1
fi
if ! mysql --user=USER NAME GOES HERE --password=PASSWORD GOES HERE -e "quit" 2>/dev/null; then
  echo "Cannot connect to MySQL as $databaseuser without a password"
  exit 1
else

  # check if antirollback configuration file exists & create if necessary
  antirollback=$gameserverdir/antirollback
  if [ ! -f $antirollback ]; then
    cat > $antirollback << EOL
set \$_exitcode = 999
run
set \$ec = \$_exitcode
if \$ec > 0
  generate-core-file
  call g_game.saveGameState()
  thread apply all bt full
end
quit \$ec
EOL
fi

# configure environment
ulimit -c unlimited
set -o pipefail
date=`date "+%d-%m-%y-%H-%M-%S"`
databasefile="${date}-CRASH.sql.gz"

# start the server
cd $gameserverdir
echo "${servername} is starting up!"

while true
do
  gdb --batch -return-child-result --command=$antirollback --args ./$binaryName 
  # 2>&1 | tee >(ts "%d-%m-%y %H_%M_%S" > "${consolelogdir}/$(date +"%F %H-%M-%S.log")")
  
  # we should move this dump to inside the crash portion?
  mysqldump --user=USER NAME GOES HERE --password=UR PASSWORD GOES HERE $databasename | gzip > $databasebackupdir$databasefile

  if [ $? -eq 0 ]; then
    echo "${servername} has shut down (Exit code 0 - graceful shutdown)." 
      echo "To prevent the server from updating & restarting, press ctrl+c now."
      sleep 10
      # echo "Running serversave.sh!"
      # cd /home/$user
      # ./remake.sh
      # ./serversave.sh
      # cd $gameserverdir
  else
    echo "${servername} has crashed! Restarting in 30 seconds!"
    echo "To prevent the server restarting, press ctrl+c now."
    sleep 30
  fi
done
fi
