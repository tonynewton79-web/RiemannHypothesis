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
