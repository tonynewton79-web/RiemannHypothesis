import Mathlib

/-!
# Exact first-theta-summand curvature diagnostic

For the m=1 summand, y = π * exp(4*r).
Its negative logarithmic third derivative is
64*y*(1 - 6*(2*y+3)/(2*y-3)^3).

The m=1 summand has the OPPOSITE curvature sign near y = π,
then has positive curvature for y ≥ 7/2.
This identifies why theta-tail cancellation is essential at the
modular point. No claim about the sign of the full theta sum follows.
-/

namespace XiKernel

def curvaturePolynomial (y : ℝ) : ℝ :=
  (2 * y - 3)^3 - 6 * (2 * y + 3)

theorem curvature_at_three :
    curvaturePolynomial 3 = -27 := by
  norm_num [curvaturePolynomial]

theorem curvature_at_thirteen_fourths :
    curvaturePolynomial (13/4) = -113/8 := by
  norm_num [curvaturePolynomial]

theorem curvature_at_seven_halves :
    curvaturePolynomial (7/2) = 4 := by
  norm_num [curvaturePolynomial]

theorem curvature_shift_identity (t : ℝ) :
    curvaturePolynomial (t + 7/2) =
      8*t^3 + 48*t^2 + 84*t + 4 := by
  unfold curvaturePolynomial
  ring

theorem first_summand_positive_above_threshold (y : ℝ)
    (hy : (7/2 : ℝ) ≤ y) :
    0 < curvaturePolynomial y := by
  have ht : 0 ≤ y - 7/2 := by linarith
  have hident : curvaturePolynomial y =
      8*(y-7/2)^3+48*(y-7/2)^2+84*(y-7/2)+4 := by
    unfold curvaturePolynomial
    ring
  rw [hident]
  positivity

theorem first_summand_third_curvature_pos (y : ℝ)
    (hy : (7/2 : ℝ) ≤ y) :
    0 < 64 * y * (1 - (6*(2*y+3))/((2*y-3)^3)) := by
  have hden : 0 < (2*y-3)^3 := by
    have hd : 0 < 2*y-3 := by linarith
    positivity
  have hpoly := first_summand_positive_above_threshold y hy
  have hratio : 6*(2*y+3)/((2*y-3)^3) < 1 := by
    apply (div_lt_iff₀ hden).2
    dsimp [curvaturePolynomial] at hpoly
    linarith
  have hfactor : 0 < 1 - 6*(2*y+3)/((2*y-3)^3) := by linarith
  have hypos : 0 < y := by linarith
  positivity

/-- The leading local theta curvature slope is proportional to the
genuine second-level log-concavity defect (not to a mere sample).
This is only an algebraic identity; its analytic Taylor derivation
must separately be justified. -/
theorem curvature_jet_identity (a0 a1 a2 : ℝ) (h0 : a0 ≠ 0) :
    -(24:ℝ)*(a2/a0 - a1^2/(2*a0^2)) =
    12*(a1^2 - 2*a0*a2)/a0^2 := by
  field_simp [h0]
  ring

end XiKernel
