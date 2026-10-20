import Mathlib

/-!
# Adjacent-zero shielding under backwards de Bruijn--Newman heat flow

For a real-root simple-zero interval, the classical zero dynamics are
x'_j(t)=2 PV sum_{k ne j} 1/(x_j-x_k).
Let a<b be adjacent zeros, g=b-a, and
S=sum_{r ne a,b} 1/((a-r)*(b-r)).
With s=1/2-t, the squared gap obeys
  d_s(g^2) = -8+4*g^2*S.
All infinite product and ODE inputs come from classical work by
Csordas--Smith--Varga and Rodgers--Tao. The new finite-window
estimates and shielding budget in the paper are CONDITIONAL.

This file certifies only algebraic signs, identities and quantitative
margin implications, not the infinite principal-value zero ODE
or the Riemann hypothesis.
-/

namespace XiKernel

theorem gap_velocity_difference
    (g S va vb : ℝ)
    (hflow : g*(vb-va) = 4-2*g^2*S) :
    2*g*(va-vb) = -8+4*g^2*S := by
  nlinarith [hflow]

theorem regular_lattice_shielding (g2 : ℝ) (hg : g2 ≠ 0) :
    -8+4*g2*(2/g2) = 0 := by
  field_simp [hg]
  ring

theorem finite_lattice_edge_defect (R : ℝ) (hR : R ≠ -1) :
    -8+4*(2*R/(R+1)) = -8/(R+1) := by
  have hden : R+1 ≠ 0 := by
    intro hz
    apply hR
    linarith
  field_simp [hden]
  ring

theorem lower_shielding_rate_gate
    (gapSq extShield R eps : ℝ)
    (hdefect : 2-gapSq*extShield ≤ 2/(R+1)+4*eps) :
    -8/(R+1)-16*eps ≤ -8+4*gapSq*extShield := by
  linarith

theorem integrated_shielding_requirement
    (g0sq gTsq T integralShield : ℝ)
    (hidentity : gTsq = g0sq-8*T+4*integralShield)
    (hpositive : 0 ≤ gTsq) :
    8*T-g0sq ≤ 4*integralShield := by
  linarith

theorem near_lattice_half_time_survival
    (initialSq terminalSq R eps : ℝ)
    (hbudget : initialSq -
      (4/(R+1)+8*eps) ≤ terminalSq)
    (hstrict : 4/(R+1)+8*eps < initialSq) :
    0 < terminalSq := by
  linarith

theorem logheight_gap_rigidity_gate
    (gapSq R eps : ℝ)
    (hg : 0 < gapSq)
    (hR : 16/gapSq ≤ R)
    (heps : 0 ≤ eps)
    (hepsmax : eps ≤ gapSq/32) :
    4/(R+1)+8*eps < gapSq := by
  have hRpos : 0 < R+1 := by
    have : 0 < 16/gapSq := div_pos (by norm_num) hg
    linarith
  have hRlower : 16 ≤ gapSq*R := by
    have ht : 16 ≤ R*gapSq := (div_le_iff₀ hg).mp hR
    nlinarith
  have hR1 : 0 < gapSq*(R+1) := mul_pos hg hRpos
  have h1 : 4/(R+1) < gapSq/4 := by
    apply (div_lt_iff₀ hRpos).2
    nlinarith
  have h2 : 8*eps ≤ gapSq/4 := by linarith
  linarith

end XiKernel
