import Mathlib

/-!
# Central-point Duhamel and negative-witness algebra

The genuine theta heat flow is defined in the accompanying
paper/central_duhamel_penalty_attack.tex. The strictly positive
heat-kernel argument makes bounded penalty at x=0 for every
Laguerre order equivalent to RH.

This module formalizes only the finite algebraic budget and
rectangle-witness gates. It does NOT formalize the Gaussian
integration, all-order Laguerre-Pólya theorem, or RH.
-/

namespace XiKernel

/-- The normalized penalty is uniformly dominated by its
C-scaled negative part and a bounded source term. -/
theorem central_penalty_budget_lower
    (C N T M J : ℝ)
    (h : C*N-T*M ≤ J) :
    C*N ≤ J+T*M := by
  linarith

/-- The same comparison gives a direct lower bound on any
hypothetical negative-mass witness. -/
theorem central_penalty_negative_witness
    (C N T M J alpha : ℝ)
    (hN : alpha ≤ N)
    (hC : 0 ≤ C)
    (hJ : C*N-T*M ≤ J) :
    C*alpha-T*M ≤ J := by
  nlinarith [mul_nonneg hC (sub_nonneg.mpr hN)]

/-- If the heat-time and space losses each consume at most
one quarter of the negative margin, half remains. -/
theorem negative_box_margin
    (delta temporal spatial u : ℝ)
    (ht : temporal ≤ delta/4)
    (hs : spatial ≤ delta/4)
    (hu : u ≤ -delta+temporal+spatial) :
    u ≤ -delta/2 := by
  linarith

/-- The all-order scalar observation
b_n=1+T*(A_n+M_n) normalizes every term so its
finite-C value is at most 1+C. -/
theorem scalar_penalty_term_bound
    (T A M C J : ℝ)
    (hT : 0 ≤ T) (hA : 0 ≤ A) (hM : 0 ≤ M)
    (hC : 0 ≤ C) (hJ : J ≤ T*(M+C*A)) :
    J/(1+T*(A+M)) ≤ 1+C := by
  have hden : 0 < 1+T*(A+M) := by positivity
  apply (div_le_iff₀ hden).2
  have hgap : 0 ≤ 1+C+T*(A+C*M) := by positivity
  nlinarith

/-- For a single order, bounded central penalty at arbitrarily
large C is inconsistent with a fixed positive smoothed negative
mass. The limit step is analytic, not this elementary inequality. -/
theorem central_penalty_growth_gate
    (C N T M J B : ℝ)
    (hC : 0 < C) (hN : 0 ≤ N)
    (hJ : C*N-T*M ≤ J) (hB : J ≤ B) :
    N ≤ (B+T*M)/C := by
  apply (le_div_iff₀ hC).2
  linarith

end XiKernel
