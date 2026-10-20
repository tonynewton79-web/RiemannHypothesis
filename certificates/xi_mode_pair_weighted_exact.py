"""Exact sign and coefficient gates for genuine theta fully weighted mode pairs.

For phi_m on the positive half-line, D_m=phi'_m(0)=q exp(-q)P1(q)
where q=pi*m*m and P1=-8q²+30q-15.
The Jacobi functional equation gives sum_m D_m=0.

For h_m,t(x)=int_0^infinity exp(t*r²)phi_m(r)cos(x*r)dr,
integration by parts gives h_m,t(x)=-D_m/x²+O(x^-4).
Every ordered pair in the weighted correlation therefore has
leading y^(2n) coefficient
 (-1)^n*(n+1)*D_m*D_k/x^(2n+4).
For all odd n, the diagonal contributions are negative at high x.

This script verifies finite exact algebraic signs/identities; Fourier
integration by parts and modular infinite-sum cancellation are
proved in the manuscript, not by these finite tests.
"""
from fractions import Fraction as Q
from math import comb
from sympy import symbols, simplify, expand
q=symbols('q')
P1=-8*q*q+30*q-15
assert simplify(P1.subs(q,Q(22,7)))==Q(13,49)
assert simplify(P1.subs(q,Q(3)))==3
for m in range(2,201):
    assert P1.subs(q,Q(3*m*m))<0
print("PASS rational first-mode / higher-mode sign gates for square-lattice q_m")

# Generating series (1+u)^(-2) = sum (-1)^n(n+1)u^n
# and (1+u)^(-4) = sum (-1)^n binom(n+3,3)u^n.
for n in range(60):
    assert sum(
        Q((-1)**j*(j+1))*Q((-1)**(n-j)*(n-j+1))
        for j in range(n+1)
    ) == Q((-1)**n*comb(n+3,3))
    assert (-1)**n*(n+1)==sum(
        (-1)**j*(-1)**(n-j) for j in range(n+1))
    A=Q(7,9)
    B=-A
    assert A*A+2*A*B+B*B==0
    assert (-1)**n*(n+1)*(A*A+2*A*B+B*B)==0
    if n%2:
        assert (-1)**n*(n+1)*A*A <0
        assert (-1)**n*(n+1)*A*B >0
print("PASS 60 orders: diagonal sign parity, mixed compensation, and all-order leading cancellation")

f,g,fp,gp,fpp,gpp=symbols('f g fp gp fpp gpp')
expr=expand((fp+gp)**2-(f+g)*(fpp+gpp)
    -(fp**2-f*fpp)-(gp**2-g*gpp)
    -(2*fp*gp-f*gpp-g*fpp))
assert expr==0
print("PASS exact two-mode first Laguerre cross-term identity")
print("ANALYTIC PROOF OBLIGATIONS: Jacobi modular sum, Fourier strip asymptotics, infinite compensation")
print("NO RH proof or all-order Fourier positivity established")
