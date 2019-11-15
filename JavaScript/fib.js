// fib.js by Aidan Fitzpatrick.
// Written in node-compatible JavaScript.

// Node console input module
const readline = require('readline');

// Check right down the bottom if you're looking for the entry point.

// A function to perform the operation (realistically pretty small)
function fibs(n, y){
	// Setting up variables to store values as they're computed
	var a = 0;
	var b = 1;
	var c = 0;
	var count = 0;
	if(y == 1){
		if (n < 2){
			count = n;
		} else {
			count = 2;
		}
	}

	// A regular expression to extract the exponent of the numbers
	var re_len = new RegExp('.*e\\+([0-9]+)');

	for(var i = 0; i < n; i++){
		// Calculate the next fibonacci number
		c = a + b;
		// Check if it has an exponent (>21 digits)
		if((l = re_len.exec(c)) != null){
			// Check if it is the right length
			if(y == parseInt(l[1])+1){
				count += 1;
			}
		}
		// Check if it is less than the exponent cutoff
		// and if it is the right length
		if(c < 1e+21 && c.toString().length == y){
			count += 1;
		}
		// Swap numbers for next iteration:
		// Forget the smaller of a/b, and reset c
		if(a > b){
			b = c;
			c = 0;
		} else {
			a = c;
			c = 0;
		}
	}
	return count;
}

// A function to abstract parsing of the argument string using regex.
function match_args(ny){
	// Take a string of `[N, Y]` or `[N,Y]` and return N and Y as integers.
	// regex
	var regex = new RegExp('\\[([0-9]+),\s*([0-9]+)\\]')
	// Apply the regex
	match = regex.exec(ny);
	// n is the first match, y is the second match
	// (match[0] is the entire match)
	n_str = match[1];
	y_str = match[2];
	// Parse the string numbers as integers
	return [parseInt(n_str), parseInt(y_str)];
}

// take input and return output
// This originally wasn't the intention, but the way that interactive input is
// handled means we need to call the other functions from this one.
function parse_args(args){
	if(args.length == 2){
		// Interactive Mode

		// Taking input in node is kinda weird...
		const rl = readline.createInterface({
			input: process.stdin,
			output:process.stdout,
		})

		// Setting up some variables
		n_str = '';
		y_str = '';
		n = 0;
		y = 0;

		// A couple of long strings separated out to keep things readable
		n_question_string = "Enter the number of fibonacci sequence numbers to generate: "
		y_question_string = "Enter how many digits in length numbers in the sequence to be counted must be: "

		// query the user for input
		rl.question(`${n_question_string}`, (n_response) => {
			n_str = n_response; // originally intended to return these variables
			// pause listening on the input to free the IO stream
			rl.pause();
			// query the user for the next question (must be done inside because
			// for some reason this is asynchronous...)
			rl.question(`${y_question_string}`, (y_response) => {
				y_str = y_response;
				// parse both the input strings to integers
				n = parseInt(n_str);
				y = parseInt(y_str);
				// missing some error handling here that I don't have time to
				// handle (need to study for exams)
				rl.close();
				// Have to do this here because node is gross
				// (run the fibs() function here)
				console.log(fibs(n, y));
			});
		})
		
	} else {
		if (args.length == 3){
			// case of `[N,Y]`
			ny_str = args[0];

			// Parse the string into ints
			ny = match_args(ny_str);

			// extract the ints from the return array
			n = ny[0];
			y = ny[1];
		} else if (args.length == 4){
			// cases of `N Y` and `[N, Y]`
			// These two are reversed so they are in known positions
			n_str = args[1];
			y_str = args[0];

			if(n_str[0] == '['){
				// parse and extract the input structure
				ny = match_args(n_str+y_str);
				n = ny[0]
				y = ny[1]
			} else {
				// If we're just given two ints this step is a bit easier
				n = parseInt(n_str);
				y = parseInt(y_str);
			}
		}
		// run the fibs() function
		console.log(fibs(n, y))
	}
}

// Here's where we start calling functions at the top level
parse_args(process.argv.reverse());