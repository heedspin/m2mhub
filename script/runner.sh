#!/usr/bin/env bash                                                                                                                                                  

if [ $# -lt 1 ] ; then
    echo "Usage:   " $0 "<path to runner script>"
    echo "E.g. :   " $0 "'Production::InventoryReport.new.run_in_background!'"
    exit 1
fi

arguments=$@

script_location=$(cd ${0%/*} && pwd -P)
cd $script_location/..
rails_root=`pwd`

if [ -f "/etc/environment" ]; then
  source /etc/environment
fi

logfile=$rails_root/log/runner.log
echo "-----------------------------------------------" >> $logfile 2>&1
echo `date` >> $logfile 2>&1
echo "$0 $arguments with path = $PATH" >> $logfile 2>&1

./script/rails runner $arguments >> $logfile 2>&1
