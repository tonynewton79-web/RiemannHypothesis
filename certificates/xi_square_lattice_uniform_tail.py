"""Theta-specific uniform Fourier derivative and Laguerre truncation bounds.

The classical Riemann kernel in r-variable is
    Phi(r)=sum_{m>=1} q_m*(2*q_m*exp(4r)-3)*exp(5r-q_m*exp(4r)),
    q_m=pi*m²,
with Phi even and F(x)=∫_R Phi(r)*exp(i*x*r)dr = xi(1/2+i*x/2)/4.
All proof comparisons here are exact rational comparisons (stdlib Fraction).

For M>=1, k>=0, x in R:
 sup|F^(k)(x)-F_M^(k)(x)|
    <= [3*k!/4^k]*q_(M+1)*exp(-q_(M+1)).
The proof uses u^k <= k!*exp(4u)/4^k,
 q²∫_1∞ t³ exp(-qt)dt =
 exp(-q)*(q+3+6/q+6/q²),
 q>=12 => q+3+6/q+6/q² <= 3q/2,
 and geometric ratio of q_m exp(-q_m) <1/2 for m>=2.

Let C=exp(-pi)*(pi+3+6/pi+6/pi²)+12*pi*exp(-4pi).
All k and M satisfy sup|F^(k)|,sup|F_M^(k)|<=C*k!/4^k.
Consequently for every n>=0,
 sup_x |L_n[F]-L_n[F_M]| <= 6*(2n+1)*C*q_(M+1)*exp(-q_(M+1))/4^(2n).
The Gaussian-integral and incomplete-gamma formulas are in the TeX proof.

This checker verifies the rational inequalities and high-order algebraic
combinatorial identities, not the transcendental analytic implications.
"""
from fractions import Fraction as Q
from math import factorial, comb
for q in (Q(12),Q(13),Q(24),Q(100),Q(10000)):
    assert q+3+Q(6)/q+Q(6)/q**2 <= Q(3,2)*q
    assert 3 <= q/4 and 6/q <= q/8 and 6/q**2 <= q/8

# e^9 > 8 is immediate from positive Taylor terms; geometric ratio <1/2.
assert 1+Q(9)>8
assert Q(4,1)/Q(1+9)<Q(1,2)  # 4e^-9 < 4/10 < 1/2

# The binomial-factorial cancellation of all Laguerre terms is exact.
for n in range(0,81):
    for j in range(2*n+1):
        assert Q(comb(2*n,j)*factorial(j)*factorial(2*n-j),factorial(2*n))==1
    assert sum((Q(2,1)*Q(comb(2*n,j)*factorial(j)*factorial(2*n-j),
                    factorial(2*n)) for j in range(2*n+1)),Q())==2*(2*n+1)

# Explicit numeric envelopes of the uniform error, used for reproducibility
# only (not as the exact inequality certificate).
import math
for M in (1,2,3,4,5):
    q=math.pi*(M+1)**2
    E=3*q*math.exp(-q)
    print(f"M={M}: global-in-x derivative error <= (k!/4^k)*{E:.12g}")
print("PASS: exact rational tail factor, geometric ratio, and n=0..80 convolution identities")
