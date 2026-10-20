import Mathlib

/-!
# Dyadic central Duhamel RH defect: algebraic gates

An analytic argument reduces RH to zero of a single nonnegative
infinite sum D of smoothed negative Laguerre masses. With adaptive
theta modes M_n(C) and C=2^k, the finite scalar S_k obeys
|S_k/2^k-D| < 2^(1-k).

Only the finite real-algebraic gates are formalized here:
normalization of each approximation error and its strict
threshold. Gaussian convolution, infinite series, adaptive
theta estimates, and the Laguerre-Pólya/RH equivalence are not
kernel-checked by this module.
-/

namespace XiKernel

theorem dyadic_error_normalization
    (T A M : ℝ)
    (hT : 0 ≤ T) (hA : 0 ≤ A) (hM : 0 ≤ M) :
    (1+T*M)/(1+T*(A+M)) ≤ 1 := by
  have hden : 0 < 1+T*(A+M) := by
    have hprod : 0 ≤ T*(A+M) := mul_nonneg hT (by linarith)
    linarith
  apply (div_le_iff₀ hden).2
  nlinarith [mul_nonneg hT hA]

theorem dyadic_negative_mass_normalization
    (T A M N : ℝ)
    (hT : 0 ≤ T) (hA : 0 ≤ A) (hM : 0 ≤ M)
    (hN : 0 ≤ N) (hn : N ≤ T*A) :
    N/(1+T*(A+M)) < 1 := by
  have hden : 0 < 1+T*(A+M) := by
    have ht : 0 ≤ T*(A+M) := mul_nonneg hT (by linarith)
    linarith
  apply (div_lt_iff₀ hden).2
  nlinarith [mul_nonneg hT hM]

theorem finite_dyadic_RH_refutation_gate (k : ℕ) (S D : ℝ)
    (hbound : |S-((2:ℝ)^k)*D| < 2)
    (hS : 3 < S) :
    0 < D := by
  have hp : 0 < (2:ℝ)^k := by positivity
  have habs : S - (2:ℝ)^k*D < 2 := (abs_lt.mp hbound).2
  have h : 1 < (2:ℝ)^k*D := by linarith
  exact (mul_pos_iff.mp (show 0 < (2:ℝ)^k*D by linarith)).resolve_left (by positivity)

theorem dyadic_limit_separation
    (C D S : ℝ) (hC : 0 < C)
    (happrox : |S-C*D| < 2)
    (hD : 3/C < D) :
    1 < S := by
  have hlow := (abs_lt.mp happrox).1
  have h3 : 3 < C*D := by
    exact (lt_mul_iff₀ hC).2 hD
  linarith

end XiKernel
