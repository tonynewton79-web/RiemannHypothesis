import Mathlib

/-!
# Exact inverse-square coefficient barrier at midpoints of real zeros.

Let a<b be consecutive simple zeros of a real entire genus≤1
Laguerre--Pólya function G, and m=(a+b)/2, g=b-a>0.
By the real-zero canonical product, at m (which is not a zero),
put λ=4/g² for the two selected roots, let B be the sum of the
remaining inverse-square distances and E the sum of their
pairwise products. Both B,E are nonnegative.

Then L₁/G² = 2λ+B, L₂/G² = λ²+2λ B+E.
Thus 6L₂/L₁ >=3λ=12/g².

This Lean module proves the algebraic gap, not the
infinite canonical-product identity or RH.
-/
namespace XiKernel

theorem midpoint_pair_ratio_gate
    (lam B E : ℝ) (hlam : 0 < lam)
    (hB : 0 ≤ B) (hE : 0 ≤ E) :
    3*lam*(2*lam+B) ≤ 6*(lam^2+2*lam*B+E) := by
  nlinarith [mul_nonneg (show 0 ≤ lam by positivity) hB]

theorem midpoint_pair_strict_denominator
    (lam B : ℝ) (hlam : 0 < lam) (hB : 0 ≤ B) :
    0 < 2*lam+B := by
  linarith

theorem midpoint_inverse_gap_barrier
    (g B E : ℝ) (hg : 0 < g)
    (hB : 0 ≤ B) (hE : 0 ≤ E) :
    12/g^2 ≤
      6*((4/g^2)^2+2*(4/g^2)*B+E)/(2*(4/g^2)+B) := by
  have hsq : 0 < g^2 := sq_pos_of_pos hg
  have hlam : 0 < 4/g^2 := div_pos (by norm_num) hsq
  have hden := midpoint_pair_strict_denominator (4/g^2) B hlam hB
  have hmain := midpoint_pair_ratio_gate (4/g^2) B E hlam hB hE
  have hq : 3*(4/g^2) ≤
      6*((4/g^2)^2+2*(4/g^2)*B+E)/(2*(4/g^2)+B) :=
    (le_div_iff₀ hden).2 hmain
  have heq : 3*(4/g^2) = 12/g^2 := by ring
  rw [heq] at hq
  exact hq

theorem midpoint_logsquare_forces_spacing
    (g C scale : ℝ) (hg : 0 < g)
    (hC : 0 < C) (hs : 0 < scale)
    (hgap : 12/g^2 ≤ C*scale) :
    12 ≤ C*scale*g^2 := by
  have hgg : 0 < g^2 := sq_pos_of_pos hg
  exact (div_le_iff₀ hgg).mp hgap

end XiKernel
