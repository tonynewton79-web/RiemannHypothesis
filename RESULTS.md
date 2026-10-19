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

## Not established

- A Lean formalization of the actual theta-kernel fifth iterate, Machin/pi bounds, or analytic theta-tail estimate.
- The Riemann hypothesis or the existence of any off-critical-line Riemann zero.
- Priority/novelty or peer review.
- Publication of reserved DOI [10.5281/zenodo.23461586](https://doi.org/10.5281/zenodo.23461586).
