import Mathlib

/-!
# Spatial Laguerre heat comparison: sharp necessary log² height scale

At any simple real zero a of H_{1/2},
the canonical product gives
  6 L₂(a)/L₁(a)=6 Σ_{b ≠ a} (a-b)^(-2).
A Jensen inverse-gap argument over N zeros in [R,2R]
and known zero-count N∼R log(R)/(4π) yields
  limsup_{a→∞} c₁(0,a)/(log a)² ≥ 1/8.

This module checks the finite algebraic two-gap and
polynomial lower bounds. The canonical product, Jensen
sum and zero-density asymptotic are analytical inputs
not yet end-to-end formalized in Lean.
-/

namespace XiKernel

theorem two_gap_jensen_polynomial (u v : ℝ) :
    (u+v)^2*(u^2+v^2)-8*u^2*v^2 =
      (u-v)^2*(u^2+4*u*v+v^2) := by
  ring

theorem two_gap_jensen_nonnegative (u v : ℝ)
    (hu : 0 ≤ u) (hv : 0 ≤ v) :
    0 ≤ (u+v)^2*(u^2+v^2)-8*u^2*v^2 := by
  rw [two_gap_jensen_polynomial]
  positivity

theorem zero_gap_necessary_coefficient
    (c lower : ℝ)
    (hc : 6*lower ≤ c) (hl : 0 ≤ lower) :
    0 ≤ c := by
  linarith

theorem log_square_threshold_gate
    (coefficient : ℝ)
    (h : (1/8 : ℝ) ≤ coefficient) :
    ¬ coefficient < 1/8 := by
  linarith

end XiKernel
