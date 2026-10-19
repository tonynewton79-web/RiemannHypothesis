"""Near-real zeros invisible to any fixed global Laguerre depth.

For N>=1 and m>=2, let d=1-1/m², A=16*N*m^4.
K(u)=exp(-u²/(2A))*(1+d*exp(-1/(2A))*cosh(u/A)).
F(z)=sqrt(2*pi*A)*exp(-A*z²/2)*(1+d*cos(z)).

For every n=1..N and every real x:
L_n[F](x) >= 2*pi*A*exp(-A*x*x) * 3*(1-d)²*A^n/(4*n!) >0.

Nonreal zeros occur at (2k+1)*pi ± i*acosh(1/d).
If m²-1>2/eps², their imaginary distance is less than eps.

Exact rational arithmetic only; independent examples supplement
the complete all-N mathematical inequality in the manuscript.
"""
from fractions import Fraction as Q
from math import factorial

for N,m in [(1,2),(3,4),(5,10),(10,150),(20,150),(40,1500)]:
    d=Q(m*m-1,m*m)
    A=Q(16*N*m**4)
    assert A==16*N/(1-d)**2
    assert A>=2*N
    for n in range(1,N+1):
        a=A**n/factorial(n)
        b=sum((A**(n-j)/factorial(n-j)/factorial(2*j)
               for j in range(1,n+1)),Q())
        c=sum((4**j*A**(n-j)/factorial(n-j)/factorial(2*j)
               for j in range(1,n+1)),Q())
        assert a>0 and b>=0 and c>=0
        assert b/a<=Q(2*N)/A
        assert 8*d*b<=a*(1-d)**2
        assert a*(1-d)**2-2*d*b>=Q(3,4)*a*(1-d)**2
    print(f"PASS N={N}, m={m}, all n<=N, exact global coefficient gate")

for eps,m in [(Q(1,10),20),(Q(1,100),200),(Q(1,1000),1500)]:
    # cosh(eps) >= 1+eps²/2 strictly when eps>0.
    # cosh(y)=1+1/(m²-1), so y<eps.
    assert Q(1,m*m-1)<eps*eps/2
    print(f"PASS strict nonreal-zero height < {eps} with m={m}")

print("PASS: rational near-real finite-depth examples; this does not prove RH.")
