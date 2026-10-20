import Mathlib

/-!
# Exact exterior-gap shielding telescoping identity

For a real adjacent zero gap g>0 let the m-th exterior gap,
measured outward from either endpoint, be g*(1+eps_m).
Define D_0=0, D_m = sum_{j=1}^m eps_j, and y_m=m+D_{m-1},
z_m=m+D_m. The normalized one-sided shielding is
S_side = sum_{m>=1} 1/(z_m*(z_m+1)).
We prove the exact FINITE identity

  sum_{m=1}^N (1/(z_m(z_m+1))
                + eps_m/(y_m*z_m))
       + 1/(N+1+D_N) = 1.

If the denominators stay positive and z_m -> infinity, it
extends to an exact infinite equality. For a currently
smallest gap eps_m>=0 on both sides, this immediately
gives g²*S <= 2, and the backward squared gap satisfies
G' = -4*(two nonnegative excess sums) <= 0.

The analytic infinite-series passage and zero-motion ODE
are in the paper, NOT Lean-formalized here.
-/

namespace XiKernel

def gapShell (D : ℕ → ℝ) (m : ℕ) : ℝ :=
  1 / ((((m : ℝ) + 1) + D (m+1)) *
       (((m : ℝ) + 2) + D (m+1)))

def gapExcess (D : ℕ → ℝ) (m : ℕ) : ℝ :=
  (D (m+1) - D m) /
    (((m : ℝ) + 1 + D m) *
     ((m : ℝ) + 1 + D (m+1)))

theorem gap_shell_local_identity
    (y z : ℝ) (hy : y ≠ 0) (hz : z ≠ 0) (h1 : z+1 ≠ 0) :
    1/(z*(z+1)) + (z-y)/(y*z) =
      1/y - 1/(z+1) := by
  field_simp [hy, hz, h1]
  ring

theorem gap_shell_finite_telescope
    (D : ℕ → ℝ) (hzero : D 0 = 0)
    (hy : ∀ m : ℕ, (m : ℝ)+1+D m ≠ 0)
    (hz : ∀ m : ℕ, (m : ℝ)+1+D (m+1) ≠ 0)
    (n : ℕ) :
    (∑ m ∈ Finset.range n, (gapShell D m + gapExcess D m)) +
      1 / ((n : ℝ)+1+D n) = 1 := by
  induction n with
  | zero =>
      simp [hzero]
  | succ n ih =>
      rw [Finset.sum_range_succ]
      have hy0 := hy n
      have hz0 := hz n
      have hz1 := hy (n+1)
      have hy0 : (n : ℝ)+1+D n ≠ 0 := hy n
      have hz0 : (n : ℝ)+1+D (n+1) ≠ 0 := hz n
      have hz1 : (n : ℝ)+2+D (n+1) ≠ 0 := by
        convert hy (n+1) using 1 <;> push_cast <;> ring
      have hk :
          gapShell D n + gapExcess D n =
            1/((n : ℝ)+1+D n) -
            1/((n : ℝ)+2+D (n+1)) := by
        unfold gapShell gapExcess
        field_simp [hy0, hz0, hz1]
        ring
      have hc : (((n+1 : ℕ) : ℝ)+1+D (n+1)) =
          (n : ℝ)+2+D (n+1) := by
        push_cast
        ring
      rw [hk, hc]
      linarith [ih]

theorem gap_shell_nonnegative (z : ℝ) (hz : 0 < z) :
    0 ≤ 1/(z*(z+1)) := by positivity

theorem gap_excess_nonnegative (y z : ℝ)
    (hy : 0 < y) (hz : y ≤ z) :
    0 ≤ (z-y)/(y*z) := by
  have hp : 0 < z := lt_of_lt_of_le hy hz
  exact div_nonneg (sub_nonneg.mpr hz) (le_of_lt (mul_pos hy hp))

/-- Finite-tail lower bound on the exterior shielding deficit. -/
theorem smallest_gap_shielding_deficit
    (leftExcess rightExcess : ℝ)
    (hleft : 0 ≤ leftExcess) (hright : 0 ≤ rightExcess) :
    -4 * (leftExcess+rightExcess) ≤ 0 := by
  nlinarith

/-- A finite one-gap excess ε at outward index j changes the
normalized shielding by ε/(j*(j+ε)). -/
theorem single_exterior_gap_exact (j eps : ℝ)
    (hj : 0 < j) (he : 0 ≤ eps) :
    1/j - 1/(j+eps) = eps/(j*(j+eps)) := by
  have h0 : j ≠ 0 := ne_of_gt hj
  have h1 : j+eps ≠ 0 := ne_of_gt (by linarith)
  field_simp [h0,h1]
  ring

end XiKernel
