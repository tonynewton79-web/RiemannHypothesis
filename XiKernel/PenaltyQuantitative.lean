import Mathlib

/-!
# Quantitative penalty defect: pointwise bounds independent of RH

Let E_C=(v-C*u)_+, N=(-u)_+, with C>0, |v|<=M.
Then |E_C-C*N|<=M. Integrating these pointwise
inequalities against a positive, mass-one heat kernel
gives the unconditional, uniform Fourier-height
estimate
 |mathcalE_C(T,x)/C - integral_0^T P_(T-r)(-U_n)_+(x)dr|
    <= T*M_n/C.
The parabolic integral step is proved in the paper and
is NOT formalized by the elementary statements below.
RH is NOT proved. No axioms or sorry are introduced here.
-/
namespace XiKernel

theorem penalty_positive_part_upper
    (C u v M : ℝ) (hC : 0 ≤ C)
    (hM : 0 ≤ M) (hv : v ≤ M) :
    max (v-C*u) 0 ≤ C*max (-u) 0 + M := by
  have hneg : -u ≤ max (-u) 0 := le_max_left _ _
  have hpos : 0 ≤ max (-u) 0 := le_max_right _ _
  have hmul : C*(-u) ≤ C*max (-u) 0 :=
    mul_le_mul_of_nonneg_left hneg hC
  apply max_le
  · linarith
  · nlinarith [mul_nonneg hC hpos]

theorem penalty_positive_part_lower
    (C u v M : ℝ) (hC : 0 ≤ C)
    (hM : 0 ≤ M) (hv : -M ≤ v) :
    C*max (-u) 0 - M ≤ max (v-C*u) 0 := by
  have hl : v-C*u ≤ max (v-C*u) 0 := le_max_left _ _
  have hr : 0 ≤ max (v-C*u) 0 := le_max_right _ _
  rcases le_total u 0 with hu | hu
  · have hmax : max (-u) 0 = -u :=
      max_eq_left (neg_nonneg.mpr hu)
    rw [hmax]
    linarith
  · have hmax : max (-u) 0 = 0 :=
      max_eq_right (neg_nonpos.mpr hu)
    rw [hmax]
    nlinarith

theorem penalty_positive_part_sandwich
    (C u v M : ℝ) (hC : 0 ≤ C)
    (hM : 0 ≤ M) (hv : -M ≤ v ∧ v ≤ M) :
    C*max (-u) 0-M ≤ max (v-C*u) 0 ∧
    max (v-C*u) 0 ≤ C*max (-u) 0+M := by
  exact ⟨penalty_positive_part_lower C u v M hC hM hv.1,
    penalty_positive_part_upper C u v M hC hM hv.2⟩

theorem normalized_penalty_limit_gate
    (C M T J N : ℝ)
    (hC : 0 < C) (hM : 0 ≤ M)
    (hT : 0 ≤ T)
    (hl : C*N-T*M ≤ J) (hu : J ≤ C*N+T*M) :
    N-T*M/C ≤ J/C ∧ J/C ≤ N+T*M/C := by
  constructor
  · apply (le_div_iff₀ hC).2
    have h : (N-T*M/C)*C = C*N-T*M := by
      field_simp
      ring
    rw [h]
    exact hl
  · apply (div_le_iff₀ hC).2
    have h : (N+T*M/C)*C = C*N+T*M := by
      field_simp
      ring
    rw [h]
    exact hu

/-- Any uniform-in-C bound on the penalized source forces
the (nonnegative) smoothed negative part to vanish as C increases.
The analytic passage to the limit is not this Lean theorem. -/
theorem negative_part_finite_budget
    (C M T J N B : ℝ)
    (hC : 0 < C) (hT : 0 ≤ T) (hM : 0 ≤ M)
    (hl : C*N-T*M ≤ J)
    (hu : J ≤ B) :
    N ≤ (B+T*M)/C := by
  apply (le_div_iff₀ hC).2
  linarith

end XiKernel
