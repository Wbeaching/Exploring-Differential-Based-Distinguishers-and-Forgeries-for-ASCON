% Use this editor as a MiniZinc scratch book
include "globals.mzn";
include "chuffed.mzn";

int :nr; % Number of Rounds
int :wordsize=64; % word size
int :bit=320; % Number of bits
int: R = nr-1;% just because starting R from 1 doesnt work!
array [0..R,0..4, 0..wordsize-1] of var 0..1: statestart; % before permutation
array [0..R,0..4, 0..wordsize-1] of var 0..1: stateend; % after permutation
array [0..64*(R+1)-1] of var {0,2,3,4}: prb; % probabilities
var int: obj; % objective value
constraint obj <= 320;
constraint obj >= 1;
constraint obj = sum(prb); % Objective Function
array [0..R,0..63] of var bool: sboxes;

array [1..317, 1..11] of int : DDT = array2d(1..317, 1..11, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 3, 0, 0, 0, 0, 1, 0, 1, 0, 1, 1, 3, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 3, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 3, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 3, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0, 3, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 3, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 3, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 3, 0, 0, 0, 1, 0, 1, 0, 0, 1, 1, 3, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 3, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1, 3, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1, 3, 0, 0, 0, 1, 0, 1, 1, 0, 1, 1, 3, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 3, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 3, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 3, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 3, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 3, 0, 0, 0, 1, 1, 0, 1, 1, 0, 1, 3, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 3, 0, 0, 0, 1, 1, 1, 0, 1, 0, 0, 3, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 3, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 3, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 2, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 2, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 2, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 2, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 3, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 3, 0, 0, 1, 0, 1, 1, 0, 1, 0, 0, 3, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 3, 0, 0, 1, 0, 1, 1, 1, 0, 0, 0, 3, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 3, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 3, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 3, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 4, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 4, 0, 0, 1, 1, 0, 0, 0, 1, 0, 1, 4, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 4, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 4, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 4, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 4, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 4, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 4, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 4, 0, 0, 1, 1, 0, 1, 0, 1, 0, 1, 4, 0, 0, 1, 1, 0, 1, 0, 1, 1, 1, 4, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 4, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 4, 0, 0, 1, 1, 0, 1, 1, 1, 0, 1, 4, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 4, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 3, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 3, 0, 0, 1, 1, 1, 0, 0, 1, 1, 0, 3, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 3, 0, 0, 1, 1, 1, 0, 1, 0, 1, 0, 3, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 3, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 3, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 3, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 3, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 3, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 3, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 3, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 3, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 3, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 3, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 3, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 4, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 4, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 4, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 4, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 4, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 4, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 4, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 4, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 4, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 4, 0, 1, 0, 0, 1, 1, 0, 1, 0, 1, 4, 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 4, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 4, 0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 4, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 4, 0, 1, 0, 0, 1, 1, 1, 1, 1, 0, 4, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 4, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 4, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 4, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 4, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 4, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 4, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 4, 0, 1, 0, 1, 0, 0, 1, 1, 1, 1, 4, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 4, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 4, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 4, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 4, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1, 4, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 4, 0, 1, 0, 1, 0, 1, 1, 1, 0, 0, 4, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 4, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 4, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 4, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 4, 0, 1, 0, 1, 1, 0, 0, 1, 1, 1, 4, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 4, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 4, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 4, 0, 1, 0, 1, 1, 0, 1, 1, 1, 1, 4, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 4, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 4, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 4, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 4, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0, 4, 0, 1, 0, 1, 1, 1, 1, 0, 1, 1, 4, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 4, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 4, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 2, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 2, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 2, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 2, 0, 1, 1, 0, 1, 0, 0, 0, 0, 1, 4, 0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 4, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 4, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 4, 0, 1, 1, 0, 1, 0, 1, 0, 0, 0, 4, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 4, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 4, 0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 4, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 4, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 4, 0, 1, 1, 0, 1, 1, 0, 1, 0, 0, 4, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 4, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1, 4, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 4, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 4, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 4, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 3, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 3, 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 3, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 3, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 3, 0, 1, 1, 1, 0, 1, 0, 0, 1, 0, 3, 0, 1, 1, 1, 0, 1, 0, 1, 0, 0, 3, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 3, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 3, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 3, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 3, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 3, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 3, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 3, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 3, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 3, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 2, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 2, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 2, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 2, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 2, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 2, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 2, 1, 0, 0, 0, 1, 1, 0, 1, 1, 1, 2, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 4, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 4, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 4, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 4, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 4, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 4, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 4, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 4, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 4, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 4, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 4, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 4, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 4, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 4, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 4, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 4, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 2, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 2, 1, 0, 0, 1, 1, 0, 1, 0, 1, 0, 2, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 2, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 3, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 3, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 3, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 3, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 3, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 3, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 3, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 3, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 3, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 3, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 3, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 3, 1, 0, 1, 0, 1, 1, 0, 0, 1, 1, 3, 1, 0, 1, 0, 1, 1, 1, 1, 0, 1, 3, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 3, 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 4, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 4, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 4, 1, 0, 1, 1, 0, 1, 0, 0, 1, 1, 4, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 4, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 4, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 4, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 4, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 4, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 4, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 4, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 4, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 4, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 4, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 4, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 4, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0, 3, 1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 3, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 3, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 3, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0, 3, 1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 3, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 3, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 3, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 4, 1, 1, 0, 0, 0, 0, 0, 1, 0, 1, 4, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 4, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 4, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 4, 1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 4, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 4, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 4, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 4, 1, 1, 0, 0, 0, 1, 0, 1, 0, 1, 4, 1, 1, 0, 0, 0, 1, 0, 1, 1, 0, 4, 1, 1, 0, 0, 0, 1, 0, 1, 1, 1, 4, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 4, 1, 1, 0, 0, 0, 1, 1, 1, 0, 1, 4, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 4, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 4, 1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 3, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 3, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 3, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 3, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 3, 1, 1, 0, 0, 1, 1, 0, 1, 0, 1, 3, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 3, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 3, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1, 4, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 4, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 4, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 4, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 4, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 4, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 4, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 4, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 4, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 4, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 4, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 4, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 4, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1, 4, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 4, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 4, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 4, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 4, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 4, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 4, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 4, 1, 1, 0, 1, 1, 0, 1, 0, 1, 1, 4, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 4, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 4, 1, 1, 0, 1, 1, 1, 0, 0, 1, 0, 4, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 4, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 4, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 4, 1, 1, 0, 1, 1, 1, 1, 0, 1, 0, 4, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 4, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 4, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 4, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 3, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 3, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 3, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 3, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 3, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 3, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 3, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 3, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 3, 1, 1, 1, 0, 1, 0, 0, 1, 0, 1, 3, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 3, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 3, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 3, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 3, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 3, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 3, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 4, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 4, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 4, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 4, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 4, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 4, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 4, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 4, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 4, 1, 1, 1, 1, 0, 1, 1, 0, 0, 1, 4, 1, 1, 1, 1, 0, 1, 1, 0, 1, 0, 4, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 4, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 4, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 4, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 4, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 4, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 3, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 3, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 3, 1, 1, 1, 1, 1, 0, 0, 1, 0, 1, 3, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 3, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 3, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 3, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 3]);




