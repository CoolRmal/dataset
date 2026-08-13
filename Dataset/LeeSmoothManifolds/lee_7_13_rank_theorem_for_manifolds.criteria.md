# Criteria: lee_7_13_rank_theorem_for_manifolds

**Statement:** [lee_7_13_rank_theorem_for_manifolds.md](lee_7_13_rank_theorem_for_manifolds.md) · **Lean:** [lee_7_13_rank_theorem_for_manifolds.lean](lee_7_13_rank_theorem_for_manifolds.lean)

## What the theorem says

This is the previous rank theorem moved from open subsets of Euclidean space to manifolds. Let $M$
and $N$ be smooth manifolds of dimensions $m$ and $n$, and let $F : M \to N$ be smooth with the
differential $dF_p$ having the same rank $k$ at every point. Then around any point $p$ there are
smooth charts on $M$ and on $N$ — centred at $p$ and at $F(p)$ — in which $F$ reads
$(x^1,\dots,x^m) \mapsto (x^1,\dots,x^k,0,\dots,0)$. The charts must belong to the smooth structure,
not just be arbitrary homeomorphisms, or the normal form would say nothing about smoothness.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $M$ is a smooth manifold of dimension exactly $m$, without boundary, and $N$ one of dimension exactly $n$. | ✅ `[ChartedSpace (Fin m → ℝ) M]` with `[IsManifold 𝓘(ℝ, Fin m → ℝ) ∞ M]`, and the same for `N` with `n`. The model `𝓘(ℝ, ·)` is boundaryless and `∞` gives $C^\infty$ transition maps. |
| 2 | $F$ is smooth. | ✅ `hF : ContMDiff 𝓘(ℝ, Fin m → ℝ) 𝓘(ℝ, Fin n → ℝ) ∞ F`. |
| 3 | The differential has rank exactly $k$ at **every** point of $M$. | ✅ `hrank : ConstantRank F k`, i.e. `∀ p, Module.finrank ℝ (LinearMap.range (mfderiv … F p).toLinearMap) = k`. |
| 4 | The smoothness hypothesis must be there so that `mfderiv` is the real differential and not a default value. | ✅ `hF` is present. Mathlib sets `mfderiv` to the zero map at points where $F$ is not `MDifferentiableAt`. |
| 5 | The conclusion is claimed for every point of $M$. | ✅ `∀ p, ∃ φ ψ, …`. |
| 6 | The chart on $M$ and the chart on $N$ belong to the *smooth* structure. | ✅ `φ ∈ IsManifold.maximalAtlas 𝓘(ℝ, Fin m → ℝ) ∞ M` and `ψ ∈ IsManifold.maximalAtlas 𝓘(ℝ, Fin n → ℝ) ∞ N`. |
| 7 | The charts are positioned: $p$ is in the domain of $\varphi$, and $F(p)$ is in the domain of $\psi$. | ✅ `p ∈ φ.source` and `F p ∈ ψ.source`. |
| 8 | $F$ carries the domain of $\varphi$ into the domain of $\psi$. | ✅ `MapsTo F φ.source ψ.source`. |
| 9 | The normal form holds on the whole chart image: for every $x \in \varphi(\text{source})$, coordinate $i$ of $\psi(F(\varphi^{-1}(x)))$ is $x^i$ for $i < k$ and $0$ for the remaining $n - k$ coordinates. | ✅ `∀ x ∈ φ.target, ψ (F (φ.symm x)) = fun i ↦ if h : i.1 < k ∧ i.1 < m then x ⟨i.1, h.2⟩ else 0`. |
| 10 | Lee's coordinates are **centred**: $\varphi(p) = 0$ and $\psi(F(p)) = 0$. | ⚠️ Missing. Neither conjunct appears, so our conclusion is weaker than the text. Adding `φ p = 0` alone would suffice, since the normal form then forces `ψ (F p) = 0`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Stating the constant-rank hypothesis but weakening `hF` to `Continuous F`, or dropping it on the grounds that constant rank implies differentiability. | It does not imply it in Lean. `mfderiv` is the zero map wherever $F$ is not `MDifferentiableAt`, so a wildly discontinuous $F$ satisfies the rank condition with $k = 0$ and the conclusion asserted for it is false. |
| 2 | Producing bare `OpenPartialHomeomorph`s without requiring membership in the maximal $C^\infty$ atlas. | Those are only topological charts. The normal form in topological charts says nothing about the smooth structure and is a much weaker claim. |
| 3 | Using the `chartAt` supplied by the `ChartedSpace` instance instead of existentially quantifying over charts. | That asserts the normal form in one specific preselected chart, which is a different and unprovable statement — the theorem produces charts adapted to $F$. |
| 4 | Assuming the rank is $k$ only at the point $p$ being considered. | Constant rank on a neighbourhood is exactly what the proof consumes; pointwise rank at $p$ alone does not give the normal form. |
| 5 | Dropping `MapsTo F φ.source ψ.source`. | Then $F(\varphi^{-1}(x))$ can lie outside $\psi$'s domain, where an `OpenPartialHomeomorph` returns a junk value, so the asserted equation is not about the coordinate representation of $F$. |
| 6 | Letting the manifold dimensions be existentially quantified, or working with `ChartedSpace H` for an abstract normed space $H$. | Lee fixes $\dim M = m$ and $\dim N = n$, and the normal form's index arithmetic ($k$ copied coordinates, $n-k$ zeros) only makes sense with those numbers fixed. |

## Notes on the ground truth

- Lee's "smooth manifold" is second countable and Hausdorff. Mathlib carries those as the separate
  typeclasses `[T2Space M]` and `[SecondCountableTopology M]`, and neither is assumed here. ⚠️ This
  is harmless *for this theorem* — the rank theorem is local, so the Lean version is more general and
  still true — but it is not a transcription of the book's hypotheses. The same omission is fatal in
  `lee_10_7_sards_theorem`, where second countability is genuinely needed.
- `hk : k ≤ m ∧ k ≤ n` is redundant: the rank of a map $T_pM \to T_{F(p)}N$ is at most $\min(m,n)$,
  and if $M$ is empty both the hypothesis and the conclusion say nothing. A candidate that omits it
  is at least as faithful.
- The model space is `Fin m → ℝ` (sup norm) rather than Mathlib's usual
  `EuclideanSpace ℝ (Fin m)`. They carry the same smooth structure and the same notion of
  `ContMDiff`, so nothing here changes; a candidate using `EuclideanSpace` is equally good or better.
  The choice would matter in a statement that mentioned distances or norms.
- The `i.1 < m` conjunct inside the `if` exists only to build a `Fin m` index and is implied by
  `i.1 < k` together with `hk.1`.
