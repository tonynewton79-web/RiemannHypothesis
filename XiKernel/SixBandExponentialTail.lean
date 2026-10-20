import Mathlib

/-!
# Exact rational improvement to the six-band Gaussian heat defect

For the genuine theta heat family, the existing six-band theorem bounds
the positive comparison defect by
k_n A_(n+1)(t) * (x²/12 - 3)_+.

Analytic Gaussian integration with a=15/16 gives the central
integrated upper bound
  k_n * sup_t A_(n+1)(t) * (8/45)*exp(-135/4)
 < k_n * sup_t A_(n+1)(t) / 10^14.

These Lean lemmas prove exact rational constants and algebraic
comparison gates. Gaussian integrals, the genuine theta source
inequality, and exp(3)>20 are analytic inputs to the paper,
not yet end-to-end kernel-checked in Lean. RH remains open.
-/

namespace XiKernel

theorem sixband_exponential_parameter :
    (1:ℚ) / (12 * (15/16)) = 4/45 := by norm_num

theorem sixband_exponential_threshold :
    (15/16:ℚ) * 36 = 135/4 := by norm_num

theorem sixband_gaussian_mgf_endpoint :
    (1:ℚ) - 2*(15/16)*(1/2) = 1/16 := by norm_num

theorem sixband_exponential_integral_constant :
    (1/2:ℚ)*(4/45)*4 = 8/45 := by norm_num

theorem sixband_exponential_rational_tail :
    (8:ℚ) / (45*20^11) < 1/10^14 := by norm_num

theorem sixband_exponential_exact_upper :
    (8:ℚ) / (45*20^11) = 1/1152000000000000 := by norm_num

theorem sixband_exp_weight_identity (x : ℝ) :
    x^2 / 12 - 3 =
      (4/45 : ℝ)*(15/16)*(x^2-36) := by ring

theorem sixband_mgf_domain (h : ℝ)
    (h0 : 0 ≤ h) (hT : h ≤ 1/2) :
    (1/16 : ℝ) ≤ 1-2*(15/16)*h := by
  linarith

/-- The exact positive Gaussian tail bound is not zero:
a strictly positive upper bound cannot prove a vanishing defect. -/
theorem sixband_finite_upper_not_zero :
    (0:ℚ) < 8/(45*20^11) := by norm_num

end XiKernel
