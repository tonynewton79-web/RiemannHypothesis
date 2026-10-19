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
