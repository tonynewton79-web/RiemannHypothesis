import Mathlib

/-!
# Open-slab spatial comparison: exact collision-model gates

For the backwards heat polynomial H_t(z)=z²-2t, with t>0,
L₁(t,x)=2x²+4t and L₂(t,x)=1.
The exact spatial comparison coefficient at order n=1 is
c₁(t,x)=3/(x²+2t), and it diverges at (t,x)=(0,0).
Nonetheless L₁(t,x)≥0 right through t=0.

This certifies a crucial distinction:
the parabolic maximum principle needs locally bounded coefficients
on each compact *preterminal* slab, not uniform boundedness up to
the final time. Analytic parabolic comparison and actual Xi
zeta-theory are NOT formalized in this Lean file.
-/

namespace XiKernel

theorem quadratic_collision_heat_equation :
    (-2 : ℝ) = -(2 : ℝ) := by norm_num

theorem quadratic_collision_L1 (t x : ℝ) :
    (2*x)^2 - (x^2-2*t)*2 = 2*x^2+4*t := by ring

theorem quadratic_collision_L2 :
    ((2:ℝ)^2)/4 = 1 := by norm_num

theorem quadratic_collision_positive (t x : ℝ) (ht : 0 < t) :
    0 < 2*x^2 + 4*t := by positivity

theorem quadratic_endpoint_nonnegative (x : ℝ) :
    0 ≤ 2*x^2 := by positivity

theorem quadratic_exact_spatial_comparison
    (t x : ℝ) (ht : 0 < t) :
    (3 / (x^2+2*t))*(2*x^2+4*t) = 6 := by
  have hden : x^2+2*t ≠ 0 := by
    have hsq : 0 ≤ x^2 := sq_nonneg x
    have hp : 0 < x^2+2*t := by linarith
    exact ne_of_gt hp
  field_simp
  ring

theorem collision_coefficient_lower_bound
    (t c : ℝ) (ht : 0 < t)
    (hgate : (6:ℝ) ≤ c * (4*t)) :
    3/(2*t) ≤ c := by
  have hden : 0 < 2*t := by positivity
  apply (div_le_iff₀ hden).2
  nlinarith [hgate]

theorem collision_at_terminal_no_finite_coefficient
    (c : ℝ) : ¬ (6:ℝ) ≤ c * 0 := by norm_num

/-- At multiplicity m≥2, the polynomial model G(z)=z^m
has L_(m-1)(x)=m*x² and L_m(x)=1; at x=0
the adjacent-order inequality is impossible. -/
theorem arbitrary_multiplicity_terminal_obstruction (m : ℕ)
    (hm : 2 ≤ m) (c : ℝ) :
    ¬ ((m:ℝ)*(2*m-1)) ≤ c*0 := by
  have hmp : 0 < (m:ℝ) := by exact_mod_cast (show 0 < m by omega)
  have hfactor : 0 < 2*(m:ℝ)-1 := by
    have : (2:ℝ) ≤ (m:ℝ) := by exact_mod_cast hm
    linarith
  have hprod : 0 < (m:ℝ)*(2*(m:ℝ)-1) := mul_pos hmp hfactor
  norm_num
  linarith

end XiKernel
