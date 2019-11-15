<!--- This readme is in standard .md format and can be viewed in any normal markdown viewer (or simply as plaintext if you can't be bothered). I've provided it for convenience to allow easy reference to all the solutions I have provided. -->
# NAB Technology Internship Coding Challenge
I have written multiple different solutions in a variety of languages. This file includes instructions on how to compile and/or run these files, since there is at least one implementation outside of the list of allowed programming languages (which I thought would be good to include bcause it is by far the simplest solution out of any, being written in a Declarative Programming Language).

This file has instructions for the following implementations (in order):
1. bash
2. C
3. C++
4. Haskell
5. Java
6. JavaScript
7. Python
8. Visual Basic

This set of solutions is also available at github: https://github.com/Chewyfitz/coding-challenge-nab-2019
The repository will be made public at (approximately) 5pm on Monday the 18th of November so as to deter any copying by others attempting the challenge.

## fib.sh [Bash]

I'm not overly familiar with Bash (the only time I've used it is for personal projects out of, but I thought I'd give this a go anyway so that I can get a bit more experience. 
This implementation requires `bc` for `N` values `>=93`. This might seem arbitrary, but it's the largest number which overflows with bash built-in maths.

This script works in four main modes:
1. `./fib.sh [N,Y]`;
2. `./fib.sh [N, Y]`, with a space in between `N,` and `Y`;
3. `./fib.sh N Y`, supplying the arguments outside of brackets; and
4. `./fib.sh`, which prompts the user for both values.

It's possible you may be required to run the file as `sh ./fib.sh (args)`, but I didn't have to in my testing. If this is the case, it's possible the command-line arguments might break, so you might be forced to use the prompt-based version if this hasn't been fixed.

The output for this script is printed to the console.

## fib.c [C]

## fib.cpp [C++]

## fib.hs [Haskell]
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

## fib.java [Java]

## fib.js [JavaScript]

## fib.py [Python]

## fib.vbs [Visual Basic]

I'm... not really sure what's going on with vba to be perfectly honest. 
In theory this should work in any context that Visual Basic scripts are allowed.
The input for this script is a little different because VBScript IO is particularly partial to native/dialogue box style input and alert boxes.
To run the script you can either do `cscript fib.vbs` or simply double-click on the script in windows explorer.
The only available input type is the interactive input mode.
This implementation does not work for a very high fibonacci sequence number (only tested up to `N=1000`).