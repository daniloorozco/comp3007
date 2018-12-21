% Assignment, Question 3
% COMP 3007-A, Fall 2018 
% Danilo Orozco
% to change time, change the time in minutes in the solve(M,<time-here>) on life 6

solution(M) :- solve(M,15).

initial([legolas,aragorn,gilmi,gandalf]).

solve(M,D) :-
  initial(T),
  transition(state(torch, T), state(cross, []), M, D1),
  D1 =< D.

% take torch back to initial
crossBridge(state(torch,L1),state(cross,L2), cross(M),D) :- 
  splitList(L1,M,L2),
  calcTime(M,D).

% take torch across the bridge   
crossBridge(state(cross ,L1),state(torch,L2),torch(X),D) :-
  initial(T),
  subtract(T,L1,R),
  member(X,R),
  ord_union([X],L1,L2),
  person(X,D).

transition(state(cross,[]),state(cross, []), [], 0).    
transition(S,U,L,D) :-
  crossBridge(S,T,M,X),
  transition(T,U,N,Y),
  append([M],N,L),
  D is X + Y.

calcTime([],0) :- !.
calcTime([X|L],C) :- 
  person(X,S), 
  calcTime(L,D), 
  C is max(S,D).

splitList(L,[X,Y],M) :- 
  member(X,L),
  member(Y,L),
  compare(<,X,Y),  
  subtract(L,[X,Y],M).

person(legolas,1).
person(aragorn,3).
person(gilmi,5).
person(gandalf,8).