% Forward Substitution
constraint forall (r in 0..R, i in 0..wordsize-1) (
             table([statestart[r,0,i],statestart[r,1,i], statestart[r,2,i], statestart[r,3,i], statestart[r,4,i],
                    stateend[r,0,i],stateend[r,1,i], stateend[r,2,i], stateend[r,3,i], stateend[r,4,i],
              prb[64*(r)+i]], DDT));
              
% Forward Permutation
% row 0
constraint forall (r in 0..R-1) (
let {
    array [0..wordsize-1] of var 0..1:tmp=RRot(array1d(0..wordsize-1,[stateend[r,0,j] | j in 0..wordsize-1]),19),
    array [0..wordsize-1] of var 0..1:tmpb=RRot(array1d(0..wordsize-1,[stateend[r,0,j] | j in 0..wordsize-1]),28),
    array [0..wordsize-1] of var 0..1:tmpc=array1d(0..wordsize-1,[stateend[r,0,j] | j in 0..wordsize-1]),
    array [0..wordsize-1] of var 0..1:tmpd=array1d(0..wordsize-1,[statestart[r+1,0,j] | j in 0..wordsize-1])
}
in Xor4(tmp, tmpb, tmpc, tmpd)
);
% row 1
constraint forall (r in 0..R-1) (
let {
    array [0..wordsize-1] of var 0..1:tmp=RRot(array1d(0..wordsize-1,[stateend[r,1,j] | j in 0..wordsize-1]),61),
    array [0..wordsize-1] of var 0..1:tmpb=RRot(array1d(0..wordsize-1,[stateend[r,1,j] | j in 0..wordsize-1]),39),
    array [0..wordsize-1] of var 0..1:tmpc=array1d(0..wordsize-1,[stateend[r,1,j] | j in 0..wordsize-1]),
    array [0..wordsize-1] of var 0..1:tmpd=array1d(0..wordsize-1,[statestart[r+1,1,j] | j in 0..wordsize-1])
}
in Xor4(tmp, tmpb, tmpc, tmpd)
);
% row 2
constraint forall (r in 0..R-1) (
let {
    array [0..wordsize-1] of var 0..1:tmp=RRot(array1d(0..wordsize-1,[stateend[r,2,j] | j in 0..wordsize-1]),1),
    array [0..wordsize-1] of var 0..1:tmpb=RRot(array1d(0..wordsize-1,[stateend[r,2,j] | j in 0..wordsize-1]),6),
    array [0..wordsize-1] of var 0..1:tmpc=array1d(0..wordsize-1,[stateend[r,2,j] | j in 0..wordsize-1]),
    array [0..wordsize-1] of var 0..1:tmpd=array1d(0..wordsize-1,[statestart[r+1,2,j] | j in 0..wordsize-1])
}
in Xor4(tmp, tmpb, tmpc, tmpd)
);
% row 3
constraint forall (r in 0..R-1) (
let {
    array [0..wordsize-1] of var 0..1:tmp=RRot(array1d(0..wordsize-1,[stateend[r,3,j] | j in 0..wordsize-1]),10),
    array [0..wordsize-1] of var 0..1:tmpb=RRot(array1d(0..wordsize-1,[stateend[r,3,j] | j in 0..wordsize-1]),17),
    array [0..wordsize-1] of var 0..1:tmpc=array1d(0..wordsize-1,[stateend[r,3,j] | j in 0..wordsize-1]),
    array [0..wordsize-1] of var 0..1:tmpd=array1d(0..wordsize-1,[statestart[r+1,3,j] | j in 0..wordsize-1])
}
in Xor4(tmp, tmpb, tmpc, tmpd)
);
% row 4
constraint forall (r in 0..R-1) (
let {
    array [0..wordsize-1] of var 0..1:tmp=RRot(array1d(0..wordsize-1,[stateend[r,4,j] | j in 0..wordsize-1]),7),
    array [0..wordsize-1] of var 0..1:tmpb=RRot(array1d(0..wordsize-1,[stateend[r,4,j] | j in 0..wordsize-1]),41),
    array [0..wordsize-1] of var 0..1:tmpc=array1d(0..wordsize-1,[stateend[r,4,j] | j in 0..wordsize-1]),
    array [0..wordsize-1] of var 0..1:tmpd=array1d(0..wordsize-1,[statestart[r+1,4,j] | j in 0..wordsize-1])
}
in Xor4(tmp, tmpb, tmpc, tmpd)
);

