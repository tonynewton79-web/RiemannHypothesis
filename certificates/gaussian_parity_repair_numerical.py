"""Independent 52-digit Gaussian-parity-repair Laguerre replay (numerical only).

M=1 theta half-axis truncation. Use exact incomplete-gamma formula and
differentiate it numerically, not by finite differences.

For sigma=0.35 and x=39.5,60,100 we check L1[F_M]<0
but L1[F_M]+sigma²*F_M²>0, matching the analytical theorem
for the Gaussian-smoothed transform.
"""
import mpmath as mp
mp.mp.dps=52
Q=mp.pi
sigma=mp.mpf("0.35")

def Fm(x):
    a=mp.mpf("1.25")+1j*x/4
    return mp.re(Q**(1-a)*(
        2*mp.gammainc(a+1,Q,mp.inf)-3*mp.gammainc(a,Q,mp.inf)))/2

for x in (mp.mpf("39.5"),mp.mpf(60),mp.mpf(100)):
    f=Fm(x)
    fp=mp.diff(Fm,x)
    fpp=mp.diff(Fm,x,2)
    L=fp**2-f*fpp
    corrected=L+sigma**2*f*f
    assert L<0
    assert corrected>0
    # Independent direct Gaussian product differentiation
    g=lambda z:mp.exp(-sigma**2*z*z/2)*Fm(z)
    gp=mp.diff(g,x)
    gpp=mp.diff(g,x,2)
    residual=gp**2-g(x)*gpp-mp.exp(-sigma**2*x*x)*corrected
    assert abs(residual)<mp.mpf("1e-37")*max(1,abs(corrected))
    print(f"x={mp.nstr(x,6)}, original L1={mp.nstr(L,15)}, "
          f"Gaussian-normalized L1={mp.nstr(corrected,15)}, "
          f"identity residue={mp.nstr(abs(residual),5)}")
print("PASS: 52-digit numerical cross-check; analytical theorem is in the manuscript.")
