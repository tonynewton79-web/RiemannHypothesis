import Mathlib

/-!
# Finite-window lattice renormalization for theta zero gaps

Only the algebraic gap decomposition, rational equilibrium examples, and
conditional scalar inequalities are formalized here. The genus-one
Hadamard product, infinite zero sum, actual Jacobi theta integrals,
near-lattice estimates, and Riemann hypothesis remain unformalized.
The code must compile in GitHub CI before kernel certification is claimed.
-/

namespace XiKernel

theorem lattice_external_difference (a b rho : ℝ)
    (ha : a ≠ rho) (hb : b ≠ rho) :
    1 / (b - rho) - 1 / (a - rho) =
      (a - b) / ((b - rho) * (a - rho)) := by
  have hb' : b - rho ≠ 0 := sub_ne_zero.mpr hb
  have ha' : a - rho ≠ 0 := sub_ne_zero.mpr ha
  field_simp [hb', ha']
  ring

theorem lattice_gap_renormalization
    (missing local tail : ℝ) :
    8 - 4 * (2 - missing + local + tail) =
      -4 * (local + (tail - missing)) := by
  ring

theorem finite_lattice_1_1 :
    (8:ℚ) - 4*(1 + 0) = 4 := by norm_num

theorem finite_lattice_2_5 :
    (8:ℚ) - 4*(2 - 1/3 - 1/6) = 2 := by norm_num

theorem finite_lattice_10_10 :
    (8:ℚ) - 4*(2 - 2/11) = 8/11 := by norm_num

theorem lattice_local_window_budget :
    (4:ℚ) * (26/7) = 104/7 := by norm_num

theorem lattice_conditional_gap_bound
    (local tailError eps tau drift : ℝ)
    (hl : |local| ≤ (26/7) * eps)
    (ht : |tailError| ≤ tau)
    (hd : drift = -4 * (local + tailError)) :
    |drift| ≤ (104/7) * eps + 4*tau := by
  have hadd := abs_add local tailError
  have hscale : |drift| = 4 * |local + tailError| := by
    rw [hd]
    simp [abs_mul]
  rw [hscale]
  nlinarith

theorem lattice_backward_gap_survival
    (gap2 rate time : ℝ)
    (h : rate * time < gap2) :
    0 < gap2 - rate * time := by
  linarith

#print axioms lattice_external_difference
#print axioms lattice_gap_renormalization
#print axioms lattice_conditional_gap_bound
#print axioms lattice_backward_gap_survival

end XiKernel
