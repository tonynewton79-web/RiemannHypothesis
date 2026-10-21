import Mathlib

/-!
# Intrinsic heat perturbation: algebraic sublemmas pending Lean CI

This module formalizes only elementary algebraic implications. It does NOT
formalize the infinite canonical product, theta integrals, Rouché's theorem,
the analytic heat equation, high-zero density, or the Riemann hypothesis.
-/

namespace XiKernel

def intrinsicHeatJetK (u v : ℝ) : ℝ := u ^ 2 / 4 - v / 3

theorem intrinsic_heat_jet_gauge (u v drift : ℝ) :
    intrinsicHeatJetK (u + 2 * drift)
      (v + 3 * drift * u + 3 * drift ^ 2) = intrinsicHeatJetK u v := by
  unfold intrinsicHeatJetK
  ring

theorem instantaneous_heat_scale_square (b k : ℝ) :
    b ^ 2 + 6 * b * k + 9 * k ^ 2 = (b + 3 * k) ^ 2 := by
  ring

theorem strict_relative_heat_margin (lower perturb : ℝ)
    (hlo : 0 < lower) (hpert : perturb < lower) :
    0 < lower - perturb := by
  linarith

/-- Scalar core of the inverse-gap lower bound. Here q represents sqrt(K). -/
theorem intrinsic_heat_sensitivity_floor
    (b q M : ℝ) (hb : 0 ≤ b) (hq : 0 ≤ q)
    (hconst : 4 * b * q ≤ M)
    (hlinear : 3 * q ^ 2 - b ^ 2 ≤ M) :
    2 * q ^ 2 ≤ M := by
  by_cases hsmall : b ≤ q / 2
  · have hprod : 0 ≤ (q / 2 - b) * (q / 2 + b) :=
      mul_nonneg (by linarith) (by linarith)
    nlinarith
  · have hprod : 0 ≤ (b - q / 2) * q :=
      mul_nonneg (by linarith) hq
    nlinarith

#print axioms intrinsic_heat_jet_gauge
#print axioms instantaneous_heat_scale_square
#print axioms intrinsic_heat_sensitivity_floor

end XiKernel
