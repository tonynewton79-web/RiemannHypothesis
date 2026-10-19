import Mathlib

/-!
# Uniform finite-depth positivity despite arbitrarily near-real complex zeros

Exact real-algebraic gate for
F(z) = sqrt(2*pi*A) exp(-A*z^2/2) (1+d*cos(z)).
For any fixed N, any 0<d<1, choosing
A=16*N/(1-d)^2 makes L_n[F](x)>0 for n<=N,
for every x in R. Meanwhile F has nonreal zeros at
odd multiples of pi ± i*acosh(1/d), with imaginary parts
arbitrarily small as d approaches one.

The Fourier identity and explicit factorial ratio estimate
are proved analytically in the paper, not yet formalized in Lean.
This Lean file checks the algebraic gate only.
-/

namespace XiKernel

theorem near_real_finite_depth_gate
    (a b c d t : ℝ)
    (ha : 0 < a)
    (hb : 0 ≤ b) (hc : 0 ≤ c)
    (hd : 0 ≤ d) (hd1 : d < 1)
    (ht : -1 ≤ t)
    (hsmall : 8*d*b ≤ a*(1-d)^2) :
    (3/4 : ℝ)*a*(1-d)^2 ≤
      a*(1+d*t)^2 + 2*d*t*b + (d^2/2)*c := by
  have ht0 : 0 ≤ t+1 := by linarith
  have hb0 : 0 ≤ (t+1)*b := mul_nonneg ht0 hb
  have hdt : 0 ≤ d*(t+1) := mul_nonneg hd ht0
  have hbase : 0 ≤ (1+d*t)-(1-d) := by nlinarith [hdt]
  have hsum : 0 ≤ (1+d*t)+(1-d) := by
    have : 0 ≤ 1-d := by linarith
    nlinarith [hbase]
  have hsqprod : 0 ≤ ((1+d*t)-(1-d))*((1+d*t)+(1-d)) :=
    mul_nonneg hbase hsum
  have hsq : (1-d)^2 ≤ (1+d*t)^2 := by nlinarith [hsqprod]
  have hscaled : a*(1-d)^2 ≤ a*(1+d*t)^2 :=
    mul_le_mul_of_nonneg_left hsq (le_of_lt ha)
  have hleft : -2*d*b ≤ 2*d*t*b := by
    have h := mul_nonneg (show 0 ≤ 2*d by positivity) hb0
    nlinarith [h]
  have hcross : 0 ≤ (d^2/2)*c := mul_nonneg (by positivity) hc
  nlinarith [hscaled, hleft, hsmall, hcross]

theorem near_real_strict (a b c d t : ℝ)
    (ha : 0 < a) (hb : 0 ≤ b) (hc : 0 ≤ c)
    (hd : 0 ≤ d) (hd1 : d < 1) (ht : -1 ≤ t)
    (hsmall : 8*d*b ≤ a*(1-d)^2) :
    0 < a*(1+d*t)^2 + 2*d*t*b + (d^2/2)*c := by
  have h := near_real_finite_depth_gate a b c d t ha hb hc hd hd1 ht hsmall
  have hx : 0 < (1-d)^2 := by
    have : 0 < 1-d := by linarith
    positivity
  have hp : 0 < (3/4 : ℝ)*a*(1-d)^2 := by positivity
  linarith

end XiKernel
