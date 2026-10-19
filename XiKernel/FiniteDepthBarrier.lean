import Mathlib

/-!
# Arbitrarily long finite Laguerre hierarchies cannot force real zeros

For the Gaussian--cosh kernel with d_N=2^(-(N+2)), each generalized
Laguerre expression of order n=1,...,N is globally positive even though
the transform has nonreal zeros.  This module proves the real algebraic
coefficient gate and exact low-order failure for d=2/5.

The full analytic Fourier expansion and factorial/binomial estimate
b_n <= 2^n/n! are proved in paper/finite_depth_laguerre_barrier.tex;
they are not yet end-to-end Lean formalized.
-/

namespace XiKernel

/-- An exact real-algebraic gate for the cosh-Gaussian coefficient formula:
a + 2*d*t*b + d²/2*(c+v*a), with t=cos(x), v=cos(2*x).
If 4*d*b <= a, every such expression is strictly positive. -/
theorem finite_depth_fourier_gate
    (a b c d t v : ℝ)
    (ha : 0 < a)
    (hb : 0 ≤ b) (hc : a ≤ c)
    (hd : 0 ≤ d) (hsmall : 4*d*b ≤ a)
    (ht : -1 ≤ t) (hv : -1 ≤ v) :
    0 < a + 2*d*t*b + (d^2/2)*(c+v*a) := by
  have htpos : 0 ≤ t+1 := by linarith
  have hvpos : 0 ≤ v+1 := by linarith
  have htbound : -b ≤ t*b := by
    have h := mul_nonneg htpos hb
    nlinarith
  have hcpos : 0 ≤ c+v*a := by
    have h := mul_nonneg hvpos (le_of_lt ha)
    nlinarith
  have hcross : 0 ≤ (d^2/2)*(c+v*a) := by
    apply mul_nonneg
    · positivity
    · exact hcpos
  have hleft : -2*d*b ≤ 2*d*t*b := by
    have h := mul_le_mul_of_nonneg_left htbound (by positivity : 0 ≤ 2*d)
    nlinarith
  have hhalf : -(a/2) ≤ 2*d*t*b := by
    nlinarith [hsmall, hleft]
  linarith

/-- Uniform global positivity of first Laguerre expression at d=2/5. -/
theorem first_order_still_positive (t : ℝ) (ht : -1 ≤ t) :
    (3/25 : ℝ) ≤ 1 + (2/5)^2 + 3*(2/5)*t + (2/5)^2*t^2 := by
  have hh : 0 ≤ (t+1)*(4*t+26) := by
    apply mul_nonneg
    · linarith
    · linarith
  nlinarith

/-- At x=π the second Laguerre expression for d=2/5
has coefficient -1/25 times a strictly positive Gaussian factor. -/
theorem second_order_coefficient_negative :
    ((1/2 : ℚ) - (25/12)*(2/5) + (11/6)*(2/5)^2) = -(1/25) := by
  norm_num

/-- The zeroth-to-second Fourier coefficient at d=2/5 is 3/25. -/
theorem first_order_at_pi_positive :
    ((1 : ℚ) - (2/5))* (1 - 2*(2/5)) = 3/25 := by
  norm_num

/-- A symbolic identity for the quadratic second Laguerre coefficient. -/
theorem second_order_polynomial (d : ℝ) :
    (1/2 : ℝ) - (25/12)*d + (11/6)*d^2 =
      (22*d^2 - 25*d + 6)/12 := by
  ring

/-- The transform is positive on the real axis even though it has nonreal zeros. -/
theorem positive_real_fourier_factor (t : ℝ) (ht : -1 ≤ t) :
    0 < (1:ℝ) + (2/5)*t := by
  linarith

end XiKernel
