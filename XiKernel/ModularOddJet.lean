import Mathlib

/-!
# Square-lattice modular odd-jet cancellation: algebraic proof gates

For q_m=pi*m^2, the first derivative of the m-th positive-axis
theta summand at zero is q_m*exp(-q_m)*P1(q_m),
P1(q)=-8q^2+30q-15. All m>=2 terms are strictly negative.
The full sum equals zero by the Jacobi modular identity.

Hence EVERY fixed M>=1 leaves a strictly positive truncated
first derivative, forcing an x^-2 Fourier cusp and an eventual
negative L1. This Lean module proves the finite algebraic gates,
NOT the theta functional equation or Fourier asymptotics.
-/

namespace XiKernel

theorem odd_jet_first_polynomial (q : ℝ) :
    8*q + (2*q-3)*(5-4*q) =
      -8*q^2 + 30*q - 15 := by
  ring

theorem higher_square_mode_negative (q : ℝ) (hq : 12 ≤ q) :
    -8*q^2 + 30*q - 15 < 0 := by
  have ht : 0 ≤ q-12 := by linarith
  have hid : -8*q^2 + 30*q -15 =
      -(8*(q-12)^2 + 162*(q-12) + 807) := by
    ring
  rw [hid]
  have hp : 0 < 8*(q-12)^2+162*(q-12)+807 := by
    positivity
  linarith

theorem higher_square_mode_derivative_negative
    (q weight : ℝ) (hq : 12 ≤ q) (hw : 0 < weight) :
    weight * q * (-8*q^2+30*q-15) < 0 := by
  have hqpos : 0 < q := by linarith
  have hs := higher_square_mode_negative q hq
  exact mul_neg_of_pos_of_neg (mul_pos hw hqpos) hs

/-- If the full modular derivative sum is zero and every tail
summand is negative, the positive-axis finite-mode defect is >0. -/
theorem finite_modular_defect_positive
    (finiteSum tail : ℝ)
    (hmodular : finiteSum + tail = 0)
    (htail : tail < 0) :
    0 < finiteSum := by
  linarith

/-- If F ~ -2D/x², F' ~4D/x³, F'' ~-12D/x⁴,
the leading first Laguerre coefficient is -8D²/x⁶. -/
theorem spurious_laguerre_leading_coefficient (D : ℝ) :
    (4*D)^2 - (-2*D)*(-12*D) = -8*D^2 := by
  ring

theorem spurious_laguerre_coefficient_negative
    (D : ℝ) (hD : 0 < D) :
    -8*D^2 < 0 := by
  have hsq : 0 < D^2 := sq_pos_of_pos hD
  nlinarith

end XiKernel
