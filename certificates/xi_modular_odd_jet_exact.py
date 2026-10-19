"""Exact square-lattice modular odd-jet and finite-cutoff sign checks.

The analytic Jacobi identity gives:
sum_{m>=1} pi*m²*exp(-pi*m²)*P_(2j+1)(pi*m²)=0, j>=0,
where P0=2q-3 and P_next=(5-4q)P+4qP'.
For m>=2, q>=4*pi>12, P1(q)=-8q²+30q-15<0.
Thus every finite positive-axis cutoff leaves D_M>0 and
L1[F_M](x)~-8 D_M²/x^6<0 as x->infinity.

This standard-library checker validates exact polynomial recurrence
and q>=12 sign structure; the modular functional equation and
Fourier asymptotic are analytic proofs in the companion paper.
"""
from fractions import Fraction as Q

P=[[-3,2]]
for _ in range(10):
    p=P[-1];n=[0]*(len(p)+1)
    for j,c in enumerate(p):
        n[j]+=5*c
        if j: n[j]+=4*j*c
        n[j+1]-=4*c
    P.append(n)
assert P[1]==[-15,30,-8],P[1]

def poly(p,q):
    a=Q(0)
    for c in p[::-1]: a=a*q+c
    return a

for q in map(Q,[12,13,20,50,100,1000]):
    t=q-12
    assert -poly(P[1],q)==8*t*t+162*t+807
    assert poly(P[1],q)<0
for D in map(Q,[Q(1,4),Q(1,1000),Q(4,7)]):
    assert (4*D)**2-(-2*D)*(-12*D)==-8*D*D<0
print("PASS: exact odd-jet P1 polynomial, q>=12 negative tail, x^-6 Laguerre coefficient.")
print("The Jacobi modular identity and integration-by-parts theorem are proved analytically in the manuscript.")
