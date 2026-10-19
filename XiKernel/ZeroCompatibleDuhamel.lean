import Mathlib

/-!
# Zero-compatible Duhamel source barrier for the Laguerre heat hierarchy

For U_n(s,x)=L_(n,t0-s)(x) the exact PDE is
 ∂s U_n = 1/2 ∂xx U_n - (n+1)(2n+1) U_(n+1).
The Duhamel identity gives
 U_n(s)=P_s U_n(0) - k_n ∫_0^s P_(s-r) U_(n+1)(r) dr.

This integral comparison needs no division by U_n and can
hold even when U_n vanishes at a multiple zero.
For the exact backward-heat polynomial H_t(z)=z²-2t
the n=1 inequality is saturated at (t,x)=(0,0):
 P_s U1(0,x)=2*(x²+s)+4*t0, 6∫_0^s P_(s-r) U2 dr=6s.
This module proves the rational polynomial identities.
It DOES NOT formalize the parabolic semigroup or RH.
-/
namespace XiKernel

theorem quadratic_duhamel_identity (t0 s x : ℝ) :
    (2*(x^2+s)+4*t0) - 6*s =
      2*x^2+4*(t0-s) := by ring

theorem quadratic_duhamel_nonnegative
    (t0 s x : ℝ) (h : s ≤ t0) :
    6*s ≤ 2*(x^2+s)+4*t0 := by
  nlinarith [sq_nonneg x]

theorem quadratic_duhamel_saturated (t0 : ℝ) :
    (2*((0:ℝ)^2+t0)+4*t0) - 6*t0 = 0 := by ring

theorem quadratic_endpoint_pointwise_impossible :
    ¬ ∃ c : ℝ, (6:ℝ)*1 ≤ c*0 := by
  norm_num

theorem ratio_requires_strict_positivity
    (denom source : ℝ)
    (hd : 0 < denom) :
    source = (source/denom)*denom := by
  field_simp

end XiKernel
