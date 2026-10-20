import Mathlib
import XiKernel.ModularOddJet

/-!
# Genuine theta square-lattice mode-pair correlation sign gates

The main mathematical theorem is the analytic formula:
  Fourier(G_n^{mk})(x)
    = (-1)^n (n+1) D_m D_k / x^(2n+4)
      + O(|x|^(-2n-6))  (|x|→∞),
D_m = (πm²) exp(-πm²) (-8(πm²)^2+30πm²-15).

All ordered mode-pair densities are pointwise nonnegative, but
every diagonal Fourier contribution at odd n is eventually negative.
The exact modular cancellation Σ D_m=0 cancels the leading coefficients
in the fully weighted infinite correlation.

This Lean module verifies finite polynomial sign, pair-cancellation and
L1 cross-term identities, NOT the modular sum, Fourier integrals or
asymptotic remainder.
-/
namespace XiKernel

theorem theta_first_mode_polynomial_positive
    (q : ℝ) (hlo : 3 ≤ q) (hhi : q ≤ 22/7) :
    0 < -8*q^2 + 30*q - 15 := by
  have hleft : 0 ≤ (22/7:ℝ) - q := by linarith
  have hright : 0 ≤ 8*(q+(22/7:ℝ))-30 := by linarith
  have hprod := mul_nonneg hleft hright
  nlinarith

theorem theta_higher_mode_polynomial_negative
    (q : ℝ) (hq : 12 ≤ q) :
    -8*q^2+30*q-15 < 0 :=
  higher_square_mode_negative q hq

theorem theta_mixed_odd_mode_positive
    (a b : ℝ) (ha : 0 < a) (hb : b < 0) :
    0 < -2*a*b := by
  have h := mul_neg_of_pos_of_neg ha hb
  nlinarith

theorem theta_diagonal_odd_mode_negative
    (k : ℕ) (D : ℝ) (hD : D ≠ 0) :
    -((2*k+2:ℕ):ℝ)*D^2 < 0 := by
  have hsq : 0 < D^2 := sq_pos_of_ne_zero hD
  have hk : 0 < ((2*k+2:ℕ):ℝ) := by positivity
  nlinarith

theorem theta_modular_two_block_cancellation (A : ℝ) :
    A^2+2*A*(-A)+(-A)^2=0 := by ring

theorem theta_first_order_pair_decomposition
    (f g fp gp fpp gpp : ℝ) :
    (fp+gp)^2-(f+g)*(fpp+gpp) =
      (fp^2-f*fpp)+(gp^2-g*gpp)
      +(2*fp*gp-f*gpp-g*fpp) := by ring

/-- An exact leading-coefficient test for first theta block
    plus its compensating (negative) tail. -/
theorem theta_all_order_leading_cancellation
    (n : ℕ) (A : ℝ) :
    (((n:ℝ)+1)*(A^2+2*A*(-A)+(-A)^2))=0 := by
  rw [theta_modular_two_block_cancellation]
  ring

end XiKernel
