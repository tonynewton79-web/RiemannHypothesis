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

## 19 October 2026: global theta-curvature certificate

- **PASS (exact Python):** `certificates/xi_global_curvature_exact.py` certifies `H'(x)>46` on 100 rational outward-rounded subintervals from `pi` to `7/2`, and `H(x)>26` across 400 subintervals `[7/2,6]`.
- **PASS (analytic infinite range):** exact algebra `H0=x(8x^3-36x^2+42x-45)>7x^4/4`, a geometric ratio bound on the `m>=2` theta tail, and the rational `e^3>20` inequality yield `H>0` on `[6,infinity)`. Combined with modular evenness `H(pi)=0`, this proves `V'''(u)>0` for all real `u>0` in the exact arithmetic/analytic proof package.
- **PASS (independent numeric cross-check):** 70-digit mpmath derivatives of the original theta series reproduce the normalized rational-polynomial curvature function at x approximately `pi,3.18,3.5,4,6,10,20`; this is independent evidence, not the proof itself.
- **LEAN SCOPE:** `XiKernel/GlobalCurvatureAlgebra.lean` formalizes the cubic leading polynomial identity, its `x>=6` margin, and the rational infinite-tail constant inequality (GitHub CI result must be checked before asserting success). It does **not** formalize the infinite sum or 500 interval cells as a theorem about actual `Phi`.
- **Riemann hypothesis:** unresolved. The resulting all-order generalized Laguerre positivity band has finite width and does not exclude nonreal zeros globally.
- Full written proof: `paper/global_curvature_certificate.tex`. Reserved DOI 10.5281/zenodo.23461586 is **not yet published**; priority is unverified.

## 19 October 2026 — Fourier-side curvature sufficiency falsified

- **EXACT:** global radial-curvature positivity and uniform strong log-concavity hold for `exp(-u²/2)*(1+cosh u/2)`; transform is the explicit Gaussian-times-cosine function.
- **EXACT:** transform has no real zeros but has nonreal zeros at `(2k+1)pi +- i*acosh(1/d)`, `d=exp(1/2)/2`.
- **EXACT:** first transform Laguerre expression `L1[F](pi)=2*pi*exp(-pi²)*(1-d)*(1-2d)<0`.
- **EXACT:** parameter family `c>=1/2` has positive third potential derivative while Fourier zeros transition at `c=exp(-1/2)`.
- **RATIONAL REGRESSION:** `certificates/gaussian_cosh_fourier_obstruction.py` proves needed exponential bounds without floating-point decisions.
- **LEAN SCOPE:** `XiKernel/RadialCurvatureCounterexample.lean` formalizes algebraic and sign gates. Do not call the complete analytic Gaussian Fourier integral or the full curvature derivative machine-checked unless separately formalized in Lean.
- **INDEPENDENT CROSS-CHECK:** mpmath numerical quadrature at complex root agrees with analytic transform to ~1e-63 absolute error.
- **RH STATUS:** unresolved. This is a rigorous falsifying case for an *overly general implication*, not a counterexample to RH.
