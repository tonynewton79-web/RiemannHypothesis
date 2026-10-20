"""Exact-rational audit of unconditional quantitative Duhamel penalty bounds.

Let E_C=(v-Cu)_+ and N=(-u)_+. With C>0 and |v|<=M,
  |E_C/C-N| <= M/C.
After integration against a positive mass-one Gaussian heat semigroup,
  |mathcal E_C(T,x)/C - mathcal N(T,x)| <= T*M/C,
uniformly in x. The actual theta analytic integral/RH equivalence
is in paper/penalty_quantitative_limit.tex, not formalized in Lean.
"""
from fractions import Fraction as Q
from random import Random
rnd=Random(20261020)
for i in range(15000):
    u=Q(rnd.randrange(-1000,1001),rnd.randrange(1,500))
    v=Q(rnd.randrange(-3000,3001),rnd.randrange(1,250))
    C=Q(rnd.randrange(1,100000),rnd.randrange(1,300))
    M=abs(v)+Q(rnd.randrange(0,50),7)
    E=max(v-C*u,Q())
    N=max(-u,Q())
    assert C*N-M <= E <= C*N+M
    assert abs(E/C-N)<=M/C
print("PASS 15000 exact-rational pointwise positive-part sandwich tests")
for m in (3,7,17,31,101):
    C=Q(m)
    J=C/4+1+1/C
    N=Q(1,4)
    assert J/C-N==1/C+1/C**2
    assert abs(J/C-N)<=Q(2)/C
print("PASS exact negative model limit J_C/C ->1/4 with O(1/C) error")
for _ in range(1000):
    C=Q(rnd.randrange(1,30000),rnd.randrange(1,100))
    T=Q(rnd.randrange(1,200),100)
    w=[Q(rnd.randrange(1,100)) for j in range(16)]
    Z=sum(w);w=[z/Z for z in w]
    U=[Q(rnd.randrange(-200,201),50) for j in range(16)]
    V=[Q(rnd.randrange(-80,81),25) for j in range(16)]
    M=max(map(abs,V))
    J=T*sum((z*max(v-C*u,Q()) for z,u,v in zip(w,U,V)),Q())
    N=T*sum((z*max(-u,Q()) for z,u in zip(w,U)),Q())
    assert abs(J/C-N)<=T*M/C
print("PASS 1000 rational positive heat-kernel quadrature models")
print("No RH proof or direct theta Laguerre positivity is claimed")
