-- Assignment 3
-- COMP 3007-A, Fall 2018
-- Danilo Orozco
-- 2018/11/10

import Data.Maybe
-- Question 1
floatGenerator :: Int -> Float
floatGenerator x = fromIntegral (randomGenerator x :: Int) / 10

randomGenerator :: Int -> Int
randomGenerator num = randomNum
   where randomNum = (x - 1) `mod` 10
         x = 7 * (num) `mod` 101

-- Question 2
data Expr = X | Lit Float | Addition Expr Expr | Subtraction Expr Expr | Multiplication Expr Expr | Division Expr Expr

-- Question 3, evaluation function (part 1)
eval :: Expr -> Float -> (Maybe Float)
eval (X) var = (Just var)
eval (Lit x) var = (Just x)
eval (Addition x y) var
 | eval x var == Nothing || eval y var == Nothing = Nothing
 | otherwise = Just (fromJust (eval x var) + fromJust (eval y var))
eval (Subtraction x y) var
 | eval x var == Nothing || eval y var == Nothing = Nothing
 | otherwise = Just (fromJust (eval x var) - fromJust (eval y var))
eval (Multiplication x y) var
 | eval x var == Nothing || eval y var == Nothing = Nothing
 | otherwise = Just (fromJust (eval x var) * fromJust (eval y var))
eval (Division x y) var
 | (fromJust (eval y var) == 0) = Nothing
 | otherwise = Just (fromJust (eval x var) / fromJust (eval y var))

 -- Question 3, toString function (part 2)
toString :: Expr -> String
toString (X) = "X"
toString (Lit x) = show x
toString (Addition x y) = ("(" ++ (toString x) ++ " + " ++ (toString y) ++ ")")
toString (Subtraction x y) = ("(" ++ (toString x) ++ " - " ++ (toString y) ++ ")")
toString (Multiplication x y) = ("(" ++ (toString x) ++ " * " ++ (toString y) ++ ")")
toString (Division x y) = ("(" ++ (toString x) ++ " / " ++ (toString y) ++ ")")

-- Question 3, drawing tree function (part 3)
space :: Int -> [Char]
space 0 = []
space n = "      " ++ space (n-1)

drawTree :: Expr -> Int -> String
drawTree (X) _ = "X"
drawTree (Lit x) _ = show x
drawTree (Addition x y) row = "( + ):---:" ++ drawTree x (row + 1) ++ "\n" ++ space row ++ " |\n" ++ space row ++ "-----:" ++ drawTree y (row + 1) 
drawTree (Subtraction x y) row = "( - ):---:" ++ drawTree x (row + 1) ++ "\n" ++ space row ++ " |\n" ++ space row ++ "-----:" ++ drawTree y (row + 1) 
drawTree (Multiplication x y) row = "( * ):---:" ++ drawTree x (row + 1) ++ "\n" ++ space row ++ " |\n" ++ space row ++ "-----:" ++ drawTree y (row + 1) 
drawTree (Division x y) row = "( / ):---:" ++ drawTree x (row + 1) ++ "\n" ++ space row ++ " |\n" ++ space row ++ "-----:" ++ drawTree y (row + 1)

-- Question 4, mutation of tree
mutateTree :: Expr -> Expr
mutateTree (Lit x) = (Lit (floatGenerator x))
mutateTree (Addition x y) = (Addition x (Multiplication (mutateTree x) (mutateTree y)))
mutateTree (Subtraction x y) = (Subtraction x (Multiplication (mutateTree y) (mutateTree x)))
mutateTree (Multiplication x y) = (Multiplication x (Addition (mutateTree y) (mutateTree x)))
mutateTree (Division x y) = (Division x (Addition (mutateTree x) (mutateTree y)))

-- **FOR TESTING
test1 = Addition (Lit 3) (Lit 7)
test2 = Subtraction (Lit 1) (Division (Lit 2) (Lit 2))
test3 = Division (Addition (Lit 4) (Lit 7)) (Multiplication (Lit 4) (Lit 2))
test4 = Addition (Addition (Lit 4) (Subtraction (Lit 4) (Subtraction (X) (Lit 2)))) (Multiplication (Lit 4) (Lit 2))
test5 = Addition (Subtraction (Multiplication (Lit 4) (X)) (Lit 1)) (Lit 4)
test6 = Division (Lit 1) (Lit 0)
