import Mathlib

/-!
# Division-free theta spectral-loss gates

For the genuine theta backward heat flow, define the loss
Δ_n=P_s U_n(0)-U_n(s). Its exact two-variable Fourier representation
has nonnegative spectral density but an oscillating cosine. At x=0
Δ_n>0; at noncentral x its sign is not determined by density positivity.

The three-atom strictly positive measure mu(0)=1, mu(±1)=1/10,
with s=2 log(5/4) in (0,1/2), has at n=1:
  Δ_1(s,0)=869/15625 >0,
  Δ_1(s,pi)=-131/15625 <0.
Only rational identities/sign gates are kernel-checked here;
the theta convolution and Fourier integration remain analytic.
-/

namespace XiKernel

theorem laguerre_heat_factorial_coupling (n : ℕ) :
    ((2*n+2 : ℕ) : ℝ) * ((2*n+1 : ℕ) : ℝ) / 2 =
      ((n : ℝ)+1) * (2*(n : ℝ)+1) := by
  push_cast
  ring

theorem retained_spectral_weight (w r : ℝ)
    (hw : 0 ≤ w) (hr0 : 0 ≤ r) (hr1 : r ≤ 1) :
    0 ≤ w*(1-r) ∧ w*(1-r) ≤ w := by
  constructor
  · exact mul_nonneg hw (by linarith)
  · nlinarith [mul_nonneg hw hr0]

theorem signed_heat_loss_at_center :
    (869/15625 : ℚ) > 0 := by norm_num

theorem signed_heat_loss_away_from_center :
    -(131/15625 : ℚ) < 0 := by norm_num

theorem three_atom_noncentral_loss :
    ((-8/125 : ℚ) + 738/15625)/2 = -(131/15625) := by
  norm_num

theorem three_atom_central_loss :
    ((8/125 : ℚ) + 738/15625)/2 = 869/15625 := by
  norm_num

/-- Division-free positive baseline criterion: does not assume U_n positive. -/
theorem theta_division_free_budget
    (baseline loss envelope : ℝ)
    (hbaseline : envelope < baseline) (hloss : loss ≤ envelope) :
    0 < baseline-loss := by linarith

/-- Duhamel weighted-defect budget: a positive part may be tolerated
provided its smoothed contribution is below the initial baseline. -/
theorem theta_positive_part_budget
    (initial deficit positiveDefect : ℝ)
    (h : positiveDefect < initial)
    (hd : deficit ≤ positiveDefect) :
    0 < initial - deficit := by linarith

end XiKernel
