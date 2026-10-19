"""Independent numerical Xi complex-strip tail and Rouché-gap exploration.

mpmath at 55 digits, NOT directed interval certification.
The exact theorem |F-FM|<=3q exp(-q) for |Im(z)|<=7
is mathematical, not a conclusion from these samples.
"""
import mpmath as mp

mp.mp.dps=55
pi=mp.pi
def fm(z,M):
    a=mp.mpf('1.25')+1j*z/4
    b=mp.mpf('1.25')-1j*z/4
    o=mp.mpc(0)
    for m in range(1,M+1):
        q=pi*m*m
        o+=q**(1-a)*(2*mp.gammainc(a+1,q,mp.inf)-3*mp.gammainc(a,q,mp.inf))/4
        o+=q**(1-b)*(2*mp.gammainc(b+1,q,mp.inf)-3*mp.gammainc(b,q,mp.inf))/4
    return o
def xi(z):
    s=mp.mpf('.5')+1j*z/2
    return s*(s-1)*pi**(-s/2)*mp.gamma(s/2)*mp.zeta(s)/8

M=2
q=pi*(M+1)**2
E=3*q*mp.exp(-q)
for z in (mp.mpf('28.269'),
          mp.mpc('28.269','0.8'),
          mp.mpc('39.5','0.99'),
          mp.mpc('100','0.5')):
    trunc=fm(z,M)
    truth=xi(z)
    err=abs(truth-trunc)
    assert err<E
    print('z=',mp.nstr(z,8),
          '|FM|=',mp.nstr(abs(trunc),13),
          '|F-FM|=',mp.nstr(err,13),
          'E=',mp.nstr(E,10),
          'pointwise |FM|>E:',bool(abs(trunc)>E))
print('PASS 55-digit complex-strip tail replay.')
print('Rouché requires a certified boundary-wide minimum, not pointwise samples.')
