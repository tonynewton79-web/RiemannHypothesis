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

When Lean CI passes, it certifies only the theorem statements actually present in the Lean file.

## Background

- Planat–Sole, [arXiv:2608.19160](https://arxiv.org/abs/2608.19160), second-level theta-kernel concavity.
- Csordas, [arXiv:1309.0055](https://arxiv.org/abs/1309.0055), kernel and Fourier-transform phenomena.
- Liu–Mao, [arXiv:2610.04972](https://arxiv.org/abs/2610.04972), a distinct coefficient sequence's infinite log-concavity.
