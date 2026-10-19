"""Exact (standard-library) algebraic gates for Gaussian parity repair.

Let P_M(u)=sum_{m<=M} phi_m(|u|), G_sigma Gaussian density, and
K_(M,sigma)=G_sigma*P_M.  K is positive, even and smooth, with all
odd endpoint derivatives zero.

F_(M,sigma)(z)=exp(-sigma²*z²/2)*F_M(z); the multiplier has no zeros.
For real x:
 L1[F_(M,sigma)](x)=exp(-sigma²*x²)
   *(L1[F_M](x)+sigma²*F_M(x)^2).
The high-frequency first-order coefficient changes from
-8*D_M²*x^-6 to
  4*sigma²*D_M²*x^-4+O(x^-6).

For every fixed n>=1, the asymptotic normalized coefficient is
  4*D_M²*sigma^(2n)/(n!*x^4)>0.
These algebraic checks do NOT certify the analytic Fourier
integrals or integration-by-parts remainder.
"""
from fractions import Fraction as Q
from math import factorial

def sign_laguerre(f,fp,fpp,g,h,s):
    gp=-h*g
    gpp=(h*h-s)*g
    lhs=(gp*f+g*fp)**2-(g*f)*(gpp*f+2*gp*fp+g*fpp)
    rhs=g*g*(fp*fp-f*fpp+s*f*f)
    return lhs,rhs

for f in [Q(-2,3),Q(0),Q(5,2)]:
 for fp in [Q(-4,7),Q(2,5)]:
  for fpp in [Q(-1,3),Q(3,5)]:
   for h in [Q(2,7),Q(-1,4)]:
    for s in [Q(0),Q(1,8),Q(2,9)]:
     lhs,rhs=sign_laguerre(f,fp,fpp,Q(17,23),h,s)
     assert lhs==rhs

for D in [Q(1,17),Q(1,1),Q(5,3)]:
 for sigma2 in [Q(1,16),Q(1,4),Q(1)]:
  for x in [2,3,5,10,20,100]:
   lhs=(4*D)**2-(-2*D)*(-12*D)+sigma2*(-2*D)**2*x*x
   rhs=4*D*D*(sigma2*x*x-2)
   assert lhs==rhs
   assert (lhs>0)==(sigma2*x*x>2)
  for n in range(1,81):
   assert 4*D*D*sigma2**n/factorial(n)>0

# The uniform error relies on 1-e^(-a) <= a for a>=0.
# Its algebraic coefficient E_M+sigma²(D_M+||f_M''||_1)
# is monotone in all nonnegative inputs.
for E in [Q(1,1000),Q(1,10)]:
 for D in [Q(1,100),Q(2,3)]:
  for J in [Q(0),Q(3,2)]:
   sigma2=E/(1+D+J)
   assert E+sigma2*(D+J) < 2*E

print("PASS exact L1 Gaussian multiplier product formula")
print("PASS exact high-frequency sign reversal gates")
print("PASS 80 arbitrary fixed-order asymptotic leading coefficient signs")
print("PASS uniform approximation error balancing algebra")
print("RH still unproved; analytic Fourier and tail theorems are not Lean-complete")
