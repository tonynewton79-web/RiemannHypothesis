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
- The locally assembled user-delivered 20-page PDF combined the last compiled 18-page cumulative manuscript with a 2-page scientific heat-flow addendum, and removed obsolete DOI reservations. The GitHub LaTeX master integrates the new result in the main narrative; its fresh automatic build is pending.

**Next proof gate:** prove or refute an actual theta-specific heat comparison/zero-exclusion statement uniform in real x and all Laguerre orders, with independent mathematical review. RH is not proved.

## 19 October 2026 — Manuscript reconciliation, new abstract and theta-specific heat-flow result

**Canonical manuscript source:** `paper/main.tex` has a newly written problem-first abstract. The manuscript omits repository publication identifiers and retains only scholarly references. The eight main research sections remain, with the verification material promoted to Appendix A.

**Uploaded manuscript reconciliation:** the two 20-page PDFs share the same 18-page main content but have distinct two-page addenda. The longer DOI-version addendum states the Gaussian-cosh double-real-zero theorem more precisely. That theorem, its correct fourth-derivative Laguerre term, the de Bruijn–Newman curvature invariance, and the coupled heat PDE were already included in `paper/theta_heat_flow_barrier.tex`. The alternative supplemental pages are **not** repeated in the canonical source.

**New theta-specific heat-flow estimate:** `paper/theta_heat_specific_tail.tex` proves uniformly for every `0<=t<=1/2`, all k>=0, and `|Im z|<=3`:
`|H_t^(k)(z)-H_(t,M)^(k)(z)| <= (3*k!/(2*4^k)) * q*exp(-q+1/16)`,
where `q=pi*(M+1)^2`. For k=0 the strip extends to `|Im z|<=7`. The genuine theta square-lattice proof uses `exp(4u)>=8u²`, exact incomplete gamma bounds, and an explicit positive quartic polynomial in `q-12`. This produces a uniform-in-heat-time **absolute** approximation bound for adjacent-order Laguerre source terms.

**All-order but bounded band:** conditional only on the earlier globally certified theta-curvature theorem, the paper derives an explicit common `|x|<r_*` positivity interval for all `n>=1` and all `t∈[0,1/2]`, where `r_*²=2 M0(0)M2(0)/(M0(1/2)M4(1/2))`, `M_j(t)=∫u^j exp(tu²)Phi(u)du`. This persists across the full backward heat interval **only within a bounded Fourier band**, not globally.

**Verification:** `certificates/xi_theta_heat_tail_exact.py` passed locally using exact rational operations, including the quartic identity and combinatorial cancellations for n=0..80. `XiKernel/ThetaHeatTail.lean` contains polynomial and tilt sign subtheorems submitted to the Lean CI build; the full theta-series and Fourier integral proof is NOT end-to-end Lean formalized. See the current GitHub Actions status before declaring this new Lean module CI-PASS.

**Unresolved RH step:** all-order global Fourier positivity or a height-uniform off-axis contour modulus lower bound. RH remains open. Prior-art/novelty review is pending.
