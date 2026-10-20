import Mathlib

/-!
# Compact transfer for the genuine theta heat-flow Laguerre comparison

Let U_n=L_n[H], V_n=(n+1)*(2*n+1)*U_(n+1),
and U_nM,V_nM be the first M square-lattice approximants.

On a fixed compact heat/frequency rectangle K, let
|U_n-U_nM|<=eps_n, |U_(n+1)-U_(n+1)M|<=eps_np1
and 0<=c<=C on K.

Then the exact comparison defect satisfies
V_n-c*U_n <= V_nM-c*U_nM + k*eps_np1+C*eps_n.

Thus a *certified finite-mode negative margin* larger than
the explicit theta errors transfers to the true heat flow.
This proof gate involves no division by U_n and requires no
a priori sign of U_n. It is not a global RH proof.
-/

namespace XiKernel

theorem compact_spatial_defect_transfer
    (U Uapprox V Vapprox c C epsU epsV k margin : ℝ)
    (hcoeff : 0 ≤ c) (hcap : c ≤ C)
    (hC : 0 ≤ C) (heU : 0 ≤ epsU) (heV : 0 ≤ epsV)
    (hV : V - Vapprox ≤ k*epsV)
    (hU : |U-Uapprox| ≤ epsU)
    (hfinite : Vapprox - c*Uapprox ≤ -margin)
    (hmargin : k*epsV+C*epsU ≤ margin) :
    V ≤ c*U := by
  have hdiff : Uapprox-U ≤ epsU := by
    have hi := (abs_le.mp hU).1
    linarith
  have hterm : c*(Uapprox-U) ≤ C*epsU := by
    calc
      c*(Uapprox-U) ≤ c*epsU :=
        mul_le_mul_of_nonneg_left hdiff hcoeff
      _ ≤ C*epsU := mul_le_mul_of_nonneg_right hcap heU
  linarith

/-- Negative-tail artefacts forbid a direct all-real-axis finite-mode
comparison at odd Laguerre orders: U_nM<0<V_(n+1)M. -/
theorem odd_cutoff_blocks_global_spatial_comparison
    (Uodd Veven c : ℝ) (hu : Uodd < 0)
    (hv : 0 < Veven) (hc : 0 ≤ c) :
    ¬ Veven ≤ c*Uodd := by
  have hprod : c*Uodd ≤ 0 := mul_nonpos_of_nonneg_of_nonpos hc (le_of_lt hu)
  linarith

/-- The error budget is explicit and nonnegative, and vanishes
as soon as all three certified inputs vanish. -/
theorem compact_error_budget
    (k C epsnext epscurrent : ℝ)
    (hk : 0 ≤ k) (hC : 0 ≤ C)
    (henext : 0 ≤ epsnext) (hecur : 0 ≤ epscurrent) :
    0 ≤ k*epsnext+C*epscurrent := by
  positivity

/-- Strict certificate margin may be chosen rationally after
the theta errors have been bounded. -/
theorem strict_compact_margin
    (sampleDefect k C epsnext epscurrent eta : ℝ)
    (h : sampleDefect + k*epsnext+C*epscurrent ≤ -eta)
    (heta : 0 < eta) :
    sampleDefect + k*epsnext+C*epscurrent < 0 := by
  linarith

end XiKernel
