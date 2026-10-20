import Mathlib

/-!
# Pole-free Laguerre ratio: exact algebraic inequality

For an LP entire G with simple real zeros rho, at real x not a zero,
G(x+iy)G(x-iy)=G(x)^2 prod_rho (1+y²/(x-rho)²).
Fix a nearby zero a, set b=(x-a)^(-2), and let E_j be the
elementary symmetric functions of the remaining inverse-square
zero distances. Then
  L_n=G(x)^2*(b*E_(n-1)+E_n),
  L_(n+1)=G(x)^2*(b*E_n+E_(n+1)).
The elementary-symmetric estimate
  n*E_n <= S*E_(n-1), (n+1)*E_(n+1) <= S*E_n,
with S=sum_(rho!=a)(x-rho)^(-2), proves an inequality
independent of b, which survives x=a without singularity.

This module formalizes the purely real-algebraic comparison.
It does NOT formalize the infinite Hadamard product or prove
zero-reality for the actual Riemann theta heat flow.
-/

namespace XiKernel

theorem poleFreeLaguerreGate
    (n b S Eprev Ecur Enext : ℝ)
    (hn : 1 ≤ n) (hb : 0 ≤ b)
    (hEnext : 0 ≤ Enext)
    (hfirst : n * Ecur ≤ S * Eprev)
    (hsecond : (n+1) * Enext ≤ S * Ecur) :
    n * (b*Ecur + Enext) ≤ S*(b*Eprev + Ecur) := by
  have ha : b*(n*Ecur) ≤ b*(S*Eprev) :=
    mul_le_mul_of_nonneg_left hfirst hb
  have hb' : n*Enext ≤ (n+1)*Enext := by
    nlinarith
  nlinarith [ha, hb', hsecond]

theorem poleFreeSourceComparison
    (n b S Eprev Ecur Enext : ℝ)
    (hn : 1 ≤ n) (hb : 0 ≤ b)
    (hEnext : 0 ≤ Enext)
    (hfirst : n * Ecur ≤ S * Eprev)
    (hsecond : (n+1) * Enext ≤ S * Ecur) :
    n * ((n+1)*(2*n+1)*(b*Ecur+Enext)) ≤
      ((n+1)*(2*n+1)*S)*(b*Eprev+Ecur) := by
  have h := poleFreeLaguerreGate n b S Eprev Ecur Enext hn hb hEnext hfirst hsecond
  have hm : 0 ≤ (n+1)*(2*n+1) := by positivity
  have hs := mul_le_mul_of_nonneg_left h hm
  nlinarith [hs]

theorem symmetricPolynomialGap
    (S Eprev Ecur Enext : ℝ)
    (h1 : 2*Ecur ≤ S*Eprev)
    (h2 : 3*Enext ≤ S*Ecur)
    (hb : 0 ≤ Ecur) :
    2*Enext ≤ S*Ecur := by
  nlinarith

end XiKernel
