"""Rigorous fixed-point interval certificate for T^5 s(0)<0.
Standard Xi kernel in Planat--Sole / Csordas normalization.
Python 3 stdlib only. Every arithmetic enclosure is directed by integer division.
"""
from fractions import Fraction
from math import factorial

D=10**110

def floordiv(a,b): assert b>0; return a//b
def ceildiv(a,b): assert b>0; return -((-a)//b)

class I:
    __slots__=('lo','hi')
    def __init__(self,lo,hi=None):
        self.lo=int(lo);self.hi=int(lo if hi is None else hi)
        assert self.lo<=self.hi
    @staticmethod
    def integer(n): return I(n*D)
    @staticmethod
    def rational(n,d): return I(floordiv(n*D,d),ceildiv(n*D,d))
    def __add__(self,o):
        o=toI(o);return I(self.lo+o.lo,self.hi+o.hi)
    __radd__=__add__
    def __neg__(self):return I(-self.hi,-self.lo)
    def __sub__(self,o):return self+-toI(o)
    def __rsub__(self,o):return toI(o)+-self
    def __mul__(self,o):
        o=toI(o)
        vals=(self.lo*o.lo,self.lo*o.hi,self.hi*o.lo,self.hi*o.hi)
        return I(floordiv(min(vals),D),ceildiv(max(vals),D))
    __rmul__=__mul__
    def divide_int(self,k):
        assert k>0
        return I(floordiv(self.lo,k),ceildiv(self.hi,k))
    def reciprocal(self):
        assert self.lo>0
        return I(floordiv(D*D,self.hi),ceildiv(D*D,self.lo))
    def __pow__(self,k):
        assert k>=0
        out=I.integer(1);q=self
        while k:
            if k&1:out=out*q
            k//=2
            if k:q=q*q
        return out
    def decimal(self,ndigits=20):
        def fmt(x):
            mark='-' if x<0 else ''
            x=abs(x)
            return f'{mark}{x//D}.{str(x%D).zfill(110)[:ndigits]}'
        return '['+fmt(self.lo)+', '+fmt(self.hi)+']'
    def sign(self):
        return 'CERTIFIED_NEGATIVE' if self.hi<0 else 'CERTIFIED_POSITIVE' if self.lo>0 else 'UNDETERMINED'

def toI(x):return x if isinstance(x,I) else I.integer(x)

# pi/4 = 4 arctan(1/5) - arctan(1/239).
# Alternating-series bounds use K even, first omitted term positive.
def atan_bounds_inv(m,K):
    assert K%2==0
    sm=sum((Fraction((-1)**j,(2*j+1)*m**(2*j+1)) for j in range(K)),Fraction(0))
    rem=Fraction(1,(2*K+1)*m**(2*K+1))
    return sm,sm+rem

l5,h5=atan_bounds_inv(5,100)
l239,h239=atan_bounds_inv(239,40)
plo=16*l5-4*h239;phi=16*h5-4*l239
piI=I(floordiv(plo.numerator*D,plo.denominator),ceildiv(phi.numerator*D,phi.denominator))
assert piI.lo > 3*D and piI.hi*7 < 22*D
print('PI enclosure:',piI.decimal(35))

# For 0<=x<1/2, exp(x) between S_80 and S_80+10^-110:
# sum_{j>=81} x^j/j! <= 2*(1/2)^81/81! <10^-110.
assert Fraction(2,2**81*factorial(81)) < Fraction(1,D)
def exp_small(x):
    assert x.lo>=0 and x.hi*2 < D
    summ=I.integer(1); term=I.integer(1)
    for j in range(1,81):
        term=(term*x).divide_int(j)
        summ=summ+term
    return I(summ.lo,summ.hi+1)

def exp_neg(q):
    y=q.divide_int(1024)
    e=exp_small(y)
    z=e.reciprocal()
    return z**1024

# Exact integer polynomial coefficients of P_j in x.
# d^j/dr^j [q(2qexp(4r)-3) exp(5r-qexp(4r))]
# = q exp(5r-qexp(4r)) P_j(qexp(4r)).
P=[[-3,2]]
for j in range(20):
    p=P[-1]; b=[0]*(len(p)+1)
    for i,c in enumerate(p):
        b[i]+=5*c;b[i+1]-=4*c
        if i:b[i]+=4*i*c
    P.append(b)
def polyval(p,x):
    ans=I.integer(0)
    for c in p[::-1]:ans=ans*x+c
    return ans

# For n>=13, q_n=pi*n^2, |P_{2k}(q_n)|<=C_{2k}q_n^(2k+1).
# Ratio consecutive terms <= (14/13)^44 2^-81 <1/2 for k<=10.
assert Fraction(14,13)**44*Fraction(1,2**81) < Fraction(1,2)
coeff=[]
for k in range(11):
    Ck=sum(map(abs,P[2*k]))
    tail=Fraction(2*Ck, factorial(2*k))*Fraction(22*169,7)**(2*k+2)*Fraction(1,2**507)
    assert tail < Fraction(4,10**83), (k,tail)
    subtotal=I.integer(0)
    for n in range(1,13):
        q=piI*(n*n)
        subtotal=subtotal + q*exp_neg(q)*polyval(P[2*k],q)
    # add +-4e-83, a rigorously conservative bound after division by (2k)!
    err=4*10**(110-83)
    a=subtotal.divide_int(factorial(2*k))
    coeff.append(I(a.lo-err,a.hi+err))

# Taylor coefficients a_j of s(t)=Phi(sqrt(t)) at t=0.
def mul_trunc(p,q,n):
    return [sum((p[i]*q[k-i] for i in range(k+1)),I.integer(0)) for k in range(n)]
def T(p):
    newlen=len(p)-2
    one=[(k+1)*p[k+1] for k in range(newlen)]
    two=[(k+2)*(k+1)*p[k+2] for k in range(newlen)]
    aa=mul_trunc(one,one,newlen)
    bb=mul_trunc(p,two,newlen)
    return [aa[k]-bb[k] for k in range(newlen)]

for m in range(6):
    print(f'T^{m} s(0)',coeff[0].sign(),coeff[0].decimal(22))
    if m<5:coeff=T(coeff)
assert coeff[0].hi<0
print('PASS: exact fixed-point arithmetic and analytic theta-tail certificate')
