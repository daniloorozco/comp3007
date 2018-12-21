% Assignment, Question 2 Part b
% COMP 3007-A, Fall 2018
% Danilo Orozco

countInRange([], _, _, 0).

countInRange([H|T], A, B, Count) :- (H >= A, H =< B), countInRange(T, A, B, X1), Count is 1 + X1.
countInRange([H|T], A, B, Count) :- (H < A ; H > B), countInRange(T, A, B, Count).
	
