# Criteria: mattila_10_10_plane_sections

**Statement:** [mattila_10_10_plane_sections.md](mattila_10_10_plane_sections.md) · **Lean:** [mattila_10_10_plane_sections.lean](mattila_10_10_plane_sections.lean)

## What the theorem says

Let $A \subset \mathbb{R}^n$ be a Borel set with $0 < \mathcal{H}^t(A) < \infty$, where $m < t < n$.
Slice $A$ by a family of parallel planes: fix a subspace $W$ of dimension $n-m$ and translate it by
vectors $a$ in the orthogonal complement $W^\perp$, which is $m$-dimensional. The theorem says two
things. First, for **every** choice of $W$, almost all the slices $A \cap (W+a)$ have finite
$(t-m)$-dimensional measure — so the slices are not too big. Second, for **almost every** $W$, chosen
according to the rotation-invariant probability measure on the Grassmannian, a set of translates $a$
of positive $\mathcal{H}^m$ measure gives slices of the expected dimension $t-m$ — so the slices are
not too small either. The second part is only claimed for a positive-measure set of translates, never
for almost all of them.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The Grassmannian $G(n, n-m)$ must carry a fixed measurable structure, so that "for $\gamma_{n,n-m}$ almost all $W$" means something. | ✅ `Defs.lean` gives `Grassmannian n (n - m)` the topology induced by the projection operators, then its Borel $\sigma$-algebra and a `BorelSpace` instance. |
| 2 | $\gamma_{n,n-m}$ is a probability measure invariant under all linear isometries of $\mathbb{R}^n$. | ✅ `γ : Measure (Grassmannian n (n - m))` with `hγ : IsInvariantGrassmannianMeasure γ`. |
| 3 | The hypotheses $m < t$ and $t < n$. | ✅ `hmt : (m : ℝ) < t ∧ t < n`. ⚠️ Packaged as one conjunction; two hypotheses would be more idiomatic. |
| 4 | $A$ is Borel with $\mathcal{H}^t(A)$ both finite and positive. | ✅ `hA : MeasurableSet A`, `hAfinite : μH[t] A < ∞`, `hApos : 0 < μH[t] A`. |
| 5 | The affine planes are $W_a = W + a$ indexed by $a \in W^\perp$, and the slice is $A \cap W_a$. | ✅ `slice W a = A ∩ {x \| x - (a : EuclideanSpace ℝ (Fin n)) ∈ W.1}` with `a : ↥W.1ᗮ`. |
| 6 | Clause (1) holds for **all** $W$, and for $\mathcal{H}^m$-almost every translate $a$: the slice has finite $\mathcal{H}^{t-m}$ measure. | ✅ `∀ W, ∀ᵐ a ∂(μH[(m : ℝ)] : Measure ↥W.1ᗮ), (μH[t - m]) (slice W a) < ∞`. |
| 7 | Clause (2) holds for $\gamma$-almost every $W$ and asserts that the translates giving slices of dimension exactly $t-m$ form a set of **positive** $\mathcal{H}^m$ measure. | ✅ `∀ᵐ W ∂γ, 0 < μH[(m : ℝ)] {a : ↥W.1ᗮ \| dimH (slice W a) = ENNReal.ofReal (t - m)}`. |
| 8 | Both clauses are asserted, joined by "and". | ✅ A conjunction of the two. |
| 9 | The target dimension must be compared correctly against `dimH`, which is `ℝ≥0∞`-valued. | ✅ `ENNReal.ofReal (t - m)`, with `t - m > 0` guaranteed by the hypotheses. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Leaving the $\sigma$-algebra on the Grassmannian as an unconstrained instance argument. | Invariance plus total mass $1$ characterizes $\gamma_{n,n-m}$ only relative to the Borel structure of its natural topology. With the trivial $\sigma$-algebra, a Dirac measure at one subspace qualifies and "for a.e. $W$" collapses to "for all $W$" — and clause (2) then fails, for instance for $A = C \times [0,1] \subset \mathbb{R}^2$ with $\dim C = t-1$ and $W$ the vertical direction. |
| 2 | Upgrading clause (2) to "for $\mathcal{H}^m$ almost all $a$". | The theorem only claims a positive-measure set of good translates. Almost all is a strictly stronger and unproved assertion. |
| 3 | Making clause (1) hold only for almost every $W$. | Clause (1) is stated for every $W$; weakening the quantifier loses part of the theorem. |
| 4 | Indexing the translates by arbitrary $a \in \mathbb{R}^n$, or by $a \in W$. | Each plane would then be counted once for every point of $W$ lying in it, which destroys both the "almost every $a$" and the "positive measure of $a$" statements. The translates must run over $W^\perp$. |
| 5 | Replacing `0 < μH[m] {a \| …}` by `∃ a, dimH (slice W a) = t - m`. | A single good translate is far weaker than a positive-measure set of them, and is not what 10.10 asserts. |
| 6 | Formalizing only clause (1). | Clause (1) is the routine Fubini-type bound; clause (2) is the substance of the theorem. |
| 7 | Comparing `dimH` against a real number, or writing the target dimension as an `ℝ≥0∞` subtraction `(t : ℝ≥0∞) - m`. | `dimH` lands in `ℝ≥0∞`, and subtraction there is truncated at `0`, so an `ℝ≥0∞` difference can silently become `0` and change the claim. |
| 8 | Dropping $\mathcal{H}^t(A) < \infty$ or $0 < \mathcal{H}^t(A)$. | Finiteness is what clause (1) needs; positivity is what clause (2) needs. Neither is decorative. |

## Notes on the ground truth

- An earlier version left the measurable structure on the Grassmannian as an unconstrained instance
  argument; that defect has been repaired in `Defs.lean` and survives above as Mistake 1.
- `Grassmannian n (n - m)` uses truncated natural subtraction. If $m \ge n$ this would silently
  become the one-point Grassmannian `Grassmannian n 0`. The hypothesis $m < t < n$ forces $m < n$,
  so `n - m` is the genuine difference.
- $\mathcal{H}^{t-m}$ of the slice is computed in the ambient $\mathbb{R}^n$. This is the same number
  as the intrinsic value inside the plane, because the inclusion of the plane is an isometry.
- $\mathcal{H}^m$ on $W^\perp$ enters only through "almost every $a$" and "positive measure", so the
  constant relating it to Lebesgue measure on that $m$-dimensional subspace is irrelevant.
- The slice family is introduced by a local `let slice := …` inside the statement, which elaborates
  to a binder in the theorem's type. Harmless, but a top-level abbreviation would be tidier.
