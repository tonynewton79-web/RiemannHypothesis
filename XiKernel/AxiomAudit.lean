import XiKernel.Algebra
import XiKernel.TransformMoment
import XiKernel.RationalJet
import XiKernel.FirstSummandCurvature
import XiKernel.EntireXi
import XiKernel.GlobalCurvatureAlgebra
import XiKernel.RadialCurvatureCounterexample

/-!
Axiom audit:
This does not create any theorem; it prints dependencies of the existing proofs.
The native_decide test may rely on Lean.ofReduceBool, unlike kernel-reduced decide.
-/
#print axioms XiKernel.centerMoment_pos
#print axioms XiKernel.correlation_quadratic_gate
#print axioms XiKernel.rational_jet_fifth_negative
#print axioms XiKernel.large_fourier_complex_zero

#print axioms XiKernel.first_summand_negative_near_modular_y
#print axioms XiKernel.first_summand_positive_above_threshold
#print axioms XiKernel.weighted_curvature_gate_positive
#print axioms XiKernel.xiEntire_functional_eq
#print axioms XiKernel.xiEntire_entire
#print axioms XiKernel.XiOnLine_even
#print axioms XiKernel.XiOnLine_entire

#check RiemannHypothesis

#print axioms XiKernel.leading_curvature_numerator
#print axioms XiKernel.leading_large_margin
#print axioms XiKernel.large_tail_margin

#print axioms XiKernel.mixture_strong_convexity
#print axioms XiKernel.mixture_third_curvature_pos
#print axioms XiKernel.fourier_laguerre_failure

#print axioms XiKernel.mixture_family_third_curvature_pos
#print axioms XiKernel.fourier_mixture_positive_on_real
