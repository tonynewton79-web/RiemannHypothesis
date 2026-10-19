"""Certified first real Riemann Xi zero in the disk |z-28.269|<0.5.

This is a *finite* interval/Simple Rouché proof, not RH. Trust boundary:
mpmath.iv 1.3.0 transcendental interval enclosure implementation,
classical composite Simpson theorem, Jacobi theta Fourier identity,
Fourier theta-tail estimate, and standard Rouché theorem.

Proof in paper/xi_first_zero_interval_certificate.tex.
Uses mpmath.iv outward binary interval endpoints converted to exact
rational fractions, plus a provable 4th-derivative Simpson error.
Run: python -m pip install mpmath==1.3.0
     python certificates/xi_first_zero_interval.py
"""
import os
import mpmath as mp
from mpmath.libmp import to_rational
from fractions import Fraction as Q
from math import factorial

mp.iv.dps=28
iv=mp.iv
N=int(os.environ.get('XI_ZERO_SIMPSON_N', '8192'))
assert N in (8192,16384)
x0=iv.mpf(28269)/iv.mpf(1000)
pi=iv.pi
def exact_bounds(x):
    a,b=x._mpi_
    return Q(*to_rational(a)),Q(*to_rational(b))

# Rigorous rational exponential comparisons:
# e^8>1000, e^8<(e^2)^4<8^4<5000, e^3>20.
assert sum((Q(8**k,factorial(k)) for k in range(8)),Q())>1000
exp2upper=sum((Q(2**k,factorial(k)) for k in range(13)),Q())
exp2upper+=Q(2**13,factorial(13))/(1-Q(1,7))
assert exp2upper<8 and 8**4<5000
assert sum((Q(3**k,factorial(k)) for k in range(12)),Q())>20
assert 16*5000**3 + 3*5000**2+2*5000+1 < 10**14
# Tail beyond r=2 of all four integrands <1e-20.
# Set T=e^8 in [1000,5000], q=pi*m² in (3,16), m=1,2.
# Incomplete gamma integer-degree bound:
# e^(-q*T)(q*T³+3*T²+6*T/q+6/q²)<1e14*20^-1000,
# summed over two modes <1e-20.
assert 2*10**14 < 10**500
TAIL=Q(1,10**20)

# Every derivative phi_m^(j) of order j<=4 obeys
# |phi_m^(j)(r)| <= B_j for all r>=0, q>=3.
# phi_m^(j) = q^-1/4*w^(5/4)*exp(-w)*P_j(w),
# w=q*exp(4r)>=3, |P_j(w)| <= ||P_j||_1 w^(j+1),
# and w^(j+3)*exp(-w)<=(j+3)!.
poly=[-3,2];B=[]
for j in range(5):
    B.append(sum(abs(v) for v in poly)*factorial(j+3))
    new=[0]*(len(poly)+1)
    for k,c in enumerate(poly):
        new[k]+=(5+4*k)*c
        new[k+1]-=4*c
    poly=new
assert B==[30,1272,79320,6800400,762395760]

# Composite Simpson 4th-derivative bounds for:
# a0: 2*phi*cos(x0*r)
# a1: -2*phi*r*sin(x0*r)
# a2: -phi*r²*cos(x0*r)
# R3 majorant: phi*r³*exp(r/2)/24.
# On [0,2], |x0|<29, exp(r/2)<3, and there are 2 modes.
def mult(a,b,c):
    return factorial(4)//(factorial(a)*factorial(b)*factorial(c))
M4=[]
for k in range(3):
    bound=Q(0)
    for a in range(5):
        for b in range(min(k,4-a)+1):
            c=4-a-b
            bound+=Q(4,factorial(k))*mult(a,b,c)*B[a]*Q(factorial(k),factorial(k-b))*2**(k-b)*29**c
    M4.append(bound)
remB=Q(0)
for a in range(5):
    for b in range(min(3,4-a)+1):
        c=4-a-b
        remB+=Q(1,4)*mult(a,b,c)*B[a]*Q(factorial(3),factorial(3-b))*2**(3-b)*Q(1,2)**c
def simp_error(B4):return Q(2,180)*Q(2,N)**4*B4
assert max(simp_error(b) for b in [*M4,remB])<Q(1,10**6)

h=iv.mpf(2)/N
acc=[iv.mpf(0) for _ in range(4)]
for j in range(N+1):
    r=iv.mpf(2*j)/N
    e=iv.exp(4*r)
    phi=iv.mpf(0)
    for m in (1,2):
        q=pi*m*m
        phi+=q*(2*q*e-3)*iv.exp(5*r-q*e)
    cs=iv.cos(x0*r);sn=iv.sin(x0*r)
    vals=[2*phi*cs,-2*phi*r*sn,-phi*r*r*cs,
          phi*r**3*iv.exp(r/2)/24]
    weight=1 if j in (0,N) else (4 if j%2 else 2)
    for k in range(4):acc[k]+=weight*vals[k]
acc=[v*h/3 for v in acc]
cert=[]
for k,z in enumerate(acc):
    lo,hi=exact_bounds(z)
    delta=simp_error(M4[k] if k<3 else remB)+TAIL
    cert.append((lo-delta,hi+delta))
    print('coefficient',k,':',float(lo-delta),float(hi+delta))
a0,a1,a2,R3=cert
assert -Q(1,10**6)<a0[0] and a0[1]<Q(1,10**6)
assert a1[1]<-Q(17,10**5)
assert -Q(52,10**6)<a2[0] and a2[1]<Q(52,10**6)
assert 0<R3[0] and R3[1]<Q(6,10**6)
# On |w|=0.5, F2(x0+w)=a0+a1*w+a2*w²+R3(w):
margin=Q(17,10**5)/2-Q(1,10**6)-Q(52,10**6)/4-Q(6,10**6)
assert margin==Q(65,10**6)
# Analytic theta tail for |Im(z)|<=7, M=2:
# E2=27*pi*e^(-9*pi) <27*(22/7)/20^9<1e-9.
assert Q(27)*Q(22,7)/20**9<Q(1,10**9)<margin
print('PASS: |F2| > 65e-6 on entire first-zero disk boundary')
print('PASS: E2 < 1e-9; true Xi and F2 have same one-zero count')
print('PASS: unique zero is real by conjugation symmetry')
print('This is a finite interval-library based certificate, not a full Lean proof or RH.')
