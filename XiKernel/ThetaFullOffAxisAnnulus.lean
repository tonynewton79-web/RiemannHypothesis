import Mathlib

/-!
# Full off-axis finite-annulus theta certificate: arithmetic core

The values of the theta transform and its derivatives, their analytic
quadrature/tail bounds, complex Taylor theorem, Rouche's theorem and
the diagonal RH argument are NOT formalized here. These statements
check only exact-rational implications of assumed certified bounds.
-/
namespace XiKernel

private def fullOffaxisR2 : ℚ := (1/5)^2 + (1/3)^2
private def fullOffaxisBase : ℚ := (1/5) * (913/10^7)
private def fullOffaxisTaylor : ℚ :=
  183/10^8 + (5302/10^8)*fullOffaxisR2/2 +
  (1/50000)*((2/5)*fullOffaxisR2)/6 +
  (1/141)*fullOffaxisR2^2/24
private def fullOffaxisHeat : ℚ :=
  (1/1500)*(5302/10^8 + (1/50000)*(2/5) +
               (1/141)*fullOffaxisR2/2) +
  (1/1500)^2 / (2*141)

theorem full_offaxis_radius_square :
    fullOffaxisR2 = 34/225 := by
  norm_num [fullOffaxisR2]

theorem full_offaxis_radius_enclosed :
    fullOffaxisR2 < (2/5:ℚ)^2 := by
  norm_num [fullOffaxisR2]

theorem full_offaxis_linear_boundary :
    fullOffaxisBase = 913/50000000 := by
  norm_num [fullOffaxisBase]

theorem full_offaxis_taylor_loss :
    fullOffaxisTaylor = 1095151763/85657500000000 := by
  norm_num [fullOffaxisTaylor, fullOffaxisR2]

theorem full_offaxis_heat_loss :
    fullOffaxisHeat = 38021719/95175000000000 := by
  norm_num [fullOffaxisHeat, fullOffaxisR2]

theorem full_offaxis_initial_margin :
    fullOffaxisBase - fullOffaxisTaylor =
      468954187/85657500000000 := by
  norm_num [fullOffaxisBase, fullOffaxisTaylor, fullOffaxisR2]

theorem full_offaxis_uniform_margin :
    fullOffaxisBase - fullOffaxisTaylor - fullOffaxisHeat =
      4347346399/856575000000000 := by
  norm_num [fullOffaxisBase, fullOffaxisTaylor, fullOffaxisHeat, fullOffaxisR2]

theorem full_offaxis_margin_positive :
    0 < fullOffaxisBase - fullOffaxisTaylor - fullOffaxisHeat := by
  rw [full_offaxis_uniform_margin]
  norm_num

theorem full_offaxis_pair_count :
    (2:ℕ) < 2*1+4 := by omega

theorem full_offaxis_scalar_rouche (model error : ℝ)
    (h : error < model) : 0 < model - error := by
  linarith

#print axioms full_offaxis_radius_square
#print axioms full_offaxis_taylor_loss
#print axioms full_offaxis_heat_loss
#print axioms full_offaxis_uniform_margin
#print axioms full_offaxis_margin_positive
end XiKernel
