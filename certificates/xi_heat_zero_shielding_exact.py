"""Exact rational checks of a conditional zero-gap shielding theorem.

The zero ODE is prior work of Csordas--Smith--Varga / Rodgers--Tao.
The finite-window and near-lattice estimates are conditional:
NO claim that genuine Xi zeros satisfy uniform near-lattice rigidity.

For real-simple consecutive zeros a<b, g=b-a, backwards time s:
 d_s(g²)=-8+4*g²*Sext,
 Sext=sum_(rho != a,b)1/((a-rho)*(b-rho)).
An ideal infinite lattice has g²*Sext=2.
R neighbors on each side give g²*S_R=2R/(R+1).
Under epsilon-relative deviations of these 2R external zeros,
2R/((R+1)*(1+eps)²)<=g²*S_R<=
2R/((R+1)*(1-eps)²).
The full far-tail is positive; hence
d_s(g²)>=-8/(R+1)-16 eps.
"""
from fractions import Fraction as Q
import sympy as sp
for R in [1,2,3,4,7,10,100,500]:
    S=2*sum((Q(1,m*(m+1)) for m in range(1,R+1)),Q())
    assert S==Q(2*R,R+1)
    assert -8+4*S==Q(-8,R+1)
print("PASS telescoping exact lattice shield through R=500")

x=sp.Symbol("x")
families=[[-3,2],[-5,-2,0,3,7],[-10,-7,-2,3,9],[-6,-5,-1,2,4,11]]
count=0
for roots in families:
    P=sp.prod(x-sp.Rational(r) for r in roots)
    for j in range(len(roots)-1):
        a,b=map(sp.Rational,(roots[j],roots[j+1]))
        g=b-a
        va=sp.cancel(P.diff(x,2).subs(x,a)/P.diff(x).subs(x,a))
        vb=sp.cancel(P.diff(x,2).subs(x,b)/P.diff(x).subs(x,b))
        S=sum((1/((a-r)*(b-r)) for r in map(sp.Rational,roots)
               if r not in (a,b)),sp.Rational(0))
        assert sp.cancel(2*g*(va-vb)+8-4*g*g*S)==0
        count+=1
print(f"PASS {count} exact polynomial heat-root gap ODE identities")

tests=0
for R in [1,2,5,20]:
    for eps in [Q(1,100),Q(1,20),Q(1,4),Q(1,2)]:
        g=Q(3,5);a=Q(0);b=g
        for sign in [-1,1]:
            left=[-(m+sign*eps)*g for m in range(1,R+1)]
            right=[(m+1+sign*eps)*g for m in range(1,R+1)]
            S=sum((1/((a-r)*(b-r)) for r in left+right),Q())
            lower=Q(2*R,R+1)/(1+eps)**2
            upper=Q(2*R,R+1)/(1-eps)**2
            assert lower<=g*g*S<=upper
            assert -8+4*g*g*S>=-Q(8,R+1)-16*eps
            tests+=1
print(f"PASS {tests} adversarial rational near-lattice regimes")
for g2 in [Q(1,100),Q(1,50),Q(1,10),Q(1,2)]:
    R=int(16/g2)
    eps=g2/32
    assert Q(4,R+1)+8*eps<g2
print("PASS four exact rational half-slab margin parameter checks")
print("GLOBAL RH GAP: no uniform theta-specific shielding proved.")
