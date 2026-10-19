import Mathlib

/-!
# Xi-kernel polynomial certificates
Algebraic sublemmas only. This file does NOT formalize the Jacobi-theta
series tail estimate, its interval arithmetic, or the Riemann hypothesis.
-/

namespace XiKernel

def p0 (t : ℝ) : ℝ := t^2 + 22*t + 241
def p1 (t : ℝ) : ℝ := t^2 + 22*t + 1

/-- The first polynomial two-cycle in the Gaussian--quartic example. -/
theorem small_cycle_first (t : ℝ) :
    (2*t + 22)^2 - 2*p0 t = 2*p1 t := by
  unfold p0 p1
  ring

theorem small_cycle_second (t : ℝ) :
    (2*t + 22)^2 - 2*p1 t = 2*p0 t := by
  unfold p0 p1
  ring

theorem small_p0_pos (t : ℝ) (ht : 0 ≤ t) : 0 < p0 t := by
  unfold p0
  positivity

theorem small_p1_pos (t : ℝ) (ht : 0 ≤ t) : 0 < p1 t := by
  unfold p1
  positivity

/-- Algebraic numerator of the strong-log-concavity estimate. -/
theorem quartic_concavity_identity (u : ℝ) :
  ((u^4 + 22*u^2 + 241)^2)/4 -
  (u^4 + 22*u^2 + 241)*(12*u^2+44) +
  (4*u^3+44*u)^2 =
  u^8/4+15*u^6+(571/2)*u^4+727*u^2+15665/4 := by
  ring

theorem quartic_concavity_positive (u : ℝ) :
   0 < u^8/4+15*u^6+(571/2)*u^4+727*u^2+15665/4 := by
  positivity

/-- The original larger Gaussian--quartic example. -/
def bigP0 (t : ℝ) : ℝ := 16*t^2 + 1848*t + 62161
def bigP1 (t : ℝ) : ℝ := 16*t^2 + 1848*t + 44561

theorem big_cycle_first (t : ℝ) :
    (32*t + 1848)^2 - 32*bigP0 t = 32*bigP1 t := by
  unfold bigP0 bigP1
  ring

theorem big_cycle_second (t : ℝ) :
    (32*t + 1848)^2 - 32*bigP1 t = 32*bigP0 t := by
  unfold bigP0 bigP1
  ring

theorem big_p0_pos (t : ℝ) (ht : 0 ≤ t) : 0 < bigP0 t := by
  unfold bigP0
  positivity

theorem big_p1_pos (t : ℝ) (ht : 0 ≤ t) : 0 < bigP1 t := by
  unfold bigP1
  positivity

theorem big_concavity_bound (u : ℝ) :
    0 < (32593/8 : ℝ) + 39*u^2 + 2*u^4 := by
  positivity

/-- Explicit nonreal complex root of the large example's Fourier polynomial. -/
theorem large_fourier_complex_zero :
    ((16*((4 : ℂ) + Complex.I/4)^2 - 255)^2 + 1024) = 0 := by
  calc
    ((16*((4 : ℂ) + Complex.I/4)^2 - 255)^2 + 1024) =
        (Complex.I^2 + 1)*(Complex.I^2 + 64*Complex.I + 1025) := by ring
    _ = 0 := by rw [Complex.I_sq]; ring

/-- The first Fourier-side Laguerre expression is strictly negative at x = 2
    for the small example: L_1[F](2) = -3278*exp(-8). -/
theorem small_transform_laguerre_arithmetic :
    (-32 : ℤ)^2 - 9*496 + 2*9^2 = -3278 := by
  norm_num

end XiKernel
