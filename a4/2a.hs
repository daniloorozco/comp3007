-- Assignment 4, Question 2 Part A
-- COMP 3007-A, Fall 2018
--  Danilo Orozco

countInRange :: [Int] -> Int -> Int -> Int
countInRange list num1 num2 = helperCount list num1 num2 0

-- helper function for tail-call optimization
helperCount :: [Int] -> Int -> Int -> Int -> Int
helperCount [] _ _ acc = acc
helperCount (x:xs) lower upper acc
     | x >= lower && x <= upper = helperCount xs lower upper (acc+1)
     | otherwise = helperCount xs lower upper (acc)