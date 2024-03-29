#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>
#include <string.h>
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
#ifndef DEBUG
	#define DEBUG 0
#endif

#define debug_print(fmt, ...)\
	do { if (DEBUG) fprintf(stderr, fmt, __VA_ARGS__); } while (0)

#define MAX_N 23601
#define MAX_Y 4932

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
		if(2 == sscanf(argv[1], "[%d,%d]", N, Y)){
			debug_print("N = %d : Y = %d\n", *N, *Y);
			return 1;
		}
	} else if (argc == 3) {
		if(argv[1][0] == '['){
			// Extract N and Y values from `[NUM, NUM]`
			char* str = malloc((strlen(argv[1]) + strlen(argv[2]) + 1)*sizeof(char));
			strcat(str, argv[1]);
			strcat(str, argv[2]);
			if(2 == sscanf(str, "[%d,%d]", N, Y)){
				debug_print("N = %d : Y = %d\n", *N, *Y);
				return 1;
			}
		} else {
			// Convert N and Y values from `NUM NUM`
			*N = atoi(argv[1]);
			*Y = atoi(argv[2]);
			debug_print("N = %d : Y = %d\n", *N, *Y);
			return 1;
		}
	}
	// Arguments not in accepted format (Too many or wrong format)
	fprintf(stderr, "Incorrect args supplied\n");
	exit(1);
}

void main(int argc, char* argv[]){
	// Set the variables to store N and Y for future use
	int N = 0; int Y = 0;

	// Parse the runtime arguments and store N and Y values
	parse_args(argc, argv, &N, &Y);

	// long double can only handle fibonacci numbers up to 23601.
	// I decided to allow the program to still be run, since it's likely that
	// the Y value will be small enough to still be computed properly.
	if(N > MAX_N){
		fprintf(stderr, "N Value too large, may behave unpredictably.\n");
		if(Y > MAX_Y){
			fprintf(stderr, "Y Value too large, answer will be incorrect.\n");
		}
	}
	long double fib_a = 0;
	long double fib_b = 1;
	long double fib_c = 0;
	long double* a = &fib_a;
	long double* b = &fib_b;
	long double* c = &fib_c;

	int count = 0;

	if(Y == 1){
		// If we're looking for length 1 need to increment values that aren't
		// created in the loop.
		count += 2;
	}

	// A temp for use during swaps
	long double* temp = NULL;
	for(int i=2; i<N; i++){
		*c = *a + *b;
		if(Y == (int)floor(log10l(fabsl(*c)))+1){
			// Increment the count if the number is the right length
			count++;
		}
		// pointer magic - swap c with the smaller of a and b
		if(*a<*b){
			temp = a;
			a = c;
			c = temp;
		} else {
			temp = b;
			b = c;
			c = temp;
		}
	}

	/** Alternate method using memoisation **

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
	*/
	// Print out the solution
	printf("%d\n", count);
	return;
}
