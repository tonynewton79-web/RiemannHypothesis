import Mathlib

/-!
# Exact signed-slice obstruction for the theta Fourier correlation

For any real even entire Fourier transform H with a simple real zero a,
the fixed-difference correlation slice C(b,a) obeys:
  integral C(b,a) db = H(a)^2 = 0,
  integral b^2 C(b,a) db = 2*(H'(a))^2 > 0.
Thus C takes both signs. Its b Fourier symbol
  H(a+eta)*H(a-eta) = -H'(a)^2*eta^2+O(eta^4)
is negative near zero, ruling out a positive
convolution-square/Gram factorization of the slice.

These Lean statements certify the finite-dimensional sign algebra
and an EXACT atomic control. They do not formalize the theta
integral identities, existence of an actual real simple zero,
or Riemann hypothesis.
-/
namespace XiKernel

theorem atomic_slice_mass_zero :
    (1/4 : ℚ) - 1/2 + 1/4 = 0 := by
  norm_num

theorem atomic_slice_second_moment :
    ((-2 : ℚ)^2)*(1/4) + (0:ℚ)^2*(-1/2) +
       (2:ℚ)^2*(1/4) = 2 := by
  norm_num

theorem atomic_slice_changes_sign :
    ((-1/2 : ℚ) < 0) ∧ ((0:ℚ) < (1/4 : ℚ)) := by
  norm_num

theorem slice_nonnegative_mass_zero_contradiction
    (cminus czero cplus : ℝ)
    (hm : 0 ≤ cminus) (hz : 0 ≤ czero)
    (hp : 0 ≤ cplus)
    (hzero : cminus + czero + cplus = 0)
    (hsecond : 0 < 4*cminus + 4*cplus) : False := by
  linarith

theorem simple_zero_spectral_sign
    (slope displacement : ℝ)
    (hs : slope ≠ 0) (hd : displacement ≠ 0) :
    (slope*displacement)*(slope*(-displacement)) < 0 := by
  have hh : 0 < (slope*displacement)^2 := by
    exact sq_pos_of_ne_zero (mul_ne_zero hs hd)
  nlinarith

theorem signed_moment_witness
    (negative positive : ℝ)
    (hm : negative < 0)
    (hp : 0 < positive) :
    ¬ (0 ≤ negative ∧ positive ≤ 0) := by
  intro h
  linarith

end XiKernel
