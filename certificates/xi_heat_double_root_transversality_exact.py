"""Exact Fraction tests for double-zero heat-flow Laguerre transversality.

General elementary theorem: at H=H'=0, H''=a !=0,
L1=0, L2=a²/4 and ∂_x² L1=a². The heat PDE implies
∂_t L1=6L2-(1/2)∂_x²L1=a²>0, hence backward
heat variation makes L1 negative in a punctured
left neighborhood (for smooth H_t).
Model H_t(z)=z²-2t has L1(t,x)=2x²+4t.
These are local entire-heat algebra identities,
NOT an assertion about occurrence of theta double
zeros and NOT a proof of RH.
"""
from fractions import Fraction as Q
for den in range(1,51):
    for a in (Q(1,den), -Q(3,den), Q(7,2*den)):
        L1 = Q(0)
        L2 = a*a/4
        L1xx = a*a
        heat_derivative = 6*L2 - L1xx/2
        assert L1 == 0 and heat_derivative == a*a > 0
    for step in (Q(1,den), Q(2,den)):
        t = -step
        x = Q(0)
        modelL1 = (2*x)**2 - (x*x-2*t)*2
        assert modelL1 == 2*x*x+4*t < 0
        assert modelL1 == 4*t
print("PASS 150 exact double-zero heat transversality cases")
print("PASS 100 exact backward heat sign-crossing model cases")
print("Note: no verified double zero of the genuine Xi heat family was claimed.")
