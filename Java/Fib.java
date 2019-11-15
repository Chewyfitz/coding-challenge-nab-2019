/* Aidan Fitzpatrick - Fib.java
 * 
 */
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import java.math.*;


public class Fib {
	public static int[] parseArgs(String args[]){
		// Parse the input args to get `N` and `Y`, or prompt the user for them
		// if they were not supplied.
		int n = 0; int y = 0;
		if(args.length == 2){
			// Parse `[N, Y]` and `N Y` cases
			if(args[0].charAt(0) == '['){
				// the `[N, Y]` case
				String str = args[0] + args[1];
				// the regex string to match
				Pattern p = Pattern.compile("\\[([0-9]+)\\,\\s*([0-9]+)\\]");
				Matcher m = p.matcher(str);
				if(!m.find()){ // If we don't find any matches, exit
					System.err.println("Parsing failed - make sure input format is correct.");
					System.exit(1);
				}
				// parse the input arguments as int
				n = Integer.parseInt(m.group(1)); 
				y = Integer.parseInt(m.group(2));
			} else {
				// the `N Y` case
				n = Integer.parseInt(args[0]);
				y = Integer.parseInt(args[1]);
			}
			
		} else if (args.length == 1){
			// Parse the `[N,Y]` case
			Pattern p = Pattern.compile("\\[([0-9]+)\\,([0-9]+)\\]");
			Matcher m = p.matcher(args[0]);
			if(!m.find()){
				System.err.println("Parsing failed - make sure input format is correct.");
				System.exit(1);
			}
			n = Integer.parseInt(m.group(1)); 
			y = Integer.parseInt(m.group(2));

		} else {
			if(args.length > 2){
				System.out.println("Error: Too many arguments. Entering interactive mode...");
			}
			// Interactive mode
			Scanner sc = new Scanner(System.in);
			// Get N
			System.out.println("Enter the number of fibonacci sequence numbers to generate: ");
			String N_str = sc.next();
			// Get Y
			System.out.println("Enter how many digits in length numbers in the sequence to be counted must be: ");
			String Y_str = sc.next();
			// Parse them into Integers (space here for errors to be handled)
			n = Integer.parseInt(N_str);
			y = Integer.parseInt(Y_str);
		}
		int[] ny = {n, y};
		return ny;
	}

	public static void main(String args[]) {
		// Get the N and Y values
		int[] NY = parseArgs(args);
		int n = NY[0]; int y = NY[1];

		// Generate the fibonacci array
		int count = 0;
		if(y == 1){
			// Add the counts for fibs[0] and fibs[1] if we're looking for
			// y == 1, since these aren't created in the loop.
			count += 2;
		}
		// Use BigIntegers so we can handle arbitrarily large numbers
		BigInteger[] fibs = new BigInteger[n];
		// Initialise the first two elements
		fibs[0] = BigInteger.valueOf(0);
		fibs[1] = BigInteger.valueOf(1);
		for(int i = 2; i < n; i++){
			fibs[i] = BigInteger.valueOf(0).add(fibs[i-1]).add(fibs[i-2]);
			if(fibs[i].toString().length() == y){
				// If the number is the right length, count it.
				count++;
			}
		}

		// Count the number of array elements which are `Y` long
		System.out.println(count);
	}
}