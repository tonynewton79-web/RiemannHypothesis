import Mathlib

/-!
# First Xi zero contour: rational 4096-node certification blueprint

A two-mode theta approximant on the circle |z-28.269|=1/2
has numerically sampled modulus ~7.45e-5. The Xi tail theorem
gives E_2=27*pi*exp(-9*pi)<1e-9.

Analytically, the global |Im z|<=3 derivative bound
is C/4 < 1/8. On a 4096-node circle the maximum
distance to a sample is <= pi/(2*4096), so
the modulus variation is <=pi/65536 <22/(7*65536).

If all 4096 node moduli are RIGOROUSLY shown >=7/100000,
the continuous contour has min modulus >E_2.

This module kernel-checks ONLY these exact rational thresholds.
Validated interval evaluation of sample values and winding is
NOT implemented yet: there is no certified zero count and no RH
theorem here.
-/

namespace XiKernel

theorem theta_derivative_rational_bound :
    (((22:ℚ)/7+3+2+(2/3:ℚ))/20 +
        12*((22:ℚ)/7)/20^4) < 1/2 := by
  norm_num

theorem theta_two_mode_tail_rational_bound :
    (27*((22:ℚ)/7)/20^9) < 1/1000000000 := by
  norm_num

theorem contour_4096_strict_gap
    (sampleMin error : ℝ)
    (hs : 7/100000 ≤ sampleMin)
    (he : error ≤ 1/1000000000) :
    error < sampleMin - 22/(7*65536) := by
  linarith

theorem contour_4096_positive_min
    (sampleMin : ℝ) (hs : 7/100000 ≤ sampleMin) :
    0 < sampleMin - 22/(7*65536) := by
  linarith

end XiKernel
