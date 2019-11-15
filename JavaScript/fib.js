// fib.js by Aidan Fitzpatrick.
// Written in node-compatible JavaScript.

const readline = require('readline');

function fibs(n, y){
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

	var re_len = new RegExp('.*e\\+([0-9]+)');

	for(var i = 0; i < n; i++){
		c = a + b;
		if((l = re_len.exec(c)) != null){
			if(y == parseInt(l[1])+1){
				count += 1;
			}
		}
		if(c < 1e+21 && c.toString().length == y){
			count += 1;
		}
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

function match_args(ny){
	var regex = new RegExp('\\[([0-9]+),\s*([0-9]+)\\]')
	match = regex.exec(ny);
	n_str = match[1];
	y_str = match[2];
	return [parseInt(n_str), parseInt(y_str)];
}

function parse_args(args){
	if(args.length == 2){
		// Interactive Mode
		const rl = readline.createInterface({
			input: process.stdin,
			output:process.stdout,
		})

		n_str = '';
		y_str = '';
		n = 0;
		y = 0;

		rl.question("N: ", (a) => {
			n_str = a;
			rl.pause();
			rl.question("Y: ", (b) => {
				y_str = b;
				n = parseInt(n_str);
				y = parseInt(y_str);
				rl.close();
				// Have to do this because node is gross
				console.log(fibs(n, y));
			});
		})
		
	} else {
		if (args.length == 3){
			// case of `[N,Y]`
			ny_str = args[0];

			ny = match_args(ny_str);
			n = ny[0];
			y = ny[1];
		} else if (args.length == 4){
			// cases of `N Y` and `[N, Y]`
			// These two are reversed so they are in known positions
			n_str = args[1];
			y_str = args[0];

			if(n_str[0] == '['){
				ny = match_args(n_str+y_str);
				n = ny[0]
				y = ny[1]
			} else {
				n = parseInt(n_str);
				y = parseInt(y_str);
			}
		}
		console.log(fibs(n, y))
	}
}

parse_args(process.argv.reverse());