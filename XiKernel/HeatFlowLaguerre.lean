import Mathlib

/-!
# Algebra of the de Bruijn--Newman heat-flow Laguerre hierarchy.

For H_t(x) solving ∂_t H_t = -∂_x² H_t, put
Q_t(x,y)=H_t(x+i*y)*H_t(x-i*y).
Then ∂_t Q = (∂_y² Q-∂_x² Q)/2.
If Q=Σ_n L_n(x)y^(2*n), then
∂_t L_n=(n+1)(2*n+1)*L_(n+1)-(1/2)∂_x² L_n.

These kernel-checked statements prove *algebraic jet identities only*,
not the analytic interchange of the genuine Xi Fourier integral,
the known de Bruijn--Newman/Rodgers--Tao theorems, or RH.
-/
namespace XiKernel

/-- The product heat-PDE identity for abstract second-order jets. -/
theorem heat_laguerre_product_pde
    (a b da db d2a d2b : ℝ) :
    -(d2a*b+a*d2b) =
      ((-d2a*b + 2*da*db - a*d2b) -
       (d2a*b + 2*da*db + a*d2b))/2 := by
  ring

/-- Coupling for n=1: ∂t L₁=6 L₂ - (1/2)L₁''. -/
theorem first_laguerre_heat_coupling
    (f f1 f2 f3 f4 : ℝ) :
    (f2^2 + f*f4 - 2*f1*f3) =
      6*(f*f4/12 - f1*f3/3 + f2^2/4) -
      (f2^2-f*f4)/2 := by
  ring

/-- Coefficient test for the heat-evolved Gaussian at arbitrary order. -/
theorem gaussian_heat_hierarchy
    (n : ℕ) (x A : ℝ) (hA : A ≠ 0) :
    (2*((n : ℝ)+1))/A - 2*x^2/A^2 =
      (2*(n : ℝ)+1)/A - (4*x^2/A^2-2/A)/2 := by
  field_simp
  ring

/-- Heat tilting by -t*u² shifts only the quadratic Taylor coefficient. -/
theorem heat_tilt_preserves_cubic_jet
    (a0 a1 a2 a3 t u : ℝ) :
    (a0 + a1*u + a2*u^2 + a3*u^3 - t*u^2) =
      (a0 + a1*u + (a2-t)*u^2 + a3*u^3) := by
  ring

end XiKernel
