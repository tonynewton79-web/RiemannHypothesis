"""Research contour experiment near first real Xi zero (NOT certified).

Take F2 from the exact incomplete-gamma 2-mode formula. On circles
centered at 28.269 with radii 0.25,0.5,1, evaluate 96 boundary
samples and compute the numerical winding number by summing
successive argument differences. Compare sampled |F2| to the
rigorous complex-strip theta-tail bound E2=27*pi*exp(-9*pi).

Even a huge sample-point margin is NOT a certified minimum on the
continuous circle; such a proof needs interval evaluations plus a
rigorous modulus-of-continuity argument, or direct analytic lower bound.
"""
import mpmath as mp
mp.mp.dps=48

def fm2(z):
    a=mp.mpf('1.25')+1j*z/4
    b=mp.mpf('1.25')-1j*z/4
    ans=mp.mpc(0)
    for m in (1,2):
        q=mp.pi*m*m
        ans+=q**(1-a)*(2*mp.gammainc(a+1,q,mp.inf)-3*mp.gammainc(a,q,mp.inf))/4
        ans+=q**(1-b)*(2*mp.gammainc(b+1,q,mp.inf)-3*mp.gammainc(b,q,mp.inf))/4
    return ans

E2=27*mp.pi*mp.exp(-9*mp.pi)
N=96
center=mp.mpf('28.269')
for radius in (mp.mpf('.25'),mp.mpf('.5'),mp.mpf('1.0')):
    values=[fm2(center+radius*mp.exp(2j*mp.pi*k/N)) for k in range(N+1)]
    total=sum((mp.arg(values[k+1]/values[k]) for k in range(N)),mp.mpf('0'))
    winding=total/(2*mp.pi)
    minimum=min((abs(z) for z in values))
    assert abs(winding-1)<mp.mpf('1e-35')
    assert minimum>100000*E2
    print('r=',radius,
          'sample-min=',mp.nstr(minimum,13),
          'tail bound=',mp.nstr(E2,11),
          'sample-margin ratio=',mp.nstr(minimum/E2,9),
          'NUMERICAL winding=',mp.nstr(winding,12))
print('PASS numerical contour exploration; no continuous-contour zero count certified.')
