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

## 19 October 2026 — Square-lattice arithmetic and Fourier truncation attack

**Exact analytical theorem (prior-art/independent review pending).** In the actual Jacobi-theta kernel, the modular identity forces **all odd endpoint derivatives to cancel**:

`sum_{m>=1} (pi*m²)*exp(-pi*m²)*P_(2j+1)(pi*m²) = 0` for every j>=0,
where `P0=2q-3` and `P_(j+1)=(5-4q)P_j+4qP_j'`.

As a consequence, **every finite mode cutoff M>=1** has a positive first-derivative defect `D_M=f_M'(0)>0`, and its cosine Fourier transform has asymptotics `F_M(x)=-2D_M/x²+O(x^-4)`, `L1[F_M](x)=-8D_M²/x^6+O(x^-8)<0` for sufficiently large |x|. The full kernel has all odd derivatives zero and decays superalgebraically in Fourier frequency; finite cutoffs cannot preserve the required global sign structure.

**Uniform-in-all-real-frequency tail theorem.** For every k>=0, M>=1 and real x, with q=pi(M+1)²,
`|F^(k)(x)-F_M^(k)(x)| <= 3*k!*q*exp(-q)/4^k`.
Set `C=exp(-pi)*(pi+3+6/pi+6/pi²)+12*pi*exp(-4*pi)`. Then
`|L_n[F](x)-L_n[F_M](x)| <= 6*(2n+1)*C*q*exp(-q)/4^(2n)`.
These are explicit absolute bounds, not proof of global Laguerre positivity.

**Independent replay at x=39.5 (55 digits; NUMERICAL, not interval):**
`L1[F_1]=-5.741582122333544e-11`,
`L1[F_2]=+3.244986650069400e-11`,
`L1[F_3]=+3.244991626288171e-11`.
The first two square-lattice modes reverse the Laguerre sign.

**Proof and verification files:** `paper/square_lattice_uniform_fourier.tex`;
`XiKernel/SquareLatticeFourierTail.lean`,
`XiKernel/ModularOddJet.lean`,
`certificates/xi_square_lattice_uniform_tail.py`,
`certificates/xi_modular_odd_jet_exact.py`,
`certificates/xi_arithmetic_incomplete_gamma_replay.py`.
The incomplete-gamma representation is classical; prior art (DeFranco, Haglund, Polson) is cited. The complete theta modular identity/integration-by-parts proof is given analytically in TeX, **not certified end-to-end in Lean**. RH remains unresolved.

## 19 October 2026 — parity-preserving Gaussian test + zero-relevant complex-strip certificate

**Gaussian parity repair (analytic theorem):** For the positive even theta cutoff `P_M(u)=sum_{m<=M}phi_m(|u|)`, convolution `K_(M,sigma)=G_sigma*P_M` is positive, even and entire. Its Fourier transform satisfies
`F_(M,sigma)(z)=exp(-sigma²*z²/2)*F_M(z)`, so **every complex zero is preserved**. Its first generalized Laguerre expression is exactly
`L1[F_(M,sigma)](x)=exp(-sigma²*x²)*(L1[F_M](x)+sigma²*F_M(x)²)`.
For every fixed n>=0, asymptotically at high real |x|,
`L_n[F_(M,sigma)](x) ~ exp(-sigma²*x²)*4*D_M²*sigma^(2n)/(n!*x⁴)>0`.
Thus repairing all odd endpoint derivatives and eventual positive Laguerre tests does not fix the zero set.
A uniform approximation bound also holds:
`sup_real |F-F_(M,sigma)| <= E_M+sigma²(D_M+J_M)`,
where `E_M=3*pi*(M+1)²*exp(-pi*(M+1)²)` and
`J_M=integral_0^infty abs(f_M''(r))dr`.
Choose `sigma²=E_M/(1+D_M+J_M)` for a uniform error <`2E_M`.

**New complex-strip theorem (analytic):** For *every complex* z with `|Im z|<=7`,
`|F(z)-F_M(z)|<=E_M`.
For all derivative orders k and `|Im z|<=3`,
`|F^(k)(z)-F_M^(k)(z)|<=k!*E_M/4^k`.
This entire region covers the RH-relevant Fourier strip `|Im z|<1` (`s=1/2+i*z/2`). By Rouché, a bounded contour Gamma on which `min|F_M|>E_M` yields the *same zero count* for Xi and the cutoff.

**RH-equivalent zero-migration criterion (classical Hurwitz):** RH holds if and only if, for each `0<epsilon<1/2` and `R>0`, sufficiently deep theta approximants are eventually zero-free on the compact region `|Re z|<=R, epsilon<=|Im z|<=1-epsilon`. The **eventual zero-free property is NOT proved**; stating the equivalence does not solve RH.

**Exact files:** `paper/gaussian_parity_repair.tex`, `paper/complex_strip_rouche_attack.tex`; `XiKernel/GaussianParityRepair.lean`, `XiKernel/ComplexStripTransfer.lean`; `certificates/gaussian_parity_repair_exact.py`, `certificates/gaussian_parity_repair_numerical.py`, `certificates/xi_complex_strip_exact.py`, `certificates/xi_complex_strip_numerical.py`.

**Verification boundary:** Exact rational scripts test algebraic gates; separate 52/55-digit numerical replays cross-check complex-argument values. New Lean modules certify Gaussian multiplier/zero and strip modulus *subtheorems*, not the integral/Rouché/Hurwitz theorem end-to-end. No proof or disproof of RH, no novelty priority certification. Existing Csordas (2011) research on nonreal zeros of finite Fourier-Jacobi truncations is relevant prior art. The reserved DOI remains unpublished.
