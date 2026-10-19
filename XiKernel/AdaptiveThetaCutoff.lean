import Mathlib

/-!
# Algebraic prerequisite for logarithmic-height adaptive theta cutoff

For q=pi*(M+1)^2>=12,
e^(q/2) >= (q/2)^2/2=q^2/8 >= q,
so 3*q*e^(-q) <= 3*e^(-q/2).

Choosing q>=2*(p*log(1+R)+log(3/delta)) then yields
E_M<=delta*(1+R)^(-p).
This makes a polynomial absolute error possible with
M=O(sqrt(log R)), but does NOT supply a nonzero
relative lower bound for Xi and therefore does not prove RH.

Lean verifies the exact algebraic inequality needed for q>=12,
not the full exponential/log statement.
-/

namespace XiKernel

theorem adaptive_theta_polynomial_margin
    (q : ℝ) (hq : 12 ≤ q) : 8*q ≤ q^2 := by
  have hq0 : 0 ≤ q := by linarith
  nlinarith [mul_nonneg hq0 (show 0 ≤ q-8 by linarith)]

theorem adaptive_theta_positive_gap
    (q : ℝ) (hq : 12 ≤ q) : 0 < q^2/8 - q + 1 := by
  have h := adaptive_theta_polynomial_margin q hq
  linarith

/-- Relative Rouché positivity is a separate hypothesis,
even if the absolute approximation error is tiny. -/
theorem adaptive_rouche_requires_modulus
    (err modulus : ℝ)
    (hsmall : 0 ≤ err) (hmod : modulus ≤ err) :
    ¬ err < modulus := by
  linarith

end XiKernel
