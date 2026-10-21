import Mathlib

/-!
# Explicit Polymath15 constant audit: algebraic verification components

This file proves elementary rational and real-arithmetic sublemmas only.
It does NOT formalize the theta Fourier integral, the Polymath15 saddle
approximation, complex logarithms, an explicit global height cutoff, the
argument principle, or the Riemann hypothesis.
-/
namespace XiKernel

/-- Rational integral comparison used for the n>=2 Dirichlet tail. -/
theorem polymath_tail_integral_comparison :
    (1 : ℚ) / 128 + 1 / 384 = 1 / 96 := by
  norm_num

/-- Exponent retains positive rational slack at t<=1/2.
    P represents the product t*L. -/
theorem polymath_exponent_slack (t P : ℝ)
    (ht0 : 0 ≤ t) (ht : t ≤ (1/2 : ℝ)) :
    7 + (P - 54) / 8 < (1/2 : ℝ) + P / 8 - t / 4 - t / 40000 := by
  nlinarith

/-- Rationalized coefficient bound for the tail estimate. -/
theorem polymath_tail_coefficient : (64 : ℚ) / 39 < 2 := by
  norm_num

/-- Scalar normalizer budget arithmetic. -/
theorem polymath_normalizer_budget (L : ℝ) (hL : 0 ≤ L) :
    12 + (L / 2 + 1) / 2 ≤ 13 + L := by
  linarith

/-- Existing phase-box boundary gap, checked again. -/
theorem polymath_phase_box_margin :
    (2 : ℚ) * (1 / 4 - (1 / 4)^3 / 6) - 1 / 5 = 283 / 960 := by
  norm_num

#print axioms polymath_tail_integral_comparison
#print axioms polymath_exponent_slack
#print axioms polymath_tail_coefficient
#print axioms polymath_normalizer_budget
#print axioms polymath_phase_box_margin
end XiKernel
