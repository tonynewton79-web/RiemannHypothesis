import Mathlib

/-!
# An affine moving-frame algebra check for backward heat flow

Only exact algebra and one rational polynomial example are covered.
This is not an analytic theta-integral, zero-counting, or RH proof.
-/

namespace XiKernel

theorem affine_constant_jet (A B : ℝ) (hA : A ≠ 0) :
    B + (-B / A) * A = 0 := by
  field_simp [hA]
  ring

theorem affine_linear_jet (A B C : ℝ) (hA : A ≠ 0) :
    C + (-B / A) * B + ((B / A)^2 - C / A) * A = 0 := by
  field_simp [hA]
  ring

private def quadraticSeed (z : ℝ) : ℝ := z^2 - 3*z + 2
private def quadraticHeat (s z : ℝ) : ℝ := quadraticSeed z + 2*s

theorem affine_quadratic_identity (s w : ℝ) :
    quadraticHeat s (1 + 2*s + (1 + 4*s)*w) - quadraticSeed (1+w) =
      8*s*w^2 + 4*s^2*(1+2*w)^2 := by
  unfold quadraticSeed quadraticHeat
  ring

theorem affine_quadratic_margin :
    (8:ℚ)*(1/100)*(1/4)^2+4*(1/100)^2*(1+2*(1/4))^2 <
       (1/4)*(1-(1/4)) := by
  norm_num

#print axioms affine_constant_jet
#print axioms affine_linear_jet
#print axioms affine_quadratic_identity
#print axioms affine_quadratic_margin

end XiKernel
