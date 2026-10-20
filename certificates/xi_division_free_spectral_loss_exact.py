"""Exact rational audit of the division-free theta spectral heat-loss algebra.

The genuine Jacobi-theta convolution and Fourier inversion are analytic
results in paper/theta_spectral_loss.tex, not formally checked by this file.
"""
from fractions import Fraction as Q
from math import factorial

for n in range(301):
    assert Q(factorial(2*n+2),2*factorial(2*n))==(n+1)*(2*n+1)

mu={-1:Q(1,10),0:Q(1),1:Q(1,10)}
r=Q(4,5)
def spectral_loss(n, sign):
    acc=Q()
    for u,a in mu.items():
        for v,b in mu.items():
            d=u-v
            w=u+v
            acc += a*b*d**(2*n)*r**(w*w)*(1-r**(d*d))*sign(w)
    return acc/factorial(2*n)

central=spectral_loss(1,lambda w:1)
noncentral=spectral_loss(1,lambda w:(-1 if w%2 else 1))
assert central==Q(869,15625)
assert noncentral==-Q(131,15625)
assert ((-Q(8,125)+Q(738,15625))/2)==noncentral
assert ((Q(8,125)+Q(738,15625))/2)==central
for u,a in mu.items():
    for v,b in mu.items():
        assert a*b*(u-v)**2*r**((u+v)**2)*(1-r**((u-v)**2))>=0

print('PASS: 301 factorial heat-coupling identities')
print('PASS: central spectral loss = +869/15625')
print('PASS: noncentral spectral loss at x=pi = -131/15625')
print('PASS: all atom-pair weights nonnegative')
print('RH remains open; this is a sign obstruction, not a theta zero claim')
