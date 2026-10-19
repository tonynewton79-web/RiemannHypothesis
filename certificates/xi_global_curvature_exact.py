"""Global positive third curvature of the classical Jacobi/Riemann Xi kernel.
Dependency-free Python 3 interval certificate, exact integer arithmetic only.

x = pi*exp(4u).  phi(u) = pi*exp(5u-x)*A_0(x), with
 A_j(x) = sum_{m>=1} (-1)^j m^(2+2j)
             (2*m*m*x-3-2*j)*exp(-(m*m-1)*x).
 A_j' = A_j + A_{j+1}.
 V'''(u) = 64 H(x)/A_0(x)^3, V=-log(phi).
 H(x) = -x^3*(A3*A0^2-3*A1*A2*A0+2*A1^3)
        -3*x^2*(A2*A0^2-A1^2*A0)-x*A1*A0^2.

To obtain strict positivity at x=pi, use the exact Jacobi modular
identity: phi is even in u, hence H(pi)=0.
100 intervals certify H'(x)>46 on [pi,7/2].
400 intervals certify H(x)>26 on [7/2,6].

For x>=6, write Aj=(-1)^j(2*x-3-2*j)+Ej.
For j<=3, |Ej|<=6144*x*exp(-3*x): m>=2 terms have magnitude
<=3*x*m^10 exp(-(m^2-1)*x), and their ratio is <1/2.
H0=x*(8*x^3-36*x^2+42*x-45)>7*x^4/4, while
|H-H0|<=6144*x^4*exp(-3*x)*(162*x^2+162*x+27).
The last exponential-polynomial factor decreases for x>=6.
Since exp(18)>20^6=64,000,000, the relative perturbation
<6144*6831/64,000,000<7/4. Hence H>0 on x>=6.

This certificate is not an end-to-end Lean proof or a proof of RH.
"""
from fractions import Fraction as F
from math import factorial

