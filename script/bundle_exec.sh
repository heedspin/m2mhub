#!/usr/bin/env bash                                                                                                                                                  

if [ $# -lt 1 ] ; then
    echo "Usage:   " $0 " <any bundle exec task>"
    echo "E.g. :   " $0 " rake synchronizer:run"
    exit 1
fi

arguments=$@

script_location=$(cd ${0%/*} && pwd -P)
cd $script_location/..
rails_root=`pwd`

if [ -f "/etc/environment" ]; then
  source /etc/environment
fi

logfile=$rails_root/log/bundle_exec.log
echo "-----------------------------------------------" >> $logfile 2>&1
echo `date` >> $logfile 2>&1
echo "$0 $arguments with path = $PATH" >> $logfile 2>&1

bundle exec $arguments >> $logfile 2>&1
