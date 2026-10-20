import Mathlib

/-!
# Signed shielding budget: an exact endpoint identity, not yet RH.

For a real-simple adjacent zero gap with squared distance G(s),
the classical de Bruijn-Newman zero ODE gives G'=-4*D.
Therefore G(sigma)=G(0)-4*integral(D), and a strict budget
at sigma is exactly the positivity of the terminal squared gap.
This is NOT an independently verified a priori bound.

The correct collision-exclusion target is a strict budget at
EVERY interior time s<1/2, allowing equality only at s=1/2
(which accommodates hypothetical multiple critical-line zeros).

The polynomial heat-flow test p_s(z)=e^(s ∂_z²)
 ((z²-1)(z²-4)) is an exact adversarial collision.
Lean proves the finite algebraic parts. Its full real-zero
collision/continuation argument is given in the paper.
-/

namespace XiKernel

theorem shielding_strict_budget_iff_gap_positive
    (initialSq integratedDefect terminalSq : ℝ)
    (hflow : terminalSq = initialSq - 4 * integratedDefect) :
    4 * integratedDefect < initialSq ↔ 0 < terminalSq := by
  constructor <;> intro h <;> linarith

theorem shielding_nonstrict_budget_iff_nonnegative_gap
    (initialSq integratedDefect terminalSq : ℝ)
    (hflow : terminalSq = initialSq - 4 * integratedDefect) :
    4 * integratedDefect ≤ initialSq ↔ 0 ≤ terminalSq := by
  constructor <;> intro h <;> linarith

/-- Quantitative independent envelope: the genuine missing estimate
must produce a lower margin separately, not define it using G. -/
theorem independent_shielding_envelope_gate
    (initialSq deficitIntegral envelope margin : ℝ)
    (henvelope : deficitIntegral ≤ envelope)
    (hmargin : 0 < margin)
    (hbound : 4 * envelope ≤ initialSq - margin) :
    margin ≤ initialSq - 4 * deficitIntegral := by
  linarith

/-- Exact quartic heat solution e^(s*D²) (z⁴-5z²+4). -/
theorem quartic_heat_polynomial (s z : ℝ) :
    z^4 + (12*s-5)*z^2 + 12*s^2-10*s+4 =
      (z^2-1)*(z^2-4) + s*(12*z^2-10) + 12*s^2 := by
  ring

/-- Discriminant in the variable v=z². -/
theorem quartic_square_discriminant (s : ℝ) :
    (5-12*s)^2-4*(12*s^2-10*s+4) =
      96*s^2-80*s+9 := by
  ring

theorem quartic_discriminant_at_zero :
    (96:ℚ)*0^2-80*0+9=9 := by
  norm_num

theorem quartic_discriminant_at_eighth :
    (0:ℚ) < 96*(1/8)^2-80*(1/8)+9 := by
  norm_num

theorem quartic_discriminant_at_seventh :
    96*(1/7:ℚ)^2-80*(1/7)+9 < 0 := by
  norm_num

theorem quartic_collision_before_half :
    (1/7:ℚ) < 1/2 := by
  norm_num

/-- The initial gap 1<2 has exterior zeros -1,-2;
its signed shielding is S=1/4, D=2-S=7/4. -/
theorem quartic_initial_shielding :
    (1/((1-(-1))*(2-(-1))) : ℚ) +
      1/((1-(-2))*(2-(-2))) = 1/4 := by
  norm_num

theorem quartic_initial_defect :
    (2:ℚ) - 1/4 = 7/4 := by
  norm_num

theorem quartic_initial_squared_speed :
    (-4:ℚ)*(7/4) = -7 := by
  norm_num

/-- A regular lattice has no signed shielding loss, despite the
same selected initial gap length. -/
theorem lattice_signed_defect_zero :
    (2:ℚ)-2=0 := by
  norm_num

end XiKernel
