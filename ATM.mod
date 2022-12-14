
# ----------------------------------------
# ATM PROBLEM
# USING BENDERS DECOMPOSITION
# (using dual formulation of subproblem)
# ----------------------------------------

### SUBPROBLEM ###
set CASE := {1 .. 7}; # scenario

param p {CASE} > 0; # probability of scenario
param chi {CASE} > 0; # random number from random variable
param x_dual > 0; # auxiliar variable in second stage problem
param q_fix > 0; # fixed cost for money reposition

param BIG := 1.0e+9;        # objective > BIG ==> unbounded

var pi {CASE} >= 0; # dual variables

maximize dual_cost: sum {i in CASE} pi[i]*(chi[i] - x_dual);

subject to bound {i in CASE}: pi[i] <= p[i]*q_fix; # constraint of subproblem

### MASTER PROBLEM ###

param nCUT >= 0 integer;
param cut_type {1..nCUT} symbolic within {"point","ray"};
param c > 0; # cost of money

param l > 0;
param u > 0;

param Pi {i in CASE, 1..nCUT}; # dual variable in the MASTER

var x >= 0; # money to get backs
var z; # auxiliar variable

minimize cost: c*x + z;
   # sum {i in ORIG} fix_cost[i] * Build[i] + Max_Ship_Cost;

subject to Cut_Defn {k in 1..nCUT}:
   if cut_type[k] = "point" then z >= sum {i in CASE} Pi[i, k]*(chi[i] - x);

subject to r1: x >= l;
subject to r2: x <= u;
