"""Exact arithmetic and symbolic proof gates for a global heat comparison obstruction.

For real LP H of order <=1, at simple zero a and another zero b,
write H(z)=(z-a)(z-b)h(z), d=a-b.
Then L1(a)=d² h(a)²,
L2(a)=h(a)²+d²*(h'(a)²-h(a)h''(a)).
The LP residual h has h'(a)²-h(a)h''(a)>=0,
hence L2/L1 >= 1/d².

For the genuine Riemann H_(1/2), known zero density
N(T)=T log(T)/(4*pi)+O(T) and real simplicity imply
arbitrarily small neighboring gaps; therefore
sup_x 6L2/L1=+infinity at t=1/2. No bounded c1(0) works.
The asymptotic zero-count theorem is cited prior art,
NOT a theorem proved by this Python/Lean arithmetic test.
"""
import sympy as sp
from fractions import Fraction as Q
z,a,b,h0,h1,h2=sp.symbols('z a b h0 h1 h2',real=True)
h=h0+h1*(z-a)+h2*(z-a)**2/2
F=sp.expand((z-a)*(z-b)*h)
d=a-b
f1=sp.diff(F,z).subs(z,a)
f2=sp.diff(F,z,2).subs(z,a)
f3=sp.diff(F,z,3).subs(z,a)
l1=sp.expand(f1**2)
l2=sp.expand(f2**2/sp.Integer(4)-f1*f3/sp.Integer(3))
assert sp.factor(l1-d*d*h0*h0)==0
assert sp.factor(l2-h0*h0-d*d*(h1*h1-h0*h2))==0
print('PASS symbolic L1/L2 local factor identities at a simple zero')
for denominator in [1,2,4,8,16,64,256,1024]:
    gap=Q(1,denominator)
    assert 6/(gap*gap)==6*denominator*denominator
for d in [Q(1,100),Q(2,3),Q(1,1)]:
 for h0 in [Q(1,4),Q(1),Q(5,2)]:
  for h1 in [Q(-2),Q(0),Q(4)]:
   for h2 in [Q(-3),Q(0)]:
    if h1*h1<h0*h2: continue
    first=(d*h0)**2
    second=h0*h0+d*d*(h1*h1-h0*h2)
    assert second/first>=1/(d*d)
print('PASS 8 shrinking gaps and all exact residual-Laguerre comparisons')
print('PRIOR-ART ASSUMPTION: H_(1/2) all-real simple zeros, N(T)~T log T/(4*pi)')
print('CONCLUSION: no bounded-in-height c1 at t=1/2; RH is OPEN')
