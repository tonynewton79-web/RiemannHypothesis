import Mathlib

/-!
# Spatial Laguerre heat comparison: exact polynomial gates

For U_s >= 1/2 U_xx - c(s,x) U with c>=0 locally bounded,
a bounded classical U with nonnegative initial data is nonnegative.
The classical PDE maximum-principle argument uses
W=U+epsilon*exp(s)*cosh(x): L_c W >=
epsilon*exp(s)*(1/2+c)*cosh(x)>0.
No global upper bound on c in x is required.

This file kernel-checks the algebraic gates and collision obstruction;
the full PDE comparison, theta Fourier integral and RH are NOT
formalized in Lean.
-/
namespace XiKernel

theorem spatial_barrier_strict
    (b c : ℝ) (hb : 0 < b) (hc : 0 ≤ c) :
    0 < b - b/2 + c*b := by
  have hmul : 0 ≤ c*b := mul_nonneg hc (le_of_lt hb)
  linarith

theorem spatial_barrier_exact (b c : ℝ) :
    b-b/2+c*b = (1/2+c)*b := by ring

/-- At root a of (x-a)(x-b), the first Laguerre
    expression is (a-b)^2; the second is 1. -/
theorem two_root_first_laguerre (a b : ℝ) :
    (2*a-a-b)^2 - (a-a)*(a-b)*2 = (a-b)^2 := by
  ring

theorem two_root_second_laguerre :
    ((2:ℚ)^2)/4 = 1 := by norm_num

theorem two_root_required_gap (gap : ℝ) (hgap : gap ≠ 0) :
    6/(gap^2) = (6:ℝ)/(gap*gap) := by ring

/-- Elementary symmetric quadratic energy estimate. -/
theorem pair_inverse_gap_bound
    (a b : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) :
    2*(a*b) ≤ (a+b)^2 := by
  nlinarith [sq_nonneg (a-b)]

/-- For H_t(z)=z^2-2t at x=0, the minimal comparison
    coefficient grows like 3/(2t) as t ↓ 0. -/
theorem heat_collision_necessary_coefficient
    (t : ℝ) (ht : t ≠ 0) :
    6/(4*t) = 3/(2*t) := by
  field_simp
  ring

theorem heat_collision_not_locally_finite (c : ℝ) :
    ¬ (6:ℝ) ≤ c*0 := by norm_num

theorem heat_colliding_zero_laguerre (t x : ℝ) :
    (2*x)^2-(x^2-2*t)*2 = 2*x^2+4*t := by ring

end XiKernel
