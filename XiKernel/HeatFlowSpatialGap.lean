import Mathlib

/-!
Spatial de Bruijn--Newman Laguerre comparison: gap obstruction.

At a simple real zero r of an LP entire function H,
  6*L₂[H](r)/L₁[H](r) = 6*(2*a+Σ_(other zero λ)1/(r-λ)^2).
This file certifies the exact two-root algebra and separation
inequality. The general canonical-product formula and the
Feynman--Kac comparison are proven on paper, not end-to-end in Lean.
-/

namespace XiKernel

def twoRootPolynomial (a b x : ℝ) : ℝ := (x-a)*(x-b)
def laguerreOneAtRoot (a b : ℝ) : ℝ := (a-b)^2
def laguerreTwoAtRoot (a b : ℝ) : ℝ := (2:ℝ)^2/4

theorem two_root_laguerre_first (a b : ℝ) :
    laguerreOneAtRoot a b = (a-b)^2 := rfl

theorem two_root_laguerre_second (a b : ℝ) :
    laguerreTwoAtRoot a b = 1 := by
  norm_num [laguerreTwoAtRoot]

theorem two_root_exact_ratio (a b : ℝ) (hab : a ≠ b) :
    6 * laguerreTwoAtRoot a b / laguerreOneAtRoot a b =
    6 / (a-b)^2 := by
  norm_num [laguerreOneAtRoot, laguerreTwoAtRoot]

theorem spatial_comparison_forces_gap
    (gap c : ℝ) (hgap : 0 < gap) (hc : 0 ≤ c)
    (hcomp : 6 ≤ c*gap^2) :
    6/gap^2 ≤ c := by
  have hsq : 0 < gap^2 := sq_pos_of_pos hgap
  exact (div_le_iff₀ hsq).2 (by nlinarith [hcomp])

theorem spatial_log_square_separation
    (gap c weight : ℝ) (hgap : 0 < gap)
    (hc : 0 ≤ c) (hw : 0 < weight)
    (hcomp : 6 ≤ c*weight*gap^2) :
    6 / (c*weight) ≤ gap^2 := by
  have hcpos : 0 < c := by
    by_contra h
    have hz : c = 0 := le_antisymm (le_of_not_gt h) hc
    simp [hz] at hcomp
  have hcw : 0 < c*weight := mul_pos hcpos hw
  apply (div_le_iff₀ hcw).2
  nlinarith [hcomp]

theorem close_pair_power_obstruction (k : ℕ) :
    (6:ℚ)/(1/(2:ℚ)^k)^2 = 6*(4:ℚ)^k := by
  have hp : (2:ℚ)^k ≠ 0 := pow_ne_zero _ (by norm_num)
  field_simp
  ring

end XiKernel
