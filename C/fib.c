#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>
/*
Aidan Fitzpatrick - fib.c

Takes args `N Y`, `[N,Y]`, or `[N, Y]` (or interactive N and Y input) and
computes the number of `Y`-length numbers within the first `N` fibonacci 
numbers.

This program is tested to be working with N values up to 23601, after which an
external library would be required to deal with arbitrary-length integers
(which would detract greatly from the portability, as the current
implementation is a single file.
*/

int parse_args(int argc, char* argv[], int* N, int* Y){
	if(argc < 2){
		// Prompt the user to input N and Y values manually
		printf("Enter the number of fibonacci sequence numbers to generate: ");
		scanf("%d", N);
		printf("Enter how many digits in length numbers in the sequence to be counted must be: ");
		scanf("%d", Y);
		return 1;
	} else if (argc == 2) {
		// Extract N and Y values from `[NUM,NUM]`
	} else if (argc == 3) {
		if(argv[1][1] == '['){
			// Extract N and Y values from `[NUM, NUM]`

		} else {
			// Convert N and Y values from `NUM NUM`
			*N = atoi(argv[1]);
			*Y = atoi(argv[2]);
			printf("N = %d : Y = %d\n", *N, *Y);
			return 1;
		}
	}
	// Arguments not in accepted format (Too many or wrong type)
	fprintf(stderr, "Incorrect args supplied\n");
	exit(1);
}

void main(int argc, char* argv[]){
	// Set the variables to store N and Y for future use
	int N = 0; int Y = 0;

	// Parse the runtime arguments and store N and Y values
	parse_args(argc, argv, &N, &Y);

	// Create the array to store all of the numbers
	long double* fibs = malloc(N*sizeof(long double));
	assert(fibs);

	// Calculate the fibonacci array using memoisation
	fibs[0] = 1;
	fibs[1] = 1;
	for(int i=2; i<N; i++){
		fibs[i] = fibs[i-1] + fibs[i-2];
	}

	// Count the numbers that have length Y
	int count = 0;
	for(int i=0; i<N; i++){
		if(Y == (int)floor(log10l(fabsl(fibs[i])))+1){
			count++;
		}
	}

	// Print out the solution
	printf("%d\n", count);
	
	return;
}
