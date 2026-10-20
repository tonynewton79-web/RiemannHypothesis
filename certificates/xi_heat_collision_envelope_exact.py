"""Exact rational and symbolic tests for spatial Laguerre comparison at heat collisions.

This tests a LOCAL obstruction, not an actual collision in the
Riemann theta heat family. At a nondegenerate real double zero,
the backward heat equation implies
  lim_(t downarrow t*) (t-t*) 6*L2(t,x*)/L1(t,x*) = 3/2.
Thus an admissible c1(s,x*) must diverge nonintegrably as
s approaches s*=1/2-t* from below.

In the exact quadratic heat model
H_t(x)=x²-2(t-t*), L1=2x²+4(t-t*), L2=1.
At two-root gap g>0 the minimal midpoint coefficient is 12/g².
"""
import sympy as sp
from fractions import Fraction as Q
import mpmath as mp

x,t,tc=sp.symbols('x t tc',real=True)
H=x*x-2*(t-tc)
assert sp.expand(sp.diff(H,t)+sp.diff(H,x,2))==0
L1=sp.expand(sp.diff(H,x)**2-H*sp.diff(H,x,2))
L2=sp.expand(H*sp.diff(H,x,4)/12
    -sp.diff(H,x)*sp.diff(H,x,3)/3
    +sp.diff(H,x,2)**2/4)
assert sp.expand(L1-2*x*x-4*(t-tc))==0
assert L2==1
R=sp.factor(6*L2/L1)
assert sp.simplify(R-3/(x*x+2*(t-tc)))==0
assert sp.limit((t-tc)*R.subs(x,0),t,tc,dir='+')==sp.Rational(3,2)
g=sp.symbols('g',positive=True)
assert sp.simplify(R.subs({x:0,t:tc+g*g/8})-12/(g*g))==0
print('PASS exact polynomial heat flow, Laguerre ratio, 3/2 singular coefficient and inverse-square gap.')

for n in [1,2,10,100,1000]:
    delta=Q(1,n+1)
    ratio=Q(6)/(4*delta)
    assert ratio==Q(3,2)*(n+1)>n
print('PASS exact arbitrary-growth finite rational sequence.')

mp.mp.dps=65
tstar=(1-1/(2*mp.log(2)))/2
alpha=1-2*tstar
assert 0<tstar<mp.mpf('0.25')
assert abs(mp.exp(1/(2*alpha))/2-1)<mp.mpf('1e-60')
print('PASS Gaussian-cosh positive kernel's previously proved collision time t*=',mp.nstr(tstar,19))
print('The collision is NOT established for the genuine theta heat flow; RH remains open.')
