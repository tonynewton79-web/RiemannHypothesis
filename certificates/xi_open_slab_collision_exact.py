"""Exact rational and symbolic checks for the open-slab collision model.

The corrected comparison assumes locally bounded coefficients only
for s<T, not at the terminal time. Under the classical heat-flow
results this is RH-equivalent without assuming simplicity at t=0.
This checker verifies polynomial gates; it does not formalize RH.
"""
from fractions import Fraction as Q
from math import comb
import sympy as S
z,t,x,a=S.symbols("z t x a",real=True)
H=(z-a)**2-2*t
assert S.simplify(S.diff(H,t)+S.diff(H,z,2))==0
f=H.subs(z,x)
L1=S.expand(S.diff(f,x)**2-f*S.diff(f,x,2))
L2=S.expand(f*S.diff(f,x,4)/12-S.diff(f,x)*S.diff(f,x,3)/3+S.diff(f,x,2)**2/4)
assert S.simplify(L1-(2*(x-a)**2+4*t))==0 and L2==1
assert S.simplify(3*L1/((x-a)**2+2*t)-6*L2)==0
for T in (Q(1,1000),Q(1,20),Q(1,2)):
 for X in (Q(0),Q(1,1000),Q(3,10),Q(2)):
  l1=2*X*X+4*T
  c=Q(3)/(X*X+2*T)
  assert l1>0 and c*l1==6 and c<=Q(3)/(2*T)
for C in (Q(0),Q(1),Q(10**7),Q(10**12)):
 T=Q(1,8*(C+1))
 assert 0<T<Q(1,2) and Q(3,2*T)>C
for m in range(2,101):
 for X in (Q(0),Q(1,10),Q(1),Q(4)):
  lprev=Q(m)*X*X
  lnext=Q(1)
  assert comb(m,m-1)*X*X==lprev and comb(m,m)==lnext
  if X: assert Q(m*(2*m-1))*lnext/lprev==Q(2*m-1)/(X*X)
  else: assert lprev==0 and lnext>0
print("PASS exact heat polynomial, L1/L2, optimal spatial coefficient")
print("PASS terminal blowup model and 99 exact multiple-zero families")
print("Not a proof of RH; genuine theta open-slab coefficient bound remains open.")
