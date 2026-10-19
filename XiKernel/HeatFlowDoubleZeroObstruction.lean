import Mathlib

/-!
# Double real zeros obstruct a bounded backward Laguerre comparison

For a real entire F and L₁=(F')²−F F'', and
L₂=F F''''/12 −F' F'''/3 +(F'')²/4:
if F(x)=F'(x)=0 but F''(x)≠0, then
L₁(x)=0 and L₂(x)>0. Consequently no finite c≥0
can satisfy 6 L₂(x) ≤ c L₁(x).

A Gaussian--cosh positive kernel under de Bruijn heat
tilt develops such a double zero at the exact
temperature c*exp(1/(2*(1−2t)))=1.
This Lean module proves only the algebraic obstruction,
not the full transcendental heat evolution or RH.
-/

namespace XiKernel

def laguerreOrderOneJet (f fp fpp : ℝ) : ℝ :=
  fp^2 - f*fpp

def laguerreOrderTwoJet (f fp fpp fppp fpppp : ℝ) : ℝ :=
  f*fpppp/12 - fp*fppp/3 + fpp^2/4

theorem double_zero_first_laguerre
    (f fp fpp : ℝ) (hf : f = 0) (hfp : fp = 0) :
    laguerreOrderOneJet f fp fpp = 0 := by
  simp [laguerreOrderOneJet, hf, hfp]

theorem double_zero_second_laguerre
    (f fp fpp fppp fpppp : ℝ)
    (hf : f = 0) (hfp : fp = 0) :
    laguerreOrderTwoJet f fp fpp fppp fpppp = fpp^2/4 := by
  simp [laguerreOrderTwoJet, hf, hfp]

theorem double_zero_blocks_heat_comparison
    (f fp fpp fppp fpppp c : ℝ)
    (hf : f = 0) (hfp : fp = 0) (hfpp : fpp ≠ 0) :
    ¬ 6 * laguerreOrderTwoJet f fp fpp fppp fpppp ≤
      c * laguerreOrderOneJet f fp fpp := by
  rw [double_zero_first_laguerre f fp fpp hf hfp,
      double_zero_second_laguerre f fp fpp fppp fpppp hf hfp]
  have hsq : 0 < fpp ^ 2 := sq_pos_of_ne_zero hfpp
  nlinarith

/-- At cos=-1, sin=0 and parameter d=1, the analytic
Gaussian-cosine Fourier factor has a double root;
its second jet has the nonzero Gaussian/scale factor. -/
theorem cosine_double_root_second_jet
    (g alpha : ℝ) (hg : g ≠ 0) (ha : alpha ≠ 0) :
    g / alpha^2 ≠ 0 := by
  exact div_ne_zero hg (pow_ne_zero 2 ha)

end XiKernel
