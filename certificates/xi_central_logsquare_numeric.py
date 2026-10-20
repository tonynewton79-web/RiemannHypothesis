"""Numerical, non-certifying check of genuine theta central moment scale.

Uses the positive double integral
M_{2n}(t)=∬ (u+v)^(2n) Phi_t(u)Phi_t(v) du dv.
The equally valid 'difference' form follows from evenness.
The true asymptotic proof is analytical in
paper/theta_central_logsquare_asymptotic.tex.

Gauss-Legendre quadrature with logsumexp avoids underflow and
compares independently chosen 320/500 node grids.
"""
import math
import numpy as np
from numpy.polynomial.legendre import leggauss
from scipy.special import logsumexp

def compute(grid, t, orders=(20,55,100,300,1000)):
    nodes, weights=leggauss(grid)
    u=2*nodes
    y=np.exp(4*np.abs(u))
    terms=[]
    for m in range(1,5):
        q=math.pi*m*m
        terms.append(np.log(q*(2*q*y-3))+5*np.abs(u)-q*y)
    lp=logsumexp(np.asarray(terms),axis=0)+t*u*u+np.log(2*weights)
    lw=np.log(np.maximum(np.abs(u[:,None]+u[None,:]),1e-200))
    base=lp[:,None]+lp[None,:]
    return {n:0.5*np.exp(logsumexp(base+(2*n+2)*lw)-
                          logsumexp(base+2*n*lw)) for n in orders}

for t in (0.0,0.5):
    coarse=compute(320,t)
    fine=compute(500,t)
    for n in coarse:
        assert abs(coarse[n]-fine[n])<5e-7, (t,n,coarse[n],fine[n])
        leading=math.log(n)**2/8
        print(f't={t:.1f} n={n:4d} central source ratio={fine[n]:.9f}, '
              f'leading log² n /8={leading:.9f}, ratio={fine[n]/leading:.6f}')
print('PASS: independent 320/500-grid theta quadrature values agree to <5e-7.')
print('These finite-n values illustrate very slow convergence; they do NOT prove the asymptotic.')
