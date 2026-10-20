import Mathlib

/-!
# Central Laguerre ratios as size-biased even-moment quotients

For the genuine theta heat kernel, convolution positivity gives
U_n(s,0) = M_(2n)(t)/(4*(2n)!), t=1/2-s, where
M_(2n)(t) = ∫ w^(2n) (Phi_t * Phi_t)(w) dw.

The comparison requirement at x=0 is therefore exactly
k_n*U_(n+1)/U_n = 1/2*M_(2n+2)/M_(2n).
Moment log-convexity forces strict increase in n. Because the
convolution density is positive on all of ℝ, its support is unbounded,
so these quotients tend to +∞. Uniformity in t∈[0,1/2] follows from
compactness and monotonicity.

Only elementary arithmetic sublemmas are formalized here; the
integral representation and infinite-support argument are
analytical manuscript results. No RH theorem is claimed.
-/
namespace XiKernel

theorem central_factorial_ratio
    (n mass massNext : ℝ) (hn : 0 ≤ n) (hm : mass ≠ 0) :
    ((n+1)*(2*n+1)) *
      (massNext / ((2*n+1)*(2*n+2)*mass)) =
      massNext/(2*mass) := by
  have h1 : 2*n+1 ≠ 0 := by linarith
  have h2 : 2*n+2 ≠ 0 := by linarith
  field_simp
  ring

theorem even_moment_ratio_monotone
    (a b c : ℝ) (ha : 0 < a) (hb : 0 < b)
    (hcs : b^2 ≤ a*c) :
    b/a ≤ c/b := by
  apply (div_le_div_iff₀ ha hb).2
  nlinarith

theorem even_moment_ratio_strict
    (a b c : ℝ) (ha : 0 < a) (hb : 0 < b)
    (hcs : b^2 < a*c) :
    b/a < c/b := by
  apply (div_lt_div_iff₀ ha hb).2
  nlinarith

/-- Any proposed c_n(s,0) must dominate the central size-biased
moment quotient, without dividing by a potentially vanishing U_n
at other spatial arguments. -/
theorem central_comparison_required
    (k next current coeff : ℝ)
    (hcurrent : 0 < current)
    (hcomp : k*next ≤ coeff*current) :
    k*next/current ≤ coeff := by
  exact (div_le_iff₀ hcurrent).2 hcomp

/-- Abstract contradiction to bounded order-independent control. -/
theorem central_unbounded_obstruction
    (r cap : ℝ) (hr : cap < r)
    (hcomp : r ≤ cap) : False := by
  linarith

end XiKernel
