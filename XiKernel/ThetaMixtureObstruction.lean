import Mathlib

/-!
# Elementary square-grid gates for a theta Gaussian-mixture obstruction.

A super-Gaussian positive correlation cannot be a nonzero positive
mixture of centered Gaussian kernels: any positive mixing measure
has some bounded-frequency mass and hence a Gaussian lower bound.

The source theta-decay and the positive-measure argument are analytic
paper proofs. These Lean lemmas check only the polynomial and order
gates, not an end-to-end formal theorem about theta-series densities.
-/

namespace XiKernel

theorem two_frequency_square_identity (w b : ℝ) :
    ((w+b)/2)^2 + ((w-b)/2)^2 =
    (w^2+b^2)/2 := by
  ring

theorem positive_gaussian_mixture_order
    (weight retention : ℝ)
    (hweight : 0 ≤ weight)
    (hretention : 0 ≤ retention)
    (hle : retention ≤ 1) :
    0 ≤ weight*retention ∧ weight*retention ≤ weight := by
  constructor
  · exact mul_nonneg hweight hretention
  · nlinarith [mul_nonneg hweight (by linarith : 0 ≤ 1-retention)]

theorem impossible_upper_lower_at_witness
    (f lower upper : ℝ)
    (hl : lower ≤ f)
    (hu : f ≤ upper)
    (hbad : upper < lower) : False := by
  linarith

theorem one_rational_exponential_witness :
    (1:ℚ) + 36 + 36^2/2 > 200 := by
  norm_num

end XiKernel
