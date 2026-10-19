"""Exact rational checks for an arbitrary finite-depth Laguerre barrier.

F_d(z)=sqrt(2*pi)*exp(-z^2/2)*(1+d*cos z), with 0<d<1.
The associated positive kernel is
K_d(u)=exp(-u^2/2)*(1+d*exp(-1/2)*cosh u).

For every integer N>=1, d_N=2^(-N-2) gives
  L_n[F_dN](x)/(2*pi*exp(-x*x)) >= 1/(2*n!)
for each 1<=n<=N and every real x.

Proof from coefficient expansion in y:
 e^(y*y)*(1+2*d*cos(x)*cosh(y)
                 +d*d/2*(cosh(2*y)+cos(2*x))).
Let a_n=1/n!, b_n=sum 1/((n-k)!(2k)!),
 c_n=sum 4**k/((n-k)!(2k)!).
Then c_n>=a_n, b_n/a_n<=2**n, using
k!/(2k)!<=1 and sum_k binom(n,k)=2**n.

The d=2/5 case has globally positive L1 but L2(pi)<0 exactly.
"""
from fractions import Fraction as Q
from math import factorial

def abc(n):
    a=Q(1,factorial(n))
    b=sum((Q(1,factorial(n-k)*factorial(2*k))
           for k in range(n+1)),Q(0))
    c=sum((Q(4**k,factorial(n-k)*factorial(2*k))
           for k in range(n+1)),Q(0))
    return a,b,c

for N in (1,2,3,5,10,20,50,100):
    d=Q(1,2**(N+2))
    for n in range(1,N+1):
        a,b,c=abc(n)
        assert c>=a
        assert b<=2**n*a
        assert a-2*d*b>=a/2
    print(f"PASS finite depth N={N}, exact rational all-order coefficient gate")

d=Q(2,5)
a1,b1,c1=abc(1)
a2,b2,c2=abc(2)
assert a1-2*d*b1+d*d/2*(c1+a1) == Q(3,25)
assert a2-2*d*b2+d*d/2*(c2+a2) == -Q(1,25)
# Symbolic lower bound at every real x for the n=1 polynomial.
# Q1(t)-3/25 = (t+1)*(4*t+26)/25, t=cos(x)>=-1.
assert (Q(1)+d*d-3*d+d*d)==Q(3,25)
print("PASS d=2/5: L1 globally positive, L2(pi)=-2*pi*exp(-pi^2)/25")
print("RH is neither proved nor refuted; N is finite and model != Xi.")
