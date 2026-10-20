import Mathlib

/-!
# Zero-density obstruction to a uniform single-anchor theta contour step.

For any fixed backward heat time sigma>0, positivity gives a
strict lower bound B0(sigma)>0 on the *optimal* Jensen
contour-error allowance at every selected high theta zero.
Meanwhile the actual contour minimum tends to zero along
shrinking adjacent gaps of H_(1/2).

The large-zero density theorem and analytic theta integral
are proved in the manuscript from established literature,
NOT kernel-formalized here. We check the finite comparison.
-/

namespace XiKernel

theorem no_uniform_theta_single_anchor
    (contourMin jensenBound baseDefect gradientBound radius : ℝ)
    (hcontour : contourMin ≤ gradientBound*radius)
    (hradius : gradientBound*radius < baseDefect)
    (hjensen : baseDefect ≤ jensenBound) :
    ¬ jensenBound < contourMin := by
  linarith

theorem shrinking_radius_model (n : ℕ)
    (hn : 21 ≤ n) :
    (2 : ℝ) / (n : ℝ) < 1/10 := by
  have hnReal : (21 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
  have hpos : 0 < (n : ℝ) := by linarith
  apply (div_lt_iff₀ hpos).2
  nlinarith

end XiKernel
