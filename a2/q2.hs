--DANILO OROZCO, 101035548
--comp3007 assignment 2, question 2
--2018/10/14

-- Data structure consisting of True, False and None
-- deriving Show
data TripleBoolean = Troo | Falz | None deriving (Show)

-- Based off Three Valued Logic
-- True is false, false is true, none is none.
ternaryNOT :: TripleBoolean -> TripleBoolean
ternaryNOT Troo = Falz
ternaryNOT Falz = Troo
ternaryNOT None = None

-- input: two operands which can be True, False or None. 
-- ternaryAND operator
ternaryAND :: TripleBoolean -> TripleBoolean -> TripleBoolean
ternaryAND Falz _ = Falz
ternaryAND _ Falz = Falz
ternaryAND None _ = None
ternaryAND _ None = None
ternaryAND _ _ = Troo

-- ternaryOR operator
ternaryOR :: TripleBoolean -> TripleBoolean -> TripleBoolean
ternaryOR Troo _ = Troo
ternaryOR _ Troo = Troo
ternaryOR None _ = None
ternaryOR _ None = None
ternaryOR _ _ = Falz