% eliminating symmetries
% constraint checkActive([statestart[2,i,63] | i in 0..4]) = 1; 
% search strategy
ann: search_ann;
search_ann = seq_search([
    int_search(row(sboxes,2), random_order, indomain_min, complete),
    int_search(row(sboxes,1), random_order, indomain_min, complete),
    int_search(row(sboxes,0), random_order, indomain_min, complete),
    int_search(row(sboxes,3), random_order, indomain_min, complete),
    int_search(row(sboxes,4), random_order, indomain_min, complete),
    int_search(row(sboxes,5), random_order, indomain_min, complete),
    int_search(array1d(prb), occurrence, indomain_min, complete)]);


constraint forall(k in 0..R, j in 0..63) (sboxes[k,j] = checkActive([statestart[k,i,j] | i in 0..4]));
solve :: restart_constant(10000)
:: search_ann minimize obj;



% Right rotation of X by val positions
function array[0..wordsize-1] of var 0..1: RRot(array[0..(wordsize-1)] of var 0..1: X, int: val)=
array1d(0..wordsize-1, [X[(wordsize+j-val) mod wordsize] | j in 0..wordsize-1]);

% XOR of 4 arrays equals zero
predicate Xor4(
  array[0..wordsize-1] of var 0..1: a, 
  array[0..wordsize-1] of var 0..1: b,
  array[0..wordsize-1] of var 0..1: c, 
  array[0..wordsize-1] of var 0..1: d)=
    forall(i in 0..wordsize-1)(a[i]+b[i]+c[i]+d[i] in {0,2,4});

% checking activeness of each Sbox
predicate checkActive(array[int] of var 0..1: a) = 
            let { int: len = length(a) }
          in
            sum(i in 1..len) (a[i]) > 0;

% for printing purposes only
array[0..R] of var int: Sboxes;
constraint forall (k in 0..R)(
  Sboxes[k] = sum(j in 0..63)(bool2int(checkActive([statestart[k,i,j] | i in 0..4])))
);

output [
        if i==0 then "\n Round " ++show(r) ++"\n beforeSB : \n" else "" endif 
        ++ if i<5 then show([statestart[r,i,j] | j in 0..wordsize-1]) ++ " \n" else "" endif ++
        if i==4 then "after SB : \n" else "" endif 
         ++ if i>=4 then show([stateend[r,i-4,j] | j in 0..wordsize-1]) ++ " \n" else "" endif   | r in 0..R, i in 0..8]  
         ++ [show([Sboxes[i] | i in 0..R]) ++ " " ++ show(obj) ++ "\n"] ++ [show([prb[i] | i in 64*k..64*(k+1)-1]) ++ " " ++ show(sum([prb[i] | i in 64*k..64*(k+1)-1])) ++ "\n" | k in 0..R ];