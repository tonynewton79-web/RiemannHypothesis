"""Theta-specific incomplete-gamma / Fourier / completed-zeta replay.

Numerical exploration only. mp.dps=55 and independent analytic routes.
The exact uniform real-frequency truncation proof is in the paper and
certificates/xi_square_lattice_uniform_tail.py.
"""
import mpmath as mp
mp.mp.dps=55
xs=[mp.mpf(0),mp.mpf(10),mp.mpf(20),mp.mpf('39.5')]
segs=[0,mp.mpf('.1'),mp.mpf('.35'),mp.mpf('.7'),mp.mpf('1.2'),2]

def phi_m(r,m):
    q=mp.pi*m*m
    return q*(2*q*mp.exp(4*r)-3)*mp.exp(5*r-q*mp.exp(4*r))

def Fgamma(x,M):
    a=mp.mpf('1.25')+1j*x/4
    def h(m):
        q=mp.pi*m*m
        return q**(1-a)*(2*mp.gammainc(a+1,q,mp.inf)-3*mp.gammainc(a,q,mp.inf))
    return mp.re(sum((h(m) for m in range(1,M+1))))/2

def Fquad(x,M,k=0):
    trigs=[mp.cos,lambda z:-mp.sin(z),lambda z:-mp.cos(z)]
    return 2*mp.quad(lambda r:sum((phi_m(r,m) for m in range(1,M+1)))*(r**k)*trigs[k](x*r),segs)

def xi(s):
    return s*(s-1)*mp.pi**(-s/2)*mp.gamma(s/2)*mp.zeta(s)/2

for x in xs:
    fg=Fgamma(x,3)
    fq=Fquad(x,3)
    fz=mp.re(xi(mp.mpf('.5')+1j*x/2))/4
    assert abs(fg-fq)<mp.mpf('1e-38')
    assert abs(fg-fz)<mp.mpf('1e-38')
    print('x=',mp.nstr(x,6),'gamma-quadrature gap=',mp.nstr(abs(fg-fq),7),
          'gamma-xi/4 gap=',mp.nstr(abs(fg-fz),7))

x=mp.mpf('39.5')
for M in (1,2,3):
    D=[Fquad(x,M,k) for k in range(3)]
    L1=D[1]**2-D[0]*D[2]
    print('M=',M,'L1=',mp.nstr(L1,34))
    if M==1: assert L1 < -mp.mpf('5e-11')
    else: assert L1 > mp.mpf('3e-11')
print('PASS independent 55-digit theta-gamma, real Fourier, completed-zeta replay')
print('M=1 negative L1, M=2 positive L1 at x=39.5: NUMERICAL ONLY.')
