#!/bin/bash

iface=wlp3s0
service=net.$iface

# Special case for $1=toggle
if [[ $1 = "toggle" ]]
then
  rc-service $service status

  # If exit code is 0 then service is started
  if [[ $? = 0 ]]
  then
    rc-service $service stop

  # If exit code is 3 then service is stopped 
  else
    rc-service $service start
  fi
else

  # otherwise pass the arg through
  rc-service $service $1
fi

# Grab the resulting status
status=$(
  rc-service $service status 2>&1 | \
  awk -F' ' '{ print $3 }'
)

logger "[ACPI] action=\"$0\" arg=$1 iface=$iface status=$status"
