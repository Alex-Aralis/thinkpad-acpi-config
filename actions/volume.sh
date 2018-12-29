#!/bin/bash

VolumeChange=$1

if [[ "$VolumeChange" = "toggle" ]]
then
  SetValue=toggle
elif (( "$VolumeChange" < "0" ))
then
  SetValue=$((-$VolumeChange))%-
else
  SetValue=$VolumeChange%+
fi

NewState=$(
  amixer set Master $SetValue | \
  grep 'Mono: Playback' | \
  awk -F'[][]' '{ print "volume="$2, "enabled="$6 }'
)

logger "[ACPI] action=\"$0\" arg=$VolumeChange $NewState"

