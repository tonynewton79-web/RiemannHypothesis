import Mathlib

/-!
# Theta annular quartet and thin-strip algebra

Rational gates and natural-number orbit arithmetic only. Not an analytic
theta proof, infinite induction, or RH formalization. CI required.
-/

namespace XiKernel

private def annularRealDerivativeLower : ℚ :=
  913 / 10^7 - (2 / 25) * (5302 / 10^8) -
    ((2 / 25)^2 / 2 + 1 / 1500) * (1 / 55)

private def annularComplexSecondUpper : ℚ :=
  5302 / 10^8 + (2 / 25 + 1 / 125) / 55 +
    (1 / 1500) / 141

private def annularUnivalenceMargin : ℚ :=
  annularRealDerivativeLower - (1 / 125) * annularComplexSecondUpper

theorem annular_derivative_lower_exact :
    annularRealDerivativeLower = 691159 / 41250000000 := by
  unfold annularRealDerivativeLower
  norm_num

theorem annular_complex_second_upper_exact :
    annularComplexSecondUpper = 35061373 / 21150000000 := by
  unfold annularComplexSecondUpper
  norm_num

theorem annular_univalence_margin_exact :
    annularUnivalenceMargin = 12698999 / 3635156250000 := by
  unfold annularUnivalenceMargin annularRealDerivativeLower
    annularComplexSecondUpper
  norm_num

theorem annular_univalence_margin_pos :
    0 < annularUnivalenceMargin := by
  rw [annular_univalence_margin_exact]
  norm_num

theorem annular_real_endpoint_left :
    (0 : ℚ) < 4368777763 / 1744875000000000 := by
  norm_num

theorem annular_real_endpoint_right :
    (0 : ℚ) < 10720122763 / 1744875000000000 := by
  norm_num

theorem annular_even_multiplicity_excess (k : ℕ) :
    2 * (2 * k) = 4 * k := by
  omega

theorem annular_odd_multiplicity_excess (k : ℕ) :
    2 * (2 * k + 1) - 2 = 4 * k := by
  omega

theorem annular_quartet_defect
    (realPairs complexQuartets multipleRealExcess : ℕ) :
    (2 * realPairs + 4 * complexQuartets + 4 * multipleRealExcess) -
      (2 * realPairs) = 4 * (complexQuartets + multipleRealExcess) := by
  omega

theorem annular_quartet_gap_gate
    (total signs quartets : ℕ)
    (hcount : total = signs + 4 * quartets)
    (hupper : total < signs + 4) : total = signs := by
  omega

theorem annular_compact_quartet_rho :
    (2 : ℚ)^2 / (100^2 + (1 / 4)^2) = 64 / 160001 := by
  norm_num

theorem annular_compact_quartet_small :
    (2 : ℚ) * (64 / 160001) + (64 / 160001)^2 < 1 / 1000 := by
  norm_num

#print axioms annular_univalence_margin_exact
#print axioms annular_univalence_margin_pos
#print axioms annular_quartet_defect
#print axioms annular_quartet_gap_gate

end XiKernel
