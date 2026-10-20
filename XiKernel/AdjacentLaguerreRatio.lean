import Mathlib

/-!
# Adjacent-order Laguerre ratio dynamics: exact algebraic gates

For genuine Xi backward heat coefficients U_n, let
 k_n=(n+1)*(2*n+1), V_n=k_n*U_(n+1), W_n=k_(n+1)*U_(n+2).
The coupled heat equations imply the *division-free* identity
 U_n D(V_n)-V_n D(U_n)=V_n^2-k_n*U_n*W_n
where D=∂s-(1/2)∂xx.
Where U_n,V_n>0, the ratio R_n=V_n/U_n satisfies
 R_n,s=R_n,xx/2+(∂x log U_n)*R_n,x+R_n*(R_n-R_(n+1)).
Only the algebra and sign conditions are formalized here.
The PDE's analytic differentiation and the genuine theta Fourier
integral are proved on paper, NOT formalized end-to-end in Lean.

Order-monotonicity R_n<=R_(n+1) is false for elementary real-zero
polynomials, so it cannot be assumed to complete a maximum principle.
-/
namespace XiKernel

theorem adjacent_division_free
  (u v w k us vs uxx vxx : ℝ)
  (hu : us = uxx/2-v)
  (hv : vs = vxx/2-k*w) :
  u*(vs-vxx/2)-v*(us-uxx/2)=v^2-k*u*w := by
  rw [hu,hv]
  ring

theorem adjacent_ratio_reaction
  (u v w k : ℝ) (hu : u ≠ 0) (hv : v ≠ 0) :
  (v/u)*(v/u-k*w/v)=(v^2-k*u*w)/u^2 := by
  field_simp
  ring

theorem ratio_order_characterization
  (e1 e2 : ℝ) (he1 : 0 < e1) :
  (6*e1 ≤ 15*e2/e1) ↔ 2*e1^2 ≤ 5*e2 := by
  rw [le_div_iff₀ he1]
  constructor
  · intro h
    nlinarith
  · intro h
    nlinarith

theorem exact_root_pair_reverse_order :
  (15/101 : ℚ) < 303/50 := by
  norm_num

theorem exact_root_pair_first_ratio :
  (6:ℚ)*(101/100) = 303/50 := by
  norm_num

theorem exact_root_pair_second_ratio :
  (15:ℚ)*(1/100)/(101/100) = 15/101 := by
  norm_num

/-- Polynomial identity for the quadratic heat ratio at
d=x²+1-2s>0: R1=3/d and R2=0.
This is a model, not the genuine theta function. -/
theorem quadratic_ratio_reaction_identity (d x : ℝ) (hd : d ≠ 0) :
  6/d^2 =
    (-3/d^2+12*x^2/d^3) - 12*x^2/d^3 + 9/d^2 := by
  field_simp
  ring

/-- The Gaussian heat solution has R_n=(2n+1)/A,
R_(n+1)=(2n+3)/A. The reaction is strictly negative. -/
theorem gaussian_ratio_reaction
  (n : ℕ) (A : ℝ) (hA : A ≠ 0) :
  ((2*(n:ℝ)+1)/A) *
    (((2*(n:ℝ)+1)/A)-((2*(n:ℝ)+3)/A)) =
    -2*(2*(n:ℝ)+1)/A^2 := by
  field_simp
  ring

end XiKernel
