import Mathlib

/-!
# Uniform frequency tail: exact polynomial gates

The analytic theorem for the actual theta Fourier representation is
in paper/square_lattice_uniform_fourier.tex. This module formalizes
the rational-polynomial lower margin used for q = pi*m² >= 12 and
the exact simplification of the truncated tail factor.

It does not formalize the full Fourier integral, the incomplete gamma
functions or infinite theta series; those remain analytic proofs in the
accompanying paper. No RH proof is claimed.
-/

namespace XiKernel

theorem square_lattice_tail_margin (q : ℝ) (hq : 12 ≤ q) :
    0 < q^3 - 6*q^2 - 12*q - 12 := by
  have ht : 0 ≤ q - 12 := by linarith
  have hid : q^3 - 6*q^2 - 12*q - 12 =
    (q-12)^3 + 30*(q-12)^2 + 276*(q-12) + 708 := by
    ring
  rw [hid]
  positivity

theorem square_lattice_tail_factor_identity (q : ℝ) (hq : 0 < q) :
    (3*q/2 - (q + 3 + 6/q + 6/q^2))*(2*q^2) =
      q^3 - 6*q^2 - 12*q - 12 := by
  have hne : q ≠ 0 := ne_of_gt hq
  field_simp
  ring

theorem square_lattice_tail_factor (q : ℝ) (hq : 12 ≤ q) :
    q + 3 + 6/q + 6/q^2 < 3*q/2 := by
  have hqpos : 0 < q := by linarith
  have hsq : 0 < 2*q^2 := by positivity
  have hi := square_lattice_tail_factor_identity q hqpos
  have hm := square_lattice_tail_margin q hq
  have : 0 < (3*q/2 - (q + 3 + 6/q + 6/q^2))*(2*q^2) := by
    rw [hi]
    exact hm
  have hdelta : 0 < 3*q/2 - (q + 3 + 6/q + 6/q^2) := by
    exact pos_of_mul_pos_left this (le_of_lt hsq)
  linarith

theorem laguerre_error_constant (n : ℕ) (C E : ℝ)
    (hC : 0 ≤ C) (hE : 0 ≤ E) :
    0 ≤ 2 * ((2*n+1 : ℕ) : ℝ) * C * E := by
  positivity

end XiKernel
