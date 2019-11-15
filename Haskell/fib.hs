-- Aidan Fitzpatrick - NAB Technology Internship Program Code Test
-- Find the number of numbers exactly y-digits long in a fibonacci sequence
-- of length n.

-- The workhorse of the program - takes input from the user and produces the
-- requested output for the problem.
--
-- Note this input method only accepts the numbers one-at-a-time, since
-- input in Haskell is quite difficult to manage at the main level without
-- requiring a specific input type.

main :: IO ()
main = do
    putStrLn "Enter the number of fibonacci sequence numbers to generate: "
    n0 <- getLine
    let n = (read n0 :: Int)
    putStrLn "Enter how many digits in length numbers in the sequence to be counted must be: "
    y0 <- getLine
    let y = (read y0 :: Int)
-- This is probably the most interesting line in the whole program.
    let soln = show $ length $ filter (== y) (fibLengths n)
    putStrLn $ "There are " ++ soln ++ " numbers of length " ++ (show y) ++ " in the first " ++ (show n) ++ " fibonacci numbers." 
-- (length.show) is a composite function (if you've never seen one before). It
-- works in the same way as composite functions in maths, ie. (f.g) (x) = f(g(x))
        where fibLengths n = map (length.show) (take n fibs)

-- A function to generate all the numbers in the fibonacci sequence.
-- Takes no input, only provides the infinite list of fibonacci numbers.
-- fibs is tail recursive.
fibs :: [Integer]
fibs = 0:1:zipWith (+) fibs (tail fibs)