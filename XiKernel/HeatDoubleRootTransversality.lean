import Mathlib

/-!
# Double-root crossing in the backward heat equation

At a double real zero of an entire heat flow H_t, suppose
H=H'=0 and H''=a !=0. For the generalized Laguerre coefficients
L1=(H')²-H*H'', L2=H*H''''/12-H'*H'''/3+(H'')²/4
we have L1=0, L2=a²/4 and L1''=a².
The exact heat hierarchy ∂t L1=6L2-L1''/2 gives
∂t L1=a²>0. Hence backward heat evolution immediately produces
negative L1 at the same real x. This is an elementary local
identity, not a statement about whether a double zero occurs
for the true Riemann Xi heat flow, and not RH.
-/
namespace XiKernel

theorem heat_double_zero_laguerre_derivative (a : ℝ) :
    6*(a^2/4) - (a^2/2) = a^2 := by
  ring

theorem heat_double_zero_laguerre_derivative_pos
    (a : ℝ) (ha : a ≠ 0) :
    0 < 6*(a^2/4) - (a^2/2) := by
  rw [heat_double_zero_laguerre_derivative]
  have hsq : 0 ≤ a^2 := sq_nonneg a
  by_contra h
  have hzero : a^2 = 0 := by
    have hh : a^2 ≤ 0 := le_of_not_gt h
    linarith
  have ha0 : a = 0 := (sq_eq_zero_iff).mp hzero
  exact ha ha0

/-- Polynomial entire heat flow H_t(x)=x²-2t solves
∂_tH_t=-∂_x²H_t; its first Laguerre expression is
2x²+4t and becomes negative at x=0 for t<0. -/
theorem heat_quadratic_model_L1 (x t : ℝ) :
    (2*x)^2 - (x^2-2*t)*2 = 2*x^2 + 4*t := by
  ring

theorem heat_quadratic_model_negative (t : ℝ) (ht : t < 0) :
    (2*(0:ℝ))^2 - ((0:ℝ)^2-2*t)*2 < 0 := by
  nlinarith

theorem heat_quadratic_model_positive (t : ℝ) (ht : 0 < t) :
    0 < (2*(0:ℝ))^2 - ((0:ℝ)^2-2*t)*2 := by
  nlinarith

end XiKernel
