"""Transform-side generalized Laguerre tests for the actual Jacobi-theta kernel.

NUMERICAL ONLY: mpmath high precision is not an interval proof.
The genuine Fourier transform is F(x)=2∫_0^∞Phi(u)cos(x*u)du
= xi(1/2+i*x/2)/4 in this normalization.
Expected first positive zero is x≈28.269, twice the first ordinates of zeta.
run: python -m pip install mpmath
     python certificates/generalized_laguerre_scan.py
"""
import mpmath as mp

mp.mp.dps=65

def phi(u):
    e=mp.exp(4*u)
    out=mp.mpf(0)
    for m in range(1,13):
        q=mp.pi*m*m
        out+=q*(2*q*e-3)*mp.exp(5*u-q*e)
    return out

def xi_fourier(x):
    return 2*mp.quad(lambda u:phi(u)*mp.cos(x*u),
                       [0,mp.mpf('0.2'),mp.mpf('0.4'),mp.mpf('0.7'),1,2])

def xi_zeta(x):
    s=mp.mpf('0.5')+mp.j*x/2
    return mp.mpf('0.125')*s*(s-1)*mp.power(mp.pi,-s/2)*mp.gamma(s/2)*mp.zeta(s)

def derivatives(x,kmax):
    out=[]
    for k in range(kmax+1):
        phase=k % 4
        if phase==0: f=lambda u: phi(u)*u**k*mp.cos(x*u)
        elif phase==1: f=lambda u:-phi(u)*u**k*mp.sin(x*u)
        elif phase==2: f=lambda u:-phi(u)*u**k*mp.cos(x*u)
        else: f=lambda u:phi(u)*u**k*mp.sin(x*u)
        out.append(2*mp.quad(f,[0,mp.mpf('0.2'),mp.mpf('0.4'),mp.mpf('0.7'),1,2]))
    return out

def L(d,n):
    return (-1)**n/mp.factorial(2*n)*sum(
        (-1)**k*mp.binomial(2*n,k)*d[k]*d[2*n-k]
        for k in range(2*n+1)
    )

def center_moment(j):
    if j%2: return mp.mpf(0)
    return 2*mp.quad(lambda u:phi(u)*u**j,[0,mp.mpf('0.2'),mp.mpf('0.4'),mp.mpf('0.7'),1,2])

def radius(n,M):
    A=mp.mpf(0);B=mp.mpf(0)
    for k in range(2*n+1):
        c=(-1)**k*mp.binomial(2*n,k)
        A+=c*M[k]*M[2*n-k]
        B+=c*(M[k+2]*M[2*n-k]+2*M[k+1]*M[2*n-k+1]+M[k]*M[2*n-k+2])
    return mp.sqrt(2*A/B)

def main():
    locations=[0,5,10,15,20,25,28,30]
    for x in locations:
        d=derivatives(x,10)
        v=[L(d,n) for n in range(1,6)]
        assert all(w>0 for w in v)
        print('x=',x,'L1=',mp.nstr(v[0],16),'L5=',mp.nstr(v[-1],16),'positive n=1..5')
    # Independent computation through zeta and gamma, not Fourier quadrature.
    for x in [0,10,28]:
        ds=derivatives(x,4)
        dz=[mp.re(mp.diff(xi_zeta,x,k)) for k in range(5)]
        error=max(abs(a-b)/max(mp.mpf('1e-40'),abs(a)) for a,b in zip(ds,dz))
        assert error<mp.mpf('1e-45')
        print('independent Xi/zeta derivative replay:',x,'relative error <',mp.nstr(error,5))
    moments=[center_moment(j) for j in range(19)]
    for n in range(1,9):
        print('n=',n,'local cosine-minorant positivity radius:',
              mp.nstr(radius(n,moments),16))
    print('PASS: numerical scan and independent zeta-normalization replay.')
    print('Not a rigorous interval certificate and not a proof of RH.')

if __name__=='__main__':main()
