import Mathlib

/-!
# Genuine theta Laguerre high-order compact-frequency concentration

Analytic theorem (paper/theta_high_order_compact.tex):
For every X<infinity and genuine heat time t in [0,1/2],
L_n[H_t](x)>0 for all n sufficiently large, uniformly |x|<=X.

The proof uses a positive two-variable theta pair measure,
large-difference concentration, and an elementary conditional
variance inequality from strong curvature at large separation.

This Lean module checks only the algebraic gates, not the theta
convolution, limit, conditional integration by parts, or RH.
-/

namespace XiKernel

/-- Exact two-variable potential for a quartic positive-control
kernel: the pair's sum coordinate is strongly confined whenever
the difference coordinate is large. -/
theorem quartic_pair_potential (w d : ℝ) :
    ((w+d)/2)^4 + ((w-d)/2)^4 =
      (w^4+6*w^2*d^2+d^4)/8 := by
  ring

/-- A lower bound for the quartic conditional curvature. -/
theorem quartic_conditional_curvature (w d : ℝ) :
    (3/2:ℝ)*(w^2+d^2) ≥ (3/2)*d^2 := by
  nlinarith [sq_nonneg w]

/-- The finite-slab second-moment budget derived from conditioning
on a large difference variable. -/
theorem large_difference_variance_budget
    (p B invCurv q : ℝ)
    (hp : 0 ≤ p) (hp1 : p ≤ q)
    (hB : 0 ≤ B) (hcurv : 0 ≤ invCurv) :
    B*p + invCurv ≤ B*q + invCurv := by
  nlinarith

/-- Cosine's elementary lower bound yields a strictly positive
Laguerre coefficient when the pair sum has sufficiently small
second moment. -/
theorem compact_frequency_cosine_gate
    (x X moment : ℝ)
    (hx : x^2 ≤ X^2)
    (hm : 0 ≤ moment)
    (hsmall : X^2*moment < 2) :
    0 < 1 - x^2*moment/2 := by
  have h := mul_le_mul_of_nonneg_right hx hm
  linarith

theorem compact_frequency_laguerre_gate
    (A x X moment : ℝ)
    (hA : 0 < A)
    (hx : x^2 ≤ X^2)
    (hm : 0 ≤ moment)
    (hsmall : X^2*moment < 2) :
    0 < A*(1 - x^2*moment/2) := by
  have hg := compact_frequency_cosine_gate x X moment hx hm hsmall
  exact mul_pos hA hg

/-- A sufficiently small combination of compact-separation
probability and large-separation curvature proves the sign gate. -/
theorem conditional_variance_compact_gate
    (X B p invCurv : ℝ)
    (hX : 0 ≤ X) (hB : 0 ≤ B)
    (hp : 0 ≤ p) (hcurv : 0 ≤ invCurv)
    (hs : X^2*(B*p+invCurv) < 2) :
    0 < 1 - X^2*(B*p+invCurv)/2 := by
  linarith

/-- Conditional domination for source coefficients on a compact
interval follows only *after* positive denominators are established;
it is not an RH proof by renaming the ratio. -/
theorem proved_positive_ratio_comparison
    (current next k : ℝ)
    (hc : 0 < current)
    (hk : 0 ≤ k) :
    k*next ≤ (k*max next 0/current)*current := by
  have hcur : current ≠ 0 := ne_of_gt hc
  rw [div_mul_cancel₀ _ hcur]
  have h : next ≤ max next 0 := le_max_left _ _
  exact mul_le_mul_of_nonneg_left h hk

end XiKernel