D=10**65
class I:
    __slots__=("lo","hi")
    def __init__(self,lo,hi=None):
        self.lo=int(lo);self.hi=int(lo if hi is None else hi)
        assert self.lo<=self.hi
    @staticmethod
    def rational(a,b=1):
        return I(a*D//b,-(-a*D//b))
    def __add__(a,b):
        b=asI(b);return I(a.lo+b.lo,a.hi+b.hi)
    __radd__=__add__
    def __neg__(a):return I(-a.hi,-a.lo)
    def __sub__(a,b):return a+-asI(b)
    def __rsub__(a,b):return asI(b)+-a
    def __mul__(a,b):
        b=asI(b)
        c=(a.lo*b.lo,a.lo*b.hi,a.hi*b.lo,a.hi*b.hi)
        return I(min(c)//D,-(-max(c)//D))
    __rmul__=__mul__
    def __pow__(a,n):
        assert n>=0
        o=I.rational(1)
        while n:
            if n&1:o=o*a
            n//=2
            if n:a=a*a
        return o
    def divnat(a,n):
        assert n>0
        return I(a.lo//n,-(-a.hi//n))
    def inv(a):
        assert a.lo>0
        return I(D*D//a.hi,-(-D*D//a.lo))
def asI(x):return x if isinstance(x,I) else I.rational(x)

# Positive Taylor expansion: 0<=z<1/4.
# exp(z) in [sum_0^80 z^j/j!, sum_0^80 z^j/j!+2/(4^81*81!)].
assert F(2,4**81*factorial(81))<F(1,D)
def exp_small(z):
    assert z.lo>=0 and 4*z.hi<D
    total=I.rational(1);term=total
    for j in range(1,81):
        term=(term*z).divnat(j)
        total=total+term
    return I(total.lo,total.hi+1)
def exp_minus(y):
    # exp(-y) = exp(y/4096)^(-4096)
    return exp_small(y.divnat(4096)).inv()**4096

# pi=16 atan(1/5)-4 atan(1/239); alternating rational remainder.
def atan_interval(m,n):
    assert n%2==0
    s=sum((F((-1)**j,(2*j+1)*m**(2*j+1))
           for j in range(n)),F(0))
    return s,s+F(1,(2*n+1)*m**(2*n+1))
l5,h5=atan_interval(5,90)
l239,h239=atan_interval(239,70)
plo=16*l5-4*h239
phi=16*h5-4*l239
pi=I(plo.numerator*D//plo.denominator,
     -(-phi.numerator*D//phi.denominator))
assert pi.lo>3*D and pi.hi<I.rational(7,2).lo
assert 7*pi.hi<22*D

# On [pi,6], for j<=4 and m>=9, omitted terms are bounded by
# 23*m^12*2^(-3(m^2-1)), whose successive ratio is <1/2.
assert F(10,9)**12 / 2**(3*19)<F(1,2)
assert F(2*23*9**12,2**240)<F(1,10**58)
ERR=D//10**58+1
def A_values(x):
    terms=[I.rational(0) for _ in range(5)]
    for m in range(1,9):
        e=I.rational(1) if m==1 else exp_minus((m*m-1)*x)
        for j in range(5):
            terms[j]=terms[j]+((-1)**j*m**(2+2*j))*(
                2*m*m*x-(3+2*j))*e
    return [I(z.lo-ERR,z.hi+ERR) for z in terms]

class Dual:
    __slots__=("v","d")
    def __init__(self,v,d=0):self.v=asI(v);self.d=asI(d)
    def __add__(a,b):
        b=asD(b);return Dual(a.v+b.v,a.d+b.d)
    __radd__=__add__
    def __neg__(a):return Dual(-a.v,-a.d)
    def __sub__(a,b):return a+-asD(b)
    def __mul__(a,b):
        b=asD(b);return Dual(a.v*b.v,a.d*b.v+a.v*b.d)
    __rmul__=__mul__
    def __pow__(a,n):
        o=Dual(1)
        for _ in range(n):o=o*a
        return o
def asD(x):return x if isinstance(x,Dual) else Dual(x)

def H(x,derivative=False):
    aa=A_values(x)
    # A_j'(x)=A_j(x)+A_{j+1}(x)
    a=[Dual(aa[j],aa[j]+aa[j+1]) for j in range(4)]
    X=Dual(x,I.rational(1))
    a0,a1,a2,a3=a
    h=-(X**3)*(a3*a0**2-3*a1*a2*a0+2*a1**3)\
      -3*(X**2)*(a2*a0**2-a1**2*a0)-X*a1*a0**2
    return h.d if derivative else h.v

# Global analytic bound for x>=6:
# (3/2)^10 e^(-30)<1/2, e^3>20, and cubic stability margin.
assert F(3,2)**10/F(2**30)<F(1,2)
assert sum((F(3**j,factorial(j)) for j in range(9)),F(0))>20
assert F(6144*6831,64_000_000)<F(7,4)
print("PASS: analytic infinite-tail and polynomial stability")

# [pi,7/2] uses H(pi)=0 exactly from the theta modular equation;
# prove strict positivity of the derivative across 100 rational cells.
min_der=None
top=I.rational(7,2)
for i in range(100):
    lo=pi.lo+(top.lo-pi.lo)*i//100
    hi=pi.hi+(top.hi-pi.hi)*(i+1)//100
    cur=H(I(lo,hi),True)
    assert cur.lo>46*D,(i,cur.lo,cur.hi)
    min_der=cur.lo if min_der is None else min(min_der,cur.lo)
print("PASS: H' >46 on 100/100 compact cells; lowest bound =",min_der,"/",D)

# [7/2,6] uses direct H positivity across 400 cells.
min_h=None
end=I.rational(6)
for i in range(400):
    lo=top.lo+(end.lo-top.lo)*i//400
    hi=top.hi+(end.hi-top.hi)*(i+1)//400
    cur=H(I(lo,hi))
    assert cur.lo>26*D,(i,cur.lo,cur.hi)
    min_h=cur.lo if min_h is None else min(min_h,cur.lo)
print("PASS: H >26 on 400/400 compact cells; lowest bound =",min_h,"/",D)
print("PASS: global Xi-kernel curvature V'''(u)>0, u>0, subject to the explicitly stated modular evenness and elementary analytic tail lemmas")
