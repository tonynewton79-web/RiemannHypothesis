"""Exact rational audit of exterior-gap shielding telescoping and backward anti-diffusion.

For neighboring simple real zeros with gap g, exterior gaps
g*(1+eps_m), D_0=0, D_m=sum_{j<=m}eps_j:
  sum_{m=1}^N [1/((m+D_m)(m+1+D_m)) +
  eps_m/((m+D_(m-1))(m+D_m))] + 1/(N+1+D_N)=1.

As N->infinity and the exterior zero positions diverge,
1-S_side=sum_{m>=1} eps_m/[(m+D_(m-1))(m+D_m)].
For both sides G'= -4*(defect_left+defect_right).
At a *currently minimum* central gap, eps_m>=0 and G'<=0.

Arithmetic checks below do NOT prove the analytic passage nor RH.
"""
from fractions import Fraction as F
import random
rng=random.Random(1141020)
def finite_identity(eps):
    D=F(0);S=F(0); defect=F(0)
    for m,e in enumerate(eps,1):
        assert e> -1
        old=D;D+=e
        y=F(m)+old;z=F(m)+D
        assert y>0 and z>0
        S+=1/(z*(z+1))
        defect+=e/(y*z)
        assert S+defect+1/(m+1+D)==1
    return S,defect,D
for N in (1,2,3,5,10,40):
    for _ in range(300):
        eps=[max(F(-99,100),F(rng.randint(-5,12),rng.randint(6,32)))
             for j in range(N)]
        S,defect,D=finite_identity(eps)
        if all(e>=0 for e in eps):
            assert defect>=0 and S<=1
    print('PASS signed-excess telescoping for N=',N)
for j in range(1,21):
    for delta in (F(1,32),F(1,2),F(1),F(3),F(11,7)):
        assert 1/F(j)-1/(F(j)+delta)==delta/(j*(F(j)+delta))
        assert delta/(j*(F(j)+delta))<=delta/F(j*j)
print('PASS exact arbitrary one-gap formula')
for _ in range(1000):
    left=[F(rng.randint(0,30),rng.randint(1,30)) for j in range(6)]
    right=[F(rng.randint(0,30),rng.randint(1,30)) for j in range(6)]
    _,dl,_=finite_identity(left)
    _,dr,_=finite_identity(right)
    assert dl>=0 and dr>=0 and -4*(dl+dr)<=0
print('PASS 1000 minimum-gap squared-speed sign checks')
print('Only exact arithmetic gates are checked; RH and theta zero dynamics open.')
