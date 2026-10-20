"""Exact rational audit of optimal two-moment Rouché shielding.

For the genuine theta weight w_Y, let A=integral(w_Y), M=integral(u²*w_Y).
The holomorphic heat difference obeys
 B(tau)<=A*(1-exp(-tau*M/A))
       <=2*A*tau*M/(2*A+tau*M)<=tau*M.
The first inequality is Jensen and is sharp for an atomic measure.
This executable checks only rational Padé and contour algebra.
Neither the theta integrals nor RH are certified by the script.
"""
from fractions import Fraction as F
from random import Random
from math import log
rng=Random(20261020)
count=0
for _ in range(25000):
    A=F(rng.randint(1,200),rng.randint(1,100))
    M=F(rng.randint(1,200),rng.randint(1,100))
    m=A*F(rng.randint(1,999),1000)
    linear=m/M
    pade=2*A*m/(M*(2*A-m))
    assert 0<m<A and 0<linear<pade
    tau=(linear+pade)/2
    bound=2*A*tau*M/(2*A+tau*M)
    assert tau*M>m and bound<m and bound<tau*M
    assert (bound<m)==(tau*M*(2*A-m)<2*A*m)
    count+=1
print(f"PASS {count} exact rational strict shielding improvements")
A,M,m,tau=F(10),F(20),F(6),F(2,5)
assert tau*M==8>m
assert 2*A*tau*M/(2*A+tau*M)==F(40,7)<m
assert m/M==F(3,10)<tau<F(3,7)
print("PASS explicit rational example: linear bound 8>6, improved bound 40/7<6")
for q in (F(1,1000),F(1,10),F(1,2),F(9,10),F(99,100)):
    x=float(q)
    assert x<2*x/(2-x)<-log(1-x)
print("PASS independent floating-point check of ordered analytic thresholds")
print("UNPROVED: global theta contour minima; RH remains open")
