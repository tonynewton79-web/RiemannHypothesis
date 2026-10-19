# Riemann Xi kernel: fifth-iterate obstruction and counterexamples

**Research note by Tony Newton — Newton Astro Labs (London, UK).**

**Status: RH is not solved or disproved.** This repository tests a kernel-concavity hierarchy and records a rigorous computer-assisted inequality for the actual Jacobi-theta kernel. The fifth iterate of T(f)=(f')²-ff'' at the modular point is negative, whereas levels 0–4 are positive.

## Main claims

- For s(t)=Phi(sqrt(t)), with the classical even Jacobi-theta kernel, exact outward-rounded rational arithmetic establishes
  `-4.813e65 < T^5 s(0) < -4.812e65`.
- Gaussian-polynomial kernels can pass *every* kernel T-iteration but have Fourier transforms with nonreal zeros.
- For the smaller example, the first *Fourier-side* Laguerre expression already fails: `L_1[F](2)=-3278*exp(-8)<0`.

## Research artefacts

- `paper/main.tex`: the complete expanded two-column paper.
- `XiKernel/Algebra.lean`: Lean 4 + Mathlib certificates for algebraic subclaims, **not** a Lean proof of the theta-tail bound or RH.
- `certificates/xi_fifth_iterate_exact.py`: dependency-free rigorous fixed-point integer intervals for the fifth iterate, including Machin-series enclosure of pi, analytic theta tails and rational Taylor bounds.
- `certificates/check_gaussian_examples.py`: separate exact arithmetic regressions for the Gaussian-polynomial examples.
- GitHub Actions workflows for Python exact checks and Lean compilation.

## DOI and reuse

**Reserved DOI (not published):** [10.5281/zenodo.23461586](https://doi.org/10.5281/zenodo.23461586). An assigned/reserved DOI is **not** evidence of an available Zenodo record.

This is a research draft; prior-art and independent specialist review are still required. Do not describe it as a proof of the Riemann hypothesis or as completely Lean certified.

## Reproduction

```sh
python3 certificates/check_gaussian_examples.py
python3 certificates/xi_fifth_iterate_exact.py
lake exe cache get
lake build
cd paper && pdflatex -interaction=nonstopmode -halt-on-error main.tex
```

**Lean CI PASS (19 October 2026):** [GitHub Actions run #39182546267](https://github.com/tonynewton79-web/RiemannHypothesis/actions/runs/39182546267) successfully compiled the algebraic module with Lean 4.24.0 / Mathlib. It certifies only the theorem statements actually present in the Lean file. The fifth-iterate analytical bound is a separate exact Python interval certificate and remains outside the Lean proof assistant.

## Background

- Planat–Sole, [arXiv:2608.19160](https://arxiv.org/abs/2608.19160), second-level theta-kernel concavity.
- Csordas, [arXiv:1309.0055](https://arxiv.org/abs/1309.0055), kernel and Fourier-transform phenomena.
- Liu–Mao, [arXiv:2610.04972](https://arxiv.org/abs/2610.04972), a distinct coefficient sequence's infinite log-concavity.

### Trusted-kernel audit

[Lean axiom audit](https://github.com/tonynewton79-web/RiemannHypothesis/actions/runs/39184421717) confirms the exact central-moment and Gaussian identities use standard Mathlib axioms only. The large rational-jet test uses `native_decide` and therefore additionally depends on `Lean.ofReduceBool` and `Lean.trustCompiler`. It is compiler-assisted verification of an approximate jet, **not** a small-kernel proof of the theta series sign. The analytic theta identity and strict fifth sign remain outside Lean; see [formalization issue #1](https://github.com/tonynewton79-web/RiemannHypothesis/issues/1).

### Transform-side research

The cumulative paper now includes all-order Fourier correlation identities, the exact local positivity band, 40 high-precision noncentral generalized Laguerre tests, and a conditional radial-curvature criterion. The global curvature hypothesis for the actual theta kernel has **not been proved**; see [issue #3](https://github.com/tonynewton79-web/RiemannHypothesis/issues/3).

## 19 October 2026 — Global curvature theorem certified

**New computer-assisted, exact-arithmetic theorem (external specialist review pending):** for the classical Riemann theta kernel `Phi(u)`, the potential `V(u)=-log(Phi(u))` has **`V'''(u)>0` for every u>0**.

The proof uses the exact change of variables `x=pi exp(4u)`, a positive denominator `A0(x)`, and a rational-polynomial numerator `H(x)` with `V'''=64 H/A0^3`. Jacobi modular evenness provides `H(pi)=0`. The mandatory Python certificate proves `H'>46` in 100 rational cells from pi to 7/2 and `H>26` in 400 cells from 7/2 to 6; the unbounded range x>=6 is closed analytically by an explicit `6144 exp(-3x)` perturbation envelope and strict quartic margin.

**Consequence:** the previously conditional moment-ratio theorem is now applicable to the true theta kernel: `B_(n+1)/A_(n+1) <= B_n/A_n`. Thus all generalized Laguerre expressions are positive for every n>=1 within the common `|x|<sqrt(2*A1/B1)` interval (Fourier variable). This is **not** a proof of RH: the inequalities outside that bounded interval remain unproved.

Reproduce directly with `python certificates/xi_global_curvature_exact.py`. See `paper/global_curvature_certificate.tex` and [Issue #3](https://github.com/tonynewton79-web/RiemannHypothesis/issues/3). The algebraic large-tail margin has been submitted for separate Lean CI in `XiKernel/GlobalCurvatureAlgebra.lean`; the full analytic theta-series proof is **not yet end-to-end Lean formalized**.

Reserved DOI 10.5281/zenodo.23461586 is unpublished; novelty is not established.

## 19 October 2026 — Crucial Fourier-side counterexample

A new exact Gaussian--cosh example separates **global radial curvature** from global Fourier Laguerre positivity:

`K(u)=exp(-u^2/2)*(1+cosh(u)/2)`,
`(-log K)'' >= 2/3`, and
`(-log K)'''(u)>0` for every `u>0`.

But `F(z)=sqrt(2*pi)*exp(-z^2/2)*(1+d*cos z)`, `d=exp(1/2)/2` between `1/2` and `1`, has explicit nonreal zeros and
`L1[F](pi)=2*pi*exp(-pi*pi)*(1-d)*(1-2*d)<0`.

This **rules out extrapolating the global curvature theorem by itself to all real Fourier arguments**. The curvature theorem for the *actual theta kernel* is unaffected. The resulting common bounded Laguerre band is still valid; RH remains unproved.

A full family `K_c=exp(-u²/2)*(1+c*cosh u)`, `c>=1/2`, has positive radial third curvature and crosses from nonreal to real Fourier zeros precisely at `c=exp(-1/2)`. See `paper/radial_curvature_fourier_counterexample.tex`, Lean polynomial module `XiKernel/RadialCurvatureCounterexample.lean` and exact rational regression `certificates/gaussian_cosh_fourier_obstruction.py`.

**Next gate**: genuine theta-specific Fourier-correlation positivity across all real frequencies, not generic curvature or pointwise positive correlation densities. Novelty of the example is not established.

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
