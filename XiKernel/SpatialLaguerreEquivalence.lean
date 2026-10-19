import Mathlib

/-!
# Local finite spatial Laguerre comparison: exact zero obstruction

The entire theta heat inequality
 (n+1)(2n+1) U_(n+1)(s,x) <= c_n(s,x) U_n(s,x)
is a strong *sufficient* hypothesis for RH, not a proved input.

At a multiple real zero of multiplicity m>=2,
 U_1=...=U_(m-1)=0 and U_m>0. Hence even the
single comparison at n=m-1 is impossible with any finite c.

For model H(z)=(z-a)^m, Q(x,y)=((x-a)^2+y^2)^m.
The y^(2m-2) and y^(2m) coefficients are
m*(x-a)^2 and 1, so the ratio necessarily diverges like
(2m-1)/(x-a)^2 close to a multiple zero.

This file proves algebraic gates (not complete polynomial-series
coefficient extraction, PDE max principle, theta heat flow, or RH).
-/

namespace XiKernel

theorem adjacent_laguerre_zero_obstruction (n : ℕ) (next : ℝ)
    (hnext : 0 < next) :
    ¬ ∃ c : ℝ, 0 ≤ c ∧
      ((n : ℝ) + 1) * (2*(n : ℝ)+1) * next ≤ c * 0 := by
  intro h
  obtain ⟨c, hc, hineq⟩ := h
  have hk : 0 < ((n : ℝ)+1) * (2*(n : ℝ)+1) := by positivity
  have hp : 0 < ((n : ℝ)+1) * (2*(n : ℝ)+1) * next := mul_pos hk hnext
  nlinarith

theorem multiple_root_order_two_expansion (h y : ℝ) :
    (h^2+y^2)^2 =
      h^4 + 2*h^2*y^2 + y^4 := by ring

theorem multiple_root_order_three_expansion (h y : ℝ) :
    (h^2+y^2)^3 =
      h^6 + 3*h^4*y^2 + 3*h^2*y^4 + y^6 := by ring

theorem multiple_root_order_four_expansion (h y : ℝ) :
    (h^2+y^2)^4 =
      h^8 + 4*h^6*y^2 + 6*h^4*y^4 +
      4*h^2*y^6 + y^8 := by ring

theorem multiplicity_ratio_identity (m h : ℝ)
    (hm : m ≠ 0) (hh : h ≠ 0) :
    (m*(2*m-1))/(m*h^2) = (2*m-1)/h^2 := by
  field_simp
  ring

theorem double_root_ratio (h : ℝ) (hh : h ≠ 0) :
    (6:ℝ)/(2*h^2) = 3/h^2 := by
  field_simp
  ring

theorem ratio_realizable_at_positive_denominator
    (u v : ℝ) (hu : 0 < u) (hv : 0 ≤ v) :
    v ≤ (v/u)*u := by
  field_simp

theorem ratio_bounded_on_positive_compact_data
    (u v epsilon B : ℝ)
    (hu : epsilon ≤ u) (he : 0 < epsilon)
    (hv : 0 ≤ v) (hB : v ≤ B) :
    v/u ≤ B/epsilon := by
  have hupos : 0 < u := lt_of_lt_of_le he hu
  apply (div_le_div_iff₀ hupos he).2
  nlinarith [mul_nonneg hv (show 0 ≤ u-epsilon by linarith),
             mul_nonneg (show 0 ≤ B-v by linarith) hupos]

end XiKernel
