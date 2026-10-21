import Mathlib

/-!
# Theta collision-cylinder and annular induction: scalar verification

This module proves exact rational bounds and the combinatorial two-gate
induction step. It does NOT formalize the theta kernel, moment-integral
inequalities, holomorphic implicit function theorem, Rouche, argument
principle, the infinite sequence of required annular bounds, or RH.
No 'sorry' and no user-defined axioms are used here.
-/
namespace XiKernel

private def thetaCylDrift : ℚ := 435885103 / 348975000000000
private def thetaCylDerivativeLower : ℚ :=
  913 / 10^7 - (1 / 20) * (5302 / 10^8) -
  ((1 / 20)^2 / 2 + 1 / 1500) * (1 / 55)
private def thetaCylLeftLower : ℚ :=
  -(183 / 10^8) + (913 / 10^7) * (1 / 20) -
  (5302 / 10^8) * (1 / 20)^2 / 2 -
  (1 / 55) * (1 / 20)^3 / 6 - thetaCylDrift
private def thetaCylRightLower : ℚ :=
  181 / 10^8 + (913 / 10^7) * (1 / 20) -
  (5302 / 10^8) * (1 / 20)^2 / 2 -
  (1 / 55) * (1 / 20)^3 / 6 - thetaCylDrift

theorem theta_cylinder_derivative_exact :
    thetaCylDerivativeLower = 1775417 / 33000000000 := by
  unfold thetaCylDerivativeLower
  norm_num
theorem theta_cylinder_left_exact :
    thetaCylLeftLower = 2905965631 / 2791800000000000 := by
  unfold thetaCylLeftLower thetaCylDrift
  norm_num
theorem theta_cylinder_right_exact :
    thetaCylRightLower = 13068117631 / 2791800000000000 := by
  unfold thetaCylRightLower thetaCylDrift
  norm_num
theorem theta_cylinder_outer_monotone :
    (913 / 10^7 : ℚ) - (5302 / 10^8) * (2 / 25) -
      (1 / 110) * (2 / 25)^2 = 397053 / 13750000000 := by
  norm_num
theorem theta_cylinder_positive_separation :
    0 < thetaCylLeftLower ∧
    thetaCylLeftLower < thetaCylDerivativeLower ∧
    thetaCylLeftLower < thetaCylRightLower := by
  unfold thetaCylLeftLower thetaCylRightLower
    thetaCylDerivativeLower thetaCylDrift
  constructor
  · norm_num
  constructor <;> norm_num
theorem theta_grid_no_double_gate (m err : ℝ)
    (hm : err < m) : 0 < m - err := by
  linarith
theorem theta_annular_count_induction
    (oldN oldS annN annS nextN nextS : ℕ)
    (hOld : oldN = oldS) (hAnn : annN = annS)
    (hCount : nextN = oldN + annN)
    (hSigns : nextS = oldS + annS) :
    nextN = nextS := by
  omega
theorem theta_polynomial_collision_step (d : ℝ) :
    d^2 - 2*(d^2 / 2) = 0 := by
  ring
theorem theta_polynomial_collision_examples :
    ((1/10 : ℚ)^2/2 = 1/200) ∧
    ((1/100 : ℚ)^2/2 = 1/20000) ∧
    ((1/1000 : ℚ)^2/2 = 1/2000000) := by
  constructor
  · norm_num
  constructor <;> norm_num

#print axioms theta_cylinder_derivative_exact
#print axioms theta_cylinder_left_exact
#print axioms theta_cylinder_right_exact
#print axioms theta_cylinder_positive_separation
#print axioms theta_annular_count_induction
end XiKernel
