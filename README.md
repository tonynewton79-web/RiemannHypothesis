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


## 19 October 2026 — First genuine Xi zero disk: finite interval-Simpson/Rouché certificate

The interval checker `certificates/xi_first_zero_interval.py` certifies that the **actual** complete Riemann `F(z)=xi(1/2+i*z/2)/4` has exactly **one real simple zero** in the disk `|z-28.269|<0.5`.

- Two-mode Fourier Taylor coefficients at `z0=28.269`: `|a0|<1e-6`, `a1<-17e-5`, `|a2|<52e-6`, with positive integrated Taylor remainder `|R3|<6e-6` for `|z-z0|<=1/2`.
- Consequently the entire circle satisfies `|F2(z)|>65e-6`, compared with its linear Taylor term `a1(z-z0)`.
- The proven full theta complex-strip bound gives `|F(z)-F2(z)|<=27*pi*exp(-9*pi)<1e-9` on the same circle, so two Rouché comparisons give exactly one zero for the true `F`. Reality follows by conjugation symmetry.
- **Rigor method:** mpmath.iv version 1.3.0 outward binary interval arithmetic, endpoint conversion to exact fractions, composite Simpson on `[0,2]` with fourth-derivative bounds, analytically proved `r>2` tails, and strict rational margin assertions. The checker passed for both **8192** and **16384** panels locally and in [GitHub interval CI run 39244890918](https://github.com/tonynewton79-web/RiemannHypothesis/actions/runs/39244890918).
- **Lean scope:** `XiKernel/FirstZeroDiskGate.lean` formalizes rational margins only, NOT the interval library's transcendental evaluations, Simpson quadrature, theta Fourier relation, or complex-analytic Rouché theorem.
- **Prior art:** location/existence of the first zeta zero at imaginary ordinate 14.134725141... is classical and extensively verified; this is a new reproducible finite-test route in this project, not a new zeta zero and not a claimed research priority.
- **Global gap:** no exclusion of nonreal zeros at arbitrary heights; RH remains **open**. Next challenge is a height-uniform certified contour modulus or adaptive `M=M(R)` with an effective global separation guarantee.


## 19 October 2026 — three disjoint genuine Xi zero disks, independently interval-certified

The same two-mode Jacobi-theta Fourier transform and exact complex-strip error theorem now certify **exactly one real simple zero in each of three disjoint disks**:

| Complex Fourier disk | Certified lower bound for |F2| on boundary | Two outward-rounded interval-Simpson panel counts |
| --- | ---: | --- |
| `|z-28.269|<1/2` | `65e-6` | `8192,16384` |
| `|z-42.04408|<1/10` | `105e-9` | `16384,32768` |
| `|z-50.02171516|<1/25` | `2e-9` (actual rational margin `2.46e-9`) | `49152,65536` |

For each disk the actual Xi Fourier transform satisfies `|F-F2|<1e-9` on its boundary, smaller than the strict certified lower bound. Two Rouché comparisons first show `F2` has one zero against its local linear Taylor term, then transfer the count to the **genuine** Xi function. Conjugation symmetry forces the unique zero to be real and simple.

**GitHub interval CI (completed with success):**
- [first disk — 39244890918](https://github.com/tonynewton79-web/RiemannHypothesis/actions/runs/39244890918)
- [second disk — 39248345083](https://github.com/tonynewton79-web/RiemannHypothesis/actions/runs/39248345083)
- [third disk — 39248816397](https://github.com/tonynewton79-web/RiemannHypothesis/actions/runs/39248816397)

**Trust boundary:** Uses pinned `mpmath.iv==1.3.0` with outward-rounded transcendental interval operations converted to exact rationals, analytic fourth-derivative Simpson and r>2 integral-tail error bounds, the classical Jacobi theta/Fourier identity, and Rouché's theorem. Lean formally checks **only** the rational comparison gates; it has not kernel-checked all quadrature or theta/Fourier analysis. The zero locations are classical prior art; this is a reproducible proof-method validation, not discovery of unknown zeta zeros.

**Riemann hypothesis:** still open. These checks do not exclude any zero outside the three bounded disks and do not prove zero-free off-real strips at arbitrary heights.

**Sources:** `certificates/xi_first_zero_interval.py`, `certificates/xi_second_zero_interval.py`, `certificates/xi_third_zero_interval.py`; `XiKernel/{FirstZeroDiskGate,SecondZeroDiskGate,ThirdZeroDiskGate}.lean`; `paper/complex_strip_rouche_attack.tex`.

## 19 October 2026 — Fourth classical Xi zero disk: adaptive three-mode local interval proof

**New finite computer-assisted theorem, not RH.** The genuine
`F(z)=xi(1/2+i*z/2)/4` has exactly one real simple zero in
`|z-60.849752252|<1/200`, established by two outward-rounded
Simpson interval runs and two classical Rouché comparisons.

The first three zero disks are centered at `28.269`, `42.04408`,
and `50.02171516`, each proven with the first two theta modes.
The fourth disk cannot be certified with the same two-mode absolute
error. Instead use **three theta modes**, whose complete infinite-tail
error on the critical complex strip is
`E3=3*(16*pi)*exp(-16*pi)<153/20^16<10^-18`.

The decisive quadrature improvement is an 80-cell **local** derivative
enclosure over `0<=r<=4/5`, replacing an extremely coarse global
fourth derivative bound. Exact Simpson formula, outward interval
transcendental calculations in `mpmath.iv==1.3.0`, and an analytic
`r>4/5` gamma-tail bound `<10^-16` give, at `z0=60.849752252`,
`F3(z0+w)=a0+a1*w+a2*w²+R3(w)` for `|w|<=1/200` with:
`|a0|<5e-13`, `a1>3.012e-9`,
`|a2|<1.5e-9`, `|R3|<5.2e-12`.
Thus `|F3|>9.3225e-12` throughout the boundary.
The source uses strictly rational comparisons; verified local
panel counts `24576` and `32768` and successfully replayed in
[dedicated GitHub CI #39253311159](https://github.com/tonynewton79-web/RiemannHypothesis/actions/runs/39253311159).

**Files:** `certificates/xi_fourth_zero_local_adaptive.py`,
`.github/workflows/xi-fourth-zero.yml`,
`XiKernel/FourthZeroDiskGate.lean`,
`paper/complex_strip_rouche_attack.tex`.

**Trust boundary:** `mpmath.iv` transcendental interval correctness,
composite Simpson remainder, Jacobi theta Fourier normalization,
analytic tail bounds, Rouché's theorem and conjugation symmetry.
Lean formally checks only the rational margin subclaims,
not the complete analytic theorem.
Four classical known zeros are now independently certified by this
particular method, but Platt–Trudgian already verified RH to
height `3e12`; no increase in finite verification height or
resolution of the Riemann hypothesis is claimed.

**Proof horizon:** A height-uniform relative contour lower bound
and a genuine exclusion of nonreal zeros at unbounded height remain missing.

## 19 October 2026 — genuine theta heat-flow / global RH mechanism audit

**Intrinsic theta-family obstruction:** For `Phi_t(u)=exp(t*u²)*Phi(u)`, the potential
`V_t(u)=-log Phi_t(u)=V_0(u)-t*u²` has exactly the same `V_t'''=V_0'''` for every heat time. Nevertheless by the established de Bruijn--Newman threshold `0<=Lambda<=1/2` (Rodgers--Tao 2020 and de Bruijn), `H_(-1)` has nonreal zeros and `H_(1/2)` has only real zeros. Thus **global theta curvature cannot, by itself, prove RH even within the true theta heat family**. This applies to the same classical theta kernel, not merely a Gaussian example.

**Coupled Laguerre heat-PDE:** `Q_t(x,y)=H_t(x+i*y)H_t(x-i*y)` satisfies `∂_tQ=(∂_y²Q-∂_x²Q)/2`. Its `y^(2n)` coefficient obeys
`∂_tL_n=(n+1)(2n+1)L_(n+1)-(1/2)∂_x²L_n`.
Backwards from t=1/2, `U_n(s,x)=L_(n,1/2-s)(x)` satisfies `∂_sU_n=(1/2)∂_x²U_n-(n+1)(2n+1)U_(n+1)`.
The negative source term identifies what global-in-order estimate is missing.

**Conditional sufficient theorem, UNPROVED for Xi:** If for all n>=1 and every real x, t in [0,1/2], there is a finite uniform-in-x nonnegative `c_n(t)` satisfying `(n+1)(2n+1)L_(n+1,t)(x)<=c_n(t)L_(n,t)(x)`, scalar parabolic comparison would propagate positivity from t=1/2 to t=0. This may be stronger than RH and its validity has not been established. A Gaussian model has `c_n(t)=(2n+1)/(4-2t)`.

**Verification:** exact SymPy algebra, exact Fraction arithmetic for 100 Gaussian Laguerre orders, and mpmath 65-digit evaluation of true theta third-curvature invariance at 4 arguments x 3 heat times all passed locally. `XiKernel/HeatFlowLaguerre.lean` contains algebraic jet lemmas; it is not a Lean proof of Rodgers--Tao, Jacobi integral calculus or RH. [Heat-flow CI](https://github.com/tonynewton79-web/RiemannHypothesis/actions) is tracked separately; do not call it passed until completed.

**Manuscript:** `paper/theta_heat_flow_barrier.tex`, integrated into `paper/main.tex`; citations Rodgers--Tao, Newman--Wu and Polymath15. **RH remains open.**

## 19 October 2026 — Bibliographic correction and new heat-flow double-zero Lean attack

- The recent heat-flow results were **not lost**: `paper/theta_heat_flow_barrier.tex`, `XiKernel/HeatFlowLaguerre.lean`, `certificates/xi_heat_flow_hierarchy_tests.py`, and the four finite Xi disk certification sources are retained in the repository.
- **New exact obstruction:** the positive Gaussian–cosh heat family has a double real zero at `t*=(1-1/(2 log 2))/2≈0.13932623978`; at it `L1=0<L2=F''²/4`. Thus the proposed uniform comparison `6 L2<=c1 L1` cannot hold at a double zero. This is a negative test of the *sufficient heat comparison mechanism*, **not** a counterexample to RH or a claim about the genuine Xi flow's zero count.
- Source: `XiKernel/HeatFlowDoubleZeroObstruction.lean` (Lean algebraic gate and axiom audit), `certificates/xi_heat_double_zero_test.py` (exact symbolic and numerical crossing), and the integrated `paper/theta_heat_flow_barrier.tex`. Local exact symbolic reproduction passed.
- **CI status:** the newest GitHub Actions Lean/PDF/heat workflow runs were still QUEUED when last checked; do not claim the added Lean declaration compiled until GitHub returns a completed successful run.
- A previously circulated 20-page PDF combined an 18-page cumulative manuscript with a two-page heat-flow addendum; the canonical LaTeX source now incorporates the heat-flow results directly. The GitHub LaTeX master integrates the new result in the main narrative; its fresh automatic build is pending.

**Next proof gate:** prove or refute an actual theta-specific heat comparison/zero-exclusion statement uniform in real x and all Laguerre orders, with independent mathematical review. RH is not proved.

## 19 October 2026 — Manuscript reconciliation, new abstract and theta-specific heat-flow result

**Canonical manuscript source:** `paper/main.tex` has a newly written problem-first abstract. The manuscript omits repository publication identifiers and retains only scholarly references. The eight main research sections remain, with the verification material promoted to Appendix A.

**Uploaded manuscript reconciliation:** the two 20-page PDFs share the same 18-page main content but have distinct two-page addenda. The longer previously circulated addendum states the Gaussian-cosh double-real-zero theorem more precisely. That theorem, its correct fourth-derivative Laguerre term, the de Bruijn–Newman curvature invariance, and the coupled heat PDE were already included in `paper/theta_heat_flow_barrier.tex`. The alternative supplemental pages are **not** repeated in the canonical source.

**New theta-specific heat-flow estimate:** `paper/theta_heat_specific_tail.tex` proves uniformly for every `0<=t<=1/2`, all k>=0, and `|Im z|<=3`:
`|H_t^(k)(z)-H_(t,M)^(k)(z)| <= (3*k!/(2*4^k)) * q*exp(-q+1/16)`,
where `q=pi*(M+1)^2`. For k=0 the strip extends to `|Im z|<=7`. The genuine theta square-lattice proof uses `exp(4u)>=8u²`, exact incomplete gamma bounds, and an explicit positive quartic polynomial in `q-12`. This produces a uniform-in-heat-time **absolute** approximation bound for adjacent-order Laguerre source terms.

**All-order but bounded band:** conditional only on the earlier globally certified theta-curvature theorem, the paper derives an explicit common `|x|<r_*` positivity interval for all `n>=1` and all `t∈[0,1/2]`, where `r_*²=2 M0(0)M2(0)/(M0(1/2)M4(1/2))`, `M_j(t)=∫u^j exp(tu²)Phi(u)du`. This persists across the full backward heat interval **only within a bounded Fourier band**, not globally.

**Verification:** `certificates/xi_theta_heat_tail_exact.py` passed locally using exact rational operations, including the quartic identity and combinatorial cancellations for n=0..80. `XiKernel/ThetaHeatTail.lean` contains polynomial and tilt sign subtheorems submitted to the Lean CI build; the full theta-series and Fourier integral proof is NOT end-to-end Lean formalized. See the current GitHub Actions status before declaring this new Lean module CI-PASS.

**Unresolved RH step:** all-order global Fourier positivity or a height-uniform off-axis contour modulus lower bound. RH remains open. Prior-art/novelty review is pending.

## 19 October 2026 — Newman GHS prior-work correction and citations

Charles M. Newman's 1991 article, *The GHS Inequality and the Riemann Hypothesis* (*Constructive Approximation* **7**, 389–399), proves convexity of the classical Riemann theta potential derivative. The qualitative monotone-curvature property is therefore **known prior art**. Our rational-interval proof is an alternative quantitative verification, not a discovery of the curvature property. The canonical manuscript now cites Newman in the abstract, curvature theorem, heat-flow discussion and bibliography. Rodgers–Tao and Newman–Wu are explicitly cited where their prior results are used, including in a corrected self-contained addendum (`paper/newman_corrected_addendum.tex`). The Zenodo identifier has been excluded from manuscript metadata and text by request. RH is not proved.

## 19 October 2026 — actual theta heat zero-density obstruction to global bounded comparison

**New theorem from classical zero density (analytical proof added to the complete paper):** At t=1/2, all zeros of the genuine de Bruijn–Newman H_t are real and simple (Ki–Kim–Lee; de Bruijn–Newman), and N_t(T)=T log T/(4π)+O(T). For any simple real zero a and any other zero b, the real-root canonical product proves

`L2[H_t](a)/L1[H_t](a) >= 1/(a-b)^2`.

The increasing density forces some adjacent gap in [T,2T] <=(4π+o(1))/log T; hence
`6L2[H_(1/2)](a)/L1[H_(1/2)](a) >= (3/(8π²)+o(1))log²T`
along an unbounded sequence. Thus
`sup_x 6L2[H_(1/2)](x)/L1[H_(1/2)](x)=infinity` on positive-denominator points.

**Implication:** the paper's earlier sufficient condition `6U2 <= c1(s)U1` with *bounded-in-height* c1(s) is impossible **for the actual theta heat flow already at its known real-zero initial time**. It is not merely unproved. The corrected sufficient hypothesis allows a nonnegative locally bounded spatial coefficient `c_n(s,x)`, with the necessary possibility of at least log²|x| growth in n=1 at s=0. A suggested log² global *upper* envelope is a proposed test, **not a proven inequality**. Any collision at some intermediate heat time could still defeat it.

**Exact reproducibility:** `paper/heat_zero_gap_global_obstruction.tex`, `XiKernel/HeatZeroGapObstruction.lean`, `certificates/xi_heat_zero_gap_exact.py`, `.github/workflows/xi-heat-zero-gap.yml`. Local symbolic and Fraction tests passed. GitHub Lean/CI runs have been queued; do not assert their success before completion. Published zero count and canonical product are cited mathematical inputs and NOT kernel-checked in Lean.

**Paper and DOI:** The full GitHub manuscript integrates the result inside its heat-flow section. The user confirms DOI `10.5281/zenodo.23461586` is live; avoid obsolete 'reserved / not yet published' claims. No claim of RH proof or publication novelty. RH remains **OPEN**.

## 19 October 2026 — spatially dependent heat comparison: precise proof gate

**Corrected maximum-principle theorem.** For any bounded classical solution U on [0,T]×ℝ, local boundedness and nonnegativity of c(s,x) suffice for the implication
`U_s - U_xx/2 + c U >= 0; U(0,x)>=0 ⇒ U>=0`.
Proof: `W=U+epsilon exp(s)cosh(x)` has strictly positive PDE residual `epsilon exp(s)(1/2+c)cosh(x)` and dominates U at large |x|. Thus the proof **does not require a global `log²(2+|x|)` upper bound**.

**RH-conditional sufficient gate:** For every n>=1 and (s,x)∈[0,1/2]×ℝ, produce a nonnegative **locally bounded** coefficient c_n(s,x) such that
`(n+1)(2n+1) U_(n+1)(s,x) <= c_n(s,x) U_n(s,x)`,
`U_n(s,x)=L_(n,1/2-s)(x)` for the true Riemann heat transform. This is **unproved**. Merely defining c as a positive ratio is circular where U_n could vanish or change sign.

**Exact necessary gap cost (finite real-rooted polynomials):** At any simple root a of `G(z)=C∏(z-rho_j)`,
`L_n[G](a)=G'(a)^2 e_(n-1)((a-rho_j)^-2 : rho_j!=a)` and
`(n+1)(2n+1)L_(n+1)/L_n <= ((n+1)(2n+1)/n) sum_(rho!=a)(a-rho)^-2`.
At n=1 the required coefficient equals `6 sum_(rho!=a)(a-rho)^-2`. A universal log² upper envelope cannot follow from real-rootedness alone: for two roots a,b the exact ratio is `6/(a-b)^2`, arbitrarily large at bounded a if b approaches a. For the heat-polynomial `H_t=z²-2t`, the minimal required coefficient at x=0 is `3/(2t)` and diverges at a collision.

**Tests:** 131 exact rational real-rooted ratio checks, inverse-gap stress examples, exact polynomial heat-collision tests and positive cosh barrier algebra all PASS locally (Python standard library). Lean subtheorems committed to `XiKernel/SpatialHeatComparison.lean`; latest GitHub Actions remain queued and no pass is yet asserted.

**Full source:** `paper/spatial_heat_comparison.tex` included in the complete eight-section `paper/main.tex`, plus `certificates/xi_spatial_comparison_exact.py`. DOI `10.5281/zenodo.23461586` is now shown without obsolete 'reserved/unpublished' wording, as instructed by the user.

**Remaining research-critical step:** a noncircular theta-specific, all-order, entire-slab estimate providing locally finite c_n(s,x), especially across possible near-collisions. No RH proof yet.

## 19 October 2026 — Sharp spatial Laguerre gate, multiplicity obstruction and Duhamel reformulation

**Mathematical result (analytic derivation in main paper; no RH proof):** The proposed inequality
`(n+1)(2n+1)U_(n+1)(s,x) <= c_n(s,x) U_n(s,x)`
with finite locally bounded, nonnegative `c_n` for every order and every point of the *closed* heat slab is **equivalent**, using classical de Bruijn-Newman zero dynamics and real-zero canonical products, to **RH together with simplicity of all nontrivial zeta zeros**. Hence the global existence of these coefficients is *strictly stronger* than RH alone and is not a free technical upgrade.

**Exact multiplicity theorem:** If the real entire transform has a zero of multiplicity `m>=2` at `a`, then `L_(m-1)(a)=0`, `L_m(a)=g(a)^2>0`, and the locally necessary comparison ratio diverges as `(2m-1)/(x-a)^2`. No finite pointwise coefficient can close that inequality at the multiple zero.

**Zero-compatible alternative:** Duhamel's identity
`U_n(s)=P_s U_n(0) - (n+1)(2n+1) ∫_0^s P_(s-r) U_(n+1)(r) dr`
yields an integrated source inequality equivalent to nonnegative `U_n`, allowing equality at multiple zeros. It is **equivalent to RH**, rather than RH+simplicity, and is presently unproved for the theta heat family. Its role is to identify a noncircular theta-specific integrated-source estimate, not to claim RH.

**Verification:** `certificates/xi_spatial_equivalence_exact.py` has 445 exact rational multiplicity configurations `m=2..90` and 36 forced-heat Duhamel checks; all passed locally. `XiKernel/SpatialLaguerreEquivalence.lean` and `XiKernel/ZeroCompatibleDuhamel.lean` state algebraic kernels; GitHub Lean CI may be queued and **must not be claimed as passed until its run completes**. Analytic canonical products, PDE comparison, theta Fourier integrals, and heat-flow real-zero results are paper proofs and cited prior art, not Lean-complete.

**Publication wording:** The paper links directly to DOI `10.5281/zenodo.23461586`; the prior description of it as reserved/unpublished has been removed from the updated source. The full integrated LaTeX is on GitHub; a complete-paper PDF with this mathematical update appended is available separately while GitHub's new paper build is queued. RH and simplicity remain open.

## 19 October 2026 — integrated Duhamel source: exact spectral identity and falsifying test

The new full-manuscript section is in `paper/spatial_heat_comparison.tex` (within the existing eight-main-section structure).

**Exact identity for the genuine theta heat flow.** Let `nu(u)=exp(u²/2)*Phi(u)/2`, `a=u+v`, `b=u-v`, and `U_n(s,x)=L_n[H_(1/2-s)](x)`. Then the integrated Duhamel source equals
`1/(2n)! * integral integral b^(2n) exp(-s*a²/2)*(1-exp(-s*b²/2))*exp(i*x*a) dnu(u)dnu(v)`.
The semigroup budget has the same integrand without `1-exp(-s*b²/2)`. Their exact difference equals `U_n(s,x)`. Pointwise spectral domination is real and rigorous, but does not survive arbitrary oscillatory Fourier transformation as an inequality.

**Exact within-target-slab counterexample.** The positive even spectral measure `delta_0+(3/4)delta_{-1}+(3/4)delta_1` starts with `H_0(x)=1+(3/2)cos(x)`, which has only real zeros. Backward heat gives `H_s(x)=1+(3/2)exp(-s)cos(x)`. At `s=log(8/5)<1/2` and `x=pi`, `U_1=-15/256`; the source exceeds its heat-semigroup budget by exactly `15/256`. At the earlier collision `s=log(3/2)`, `U_1(pi)=0`, `U_2(pi)=1/4`. Thus neither naive positive-integrand source domination nor a finite spatial coefficient repairs the problem generically. Gaussian smoothing of the atomic measure retains the strict source failure, giving smooth positive Fourier kernels.

**Positive prospective gate (OPEN).** Explicitly construct positive Gaussian-mixture representations for each genuine theta correlation density `G_(n,s)(w)` across all `n,s`, or find a counterexample to the proposed mixture structure by interval-certified complete-monotonicity tests. This is stronger than mere positivity and would imply Fourier-positive Laguerre coefficients. It is NOT proved and might be false.

**Verification:** `python /mnt/data/xi_heat_duhamel_source_exact.py` passed locally (symbolic transfer identity, 101 exact all-order factorial gates, rational atomic values). The matching GitHub source is `certificates/xi_heat_duhamel_source_exact.py`. New Lean algebraic gates are in `XiKernel/HeatDuhamelSpectral.lean`. New GitHub Actions runs are QUEUED, not marked passed. No end-to-end Lean proof of the theta integral or RH.

**Publication:** The manuscript links to `https://doi.org/10.5281/zenodo.23461586` with no reserved/unpublished label, following the author's confirmed live-DOI status. A 21-page complete retained manuscript plus current heat-Duhamel supplement was compiled and emailed to the primary research address. RH remains open.

## 19 October 2026 — exact Duhamel spectral decomposition and *actual theta* Gaussian-mixture obstruction

### Exact new analytic theorems (not RH)
For the positive spectral theta measure dnu(u)=Phi(u)*exp(u²/2)du/2,
and U_n(s,x)=L_n[H_(1/2-s)](x), the integrated source has the exact
two-frequency form, a=u+v and b=u-v:
  source = 1/(2n)! ∬ b^(2n) exp(-s*a²/2)*(1-exp(-s*b²/2))*exp(i*x*a) dnu(u)dnu(v).
The semigroup budget has the same weight with the parenthesis omitted;
its difference from source equals U_n(s,x) **exactly**. Positive spectral
weights alone do not guarantee a positive oscillatory Fourier transform.

An explicit positive even atomic heat flow, H_s(x)=1+(3/2)exp(-s)cos(x),
has all real zeros at s=0 but at s=log(8/5)<1/2 has
U_1(s,pi)=-15/256: source overshoots heat budget by 15/256.
At s=log(3/2), U_1(s,pi)=0 while U_2(s,pi)=1/4,
invalidating every finite coefficient comparison there.
The strict source failure persists under sufficiently narrow
positive Gaussian smoothing. This is a counterexample to a
**general inference**, not to RH.

**Stronger genuinely theta-specific theorem:** the actual
two-frequency theta correlation G_(n,s)(w)>0 decays faster than
exp(-A*w²) for every fixed A>0, for each n>=0 and s∈[0,1/2].
No nonzero positive mixture ∫exp(-lambda*w²)ρ(dlambda)
can therefore represent G_(n,s), because any positive mixture
has at least one Gaussian lower envelope.
This refutes a proposed sufficient proof architecture; it does
NOT refute positive definiteness or RH. A genuinely constructive
square-lattice convolution-square decomposition remains unproved.

### Reproducibility and trust boundary
- Exact local Python/SymPy and Fraction audit passed:
  `certificates/xi_heat_duhamel_source_exact.py`
  (101 factorial cases and rational atomic time-slab witness).
- Exact rational Gaussian-mixture incompatibility checks passed:
  `certificates/xi_theta_mixture_no_go_exact.py`.
- Two new algebraic Lean files:
  `XiKernel/HeatDuhamelSpectral.lean` and
  `XiKernel/ThetaMixtureObstruction.lean`.
- The new Lean CI and PDF CI were QUEUED at writing;
  **do not describe them as passing or end-to-end Lean proofs**.
  The infinite theta-series super-Gaussian tail, the measure
  lower bound and heat-semigroup integration are paper proofs.
- Full cumulative 22-page manuscript was assembled locally
  from the previous complete 18-page paper plus a revised
  4-page mathematical supplement; the older PDF's obsolete
  reserved-DOI phrases were corrected.
- DOI link: https://doi.org/10.5281/zenodo.23461586
  (author reports it is live; no reserved or unpublished label).
- RH remains open and no original priority is claimed.

## 20 October 2026 — spatial heat comparison and microscopic gap constraint

**New exact theorem (analytic paper proof):** For any order-one Laguerre–Pólya entire function with real simple zeros, the first Laguerre adjacent-order quotient at a zero a is
`6*L2(a)/L1(a)=6*sum_(other zeros rho)1/(a-rho)^2`.
A global logarithmic-square pointwise comparison
`6*L2(x) <= C*(1+log(2+|x|)^2)*L1(x)` thus **forces**
`|a-b| >= sqrt(6/C)/sqrt(1+log(2+|a|)^2)`
for any distinct real zeros a,b.

**New counterexample to inference from zero density:** Choose `T_k=8*pi*k/log(k+e)`, `S_k=T_k+2^(-k)`, and the compactly convergent even Laguerre–Pólya product over the pairs ±T_k,±S_k. It has only simple real zeros and `N_+(T)~T*log(T)/(4*pi)`, the same leading positive-zero density as the theta heat family, while at T_k its required spatial coefficient is at least `6*4^k`. Therefore a logarithmic-square upper bound cannot be deduced from that zero density or real-rootedness alone. This *does not* disprove such a bound for the genuine Riemann theta family; it identifies the missing zero-separation mechanism.

**Formal/test scope:** `paper/spatial_heat_comparison.tex` now contains the theorem and proof. `XiKernel/HeatFlowSpatialGap.lean` formalizes only the finite two-root and rational separation algebra. `certificates/xi_spatial_gap_density_obstruction.py` checks finite exact fraction identities and provides diagnostics; the infinite canonical-product theorem is paper mathematics. Local exact tests passed; as checked, all newly triggered GitHub Actions runs remain **queued**, not passed. There is no end-to-end Lean theta heat-flow proof.

**Paper and DOI:** The repository source displays DOI 10.5281/zenodo.23461586 with no reserved-status wording. A locally compiled **21-page combined PDF** retaining the prior 18-page manuscript with the latest heat-flow continuation was emailed to tony.newton79@gmail.com on 20 October. A new one-piece PDF build of the complete current GitHub LaTeX source is still pending in CI.

**RH remains open.** The exact unresolved assertion is a theta-specific global comparison at all heat times and all Laguerre orders, or a genuinely new zero-exclusion mechanism that tolerates close pairs.

## 20 October 2026 — Strict high-order Duhamel source saturation (analytic theorem, RH open)

At backward heat time s∈(0,1/2], let B_n(s)=(P_s U_n(0))(0), D_n(s)=(n+1)(2n+1)∫_0^s(P_(s-r)U_(n+1)(r))(0)dr. For the **genuine positive Riemann theta kernel**:

- 0 < D_n/B_n < D_(n+1)/B_(n+1) < 1 for every n≥0.
- D_n(s)/B_n(s) → 1 as n→∞ for every fixed s>0. Therefore no order-independent fractional reserve η>0 can satisfy D_n≤(1−η)B_n at all orders, even at x=0.
- Proof: the positive full-support density W_s(b)=(1/2)∫ exp(−s w²/2)ν((w+b)/2)ν((w−b)/2)dw; ν(u)=(1/2)exp(u²/2)Φ(u). Then B_n=(2n)!⁻¹∫b^(2n)W_s(b)db, U_n(s,0)=(2n)!⁻¹∫b^(2n)exp(−s b²/2)W_s(b)db. Reverse covariance under b²-size bias proves monotonicity; a two-radius (R<L) moment estimate proves convergence to zero of U_n/B_n.
- Explicit Gaussian benchmark ν=e^(−a u²): U_n/B_n=(a/(a+s))^(n+1/2).
- Theta quadrature at s=1/4 gives source fractions 0.00839 (n=1), 0.02701 (n=5), 0.07391 (n=20), 0.16691 (n=80), 0.23145 (n=160); numerical diagnostics only.
- Sources: paper/duhamel_order_saturation.tex, XiKernel/DuhamelOrderSaturation.lean, certificates/xi_duhamel_order_saturation_exact.py; injected into spatial_heat_comparison.tex and exact Python CI.

**What this does NOT prove:** Failure of the original Duhamel inequality. At x=0 it holds strictly at each finite n. The outstanding RH-equivalent assertion is U_n(s,x)≥0 at every x, s and n. The new theorem shows that the necessary comparison cannot have an n-uniform positive relative margin.

**Verification:** local analytic proof and exact/rational diagnostic established; newest GitHub CI runs are QUEUED as of update, not reported as successful; no end-to-end Lean proof of full theta integrals. The complete 23-page PDF (prior 21-page paper plus 2-page continuation) was emailed to tony.newton79@gmail.com. DOI https://doi.org/10.5281/zenodo.23461586 is cited without 'reserved' qualification.

**Next actionable gate:** test a genuinely theta-specific Fourier-positive conditional-slice or signed-correlation decomposition, which would imply the source inequality without dividing by U_n. First attempt to falsify any proposed stronger slice condition before elevating it to an RH lemma.

## 20 October 2026 — Genuine theta conditional slices necessarily change sign at simple zeros

**New analytical theorem (RH is NOT assumed):**
Let `nu_t(u)=Phi(u)*exp(t*u²)/2` and `H_t(x)=int nu_t(u)*exp(i*x*u)du`.
Define a fixed-difference Fourier slice
`C_t(b,x)=(1/2) int_R nu_t((w+b)/2) nu_t((w-b)/2) cos(x*w) dw`.
Then
`int_b C_t(b,x)*exp(i*eta*b) db=H_t(x+eta)*H_t(x-eta)`
and
`int_b b^(2n) C_t(b,x) db=(2n)! L_(n,t)(x)`.
At every known **simple real** zero `a` of the actual theta transform,
`int C_t(b,a) db=0` but `int b² C_t(b,a) db=2*H_t'(a)^2>0`.
Thus the genuine theta slice **has both positive and negative values**.
Furthermore its `b`-Fourier symbol is
`-H_t'(a)^2*eta²+O(eta^4)<0` near eta=0.
Therefore neither pointwise slice positivity nor positive convolution-square/Gram
factorization **of the individual fixed-difference slices** is valid.
This disproves a proposed proof *shortcut*, not RH.

**Exact control:** positive measure (delta_-1+delta_+1)/2 at its simple cos-zero
gives signed slice weights +1/4 at b=±2 and -1/2 at b=0;
total mass 0, second moment 2. The rational arithmetic tests pass.

**Theta diagnostic, not interval-certified:** using actual Jacobi theta
at rational Fourier x=28.269, `C_0(0,x)~-3.26794e-7` and
`C_0(1/2,x)~+9.74345e-8`, reproducible at 8000/16000
Simpson panels. Neither sign is promoted to a rigorous numerical certificate.

**Files:** `paper/theta_conditional_slice_attack.tex` (included in
`paper/spatial_heat_comparison.tex`), `XiKernel/ThetaConditionalSliceObstruction.lean`,
and `certificates/xi_theta_conditional_slice_attack.py`.
The paper proof uses classical Fourier inversion and known real simple theta
zeros; the Lean module tests the finite signed-measure algebra, **not** the infinite
theta integral theorem end-to-end.

**Remaining RH gate:** Prove nonnegative Fourier transforms of the *completed
b-weighted* theta correlation `G_(n,t)(w)` simultaneously for all n,t,x,
via a non-circular arithmetic construction. Neither pointwise positivity of
the unweighted signed slices nor their b-positive-definiteness works.
The statement remains equivalent to the all-order Laguerre target unless
independent theta arithmetic gives a valid constructive certificate.
The source bibliography already cites Csordas and Dimitrov-Xu.

**Repository verification:** New Lean, exact Python and PDF Actions runs remain
QUEUED at this checkpoint; do not describe their outputs as passed.
Exact Python tests ran successfully locally.
DOI: https://doi.org/10.5281/zenodo.23461586 (author confirms live,
old 'reserved' text no longer used).
The cumulative complete 25-page PDF was assembled locally from the
previous 23-page manuscript plus the two-page research continuation.

## 20 October 2026 — fully weighted theta mode-pair attack

**Analytical theorem added to the cumulative paper:** For \(q_m=\pi m^2\), \(D_m=\phi_m'(0)=q_m e^{-q_m}(-8q_m^2+30q_m-15)\) satisfies \(D_1>0\), \(D_m<0\) for all \(m\ge2\), and \(\sum_mD_m=0\) by Jacobi modular evenness.

For the exactly normalized positive mode densities \(\nu_{m,t}(u)=\tfrac12e^{tu^2}\phi_m(|u|)\), the ordered weighted correlation \(G^{mk}_{n,t}(w)=\frac{1}{2(2n)!}\int b^{2n}\nu_{m,t}((w+b)/2)\nu_{k,t}((w-b)/2)\,db\) is nonnegative as a function of \(w\), yet its Fourier transform obeys
\[
\widehat G^{mk}_{n,t}(x)=(-1)^n(n+1)D_mD_k/x^{2n+4}+O_{m,k,n,t}(|x|^{-2n-6}).
\]
Thus every diagonal mode pair is eventually **negative at every fixed odd Laguerre order**, for **every finite heat time t**—including t=1/2 where the complete theta transform has only real zeros. The first-mode/higher-mode mixed correlations have the opposite leading sign and compensate the diagonal/tail modes. Their aggregate leading coefficient is zero exactly because \((\sum_m D_m)^2=0\).

For each finite M, \(D_M=\sum_{m\le M}D_m>0\), so every fixed odd Laguerre order of the finite theta approximation is eventually negative: \(L_n[H_{M,t}](x)\sim-(n+1)D_M^2/x^{2n+4}\). This extends the earlier first-order truncation artifact to all odd orders.

**Meaning:** pointwise nonnegativity of the weighted correlation densities DOES NOT give nonnegative Fourier transforms of their individual square-lattice mode pairs. Any viable proof requires an *entire-series, modularly compensated* Fourier estimate, all n,t,x. The leading modular cancellation is necessary but not sufficient for RH.

**Tests and formalization:** The standard-library rational/SymPy coefficient test covers 60 orders and exact first-mode/higher-mode sign gates; local rational subset covers 35. The new Lean module proves finite sign/cancellation/cross-term algebra only. CI submitted but not claimed to have passed until verified. The full infinite Jacobi modular cancellation and Fourier integration-by-parts asymptotics are analytic manuscript proofs, not Lean-certified end to end.

**Files:** `paper/theta_weighted_mode_pairs.tex`, `XiKernel/WeightedModePairs.lean`, `certificates/xi_mode_pair_weighted_exact.py`.

**Priority:** this decomposition builds directly on Csordas, Csordas–Ruttan–Varga, and Dimitrov–Xu. No independent novelty review and no RH proof.

**Next target:** construct a *non-circular* infinite-lattice compensation bound for the complete \(\widehat G_{n,t}\), with a relative sign lower bound uniform in Fourier height, heat time, and Laguerre order. Any finite-mode positivity claim is provably false at odd orders and high frequencies.

## 20 October 2026 — Quantitative spatial defect stability and new RH proof gate

The [cumulative LaTeX manuscript](paper/main.tex) now includes a **non-circular quantitative spatial heat comparison** in `paper/spatial_heat_comparison.tex`:

For any bounded classical U with `U_s-(1/2)U_xx+c U >= -epsilon`, `c>=0` locally bounded, `epsilon>=0) bounded and `U(0,x)>=0`, one has
`U(s,x) >= -integral_0^s P_(s-r)epsilon(r,.)(x)dr`.
If `epsilon<=delta`, then `U>=-s*delta`; on a finite interval with lateral lower bound `-b`, `U>=-b-s*delta`.
For the theta heat hierarchy, the **positive comparison defect**
`epsilon_(n,c)=[(n+1)(2n+1)U_(n+1)-c_n U_n]_+`
is therefore a concrete error quantity whose vanishing would give all-order Laguerre positivity and RH, but **no such vanishing theta-series bound has been proved**.

An exact collision test with `H_t(z)=z²-2t` shows
`L1=2x²+4t`, `L2=1`. At `(t,x)=(0,0)` the comparison defect is exactly 6 for any finite c; if `c<=C`, `0<=L1<=1/(1+C)`, then the defect is >=5. Any proposed approximate proof must be compatible with such collision obstructions.

New files: `XiKernel/SpatialDefectStability.lean` and
`certificates/xi_spatial_defect_stability_exact.py`. The exact-rational collision control was run locally and passed. The new GitHub Actions CI jobs were still **queued**, so no remote Lean or build success is claimed for these latest edits.

The DOI URL in `paper/main.tex` is now presented without the earlier “reserved/not published” language, as requested by the author:
[10.5281/zenodo.23461586](https://doi.org/10.5281/zenodo.23461586).

**Research status:** RH is open. The locally bounded spatial comparison is equivalent (under standard analytic hypotheses) to **RH plus zero simplicity** and is therefore stronger than the desired result. The division-free Duhamel source inequality remains the zero-compatible RH-equivalent target; the new defect bound is a quantitative stability tool, not an RH proof.


## 20 October 2026 — zero-compatible constant-penalty heat criterion

New paper section: `paper/penalty_defect_limit.tex`, included after the
spatial/Duhamel analysis in the complete `paper/main.tex` manuscript.

For the actual Riemann theta heat family, let `U_n(s,x)=L_(n,1/2-s)(x)`,
`k_n=(n+1)(2n+1)` and `P_h` be Gaussian heat convolution. Define
`E_(n,C)=[k_n U_(n+1)-C U_n]_+` and
`mathcalE_(n,C)(s,x)=int_0^s P_(s-r)E_(n,C)(r,.)(x) dr`.
Under the standard analytic/semigroup hypotheses, the condition
`lim_(C->infinity)mathcalE_(n,C)(1/2,x)=0` for all n>=1 and real x is
equivalent to RH. This is an **exact, zero-compatible reformulation,
not a proof of the necessary genuine-theta estimate**.

The essential distinction is verified by exact control models:
- `H_t(z)=z²-2t`: at the double-zero collision, the pointwise
positive defect is exactly `6` for every C, but its convolved error
is at most `9/C` (for C>=3). The original Duhamel budget is exactly
saturated at the collision.
- A negative Laguerre region in the model `U(s,x)=1-2s` produces
a heat-convolved positive defect at least `3C/16` at s=1.
- Positivity of actual theta's even `H_t(iy)` Taylor coefficients
proves each `U_n(s,0)>0`, so every spatial analytic zero set has
measure zero; dominated convergence establishes the RH=>defect-limit
direction, and heat comparison gives the converse.

**Verification:** `certificates/xi_penalty_defect_limit_exact.py`
passed exact-rational tests locally. `XiKernel/PenaltyDefectLimit.lean`
contains the finite algebraic gates, but **latest GitHub Lean CI remains
queued** as of this update. The analytic theta heat-kernel theorem,
Fubini/dominated convergence, and RH equivalence are not formalized
end-to-end in Lean. No new global off-line zero exclusion is proved.

The linked manuscript DOI is
https://doi.org/10.5281/zenodo.23461586.
The old “reserved DOI/not yet published” wording has been removed from
the source. User reports the Zenodo DOI is live; independent web
resolution was not available in this check.

**Highest-value missing step:** directly estimate from the genuine
theta correlation measure, without presupposing `U_n>=0`, that
`mathcalE_(n,C)(1/2,x)->0` for *all* Laguerre orders and real x.
All finite tests and the heat-flow equivalence alone do not prove RH.

## 20 October 2026 — quantitative normalized Duhamel penalty identity

**New unconditional theorem (analytic proof):** For each fixed n>=1 and T in (0,1/2], let k_n=(n+1)(2n+1), U_n(s,x)=L_(n,1/2-s)(x), V=k_n U_(n+1), and E_(n,C)=[V-C U_n]_+. Write mathcalE_(n,C)(T,x)=integral_0^T P_(T-s) E_(n,C)(s,.)(x) ds, and mathcalN_n(T,x)=integral_0^T P_(T-s)[(-U_n(s,.))_+](x)ds. With M_(n,T)=sup_(s∈[0,T],x∈R)|V(s,x)|<infty, the 1-Lipschitz positive-part identity yields

  sup_x |mathcalE_(n,C)(T,x)/C - mathcalN_n(T,x)| <= T*M_(n,T)/C.

This uses no RH or positivity assumption. The theta heat transform and all its derivatives are bounded uniformly on the compact heat-time slab, so M_(n,T) is finite.

**Sharper RH-equivalent proof target (NOT proved):** RH is equivalent to, for every n>=1 and real x, sup_(C>=1) mathcalE_(n,C)(1/2,x)<infty. It is also equivalent to mathcalE_(n,C)(1/2,x)=o(C). The equivalence uses positivity of the Gaussian heat kernel, continuity of U_n, the de Bruijn–Newman real-zero criterion for t>=0 under RH, and the generalized Laguerre–Pólya theorem. This improves the prior missing demand mathcalE_(n,C)->0 by requiring only boundedness, but proving that boundedness directly from the theta correlation measure remains open. These are RH-equivalent reformulations, **NOT a proof of RH**.

**Exact local tests PASSED:** 15000 rational pointwise positive-part sandwiches, 1000 rational positive-weight heat-average models, and the exact constant negative-region model U=1-2s, v=2: mathcalE_C(1,x)=C/4+1+1/C and mathcalN=1/4. Script: certificates/xi_penalty_quantitative_exact.py. Algebraic Lean source: XiKernel/PenaltyQuantitative.lean. The new Lean and GitHub PDF CI are **QUEUED**, so new Lean source is NOT claimed compiled. The heat-semigroup theorem and RH equivalence are NOT formalized end-to-end in Lean.

The complete updated manuscript source includes paper/penalty_quantitative_limit.tex, imported from paper/spatial_heat_comparison.tex, and an updated abstract/reproducibility narrative. The DOI is listed directly as https://doi.org/10.5281/zenodo.23461586 without obsolete reserved wording. The separately delivered immediate PDF is a consolidated previous 18-page verified paper with a dated 2-page research supplement; the GitHub new-source full recompilation is queued.

## 20 October 2026 — final Duhamel attack: single-Fourier-point criterion and quantitative negative-witness theorem

**Analytic theorem proved; RH itself remains open.** Let `T=1/2`,
`U_n(s,x)=L_(n,1/2-s)(x)`, `k_n=(n+1)(2n+1)`,
and `E_(n,C)=[k_n U_(n+1)-C U_n]_+`.
Let `mathcalE_(n,C)(T,x)=int_0^T P_(T-s) E_(n,C)(s,.)(x) ds`.
Strict positivity of the Gaussian semigroup and the already established
uniform normalized-penalty identity yield the **sharper equivalence**:

`RH ↔ ∀n≥1: sup_(C≥1) mathcalE_(n,C)(1/2,0)<∞`.

The observation need only be made at the **single central Fourier height x=0**, but all Laguerre orders and unbounded C remain essential. More strongly, with
`M_n=sup|k_n U_(n+1)|`, `A_n=sup|U_n|`, and `b_n=1+T(A_n+M_n)`,
the well-defined scalar `S(C)=sum_(n≥1)2^-n mathcalE_(n,C)(T,0)/b_n`
satisfies `RH ↔ sup_(C≥1) S(C)<∞`. This is a logically exact reformulation, **not a theta-specific bound proving RH**.

**Quantitative witness theorem:** if for some n, `U_n(T,X)≤−delta<0`,
`|partial_s U_n|≤A`, `|partial_x U_n|≤B`, choose
`tau=min(T/4,delta/[8(1+A)])`,
`r=min(1,delta/[4(1+B)])`, `Y=|X|+r`.
Then the smoothed negative mass at the *origin* obeys
`mathcalN_n(T,0) >= delta*r*sqrt(tau)/(2*sqrt(pi))*exp(-Y²/(2*tau)) > 0`.
Hence `mathcalE_(n,C)(T,0) >= C*mathcalN_n(T,0)-T*M_n`.
The exponentially tiny factor at high Fourier height explains why finite
certificates cannot settle the global result.

**New code and manuscript sections:**
`paper/central_duhamel_penalty_attack.tex`,
`XiKernel/CentralDuhamel.lean`,
`certificates/xi_central_duhamel_exact.py`.
Independent local rational replay passed 400 witness rectangles,
36 scalar bounds and 5 negative-region models.
The latest GitHub Lean/Python/PDF workflows are **queued**; do not claim
they passed. The full Gaussian integration, real-entire Laguerre criterion
and RH equivalence are analytical manuscript proofs, not end-to-end Lean.

**Unproved decisive gate:** derive boundedness of `mathcalE_(n,C)(T,0)`
from actual square-lattice theta correlations for all n and all C,
without assuming U_n≥0 or an equivalent positive-definiteness claim.
No Riemann-hypothesis proof or newly verified zero height is asserted.

Manuscript DOI: https://doi.org/10.5281/zenodo.23461586

## 20 October 2026 — Dyadic central heat-defect reduction

For the genuine theta heat flow, let N_n be the Gaussian-smoothed negative mass of the n-th Laguerre coefficient at the central observation point, and b_n=1+T(A_n+M_n) its positive normalization. The previously established central-point criterion and the adaptive theta cutoffs m_n(C) combine into the **single nonnegative defect**

D = sum_{n>=1} 2^(-n) N_n / b_n,

and a **single sequence of finite theta approximations**

S_k = sum_{n=1}^k 2^(-n) E^(m_n(2^k))_(n,2^k)(T,0)/b_n.

**New quantitative theorem:** for every integer k>=1,

|2^(-k) S_k - D| < 2^(1-k).

Analytic central positivity shows RH iff D=0 iff S_k<1 for all k. A rigorously established S_k>=1 at one stage would refute RH; none has been found. Proving S_k<1 simultaneously for every k from the genuine modular theta source is the open global RH step. This is a quantitative reformulation, not a proof of RH or a finite verification algorithm for every stage.

**Files:** paper/dyadic_penalty_defect_attack.tex (included in full manuscript by paper/spatial_heat_comparison.tex), certificates/xi_dyadic_penalty_defect_exact.py, XiKernel/DyadicPenalty.lean (imported and axiom-inspected). The exact rational normalization cases passed independently in the model working environment. New GitHub Lean and PDF workflow runs were still **queued** at the time of this update; no CI pass is claimed for the new Lean declarations. The full analytic theta/Fourier/Duhamel argument is not end-to-end kernel formalized.

**DOI:** https://doi.org/10.5281/zenodo.23461586 (live DOI supplied by author). The previous reserved-DOI label should not be used for the current paper.

## 20 October 2026 — Adjacent-order ratio PDE: exact structural attack

**Exact mathematical identity.** Put `k_n=(n+1)(2n+1)`, `D_n=U_n`, `V_n=k_n U_(n+1)`, `W_n=k_(n+1) U_(n+2)`, `D=∂s−(1/2)∂xx`. Then the genuine backward heat hierarchy satisfies the **division-free** identity

`D_n D(V_n) − V_n D(D_n) = V_n²−k_n D_n W_n.`

On open regions with independently guaranteed `D_n,V_n>0`, `R_n=V_n/D_n` obeys

`∂s R_n = (1/2)∂xx R_n + (∂x log U_n)∂x R_n + R_n(R_n−R_(n+1)).`

This is a conditional **ratio evolution identity**, not proof of the missing positivity. Proposing `c_n=k_n U_(n+1)/U_n` without independent sign control is circular.

**Exact negative control:** For real-rooted `G(z)=z(z−1)(z−10)`, at the simple root 0, `R_1=303/50>15/101=R_2`. Thus `R_n<=R_(n+1)`, which would make the PDE reaction nonpositive, cannot be assumed from real-rootedness alone.

**Genuine-theta numerical diagnostic (46 digits, not intervals):** At `t=1/2,x=28.269`, `R_1≈12.005931723` and `R_2≈0.104107122`; a similar reversal is sampled near x=42.044. This motivates an independent interval audit before any theorem about the actual theta ordering.

**Tests and artifacts:** `paper/adjacent_laguerre_ratio_attack.tex`, `XiKernel/AdjacentLaguerreRatio.lean`, `certificates/xi_adjacent_ratio_heat_exact.py`. Symbolic and exact rational checks passed locally; a new numerical test also passed. Latest GitHub Actions Lean/PDF runs were queued when this entry was written; do not claim they passed. The full nonlinear PDE is analytically derived in the manuscript but is not yet an end-to-end Lean proof.

**Scientific frontier:** Independent theta-specific control of `∂x log U_n` and the signed reaction **without assuming Laguerre positivity**, or a direct bound for the existing division-free Duhamel/dyadic defect. RH remains open.

**DOI:** https://doi.org/10.5281/zenodo.23461586 (author reports the DOI is live; no obsolete reserved/unpublished designation).

## 20 October 2026 — Certified actual-theta comparison on a full-time rectangle

**New scoped mathematical certificate (not RH).** Fix Laguerre order `n=1`, theta cutoff `M=2`, spatial coefficient `c=C_K=1`, and the full heat/frequency rectangle
`K=[0,1/2] × [-4,4]`.

A directed-interval Simpson calculation using the first two genuine Jacobi-theta summands (independently at 8,192 and 16,384 panels) with analytic fourth-derivative and `r>2` tail bounds establishes the following exact rational theta-moment enclosures:
`m0(0)>1/20, m2(0)>1/2000`;
`m0(1/2)<1/10, m1(1/2)<1/100, m2(1/2)<1/1000, m3(1/2)<1/5000, m4(1/2)<1/30000`.
Positivity of the kernel, heat-moment monotonicity, `cos y ≥ 1-y²/2`, and standard L1/L2 derivative identities yield
`6*U_(2,2)(s,x)-U_(1,2)(s,x) < -79/30000000 ≈ -2.63333e-6`.
The complete analytic theta tail budget on K is
`6 e_(2,2)+e_(1,2) < 5.05e-8`; therefore
`6U_(2,2)-U_(1,2) ≤ -6e_(2,2)-e_(1,2)`
throughout the **entire** rectangle, and the earlier noncircular transfer theorem proves
`6U_2(s,x)≤U_1(s,x)` for the **genuine complete theta heat flow** there.
The remaining strict margin exceeds `2.58e-6`.

A further **analytic, existence-level** result shows that for each fixed order `n≥1` there exists an order-dependent radius `r_n>0`, a sufficiently large finite theta cutoff `M_n` and a finite constant coefficient `c_n>0` making the corresponding finite-mode transfer inequality true on `[0,1/2]×[-r_n,r_n]`. This does not supply any uniform radius or off-axis/global-in-height exclusion.

- Full source: `paper/first_certified_compact_rectangle.tex`
- Directed interval / exact arithmetic: `certificates/xi_first_compact_theta_rectangle.py`
- Kernel-checked rational **subgoals only**: `XiKernel/FirstCompactThetaRectangle.lean`
- Two-mesh GitHub action: `.github/workflows/xi-compact-rectangle.yml`
- **Trust:** interval transcendentals from pinned `mpmath.iv==1.3.0`; Jacobi theta positive integral, Simpson fourth-derivative formula and explicit analytic tails. No end-to-end Lean proof of full theta heat/Fourier identities. Current GitHub CI was queued when this entry was written; local dual-resolution checks passed.
- **Global RH target still missing:** the sign comparison for *every* `n` and *arbitrarily large real x`, without using RH or a disguised equivalent hypothesis. The successful compact result makes no claim about RH outside K.

DOI: https://doi.org/10.5281/zenodo.23461586

## 20 October 2026 — Strictly increasing central Laguerre ratio and uniform order obstruction

**Analytical theorem:** For the *genuine* classical Jacobi theta heat family on the full slab 0<=t<=1/2, put g_t=Phi_t*Phi_t (positive on every real w), M_(2n)(t)=integral_R w^(2n) g_t(w) dw, and U_n(s,x)=L_n[H_(1/2-s)](x). At x=0:

`U_n(s,0)=M_(2n)(t)/(4(2n)!) > 0` and
`(n+1)(2n+1)U_(n+1)(s,0)/U_n(s,0) = M_(2n+2)(t)/(2M_(2n)(t))`.

Strict Cauchy–Schwarz moment log-convexity makes the ratio *strictly increasing in n*. Because the true theta convolution has positive unbounded support, it **diverges as n→infinity**, and compactness plus monotonicity upgrades divergence to **uniform in t∈[0,1/2]**.

**Consequence:** Any claimed source comparison `k_n U_(n+1)<=c_n(s,x)U_n` needs coefficients satisfying `inf_s c_n(s,0)→+infinity`. A spatial logarithmic-square envelope `C*(1+log²(2+|x|))` with C independent of order is disproved. **An order-dependent coefficient C_n*(1+log²(2+|x|)) is NOT ruled out**; even a proposed `C_n~log²(n)` has not been proved and is a quantitative research target. Central positivity alone holds regardless of RH and cannot settle the noncentral global comparison.

**Check status:** `certificates/xi_central_moment_ratio_exact.py` passed locally (101 factorial identities; strict finite-support moment ratio sanity test and essential negative control). Exploratory actual-theta quadratures at 512/1024/2048 nodes agree for orders 1,5,20,55 at heat times 0 and 1/2 (script: `certificates/xi_central_moment_ratio_numerical.py`). These samples do NOT prove asymptotic logarithmic-square growth. Lean algebra subtheorems live in `XiKernel/CentralMomentRatio.lean`. GitHub Actions builds/Lean were **queued** at last inspection; do not treat them as passing runs.

Full proof: `paper/theta_central_moment_barrier.tex` included from `paper/main.tex`. The existing full-time first-order compact rectangle `|x|<=4` and other heat comparisons remain in their original sources. A 22-page local compiled cumulative supplement plus earlier archived manuscript was emailed on 20 Oct 2026, with the DOI linked as `https://doi.org/10.5281/zenodo.23461586`. This local PDF is a consolidation, not yet the rebuilt complete current GitHub LaTeX snapshot. RH unresolved.

## 20 October 2026 — All-order six-unit spatial comparison, full heat slab

**Proved from existing theta moment certificates and Newman's GHS curvature theorem:** for every n≥1, t∈[0,1/2], x∈ℝ, with central A_n(t)=L_n[H_t](0)>0,

`L_n[H_t](x) >= A_n(t)*(1-x²/48)`.

The required heat coupling has a **division-free global source upper estimate** with positive central coefficient
`c_n(t)=4*(n+1)*(2n+1)*A_(n+1)(t)/A_n(t)`:

`k_n*L_(n+1)[H_t](x) - c_n(t)*L_n[H_t](x) <= k_n*A_(n+1)(t)*(x²/12-3)`.

Consequently **the strict spatial source comparison is valid for all orders and all heat times on |x|≤6**, without dividing by the possibly small noncentral Laguerre expression. For the global positive-part defect, Gaussian heat averaging at the centre proves the nonzero explicit estimate

`integral_0^(.5) P_(.5-s)[k_n U_(n+1)-c_n U_n]_+(0) ds <= k_n * max_t A_(n+1)(t) /3456`.

**Inputs:** the previously validated full heat-time two-mode moments `mu0,2(0)>1/20`, `mu2,2(.5)<1/1000`, the heat Fourier tail `mu2(t)-mu2,2(t)<1e-8`, and the known curvature/moment-ratio monotonicity (Newman 1991). Thus `mu2(t)/mu0(t)<(1/1000+1e-8)/(1/20)=100001/5000000<1/48`. These inputs are not newly verified by an independent interval backend in this turn.

**Reproduce exact arithmetic**: `python certificates/xi_heat_six_band_exact.py`. New Lean algebra `XiKernel/SixBandDivisionFree.lean` compiles only if current GitHub Actions run passes; do not treat a queued CI run as verified. Complete theta integrals are not end-to-end Lean proofs.

**Open RH gate:** the defect becomes positive outside |x|≤6, and its Gaussian-smoothed upper bound is nonzero. Hence this does **not** imply the RH-equivalent vanishing negative-part criterion or prove RH. Full source: `paper/heat_six_band_division_free.tex` included in `paper/main.tex`. DOI: https://doi.org/10.5281/zenodo.23461586 (do not label it reserved).

## 20 October 2026 — Exponential suppression of the global six-band Duhamel source

**New analytic bound, contingent only on the already established full-theta six-band source theorem:** for every order n≥1, write k_n=(n+1)(2n+1), T=1/2, U_n(s,x)=L_(n,T-s)(x), A_(n+1)(t)=L_(n+1,t)(0)>0 and c_n(s)=4*k_n*A_(n+1)(T-s)/A_n(T-s). Put

`E_n(s,x)=[k_n U_(n+1)(s,x)-c_n(s)U_n(s,x)]_+`.

The six-band result gives `E_n <= k_n A_(n+1)(T-s)*(x²/12-3)_+`. A direct Gaussian exponential moment inequality with parameter a=15/16 yields the improved central penalty estimate

`integral_0^(1/2) P_(1/2-s)[E_n(s,.)](0) ds <= (8/45)exp(-135/4)*k_n*sup_(0<=t<=1/2) A_(n+1)(t)`
`< k_n*sup_t A_(n+1)(t)/10^14.`

It sharpens the previous polynomial coefficient 1/3456 by >10 orders of magnitude. The **strict rational verification** uses `e^3>20`, so `(8/45)exp(-135/4)<8/(45*20^11)=1/1152000000000000<10^-14`.

**Crucial scope:** the bound is exponentially small but not zero, and the normalization factor is order-dependent. It does not prove the RH-equivalent vanishing/uniform-penalty criterion; RH remains open. It does not resolve all frequencies via a scalar coefficient. This is a quantitative strengthening, not a complete global proof.

Files: `paper/heat_six_band_exponential_tail.tex`, `XiKernel/SixBandExponentialTail.lean`, `certificates/xi_six_band_exponential_exact.py`. Exact rational tests have passed locally; new Lean/GitHub CI must be checked before marking those runs passed. The Gaussian MGF, actual theta correlation inequality and full parabolic transfer are analytical inputs, not Lean-formalized end-to-end. DOI https://doi.org/10.5281/zenodo.23461586 is now linked directly as the user's live DOI.

## 20 October 2026 — spatial heat comparison: density-forced coefficient 1/8

A new analytic theorem in `paper/heat_log_square_density_gate.tex` gives a quantitative **necessary** height dependence for any locally finite nonnegative coefficient in the heat-Laguerre comparison. At each simple real zero `a` of `H_(1/2)`,

`c_1(0,a) >= 6 * sum_{b != a} (a-b)^(-2)`.

For `N(R)` real zeros in `[R,2R]`, Jensen's inequality gives some zero `a_R` with

`c_1(0,a_R) >= (12/(N(R)*R^2)) * sum_{m=1}^{N(R)-1} (N(R)-m)^3/m^2`.

Using the established `N(R) ~ R log R/(4*pi)` zero-count law, one obtains

`limsup_{a -> infinity, H_(1/2)(a)=0} c_1(0,a)/log(2+a)^2 >= 1/8`.

Therefore every proposed `c_1(0,x) <= C*(1+log^2(2+|x|))` needs `C>=1/8` and every sub-log-square candidate fails. This is **NOT** an upper bound, the needed comparison is still unproved, and RH remains open.

Reproduction: exact rational tests `certificates/xi_heat_log_square_gap_exact.py` and Lean polynomial gates `XiKernel/LogSquareHeatGap.lean`. The canonical product, zero-density input, Jensen aggregation and heat maximum principle are not fully Lean-certified. Local exact rational checks passed. The latest GitHub Actions jobs were still **queued** as of the 20 October inspection; report no completed CI pass for this commit until they finish.

Publication DOI: https://doi.org/10.5281/zenodo.23461586 (the user reports it is live). The manuscript header now uses the DOI rather than a reserved/unpublished label. The complete current paper source is `paper/main.tex` and its included modules; newest hosted PDF build may be delayed by the GitHub Actions queue.

## 20 October 2026 — Sharp nonintegrable spatial comparison at heat collisions

**Exact conditional theorem:** At a nondegenerate real double zero
`H_(t*)(x*)=H'_(t*)(x*)=0`, `a=H''_(t*)(x*)≠0`
of any real entire family solving `∂tH=-∂xxH`,
the first adjacent Laguerre ratio satisfies
`lim_(t↓t*) (t-t*)·6L₂(t,x*)/L₁(t,x*)=3/2`.
Thus any nonnegative spatial coefficient satisfying
`6U₂≤c₁(s,x)U₁` immediately before the collision time
`s*=1/2-t*` must obey
`liminf_(s↑s*) (s*-s)c₁(s,x*)≥3/2`.
Its time integral diverges; it cannot remain locally bounded
or time-integrable through the collision.

**Exact polynomial normal form:** The backward heat solution
`H_t(x)=x²-2(t-t*)` has
`L₁=2x²+4(t-t*)`, `L₂=1`,
`6L₂/L₁=3/(x²+2(t-t*))`.
When its two real zeros are separated by gap `g`, the
necessary coefficient at their midpoint is `12/g²`.
This sharpens the previously established double-zero
point obstruction by quantifying inverse-time and inverse-gap growth.
It is *not evidence that the genuine theta heat flow has such a collision*.

**Prior context:** `paper/spatial_heat_comparison.tex` already proves
a maximum-principle criterion with locally bounded coefficients;
a logarithmic-square spatial majorant is not necessary merely to
apply that criterion. The closed-slab comparison would also force
zero simplicity; preterminal and division-free alternatives are
studied separately. The genuine-theta all-order `|x|≤6`
comparison is not a global RH proof.

**Verification:** Exact local symbolic and rational replay
`certificates/xi_heat_collision_envelope_exact.py` passed in
the working runtime. The Lean algebra source
`XiKernel/HeatCollisionRate.lean` and
`#print axioms` audit were committed; GitHub CI remains
queued as of the last status check, so **do not label these
new Lean declarations as CI-passed**. The universal
analytic limit/nonintegrability theorem is proved in
`paper/heat_collision_spatial_gate.tex`, not end-to-end
in Lean.

**Publication:** The main paper displays
doi:10.5281/zenodo.23461586 without the obsolete reserved-DOI
wording. RH remains open.

## 20 October 2026 — exact all-order zero lattice and seven-unit theta heat band

**New complete analytical deductions, conditional only on existing established theta moment bounds, not on RH**:

- Simple real-zero canonical-product identity at every Laguerre order: `L_n[H_t](a)=H_t'(a)^2*e_(n-1)({(a-b)^(-2):b≠a})`. Hence any proposed spatial heat coefficient at such a zero must dominate `(n+1)(2n+1)e_n/e_(n-1)`; the elementary symmetric inequality gives `n*e_n<=S(a)*e_(n-1)`, `S(a)=sum_(b≠a)(a-b)^(-2)`. This is a necessary zero-lattice relation, not a global sufficient bound.
- A multiple real zero of multiplicity `m>=2` forces `L_(m-1)(a)=0` while `L_m(a)=(H^(m)(a)/m!)²>0`. Therefore no finite spatial coefficient can satisfy the proposed comparison there at order `m-1`. This extends the earlier double-root obstruction; open-slab comparison may still allow endpoint singularities.
- From `B_n/A_n<=1/24` and the positive genuine theta correlation kernel, `|∂_x U_n|<=A_n*min(|x|/24,1/sqrt(24))`. Integrating yields the piecewise all-order lower bound `U_n/A_n>=1-x²/48` for `|x|<=sqrt(24)`, and `U_n/A_n>=3/2-|x|/sqrt(24)` above that threshold. Consequently the actual theta heat family has a positive all-order common spatial band `|x|<3sqrt(6)≈7.348` and the particularly useful **closed seven-unit source comparison** `k_n U_(n+1) <= [15 k_n A_(n+1)/A_n] U_n` for **every** order and heat time `|x|<=7`. This strictly improves the previously proven six-unit band and the intermediate sqrt48 band.
- Exact rational tests passed independently in the local Python environment: elementary symmetric families of size 2–10, multiplicities 2–17, and the strict seven-unit numerical identity `24*(43/30)²-49=23/75>0`.
- Source: `paper/zero_lattice_extended_band.tex`, `paper/seven_unit_heat_band.tex`, `XiKernel/ZeroLatticeAndBand.lean`, `XiKernel/SevenUnitHeatBand.lean`, and the matching rational scripts under `certificates/`. **Latest GitHub Lean/PDF CI jobs are QUEUED, not passed**.
- An immediate **25-page cumulative PDF** has been generated and emailed, combining the last verified eight-section archival PDF (with superseded DOI wording removed) and dated technical continuations. Because GitHub CI is queued, this is a consolidated interim publication PDF; the fully updated single-source full-paper build remains pending. DOI is shown without any reserved-status wording: https://doi.org/10.5281/zenodo.23461586.
- **RH is still open:** no proof controls the division-free coupled Laguerre source for all real heights, orders and preterminal heat times, nor an equivalent zero-exclusion estimate uniformly to infinite height.

## 20 October 2026 — genuine-theta division-free spectral heat-loss attack

**New exact analytic result:** for `U_n(s,x)=L_{n,1/2-s}(x)`, define
`h(u)=Phi(|u|)exp(u²/2)/2` and
`W_n(u,v)=h(u)h(v)(u-v)^(2n)/(2n)!`. Then

`Delta_n(s,x):=P_s U_n(0,x)-U_n(s,x)
 = ∫∫ W_n(u,v) exp(-s(u+v)²/2)[1-exp(-s(u-v)²/2)] cos(x(u+v)) du dv`.

Here `P_s` is the Gaussian heat semigroup, and the identity holds
for every n>=1, s in [0,1/2], x real. The pair weight is nonnegative;
`Delta_n(s,0)>0` for every s>0; and
`|Delta_n(s,x)| <= s(n+1)(2n+1) M_(n+1)(s)` with a strictly positive
explicit theta pair moment `M_(n+1)(s)`. Pushing the pair weight onto
the sum frequency yields a smooth nonnegative Schwartz spectral
density `K_(n,s)`, so
`|Delta_n(s,x)| <= min(s*k_n*M_(n+1)(s), ||K''_(n,s)||_1/x²)`
(and a 2j-derivative analogue). These bounds never divide by
`U_n` or assume its positivity.

**Exact no-go to a tempting shortcut:** in the positive symmetric
three-atom model `mu(0)=1, mu(±1)=1/10`, at
`s=2log(5/4)<1/2`, direct rational summation gives
`Delta_1(s,0)=869/15625>0` but
`Delta_1(s,pi)=-131/15625<0`. Thus positivity of the
theta-type pair density does not itself imply Fourier-side sign.

**Verified locally:** `python certificates/xi_division_free_spectral_loss_exact.py`
checks 301 exact factorial identities, all three-atom pair weights,
and both exact loss values. Companion Lean algebra subtheorems are in
`XiKernel/ThetaSpectralLoss.lean`; these have been submitted to CI
but the new runs are still **queued**, not counted as successful.
The full theta convolution, spatial integration by parts and
Feynman–Kac/Duhamel argument are analytic paper proofs, not
end-to-end Lean formalizations.

**Precise unsolved proof gate:** establish a theta-specific *relative*
Fourier-sign estimate comparing the signed spectral loss with the
positive heat baseline for every n,x,s, or an equivalent
division-free integrated weighted-Duhamel source estimate.
No unbounded-height off-critical zero exclusion or RH proof follows.

**Paper:** `paper/theta_spectral_loss.tex`, included in the existing
eight-section manuscript. The complete current user PDF is a
32-page combination preserving the last emailed 30-page cumulative
research paper and adding the two-page mathematical continuation.

**DOI:** https://doi.org/10.5281/zenodo.23461586
(no obsolete reserved/unpublished DOI wording).

## 20 October 2026 — Pole-free nearest-zero Laguerre comparison

**Analytic proposition (classical ingredients, originality unestablished):** If G is a real entire Laguerre–Pólya function of order at most one with infinitely many simple real zeros, choose a zero a and define S_a(x)=sum_{rho!=a}(x-rho)^(-2). On a zero-free punctured interval around a, and continuously at a, for every n>=1,

`0 <= k_n*L_(n+1)[G](x)/L_n[G](x) <= k_n*S_a(x)/n`, where `k_n=(n+1)(2n+1)`.

The apparent inverse-square pole of the chosen zero cancels **exactly** after separating its canonical-product factor. In an abstract globally g-separated simple real-zero set, the nearest-zero choice yields `S_a(x)<=pi²/g²`. This last hypothesis does not hold uniformly for the actual Riemann heat flow at high heights, whose zero density grows; it is a transparent control model.

**Precise RH boundary:** The nearest-root formula presupposes that all zeros are real and simple. It works at t=1/2 but cannot be extrapolated to unknown earlier heat times without a genuine continuation/zero-exclusion argument. The next independent target is quantitative repulsion of the *other* roots or a division-free theta Fourier positivity theorem valid across the heat slab. No RH proof has been obtained.

**Files:** `paper/pole_free_laguerre.tex`; `XiKernel/PoleFreeLaguerre.lean`; `certificates/pole_free_laguerre_exact.py`.

**Tests:** Exact finite rational root-configuration checks passed locally; new Lean and automated Python CI at commit `254b07d1` are queued as of the latest observation and must not be called passed yet.

**Correspondence release:** The latest known compiled 33-page manuscript plus a completely typeset 2-page pole-free continuation was delivered as a 35-page cumulative PDF by Gmail from `newtonastro.physics@gmail.com` to `tony.newton79@gmail.com`. The monolithic GitHub LaTeX source includes the new file, but its separate PDF recompilation is queued. DOI: https://doi.org/10.5281/zenodo.23461586 (author confirms live; no reserved designation).

## 20 October 2026 — Exact backward-heat zero-gap shielding attack (conditional)

**Mathematical statement.** On any heat-time interval in which the genuine de Bruijn--Newman transform has simple real zeros, two consecutive zeros a<b with squared gap G=(b-a)² satisfy the exact identity

`d_s G = -8 + 4*G*S_ext`, `s=1/2-t`, `S_ext = sum_(rho!=a,b) 1/((a-rho)*(b-rho))`.

The underlying zero-motion dynamics and its use in the de Bruijn-Newman problem are **established prior art** (Csordas--Smith--Varga, Rodgers--Tao), not a claimed discovery. The external shielding sum is absolutely convergent. For an ideal arithmetic zero lattice `G*S_ext=2` exactly, making `G'=0`; for only R exterior zeros on each side, `G*S_R=2R/(R+1)`, leaving the exact finite-window defect `-8/(R+1)`.

**Conditional quantitative theorem.** Suppose throughout a backward real-simple-zero interval that the R closest exterior zeros on each side remain within relative position error `eps<1` of an ideal lattice based on the current gap. Then

`d_s G>= -8/(R+1)-16*eps`
and
`G(s)>=G(0)-s*(8/(R+1)+16*eps)`.

For a half-unit interval, the strict condition `G(0)>4/(R+1)+8*eps` gives a positive gap margin. For each gap `G(0)`, one numerical parameter choice is `R>=16/G(0)`, `eps<=G(0)/32` (with eps<1). **No such uniform lattice rigidity is proved for actual Xi zeros.** At large heights it would demand roughly O(log² height) neighbors and O(log^-2 height) relative positional accuracy—far stronger than average spacing estimates.

**Less restrictive, still open:** show the integrated positive shielding defect obeys `4*integral_0^s [2-G*S_ext]_+ dv < G(0)` for every gap, backward time and height; also prevent possible migration of nonreal zeros from unbounded height. Without that additional theta-specific control, this approach does not establish RH.

**Exact local tests PASSED:** `certificates/xi_heat_zero_shielding_exact.py` verifies R<=500 telescopes, 14 finite polynomial heat-flow root ODE identities, 32 adversarial rational lattice cases, and four quantitative persistence margins. These tests have also run successfully in local Python. **Lean:** `XiKernel/HeatZeroShielding.lean` contains purely algebraic gates; the infinite theta zero dynamics and continuation are not formalized. **GitHub CI:** latest jobs queued at last check, so no success claimed.

**Published paper:** DOI [10.5281/zenodo.23461586](https://doi.org/10.5281/zenodo.23461586) (author confirms live). No reserved-DOI language should appear.

**Full-manuscript release:** The latest previously emailed 35-page version was combined with a 3-page mathematically edited shielding appendix and independently rendered as `Riemann_Xi_Full_Paper_Zero_Shielding_Update_20Oct2026.pdf` (38 pages). On GitHub, the same work is integrated as `paper/heat_zero_shielding_continuation.tex` in the eight-main-section LaTeX source; complete CI recompilation is pending.

## 20 October 2026 — Noncircular local Rouché-to-shielding certificate

**Mathematical theorem (analytic):** For the *genuine* theta heat flow, start at any t*>Lambda, with a selected consecutive simple real zero pair a<b and initial gap g*=b-a. Pick radius 0<r<g*/2 and three conjugation-invariant contours around the two root disks and their enclosing zero-free corridor. Let m>0 be the initial minimum |H_(t*)| on all contours and let

M_Y = integral_0^infty Phi(u) exp(t* u²) u² exp(Y u) du,

where Y is the maximal boundary imaginary height. The exact Fourier-integral difference satisfies |H_(t*−tau)−H_(t*)|<=tau M_Y on all contours. Whenever sigma M_Y<m, classical Rouché counts one *real simple* root in each disk and no intervening root for tau<=sigma. Therefore g(tau)>=g*−2r>0 **independently** of the signed shielding gap identity. On any real-simple ODE interval,

integral_0^tau D(v) dv <= B_r := r(g*−r), with 4 B_r=g*²−eta_r and eta_r=(g*−2r)²>0.

This is a mathematically valid **short-time, pair-dependent, noncircular shielding envelope**, not the sought uniform-in-height/whole-time estimate. Every fixed actual theta zero pair has some positive certified local time by simplicity and compactness, but the threshold m/M_Y need not be uniform. The published Polymath de Bruijn–Newman bound Lambda<=0.22 independently guarantees global reality for all t>0.22; our contour theorem does not improve that published global range.

**Adversarial quartic proof:** Starting from (z²−1)(z²−4), the backward heat polynomial has a uniform four-disk Rouché margin 231/256−709/800=103/6400>0 for 0<=s<=1/80 at disk radius r=1/4. The positive-pair integrated shielding envelope is B=3/16, eta=1/4. The same quartic nevertheless collides later at s*=(10−sqrt46)/24. This proves an independent *local* certificate cannot simply be iterated without a new verified contour margin.

**Verification:** `paper/rouche_independent_shielding.tex`; `XiKernel/RoucheShieldingTransfer.lean` algebraic gates; `certificates/xi_rouche_shielding_local_exact.py` (20,000 exact Fraction tests and exact quartic margin; local exit 0). New GitHub Lean and PDF actions are queued as of this note, not called passed. The analytic Rouché/transcendental proof is not formalized end-to-end in Lean.

**RH-level outstanding theorem:** independently verify contour lower bounds for the entire remaining interval down to t=0 for every root, prevent degeneration of margins at heights tending to infinity, and prove complete zero labeling/no migration from infinity. This remains unproved; no full RH proof.

**Full paper PDF:** a recovered, previously emailed 43-page cumulative PDF plus a three-page mathematically edited shielding continuation was assembled and checked as a 46-page working PDF and emailed separately. The live DOI is `10.5281/zenodo.23461586` with no obsolete 'reserved' label.
