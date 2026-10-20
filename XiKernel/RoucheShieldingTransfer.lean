import Mathlib

/-!
# A noncircular local theta-flow shielding certificate

The analytic Rouché premise (in the companion manuscript)
certifies one real zero in each of two disjoint disks
centred on adjacent zeros a0,b0, radius r<g0/2, and
exactly two zeros in an enclosing corridor. This
implies a terminal gap >=g0-2r independently of the
signed-gap ODE. The ODE then gives the true envelope
integral(D) <= r*(g0-r), eta=(g0-2r)^2>0.

This Lean module kernel-checks the algebraic transfer and
a quartic adversarial rational contour margin only.
It does not formalize Rouche's theorem or the theta
Fourier-integral contour minimum. RH is not proved.
-/

namespace XiKernel

theorem disk_separation_positive
    (g r : ℝ) (hg : 0 < g) (hr : 0 ≤ r)
    (htwo : 2*r < g) :
    0 < (g-2*r)^2 := by
  have hd : 0 < g-2*r := by linarith
  exact sq_pos_of_pos hd

theorem rouche_to_signed_shielding_envelope
    (g r I terminalSq : ℝ)
    (hflow : terminalSq = g^2 - 4*I)
    (hdisks : (g-2*r)^2 ≤ terminalSq) :
    I ≤ r*(g-r) := by
  have hid : 4*r*(g-r) = g^2-(g-2*r)^2 := by ring
  nlinarith [hid]

theorem rouche_independent_margin
    (g r : ℝ) :
    4*r*(g-r) = g^2-(g-2*r)^2 := by
  ring

theorem quartic_rouche_minimum :
    ((1/4:ℚ)*(3/4)*(7/4)*(11/4)) = 231/256 := by
  norm_num

theorem quartic_rouche_perturbation :
    (283/4 : ℚ)*(1/80)+12*(1/80)^2 = 5672/6400 := by
  norm_num

theorem quartic_rouche_strict_margin :
    (231/256:ℚ) -
      ((283/4)*(1/80)+12*(1/80)^2) =
      103/6400 := by
  norm_num

theorem quartic_local_independent_shielding_margin :
    4*(3/16:ℚ) = 1-(1/4) := by
  norm_num

theorem quartic_local_terminal_gap_floor :
    (1:ℚ)-2*(1/4) = 1/2 := by
  norm_num

end XiKernel
