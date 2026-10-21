import Mathlib

/-!
# Native-strip high-zero phase gates (arithmetic fragment only)

These lemmas formalize exact rational arithmetic and algebraic prerequisites
of the paper-level high-zero circle proof. They do NOT formalize the
Polymath15 theta approximation, the complex logarithmic phase, the
analytic phase-derivative estimate, Rouche's theorem, the outer zero-free
strip, or the Riemann hypothesis. Compilation remains to be checked.
-/
namespace XiKernel

theorem native_strip_exp_repair :
    (384 : ℚ) / (330 * 200 ^ 2) < 1 / 10000 := by
  norm_num

theorem native_strip_exp_second_step :
    (2 : ℚ) / 10000 = 1 / 5000 := by
  norm_num

theorem native_strip_rouche_cos_lower :
    (1 : ℚ) / 2 < 2 * (2 / 5 - (3 / 5) ^ 3 / 3) := by
  norm_num

theorem native_strip_rouche_error_small :
    (2 : ℚ) / 1000 < 1 / 2 := by
  norm_num

theorem native_strip_rouche_margin :
    (1 : ℚ) / 2 - 2 / 1000 = 249 / 500 := by
  norm_num

theorem native_strip_phase_contour_half :
    (1 : ℚ) / 2 - (1 / 4) * (2 / 200) > 2 / 5 := by
  norm_num

theorem native_strip_phase_contour_upper :
    (1 : ℚ) / 2 + (1 / 4) * (2 / 200) < 3 / 5 := by
  norm_num

theorem native_strip_phase_near_axis :
    (1 : ℚ) / 1600 + 1 / 160000 < 1 / 1000 := by
  norm_num

theorem native_strip_phase_cover_budget :
    (2 : ℚ) / 1000 + 1 / 1000 = 3 / 1000 := by
  norm_num

theorem native_strip_analytic_normalization (a b : ℂ) :
    (a + b) / 2 + (a - b) / 2 = a := by
  ring

theorem native_strip_real_gap_scale (L : ℝ)
    (hL : 200 ≤ L) :
    (3 / 1000 : ℝ) * L < (1 / 50) * (L / 4 - 1 / 100) := by
  linarith

#print axioms native_strip_exp_repair
#print axioms native_strip_rouche_cos_lower
#print axioms native_strip_phase_cover_budget
#print axioms native_strip_real_gap_scale
end XiKernel
