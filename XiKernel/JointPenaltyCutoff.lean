import Mathlib

/-!
# Joint theta cutoff and penalty: exact algebraic error gates

For the genuine heat-deformed Riemann theta kernel,
|E_(n,C)^M - E_(n,C)| <= T*C*D_n*q*exp(-q+1/16).
The analytic theta moment majorants are in
paper/theta_heat_specific_tail.tex and
paper/central_duhamel_penalty_attack.tex.

The explicit rule q>=2 log(exp(1/16)*(1+C)*(1+T*D_n))
and q>=12 makes this difference strictly <1.

This module only kernel-checks the polynomial-rational gates.
It does NOT formalize the logarithm/exponential estimates,
infinite theta series or the RH-equivalent boundedness claim.
-/

namespace XiKernel

theorem adaptive_penalty_denominator_identity (T C D : ℝ) :
    (1+C)*(1+T*D)-T*C*D = 1+C+T*D := by
  ring

theorem adaptive_penalty_strict_ratio
    (T C D : ℝ)
    (hT : 0 ≤ T) (hC : 0 ≤ C) (hD : 0 ≤ D) :
    T*C*D < (1+C)*(1+T*D) := by
  have h : 0 < 1+C+T*D := by positivity
  nlinarith [adaptive_penalty_denominator_identity T C D]

theorem adaptive_penalty_unit_error
    (T C D eps : ℝ)
    (hT : 0 ≤ T) (hC : 0 ≤ C) (hD : 0 ≤ D)
    (heps : 0 ≤ eps)
    (hsmall : eps*(1+C)*(1+T*D) ≤ 1) :
    T*C*D*eps < 1 := by
  have hden : 0 < (1+C)*(1+T*D) := by positivity
  have hscaled : T*C*D*eps <
      (1+C)*(1+T*D)*eps := by
    have h := adaptive_penalty_strict_ratio T C D hT hC hD
    by_cases he0 : eps = 0
    · simp [he0]
      positivity
    · exact mul_lt_mul_of_pos_right h (lt_of_le_of_ne heps (Ne.symm he0))
  have hupper : (1+C)*(1+T*D)*eps ≤ 1 := by
    nlinarith [hsmall]
  linarith

/-- An absolute error bounded by one transfers
uniform boundedness of nonnegative penalties. -/
theorem uniform_penalty_transfer
    (actual truncated budget : ℝ)
    (hbound : actual ≤ budget)
    (hdiff : truncated-actual ≤ 1) :
    truncated ≤ budget+1 := by
  linarith

end XiKernel
