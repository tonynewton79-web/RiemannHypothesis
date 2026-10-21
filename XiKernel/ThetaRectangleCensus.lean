import Mathlib

/-!
# Two genuine-theta rectangle census: formalized arithmetic gates

Exact rational inequalities after outward-rounded theta interval integration.
Analytic quadrature, derivative bounds, Rouche's theorem, argument principle,
terminal Hurwitz/Rouche and RH are NOT formalized here. CI must be checked.
-/
namespace XiKernel

private def rectError : ℚ :=
  (5302 / 10^8) / 2 * (89 / 10^4) + 1 / (330 * 1000)
private def rectMargin : ℚ := 913 / (20 * 10^7) - rectError
private def rectHeatDrift : ℚ :=
  1 / 1500 * (5302 / 10^8 + 1 / (10 * 55)) +
  (1 / 1500)^2 / (2 * 141)

theorem theta_rect_square_radius :
    (2 / 25 : ℚ)^2 + (1 / 20 : ℚ)^2 = 89 / 10^4 := by
  norm_num

theorem theta_rect_inside_tenth_disk :
    (2 / 25 : ℚ)^2 + (1 / 20 : ℚ)^2 < (1 / 10)^2 := by
  norm_num

theorem theta_rect_remainder_bound :
    rectError = 107785987 / 33000000000000 := by
  unfold rectError
  norm_num

theorem theta_rect_positive_margin :
    rectMargin = 42859013 / 33000000000000 ∧ 0 < rectMargin := by
  unfold rectMargin rectError
  constructor <;> norm_num

theorem theta_rect_left_sign :
    (-183 / 10^8 : ℚ) + (913 / 10^7)*(2/25) -
    (5302 / 10^8)/2 * (2/25)^2 -
    (1/55)*(2/25)^3/6 = 7740193 / 2062500000000 := by
  norm_num

theorem theta_rect_right_sign :
    (-181 / 10^8 : ℚ) - (913 / 10^7)*(2/25) +
    (5302 / 10^8)/2 * (2/25)^2 +
    (1/55)*(2/25)^3/6 = -15247693 / 2062500000000 := by
  norm_num

theorem theta_rect_heat_drift :
    rectHeatDrift = 435885103 / 348975000000000 := by
  unfold rectHeatDrift
  norm_num

theorem theta_rect_heat_contour_margin :
    rectMargin - rectHeatDrift = 693958379 / 13959000000000000 ∧
    0 < rectMargin - rectHeatDrift := by
  unfold rectMargin rectError rectHeatDrift
  constructor <;> norm_num

theorem theta_rect_linear_zero_inside :
    (183 / 10^8 : ℚ) / (913 / 10^7) < 2 / 25 := by
  norm_num

theorem theta_rect_heat_preserves_signs :
    rectHeatDrift < 7740193 / 2062500000000 ∧
    rectHeatDrift < 15247693 / 2062500000000 := by
  unfold rectHeatDrift
  constructor <;> norm_num

theorem theta_rect_count_matching
    (zeroCount realCount signChanges : ℕ)
    (h₁ : signChanges ≤ realCount)
    (h₂ : realCount ≤ zeroCount)
    (h₃ : zeroCount = signChanges) : zeroCount = realCount := by
  omega

#print axioms theta_rect_positive_margin
#print axioms theta_rect_heat_contour_margin
#print axioms theta_rect_count_matching
end XiKernel
