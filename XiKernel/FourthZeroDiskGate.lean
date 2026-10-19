import Mathlib

/-!
# Fourth genuine Xi zero: exact local interval/Rouché margin

External mpmath.iv 1.3.0 + analytic Simpson/theta-tail proof gives,
at z0=60.849752252, for the THREE-MODE approximation:
|a0|<5e-13, a1>3012e-12, |a2|<15e-10,
|R3(w)|<52e-13 for |w|<=1/200.
Thus |F3|>9.3225e-12 on the circle.
Full theta tail E3=3q4 exp(-q4)<153/20^16<1e-18,
q4=16pi. This leads to exactly one real simple zero of Xi
in the disk by two classical Rouché comparisons.

Lean checks ONLY the rational algebraic inequalities below,
NOT the directed interval transcendental data, Simpson formula,
Jacobi-theta identity or complex-analytic zero-count transfer.
-/

namespace XiKernel

theorem fourth_zero_exact_margin :
    (3012/10^12 : ℚ)/200 -
      ((5/10^13 : ℚ)+(15/10^10 : ℚ)/200^2+(52/10^13 : ℚ))
      = 3729/400000000000000 := by
  norm_num

theorem fourth_zero_margin_sufficient :
    (8/10^12 : ℚ) < 3729/400000000000000 := by
  norm_num

theorem fourth_zero_tail_rational_gate :
    (153/20^16 : ℚ) < 1/10^18 := by
  norm_num

theorem fourth_zero_rouche_gap (cutoffMod error : ℝ)
    (hm : (8/10^12 : ℝ) ≤ cutoffMod)
    (he : error ≤ (1/10^18 : ℝ)) :
    error < cutoffMod := by
  linarith

theorem fourth_zero_linear_comparison
    (linear constant quadratic remainder : ℝ)
    (hl : (3012/10^12 : ℝ)/200 < linear)
    (hc : constant < (5/10^13 : ℝ))
    (hq : quadratic < (15/10^10 : ℝ)/200^2)
    (hr : remainder < (52/10^13 : ℝ)) :
    (8/10^12 : ℝ) < linear - constant - quadratic - remainder := by
  linarith

end XiKernel
