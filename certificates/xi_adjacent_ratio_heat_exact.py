"""Exact adjacent-order Laguerre ratio heat identity and genuine Xi diagnostics.

D=∂s-0.5∂xx; D U_n=-V_n, D V_n=-k_n W_n.
Where U_n,V_n>0, R_n=V_n/U_n and
∂s R_n=0.5 R_n,xx+(log U_n),x R_n,x+R_n(R_n-R_(n+1)).

The genuine theta computations are exploratory 46-digit quadratures,
not interval certificates or an end-to-end Lean proof of RH.
"""
import sympy as sp
from fractions import Fraction as Q
from math import factorial, comb
import mpmath as mp
u,v,w,k,us,vs,uxx,vxx=sp.symbols("u v w k us vs uxx vxx")
E=sp.expand(u*(vs-vxx/2)-v*(us-uxx/2))
assert sp.simplify(E.subs({us:uxx/2-v,vs:vxx/2-k*w})-(v*v-k*u*w))==0
assert sp.simplify((v/u)*(v/u-k*w/v)-(v*v-k*u*w)/u**2)==0
print("PASS exact symbolic division-free identity and quotient reaction")

s,x,n=sp.symbols("s x n",real=True)
d=x*x+1-2*s
R=3/d
assert sp.simplify(sp.diff(R,s)-sp.diff(R,x,2)/2-sp.diff(sp.log(2*d),x)*sp.diff(R,x)-R**2)==0
A=3+2*s
q=(2*n+1)/A
qn=(2*n+3)/A
assert sp.simplify(sp.diff(q,s)-q*(q-qn))==0
e1,e2=Q(101,100),Q(1,100)
assert 6*e1==Q(303,50) and 15*e2/e1==Q(15,101)
assert 6*e1>15*e2/e1
print("PASS exact Gaussian, quadratic and real-root pair reversal controls")

mp.mp.dps=46
pi=mp.pi
def theta(r):
    E=mp.exp(4*r)
    return sum((pi*m*m*(2*pi*m*m*E-3)*mp.exp(5*r-pi*m*m*E)
                for m in range(1,9)), mp.mpf(0))
def ratios(t,x):
    jmax=8
    derivs=[mp.quad(lambda r,j=j: theta(r)*mp.exp(t*r*r)*r**j*mp.cos(x*r+j*pi/2),
                    [0,.08,.2,.35,.55,.8,1.2,2.5]) for j in range(jmax+1)]
    L=[(-1)**N*sum((-1)**j*comb(2*N,j)*derivs[j]*derivs[2*N-j]
                     for j in range(2*N+1))/factorial(2*N)
       for N in range(4)]
    return [(n+1)*(2*n+1)*L[n+1]/L[n] for n in range(3)]
for X in map(mp.mpf,["0","10","20","28.269","30","42.044"]):
    r=ratios(mp.mpf("0.5"),X)
    if X==mp.mpf("28.269"):
        assert r[0]>10 and 0<r[1]<mp.mpf(".2")
    print("t=.5 x=",mp.nstr(X,7),"ratios",
          *[mp.nstr(z,11) for z in r])
print("PASS exploratory 46-digit theta ratio reversal near x=28.269")
print("NO proof of RH; a theta-specific division-free source bound remains unproved")
