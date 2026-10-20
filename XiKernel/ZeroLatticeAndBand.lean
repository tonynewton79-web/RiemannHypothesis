import Mathlib

/-!
# Genuine theta heat: extended division-free comparison band and zero multiplicities

The *analytical* preconditions are the established moment ratio
 B_n/(2*A_n) < 1/48 and the positive Fourier-correlation measure
for all heat times 0<=t<=1/2 and Laguerre orders n>=1.
They imply U_n>=A_n*(1-x²/48), |U_(n+1)|<=A_(n+1).

We kernel-check the exact algebraic transfer on |x|<sqrt(48),
the closed |x|<=13/2 coefficient 192/23, and the impossibility
of finite spatial comparison at a multiplicity m>=2 real zero.

The infinite theta-integral, heat-flow and canonical-product
identities remain in the analytic manuscript, not formalized here.
-/
namespace XiKernel

theorem thirteen_halves_variance_gate
    (x : ℝ) (hx : |x| ≤ 13/2) :
    (23/192 : ℝ) ≤ 1-x^2/48 := by
  have hl : -(13/2 : ℝ) ≤ x := (abs_le.mp hx).1
  have hr : x ≤ (13/2 : ℝ) := (abs_le.mp hx).2
  have h1 : 0 ≤ x+13/2 := by linarith
  have h2 : 0 ≤ 13/2-x := by linarith
  have hmul := mul_nonneg h1 h2
  nlinarith

theorem extended_band_source_gate
    (A B U V k x : ℝ)
    (hA : 0 < A) (hB : 0 ≤ B) (hk : 0 ≤ k)
    (hx : x^2 < 48)
    (hU : A*(1-x^2/48) ≤ U)
    (hV : V ≤ B) :
    k*V ≤ (k*B/(A*(1-x^2/48)))*U := by
  have hfac : 0 < 1-x^2/48 := by linarith
  have hd : 0 < A*(1-x^2/48) := mul_pos hA hfac
  have hc : 0 ≤ k*B/(A*(1-x^2/48)) := by positivity
  have hupper := mul_le_mul_of_nonneg_left hV hk
  have hlower := mul_le_mul_of_nonneg_left hU hc
  have heq : (k*B/(A*(1-x^2/48)))*(A*(1-x^2/48)) = k*B := by
    field_simp [ne_of_gt hd]
  linarith

theorem thirteen_halves_source_gate
    (A B U V k x : ℝ)
    (hA : 0 < A) (hB : 0 ≤ B) (hk : 0 ≤ k)
    (hx : |x| ≤ 13/2)
    (hU : A*(1-x^2/48) ≤ U)
    (hV : V ≤ B) :
    k*V ≤ ((192/23:ℝ)*(k*B/A))*U := by
  have hgate := thirteen_halves_variance_gate x hx
  have hUpos : A*(23/192:ℝ) ≤ U := by
    calc
      A*(23/192:ℝ) ≤ A*(1-x^2/48) :=
        mul_le_mul_of_nonneg_left hgate (le_of_lt hA)
      _ ≤ U := hU
  have hc : 0 ≤ (192/23:ℝ)*(k*B/A) := by positivity
  have hm := mul_le_mul_of_nonneg_left hV hk
  have hmul := mul_le_mul_of_nonneg_left hUpos hc
  have hid : ((192/23:ℝ)*(k*B/A))*(A*(23/192:ℝ)) = k*B := by
    field_simp [ne_of_gt hA]
    ring
  linarith

/-- At a real zero of multiplicity m>=2, the first nonzero
even Taylor coefficient is a² at order m, while order m-1 is zero.
No finite coefficient, even spatially varying, can satisfy the
source inequality at that point. -/
theorem multiple_real_zero_comparison_impossible
    (m : ℕ) (hm : 2 ≤ m) (a c : ℝ) (ha : a ≠ 0) :
    ¬ ((m:ℝ)*(2*(m:ℝ)-1)*a^2 ≤ c*0) := by
  have hm1 : (1:ℝ) ≤ m := by
    exact_mod_cast (show 1 ≤ m by omega)
  have hp : 0 < a^2 := sq_pos_of_ne_zero ha
  intro h
  have hk : 0 < (m:ℝ)*(2*(m:ℝ)-1) := by positivity
  nlinarith [mul_pos hk hp]

theorem symmetric_two_variable_coefficients
    (u v t : ℝ) :
    t^2*(1+u*t^2)*(1+v*t^2) =
    t^2 + (u+v)*t^4 + (u*v)*t^6 := by
  ring

/-- The two-gap elementary symmetric inequality 2e₂<=e₁². -/
theorem symmetric_two_gap_bound (u v : ℝ) :
    2*(u*v) ≤ (u+v)^2 := by
  nlinarith [sq_nonneg (u-v)]

end XiKernel
