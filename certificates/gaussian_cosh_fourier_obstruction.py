"""Exact arithmetic regression for the Gaussian-cosh Fourier counterexample.

K(u)=exp(-u*u/2)*(1+cosh(u)/2)
V=-log(K)
V''=(cosh(u)^2+2*cosh(u)+3)/(cosh(u)+2)^2 >= 2/3
V'''=2*(cosh(u)-1)*sinh(u)/(cosh(u)+2)^3 >0 (u>0)
F(z)=sqrt(2*pi)*exp(-z*z/2)*(1+d*cos(z))
d=exp(1/2)/2 in (3/4,1).
F has nonreal zeros and L1[F](pi)=2*pi*exp(-pi*pi)*(1-d)*(1-2*d)<0.

Polynomial identities are proved in Lean, analytic differentiation by
ordinary calculus, Gaussian integration exactly. The interval enclosure
for d uses rational Taylor terms and a rigorous positive-term tail.
"""
from fractions import Fraction as Q
from math import factorial

x=Q(1,2)
terms=[x**k/factorial(k) for k in range(30)]
low=sum(terms)
# For k>=30, term_(k+1)/term_k <= (1/2)/31 < 1/62.
tail=terms[-1]*(x/30)/(1-Q(1,62))
upper=low+tail
assert low>Q(3,2)
assert upper<2
dlow, dhigh=low/2, upper/2
assert Q(3,4)<dlow and dhigh<1
assert (1-dlow)>0 and (1-2*dlow)<0
assert (1-dhigh)>0 and (1-2*dhigh)<0

# Algebraic checks for the exact identity 3*numer(V'') -
# 2*denom(V'')=(cosh(u)-1)^2 over c=cosh(u)>=1.
for C in [Q(1),Q(7,6),Q(3,2),Q(2),Q(9,2),Q(42)]:
    lhs=3*(C*C+2*C+3)-2*(C+2)**2
    assert lhs==(C-1)**2
    assert Q(2,3)<=(C*C+2*C+3)/(C+2)**2

print("PASS rational exp(1/2) bounds, 3/4 < d < 1.")
print("PASS strict negative Fourier Laguerre factor at x=pi.")
print("PASS polynomial strong-convexity identities.")
print("Important: nonreal Fourier zeros disprove radial-curvature sufficiency, NOT RH.")
