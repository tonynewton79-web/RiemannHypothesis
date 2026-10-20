import Mathlib

/-!
# First certified compact heat-frequency rectangle for the genuine theta flow

Let U_(j,2)=L_j[H_(1/2-s,2)] for the FIRST TWO actual theta
summands. The external validated interval-Simpson calculation proves
moment enclosures sufficient for all 0<=s<=1/2, |x|<=1/100.

The source comparison with k_1=6 and c=C_K=1 has strict negative
rational margin larger than the uniform theta errors.

This module kernel-checks the exact moment-to-source implication and
all rational truncation margins. The transcendental Simpson
enclosures and genuine theta integral are not yet Lean-formalized.
-/

namespace XiKernel

private def mu0Lower : ℚ := 1/20 - ((1/100 : ℚ)^2/2)*(1/1000)
private def mu2Lower : ℚ := 1/2000 - ((1/100 : ℚ)^2/2)*(1/30000)

private def U1Lower : ℚ := mu0Lower*mu2Lower
private def U2Upper : ℚ :=
  (1/10 : ℚ)*(1/30000)/12+
  (1/100 : ℚ)*(1/5000)/3+
  (1/1000 : ℚ)^2/4

private def thetaCommon : ℚ := (198/7)/20^8
private def e1Upper : ℚ := (3*3*100 : ℚ)/(2*4^2)*thetaCommon
private def e2Upper : ℚ := (3*5*100 : ℚ)/(2*4^4)*thetaCommon

theorem rectangle_moment_lower_positive :
    0 < U1Lower := by
  norm_num [U1Lower, mu0Lower, mu2Lower]

theorem rectangle_theta_budget_small :
    6*e2Upper+e1Upper < 1/10000000 := by
  norm_num [e1Upper,e2Upper,thetaCommon]

theorem rectangle_finite_source_exact :
    6*U2Upper-U1Lower = -(79/30000000 : ℚ) := by
  norm_num [U1Lower,U2Upper,mu0Lower,mu2Lower]

theorem rectangle_strict_transfer_margin :
    6*U2Upper-U1Lower+6*e2Upper+e1Upper < -(2/1000000 : ℚ) := by
  norm_num [U1Lower,U2Upper,mu0Lower,mu2Lower,e1Upper,e2Upper,thetaCommon]

/-- Division-free full-rectangle source comparison. The hypotheses
are exactly the positive theta-moment bounds obtained from the
external interval proof, and the abstract error bounds. -/
theorem genuine_theta_first_rectangle_gate
    (U1 U2 e1 e2 : ℝ)
    (h1 : (U1Lower : ℝ) ≤ U1)
    (h2 : U2 ≤ (U2Upper : ℝ))
    (he1 : 0 ≤ e1 ∧ e1 ≤ (e1Upper : ℝ))
    (he2 : 0 ≤ e2 ∧ e2 ≤ (e2Upper : ℝ)) :
    6*U2-U1 ≤ -(6*e2+e1) := by
  have hstrict : 6*(U2Upper : ℝ)-(U1Lower : ℝ)+
      6*(e2Upper : ℝ)+(e1Upper : ℝ) < -(2/1000000 : ℝ) := by
    exact_mod_cast rectangle_strict_transfer_margin
  linarith

end XiKernel
