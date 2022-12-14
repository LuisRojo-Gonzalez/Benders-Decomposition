
# ----------------------------------------
# ATM PROBLEM
# ----------------------------------------

### SUBPROBLEM ###
set CASE := {1 .. 7}; # scenario

param p {CASE} > 0; # probability of scenario
param chi {CASE} > 0; # random number from random variable
param q_fix > 0; # fixed cost for money reposition
param c > 0;
param l > 0;
param u > 0;

var y {CASE} >= 0;
var x >= 0;

minimize cost: c*x + sum{i in CASE} p[i]*q_fix*y[i];

subject to r1: x >= l;
subject to r2: x <= u;
subject to r3 {i in CASE}: x + y[i] >= chi[i];
