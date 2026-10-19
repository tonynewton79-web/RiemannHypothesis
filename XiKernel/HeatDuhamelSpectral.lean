import Mathlib

/-!
# An exact Duhamel source-budget obstruction.

The coupled theta Laguerre PDE gives
  U_n(s) = P_s U_n(0) - a_n * ∫₀ˢ P_(s-r) U_(n+1)(r) dr.
Hence the proposed source inequality is exactly positivity of U_n.

We prove only elementary algebraic gates, not heat-semigroup
integrals or the genuine Riemann-Hilbert zero criterion.

The toy even positive measure δ₀+3/4(δ₁+δ₋₁) has
H_s(x)=1+(3/2)e^(-s) cos x, where s is backward heat time.
It starts with only real zeros but at s=log 2
U₁(s,π)=-3/16; at s=log(3/2) a double real zero has
U₁=0, U₂=1/4. No finite coefficient repairs 6U₂≤c U₁.
-/

namespace XiKernel

theorem spectral_deficit_identity (weight retention : ℝ) :
    weight - weight * (1-retention) = weight * retention := by
  ring

theorem spectral_source_weight_bounds
    (weight retention : ℝ) (hw : 0 ≤ weight)
    (hr0 : 0 ≤ retention) (hr1 : retention ≤ 1) :
    0 ≤ weight * (1-retention) ∧
    weight * (1-retention) ≤ weight := by
  constructor
  · exact mul_nonneg hw (by linarith)
  · nlinarith [mul_nonneg hw hr0]

theorem atomic_laguerre_one (d c : ℝ) :
    d^2 * (1-c^2) + (1+d*c)*d*c = d*(d+c) := by
  ring

theorem atomic_laguerre_two (d c : ℝ) :
    d*c/12 + d^2/3 = d*(4*d+c)/12 := by
  ring

theorem atomic_heat_endpoint_negative :
    (3/4 : ℚ) * (3/4-1) = -(3/16) := by
  norm_num

theorem atomic_heat_collision :
    ((1:ℚ)*(1-1) = 0) ∧
    ((1:ℚ)*(4*1-1)/12 = 1/4) := by
  norm_num

theorem spatial_coefficient_cannot_repair_collision
    (c : ℝ) : ¬ (6*(1/4 : ℝ) ≤ c*0) := by
  norm_num

/-- At backward heat time log(4), the toy model's source exceeds
its semigroup budget by the exact positive amount 15/64. -/
theorem atomic_source_overshoot :
    (111/64 : ℚ) - 3/2 = 15/64 := by
  norm_num

theorem atomic_integrated_comparison_failure :
    ¬ (111/64 : ℝ) ≤ 3/2 := by
  norm_num

/-- A manifestly nonnegative bivariate source integrand does not
imply that its Fourier cosine transform is nonnegative. -/
theorem positive_weights_negative_cosine_example :
    (0 : ℚ) ≤ 3/8 ∧ (0 : ℚ) ≤ 9/64 ∧
    (9/64 : ℚ) - 3/8 = -(15/64) := by
  norm_num

/-- A rational witness already within the half-unit backward time slab:
at s = log(8/5) the attenuation is 5/8 and the cosine
coefficient becomes (3/2)*(5/8)=15/16. -/
theorem atomic_within_half_time_negative :
    ((15/16 : ℚ)*(15/16-1) = -(15/256)) := by
  norm_num

/-- The integrated source overshoots the heat budget by 15/256
at that same backward time and x=pi. -/
theorem within_slab_source_deficit (budget source : ℝ)
    (h : source = budget + (15/256 : ℝ)) :
    ¬ source ≤ budget := by
  intro hbad
  rw [h] at hbad
  linarith

end XiKernel
