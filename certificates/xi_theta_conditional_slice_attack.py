"""Riemann theta conditional-slice sign obstruction: exact and diagnostic tests.

For a real-even Fourier H_t and fixed-difference slice C_t(b,x),
int C db=H_t(x)^2 and int b² C db=2 L1[H_t](x).
At a simple real zero a this is 0 versus 2 H'_t(a)^2>0.
Consequently the slice has both signs and the b-Fourier symbol
H_t(a+eta) H_t(a-eta)<0 for small nonzero eta.

Exact control measure psi=(delta_-1+delta_1)/2:
C(0,pi/2)=-1/2, C(±2,pi/2)=1/4.
No RH conclusion. Numerical theta signs below are NOT interval-certified.
"""
from fractions import Fraction as Q
from math import cos,exp,pi

atoms={-2:Q(1,4),0:Q(-1,2),2:Q(1,4)}
assert sum(atoms.values(),Q())==0
assert sum((v*b*b for b,v in atoms.items()),Q())==2
assert atoms[0]<0<atoms[2]
print('PASS exact three-atom signed slice normalization and moment')

def phi(u):
    u=abs(u)
    if u>2.8:return 0.
    e=exp(4*u)
    return sum(pi*m*m*(2*pi*m*m*e-3)*exp(5*u-pi*m*m*e)
               for m in (1,2,3,4))
def simpson(f,a,b,n):
    assert n%2==0
    h=(b-a)/n
    value=f(a)+f(b)
    for j in range(1,n):
        value+=(4 if j%2 else 2)*f(a+j*h)
    return value*h/3
def slice_at(b,x,n):
    return simpson(lambda w:phi((w+b)/2)*phi((w-b)/2)*cos(x*w)/8,
                   -5.6,5.6,n)
x=Q(28269,1000)
for panels in (8000,16000):
    neg=slice_at(0,float(x),panels)
    pos=slice_at(.5,float(x),panels)
    assert neg< -Q(2,10**7) and pos>Q(5,10**8)
    print(f'NUMERICAL ONLY panels={panels}: C(0,28.269)={neg:.14g}, C(.5,28.269)={pos:.14g}')
print('PASS independent finite rational atomic proof gates and double-mesh theta diagnostics')
print('RH OPEN: signed b-slice positivity fails; weighted moment positivity unproved.')
