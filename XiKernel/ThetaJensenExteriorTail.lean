import Mathlib

/-!
# All-complex-zero theta exterior tail: exact scalar gates

The companion paper proves an explicit Jensen bound for the Riemann theta
heat transform and a dyadic zero-shell interaction estimate. This file
covers elementary REAL and RATIONAL inequalities only. It does NOT
formalize the Jacobi theta Fourier integral, Jensen's formula, counting
zeros of holomorphic functions, convergence of an infinite zero sum,
the all-height global zero dynamics, or the Riemann hypothesis.

No axioms or sorry are introduced. CI build status must be checked.
-/

namespace XiKernel

theorem theta_quartic_kernel_polynomial (u : ℝ) (hu : 0 ≤ u) :
    9*u + u^4 -
        (3/2 : ℝ) * (1 + 4*u + 8*u^2 + (32/3)*u^3 + (32/3)*u^4)
      ≤ -21/16 := by
  have h3 : 0 ≤ u^3 := pow_nonneg hu _
  have h4 : 0 ≤ u^4 := pow_nonneg hu _
  nlinarith [sq_nonneg (u - (1/8 : ℝ))]

theorem theta_half_heat_quartic (u : ℝ) :
    (1/2 : ℝ)*u^2 - (1/2)*u^4 ≤ 1/8 := by
  nlinarith [sq_nonneg (u^2 - (1/2 : ℝ))]

theorem theta_kernel_q4_power_series :
    (3/8 : ℚ) *
        (1 + 11*(3/8) + 11*(3/8)^2 + (3/8)^3) /
        (1 - (3/8))^5 = 82632/3125 := by
  norm_num

theorem theta_kernel_constant_529 :
    (20 : ℚ) * (82632/3125) < 529 := by
  norm_num

theorem theta_kernel_constant_605 :
    (529 : ℚ) * (8/7) < 605 := by
  norm_num

theorem theta_shell_denominator_gate (d R : ℝ)
    (hd : 0 ≤ d) (hR : 0 ≤ R) (h : d ≤ R) :
    (3/4 : ℝ)*R^2 ≤ R^2 - d^2/4 := by
  have hp : 0 ≤ (R-d)*(R+d) :=
    mul_nonneg (sub_nonneg.mpr h) (add_nonneg hR hd)
  nlinarith

theorem theta_shell_count_coefficients (A B x : ℝ) :
    (4/3 : ℝ) * ((4/3)*A*x^2 + 2*B*x) =
      (16/9)*A*x^2 + (8/3)*B*x := by
  ring

theorem theta_shell_lattice_m5 :
    (2/5 : ℚ) ≤ (16/9)*2/(11/2)^2 + (8/3)*2/(11/2) := by
  norm_num

theorem theta_shell_complex_quartet :
    (176/377 : ℚ) ≤ (16/9)*4 := by
  norm_num

theorem theta_upper_margin (error upper : ℝ)
    (h : error ≤ upper) (hupper : upper < 1) : error < 1 := by
  linarith

#print axioms theta_quartic_kernel_polynomial
#print axioms theta_half_heat_quartic
#print axioms theta_shell_denominator_gate
#print axioms theta_shell_count_coefficients
#print axioms theta_shell_complex_quartet

end XiKernel
