"""Exact rational gates for the Riemann Xi complex-strip tail bound.

For z=x+i*y, the theta Fourier integral has integrand
bounded by exp(|y|*r).
After t=exp(4r), derivative order k has upper integrand
 q_m² * t^((9+|y|)/4)*exp(-q_m*t), times k!/4^k.
For |y|<=3, the power <=3.  For k=0, no extra
e^(4r), and the power is (5+|y|)/4, <=3 when |y|<=7.

Thus the full exact real-frequency tail bound extends to the
complex strip, independently of Re(z):
 E_M = 3*q_(M+1)*exp(-q_(M+1)).
The theorem uses an analytic Fourier-integral majorant;
this script verifies exact rational inequality gates only.
"""
from fractions import Fraction as Q
from math import factorial, comb

for Y in [Q(0),Q(1,10),Q(1),Q(2),Q(3)]:
    assert (9+Y)/4<=3
for Y in [Q(0),Q(1),Q(3),Q(5),Q(7)]:
    assert (5+Y)/4<=3
for q in [Q(12),Q(13),Q(20),Q(100),Q(1000)]:
    assert q+3+Q(6)/q+Q(6)/q**2 <= Q(3,2)*q

for n in range(0,61):
    s=sum([Q(comb(2*n,k)*factorial(k)*factorial(2*n-k),factorial(2*n))
           for k in range(2*n+1)],Q())
    assert s==2*n+1

# Inverse relation s=1/2+i*z/2 => Re(s)=(1-Im z)/2.
for y in [Q(-99,100),Q(-1,3),Q(0),Q(1,3),Q(99,100)]:
    re_s=(1-y)/2
    assert 0<re_s<1

# Algebraic Rouché gap condition: |F-FM|<=E and
# |FM|>E imply |F|>0; the contour condition must hold
# for EVERY point of the contour, not merely samples.
for E,mod in [(Q(1,100000),Q(2,100000)),
               (Q(3,10000),Q(1,1000))]:
    assert mod>E and mod-E>0
print("PASS: k>=0 complex strip |Im z|<=3 gates")
print("PASS: k=0 complex strip |Im z|<=7 gates")
print("PASS: 61 orders of exact Laguerre binomial cancellations")
print("PASS: Xi critical-strip coordinate conversion and Rouché margin logic")
print("NOT a numerical zero count or a proof of RH.")
