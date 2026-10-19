from fractions import Fraction as Q
from math import log, pi, e

# For P(z)=(z-a)(z-b), at a:
# L1[P](a)=(a-b)^2, L2[P](a)=1.
# Therefore the required comparison coefficient is 6/(a-b)^2.
for k in [4,8,12,16,24,40,80]:
    gap=Q(1,2**k)
    dP=-gap
    ddP=Q(2)
    L1=dP**2
    L2=ddP**2/4
    assert L1==gap**2 and L2==1
    assert 6*L2/L1==6*4**k
    print('PASS inverse-gap certificate k=',k,' required=',6*4**k)

# Diagnostics (not mathematical certification) for the density-matched
# paired root set T_k=8*pi*k/log(k+e), T_k+2^(-k).
# The order-one LP product and zero counting are proved in TeX.
for k in [10,20,40,80]:
    T=8*pi*k/log(k+e)
    ratio=(6*4**k)/(1+log(2+T)**2)
    print('DIAGNOSTIC k=',k,' location=',T,'ratio/log²=',ratio)
print('PASS exact rational finite algebra; RH is not proved.')
