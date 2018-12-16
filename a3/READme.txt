Assignment 3
COMP 3007-A, Fall 2018
2018/11/10

Question 1:
floatGenerator :: Int -> Float

- to run, open winghci and load the file and enter; 
-> floatGenerator 2
(or any other integer you want to choose)

Question 2:
Structure:
data Expr = X | Lit Float | Addition Expr Expr | Subtraction Expr Expr | Multiplication Expr Expr | Division Expr Expr

Question 3:

Part 1; Evaluation
eval :: Expr -> Float -> (Maybe Float)

Part 2; String Representation
toString :: Expr -> String

Part 3; Tree drawing function
drawTree :: Expr -> Int -> String

For testing the above functions, I have provided equations at bottom of the .hs file that will work if you input the following into winghci;
ex:

part 1:
-> eval test1 0
-> eval test2 0
...

part 2;
-> toString test1
-> toString test4
...

**FOR TESTING PART 3 make sure to run with the following 
part 3;
-> putStrLn $ drawTree test4 0
-> putStrLn $ drawTree test3 0

NOTES:
- the last parameters in eval and drawTree is the value that will substitute the variable X if it exists in the equation
- you can also enter your own equations and run it like;
->eval Addition (Addition (Lit 4) (Subtraction (Lit 4) (Subtraction (X) (Lit 2)))) (Multiplication (Lit 4) (Lit 2)) 2
->drawTree Addition (Addition (Lit 4) (Subtraction (Lit 4) (Subtraction (X) (Lit 2)))) (Multiplication (Lit 4) (Lit 2)) 4
