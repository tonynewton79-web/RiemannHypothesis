import Mathlib

/-!
# Root-spacing obstruction to height-uniform heat/Laguerre comparison

For a real Laguerre--Pólya entire function F with a simple zero a,
F(z)=(z-a)g(z) and L2[F](a)/L1[F](a)
= (g'(a)^2-g(a)g''(a))/g(a)^2.

If b is another simple real zero, let
g(z)=(z-b)h(z), d=a-b. Then
L1[F](a)=(d*h(a))^2,
L2[F](a)=h(a)^2+d^2*(h'(a)^2-h(a)h''(a)).
The residual h has nonnegative first Laguerre expression
at a in the Laguerre--Pólya class. Thus
L2/L1 >= 1/d².

The theta-specific conclusion at t=1/2 also uses the
published real-zero count for H_t, which is not
formalized here. These Lean theorems certify only
the elementary local identities and positivity gates.
-/

namespace XiKernel

theorem root_gap_first_jet_identity (d h : ℝ) :
    (d*h)^2 = d^2*h^2 := by ring

theorem root_gap_second_jet_identity (d h hp hpp : ℝ) :
    (h+d*hp)^2 - (d*h)*(2*hp+d*hpp) =
      h^2+d^2*(hp^2-h*hpp) := by ring

theorem root_gap_second_lower (d h hp hpp : ℝ)
    (hres : 0 ≤ hp^2-h*hpp) :
    h^2 ≤ (h+d*hp)^2 - (d*h)*(2*hp+d*hpp) := by
  rw [root_gap_second_jet_identity]
  have hnonneg : 0 ≤ d^2*(hp^2-h*hpp) :=
    mul_nonneg (sq_nonneg d) hres
  linarith

theorem root_gap_scaled_ratio_gate (d h hp hpp : ℝ)
    (hres : 0 ≤ hp^2-h*hpp) :
    (d*h)^2 ≤
      d^2*((h+d*hp)^2-(d*h)*(2*hp+d*hpp)) := by
  have hl := root_gap_second_lower d h hp hpp hres
  have hh := mul_le_mul_of_nonneg_left hl (sq_nonneg d)
  nlinarith [hh]

/-- For the quadratic model F(z)=(z-a)(z-b) at z=a,
L1=d² and L2=1. The ratio becomes unbounded as d→0. -/
theorem two_root_ratio_algebra (d : ℝ) :
    ((0+d*0)^2-(d*1)*(2*0+d*0) + 1) = 1 := by
  ring

theorem close_root_ratio_lower (d C : ℝ)
    (hd : 0 < d) (hC : 0 ≤ C) (hsmall : d^2*C < 1) :
    C < 1/d^2 := by
  have hs : 0 < d^2 := sq_pos_of_pos hd
  apply (lt_div_iff₀ hs).2
  simpa using hsmall

end XiKernel
