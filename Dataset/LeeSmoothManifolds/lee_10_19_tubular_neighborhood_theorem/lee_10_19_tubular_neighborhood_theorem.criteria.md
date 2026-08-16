# Criteria: lee_10_19_tubular_neighborhood_theorem

**Statement:** [lee_10_19_tubular_neighborhood_theorem.md](lee_10_19_tubular_neighborhood_theorem.md) · **Lean:** [lee_10_19_tubular_neighborhood_theorem.lean](lee_10_19_tubular_neighborhood_theorem.lean) · **Context:** [lee_10_19_tubular_neighborhood_theorem.context.md](lee_10_19_tubular_neighborhood_theorem.context.md)

## What the theorem says

The one printed line hides a definition. A *tubular neighbourhood* of an embedded submanifold
$M \subseteq \mathbb{R}^n$ is an open set $U$ containing $M$ that looks exactly like a thickened
copy of $M$ in the directions perpendicular to it: pick for each $x \in M$ a radius $\delta(x) > 0$,
form the set of pairs $(x,v)$ with $v$ perpendicular to $M$ at $x$ and $\lvert v\rvert < \delta(x)$,
and require that the map $(x,v) \mapsto x + v$ takes that set one-to-one onto $U$ with a smooth
inverse. The theorem says every embedded submanifold of $\mathbb{R}^n$ has one. The radius must be
allowed to vary from point to point, because $M$ need not be closed.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $M$ is an embedded submanifold of $\mathbb{R}^n$, expressed by Lee's local slice condition with charts drawn from the *smooth* structure. | ✅ `hM : EmbeddedSubmanifoldOfCodimension (m := n) M codim`, whose charts are required to lie in `IsManifold.maximalAtlas 𝓘(ℝ, Fin n → ℝ) ∞`, so they are smooth charts and not mere homeomorphisms. `codim` is universally quantified, covering submanifolds of every dimension. |
| 2 | No closedness, compactness or properness is assumed of $M$. | ✅ None of these appears. Lee's theorem holds for every embedded submanifold. |
| 3 | A radius function on $M$ that is strictly positive at every point. | ✅ `radius : M → ℝ` with `∀ x, 0 < radius x`. |
| 4 | The radius is allowed to vary from point to point rather than being a single constant. | ✅ It is a function on `M`, not a real number. |
| 5 | "$v$ is perpendicular to $M$ at $x$" has to be defined by hand, since Mathlib has no normal-bundle API. | ✅ `IsNormalVector M x v` (in `Defs.lean`): `x ∈ M`, and for every curve `γ : ℝ → (Fin n → ℝ)` with `γ 0 = x` that stays in `M` near $0$ and has derivative `velocity` at $0$, one has `∑ i, v i * velocity i = 0`. For a $C^\infty$ embedded submanifold the set of such velocities is exactly the tangent space, so this is faithful. |
| 6 | The disk bundle: pairs $(x,v)$ with $v$ normal at $x$ and $\lvert v\rvert < \delta(x)$. | ✅ `NormalDiskBundle M radius = {p \| IsNormalVector M p.1 p.2 ∧ ‖p.2‖ < radius p.1}`. |
| 7 | $U$ is open and contains $M$. | ✅ `IsOpen U ∧ M ⊆ U`. |
| 8 | The map $(x,v) \mapsto x + v$ carries the disk bundle one-to-one **onto** $U$. | ✅ `Set.BijOn (fun p : M × (Fin n → ℝ) ↦ (p.1 : Fin n → ℝ) + p.2) (NormalDiskBundle M radius) U`. |
| 9 | The inverse of that map is smooth, in both of its components. | ✅ `ContinuousOn inverse U`, `ContDiffOn ℝ ∞ (fun z ↦ ((inverse z).1 : Fin n → ℝ)) U` and `ContDiffOn ℝ ∞ (fun z ↦ (inverse z).2) U`, with `∞` meaning $C^\infty$. |
| 10 | `inverse` really is the inverse of $(x,v) \mapsto x+v$ on the bundle. | ✅ `∀ p ∈ NormalDiskBundle M radius, inverse ((p.1 : Fin n → ℝ) + p.2) = p`. No separate "`inverse` lands in the bundle" clause is needed: that follows from surjectivity in `BijOn` together with this left-inverse clause. |
| 11 | The radius function is **continuous**. | ✅ `Continuous radius`, alongside positivity. Without it the "disk bundle" need not be open inside the normal bundle and the object produced would not be the book's tubular neighbourhood. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Encoding "embedded submanifold" as the image of an injective immersion. | That is an *immersed* submanifold, and the theorem is false for those: the immersed figure-eight in the plane has no tubular neighbourhood, because the two branches through the crossing point force overlapping normal disks. |
| 2 | Adding `IsClosed M` or a compactness hypothesis. | This reduces the theorem to the much easier uniform-radius case. Lee's statement covers every embedded submanifold, and the variable radius exists precisely to handle the non-closed ones. |
| 3 | Using a single constant radius $\varepsilon > 0$ for all of $M$. | False as stated. An open interval embedded in the plane as a spiral accumulating on itself admits no uniform tube. |
| 4 | Writing the smoothness class as `⊤` under `open scoped ContDiff`. | That elaborates to `ω`, real-analytic. Here it sits in the *conclusion*, so the statement would demand more than is true: `EmbeddedSubmanifoldOfCodimension` only makes $M$ a $C^\infty$ submanifold, and the tubular retraction of a smooth non-analytic submanifold — the graph of a smooth non-analytic function in $\mathbb{R}^2$ — is $C^\infty$ but not $C^\omega$. Our file had this defect and it was repaired to `∞`. |
| 5 | Defining the normal directions as the orthogonal complement of an ad hoc span, or through `mfderiv` of an unnamed parametrization. | Both invite default values: `mfderiv` is the zero map where the parametrization is not differentiable, and an ad hoc span may not be the tangent space, so the "normal" set can come out too big or too small. |
| 6 | Asserting only that $(x,v) \mapsto x+v$ is injective on the bundle, without surjectivity onto $U$. | Then $U$ is not identified with the tube; it could be all of $\mathbb{R}^n$ and the statement would say almost nothing. |
| 7 | Asserting only that $(x,v) \mapsto x+v$ is a homeomorphism onto $U$. | A tubular neighbourhood is a *diffeomorphism*. The smooth inverse is what lets one build the smooth retraction $U \to M$, which is the whole use of the theorem. |
| 8 | Omitting `M ⊆ U` or `IsOpen U`. | Without them $U$ is not a neighbourhood of $M$ at all, and the word "neighbourhood" in the statement is unfulfilled. |

