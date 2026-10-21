import Mathlib

/-!
# Finite-region zero census: arithmetic and order fragments

Theorems in this file concern natural-number counts, exact rational
margins from two finite polynomial controls, and algebra of a quadratic
backward-heat countermodel.

It does NOT formalize the complex argument principle, certified theta
values, the Polymath15 estimate, Rouche's theorem, Hurwitz's theorem,
or the Riemann hypothesis. GitHub CI compilation must be checked.
-/
namespace XiKernel

theorem all_zeros_accounted_for
    (total realZeros signChanges : ℕ)
    (hsc : signChanges ≤ realZeros)
    (hreal : realZeros ≤ total)
    (heq : total = signChanges) : realZeros = total := by
  omega

theorem all_real_quartic_mesh_margin :
    (0 : ℚ) < 2225207425 / 268435456 := by
  norm_num

theorem mixed_quartic_mesh_margin :
    (0 : ℚ) < 30556985 / 8388608 := by
  norm_num

theorem quartic_mesh_step :
    (140 : ℚ) * (5 / 512) = 175 / 128 := by
  norm_num

theorem finite_heat_polynomial_increment (a t h z : ℝ) :
    (z^2 + a - 2 * (t + h)) - (z^2 + a - 2*t) = -2*h := by
  ring

theorem finite_heat_positive_discriminant
    (a t : ℝ) (ha : 0 < a) (ht : a ≤ t) :
    0 < 2*t-a := by
  linarith

theorem finite_heat_initial_sign (a : ℝ) (ha : 0 < a) :
    0 < a - 2*(0:ℝ) := by
  linarith

#print axioms all_zeros_accounted_for
#print axioms all_real_quartic_mesh_margin
#print axioms mixed_quartic_mesh_margin
#print axioms quartic_mesh_step
#print axioms finite_heat_polynomial_increment
#print axioms finite_heat_positive_discriminant
end XiKernel
