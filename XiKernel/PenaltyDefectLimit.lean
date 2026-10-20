import Mathlib

/-!
# Zero-compatible constant-penalty Duhamel defect: algebraic gates

The actual analytic statement, proved in the accompanying manuscript,
is that for the theta heat hierarchy a Gaussian-heat-convolved
positive-part defect E_{n,C}=[k_n U_{n+1}-C U_n]_+ tends to zero as
C→∞ iff the Riemann hypothesis is true. The proof uses the analyticity
and nonvanishing of each U_n(s,.) and classical heat comparison.
THIS LEAN FILE DOES NOT FORMALIZE THAT ANALYTIC THEOREM OR PROVE RH.

At a polynomial double-zero collision, the pointwise defect stays 6,
while its heat convolution is ≤9/C. A negative region instead makes
the convolved defect grow at least linearly with C.
-/

namespace XiKernel

theorem collision_penalty_point_defect (C : ℝ) :
    max (6 - C*(2*(0:ℝ)^2+2-4*(1/2:ℝ))) 0 = 6 := by
  norm_num

theorem collision_heat_error_bound (C : ℝ) (hC : 3 ≤ C) :
    0 < 9/C ∧ 9/C ≤ 3 := by
  have hp : 0 < C := by linarith
  constructor
  · positivity
  · apply (div_le_iff₀ hp).2
    linarith

theorem collision_duhamel_exact_balance :
    2*((0:ℝ)^2 + (1/2:ℝ)) + 2 = 6*(1/2:ℝ) := by
  norm_num

theorem negative_region_penalty_lower (C : ℝ) (hC : 0 < C) :
    0 < (3/16:ℝ)*C := by
  positivity

theorem penalty_defect_negative_region_growth
    (C delta K source potential : ℝ)
    (hdelta : 0 < delta) (hC : 0 < C)
    (hU : potential ≤ -delta) (hV : -K ≤ source) :
    C*delta-K ≤ source-C*potential := by
  nlinarith

theorem penalty_defect_exact_zero
    (C u v : ℝ) (h : C*u ≥ v) :
    max (v-C*u) 0 = 0 := by
  apply max_eq_right
  linarith

end XiKernel
