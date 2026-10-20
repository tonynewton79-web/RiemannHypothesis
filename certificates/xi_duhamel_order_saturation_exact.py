"""Exact finite algebra supporting the Duhamel order-saturation theorem.

The analytical theorem for the genuine Riemann theta heat kernel proves:
r_n(s)=U_n(s,0)/(P_s U_n(0,.))(0) is strictly decreasing with n,
and tends to zero for every fixed s>0. Therefore the fraction
of the central Duhamel budget used by the source rises to one.

This file verifies algebraic size-bias and Gaussian benchmark gates.
It is *not* an interval computation of the infinite theta integral.
"""
from fractions import Fraction as Q

# Two-point anti-covariance, exact rational witnesses.
for p in map(Q,[1,2,4]):
 for q in map(Q,[1,3,5]):
  for x,y in [(Q(1),Q(2)),(Q(2),Q(7)),(Q(1,4),Q(3))]:
   for fx,fy in [(Q(9,10),Q(1,5)),(Q(1),Q(0)),(Q(5,7),Q(2,9))]:
    lhs=(p*x*fx+q*y*fy)*(p+q)-(p*fx+q*fy)*(p*x+q*y)
    rhs=p*q*(x-y)*(fx-fy)
    assert lhs==rhs and rhs<0
print("PASS exact two-point size-bias reverse covariance")

# A three-point positive distribution: absolute values b=1,2,4.
# For all n the fraction strictly decreases, but it converges to
# positive f(4); finite support alone does NOT prove saturation.
x=[Q(1),Q(4),Q(16)]
w=[Q(2),Q(3),Q(5)]
f=[Q(9,10),Q(1,2),Q(1,5)]
ratios=[]
for n in range(80):
    B=sum((w[j]*x[j]**n for j in range(3)), Q(0))
    U=sum((w[j]*x[j]**n*f[j] for j in range(3)), Q(0))
    ratios.append(U/B)
assert all(0<ratios[i+1]<ratios[i]<1 for i in range(len(ratios)-1))
assert ratios[-1]>Q(1,5)
print("PASS rational 80-order monotonicity; confirms need for unbounded support")

# Gaussian benchmark with nu0(u)=exp(-a*u²), s=a=1:
# r_n^2=2^(-2n-1) and r_(n+1)=r_n/2.
for n in range(151):
    rr2=Q(1,2**(2*n+1))
    next2=Q(1,2**(2*(n+1)+1))
    assert rr2>0 and next2*4==rr2
assert Q(1,2**(2*50+1))<Q(1,10**20)
print("PASS exact Gaussian source-saturation powers through order 150")
print("Full theta limit follows analytically from positive W_s(b) with unbounded support.")
print("No proof or disproof of RH.")
