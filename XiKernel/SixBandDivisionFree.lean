import Mathlib

/-!
# All-order common six-unit theta heat band (exact algebraic gates)

For the genuine theta heat family on 0 ≤ t ≤ 1/2, let
A_n(t)=L_n[H_t](0)>0 and k_n=(n+1)(2n+1).

Existing two-mode interval moment certificates and analytic theta tails:
mu_0(t) > 1/20, mu_2(t) < 1/1000 + 10^-8.
The rational consequence is mu_2/mu_0 < 1/48.

Newman's GHS/curvature theorem, unchanged under exp(t*u²),
gives B_n/A_n ≤ B_0/A_0=2 mu_2/mu_0.
Therefore U_n(t,x) ≥ A_n(t)(1-x²/48).
For |x|≤6, U_n≥A_n/4 and
  k_n U_(n+1)(t,x) ≤ (4*k_n*A_(n+1)(t)/A_n(t))*U_n(t,x).
The coefficient uses only known positive central moments; it never
divides by the possibly small noncentral U_n(t,x).

Lean formalizes only the exact rational/real algebraic gates.
Infinite theta integral and Newman's theorem are external analytic
inputs; this is NOT a complete Lean proof of RH.
-/

namespace XiKernel

theorem six_band_variance_gate :
    ((1/1000 : ℚ) + 1/10^8) / (1/20) < 1/48 := by
  norm_num

theorem six_band_quarter_gate (x r A u : ℝ)
    (hA : 0 < A) (hr : 0 ≤ r) (hrmax : r ≤ 1/48)
    (hx : x^2 ≤ 36)
    (hu : A * (1 - r*x^2) ≤ u) :
    A/4 ≤ u := by
  have hx0 : 0 ≤ x^2 := sq_nonneg x
  have h1 : r*x^2 ≤ (1/48 : ℝ)*x^2 :=
    mul_le_mul_of_nonneg_right hrmax hx0
  have h2 : (1/48 : ℝ)*x^2 ≤ 3/4 := by
    nlinarith [hx]
  have hm : 1/4 ≤ 1-r*x^2 := by linarith
  have hmA := mul_le_mul_of_nonneg_left hm (le_of_lt hA)
  nlinarith [hmA,hu]

theorem six_band_division_free_source
    (k A B u v : ℝ)
    (hk : 0 ≤ k) (hA : 0 < A) (hB : 0 ≤ B)
    (hu : A/4 ≤ u) (hv : v ≤ B) :
    k*v ≤ (4*k*B/A)*u := by
  have hc : 0 ≤ 4*k*B/A := by positivity
  have hleft := mul_le_mul_of_nonneg_left hv hk
  have hright := mul_le_mul_of_nonneg_left hu hc
  have hident : (4*k*B/A)*(A/4)=k*B := by
    have hAne : A ≠ 0 := ne_of_gt hA
    field_simp [hAne]
    ring
  linarith

theorem six_band_quadratic_defect
    (k A B u v x : ℝ)
    (hk : 0 ≤ k) (hA : 0 < A) (hB : 0 ≤ B)
    (hu : A*(1-x^2/48) ≤ u) (hv : v ≤ B) :
    k*v - (4*k*B/A)*u ≤ k*B*(x^2/12-3) := by
  have hc : 0 ≤ 4*k*B/A := by positivity
  have hleft := mul_le_mul_of_nonneg_left hv hk
  have hright := mul_le_mul_of_nonneg_left hu hc
  have hid : (4*k*B/A)*(A*(1-x^2/48)) =
      4*k*B*(1-x^2/48) := by
    have hAne : A ≠ 0 := ne_of_gt hA
    field_simp [hAne]
    ring
  calc
    k*v-(4*k*B/A)*u ≤ k*B-(4*k*B/A)*(A*(1-x^2/48)) := by
      linarith
    _ = k*B*(x^2/12-3) := by
      rw [hid]
      ring

theorem heat_gaussian_defect_budget :
    (1/2 : ℚ)^3 / 432 = 1/3456 := by
  norm_num

end XiKernel