## Notes on the ground truth

- `Continuous radius` is asserted alongside positivity, so the disk bundle is open in the normal
  bundle and the object produced really is a tubular neighbourhood.
- `∑ i, v i * velocity i` is the genuine Euclidean inner product, which is the right notion of
  perpendicularity even though `Fin n → ℝ` carries the sup norm.
- The fibre condition is `∑ i, (p.2 i)^2 < (radius p.1)^2`, so the fibres are Euclidean balls
  rather than sup-norm boxes.
- Quantifying only over curves that are smooth, rather than merely differentiable at $0$, would give
  the same tangent space and is an acceptable variant.
- `EmbeddedSubmanifoldOfCodimension` carries `codim ≤ m`, so the slice condition cannot be read
  through a truncated subtraction.
- `IsNormalVector M x v` includes the conjunct `x ∈ M`. Inside `NormalDiskBundle` the first
  component already has type `↥M`, so that conjunct is automatically satisfied there and adds
  nothing.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[lee_10_19_tubular_neighborhood_theorem.md](lee_10_19_tubular_neighborhood_theorem.md) and the background in [lee_10_19_tubular_neighborhood_theorem.context.md](lee_10_19_tubular_neighborhood_theorem.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 11 rows, so each row is worth 4.5 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 11 with the radius not required continuous.
- Requirement 4 with a single constant radius.
- Requirement 8 or 9 with the bijection or the smoothness of its inverse dropped.

### Domain-specific pitfalls for this problem

- The radius is a positive **continuous** function on $M$, varying from point to point.
- Normality is orthogonality to the tangent space, which has to be spelled out since the ambient library has no normal-bundle API.
- The identification map is $(x,v)\mapsto x+v$ and must be a bijection onto the open set $U$, with smooth inverse in both components.
- No closedness or compactness of $M$ is assumed.
