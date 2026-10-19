import Mathlib

/-!
# Moment-side certificates for the generalized Laguerre hierarchy

This module is **not** a proof of the Riemann hypothesis.
It proves exact finite-sum consequences of strictly positive even
moments. The identification of these abstract moments with
Jacobi-theta integrals requires separate analytic lemmas.
-/

namespace XiKernel

/-- Even-moment binomial contraction of the central generalized
Laguerre integral, before the positive factorial normalization. -/
noncomputable def centerMoment (M : ℕ → ℝ) (n : ℕ) : ℝ :=
  ∑ k ∈ Finset.range (n + 1),
    (Nat.choose (2 * n) (2 * k) : ℝ) * M (2 * k) * M (2 * (n - k))

/-- Positive even moments force the entire generalized Laguerre
hierarchy to be positive *at the central point*. This is a
universal obstruction to proving RH from central tests alone. -/
theorem centerMoment_pos (M : ℕ → ℝ) (n : ℕ)
    (hM : ∀ j : ℕ, 0 < M (2 * j)) :
    0 < centerMoment M n := by
  unfold centerMoment
  apply Finset.sum_pos
  · intro k hk
    have hk' : k ≤ n := by
      simp only [Finset.mem_range] at hk
      omega
    have hc : 0 < (Nat.choose (2 * n) (2 * k) : ℝ) := by
      exact_mod_cast Nat.choose_pos (by omega : 2 * k ≤ 2 * n)
    exact mul_pos (mul_pos hc (hM k)) (hM (n - k))
  · simp

/-- An elementary quantitative local-positivity gate:
if 2A > x²B, the quadratic correlation minorant is positive. -/
theorem correlation_quadratic_gate (A B x : ℝ)
    (h : x ^ 2 * B < 2 * A) :
    0 < A - x ^ 2 * B / 2 := by
  linarith

/-- The order-one central moment for even kernels is M₀M₂. -/
theorem order_one_central (M0 M2 : ℝ) :
  (M0 * M2 + M2 * M0) / 2 = M0 * M2 := by
  ring

/-- The quadratic-weighted second moment for L₁ is
M₀M₄ - M₂², an exact algebraic identity. -/
theorem order_one_second_weight (M0 M2 M4 : ℝ) :
  (M0 * M4 + M4 * M0 - 2 * M2 ^ 2) / 2 =
    M0 * M4 - M2 ^ 2 := by
  ring

/-- Bounded central-variance gate, conditional on real moment bounds. -/
theorem order_one_explicit_band
    (M0 M2 M4 x : ℝ)
    (h : x ^ 2 * (M0 * M4 - M2 ^ 2) < 2 * (M0 * M2)) :
    0 < M0 * M2 -
      x ^ 2 * (M0 * M4 - M2 ^ 2) / 2 := by
  linarith

end XiKernel
