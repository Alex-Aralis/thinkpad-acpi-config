#!/bin/bash 

# gets the offset for first arg, passed from event
IncVal=$1

# Get the Maximum value for use. 
#MaxVal=$(cat /sys/class/backlight/intel_backlight/max_brightness); 
read -r MaxVal < "/sys/class/backlight/intel_backlight/max_brightness"


# Set the Minimum we will accept. 
MinVal=10 

# Get the current brightness value. 
#CurrVal=$(cat /sys/class/backlight/intel_backlight/brightness); 
read -r CurrVal < "/sys/class/backlight/intel_backlight/brightness"

# Set the new value minus the decrement value. 
NewVal=$(($CurrVal + $IncVal)); 
echo $NewVal 

# Set it to the threshold of the max value. 
ThresholdVal=$(($NewVal<$MaxVal?$NewVal:$MaxVal)) 
ThresholdVal=$(($ThresholdVal>$MinVal?$ThresholdVal:$MinVal)) 
echo $ThresholdVal 

# Set the new value directly. 
echo -n $ThresholdVal > /sys/class/backlight/intel_backlight/brightness 
read -r CurVal < "/sys/class/backlight/intel_backlight/brightness"

logger "[ACPI] action=\"$0\" arg=$IncVal brightness=$CurVal"
