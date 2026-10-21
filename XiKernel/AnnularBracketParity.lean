import Mathlib

/-!
# Sign-bracket parity and value-dominated flank algebra

This module proves Presburger and rational-arithmetic consequences of a
symmetric-annulus sign-parity gate and of the prior theta interval jets.
It does not formalize the argument principle, complex zero pairing,
Noshiro--Warschawski, theta kernel, interval quadrature, or RH.
Compilation via GitHub CI is required.
-/
namespace XiKernel

/-- If l verified positive-side brackets have the same parity as
the actual positive real odd-multiplicity zero count, the symmetric
zero excess is divisible by four. The variables k and e encode the
remaining real and nonreal conjugate-pair contributions. -/
theorem annular_bracket_parity_formula (l k e : ℕ) :
    2 * (l + 2*k + 2*e) = 2*l + 4*(k+e) := by
  omega

/-- A total count within three of twice the certified positive-side
brackets excludes every additional quartet. -/
theorem annular_bracket_parity_gap (N l : ℕ)
    (hlower : 2*l ≤ N) (hupper : N < 2*l+4)
    (hmod : N % 4 = (2*l) % 4) : N = 2*l := by
  omega

/-- Endpoint-sign parity is essential: missing one real pair leaves
an apparent defect of two, not a multiple of four. -/
theorem annular_missing_parity_control :
    ((4:ℕ) - 2*1) % 4 = 2 := by
  norm_num

private def flankD1 : ℚ := 914 / 10^7
private def flankR : ℚ := 9 / 100
private def flankM2 : ℚ := 5302 / 10^8
private def flankM3 : ℚ := 1 / 55
private def flankS : ℚ := 1 / 1500
private def flankH : ℚ := 1 / 125
private def flankDelta : ℚ := 1 / 250
private def flankDerivativeUpper : ℚ :=
  flankD1 + flankR * flankM2 +
  ((flankR^2)/2 + flankS)*flankM3
private def flankLoss : ℚ :=
  (flankDelta + flankH)*flankDerivativeUpper

theorem theta_flank_disk_contains_cells :
    ((2/25 : ℚ) + flankDelta)^2 + flankH^2 < flankR^2 := by
  unfold flankDelta flankH flankR
  norm_num

theorem theta_flank_derivative_upper_exact :
    flankDerivativeUpper = 30018347 / 165000000000 := by
  unfold flankDerivativeUpper flankD1 flankR flankM2 flankM3 flankS
  norm_num

theorem theta_flank_loss_exact :
    flankLoss = 30018347 / 13750000000000 := by
  unfold flankLoss flankDelta flankH flankDerivativeUpper
    flankD1 flankR flankM2 flankM3 flankS
  norm_num

theorem theta_flank_left_margin :
    (4368777763 : ℚ) / 1744875000000000 - flankLoss =
      5594495287 / 17448750000000000 := by
  unfold flankLoss flankDelta flankH flankDerivativeUpper
    flankD1 flankR flankM2 flankM3 flankS
  norm_num

theorem theta_flank_right_margin :
    (10720122763 : ℚ) / 1744875000000000 - flankLoss =
      69107945287 / 17448750000000000 := by
  unfold flankLoss flankDelta flankH flankDerivativeUpper
    flankD1 flankR flankM2 flankM3 flankS
  norm_num

theorem theta_flank_positive_margins :
    0 < (5594495287:ℚ) / 17448750000000000 ∧
    0 < (69107945287:ℚ) / 17448750000000000 := by
  constructor <;> norm_num

#print axioms annular_bracket_parity_formula
#print axioms annular_bracket_parity_gap
#print axioms theta_flank_left_margin
#print axioms theta_flank_positive_margins
end XiKernel
