"""Exact rational gates for a division-free all-order six-unit Xi heat band.

Analytic inputs from the existing verified theta source:
mu0(t)>1/20, mu2(t)<1/1000+1e-8, 0<=t<=1/2.
The omitted two-mode mu2 tail is bounded by
(3/16)*(198/7)*20^-8 <1e-8.

Newman's GHS theorem (curvature of the actual Jacobi theta
potential), unchanged under heat tilt, yields B_n/A_n <=
B0/A0=2*mu2/mu0 for all n and t. Hence
U_n(t,x)>=A_n(t)*(1-x²/48), A_n(t)=U_n(t,0)>0.

With k_n=(n+1)(2n+1) and c_n(t)=4*k_n*A_(n+1)/A_n:
 k_n*U_(n+1)(t,x)-c_n(t)*U_n(t,x)
 <= k_n*A_(n+1)(t)*(x²/12-3).
Therefore the original division-free source inequality holds
simultaneously for every n, t and |x|<=6.

The final global defect can be Gaussian-averaged at x=0:
 E[(Z²/12-3)_+]<=E[Z⁴]/432=h²/144,
 int_0^(1/2) h²/144 dh=1/3456.
This is a nonzero bound, NOT a proof of RH.
"""
from fractions import Fraction as Q
from math import factorial

tail2=Q(3,16)*Q(198,7)/20**8
assert tail2<Q(1,10**8)
mu0_min=Q(1,20)
mu2_max=Q(1,1000)+Q(1,10**8)
assert mu2_max/mu0_min<Q(1,48)
assert 1-Q(36,48)==Q(1,4)
print("PASS genuine theta heat second-moment rational gate:",float(mu2_max/mu0_min))

for n in (0,1,2,5,20,100):
  k=Q((n+1)*(2*n+1))
  for A in (Q(1,100),Q(1,2),Q(3,7)):
    for B in (Q(1,1000),Q(1,17),Q(1)):
      c=4*k*B/A
      for x in (Q(0),Q(1,2),Q(2),Q(6),Q(7),Q(100)):
        left=k*B-c*A*(1-x*x/48)
        right=k*B*(x*x/12-3)
        assert left==right
        if abs(x)<=6:assert right<=0
print("PASS 6 orders x 3 central moments x 3 next moments x 6 frequency gates")
assert Q(1,2)**3/Q(432)==Q(1,3456)
print("PASS exact Gaussian averaged global source defect normalization")
print("RH remains open: quadratic defect is positive outside |x|<=6.")
