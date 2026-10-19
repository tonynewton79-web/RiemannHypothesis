import Mathlib

/-!
# Complex-strip Fourier tail gate for the actual Riemann Xi kernel.

Because possible off-critical Xi zeros have Fourier coordinate
|Im z|<1, a uniform bound on |Im z|<=3 is enough for any
bounded Rouché contour around such potential zeros.

The full theorem is analytic and in the associated manuscript:
  |F^(k)(z)-F_M^(k)(z)|
    <= 3 * k! * q_(M+1) * exp(-q_(M+1)) / 4^k
on |Im z| <= 3 for every k>=0;
and the same k=0 bound extends to |Im z|<=7.

This Lean module proves exact exponent gates and elementary
norm-gap logic; Gaussian/Fourier integrals and Rouché's theorem
are not asserted as kernel-checked here.
-/

namespace XiKernel

theorem derivative_complex_strip_gate (Y : ℝ)
    (hY : Y ≤ 3) : (9+Y)/4 ≤ 3 := by
  linarith

theorem zeroth_complex_strip_gate (Y : ℝ)
    (hY : Y ≤ 7) : (5+Y)/4 ≤ 3 := by
  linarith

theorem critical_strip_xi_coordinate
    (y : ℝ) (h : -1 < y ∧ y < 1) :
    0 < (1-y)/2 ∧ (1-y)/2 < 1 := by
  constructor <;> linarith [h.1, h.2]

theorem strict_rouche_modulus_gate
    (f fm : ℂ) (err : ℝ)
    (h : ‖f-fm‖ ≤ err) (hlarge : err < ‖fm‖) :
    f ≠ 0 := by
  intro hf
  have hs : ‖fm‖ ≤ err := by simpa [hf] using h
  linarith

/-- No fixed positive absolute error can prove a modulus gap
along a curve where approximant moduli tend to zero. This is
the abstract algebraic obstruction to a global Rouché claim. -/
theorem missing_global_gap
    (err m : ℝ) (he : 0 < err) (hm : m ≤ err) :
    ¬ err < m := by
  linarith

end XiKernel
