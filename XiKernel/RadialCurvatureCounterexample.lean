import Mathlib

/-!
# A globally radially convex potential does not force Fourier Laguerre positivity

The explicit even kernel K(u)=exp(-u^2/2)*(1+cosh(u)/2) has
V''(u) >= 2/3 and V'''(u)>0 for u>0.
Its Fourier transform has the form
sqrt(2*pi)*exp(-z^2/2)*(1+d*cos(z)), d=exp(1/2)/2.
For 1/2<d<1, the first Fourier Laguerre expression is
strictly negative at pi.

This file formally proves the polynomial inequalities and sign gates.
Gaussian integration, the hyperbolic differentiations, and
the transcendental bound 1/2<exp(1/2)/2<1 are stated and proved
in the accompanying manuscript and numerical-independent
analytic regression file; they are not claimed Lean-complete here.
-/

namespace XiKernel

theorem mixture_log_second_gap (c : ℝ) :
    3 * (c^2 + 2*c + 3) - 2*(c+2)^2 = (c-1)^2 := by
  ring

theorem mixture_strong_convexity (c : ℝ) (hc : 1 ≤ c) :
    (2/3 : ℝ) ≤ (c^2 + 2*c + 3)/(c+2)^2 := by
  have hden : 0 < (c+2)^2 := sq_pos_of_pos (by linarith)
  apply (le_div_iff₀ hden).2
  nlinarith [sq_nonneg (c-1)]

theorem mixture_third_curvature_pos (c s : ℝ)
    (hc : 1 < c) (hs : 0 < s) :
    0 < 2*(c-1)*s/(c+2)^3 := by
  have hd : 0 < (c+2)^3 := by positivity
  have hc' : 0 < c-1 := sub_pos.mpr hc
  have hnum : 0 < 2*(c-1)*s := by positivity
  exact div_pos hnum hd

theorem mixture_third_derivative_numerator (c sh : ℝ) :
    (1+c/2)^2 - 3*(c/2)*(1+c/2) + 2*(sh/2)^2 =
    (1-c)/2 + (sh^2-c^2+1)/2 := by
  ring

theorem fourier_laguerre_factor (d : ℝ) :
    2*d^2 - 3*d + 1 = (1-d)*(1-2*d) := by
  ring

theorem fourier_laguerre_failure (d : ℝ)
    (hdhalf : 1/2 < d) (hdone : d < 1) :
    (1-d)*(1-2*d) < 0 := by
  have ha : 0 < 1-d := by linarith
  have hb : 1-2*d < 0 := by linarith
  exact mul_neg_of_pos_of_neg ha hb

theorem fourier_mixture_positive_on_real (d c : ℝ)
    (hd0 : 0 ≤ d) (hd1 : d < 1)
    (hc : -1 ≤ c) :
    0 < 1 + d*c := by
  have hc1 : 0 ≤ c+1 := by linarith
  have hm : 0 ≤ d*(c+1) := mul_nonneg hd0 hc1
  have h : -d ≤ d*c := by nlinarith
  linarith

end XiKernel
