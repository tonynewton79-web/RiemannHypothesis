import Mathlib

/-!
# Moving theta contours: rational boundary-crossing gates

This file formalizes only exact rational bounds and elementary consequences
of ASSUMED interval enclosures. It does NOT formalize Jacobi theta
quadrature, the Fourier integration-by-parts decay theorem, the complex
argument principle, or RH.
-/
namespace XiKernel

private def thetaSimpsonError (n : ℚ) : ℚ :=
  (3/2) * (3/(2*n))^4 * 1300000/180 + 1/(10^17)

theorem theta_moving_time_order :
    (599 : ℚ)/5000 < 3/25 := by norm_num

theorem theta_moving_fourth_derivative_budget :
    (1293865 : ℚ) < 1300000 := by norm_num

theorem theta_moving_simpson_6000 :
    thetaSimpsonError 6000 < 1/(10^10) := by
  norm_num [thetaSimpsonError]

theorem theta_moving_simpson_12000 :
    thetaSimpsonError 12000 < 1/(10^11) := by
  norm_num [thetaSimpsonError]

theorem theta_moving_certified_positive
    (h : ℝ) (hh : (36:ℝ)/10^10 < h) : 0 < h := by
  linarith

theorem theta_moving_certified_negative
    (h : ℝ) (hh : h < -(64:ℝ)/10^10) : h < 0 := by
  linarith

theorem moving_zero_velocity
    (first second v : ℝ)
    (hfirst : first ≠ 0)
    (hbalance : first * v = second) :
    v = second / first := by
  apply (eq_div_iff hfirst).2
  simpa [mul_comm] using hbalance

theorem moving_mesh_margin (a e : ℝ)
    (h : e < a) : 0 < a - e := by
  linarith

#print axioms theta_moving_time_order
#print axioms theta_moving_simpson_6000
#print axioms theta_moving_simpson_12000
#print axioms moving_zero_velocity

end XiKernel
