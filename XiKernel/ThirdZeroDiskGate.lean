import Mathlib

/-!
# Rational Rouché gate: third genuine Riemann Xi zero

The independently run mpmath.iv interval-Simpson certificate
encloses F2(50.02171516+w)=a0+a1*w+a2*w²+R3(w):
 |a0|<1e-9, a1<-156e-9, |a2|<5e-8,
 |R3(w)|<27e-10 on |w|<=1/25.
Then |F2|>2e-9 on the boundary.
The theta-tail bound E2<1e-9 transfers a one-zero count
to the genuine completed Riemann Xi function by Rouché.

Lean verifies only these finite rational gates; not
the interval-Simpson integrals or analytic Rouché theorem.
-/

namespace XiKernel

theorem third_zero_boundary_exact_margin :
    (156/10^9 : ℚ)/25 -
       (1/10^9 + (5/10^8)/625 + 27/10^10)
       = 246/10^11 := by
  norm_num

theorem third_zero_boundary_above_tail :
    (1/10^9 : ℚ) < 246/10^11 := by
  norm_num

theorem third_zero_disk_rouche_gate
    (cutoffMod tail : ℝ)
    (hcutoff : (2/10^9 : ℝ) ≤ cutoffMod)
    (htail : tail ≤ (1/10^9 : ℝ)) :
    tail < cutoffMod := by
  linarith

theorem third_zero_comparison_gate
    (linear constant quadratic remainder : ℝ)
    (hl : (156/10^9 : ℝ)/25 < linear)
    (hc : constant < (1/10^9 : ℝ))
    (hq : quadratic < (5/10^8 : ℝ)/625)
    (hr : remainder < (27/10^10 : ℝ)) :
    (2/10^9 : ℝ) < linear - constant - quadratic - remainder := by
  linarith

end XiKernel
