<!--- This readme is in standard .md format and can be viewed in any normal markdown viewer (or simply as plaintext if you can't be bothered). I've provided it for convenience to allow easy reference to all the solutions I have provided. -->
# NAB Technology Internship Coding Challenge
I have written multiple different solutions in a variety of languages. This file includes instructions on how to compile and/or run these files, since there is at least one implementation outside of the list of allowed programming languages (which I thought would be good to include bcause it is by far the simplest solution out of any, being written in a Declarative Programming Language).

## fib.sh


## fib.hs
This is a Haskell file. Unfortunately taking command-line input in Haskell is not an easy task (it can be done, but it's much easier to take arguments one at a time since the main function does not allow polymorphism), so I've instead opted to use a different format of asking for the arguments one-by-one. 
The following instructions are provided for anyone who is unfamiliar with Haskell.

To run the program:
1. Install `ghc`
2. Compile the program with `ghc fib.hs`
3. Run the program with `./fib`

You are then provided with a prompt `Enter the number of fibonacci sequence numbers to generate:`, which requests the `n` value, followed by a second prompt `Enter how many digits in length numbers in the sequence to be counted must be: `, which requests the `y` value.
Once you have provided those two values the answer will be printed to the console.
Since the definition of `fibs` is one line, you are also welcome to explore it in `ghci`, where you can define `fibs` with `let fibs = 0:1:zipWith (+) fibs (tail fibs)`.
You can then view any amount of fibonacci numbers with the command `take [number] fibs`.
(also a reminder that the command to quit `ghci` is `:q`, similarly to vim)