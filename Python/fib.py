#!/usr/bin/python

"""
Aidan Fitzpatrick (chewyfitz@gmail.com) - fib.py
Takes two arguments in the format of `[NUM, NUM]`, `[NUM,NUM]`, or `NUM NUM`; or
alternatively can be run with no arguments, with the user prompted to input the
required values.
This file does not define any functions as it is simple enough to not require
them.

fib.py takes an `N` and a `Y` value, finding the number of fibonacci numbers up 
to `N` which have length `Y`.
"""

import sys
import re

# An empty string to store the numbers. Needs to be defined here so that it can
# be checked regardless of if the arguments are successfully read or not.
string = ''

# Get the runtime args if they are supplied
if(len(sys.argv)>2):
	# If two args are supplied, they are either '[NUM,', 'NUM]' or 'NUM' 'NUM'
	string = sys.argv[1] + ' ' + sys.argv[2]
elif(len(sys.argv)>1):
	# If one arg is supplied, it is of form '[NUM,NUM]'
	string = sys.argv[1]

# If no runtime args were supplied, prompt the user for them instead
if(string):
	# Attempt to get the arg numbers with regex
	try:
		[(N, Y)] = re.findall('^\[*([0-9]+)[, ]+([0-9]+)\]*$', string)
	except:
		sys.exit("Error: Args not supplied properly! Check the number of args!") 
else:
	# Get user input
	N = input("Enter the number of fibonacci sequence numbers to generate: ")
	Y = input("Enter how many digits in length numbers in the sequence to be counted must be: ")

if( len(N) <= 0 or len(Y) <= 0 ):
	# If N or Y have not been supplied
	sys.exit("Error: Numbers not supplied or not in correct format!")

# Convert N and Y to int for the next part
N = int(N)
Y = int(Y)

# Define the fibonacci list
fibs = [0, 1]
if N > 2:
	for i in range(2,N):
		# append() is O(1) for lists
		fibs.append(fibs[i-1] + fibs[i-2])

# Count how many numbers have length Y
count = 0
for a in range(N):
	if(len(str(fibs[a])) == Y):
		count += 1

# print the count
print(count)
