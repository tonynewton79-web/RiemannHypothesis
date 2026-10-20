"""Independent Gaussian quadrature replay of genuine theta central Laguerre ratios.

The mathematical theorem is an exact convolution-moment identity, not
dependent on this numerical diagnostic. Gaussian quadrature at 512,
1024 and 2048 nodes on [0,2.3] shows the monotonic ratios for n<=55
at t=0 and t=1/2; high-r contributions decay super-exponentially.

Requires numpy and scipy. Does NOT constitute an interval certificate.
"""
import numpy as np
from numpy.polynomial.legendre import leggauss
from scipy.special import gammaln
from math import pi
saved={}
for nodes in (512,1024,2048):
    v,w=leggauss(nodes)
    u=(v+1)*1.15
    w=w*1.15
    exp4=np.exp(4*u)
    phi=sum((pi*m*m*(2*pi*m*m*exp4-3)
            *np.exp(5*u-pi*m*m*exp4) for m in range(1,8)))
    for t in (0.0,0.5):
        wt=phi*np.exp(t*u*u)*w
        js=np.arange(61)
        mu=np.array([np.dot(wt,u**(2*j)) for j in js])
        aa=np.exp(np.log(mu)-gammaln(2*js+1))
        bb=np.convolve(aa,aa)
        ratios=np.array([(n+1)*(2*n+1)*bb[n+1]/bb[n]
                         for n in range(60)])
        assert np.all(ratios>0)
        assert np.all(np.diff(ratios[:56])>0)
        key=(t, tuple([1,5,20,55]))
        row=np.array([ratios[n] for n in key[1]])
        if nodes==512:saved[key]=row
        else:assert np.allclose(row,saved[key],rtol=2e-8,atol=1e-12)
        print(f'nodes={nodes}, t={t}: '+
              ', '.join(f'R_{n}={ratios[n]:.9f}' for n in key[1]))
print('PASS genuine theta exploratory quadrature agreement; no global RH proof.')
