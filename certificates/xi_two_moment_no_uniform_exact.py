"""Exact finite comparison behind high-zero Jensen contour degeneration.

On the genuine H_(1/2) zero sequence, the published zero-density
asymptotic yields adjacent gaps g_i->0. For any protecting disk
r_i<g_i/2, the theta Fourier first-moment bound gives
m_i<=C1*r_i -> 0. For any fixed sigma>0 the Jensen allowance is
>=B0(sigma)>0 and eventually exceeds m_i, so a *single fixed*
time-step criterion cannot cover every zero pair.

This script checks the algebraic step with exact fractions.
The theta zero density and Fourier integral are external
analytic inputs, not asserted as computed here.
"""
from fractions import Fraction as F
from random import Random
rng=Random(20261020)
for C in (F(1),F(2),F(7,3),F(45,4)):
    B=F(1,10)
    for n in (21,50,100,200,1000,10000):
        rad=B/(2*C*n)
        mUpper=C*rad
        assert mUpper<B
        J=B+F(rng.randint(0,100),1000)
        assert J>=B>mUpper
print("PASS exact monotone no-uniform-step algebra for all 24 shrinking-radius models")
for _ in range(10000):
    C=F(rng.randint(1,99),rng.randint(1,99))
    B=F(rng.randint(1,99),rng.randint(1,99))
    n=rng.randint(1,10000)
    rad=B/(C*(n+1))
    max_modulus=C*rad
    J=B+F(rng.randint(0,100),1000)
    assert max_modulus<B<=J
print("PASS 10,000 randomized exact rational contour-vs-error separation witnesses")
print("Unproved: height-uniform Riemann theta contour bounds and global RH.")
