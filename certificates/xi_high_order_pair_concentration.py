"""Theta pair-concentration experiment and exact quartic algebra control.

The theorem in paper/theta_high_order_compact.tex is analytic.
This test is an *independent numerical diagnostic* of its mechanism.
Two composite Simpson meshes test the normalized pair-sum variance
and cosine coefficients for genuine Jacobi-theta heat times.

No finite sample can prove the all-n/all-x/all-time statement.
"""
from fractions import Fraction as Q
from math import exp,cos,pi

for w in range(-5,6):
    for d in range(-5,6):
        W,D=Q(w),Q(d)
        assert ((W+D)/2)**4+((W-D)/2)**4 == (
            W**4+6*W*W*D*D+D**4)/8
        assert Q(3,2)*(W*W+D*D)>=Q(3,2)*D*D
print("PASS exact rational quartic pair-squeezing identity")

def theta(u):
    u=abs(u)
    e4=exp(4*u)
    out=0.
    for m in range(1,8):
        q=pi*m*m
        out+=q*(2*q*e4-3)*exp(5*u-q*e4)
    return out

def sweep(mesh,t,n):
    assert mesh%2==0
    left,right=-2.4,2.4
    dx=(right-left)/mesh
    xx=[left+i*dx for i in range(mesh+1)]
    hw=[(1 if i in (0,mesh) else (4 if i%2 else 2))*dx/3
        for i in range(mesh+1)]
    h=[theta(x)*exp(t*x*x)/2 for x in xx]
    weights=[a*b for a,b in zip(hw,h)]
    mass=second=cosine=0.
    for i,u in enumerate(xx):
        wi=weights[i]
        for j,v in enumerate(xx):
            d=abs(u-v)
            if d==0:continue
            p=wi*weights[j]*d**(2*n)
            q=u+v
            mass+=p
            second+=p*q*q
            cosine+=p*cos(8*q)
    return second/mass,cosine/mass

orders=(2,4,8,16,32,64,100)
for t in (0.,.25,.5):
    prev=None
    for n in orders:
        v0,f0=sweep(160,t,n)
        v1,f1=sweep(240,t,n)
        assert abs(v0-v1)<2e-6,(t,n,v0,v1)
        assert abs(f0-f1)<2e-5,(t,n,f0,f1)
        assert v1>0
        if prev is not None: assert v1<prev
        if n>=16:assert f1>0
        prev=v1
        print(f"heat t={t:.2f}, n={n:3d}: E(W²)={v1:.9f}, E cos(8W)={f1:.9f}")
print("PASS diagnostic convergence on two meshes; analytic theorem is separate.")
