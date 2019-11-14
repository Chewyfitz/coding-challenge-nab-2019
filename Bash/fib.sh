#!/bin/bash

# requires `bc` for dealing with numbers above 9223372036854775807 (N > 92).
# Because we're using `bc`, IO takes a little longer, so expect large inputs for
# these cases to be a fair bit slower.

# I'm not too familiar with bash, so this program might not be 100% perfect
INPUTS0=^\[[0-9]+\,[0-9]+\]$ # Input in form [NUM,NUM]
INPUTS1=^\[[0-9]+\,$         # Input in form [NUM, NUM] (first half)
INPUTS2=^[0-9]+\]$           # Input in form [NUM, Num] (second half)
INPUTONLYNUM=^[0-9]+$        # Input in form NUM NUM (both args numbers)

PRINTN="Enter the number of fibonacci sequence numbers to generate: "
PRINTY="Enter how many digits in length numbers in the sequence to be counted must be: "

# Figure out what the input is
if [[ $1 =~ $INPUTS0 ]]; then
	# If it's a single tuple
	String=$(echo $1 | tr -dc '0-9,')
	N=$(echo $String | awk -F '[,]' '{print $1}')
	Y=$(echo $String | awk -F '[,]' '{print $2}')
elif [[ $1 =~ $INPUTS1 && $2 =~ $INPUTS2 ]]; then
	# If it's a tuple with a space
	N=$(echo $1 | tr -dc '0-9')
	Y=$(echo $2 | tr -dc '0-9')
elif [[ $1 =~ $INPUTONLYNUM && $2 =~ $INPUTONLYNUM ]]; then
	# If it's just numbers
	N=$1
	Y=$2
else
	# Otherwise
	echo "Input poorly formed! Entering interactive mode..."
	read -p "$PRINTN" N
	read -p "$PRINTY" Y
fi

# Generate enough Fibonacci numbers
fibs[0]=1
fibs[1]=1
fib_lens[0]=1
fib_lens[1]=1
if [[ $N -lt 93 ]]; then
	# If we're only generating a few we can use bash maths

	for (( i=2; i<N; i++ ))
	do
		fibs[i]=$(( ${fibs[i-1]} + ${fibs[i-2]} ))
		fib_lens[i]=${#fibs[i]}
	done
else
	# If we're generating a lot we need to use an external program to do it
	# so we don't integer overflow.

	for (( i=2; i<N; i++ ))
	do
		fibs[i]=$(bc <<< "${fibs[i-1]} + ${fibs[i-2]}")
		fib_lens[i]=${#fibs[i]}
	done
fi

# Find how many numbers are `Y` characters long
num=0
for (( i=0; i<N; i++ ))
do
	if [[ ${fib_lens[i]} == $Y ]]; then
		num=$(($num + 1))
	fi
done

# Print out the answer!
echo $num
