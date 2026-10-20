import Mathlib

/-!
# One-sided inverse-square shielding inequality

For adjacent real zeros a<b with g=b-a and outward gaps
d_L(j), d_R(j), the normalized shielding deficit obeys

[2-g²*S]_+ ≤ ∑_{j≥1} ((d_L(j)/g-1)_+ + (d_R(j)/g-1)_+)/j².

The analytical proof and finite-R version are in
paper/heat_one_sided_shielding.tex. This file certifies
the scalar exact tangent-line identity, rational weights
and the *conditional* integrated margin. It does not
formalize the infinite zero-motion ODE or prove the
time-integrated estimate for actual Riemann theta zeros.
-/

namespace XiKernel

/-- Exact tangent error for f(x)=1/(x*(x+1)), x=m+h.
The right side is nonnegative for m>0, h≥0. -/
theorem shielding_tangent_identity (m h : ℝ)
    (hm : 0 < m) (hh : 0 ≤ h) :
    (h*(1/m^2-1/(m+1)^2)
      -(1/(m*(m+1))-1/((m+h)*(m+h+1)))) *
      (m^2*(m+1)^2*(m+h)*(m+h+1)) =
    h^2*(2*h*m+h+3*m^2+3*m+1) := by
  have h0 : m ≠ 0 := ne_of_gt hm
  have h1 : m+1 ≠ 0 := ne_of_gt (by linarith)
  have h2 : m+h ≠ 0 := ne_of_gt (by linarith)
  have h3 : m+h+1 ≠ 0 := ne_of_gt (by linarith)
  field_simp [h0, h1, h2, h3]
  ring

/-- The slope of the convex reciprocal-pair kernel is the
discrete inverse-square difference. -/
theorem shielding_weight_identity (m : ℝ) (hm : 0 < m) :
    1/m^2-1/(m+1)^2 =
    (2*m+1)/(m^2*(m+1)^2) := by
  have h0 : m ≠ 0 := ne_of_gt hm
  have h1 : m+1 ≠ 0 := ne_of_gt (by linarith)
  field_simp [h0, h1]
  ring

/-- A gap excess at j contributes inverse-square mass; this
telescoping identity makes the weighting sharp. -/
theorem shielding_inverse_square_telescope
    (j R : ℝ) (hj : 0 < j) (hR : 0 < R) :
    (1/j^2-1/R^2)+1/R^2 = 1/j^2 := by
  ring

/-- A single doubled outward gap at index j produces exactly
1/(j(j+1)) extra shielding deficit versus the full lattice. -/
theorem shielding_single_doubled_gap (j : ℝ) (hj : 0 < j) :
    1/j-1/(j+1) = 1/(j*(j+1)) := by
  have h0 : j ≠ 0 := ne_of_gt hj
  have h1 : j+1 ≠ 0 := ne_of_gt (by linarith)
  field_simp [h0,h1]
  ring

/-- The integrated upper bound is a genuine *sufficient*
no-collision gate, not an established bound for theta zeros. -/
theorem one_sided_integrated_shielding_gate
    (initialSq terminalSq actualLoss upperLoss : ℝ)
    (hdynamics : initialSq-4*actualLoss ≤ terminalSq)
    (hupper : actualLoss ≤ upperLoss)
    (hmargin : 4*upperLoss < initialSq) :
    0 < terminalSq := by
  linarith

end XiKernel
