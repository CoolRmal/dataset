# Ground-truth issues

Applying the per-problem rubrics (`Dataset/<Book>/<decl>.criteria.md`) to the
dataset's own Lean statements turned up defects in the ground truth. They are
recorded here, and in the corresponding rubric row, rather than silently
repaired: changing a statement changes what the benchmark measures, so each of
these is a decision for the dataset owner.

Nothing in this file has been fixed in the Lean sources.

Severity:

- **False** — the statement as written is not a theorem (or is unsatisfiable),
  so it cannot be proved and does not express the textbook result.
- **Junk** — the statement typechecks and may be provable, but some term
  silently evaluates to a default value, so it does not say what it appears to.
- **Divergent** — the statement is a true theorem, but not the book's.

Every entry below was checked against the mathlib sources or by elaborating a
Lean snippet, not by reading alone; the "evidence" column says how.

## False

| Statement | Defect | Evidence |
|---|---|---|
| `MattilaGeometry/mattila_8_8_frostman_lemma` | The "moreover" conjunct (`∃ μ, … ∧ c * hausdorffContent s B ≤ μ B`) is asserted for *every* measurable `B`, not only when $\mathcal H^s(B)>0$. At `B = ∅` it demands `μ ≠ 0` together with `μ ∅ᶜ = μ univ = 0`; monotonicity forces `μ = 0`. The statement is unsatisfiable. | Read the statement's quantifier structure. |
| `ConwayFunctionalAnalysis/conway_IX_2_2_bounded_normal_spectral_theorem` | `scalarMeasure x y B = inner ℂ (E.toFun B x) y` is conjugate-linear in its *first* argument, so the integral clause encodes $T=\int\bar z\,dE$ — the spectral measure of $N^*$. With `E.toFun (spectrum ℂ T) = id` this is unsatisfiable whenever $\sigma(N)$ is not conjugation-symmetric: for $H=\mathbb C$, $T=i\cdot\mathrm{id}$, it reduces to $-i\bar xy = i\bar xy$. | `inner_smul_left : ⟪r • x, y⟫ = r† * ⟪x, y⟫` in `Mathlib/Analysis/InnerProductSpace/Defs.lean`. |
| `EngelkingGeneralTopology/engelking_5_1_9_paracompact_partition_of_unity` | Engelking's "paracompact" includes Hausdorff; mathlib's `ParacompactSpace` does not, and only `[T1Space X]` is assumed. $\mathbb N$ with the cofinite topology is $T_1$ and compact, hence `ParacompactSpace`, but every continuous $f\to\mathbb R$ on it is constant, so the cover $U_n=\mathbb N\setminus\{n\}$ admits no subordinate partition of unity. Item (i) of the `TFAE` holds while (ii) and (iii) fail. | `instance paracompact_of_compact [CompactSpace X] : ParacompactSpace X` — no separation hypothesis. |
| `LeeSmoothManifolds/lee_10_7_sards_theorem` | No `[SecondCountableTopology M]`. Lee builds second countability into "smooth manifold"; mathlib does not, and Sard needs it (the proof takes a *countable* chart cover). Counterexample: $M=\mathbb R\times D$ with $D$ uncountable discrete, $N=\mathbb R$, $F(t,d)=\iota d$ for $\iota : D\hookrightarrow[0,1]$ — every point critical, critical values $[0,1]$. | Typeclass stack of the statement. |
| `LeeSmoothManifolds/lee_10_19_tubular_neighborhood_theorem` | The conclusion demands `ContDiffOn ℝ ⊤`, and `⊤` in `WithTop ℕ∞` is `ω` (real-analytic), not `∞`. A merely $C^\infty$ embedded submanifold — the graph of a smooth non-analytic function — has no real-analytic tubular-neighborhood inverse. | `example : (⊤ : WithTop ℕ∞) = ω := rfl` elaborates; `= ∞` does not. |
| `NikolskiOperators/nikolski_B_3_2_nevanlinna_pick_interpolation` | `solutions` is a set of entire functions `ℂ → ℂ`, while `SchurFunction` constrains `f` only on `ball 0 1`; two solutions differing off the disc are distinct, so `solutions.Subsingleton` never holds when `solutions` is nonempty and the second conjunct's `↔` fails. Separately, `Function.Injective z` (distinct nodes) is missing. | Read `SchurFunction` in `Defs.lean` against the statement. |
| `NikolskiOperators/nikolski_B_7_2_1_adamyan_arov_krein` | At `n = 0`, `RationalVanishingAtInfinityDegreeLE 0` requires `numerator.natDegree < denominator.natDegree ≤ 0`, unsatisfiable in `ℕ`, so `rationalPlusHInfinityDistance φ 0 = sInf ∅ = ⊤` while the other two quantities are $\lVert H_\varphi\rVert$. Taking `φ = 0` gives `0 = ⊤`. | Read the definitions in `Defs.lean`. |
| `NikolskiOperators/nikolski_A_5_4_helson_szego`, `nikolski_B_4_3_3_devinatz_widom` | `circleHilbertTransform` takes `Complex.re (∑' k : ℤ, …)`; in `ℂ`, `Summable` is absolute summability, so the `tsum` is junk `0` unless $\hat v\in\ell^1$ — and when it is, the sum is continuous. Either way the conjugate-function item forces the weight to be bounded above *and below*, breaking the equivalence ($w(\zeta)=\lvert 1-\zeta\rvert^{1/2}$ is $A_2$ but vanishes at $1$). | Reported by the Nikolski audit; the `tsum`-of-non-summable-is-zero mechanism is standard mathlib behaviour. |
| `GrafakosFourier/grafakos_4_1_1_torus_summability_uniform_boundedness` | The operator `A` is applied to arbitrary `f` with `MemLp f p μ`, but the book defines it only on $C^\infty(\mathbb T^n)$; for $\hat f\notin\ell^1$ the `tsum` is junk `0`. With $n=1$, $p=2$, $a(m,R)=\mathbf 1_{\lvert m\rvert\le R}$ the right side holds with `C = 1` while the left demands $\lVert S_Rf\rVert_2\to0$. | Reported by the Grafakos audit. |
| `GrafakosFourier/grafakos_5_3_1_calderon_zygmund_decomposition` | `Q : ℕ → DyadicCube n` with pairwise-disjoint carriers forces infinitely many cubes of positive volume, so `∑' j, volume (Q j).carrier > 0` always; the conjunct bounding that sum by `eLpNorm f 1 volume / ENNReal.ofReal α` is unsatisfiable when $f=0$ a.e. The book's cube family may be finite or empty. | Reported by the Grafakos audit. |
| `KongODE/kong_1_5_3_differentiable_dependence` | Missing `IsOpen D`. With $n=k=1$, $f\equiv1$, $D=\mathbb R\times\{0\}\times\{0\}$, the containment and openness of the solution interval force the solution to be constantly $0$ while `IsTrajectoryOn` demands derivative $1$. | Reported by the Kong audit. |
| `KongODE/kong_2_3_1_variation_of_parameters` | The `↔` fails right-to-left: `I.OrdConnected` permits `I = Icc 0 1`, but solutions must satisfy two-sided `HasDerivAt` at every `t ∈ I` while the formula constrains `y` only on `I`. Needs `IsOpen I` or `HasDerivWithinAt`. | Reported by the Kong audit. |
| `KongODE/kong_2_5_3_floquet_theorem` | No continuity hypothesis on `A`. Since `exp (t • R)` is invertible, `P t = X t * exp (-t • R)` is forced, so requiring `P ∈ C¹` forces `A = X'X⁻¹` continuous — not assumed. | Reported by the Kong audit. |
| `KongODE/kong_3_4_2_integrable_perturbation_stability` | `UniformlyStableZeroSolution` quantifies `t₀` over all of `ℝ` while `IntegrableSmallPerturbation` controls `r` only for `t ≥ 0`. With $A\equiv0$, $p\equiv0$, $r\,t\,x=\max(-t,0)\cdot e_0$, solutions from $t_0=-T$ reach norm $T^2/2$. | Reported by the Kong audit. |
| `KongODE/kong_3_5_2_lasalle_invariance_stability`, `kong_4_5_3_generalized_poincare_bendixson` | No regularity at all is assumed of the vector field, which both LaSalle and Poincaré–Bendixson require; a planar field continuous off a circle and tangential there admits trajectories accumulating on a set that is neither equilibrium, closed orbit, nor graphic. | Reported by the Kong audit. |
| `KongODE/kong_6_6_4_periodic_sturm_liouville_coupling` | Two causes. (i) `{lam μ ν : ℕ → ℝ}` are implicit and therefore universally quantified; `lam = μ = ν = 0` falsifies `Tendsto lam atTop atTop`. They must be existentially bound. (ii) `IsSturmLiouvilleEigenfunction` requires only global `y ≠ 0`, so a smooth bump vanishing on $(-\infty,b]$ is an "eigenfunction" for every eigenvalue. | Reported by the Kong audit. |
| `GrafakosFourier/grafakos_1_3_2_marcinkiewicz_interpolation` | Not provable as stated: the conclusion's `HasStrongType` bundles `AEStronglyMeasurable (T f) ν`, but the hypotheses never say `T` takes values in measurable functions, and sublinearity gives no additivity from which to derive it. | Reported by the Grafakos audit. |
| `KrylovHolder/krylov_2_3_1_green_poisson_representation` | `K` is a free variable with no hypothesis making it the fundamental solution, so `K = h = G = H = 0` satisfies every hypothesis; with $f=0$, $g=1$, $u\equiv1$ the conclusion asserts $u(x)=0$. | Reported by the Krylov audit. |
| `KrylovHolder/krylov_3_7_2_constant_coefficient_holder_solvability`, `krylov_4_5_1_variable_coefficient_global_solvability` | `lam ≠ 0` admits $\lambda<0$ while the symbol condition admits $L=\Delta$. For $d=1$, $Lu=u''$, $\lambda=-1$, $f=0$, both $0$ and $\sin$ satisfy the `∃!` body, so uniqueness fails. | Reported by the Krylov audit. |
| `KrylovHolder/krylov_4_2_1_better_regular_data_better_regular_solution` | Two causes: the same negative-$\lambda$ admission, and `{lam₀ : ℝ}` with `0 ≤ lam₀` being a *universally quantified input* rather than `∃ lam₀`, so the estimate is asserted at $\lambda_0=0$, where $u_n=\sin(x/n)$ refutes it. | Reported by the Krylov audit. |
| `KrylovHolder/krylov_6_5_3_smooth_domain_dirichlet_solvability` | `EllipticDirichletSolution` omits `ContinuousOn u (closure Ω)`, so $\mathbf 1_\Omega$ is a second "solution" for $L=\Delta$, $f=g=0$; and no sign condition is imposed on the zeroth-order coefficient, so $L=\Delta+\lambda_1$ gives an eigenfunction counterexample. | Reported by the Krylov audit. |
| `KrylovHolder/krylov_7_1_2_interior_holder_regularization` | `HolderOn` is a uniform, up-to-the-boundary gauge, but interior regularity is local. On the unit disc with $u=\operatorname{Re}((1-z)^{5/2})$, the hypotheses hold while $D^3u\sim(1-z)^{-1/2}$ is unbounded on $\Omega$. | Reported by the Krylov audit. |
| `KrylovHolder/krylov_10_3_3_parabolic_dirichlet_domain_solvability` | `parabolicBoundary` is **inverted**: `{p ∈ frontier Q \| ∀ ε>0, ∃ q ∈ Q, q.1 ≤ p.1 ∧ dist q p < ε}` includes a cylinder's terminal face and excludes its initial face, so the statement prescribes terminal data — a backward problem. Also lacks continuity up to $\partial'Q$ and any $\partial Q$ regularity. | Reported by the Krylov audit. |

