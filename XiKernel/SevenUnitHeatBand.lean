import Mathlib

/-!
# Exact seven-unit theta heat band: algebraic verification

Analytic inputs: positive Fourier correlation kernel with
B_n/A_n<=1/24, hence
|U_n'(x)| <= A_n * min(|x|/24,1/sqrt(24)).
This gives U_n>=A_n*g(|x|), g(r)=1-r²/48
through sqrt(24), then 3/2-r/sqrt(24).
The rational identity proves g(7)>1/15.
Lean proves the finite rational and source comparison gates,
NOT the infinite theta integral or Cauchy--Schwarz application.
-/
namespace XiKernel

theorem seven_unit_rational_gap :
    (43/30 : ℚ)^2*24-49 = 23/75 := by
  norm_num

theorem seven_unit_rational_strict :
    (49 : ℚ) < 24*(43/30)^2 := by
  norm_num

theorem seven_unit_heat_source_gate
    (A B U V k : ℝ)
    (hA : 0 < A) (hB : 0 ≤ B) (hk : 0 ≤ k)
    (hU : A/15 ≤ U)
    (hV : V ≤ B) :
    k*V ≤ (15*k*B/A)*U := by
  have hcoeff : 0 ≤ 15*k*B/A := by positivity
  have hleft := mul_le_mul_of_nonneg_left hV hk
  have hright := mul_le_mul_of_nonneg_left hU hcoeff
  have hid : (15*k*B/A)*(A/15) = k*B := by
    field_simp [ne_of_gt hA]
    ring
  linarith

theorem seven_unit_model_extension :
    (1/15 : ℚ) > (1-7^2/48) := by
  norm_num

end XiKernel
