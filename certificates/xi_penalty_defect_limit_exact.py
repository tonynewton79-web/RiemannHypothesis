"""Exact rational penalty-defect checks for theta-heat research (NOT RH).

H_t=z²-2t, s=1/2-t gives U1=2x²+2-4s, U2=1.
At the double-zero endpoint E_C(T,0)=6 for ALL finite C,
but the positive Gaussian-heat convolution is at most 9/C.
The support is in T-3/(2C)<r<=T and 0<=E_C<=6.

For a negative target U(s,x)=1-2s, U2=1/3,
the same heat PDE has nonnegative initial value, but
the convolved penalty defect >=3C/16 at s=1, all x.
This is exact algebra for control models. The analytic theta
penalty-limit/RH equivalence and semigroup are paper proofs.
"""
from fractions import Fraction as Q
def pos(x):return max(Q(0),x)
for C in [3,6,12,30,100,1000,10000]:
    T=Q(1,2)
    U1=lambda s,x:2*x*x+2-4*s
    assert pos(6-C*U1(T,Q(0)))==6
    width=Q(3,2*C)
    assert 0<width<=T
    assert 6*width==Q(9,C)
    print("collision C=",C,"point defect=6; heat error <=",Q(9,C))
assert 2*(Q(0)**2+T)+2==6*T==3
for C in [1,2,6,30,1000]:
    # integral_[3/4,1] C*(2r-1)dr=3C/16
    integral=C*((Q(1)**2-Q(1))-(Q(3,4)**2-Q(3,4)))
    assert integral==Q(3*C,16)>0
    print("negative model C=",C,"convolved defect >=",integral)
print("PASS: exact rational collision/negative-region penalty dichotomy")
print("No complete theta-series comparison or Riemann hypothesis proof.")
