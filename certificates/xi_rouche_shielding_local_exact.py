"""Exact, noncircular local shielding-envelope test.

Holomorphic theta heat flow at t*=1/2:
H_t(z)=int Phi(u) exp(t*u*u) cos(z*u) du.
For 0<=s<=sigma and |Im z|<=Y:
|H_(t*-s)(z)-H_(t*)(z)| <= s * M_Y,
M_Y=int_0^inf Phi(u) exp(t* u²) u² exp(Yu)du.
If at t* contour minima for two disjoint zero disks and an
enclosing two-zero corridor exceed sigma*M_Y, Rouché certifies
two distinct real zeros separated by at least g0-2r.
Then WITHOUT assuming survival, signed shielding flow gives
  integral D <= r*(g0-r),  eta=(g0-2r)^2 >0.

This script checks rational algebra and an explicit adversarial
polynomial control. It does not prove any height-uniform theta
contour minimum or RH.
"""
from fractions import Fraction as F
from random import Random
R=Random(20261020)
for _ in range(20000):
    g=F(R.randrange(3,600),R.randrange(1,50))
    r=g*F(R.randrange(1,999),2000)
    assert 0<2*r<g
    eta=(g-2*r)**2
    budget=r*(g-r)
    assert 4*budget==g*g-eta
    # A certified location separation implies an independent deficit envelope.
    extrasq=eta + F(R.randrange(0,50),R.randrange(1,50))
    I=(g*g-extrasq)/4
    assert I<=budget and eta>0
print("PASS 20000 exact Rouché-disk-to-shielding budget comparisons")

# p_s(z)=z^4+(12s-5)z^2+(12s²-10s+4).
# Initial roots -2,-1,1,2; choose radius r=1/4 for all 4.
# On each root circle, product |p0(z)| >=
#  r * (1-r)*(2-r)*(3-r) =231/256 (smallest: roots ±1).
# Max |z|<=9/4 on the four circles, so
#  |p_s-p0| <= s*(12*|z|²+10)+12*s²
#            <= (283/4)s+12s².
# At s=1/80 the upper bound is 283/320+3/1600=5672/6400,
# while lower bound 231/256=5775/6400, margin 103/6400.
r=F(1,4)
m=r*(1-r)*(2-r)*(3-r)
perturb=F(283,4)*F(1,80)+12*F(1,80)**2
assert m==F(231,256)
assert perturb==F(5672,6400)
assert m-perturb==F(103,6400)>0
# Rouché keeps one zero in each of four disjoint real-centred
# disks. Since the four roots exhaust the quartic and coefficients
# are real, each root is real. Gap between the roots near 1 and 2
# stays >=1/2 for the entire s interval.
g=F(1); eta=(g-2*r)**2; B=r*(g-r)
assert (eta,B)==(F(1,4),F(3,16))
assert 4*B==g*g-eta
# Actual collision of the positive quartic roots occurs later.
from decimal import Decimal,localcontext
with localcontext() as ctx:
    ctx.prec=55
    collision=(Decimal(10)-Decimal(46).sqrt())/24
    assert Decimal(1)/80<collision<Decimal(1)/7
print("PASS explicit quartic contour margin =103/6400")
print("PASS independent local integrated shielding envelope B=3/16, eta=1/4")
print("PASS quartic ultimately collides AFTER the certified local interval")
print("OPEN: true theta contour margins uniformly for all zero pairs and full backward interval")
