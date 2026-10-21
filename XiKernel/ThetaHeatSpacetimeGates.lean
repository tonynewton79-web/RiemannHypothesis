import Mathlib

/-!
# Riemann Xi spacetime theta margin and exact heat-polynomial controls

Scope: exact rational inequalities and algebra of a quartic backward-heat
countermodel. Does NOT prove the theta integral enclosures,
complex Rouche theorem, holomorphic root continuation, uniform annular
census, de Bruijn-Newman bound, or the Riemann hypothesis.
No sorry, external axiom or native_decide. Compilation requires Lean CI.
-/
namespace XiKernel

private def thetaBase : ℚ := 913 / 50000000
private def thetaTaylor : ℚ := 1095151763 / 85657500000000
private def thetaR2 : ℚ := 34 / 225
private def thetaA : ℚ := 5302 / 10^8 + (2 / 5) / 50000 + thetaR2 / 282
private def thetaStep : ℚ := 1 / 115

theorem extended_theta_rouche_margin :
    thetaBase - thetaTaylor - thetaStep * thetaA - thetaStep^2 / 282
      = 743389933 / 45312817500000000 := by
  norm_num [thetaBase, thetaTaylor, thetaR2, thetaA, thetaStep]

theorem extended_theta_margin_positive :
    0 < thetaBase - thetaTaylor - thetaStep * thetaA - thetaStep^2 / 282 := by
  rw [extended_theta_rouche_margin]
  norm_num

theorem extended_heat_step_improvement :
    (1500 : ℚ) / 115 > 13 := by
  norm_num

theorem heat_quartic_factor (z R d : ℝ) :
    ((z - R)^2 - d^2) * ((z + R)^2 - d^2) =
      z^4 - 2 * (R^2 + d^2) * z^2 + (R^2 - d^2)^2 := by
  ring

theorem heat_quartic_pde_jet (z R d s : ℝ) :
    (-4 * (R^2 + d^2) + 12 * z^2 + 24 * s) =
      12 * z^2 + 2 * (-2 * (R^2 + d^2) + 12 * s) := by
  ring

theorem heat_quartic_discriminant (R d s : ℝ) :
    (-2 * (R^2 + d^2) + 12 * s)^2 -
      4 * ((R^2 - d^2)^2 - 4*(R^2 + d^2)*s + 12*s^2) =
    16 * (R^2*d^2 - 2*(R^2 + d^2)*s + 6*s^2) := by
  ring

theorem heat_quartic_initial_discriminant :
    (1000 : ℚ)^2 * (1/10)^2 = 10000 := by
  norm_num

theorem heat_quartic_final_discriminant :
    (1000 : ℚ)^2 * (1/10)^2 -
      2 * ((1000 : ℚ)^2 + (1/10)^2) * (1/100) +
      6 * (1/100 : ℚ)^2 = -24999999 / 2500 := by
  norm_num

private def ad : ℚ := (1000 : ℚ)^2 - (1/10)^2
private def ab : ℚ := 2 * ((1000 : ℚ)^2 + (1/10)^2) / ad^2
private def ac : ℚ := 1 / ad^2
private def c0 : ℚ := ab * (4 + 2/100) + ac * (16 + 48/100 + 12 / 10000)
private def c1 : ℚ := 4 * ab + ac * (32 + 48/100)
private def c2 : ℚ := 2 * ab + ac * (48 + 24/100)

theorem heat_quartic_compact_C2 :
    c0 < 9 / 1000000 ∧ c1 < 9 / 1000000 ∧ c2 < 9 / 1000000 := by
  norm_num [c0, c1, c2, ab, ac, ad]

theorem spacetime_mesh_noncollision_gate (m m1 m2 m3 hx hs : ℝ)
    (h : hx * (m1+m2) + hs * (m2+m3) < m) :
    0 < m - (hx * (m1+m2) + hs * (m2+m3)) := by
  linarith

#print axioms extended_theta_rouche_margin
#print axioms extended_theta_margin_positive
#print axioms heat_quartic_factor
#print axioms heat_quartic_discriminant
#print axioms heat_quartic_final_discriminant
#print axioms heat_quartic_compact_C2
end XiKernel
