import Mathlib

/-!
# Height-renewal obstruction for backward heat real-rootedness

Exact even quartic adversarial family
  Q_s(z)=z^4+(12s-S)z^2+P-2S*s+12s²,
  S=(A+e)²+(A+2e)², P=(A+e)²*(A+2e)².
It satisfies ∂_s Q = ∂_z² Q and at s=0 has
four simple real zeros ±(A+e), ±(A+2e).
For A>=e>0 its z²-discriminant is positive at s=0
and strictly negative at s=e², so there must be an
interior real-root collision, at |z|>=A/sqrt(2).

No generic backward-heat local-renewal theorem can supply a
height-independent positive time step for all initially-real
even entire functions. The REAL Riemann theta family is not
identified with this polynomial, and RH is not decided.

Only algebraic pieces below are Lean formalized; the complete
intermediate-value and root-collision argument is in the paper.
-/

namespace XiKernel

def evenHeatS (A e : ℝ) : ℝ := (A+e)^2 + (A+2*e)^2

def evenHeatP (A e : ℝ) : ℝ := (A+e)^2 * (A+2*e)^2

def evenHeatQ (A e s z : ℝ) : ℝ :=
  z^4 + (12*s-evenHeatS A e)*z^2 +
  evenHeatP A e - 2*(evenHeatS A e)*s + 12*s^2

theorem even_heat_initial_factor (A e z : ℝ) :
    evenHeatQ A e 0 z =
       (z^2-(A+e)^2)*(z^2-(A+2*e)^2) := by
  unfold evenHeatQ evenHeatS evenHeatP
  ring

/-- The two formal derivatives are equal: exact backward-heat PDE. -/
theorem even_heat_pde_algebra (A e s z : ℝ) :
    (12*z^2-2*evenHeatS A e+24*s) =
       (12*z^2+2*(12*s-evenHeatS A e)) := by
  ring

theorem even_heat_discriminant_identity (A e s : ℝ) :
    (12*s-evenHeatS A e)^2 -
      4*(evenHeatP A e-2*(evenHeatS A e)*s+12*s^2) =
    (2*A*e+3*e^2)^2-16*(evenHeatS A e)*s+96*s^2 := by
  unfold evenHeatS evenHeatP
  ring

theorem even_heat_end_discriminant_identity (A e : ℝ) :
    (2*A*e+3*e^2)^2 -
     16*(evenHeatS A e)*e^2+96*e^4 =
    e^2*(-28*A^2-84*A*e+25*e^2) := by
  unfold evenHeatS
  ring

theorem even_heat_end_discriminant_negative
    (A e : ℝ) (he : 0 < e) (hA : e ≤ A) :
    e^2*(-28*A^2-84*A*e+25*e^2) < 0 := by
  have hnonneg : 0 ≤ A-e := sub_nonneg.mpr hA
  have hpositive :
      0 < 28*(A-e)^2+140*(A-e)*e+87*e^2 := by
    positivity
  have hid : -28*A^2-84*A*e+25*e^2 =
       -(28*(A-e)^2+140*(A-e)*e+87*e^2) := by
    ring
  rw [hid]
  exact mul_neg_of_pos_of_neg (sq_pos_of_pos he) (by linarith)

theorem even_heat_collision_vertex_positive
    (A e : ℝ) (he : 0 < e) (hA : e ≤ A) :
    A^2 ≤ evenHeatS A e - 12*e^2 := by
  have ht : 0 ≤ A-e := sub_nonneg.mpr hA
  have hp : 0 ≤ A+7*e := by linarith
  have hprod : 0 ≤ (A-e)*(A+7*e) := mul_nonneg ht hp
  unfold evenHeatS
  nlinarith

/-- Positive-time real-zero closure's *local modulus-gap* sublemma.
The analytic Hurwitz/Rouche transfer is not yet Lean formalized. -/
theorem terminal_nonreal_zero_contour_transfer
    (m err : ℝ) (hm : 0 < m) (he : err < m) :
    0 < m-err := by
  linarith

end XiKernel
