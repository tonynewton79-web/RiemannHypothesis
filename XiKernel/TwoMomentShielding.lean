import Mathlib

/-!
# Two-moment nonlinear contour shielding: exact rational gates

For the positive Jacobi theta heat-weight w_Y(u),
  A = ∫ w_Y, M = ∫ u² w_Y,
the contour perturbation under backward time τ satisfies

  B(τ) ≤ A*(1-exp(-τ*M/A))
       ≤ 2*A*τ*M/(2*A+τ*M) ≤ τ*M.

The first inequality is Jensen, equality for an atomic measure.
The second is the elementary exponential Padé inequality.

We formally check only the rational implications and a strict
counterexample to the old *linear* threshold, not the theta integral,
Jensen in measure-theoretic form, Rouché, or any claim of RH.
-/

namespace XiKernel

theorem pade_theta_den_pos (A M tau : ℝ)
    (hA : 0 < A) (hM : 0 ≤ M) (ht : 0 ≤ tau) :
    0 < 2*A+tau*M := by
  positivity

theorem pade_theta_below_linear (A M tau : ℝ)
    (hA : 0 < A) (hM : 0 ≤ M) (ht : 0 ≤ tau) :
    (2*A*tau*M)/(2*A+tau*M) ≤ tau*M := by
  have hd := pade_theta_den_pos A M tau hA hM ht
  apply (div_le_iff₀ hd).2
  have hprod : 0 ≤ (tau*M)^2 := sq_nonneg (tau*M)
  nlinarith

theorem pade_theta_strictly_below_linear (A M tau : ℝ)
    (hA : 0 < A) (hM : 0 < M) (ht : 0 < tau) :
    (2*A*tau*M)/(2*A+tau*M) < tau*M := by
  have hden : 0 < 2*A+tau*M := by positivity
  apply (div_lt_iff₀ hden).2
  have hp : 0 < (tau*M)^2 := sq_pos_of_pos (mul_pos ht hM)
  nlinarith

theorem two_moment_independent_contour_gate
    (A M m tau : ℝ)
    (hA : 0 < A) (hM : 0 ≤ M) (ht : 0 ≤ tau)
    (hbudget : tau*M*(2*A-m) < 2*A*m) :
    (2*A*tau*M)/(2*A+tau*M) < m := by
  have hd := pade_theta_den_pos A M tau hA hM ht
  apply (div_lt_iff₀ hd).2
  nlinarith [hbudget]

theorem exact_two_moment_example_linear_fails :
    (6 : ℚ) < (2/5)*20 := by
  norm_num

theorem exact_two_moment_example_pade_succeeds :
    ((2*10*(2/5)*20)/(2*10+(2/5)*20) : ℚ) = 40/7 ∧
    ((40/7 : ℚ) < 6) := by
  constructor <;> norm_num

end XiKernel
