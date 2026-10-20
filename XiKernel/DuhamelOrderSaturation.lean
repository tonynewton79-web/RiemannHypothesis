import Mathlib

/-!
# Duhamel budget saturation: algebraic size-bias gates.

For the actual theta heat flow at Fourier frequency zero, positive
bivariate correlation weights imply that the fraction U_n/B_n
decreases strictly with Laguerre order n and tends to zero.
This module certifies the two-point reverse-covariance identity
and the exact Gaussian benchmark's rational consequences.
The all-n integral concentration proof remains paper mathematics.
No theorem here proves RH or infinite-dimensional heat positivity.
-/

namespace XiKernel

theorem two_point_reverse_covariance_identity
    (p q x y fx fy : ℝ) :
    (p*x*fx + q*y*fy)*(p+q) -
      (p*fx+q*fy)*(p*x+q*y)
        = p*q*(x-y)*(fx-fy) := by
  ring

theorem two_point_size_bias_strict
    (p q x y fx fy : ℝ)
    (hp : 0 < p) (hq : 0 < q)
    (hxy : x < y) (hfy : fy < fx) :
    (p*x*fx + q*y*fy)*(p+q) <
      (p*fx+q*fy)*(p*x+q*y) := by
  rw [← sub_lt_zero]
  rw [two_point_reverse_covariance_identity]
  have hn : x-y < 0 := sub_neg.mpr hxy
  have hf : 0 < fx-fy := sub_pos.mpr hfy
  have hpos : 0 < p*q := mul_pos hp hq
  exact mul_neg_of_neg_of_pos (mul_neg_of_pos_of_neg hpos hn) hf

/-- The divided source identity as a polynomial relation:
B = U + D, so 1-D/B=U/B (where B != 0).
In the genuine theta proof B>0 comes from W_s>0. -/
theorem duhamel_budget_fraction_identity
    (budget residual source : ℝ)
    (hb : budget ≠ 0)
    (h : budget = residual + source) :
    1-source/budget = residual/budget := by
  field_simp
  linarith

/-- An order-uniform fixed fractional slack is impossible
once the residual fraction falls below the margin. -/
theorem small_residual_forces_source_saturation
    (budget residual source delta : ℝ)
    (hb : 0 < budget)
    (hadd : source = budget - residual)
    (hsmall : residual < delta*budget) :
    (1-delta)*budget < source := by
  rw [hadd]
  nlinarith

theorem gaussian_budget_ratio_square_step (r : ℚ) :
    (r*r)/4 = (r/2)*(r/2) := by
  ring

theorem gaussian_budget_ratio_monotone
    (r : ℝ) (hr : 0 < r) : r/2 < r := by
  linarith

end XiKernel
