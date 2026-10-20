import Mathlib

/-!
# Quantitative error stability for a spatial Laguerre heat comparison.

The manuscript proves by parabolic maximum principle that if
   (∂s - (1/2)∂xx + c)U >= -epsilon, c>=0, U(0)>=0
on the full line, then U(s,x) >= -s*epsilon.
On a finite rectangle with boundary U>=-b:
   U(s,x) >= -b - s*epsilon.

A more precise nonconstant forcing theorem gives
U >= -(P * epsilon)(s,x). These Lean results certify
finite rational/algebraic barriers and a sharp collision
countertest, NOT the full parabolic maximum principle,
theta integrals, or Riemann hypothesis.
-/
namespace XiKernel

theorem defect_global_barrier_algebra
    (u s error : ℝ)
    (hu : 0 ≤ u+s*error) :
    -(s*error) ≤ u := by linarith

theorem defect_rectangle_barrier_algebra
    (u s error boundary : ℝ)
    (hu : 0 ≤ u+boundary+s*error) :
    -boundary-s*error ≤ u := by linarith

theorem defect_barrier_supersolution_algebra
    (c boundary s error : ℝ)
    (hc : 0 ≤ c) (hb : 0 ≤ boundary)
    (hs : 0 ≤ s) (he : 0 ≤ error) :
    0 ≤ c*(boundary+s*error) := by positivity

/-- An explicit zero collision blocks any uniformly vanishing
spatial comparison defect with locally bounded coefficients. -/
theorem quadratic_collision_exact_defect (c : ℝ) :
    6 - c*(2*0^2+4*0) = 6 := by ring

theorem quadratic_collision_local_defect
    (C c value : ℝ)
    (hC : 0 ≤ C) (hc : 0 ≤ c) (hcap : c ≤ C)
    (hval : 0 ≤ value)
    (hsmall : value*(1+C) ≤ 1) :
    5 ≤ 6 - c*value := by
  have hden : 0 < 1+C := by linarith
  have h1 : c*value ≤ C*value :=
    mul_le_mul_of_nonneg_right hcap hval
  have h2 : C*value ≤ (1+C)*value := by
    nlinarith [hval]
  nlinarith [h1,h2,hsmall]

theorem defect_to_zero_exclusion_margin
    (anchor totalNegative : ℝ)
    (ha : 0 < anchor) (hne : totalNegative < anchor) :
    0 < anchor - totalNegative := by linarith

end XiKernel
