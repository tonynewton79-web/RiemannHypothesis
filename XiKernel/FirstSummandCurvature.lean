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

/-- Quantitative negative-curvature region for the dominant theta term.
The classical rational bounds 3 < π < 22/7 < 13/4 put y=π here
at r=0. The inequalities are polynomial and kernel-checkable. -/
theorem first_summand_negative_near_modular_y (y : ℝ)
    (hylo : 3 ≤ y) (hyhi : y ≤ 13/4) :
    curvaturePolynomial y < 0 := by
  let t := y - 3
  have ht0 : 0 ≤ t := by dsimp [t]; linarith
  have ht1 : t ≤ 1/4 := by dsimp [t]; linarith
  have hsmall : 0 ≤ 1/4 - t := by linarith
  have ht2 : t^2 ≤ 1/16 := by
    have h := mul_nonneg ht0 hsmall
    nlinarith
  have ht3 : t^3 ≤ 1/64 := by
    have h := mul_nonneg (sq_nonneg t) hsmall
    nlinarith [ht2]
  have hpoly : curvaturePolynomial y =
      8*t^3+36*t^2+42*t-27 := by
    unfold curvaturePolynomial
    dsimp [t]
    ring
  rw [hpoly]
  nlinarith [ht2, ht3]

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

/-- The exact algebraic gate behind the weighted defect
W(t)=t^(3/2)*(-log s)''(t). Passing from W' to curvature
requires a separate chain-rule theorem for the genuine theta kernel. -/
theorem weighted_curvature_gate_identity (u q dq : ℝ) :
    12*u*q + 8*u^3*dq =
      8*u*((3/2)*q + u^2*dq) := by
  ring

theorem weighted_curvature_gate_positive (u q dq : ℝ)
    (hu : 0 < u) (hq : 0 < (3/2)*q + u^2*dq) :
    0 < 12*u*q + 8*u^3*dq := by
  rw [weighted_curvature_gate_identity]
  positivity

end XiKernel
