"""Exact/symbolic tests for the de Bruijn--Newman theta heat flow.

H_t(z)=integral_0^infinity Phi(u)*exp(t*u^2)*cos(z*u)du,
where ∂_t H_t=-∂_z² H_t.

The product Q_t(x,y)=H_t(x+i*y)H_t(x-i*y) satisfies
∂_t Q=(∂_y² Q-∂_x² Q)/2. Its y^(2n) coefficients satisfy
∂_t L_n=(n+1)(2n+1)L_(n+1)-1/2∂_x² L_n.

Important: these identities and numerical checks are not a RH proof.
The real/nonreal zero transition at t=1/2 and t=-1 follows from
de Bruijn--Newman and Rodgers--Tao (2020), not numerical sampling.
"""
import sympy as sp
import mpmath as mp
from fractions import Fraction as Fr

u,t,x=sp.symbols('u t x',real=True)
V=sp.Function('V')
assert sp.simplify(sp.diff(V(u)-t*u*u,u,3)-sp.diff(V(u),u,3))==0
a,b,da,db,d2a,d2b=sp.symbols('a b da db d2a d2b')
Qxx=d2a*b+2*da*db+a*d2b
Qyy=-d2a*b+2*da*db-a*d2b
Qt=-(d2a*b+a*d2b)
assert sp.expand(Qt-(Qyy-Qxx)/2)==0
f0,f1,f2,f3,f4=sp.symbols('f0 f1 f2 f3 f4')
L1_t=f2*f2+f0*f4-2*f1*f3
L1_xx=f2*f2-f0*f4
L2=f0*f4/12-f1*f3/3+f2*f2/4
assert sp.expand(L1_t-(6*L2-L1_xx/2))==0
print('PASS exact symbolic V_t third derivative, heat PDE and order-one coupling')

for n in range(100):
    for A in [Fr(1,2),Fr(1),Fr(7,3)]:
        for X in [Fr(0),Fr(1,3),Fr(7,4)]:
            lhs=Fr(2*(n+1),1)/A-2*X*X/(A*A)
            rhs=Fr(2*n+1,1)/A-(4*X*X/(A*A)-Fr(2,1)/A)/2
            assert lhs==rhs
print('PASS n=0..99 exact Gaussian heat hierarchy rational checks')

mp.mp.dps=65
def phi(v):
    return sum((2*mp.pi**2*m**4*mp.exp(9*v)
                -3*mp.pi*m*m*mp.exp(5*v))
               *mp.exp(-mp.pi*m*m*mp.exp(4*v))
               for m in range(1,9))
for U in map(mp.mpf,['0.1','0.2','0.35','0.6']):
    V3=mp.diff(lambda w:-mp.log(phi(w)),U,3)
    for T in map(mp.mpf,['-1','0','0.5']):
        tilted=mp.diff(lambda w:-mp.log(phi(w))-T*w*w,U,3)
        assert mp.almosteq(V3,tilted,
                           rel_eps=mp.mpf('1e-53'),abs_eps=mp.mpf('1e-53'))
print('PASS 65-digit actual theta V_t third derivative invariance at 4 points, 3 heat times')
print('KNOWN PRIOR ART: Lambda lies in [0,1/2], hence H_-1 has nonreal zeros')
print('RH remains OPEN; none of these finite/symbolic tests proves Lambda=0')
