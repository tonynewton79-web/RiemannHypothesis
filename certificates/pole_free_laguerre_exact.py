"""Exact finite-product audit for a pole-free Laguerre ratio bound.

For a real-rooted polynomial G with distinct real roots,
  G(x+i*y)G(x-i*y)=G(x)^2*prod_j(1+y^2/(x-rho_j)^2).
Removing any selected root a yields elementary-symmetric
coefficients E_k for all other roots. The bound
  n*(b*E_n+E_(n+1)) <= S*(b*E_(n-1)+E_n),
where b=(x-a)^(-2), S=sum_(rho!=a)(x-rho)^(-2),
is independent of b.

At x=a, the exact limiting formula is
  L_n[G](a)=G'(a)^2 E_(n-1).
This is a countermeasure to an artificial pole. It does not prove
that any unknown Riemann Xi heat deformation has real roots.
"""
from fractions import Fraction as F
from itertools import combinations

def e(xs,k):
    if k<0 or k>len(xs):return F(0)
    return sum((__import__('math').prod(c) for c in combinations(xs,k)),F(0))

roots=[F(-31,4),F(-2),F(1),F(9,4),F(7),F(21,2)]
for a in roots:
    for eps in [F(-1,100),F(-1,100000),F(1,10**7),F(1,20)]:
        x=a+eps
        if x in roots: continue
        b=1/(x-a)**2
        bs=[1/(x-r)**2 for r in roots if r!=a]
        S=sum(bs)
        for n in range(1,len(roots)):
            p,c,z=e(bs,n-1),e(bs,n),e(bs,n+1)
            assert n*c<=S*p
            assert (n+1)*z<=S*c
            assert n*(b*c+z)<=S*(b*p+c)
            if p>0:
                assert F((n+1)*(2*n+1))*(b*c+z)/(b*p+c) <= F((n+1)*(2*n+1),n)*S
    # At x=a the selected root factor cancels exactly.
    other=[1/(a-r)**2 for r in roots if r!=a]
    S=sum(other)
    for n in range(1,len(roots)):
        p,c=e(other,n-1),e(other,n)
        if p:
            assert F((n+1)*(2*n+1))*c/p <= F((n+1)*(2*n+1),n)*S
print("PASS pole-free exact finite-polynomial tests near every root down to |x-a|=1e-7")
print("PASS at-zero exact symmetric coefficients; no artificial (x-a)^(-2) pole")
print("The full Hadamard-product extension uses classical convergence, not finite tests.")
