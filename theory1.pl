:- consult('core2.pl').

fact(bird(tweety)).
fact(penguin(charles)).

strict(r1,knowledge,bird(X),penguin(X)).
defeasible(r2,knowledge,fly(X),bird(X)).
defeater(r3,knowledge,~(fly(X)),penguin(X)).
% superior(r3,r2).
