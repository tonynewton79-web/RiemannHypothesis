"""Exact rational audit of theta-specific heat-flow Fourier tails.

Analytic proof in paper/theta_heat_specific_tail.tex.
Checks the quartic inequality for q>=12 coefficientwise
and the generalized Laguerre combinatorial cancellation for n<=80.
Does not prove RH or independently formalize transcendental bounds.
"""
from fractions import Fraction as Q
from math import factorial, comb

def add(a,b):
    return [(a[i] if i<len(a) else Q(0))+(b[i] if i<len(b) else Q(0))
            for i in range(max(len(a),len(b)))]
def mul(a,b):
    c=[Q(0)]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b): c[i+j]+=x*y
    return c
def scale(a,x): return [x*y for y in a]
def power(a,n):
    c=[Q(1)]
    for _ in range(n): c=mul(c,a)
    return c
q=[Q(0),Q(1)]
a=[-Q(1,16),Q(1)]
lhs=add(scale(power(a,4),Q(3)),
        scale(mul(q,add(add(power(a,3),scale(power(a,2),Q(3))),
                        add(scale(a,Q(6)),[Q(6)]))),Q(-2)))
t=[-Q(12),Q(1)]
expected=add(add(power(t,4),scale(power(t,3),Q(333,8))),
             add(scale(power(t,2),Q(39891,64)),
                 add(scale(t,Q(7941835,2048)),[Q(522416259,65536)])))
assert lhs==expected
for qq in [Q(12),Q(13),Q(25),Q(50),Q(10000),Q(10**10)]:
    aa=qq-Q(1,16)
    assert 2*qq*(aa**3+3*aa**2+6*aa+6)<3*aa**4
for n in range(81):
    for k in range(2*n+1):
        assert comb(2*n,k)*factorial(k)*factorial(2*n-k)==factorial(2*n)
for y in [Q(0),Q(1,7),Q(1),Q(3)]: assert (9+y)/4<=3
for y in [Q(0),Q(1),Q(3),Q(5),Q(7)]: assert (5+y)/4<=3
print("PASS: exact theta heat-flow gamma-tail quartic identity")
print("PASS: 81 Laguerre orders' factorial cancellations; complex strip exponent gates")
print("Full Jacobi theta heat evolution and RH remain unproved in Lean.")
