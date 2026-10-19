# Verification ledger

## Completed with locally executed Python 3

- **PASS:** two exact polynomial two-cycles: `T(P0)=2 P1` and `T(P1)=2 P0` for the small Gaussian; corresponding factor 32 for the larger Gaussian.
- **PASS:** explicit nonreal Fourier root `4+i/4` of the large example, verified over rational Gaussian integers.
- **PASS:** small example's transform-level Laguerre value: `L_1[F](2)=-3278 exp(-8)`.
- **PASS:** analytic theta-tail upper bounds for eleven coefficients, via rational comparisons.
- **PASS:** directed integer interval computation for `T^5 s(0)` in `(-4.813e65,-4.812e65)`, with strict positive signs for levels 0–4.
- **PASS:** local PDF compilation and PDF extraction for the expanded manuscript in the research preparation environment.

## Lean 4.24.0 + Mathlib — GitHub CI PASS (19 October 2026)

**PASS:** [GitHub Actions Lean run #39182546267](https://github.com/tonynewton79-web/RiemannHypothesis/actions/runs/39182546267) on commit `922ed6c6` completed successfully. The successful job includes installation, Lake dependency resolution, and the Mathlib compilation action. The module `XiKernel/Algebra.lean` certifies polynomial two-cycles, positivity subclaims, an exact complex Fourier-polynomial zero, and arithmetic for the Fourier-side negative Laguerre value. It does **not** formalize the infinite-iteration theorem, Gaussian Fourier integration, analytic theta tail or fifth-iterate interval computation in Lean.

## Verification trust audit (19 October 2026)

- **PASS:** [Lean audit workflow run #39184421717](https://github.com/tonynewton79-web/RiemannHypothesis/actions/runs/39184421717).
- `XiKernel.centerMoment_pos`, `XiKernel.correlation_quadratic_gate`, and `XiKernel.large_fourier_complex_zero` depend only on standard Mathlib axioms `[propext, Classical.choice, Quot.sound]`.
- `XiKernel.rational_jet_fifth_negative` uses `native_decide`; `#print axioms` explicitly reports `Lean.ofReduceBool` and `Lean.trustCompiler`, in addition to the standard axioms. This is compiler-assisted reflection, **not a small-kernel-only check**. It still proves only the sign of the rational approximation jet, not the genuine theta-kernel fifth-iterate inequality.

## Not established

- A Lean formalization of the actual theta-kernel fifth iterate, Machin/pi bounds, or analytic theta-tail estimate.
- The Riemann hypothesis or the existence of any off-critical-line Riemann zero.
- Priority/novelty or peer review.
- Publication of reserved DOI [10.5281/zenodo.23461586](https://doi.org/10.5281/zenodo.23461586).

## 19 October 2026 — Curvature endpoint and actual xi formalization

- **PASS, standard-axiom Lean:** [Run #39188217443](https://github.com/tonynewton79-web/RiemannHypothesis/actions/runs/39188217443) verifies `first_summand_negative_near_modular_y`, `first_summand_positive_above_threshold`, `weighted_curvature_gate_positive`, `xiEntire_functional_eq`, `xiEntire_entire`, `XiOnLine_even`, and `XiOnLine_entire`. `#print axioms` shows only `propext`, `Classical.choice`, and `Quot.sound` for these declarations.
- **PASS:** [Updated Lean build #39188316189](https://github.com/tonynewton79-web/RiemannHypothesis/actions/runs/39188316189) on manuscript integration commit `ae38d39d`; source proof declarations unchanged.
- **PASS:** [Exact theta fifth-iterate certificate #39188314713](https://github.com/tonynewton79-web/RiemannHypothesis/actions/runs/39188314713) and [updated six-page PDF compilation #39188314731](https://github.com/tonynewton79-web/RiemannHypothesis/actions/runs/39188314731).
- **Analytic results, not formalized end-to-end in Lean:** first-summand curvature has a negative sign near the modular point but positive sign for `y>=7/2`; the full kernel curvature is positive for sufficiently small and sufficiently large positive arguments. The exact identity `V'''(u)=8*(d/dt)[t^(3/2)*T(s)/s^2]_(t=u^2)` reduces the full curvature question to weighted-defect monotonicity.
- **Open:** prove this weighted-defect monotonicity globally, certify a noncentral all-real-x generalized Laguerre hierarchy, and formalize the equivalence of Mathlib's `RiemannHypothesis` with the real-zero property of `XiOnLine`. These are *not* proved by building the module.
- **Trust distinction:** the finite rational jet checked with `native_decide` still depends on `Lean.ofReduceBool` and `Lean.trustCompiler`, unlike the newly audited standard-axiom theorems.

Reserved DOI: 10.5281/zenodo.23461586 (unpublished). No RH proof or disproof; no originality claim.
