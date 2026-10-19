"""A finite interval-Simpson/Rouche certificate for the THIRD classical Xi zero.

Proves the actual F(z)=xi(1/2+i*z/2)/4 has exactly one real simple
zero inside |z-50.02171516|<0.04. Independent panel counts 49152/65536.

Trust: mpmath.iv 1.3.0 transcendental outward enclosures; elementary
Simpson error theorem, theta Fourier identity, integral-tail estimates,
and Rouche's theorem. NOT an end-to-end Lean proof and NOT RH.
"""
import os
import mpmath as mp
from mpmath.libmp import to_rational
from fractions import Fraction as Q
from math import factorial

iv=mp.iv
iv.dps=28
N=int(os.environ.get("XI_THIRD_N","49152"))
assert N in (49152,65536)
X0=iv.mpf(5002171516)/iv.mpf(100000000)
PI=iv.pi

def rat_bounds(x):
    a,b=x._mpi_
    return Q(*to_rational(a)),Q(*to_rational(b))

# exp8 in (1000,5000), exp3>20, pi between 3 and 22/7.
exp8lo=sum((Q(8**k,factorial(k)) for k in range(8)),Q())
exp2hi=sum((Q(2**k,factorial(k)) for k in range(13)),Q())+Q(2**13,factorial(13))/(1-Q(1,7))
exp3lo=sum((Q(3**k,factorial(k)) for k in range(12)),Q())
assert exp8lo>1000 and exp2hi<8 and exp3lo>20
assert 8**4<5000
assert 16*5000**3+3*5000**2+2*5000+1<10**14
assert 2*10**14<10**500
# Every mode contribution beyond r=2, for each relevant integral,
# is <10^-500 by exponential suppression q exp(8)>3000.
TAIL=Q(1,10**20)

# P_(j+1)=(5-4w)P_j+4wP_j', and for j<=4:
# |phi_m^(j)(r)| <= ||P_j||_1 * (j+3)! for r>=0.
p=[-3,2]; B=[]
for j in range(5):
    B.append(sum(abs(t) for t in p)*factorial(j+3))
    nxt=[0]*(len(p)+1)
    for k,c in enumerate(p):
        nxt[k]+=(5+4*k)*c
        nxt[k+1]-=4*c
    p=nxt
assert B==[30,1272,79320,6800400,762395760]

# Four test integrands: a0, a1, a2 and
# majorant R3 = (sum phi_m)*r^3 exp(r/25)*64/3000000.
# Sum derivative bounds for BOTH m=1,2; |X0|<51.
M4=[]
for k in range(3):
    ctot=Q(0)
    for a in range(5):
        for b in range(min(k,4-a)+1):
            c=4-a-b
            mult=factorial(4)//(factorial(a)*factorial(b)*factorial(c))
            ctot+=Q(4,factorial(k))*mult*B[a]*Q(factorial(k),factorial(k-b))*2**(k-b)*51**c
    M4.append(ctot)
remM4=Q(0)
for a in range(5):
    for b in range(min(3,4-a)+1):
        c=4-a-b
        mult=factorial(4)//(factorial(a)*factorial(b)*factorial(c))
        # two modes, exp(r/25)<2: coefficient 4*(64/3000000)=256/3000000
        remM4+=Q(256,3000000)*mult*B[a]*Q(factorial(3),factorial(3-b))*2**(3-b)*Q(1,25)**c

def simpson_err(bound):
    return Q(2,180)*Q(2,N)**4*bound

h=iv.mpf(2)/N
s=[iv.mpf(0) for _ in range(4)]
for j in range(N+1):
    r=iv.mpf(2*j)/N
    t=iv.exp(4*r)
    phi=iv.mpf(0)
    for m in (1,2):
        q=PI*m*m
        phi+=q*(2*q*t-3)*iv.exp(5*r-q*t)
    co=iv.cos(X0*r)
    si=iv.sin(X0*r)
    v=[2*phi*co,-2*phi*r*si,-phi*r*r*co,
       phi*r**3*iv.exp(r/25)*iv.mpf(64)/3000000]
    w=1 if j in (0,N) else (4 if j%2 else 2)
    for k in range(4):
        s[k]+=w*v[k]
s=[z*h/3 for z in s]

bounds=[]
for k,z in enumerate(s):
    a,b=rat_bounds(z)
    err=simpson_err(M4[k] if k<3 else remM4)+TAIL
    bounds.append((a-err,b+err))
    print("n=",N,"coefficient=",k,
          "certified lower=",float(a-err),"upper=",float(b+err))

a0,a1,a2,rem=bounds
assert -Q(1,10**9)<a0[0] and a0[1]<Q(1,10**9)
assert a1[1]<-Q(156,10**9)
assert -Q(5,10**8)<a2[0] and a2[1]<Q(5,10**8)
assert 0<rem[0] and rem[1]<Q(27,10**10)
# Radius R=1/25, and E2 <10^-9.
margin=Q(156,10**9)*Q(1,25)-Q(1,10**9)-Q(5,10**8)*Q(1,625)-Q(27,10**10)
assert margin>Q(2,10**9)
assert Q(27)*Q(22,7)/20**9 < Q(1,10**9) < margin
print("PASS third Xi disk |z-50.02171516|<0.04: exactly one real simple zero")
print("Strict Rouché boundary: |F2|>2e-9 and E2<1e-9.")
print("NOT RH; mpmath.iv, Jacobi and classical analytic lemmas remain trusted.")
