"""Exact-rational verification of the six-band heat-tail refinement.

For b(x)=(x²/12-3)_+, a=15/16:
 b(x) <= (4/45)*exp(-135/4)*exp(a*x²).
For Z_h~N(0,h), h<=1/2:
 E exp(a Z_h²)=(1-2*a*h)^(-1/2)<=4.
Thus the time-integrated heat defect <=
 k_n*sup A_(n+1)* (8/45)*exp(-135/4)
 < k_n*sup A_(n+1)/10^14.

The script checks exact rational constants. The Gaussian MGF
and the actual theta six-band source theorem are separate
analytic inputs. A positive upper bound does not prove RH.
"""
from fractions import Fraction as Q
from math import factorial
from decimal import Decimal, getcontext

a=Q(15,16)
T=Q(1,2)
assert Q(1,12)/a==Q(4,45)
assert 36*a==Q(135,4)
assert 1-2*a*T==Q(1,16)
assert T*Q(4,45)*4==Q(8,45)
assert Q(8,45)/20**11==Q(1,1152000000000000)
assert Q(8,45)/20**11<Q(1,10**14)
assert sum((Q(3**j,factorial(j)) for j in range(10)),Q())>20
assert Q(135,4)>33
for h in (Q(0),Q(1,20),Q(1,8),Q(1,4),Q(2,5),Q(1,2)):
    assert Q(1,16)<=1-2*a*h<=1
for v in (Q(-50),Q(-1),Q(0),Q(1,100),Q(7,2),Q(30),Q(200)):
    if v>=0:
        assert a*v<=1+a*v
    else:
        assert max(v,Q(0))==0
getcontext().prec=60
value=Decimal(8)/45*(-Decimal(135)/4).exp()
print("PASS: six-band exact rational Gaussian-tail constants")
print("Analytic constant 8/45 exp(-135/4), numerical diagnostic =", value)
print("Rational strict bound < 1e-14 * k_n * sup A_(n+1)")
print("The comparison defect is not proved zero; RH remains open.")