## Junk

| Statement | Defect | Evidence |
|---|---|---|
| `MattilaGeometry/Defs.hausdorffContent` (affects `mattila_8_8_frostman_lemma`) | Sums `ENNReal.ofReal (Metric.diam (U i)) ^ s`, and `Metric.diam` is `0` on unbounded sets. Covering by `U i = univ` gives content `0`, so `hausdorffContent s A = 0` for every `A` in an unbounded space and every `s > 0`. `EMetric.diam`, valued in `ℝ≥0∞`, is the fix. | `theorem diam_eq_zero_of_unbounded` in `Mathlib/Topology/MetricSpace/Bounded.lean`. |
| `MattilaGeometry/Defs.rieszEnergy` (affects `mattila_9_7_projection_energy`) | `ENNReal.ofReal (dist x y)⁻¹ ^ s` parses as `ofReal ((dist x y)⁻¹)`, so the diagonal contributes `0` rather than `⊤`. Then `rieszEnergy m (dirac 0) = 0 < ∞` satisfies the hypothesis while the conclusion fails. Intended: `(ENNReal.ofReal (dist x y))⁻¹ ^ s`. | `set_option pp.parens true` prints `ENNReal.ofReal (dist x y)⁻¹`; `ENNReal.ofReal (dist x x)⁻¹ ^ s = 0` proves by `simp`. |
| `KallenbergProbability/kallenberg_9_30_optional_sampling_and_closure` | In the closure clause `τ'` ranges over all stopping times, and `stoppedValue u τ ω = u (τ ω).untopA ω` with `untopA = untopD (Classical.arbitrary _)`. On $\{\tau'=\infty\}$ the term is `X` at an arbitrary *finite* time, not $X_\infty=\lim_{t\to\infty}X_t$. The bounded half is unaffected. | `stoppedValue` in `Mathlib/Probability/Process/Stopping.lean`; `unbotA` in `Mathlib/Order/WithBot.lean`. |
| `MattilaGeometry/mattila_9_7_projection_energy`, `mattila_10_10_plane_sections`, `mattila_18_1_besicovitch_federer_projection` | `[MeasurableSpace (Grassmannian n m)]` is an unconstrained instance argument, so each theorem is asserted for *every* measurable structure. Under `⊥`, a Dirac measure satisfies `IsInvariantGrassmannianMeasure` and "for $\gamma$-a.e. $V$" collapses to "for all $V$", which falsifies all three. The invariance hypothesis does pin down $\gamma_{n,m}$ once the Borel structure of the natural topology is fixed — nothing fixes it. | Reported by the Mattila audit, checked in Lean by that agent. |
| `GrafakosFourier/grafakos_2_2_16_hausdorff_young` | `𝓕` is the Bochner integral, identically `0` for $f\in L^p\setminus L^1$, so for $1<p\le2$ and non-integrable $f$ the conclusion degenerates to $0\le\lVert f\rVert_p$. The statement retains content only on $L^1\cap L^p$; the intended $L^p$-extension of $\mathcal F$ is not expressible with mathlib's `𝓕`. | Reported by the Grafakos audit. |

## Divergent

| Statement | Divergence |
|---|---|
| `LeeSmoothManifolds/lee_7_6_inverse_function_theorem`, `lee_7_8_rank_theorem` | `Defs.SmoothDiffeomorphismOn` uses `ContDiffOn ℝ ⊤`, i.e. `ω`. Both remain true theorems — the analytic inverse function and rank theorems — but they are not Lee 7.6 and 7.8, which are $C^\infty$. |
| `MattilaGeometry/mattila_7_7_lipschitz_level_sets` | Mattila uses the *upper* integral $\int^*$ because $y\mapsto \mathcal H^{s-m}(A\cap f^{-1}\{y\})$ is not known to be measurable; `∫⁻` is the lower integral, so the Lean inequality is strictly weaker than the book's. |
| `MattilaGeometry/mattila_12_14_falconer_distance_set` | No `2 ≤ n`. At $n=1$ part (2) is not Falconer's theorem and is contradicted by known compact $A\subset\mathbb R$ with $\dim(A-A)=\dim A$. Inherited from the transcription, not introduced by the Lean. |
| `KrylovHolder/krylov_2_5_2_harmonic_smooth_interior_estimates` | `⊤` is `ω`, so the hypothesis is analyticity; the constant is also allowed to depend on $u$ and $\Omega$; and `Fin d → ℝ` carries the sup norm, so `Metric.closedBall` is a cube. |
| `KrylovHolder/krylov_2_3_1_green_poisson_representation` (measure) | `Fin d → ℝ` carries the sup norm, so `μH[d-1]` is not the Euclidean surface measure the Green–Poisson representation is stated with. |
| `NikolskiOperators/nikolski_A_1_3_beurling_invariant_subspaces` | Formalizes Beurling's theorem in $H^2$ rather than Beurling–Helson in $L^2$, which is the stated result. |
| `ConwayFunctionalAnalysis/conway_VIII_5_17_gelfand_naimark` | `[CStarAlgebra A]` is mathlib's *unital* class, narrowing the theorem. |
| `KongODE/kong_5_4_2_hopf_friedrich_dichotomy` | `ContDiff ℝ ⊤` is `ω`, so the vector field is assumed real-analytic rather than $C^\infty$ — defensible for the Hopf–Friedrich dichotomy, but not what the book says. |
| `GrafakosFourier/grafakos_2_2_14_fourier_identities_on_schwartz` | The last conjunct restates identity (1) with `g := h` rather than the book's identity (5), $\int f h=\int\widehat f\,h^{\vee}$; four of five identities are covered. |

## Recurring patterns

These are worth checking in any new statement added to the dataset.

1. **`⊤` is `ω`, not `∞`.** In `WithTop ℕ∞` the top element is real-analytic.
   Smoothness must be written `∞` (with `open scoped ContDiff`). A `⊤` in a
   hypothesis strengthens it; a `⊤` in a conclusion usually makes the statement
   false.
2. **Textbook separation conventions.** Engelking's regular, normal,
   paracompact and completely regular all include $T_1$, and his compact
   includes Hausdorff; Lee's "smooth manifold" includes Hausdorff and second
   countable. Mathlib's corresponding classes include none of these, so the
   missing axiom has to be added explicitly — and it is sometimes load-bearing.
3. **Junk defaults on partial operations.** `Metric.diam` on unbounded sets,
   `x⁻¹` and `x / 0` at zero, `sInf ∅ = ⊤` / `sSup ∅ = 0`, `deriv` and `mfderiv`
   off the differentiability locus, `Measure.map` of a non-measurable map,
   `condExp` of a non-integrable function, `tsum` of a non-summable family, and
   `stoppedValue` at `⊤` all evaluate to a default rather than failing.
4. **Where the quantifier sits.** "There is a constant $N$ such that for all
   $u$" must put `∃ N` outside `∀ u`; "unique up to …" needs the equivalence
   made explicit; and a set of functions constrained only on a subdomain is
   never a subsingleton.
