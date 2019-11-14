#!/usr/bin/python
import sys
import re

string = ''

# Get the runtime args if they are supplied
if(len(sys.argv)>2):
	string = sys.argv[1] + ' ' + sys.argv[2]
elif(len(sys.argv)>1):
	string = sys.argv[1]

# If no runtime args were supplied, prompt the user for them instead
if(string):
	try:
		[(N, Y)] = re.findall('^\[*([0-9]+)[, ]+([0-9]+)\]*$', string)
	except:
		sys.exit("Error: Args not supplied properly!") 
else:
	N = input("Enter the number of fibonacci sequence numbers to generate: ")
	Y = input("Enter how many digits in length numbers in the sequence to be counted must be: ")

if( len(N) <= 0 or len(Y) <= 0 ):
	sys.exit("Error: Numbers not supplied or not in correct format!")

N = int(N)
Y = int(Y)

print(N, Y)

fibs = {0:1, 1:1}
if N > 2:
	for i in range(2,N):
		fibs[i] = fibs[i-1] + fibs[i-2]

count = 0
for a in range(N):
	print(fibs[a])
	if(len(str(fibs[a])) == Y):
		count += 1

print(count)