import Mathlib

/-!
# Rational polygon-counting algebra interface
Only a complex chord decomposition and elementary margin inequality
are proved here. The contour homotopy, argument principle, theta
Fourier integral, Polymath15 cutoff and Riemann hypothesis are NOT
formalized in this file.
-/
namespace XiKernel

theorem chord_decomposition (v a b qa qb u : ℂ) :
    v - ((1-u)*qa + u*qb) =
      (1-u)*(v-a) + u*(v-b) +
      (1-u)*(a-qa) + u*(b-qb) := by
  ring

theorem rational_mesh_margin
    (d err lip length : ℝ)
    (h : err + lip * length / 2 < d) :
    0 < d - (err + lip * length / 2) := by
  linarith

theorem rational_good_control_margin :
    (11:ℚ) < (51008341061446011:ℚ) / 4586699148283904 := by
  norm_num

theorem rational_mixed_control_margin :
    (9:ℚ)/50 < (27554166292991456079:ℚ) / 145916667512443961344 := by
  norm_num

#print axioms chord_decomposition
#print axioms rational_mesh_margin
#print axioms rational_good_control_margin
#print axioms rational_mixed_control_margin
end XiKernel
