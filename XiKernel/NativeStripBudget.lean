import Mathlib

/-!
# Native-strip theta two-saddle budget: algebraic gates
Only rational and scalar order inequalities are proved. The Riemann--Siegel
approximation, its uniform analytic remainder, theta integral and Riemann
hypothesis are not formalized. GitHub CI compilation is required.
-/
namespace XiKernel

theorem native_strip_power_gate : (50 : ℕ) ^ 4 < 2 ^ 23 := by
  norm_num

theorem native_strip_final_budget :
    (1 : ℚ) / 1600 + 1 / 4000 = 7 / 8000 := by
  norm_num

theorem native_strip_final_strict :
    (7 : ℚ) / 8000 < 1 / 1000 := by
  norm_num

theorem native_strip_summation_gate :
    (3 : ℚ) * (12 / 11) < 4 := by
  norm_num

theorem native_strip_zero_modulus (g err : ℝ)
    (hzero : |1 - g| ≤ err)
    (hbudget : err ≤ 1 / 1000) :
    (999 / 1000 : ℝ) ≤ g := by
  have h := (abs_le.mp hzero).2
  linarith

theorem native_strip_width_numerator (L : ℝ)
    (hL : 200 ≤ L) :
    800 * L < 999 * (L - 1 / 25) := by
  linarith

#print axioms native_strip_power_gate
#print axioms native_strip_final_budget
#print axioms native_strip_final_strict
#print axioms native_strip_summation_gate
#print axioms native_strip_zero_modulus
#print axioms native_strip_width_numerator
end XiKernel
