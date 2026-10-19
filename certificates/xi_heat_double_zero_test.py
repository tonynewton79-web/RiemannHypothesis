"""Independent test of the exact double-zero failure of the heat comparison.

K_t(u) = exp(-(1/2-t)*u²)*(1+cosh(u)/2).
For alpha=1-2t>0 its Fourier transform is
sqrt(2*pi/alpha)*exp(-z²/(2*alpha)) *
  [1+exp(1/(2*alpha))/2*cos(z/alpha)].

At t*=(1-1/(2 log 2))/2, z*=pi/(2 log 2), we have
F=F'=0, F'' != 0. Thus L1=0, L2=F''²/4>0.
The inequality 6 L2 <= c1 L1 is impossible for all finite c1.
This is a generic heat-flow example, not a counterexample to RH.
"""
import sympy as sp
from mpmath import mp
z,a,d,G=sp.symbols('z a d G',positive=True,real=True)
F=G*sp.exp(-z*z/(2*a))*(1+d*sp.cos(z/a))
subs={d:1,z:sp.pi*a}
assert sp.simplify(F.subs(subs))==0
assert sp.simplify(sp.diff(F,z).subs(subs))==0
assert sp.simplify(sp.diff(F,z,2).subs(subs)
                   -G*sp.exp(-sp.pi**2*a/2)/a**2)==0
u,v,w,p,q=sp.symbols('u v w p q',real=True)
L1=v*v-u*w
L2=u*q/12-v*p/3+w*w/4
assert sp.expand(L1.subs({u:0,v:0}))==0
assert sp.expand(L2.subs({u:0,v:0})-w*w/4)==0
mp.dps=65
alpha=1/(2*mp.log(2))
tstar=(1-alpha)/2
assert 0<tstar<mp.mpf('0.25')
assert mp.exp(mp.mpf('0.5'))/2<1<mp.exp(1)/2
assert mp.almosteq(mp.exp(1/(2*alpha))/2,1)
print('PASS exact symbolic jet identities; double zero has L1=0, L2>0')
print('PASS t*=',mp.nstr(tstar,30),'; cosine coefficient crosses 1')
print('No full RH proof; Lean file checks algebraic obstruction only.')
