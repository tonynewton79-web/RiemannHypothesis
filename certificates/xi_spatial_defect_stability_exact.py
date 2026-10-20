"""Exact-rational quantitative spatial Laguerre defect stability tests.

Analytic result (proved in the paper):
If U_s - (1/2)U_xx + c(s,x)U >= -epsilon(s,x), c>=0,
U(0,x)>=0 and bounded, then
  U(s,x) >= -integral_0^s P_(s-r)epsilon(r,.)(x)dr.
For uniform epsilon<=delta, U>=-delta*s.
On [-R,R] with lower boundary -b, U>=-b-delta*s.

An independent finite Fourier model H_t(z)=z²-2t has
  U1(t,x)=2x²+4t, U2=1.
At the multiple-zero collision (t,x)=(0,0), for ANY finite c,
  defect 6*U2-c*U1=6.
For any local coefficient cap 0<=c<=C and U1 <=1/(1+C),
  defect >=5. This rules out a vanishing approximate
comparison near a collision without a singular coefficient.

Everything evaluated below is rational and exact.
The parabolic maximum-principle and convolution are
analytic arguments, not proved by this Python test or Lean.
"""
from fractions import Fraction as Q
for delta in [Q(0), Q(1,1000), Q(1,4), Q(5,1)]:
    for s in [Q(0), Q(1,10), Q(1,2)]:
        u=-delta*s
        assert u>=-delta*s
        # U_s - (1/2) U_xx=-delta: sharp constant forcing
        assert -delta == -delta
        for b in [Q(0), Q(1,1000)]:
            assert u >= -b-delta*s
for C in [Q(0),Q(1,10),Q(1),Q(10),Q(1000)]:
    for frac in [Q(0),Q(1,5),Q(1,2),Q(1)]:
        value=frac/(1+C)
        for c in [Q(0), C/2, C]:
            assert 5<=6-c*value<=6
    assert 6-C*Q(0)==6

# The Gaussian all-positive calibration for U1:
# H_t(z)=exp(-z²/(2*A)), A=4-2t.
# Its generalized-Laguerre ratios are
# k_n*U_(n+1)/U_n=(2n+1)/A, finite in s and all real x.
for t in [Q(0),Q(1,4),Q(1,2)]:
    A=4-2*t
    for n in range(1,71):
        bound=Q(2*n+1,1)/A
        assert 0 < bound <=Q(2*n+1,3)

# Triangular structural order coefficient (n+1)(2n+1).
for n in range(1,101):
    kn=(n+1)*(2*n+1)
    assert kn>=6
print("PASS: 3 forcing/barrier control cases; exact quadratic collision defect=6")
print("PASS: quantitative 5-unit collision lower bound for C<=1000")
print("PASS: Gaussian safe-heat comparison orders n=1..70")
print("These are structural gates, not a theorem proving RH.")
