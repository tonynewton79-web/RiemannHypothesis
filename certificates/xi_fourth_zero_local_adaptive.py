"""Fourth Xi zero: local interval-Simpson / Rouché certificate.

Proves one real simple zero of F(z)=xi(1/2+i*z/2)/4 inside
|z-60.849752252|<1/200. Two independent panel counts 24576,32768.

Trust assumptions: mpmath.iv 1.3.0 outward enclosures for exp/trig/pi,
classical composite Simpson remainder, Jacobi theta Fourier identity,
standard exponential/integral tail inequalities, and Rouché theorem.
Not end-to-end Lean; not RH.
"""
import os
import mpmath as mp
from mpmath.libmp import to_rational
from fractions import Fraction as Q
from math import factorial

iv=mp.iv
iv.dps=28
N=int(os.environ.get("XI_FOURTH_N","24576"))
assert N in (24576,32768)
M=3
R=Q(1,200)
Z0=iv.mpf(60849752252)/iv.mpf(1000000000)
PI=iv.pi
TAIL=Q(1,10**16)

def endpoints(v):
    a,b=v._mpi_
    return Q(*to_rational(a)),Q(*to_rational(b))

def absup(v):
    a,b=endpoints(v)
    return max(abs(a),abs(b))

# P0=2w-3, P_(j+1)=(5-4w)*P_j+4w*P_j'.
polys=[[-3,2]]
for _ in range(4):
    p=polys[-1]
    nxt=[0]*(len(p)+1)
    for k,c in enumerate(p):
        nxt[k]+=(5+4*k)*c
        nxt[k+1]-=4*c
    polys.append(nxt)

# Interval enclosures on ALL 80 segments [ell/100,(ell+1)/100].
# phi_m^(j)=q_m exp(5r-q_m exp(4r)) P_j(q_m exp(4r)).
# B_j bounds sum over m<=3 of |phi_m^(j)| uniformly on segment.
M4=[Q(0)]*4
for ell in range(80):
    r=iv.mpf([ell,ell+1])/iv.mpf(100)
    B=[Q(0)]*5
    for m in range(1,M+1):
        q=PI*m*m
        w=q*iv.exp(4*r)
        pref=q*iv.exp(5*r-w)
        for j,p in enumerate(polys):
            v=iv.mpf(0)
            for c in p[::-1]:
                v=v*w+c
            B[j]+=absup(pref*v)
    for k in range(3):
        val=Q(0)
        for a in range(5):
            for b in range(min(k,4-a)+1):
                c=4-a-b
                mult=factorial(4)//(factorial(a)*factorial(b)*factorial(c))
                val+=Q(2,factorial(k))*mult*B[a]*Q(factorial(k),factorial(k-b))*2**(k-b)*61**c
        M4[k]=max(M4[k],val)
    # fourth derivative of sum(phi_m)*r^3*exp(r/200)/24000000.
    # extra factor 2 bounds exp(r/200) on [0,4/5].
    rem=Q(0)
    for a in range(5):
        for b in range(min(3,4-a)+1):
            c=4-a-b
            mult=factorial(4)//(factorial(a)*factorial(b)*factorial(c))
            rem+=Q(2,24_000_000)*mult*B[a]*Q(factorial(3),factorial(3-b))*2**(3-b)*R**c
    M4[3]=max(M4[3],rem)

# Composite Simpson error is (4/5)/180 * ((4/5)/N)^4 * M4.
def simerr(x): return Q(4,5*180)*Q(4,5*N)**4*x
assert simerr(M4[0])<Q(3,10**13)
assert simerr(M4[1])<Q(6,10**13)
assert simerr(M4[2])<Q(6,10**13)
assert simerr(M4[3])<Q(1,10**19)
print("PASS 80 local fourth-derivative interval majorants")
print("Simpson errors:",*[float(simerr(z)) for z in M4])

# Beyond r=4/5, t=e^(4r)>e^3>20 and 3<q_m<29.
# All four coefficient integral tails are bounded by
# sum_{m<=3} q_m^2 integral_{20}^infty t^3 exp(-q_m t)dt.
# This follows from phi_m<=2q_m² exp(9r-q_m exp(4r)),
# r^k<=k!exp(4r)/4^k (k=0,1,2), and
# r^3 exp(r/200) <= (2/9)exp(4r).
# Replacing q_m by 3 in the exponential, q_m² by 29²:
# tail < 3*29²*exp(-60)*(20³/3+20²/3+40/9+2/27).
assert sum((Q(3**k,factorial(k)) for k in range(12)),Q())>20
gamma3=Q(20**3,3)+Q(20**2,3)+Q(40,9)+Q(2,27)
assert 3*29**2*gamma3/Q(20**20)<TAIL

h=iv.mpf(4)/(5*N)
acc=[iv.mpf(0) for _ in range(4)]
for i in range(N+1):
    r=iv.mpf(4*i)/(5*N)
    e=iv.exp(4*r)
    phi=iv.mpf(0)
    for m in range(1,M+1):
        q=PI*m*m
        phi+=q*(2*q*e-3)*iv.exp(5*r-q*e)
    co=iv.cos(Z0*r)
    si=iv.sin(Z0*r)
    vals=[2*phi*co,-2*phi*r*si,-phi*r*r*co,
          phi*r**3*iv.exp(r/200)/24_000_000]
    weight=1 if i in (0,N) else (4 if i%2 else 2)
    for k in range(4):
        acc[k]+=weight*vals[k]
acc=[z*h/3 for z in acc]

cert=[]
for k,z in enumerate(acc):
    lo,hi=endpoints(z)
    delta=simerr(M4[k])+TAIL
    cert.append((lo-delta,hi+delta))
    print("coefficient",k,"certified lower/upper",float(lo-delta),float(hi+delta))
a0,a1,a2,rem=cert
assert -Q(5,10**13)<a0[0] and a0[1]<Q(5,10**13)
assert Q(3012,10**12)<a1[0]
assert -Q(15,10**10)<a2[0] and a2[1]<Q(15,10**10)
assert 0<rem[0] and rem[1]<Q(52,10**13)
margin=Q(3012,10**12)*R-Q(5,10**13)-Q(15,10**10)*R**2-Q(52,10**13)
assert margin>Q(8,10**12)
# q4=16pi in (48,51), so E3<153*20^-16<10^-18.
assert Q(153,20**16)<Q(1,10**18)<margin
print("PASS fourth genuine Xi disk |z-60.849752252|<0.005")
print("Rouché: |F3|>8e-12 on contour, |F-F3|<1e-18")
print("Exactly one zero, real and simple; finite test, not RH.")
