import Mathlib

/-!
# Phase-box rational margins for the Polymath15 counting-phase atlas

Only rational arithmetic and a scalar implication are formalized here.
This file DOES NOT formalize the complex phase univalence theorem,
Rouche's theorem, Polymath15's actual theta remainder, an explicit
numeric high-zero cutoff, zero counting, or the Riemann hypothesis.
The file has not been compiled locally; CI must be checked independently.
-/
namespace XiKernel

theorem phase_box_lower_margin :
    2 * ((1 / 4 : ℚ) - (1 / 4 : ℚ) ^ 3 / 6) - 1 / 5 = 283 / 960 := by
  norm_num

theorem phase_box_strict_gate :
    (1 / 5 : ℚ) < 2 * ((1 / 4 : ℚ) - (1 / 4 : ℚ) ^ 3 / 6) := by
  norm_num

theorem phase_inverse_fraction_bound :
    (3 / 8 : ℚ) + 1 / 1400 < 1 / 2 := by
  norm_num

theorem phase_inverse_margin :
    (1 / 2 : ℚ) - 3 / 8 - 1 / 1400 = 87 / 700 := by
  norm_num

theorem phase_second_derivative_fraction_bound :
    (1 / (4 * 199) : ℚ) + 1 / (8 * (199 ^ 2)) < 1 / 700 := by
  norm_num

theorem phase_strict_rouche_scalar (m e : ℝ)
    (h : e < m) : 0 < m - e := by
  linarith

#print axioms phase_box_lower_margin
#print axioms phase_box_strict_gate
#print axioms phase_inverse_fraction_bound
#print axioms phase_inverse_margin
#print axioms phase_second_derivative_fraction_bound
end XiKernel
