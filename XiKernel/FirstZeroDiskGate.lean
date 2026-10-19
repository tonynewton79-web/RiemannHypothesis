import Mathlib

/-!
# Exact rational Rouché margin for the first true Xi zero.

The interval-Simpson certificate in
certificates/xi_first_zero_interval.py provides the hypotheses:

|a0|<10^-6, a1<-17/100000, |a2|<52/10^6,
and |R3(w)|<6/10^6 for |w|=1/2.

These imply |F2(z)|>65/10^6 on the circle.
The true Xi/Fourier error is E2<10^-9.

Lean checks the exact numerical gate, NOT the transcendental
interval evaluations, Jacobi theta identity, nor Rouche theorem.
-/

namespace XiKernel

theorem first_zero_disk_margin :
    (17/100000 : ℚ)/2 -
      (1/1000000 + (52/1000000)/4 + 6/1000000)
      = 65/1000000 := by
  norm_num

theorem first_zero_tail_margin :
    (27:ℚ)*(22/7)/20^9 < 1/1000000000 := by
  norm_num

theorem certified_circle_modulus_gate
    (linear constant quadratic remainder : ℝ)
    (hlinear : (17/100000 : ℝ)/2 < linear)
    (hconstant : constant < 1/1000000)
    (hquad : quadratic < (52/1000000 : ℝ)/4)
    (hrem : remainder < 6/1000000) :
    65/1000000 < linear - constant - quadratic - remainder := by
  linarith

theorem two_mode_rouche_gap
    (contourMod tail : ℝ)
    (hc : (65/1000000 : ℝ) ≤ contourMod)
    (he : tail ≤ (1/1000000000 : ℝ)) :
    tail < contourMod := by
  linarith

end XiKernel
