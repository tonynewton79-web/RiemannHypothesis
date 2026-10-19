import Mathlib

/-!
# The actual entire Riemann xi function in Mathlib

Mathlib defines completedRiemannZeta₀(s) as an entire modification
of Λ(s)=π^(-s/2) Γ(s/2) ζ(s), with the simple poles subtracted.
The exact identity ξ(s) = (1+s(s-1) Λ₀(s))/2 extends through 0 and 1.

These proofs connect our project to genuine zeta infrastructure.
They do NOT show that ξ has only critical-line zeros or prove RH.
-/

namespace XiKernel

noncomputable def xiEntire (s : ℂ) : ℂ :=
  (1 + s * (s - 1) * completedRiemannZeta₀ s) / 2

theorem xiEntire_zero : xiEntire 0 = 1/2 := by
  simp [xiEntire]

theorem xiEntire_one : xiEntire 1 = 1/2 := by
  simp [xiEntire]

theorem xiEntire_functional_eq (s : ℂ) :
    xiEntire (1 - s) = xiEntire s := by
  unfold xiEntire
  rw [completedRiemannZeta₀_one_sub]
  ring

theorem xiEntire_entire : Differentiable ℂ xiEntire := by
  unfold xiEntire
  have hpoly : Differentiable ℂ (fun s : ℂ => s * (s - 1)) := by
    fun_prop
  have hprod : Differentiable ℂ (fun s : ℂ => s * (s - 1) * completedRiemannZeta₀ s) :=
    hpoly.mul differentiable_completedZeta₀
  have hsum : Differentiable ℂ (fun s : ℂ => 1 + s * (s - 1) * completedRiemannZeta₀ s) :=
    (differentiable_const (1 : ℂ)).add hprod
  exact hsum.div_const (2 : ℂ)

/-- The actual critical-line Xi entire function, with the Fourier
variable z scaled so that the first real zero is at ~28.269... -/
noncomputable def XiOnLine (z : ℂ) : ℂ :=
  xiEntire ((1/2 : ℂ) + Complex.I * z / 2)

theorem XiOnLine_even (z : ℂ) :
    XiOnLine (-z) = XiOnLine z := by
  unfold XiOnLine
  have harg : (1/2 : ℂ) + Complex.I * (-z) / 2 =
      1 - ((1/2 : ℂ) + Complex.I * z / 2) := by
    ring
  rw [harg, xiEntire_functional_eq]

theorem XiOnLine_entire : Differentiable ℂ XiOnLine := by
  unfold XiOnLine
  have harg : Differentiable ℂ (fun z : ℂ => (1/2 : ℂ) + Complex.I * z / 2) := by
    fun_prop
  exact xiEntire_entire.comp harg

end XiKernel
