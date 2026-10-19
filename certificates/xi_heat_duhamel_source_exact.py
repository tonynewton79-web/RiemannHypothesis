"""Exact symbolic audit of the generalized-Laguerre Duhamel source gate.

No claim of RH. The genuine Jacobi kernel application of the general
Fourier identity still requires an all-order signed cosine estimate.
"""
from fractions import Fraction as F
import sympy as s
u,v,t,r,x,d=s.symbols('u v t r x d', real=True)
b=u-v; a=u+v
initial=s.exp(-t*a*a/2)*b**2
source=initial*(1-s.exp(-t*b*b/2))
remainder=initial*s.exp(-t*b*b/2)
assert s.simplify(initial-source-remainder)==0
assert s.simplify(s.exp(-t*(u*u+v*v)) - s.exp(-t*(a*a+b*b)/2))==0
print('PASS exact two-frequency spectral cancellation / Duhamel identity')
H=1+d*s.cos(x)
L1=s.expand_trig(s.diff(H,x)**2-H*s.diff(H,x,2))
L2=s.expand_trig(H*s.diff(H,x,4)/12-s.diff(H,x)*s.diff(H,x,3)/3+s.diff(H,x,2)**2/4)
assert s.simplify(L1-d*(d+s.cos(x)))==0
assert s.simplify(L2-d*(4*d+s.cos(x))/12)==0
assert s.simplify(L1.subs({d:s.Rational(3,4),x:s.pi})+s.Rational(3,16))==0
assert L1.subs({d:1,x:s.pi})==0
assert L2.subs({d:1,x:s.pi})==s.Rational(1,4)
print('PASS exact first-order negative source deficit, double-zero comparison impossibility')
d0=F(3,2); attenuation=F(1,4); rootatt=F(1,2)
semigroup_budget=d0*d0-d0*rootatt
current_L1=(d0*attenuation)**2-d0*attenuation
source_value=semigroup_budget-current_L1
assert semigroup_budget==F(3,2)
assert current_L1==-F(15,64)
assert source_value==F(111,64)
assert source_value-semigroup_budget==F(15,64)
print('PASS integrated source overshoots heat budget by 15/64 at s=log(4), x=pi')
for n in range(101):
    assert s.Rational((n+1)*(2*n+1),s.factorial(2*n+2))==s.Rational(1,2*s.factorial(2*n))
print('PASS all-order Duhamel coefficient cancellation n=0..100')
print('Open: theta-specific positive-definite correlation estimate at all orders and heat times')
