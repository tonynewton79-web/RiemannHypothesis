import Mathlib

/-!
# Relative moving collar: algebraic certificates only

Exact rational inequalities from assumed theta Fourier-jet enclosures,
plus elementary algebra of the two-root heat-gap equation.
No theta integral, interval algorithm, Rouché theorem, global annular
count or Riemann hypothesis is formalized here. CI is required.
-/
namespace XiKernel

private def collarS : ℚ := 1 / 115
private def collarR : ℚ := 3 / 10
private def collarShift : ℚ := 3 / 5 * collarS
private def collarRadius : ℚ := collarR + collarShift
private def collarE : ℚ :=
  183 / 10^8 + collarS * (5302 / 10^8) + collarS^2 / (2*141)
private def collarM : ℚ :=
  913 / 10^7 - collarS * (1832 / 10^8) - collarS^2 / 2000
private def collarB : ℚ :=
  5302 / 10^8 + collarS / 141 + collarRadius * (1832 / 10^8) +
    collarRadius^2 / 282
private def collarGap : ℚ :=
  collarM * (collarR - collarShift) - collarE - collarRadius^2 * collarB / 2

theorem moving_collar_shift_exact : collarShift = 3 / 575 := by
  norm_num [collarShift, collarS]

theorem moving_collar_max_radius : collarRadius = 351 / 1150 := by
  norm_num [collarRadius, collarR, collarShift, collarS]

theorem moving_collar_strip_admissible : collarRadius < 1 / 3 := by
  norm_num [collarRadius, collarR, collarShift, collarS]

theorem moving_collar_slope_lower : collarM = 12048357 / 132250000000 := by
  norm_num [collarM, collarS]

theorem moving_collar_value_upper : collarE = 95443321 / 37294500000000 := by
  norm_num [collarE, collarS]

theorem moving_collar_curvature_upper :
    collarB = 42014974169 / 93236250000000 := by
  norm_num [collarB, collarS, collarRadius, collarShift, collarR]

theorem moving_collar_gap_exact :
    collarGap = 815437494087031 / 246609881250000000000 := by
  norm_num [collarGap, collarB, collarM, collarE,
    collarS, collarRadius, collarShift, collarR]

theorem moving_collar_gap_positive : 0 < collarGap := by
  rw [moving_collar_gap_exact]
  norm_num

theorem two_zero_gap_square_identity (d rhoA rhoB da db : ℝ)
    (hd : d ≠ 0)
    (ha : da = -2/d + 2*rhoA)
    (hb : db = 2/d + 2*rhoB) :
    2*d*(db-da) = 8 + 4*d*(rhoB-rhoA) := by
  rw [ha, hb]
  field_simp [hd]
  ring

#print axioms moving_collar_gap_exact
#print axioms moving_collar_gap_positive
#print axioms two_zero_gap_square_identity
end XiKernel
