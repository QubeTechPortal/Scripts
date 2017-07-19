#!/bin/bash
read -p "Enter destination username>" dusername
read -p "Enter destination ipaddress>" dipaddress
read -p "Enter source udr path >" spath
read -p "Enter destination udr path >" dpath
read -p "Enter destination ssh port >" dport
read -p "Enter bandwidth in kbps >" bwd
read -p "Enter source directory >" sd
read -p "Enter destination directory >" dd
read -p "Enter log file name with path >" log
touch $log
echo "$spath -c $dpath -P $dport rsync -rvP --size-only --bwlimit=$bwd $sd $dusername@$dipaddress:$dd >> $log" >> rsync.log
chmod 775 $log runsync.sh
