#!/bin/bash

#I'm not too familiar with bash, so this program might not be 100% perfect
INPUTS0=^\[[0-9]+\,[0-9]+\]$ # Input in form [NUM,NUM]
INPUTS1=^\[[0-9]+\,$         # Input in form [NUM, NUM] (first half)
INPUTS2=^[0-9]+\]$           # Input in form [NUM, Num] (second half)
INPUTONLYNUM=^[0-9]+$        # Input in form NUM NUM (both args numbers)
if [[ $1 =~ $INPUTS0 ]]; then
	String=$(echo $1 | tr -dc '0-9,')
	N=$(echo $String | awk -F '[,]' '{print $1}')
	Y=$(echo $String | awk -F '[,]' '{print $2}')
elif [[ $1 =~ $INPUTS1 && $2 =~ $INPUTS2 ]]; then
	N=$(echo $1 | tr -dc '0-9')
	Y=$(echo $2 | tr -dc '0-9')
elif [[ $1 =~ $INPUTONLYNUM && $2 =~ $INPUTONLYNUM ]]; then
	N=$1
	Y=$2
else
	echo "Input poorly formed! Entering interactive mode..."
fi
echo $N
echo $Y