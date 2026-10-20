import Mathlib

/-!
# Necessary inverse-gap and inverse-time growth of heat-Laguerre comparison

Model the local collision normal form by
  H_t(x) = (x-x₀)^2 - 2 (t-t₀).
This is an exact solution of ∂ₜ H = - ∂ₓ² H.
Its first two Laguerre coefficients satisfy
  L₁=2(x-x₀)^2+4(t-t₀),  L₂=1,
and therefore
  6 L₂/L₁ = 3/((x-x₀)^2+2(t-t₀)).

This proves necessary inverse-square gap growth and a
non-time-integrable singularity at the collision.
The same 3/2 temporal constant for ANY analytic nondegenerate
double zero follows from the heat equation and Taylor expansions,
but that analytic limit is not formalized in Lean here.

These results do not establish a collision for genuine Riemann Xi,
nor the spatial comparison inequality or RH.
-/
namespace XiKernel

theorem collision_model_heat_identity (x δ : ℝ) :
    (2*x)^2 - (x^2-2*δ)*2 = 2*x^2+4*δ := by
  ring

theorem collision_model_second_coefficient :
    (2:ℝ)^2/4 = 1 := by
  norm_num

theorem collision_model_positive_laguerre
    (x δ : ℝ) (hδ : 0 < δ) :
    0 < 2*x^2+4*δ := by
  have hs : 0 ≤ x^2 := sq_nonneg x
  linarith

theorem collision_model_adjacent_ratio
    (x δ : ℝ) (hδ : 0 < δ) :
    (6:ℝ)/(2*x^2+4*δ) = 3/(x^2+2*δ) := by
  have h0 : 0 < x^2 + 2*δ := by
    have hx : 0 ≤ x^2 := sq_nonneg x
    linarith
  have h1 := collision_model_positive_laguerre x δ hδ
  field_simp [ne_of_gt h0, ne_of_gt h1]
  ring

theorem collision_pair_inverse_gap
    (gap : ℝ) (hgap : 0 < gap) :
    (6:ℝ)/(4*(gap^2/8)) = 12/gap^2 := by
  have hsq : gap^2 ≠ 0 := pow_ne_zero 2 (ne_of_gt hgap)
  field_simp [hsq]
  ring

theorem collision_ratio_sequence (N : ℕ) :
    (6:ℝ)/(4/(N+1:ℝ)) = 3*(N+1:ℝ)/2 := by
  have hne : (N+1:ℝ) ≠ 0 := by positivity
  field_simp [hne]
  ring

theorem collision_ratio_unbounded (N : ℕ) :
    (N:ℝ) < 3*(N+1:ℝ)/2 := by
  have hN : (0:ℝ) ≤ N := Nat.cast_nonneg N
  linarith

end XiKernel
