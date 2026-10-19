"""Exact, stdlib-only polynomial and rational-complex regression tests."""
from fractions import Fraction as F

def clean(p):
    while p and p[-1] == 0: p.pop()
    return p
def add(a,b):
    return clean([(a[i] if i<len(a) else 0)+(b[i] if i<len(b) else 0)
                  for i in range(max(len(a),len(b)))])
def scale(c,a): return clean([c*x for x in a])
def mul(a,b):
    r=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b): r[i+j]+=x*y
    return clean(r)
def derivative(a): return clean([i*a[i] for i in range(1,len(a))])
def T(a): return add(mul(derivative(a),derivative(a)),scale(-1,mul(a,derivative(derivative(a)))))

p0=[241,22,1];p1=[1,22,1]
assert T(p0)==scale(2,p1)
assert T(p1)==scale(2,p0)
b0=[62161,1848,16];b1=[44561,1848,16]
assert T(b0)==scale(32,b1)
assert T(b1)==scale(32,b0)

# Exact Gaussian-integer arithmetic.
class GI:
    def __init__(self,r=0,i=0): self.r,self.i=F(r),F(i)
    def __add__(self,o):
        if not isinstance(o,GI):o=GI(o)
        return GI(self.r+o.r,self.i+o.i)
    __radd__=__add__
    def __neg__(self):return GI(-self.r,-self.i)
    def __sub__(self,o):return self+-o if isinstance(o,GI) else self+GI(-o)
    def __mul__(self,o):
        if not isinstance(o,GI):o=GI(o)
        return GI(self.r*o.r-self.i*o.i,self.r*o.i+self.i*o.r)
    __rmul__=__mul__
    def __pow__(self,n):
        r=GI(1)
        for _ in range(n):r=r*self
        return r
    def __eq__(self,o):
        if not isinstance(o,GI):o=GI(o)
        return (self.r,self.i)==(o.r,o.i)

z=GI(4,F(1,4))
assert (16*z**2-255)**2+1024==GI(0)
# For smaller Fourier H(x)=(4*x^2-17)^2+8:
# H(2)=9, H'(2)=-32, H''(2)=496.
assert (-32)**2-9*496+2*9**2==-3278
print('PASS: 2 polynomial two-cycles, exact complex Fourier zero, Laguerre sign')
