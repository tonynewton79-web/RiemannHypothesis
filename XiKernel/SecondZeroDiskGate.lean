import Mathlib

/-!
# Rational Rouché gate: second genuine Riemann Xi zero

The externally audited mpmath.iv interval-Simpson certificate proves:
|a0|<5/10^8, a1>21/10^7, |a2|<10^-6 and
|R3(w)|<45/10^9 on |w|<=1/10,
where F2(42.04408+w)=a0+a1*w+a2*w²+R3(w).
Then |F2|>105/10^9 on the boundary, and the genuine Xi/Fourier
truncation error is <10^-9. The actual complex-analytic theorem is
in the paper and numerical certificate; Lean certifies the rational
algebra only, not interval integrals or Rouché's theorem.
-/

namespace XiKernel

theorem second_zero_boundary_exact_margin :
    (21/10^7 : ℚ)/10 -
      (5/10^8 + (1/10^6)/100 + 45/10^9)
      = 105/10^9 := by
  norm_num

theorem second_zero_disk_rouche_gap
    (cutoffMod tail : ℝ)
    (hcutoff : (105/10^9 : ℝ) ≤ cutoffMod)
    (htail : tail ≤ (1/10^9 : ℝ)) :
    tail < cutoffMod := by
  linarith

theorem second_zero_comparison_gate
    (linear constant quadratic remainder : ℝ)
    (hl : (21/10^8 : ℝ) < linear)
    (hc : constant < (5/10^8 : ℝ))
    (hq : quadratic < (1/10^8 : ℝ))
    (hr : remainder < (45/10^9 : ℝ)) :
    (105/10^9 : ℝ) < linear - constant - quadratic - remainder := by
  linarith

end XiKernel
