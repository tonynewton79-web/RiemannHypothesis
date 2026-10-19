import XiKernel.Algebra
import XiKernel.TransformMoment
import XiKernel.RationalJet
import XiKernel.FirstSummandCurvature
import XiKernel.EntireXi
import XiKernel.GlobalCurvatureAlgebra
import XiKernel.RadialCurvatureCounterexample
import XiKernel.FiniteDepthBarrier
import XiKernel.NearRealFiniteDepth
import XiKernel.SquareLatticeFourierTail
import XiKernel.ModularOddJet
import XiKernel.GaussianParityRepair
import XiKernel.ComplexStripTransfer
import XiKernel.ContourMeshGate
import XiKernel.FirstZeroDiskGate
import XiKernel.SecondZeroDiskGate
import XiKernel.ThirdZeroDiskGate
import XiKernel.AdaptiveThetaCutoff
import XiKernel.FourthZeroDiskGate
import XiKernel.HeatFlowLaguerre
import XiKernel.HeatDuhamelSpectral
import XiKernel.ThetaMixtureObstruction
import XiKernel.SpatialHeatComparison
import XiKernel.HeatFlowDoubleZeroObstruction
import XiKernel.HeatFlowSpatialGap
import XiKernel.ThetaHeatTail
import XiKernel.HeatDoubleRootTransversality
import XiKernel.HeatZeroGapObstruction

/-!
Axiom audit:
This does not create any theorem; it prints dependencies of the existing proofs.
The native_decide test may rely on Lean.ofReduceBool, unlike kernel-reduced decide.
-/
import XiKernel.SpatialLaguerreEquivalence
import XiKernel.ZeroCompatibleDuhamel
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

#print axioms XiKernel.finite_depth_fourier_gate
#print axioms XiKernel.first_order_still_positive
#print axioms XiKernel.second_order_coefficient_negative

#print axioms XiKernel.near_real_finite_depth_gate
#print axioms XiKernel.near_real_strict

#print axioms XiKernel.square_lattice_tail_margin
#print axioms XiKernel.square_lattice_tail_factor

#print axioms XiKernel.square_lattice_tail_margin
#print axioms XiKernel.square_lattice_tail_factor
#print axioms XiKernel.higher_square_mode_negative
#print axioms XiKernel.finite_modular_defect_positive
#print axioms XiKernel.spurious_laguerre_coefficient_negative

#print axioms XiKernel.gaussian_laguerre_algebra
#print axioms XiKernel.gaussian_multiplier_zero_iff
#print axioms XiKernel.gaussian_cusp_leading_positive

#print axioms XiKernel.derivative_complex_strip_gate
#print axioms XiKernel.zeroth_complex_strip_gate
#print axioms XiKernel.strict_rouche_modulus_gate

#print axioms XiKernel.theta_derivative_rational_bound
#print axioms XiKernel.theta_two_mode_tail_rational_bound
#print axioms XiKernel.contour_4096_strict_gap

#print axioms XiKernel.first_zero_disk_margin
#print axioms XiKernel.certified_circle_modulus_gate
#print axioms XiKernel.two_mode_rouche_gap

#print axioms XiKernel.second_zero_boundary_exact_margin
#print axioms XiKernel.second_zero_disk_rouche_gap
#print axioms XiKernel.second_zero_comparison_gate

#print axioms XiKernel.third_zero_boundary_exact_margin
#print axioms XiKernel.third_zero_boundary_above_tail
#print axioms XiKernel.third_zero_disk_rouche_gate

#print axioms XiKernel.adaptive_theta_polynomial_margin
#print axioms XiKernel.adaptive_rouche_requires_modulus

#print axioms XiKernel.fourth_zero_exact_margin
#print axioms XiKernel.fourth_zero_tail_rational_gate
#print axioms XiKernel.fourth_zero_linear_comparison

#print axioms XiKernel.heat_laguerre_product_pde
#print axioms XiKernel.first_laguerre_heat_coupling
#print axioms XiKernel.gaussian_heat_hierarchy
#print axioms XiKernel.heat_tilt_preserves_cubic_jet

#print axioms XiKernel.double_zero_first_laguerre
#print axioms XiKernel.double_zero_second_laguerre
#print axioms XiKernel.double_zero_blocks_heat_comparison

#print axioms XiKernel.theta_heat_tail_gate
#print axioms XiKernel.theta_heat_tilt_bound
#print axioms XiKernel.theta_heat_missing_relative_gap

#print axioms XiKernel.heat_double_zero_laguerre_derivative
#print axioms XiKernel.heat_double_zero_laguerre_derivative_pos
#print axioms XiKernel.heat_quadratic_model_negative
#print axioms XiKernel.root_gap_first_jet_identity
#print axioms XiKernel.root_gap_second_jet_identity
#print axioms XiKernel.root_gap_second_lower
#print axioms XiKernel.root_gap_scaled_ratio_gate
#print axioms XiKernel.close_root_ratio_lower

#print axioms XiKernel.spatial_barrier_strict
#print axioms XiKernel.two_root_first_laguerre
#print axioms XiKernel.heat_collision_necessary_coefficient
#print axioms XiKernel.heat_collision_not_locally_finite

#print axioms XiKernel.adjacent_laguerre_zero_obstruction
#print axioms XiKernel.multiple_root_order_three_expansion
#print axioms XiKernel.multiplicity_ratio_identity
#print axioms XiKernel.quadratic_duhamel_nonnegative
#print axioms XiKernel.quadratic_duhamel_saturated

#print axioms XiKernel.spectral_deficit_identity
#print axioms XiKernel.spectral_source_weight_bounds
#print axioms XiKernel.atomic_heat_endpoint_negative
#print axioms XiKernel.atomic_heat_collision
#print axioms XiKernel.atomic_integrated_comparison_failure

#print axioms XiKernel.two_frequency_square_identity
#print axioms XiKernel.positive_gaussian_mixture_order
#print axioms XiKernel.impossible_upper_lower_at_witness

#print axioms XiKernel.two_root_exact_ratio
#print axioms XiKernel.spatial_comparison_forces_gap
#print axioms XiKernel.close_pair_power_obstruction
