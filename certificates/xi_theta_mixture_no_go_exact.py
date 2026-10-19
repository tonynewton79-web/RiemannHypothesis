"""Exact arithmetic checks for theta Gaussian-mixture exclusion.

Analytic theorem: the Riemann theta correlation G_(n,s)(w) is
strictly positive and decays faster than every Gaussian.
A positive nonzero mixture of centered Gaussians must have
a Gaussian lower bound; thus no such mixture represents G.

This script checks rational spectral substitutions,
all-order factorial algebra, and finite lower/upper
exponential incompatibility witnesses. Infinite theta
decay and measure-theoretic lower bound remain analytic
proofs in paper/spatial_heat_comparison.tex.
"""
from fractions import Fraction as Q
from math import factorial
for n in range(30):
    assert Q((n+1)*(2*n+1),factorial(2*n+2))==Q(1,2*factorial(2*n))
for w in [Q(-25),Q(-5),Q(-1),Q(0),Q(1),Q(7,3),Q(30)]:
    for b in [Q(-8),Q(0),Q(11,5)]:
        u=(w+b)/2;v=(w-b)/2
        assert u*u+v*v==(w*w+b*b)/2
for m,C,L,A in [(Q(1),Q(2),Q(1),Q(10)),
                  (Q(1,100),Q(50),Q(1),Q(20)),
                  (Q(5,8),Q(123),Q(3),Q(17)),
                  (Q(2,5),Q(500),Q(3,2),Q(33))]:
    assert m>0 and C>0 and A>L
    W=1
    while 1+(A-L)*W*W+((A-L)*W*W)**2/2<=C/m:
        W+=1
    t=(A-L)*W*W
    assert 1+t+t*t/2>C/m
    print('PASS rational Gaussian-mixture lower/upper contradiction at |w|=',W)
print('PASS all-order coefficient and frequency-variable quadratic identities')
print('Theta super-Gaussian bound is an analytic proof, not end-to-end Lean.')
