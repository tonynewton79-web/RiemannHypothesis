import Mathlib

/-!
# Gaussian parity repair preserves Fourier zeros but alters Laguerre signs

For any real-even Fourier transform F, multiplying by
g(x)=exp(-sigma^2*x^2/2) corresponds to convolving its kernel
with a positive Gaussian. This removes all cusp and odd-jet
defects of finite positive-axis theta-mode truncations.

The complex Gaussian factor has no zeros; hence *all* zero
locations are unchanged.

The first Laguerre expression is shifted by sigma^2*F(x)^2.
Lean certifies the polynomial identity and complex zero
preservation. Fourier inversion and the analytic asymptotic
are kept separately in the paper; no RH theorem is claimed.
-/

namespace XiKernel

/-- Algebraic form of the first Laguerre product law.
Take gp=-h*g and gpp=(h²-s)*g; for a Gaussian
h=sigma²*x and s=sigma². -/
theorem gaussian_laguerre_algebra
    (f fp fpp g h s : ℝ) :
    ((-h*g)*f + g*fp)^2 -
      (g*f)*((h^2-s)*g*f+2*(-h*g)*fp+g*fpp) =
    g^2*(fp^2-f*fpp+s*f^2) := by
  ring

/-- Nonvanishing Gaussian multipliers preserve zeros in ℂ. -/
theorem gaussian_multiplier_zero_iff (sigma z f : ℂ) :
    Complex.exp (-(sigma^2)*z^2/2)*f=0 ↔ f=0 := by
  constructor
  · intro h
    rcases mul_eq_zero.mp h with he | hf
    · exact False.elim ((Complex.exp_ne_zero _) he)
    · exact hf
  · intro h
    simp [h]

/-- Leading high-frequency Laguerre coefficient for a
cusp-generated F~-2D/x² and Gaussian smoothing. -/
theorem gaussian_cusp_leading_identity
    (D sigma x : ℝ) :
    (4*D)^2-(-2*D)*(-12*D)
       + sigma^2 * (-2*D)^2*x^2 =
       4*D^2*(sigma^2*x^2-2) := by
  ring

/-- For any fixed sigma>0, the leading high-frequency
coefficient becomes positive once sigma²*x²>2. -/
theorem gaussian_cusp_leading_positive
    (D sigma x : ℝ) (hD : 0 < D)
    (hregion : 2 < sigma^2*x^2) :
    0 < 4*D^2*(sigma^2*x^2-2) := by
  have hs : 0 < D^2 := sq_pos_of_pos hD
  have hr : 0 < sigma^2*x^2-2 := by linarith
  positivity

/-- The same explicit sign model at zero smoothing is negative. -/
theorem original_cusp_leading_negative (D : ℝ) (hD : 0 < D) :
    (4*D)^2-(-2*D)*(-12*D) < 0 := by
  nlinarith [sq_pos_of_pos hD]

end XiKernel
