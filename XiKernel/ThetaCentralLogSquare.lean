import Mathlib

/-!
# Central theta Laguerre comparison: sharp logarithmic-square necessary scale.

The analytic theorem in paper/theta_central_logsquare_asymptotic.tex
proves that for 0≤t≤1/2 the positive theta-convolution moments satisfy
    M_(2n+2)(t) / (M_(2n)(t) * (log n)^2) -> 1/4
uniformly in heat time, hence
    k_n U_(n+1)(s,0) / U_n(s,0) ~ (log n)^2 / 8.
The theorem uses genuine theta double-exponential tails and
concentration under high even moments. This file formalizes only
the elementary algebraic order-coefficient comparison gates.
No infinite convolution, limit, or RH theorem is formalized here.
-/

namespace XiKernel

/-- A nonnegative spatial source inequality implies a lower
bound on its coefficient at a point where U_n is positive. -/
theorem central_comparison_coefficient_lower
    (u v c k : ℝ)
    (hu : 0 < u) (hk : 0 ≤ k)
    (hsource : k*v ≤ c*u) :
    k*v/u ≤ c := by
  exact (div_le_iff₀ hu).2 hsource

/-- If the central source ratio is at least b, so is any
coefficient satisfying the pointwise comparison. -/
theorem central_logsquare_lower_gate
    (u v c k b : ℝ)
    (hu : 0 < u) (hk : 0 ≤ k)
    (hratio : b*u ≤ k*v)
    (hsource : k*v ≤ c*u) :
    b ≤ c := by
  have h := le_trans hratio hsource
  exact (mul_le_mul_right hu).mp h

/-- The moment-to-source algebraic factor is exactly one half. -/
theorem central_moment_ratio_half
    (m mn : ℝ) (hm : 0 < m) :
    ((mn / (4*m)) * (2:ℝ)) = mn/(2*m) := by
  field_simp [ne_of_gt hm]
  ring

/-- The candidate order and height scales must both be accommodated. -/
theorem logarithmic_order_and_height_gate
    (order height c : ℝ)
    (ho : 0 ≤ order) (hh : 0 ≤ height)
    (horder : order ≤ c) (hheight : height ≤ c) :
    max order height ≤ c := max_le horder hheight

end XiKernel
