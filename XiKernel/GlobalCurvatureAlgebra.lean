import Mathlib

/-!
# Global Xi theta curvature: exact large-x algebra

All statements are algebraic subclaims. The infinite theta-series
tail bound and the compact directed-interval certificate are still
external analytic/computational inputs; they are not yet
kernel-formalized in Lean.
-/

namespace XiKernel

def curvatureNumerator (x a0 a1 a2 a3 : ℝ) : ℝ :=
  -(x^3)*(a3*a0^2 - 3*a1*a2*a0 + 2*a1^3) -
   3*x^2*(a2*a0^2-a1^2*a0)-x*a1*a0^2

/-- Remove all higher theta summands. The resulting numerator
is x times the leading first-summand cubic. -/
theorem leading_curvature_numerator (x : ℝ) :
    curvatureNumerator x (2*x-3) (-(2*x-5))
      (2*x-7) (-(2*x-9)) =
      x*(8*x^3-36*x^2+42*x-45) := by
  unfold curvatureNumerator
  ring

/-- A fixed positive quartic margin above x=6. -/
theorem leading_large_margin (x : ℝ) (hx : 6 ≤ x) :
    (7/4 : ℝ)*x^4 <
      x*(8*x^3-36*x^2+42*x-45) := by
  have ht : 0 ≤ x-6 := by linarith
  have heq : x*(8*x^3-36*x^2+42*x-45) -
      (7/4 : ℝ)*x^4 =
       (25/4)*(x-6)^4+114*(x-6)^3+
       744*(x-6)^2+1971*(x-6)+1566 := by
    ring
  have hp : 0 < (25/4 : ℝ)*(x-6)^4 +
      114*(x-6)^3+744*(x-6)^2+
      1971*(x-6)+1566 := by
    positivity
  linarith

/-- Elementary tail-vs-leading-margin comparison.
The analytic estimate upstream is |H-H0| ≤
6144*x^4*exp(-3*x)*(162*x²+162*x+27).
The polynomial-exponential factor is decreasing for x≥6,
and e^18>20^6=64,000,000. -/
theorem large_tail_margin :
    (6144:ℝ)*6831/64000000 < 7/4 := by
  norm_num

/-- Exact positive first-summand cubic at x=6. -/
theorem leading_at_six :
    8*(6:ℤ)^3-36*(6:ℤ)^2+42*6-45 = 639 := by
  norm_num

end XiKernel
