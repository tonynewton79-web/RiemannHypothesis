import Mathlib

/-!
# Theta-square-lattice heat-flow truncation: exact rational gate

For 0 <= t <= 1/2 and u>=0, exp(4u)>=8u² ensures
t*u² <= exp(4u)/16. The omitted m>M summands of the
*actual* theta Fourier heat deformation are consequently
dominated by incomplete gamma integrals with parameter
a = pi*m²-1/16.

For q>=12, setting a=q-1/16 gives:
  2q(a³+3a²+6a+6)<3a⁴.
Combined with the square-lattice geometric ratio this gives
an explicit full-line derivative error <=
3*q*exp(-q+1/16)*k!/4^k uniformly over
0<=t<=1/2 and |Im z|<=3 (or |Im z|<=7 if k=0).

THIS Lean module proves the exact polynomial gate only,
not the infinite theta series, exponential inequalities,
Gaussian heat flow, complex Fourier integral, or RH.
-/

namespace XiKernel

private theorem shifted_identity (q : ℝ) :
    3*(q-1/16)^4 -
      2*q*((q-1/16)^3 + 3*(q-1/16)^2 +
        6*(q-1/16)+6) =
      (q-12)^4 + (333/8)*(q-12)^3 +
      (39891/64)*(q-12)^2 +
      (7941835/2048)*(q-12) +
      (522416259/65536) := by
  ring

theorem theta_heat_tail_gate (q : ℝ) (hq : 12 ≤ q) :
    2*q*((q-1/16)^3 + 3*(q-1/16)^2 +
       6*(q-1/16)+6) < 3*(q-1/16)^4 := by
  have hnonneg : 0 ≤ q-12 := by linarith
  have hp : 0 < (q-12)^4 + (333/8)*(q-12)^3 +
      (39891/64)*(q-12)^2 +
      (7941835/2048)*(q-12) +
      (522416259/65536) := by
    positivity
  rw [← shifted_identity] at hp
  linarith

theorem theta_heat_strip_derivative_exponent (Y : ℝ) (hY : Y ≤ 3) :
    (9+Y)/4 ≤ 3 := by
  linarith

theorem theta_heat_strip_zeroth_exponent (Y : ℝ) (hY : Y ≤ 7) :
    (5+Y)/4 ≤ 3 := by
  linarith

theorem theta_heat_tilt_bound (t r E : ℝ)
    (ht : 0 ≤ t) (ht2 : t ≤ 1/2)
    (hr : 0 ≤ r) (hE : 8*r^2 ≤ E) :
    t*r^2 ≤ E/16 := by
  have hs : 0 ≤ r^2 := sq_nonneg r
  nlinarith

/-- A strict absolute error does not imply a strict relative
gap when a candidate transform is smaller than the allowance. -/
theorem theta_heat_missing_relative_gap (err modul : ℝ)
    (he : 0 < err) (hm : modul ≤ err) :
    ¬ err < modul := by
  linarith

end XiKernel
