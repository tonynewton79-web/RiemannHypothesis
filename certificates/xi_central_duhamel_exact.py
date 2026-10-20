"""Exact proof-gate tests for the one-Fourier-point Duhamel RH criterion.

The analytic statement, proved in paper/central_duhamel_penalty_attack.tex:
For the *genuine* theta heat family and T=1/2, RH iff
 sup_(C>=1) mathcal E_(n,C)(T,0)<infty for every n>=1.

This program checks its elementary algebra and the explicit
negative-witness rectangle bound in rational arithmetic; it does
NOT check the theta-wide positivity or prove RH.
"""
from fractions import Fraction as Q
from itertools import product
from math import exp, sqrt, pi

T=Q(1,2)
tests=0
for A,B,d in product((Q(0),Q(1,3),Q(1),Q(50),Q(999)),
                     (Q(0),Q(1,5),Q(2),Q(100)),
                     (Q(1,100),Q(1,8),Q(1),Q(17,3))):
    tau=min(T/4,d/(8*(1+A)))
    r=min(Q(1),d/(4*(1+B)))
    assert tau>0 and r>0
    assert 2*tau*A+r*B <= d/2
    assert T-2*tau>=0 and T-tau<T
    # Any U(T,X)<=-d with derivative bounds A,B
    # satisfies U(s,y)<=-d/2 on the rectangle.
    u_upper=-d+2*tau*A+r*B
    assert u_upper<=-d/2
    tests+=1
print(f"PASS {tests} exact witness rectangles")

for C,A,M in product((Q(1),Q(3),Q(17),Q(100)),
                     (Q(0),Q(1,10),Q(2)),
                     (Q(0),Q(1,20),Q(3))):
    b=1+T*(A+M)
    J_upper=T*(M+C*A)
    assert J_upper/b<=1+C
    if A==0:
        assert J_upper<=T*M
print("PASS exact scalar all-order summand normalizations")

# A rational Gaussian counter-model with a negative interval:
# U(s,y)=1-2*s (independent of y) on T=1.
# Negative mass N(1,0)=integral_1/2^1 (2s-1) ds=1/4.
# Positive defect E_C=(2-C(1-2s))_+ has
# mathcalE_C(1,0)=C/4+1+1/C, C>2.
for C in (Q(4),Q(8),Q(16),Q(100),Q(1024)):
    N=Q(1,4)
    E=C/4+1+1/C
    assert E/C > N
    assert E>C*N
    assert E/C-N==1/C+1/C**2
print("PASS negative-region toy heat source forces linear-C penalty")

# Non-rigorous floating-point demonstration of the rigorous Gaussian
# lower bound from the exact rectangle theorem. It illustrates the
# extreme loss of sensitivity at large Fourier heights; its sign
# positivity is already established analytically.
A=B=d=Q(1)
tau=min(T/4,d/(8*(1+A)))
r=min(Q(1),d/(4*(1+B)))
for X in (0,1,3,8):
    y=abs(X)+float(r)
    witness=float(d*r)*sqrt(float(tau))/(2*sqrt(pi))*exp(-y*y/(2*float(tau)))
    assert witness>=0
    print(f"DEMONSTRATION |X|={X}: exact positive witness formula ~ {witness:.3e}")
print("PASS: no unconditional Xi central penalty bound has been proved.")
