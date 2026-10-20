"""Validated first compact comparison on the REAL Riemann theta heat flow.

K=[0,1/2] x [-1/100,1/100], n=1, M=2, c=C_K=1.
Prove k_1*U_(2,2)-U_(1,2) <= -k_1*e_(2,2)-e_(1,2)
on ALL of K using actual theta moments, outward-rounded mpmath.iv
1.3.0 and analytic Simpson/tail majorants. No RH assumption.

Run XI_RECT_N=8192 or 16384 with python and pinned mpmath==1.3.0.
The Lean module checks the final rational inequalities only.
"""
import os
from fractions import Fraction as Q
from math import factorial,comb
import mpmath as mp
from mpmath.libmp import to_rational

N=int(os.environ.get("XI_RECT_N","8192"))
assert N in (8192,16384)
iv=mp.iv; iv.dps=35
def interval(v):
    a,b=v._mpi_
    return Q(*to_rational(a)),Q(*to_rational(b))

# Exact P recurrence; phi_m^(j) = q_m exp(5r-q_m e^(4r))*P_j(q_m e^(4r)).
# For r>=0 and q_m>=3: |phi_m^(j)| <= B_j
# with B_j=||P_j||_1*(j+3)!.
p=[-3,2]; B=[]
for j in range(5):
    B.append(sum(abs(c) for c in p)*factorial(j+3))
    nxt=[0]*(len(p)+1)
    for k,c in enumerate(p):
        nxt[k]+=(5+4*k)*c
        nxt[k+1]-=4*c
    p=nxt
assert B==[30,1272,79320,6800400,762395760]

# Derivative of r^j exp(r²/2) has form polynomial * exp(r²/2);
# coefficients remain nonnegative, so the following upper envelope
# also covers 0<=t<=1/2 and 0<=r<=2.
def derivative_envelope(j,b):
    p=[0]*j+[1]
    for _ in range(b):
        out=[0]*(len(p)+1)
        for k,c in enumerate(p):
            if k:out[k-1]+=k*c
            out[k+1]+=c
        p=out
    return sum(c*2**k for k,c in enumerate(p))

# The factor 16 = 2 modes * e²<8. Four derivatives by Leibniz.
M4=[16*sum(comb(4,a)*B[a]*derivative_envelope(j,4-a)
       for a in range(5)) for j in range(5)]
def SimpsonError(j):return Q(2,180)*Q(2,N)**4*M4[j]

# r>=2 tails: e^(tr²)<=e^(e^(4r)), r^j<=j!e^r, and
# phi_m(r)<=2q_m² exp(9r-q_m e^(4r)).
# Substitution w=e^(4r)>e^8>1000 and q_m in (3,16)
# gives tail<=j!*256*int_1000^infty w²exp(-2w)dw < 10^-100.
assert sum((Q(8**k,factorial(k)) for k in range(8)),Q())>1000
assert sum((Q(3**k,factorial(k)) for k in range(9)),Q())>20
TAIL=Q(1,10**100)
assert factorial(4)*256*501001/20**666<TAIL

h=iv.mpf(2)/N
S0=[iv.mpf(0) for _ in range(5)]
S1=[iv.mpf(0) for _ in range(5)]
for i in range(N+1):
    r=iv.mpf(2*i)/N
    exp4=iv.exp(4*r)
    phi=iv.mpf(0)
    for m in (1,2):
        q=iv.pi*m*m
        phi+=q*(2*q*exp4-3)*iv.exp(5*r-q*exp4)
    heat=iv.exp(r*r/2)
    weight=1 if i in (0,N) else 4 if i%2 else 2
    rk=iv.mpf(1)
    for j in range(5):
        S0[j]+=weight*rk*phi
        S1[j]+=weight*rk*phi*heat
        rk*=r
S0=[v*h/3 for v in S0]
S1=[v*h/3 for v in S1]
def enclose(v,j):
    lo,hi=interval(v)
    err=SimpsonError(j)+TAIL
    return lo-err,hi+err

lower0=[enclose(S0[j],j)[0] for j in range(5)]
upper1=[enclose(S1[j],j)[1] for j in range(5)]
assert lower0[0]>Q(1,20)
assert lower0[2]>Q(1,2000)
UP=(Q(1,10),Q(1,100),Q(1,1000),Q(1,5000),Q(1,30000))
for j in range(5):
    assert upper1[j]<UP[j],(j,float(upper1[j]),float(UP[j]))
    print("moment",j,"t=0 lower",float(lower0[j]),
          "t=1/2 upper",float(upper1[j]),
          "Simpson error",float(SimpsonError(j)))

# H_t(x)>=mu0(0)-R²mu2(1/2)/2,
# -H_t''(x)>=mu2(0)-R²mu4(1/2)/2
# via cos(y)>=1-y²/2. Because H'^2>=0,
# U1=H'^2-H*H'' >= product of positive lower bounds.
# |U2|<=mu0mu4/12+mu1mu3/3+mu2²/4, uniformly in x,t.
R=Q(1,100)
U1lo=(Q(1,20)-R*R*Q(1,1000)/2)*(Q(1,2000)-R*R*Q(1,30000)/2)
U2hi=Q(1,10)*Q(1,30000)/12+Q(1,100)*Q(1,5000)/3+Q(1,1000)**2/4
source=6*U2hi-U1lo

# For 2-mode tail q3=9pi, with 27<q3<198/7,
# exp(-(q3-1/16)) < 20^-8 because q3-1/16>24.
# Earlier analytic uniform Laguerre bound has C_*<100.
thetaCommon=Q(198,7)/20**8
en=lambda n:Q(3*(2*n+1)*100,2*4**(2*n))*thetaCommon
budget=6*en(2)+en(1)
assert budget<Q(1,10**7)
assert source+budget<-Q(1,10**5)
print("PASS first RECTANGLE n=1, M=2, c=C_K=1")
print("full s in [0,1/2], x in [-1/100,1/100]")
print("finite source upper",float(source),"theta budget upper",float(budget))
print("certified strict transfer margin",float(-source-budget))
print("Does not certify all orders or all heights; RH remains open.")
