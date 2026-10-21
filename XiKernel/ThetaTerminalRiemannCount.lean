import Mathlib

/-!
# Terminal Riemann-von Mangoldt shell count and conditional heat-time transport

Scope: algebraic shell denominators, absolute-axis inclusion, and
the finite/counting implications of zero-free wall transport.
NOT formalized: Riemann-von Mangoldt, zeta/xi-to-theta zero mapping,
the complex argument principle, de Bruijn's strip theorem, the full
infinite exterior sum, interval logarithm evaluation, or RH.
No axioms or sorry introduced. Lean CI status must be checked.
-/

namespace XiKernel

theorem terminal_horizontal_inclusion
    (x c s : ℝ) (hc : 0 ≤ c) (hs : 0 ≤ s)
    (h : |x - c| ≤ s) : |x| ≤ c + s := by
  rcases abs_le.mp h with ⟨hlo, hhi⟩
  apply abs_le.mpr
  constructor <;> linarith

theorem terminal_shell_denominator_lower
    (r d q : ℝ) (hr : 0 ≤ r) (hd : 0 ≤ d)
    (hdr : d ≤ r) (hq : r^2 ≤ q) :
    (3 / 4 : ℝ) * r^2 ≤ q - d^2 / 4 := by
  have hh : 0 ≤ (r-d)*(r+d) :=
    mul_nonneg (sub_nonneg.mpr hdr) (add_nonneg hr hd)
  nlinarith

theorem terminal_complex_zero_count_gate
    (shell signedUpper positiveUpper : ℕ)
    (hcover : shell ≤ signedUpper)
    (hsym : signedUpper ≤ 2 * positiveUpper) :
    shell ≤ 2 * positiveUpper := by
  omega

theorem terminal_zero_free_wall_transport
    (initial final upper : ℕ)
    (hhomotopy : final = initial)
    (hterminal : initial ≤ upper) : final ≤ upper := by
  omega

theorem terminal_moving_wall_shell_gate
    (x center center0 outer delta : ℝ)
    (hcentre : |center-center0| ≤ delta)
    (houter : |x-center| ≤ outer) :
    |x-center0| ≤ outer + delta := by
  calc
    |x-center0| = |(x-center)+(center-center0)| := by ring
    _ ≤ |x-center|+|center-center0| := abs_add_le _ _
    _ ≤ outer+delta := add_le_add houter hcentre

theorem terminal_dyadic_coefficient :
    (4 / 3 : ℚ) * 2 = 8 / 3 := by norm_num

theorem terminal_first_two_shell_thresholds :
    (15422 / 1000 : ℚ) < 16 ∧
    (6584 / 1000 : ℚ) < 7 ∧
    (3745 / 1000 : ℚ) < 4 := by
  constructor
  · norm_num
  constructor <;> norm_num

#print axioms terminal_horizontal_inclusion
#print axioms terminal_shell_denominator_lower
#print axioms terminal_complex_zero_count_gate
#print axioms terminal_moving_wall_shell_gate
end XiKernel
