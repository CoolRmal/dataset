# Criteria: mattila_15_19_rectifiability_tangent_planes

**Statement:** [mattila_15_19_rectifiability_tangent_planes.md](mattila_15_19_rectifiability_tangent_planes.md) · **Lean:** [mattila_15_19_rectifiability_tangent_planes.lean](mattila_15_19_rectifiability_tangent_planes.lean)

## What the theorem says

Let $E \subset \mathbb{R}^n$ be measurable with $\mathcal{H}^m(E) < \infty$. The theorem says four
descriptions of $E$ are equivalent. The first is that $E$ is $m$-rectifiable: countably many
Lipschitz images of $\mathbb{R}^m$ cover all of $E$ except an $\mathcal{H}^m$-null set. The second is
that $E$ is linearly approximable: near almost every point of $E$, and at every small scale, $E$
looks close to an $m$-plane — it fills that plane densely and almost none of it strays far from the
plane. The third is that at almost every point of $E$ there is a *unique* approximate tangent
$m$-plane, and the fourth that there is *some* approximate tangent $m$-plane. An approximate tangent
plane at $a$ is a subspace $V$ such that $E$ has positive upper $m$-density at $a$ and the part of
$E$ near $a$ lying outside every cone around $V$ is negligible at small scales.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The hypotheses: $E$ is $\mathcal{H}^m$ measurable and $\mathcal{H}^m(E) < \infty$. | ✅ `hEmeas : MeasurableSet E`, `hEfinite : μH[(m : ℝ)] E < ∞`. ⚠️ The book means Carathéodory $\mathcal{H}^m$-measurable, i.e. `NullMeasurableSet E μH[(m:ℝ)]`; Borel `MeasurableSet` is stronger, so our version is a slightly narrower theorem. |
| 2 | All four conditions are asserted equivalent, as one equivalence rather than a chain of implications. | ✅ `List.TFAE [ … ]` with four entries. |
| 3 | Rectifiability (15.3): countably many Lipschitz maps $\mathbb{R}^m \to \mathbb{R}^n$, **each with its own** Lipschitz constant, whose ranges cover $E$ up to an $\mathcal{H}^m$-null set. | ✅ `RectifiableSet n m E = ∃ f : ℕ → …, (∀ j, ∃ K : ℝ≥0, LipschitzWith K (f j)) ∧ μH[(m:ℝ)] (E \ ⋃ j, range (f j)) = 0`. |
| 4 | Linear approximability (15.7): for almost every $a \in E$ and **every** $\eta > 0$ there are a plane, a scale $r_0$ and a constant $c$ — all allowed to depend on $\eta$ — such that both displayed inequalities hold for all $0 < r < r_0$. | ✅ `LinearlyApproximableSet`: `∀ᵐ a ∂μH[(m:ℝ)].restrict E, ∀ η, 0 < η → ∃ V, ∃ r₀ c, 0 < r₀ ∧ 0 < c ∧ ∀ r, 0 < r → r < r₀ → …`. |
| 5 | The first inequality of 15.7: $\mathcal{H}^m(E \cap B(x,\eta r)) \ge c\,r^m$ for every $x$ in the plane through $a$ within distance $r$ of $a$. | ✅ `∀ x, x - a ∈ V.1 → x ∈ closedBall a r → ENNReal.ofReal (c * r ^ m) ≤ μH[(m:ℝ)] (E ∩ closedBall x (η * r))`. |
| 6 | The second inequality of 15.7: the part of $E$ near $a$ that lies at distance at least $\eta r$ from the plane has measure less than $\eta r^m$. | ✅ `μH[(m:ℝ)] (E ∩ closedBall a r ∩ {x \| η * r ≤ infDist (x - a) V.1}) < ENNReal.ofReal (η * r ^ m)`. |
| 7 | An approximate tangent plane (15.17) requires **both** positive upper $m$-density at $a$ **and** the vanishing cone-complement density for every $0 < s < 1$. | ✅ `IsApproximateTangentPlane E a V = 0 < upperHausdorffDensity (m:ℝ) E a ∧ ∀ s, 0 < s → s < 1 → Tendsto (fun r ↦ μH[(m:ℝ)] (E ∩ closedBall a r ∩ {x \| s * dist x a ≤ infDist (x - a) V.1}) / ENNReal.ofReal (r ^ (m:ℝ))) (𝓝[>] 0) (𝓝 0)`. |
| 8 | Items (3) and (4) must stay distinct: uniqueness of the tangent plane versus mere existence. | ✅ `∃! V : Grassmannian n m, …` in item 3 and `∃ V : Grassmannian n m, …` in item 4. |
| 9 | "For $\mathcal{H}^m$ almost all $a \in E$" in items (2), (3), (4) must restrict the measure to $E$. | ✅ `∀ᵐ a ∂μH[(m:ℝ)].restrict E` in all three places; this reading is correct precisely because `hEmeas` is assumed. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Dropping item (3), or writing `∃` in both items (3) and (4). | Almost-everywhere *uniqueness* of the tangent plane is a substantive part of 15.19; collapsing the two items loses it. |
| 2 | Requiring a single Lipschitz constant for the whole family of maps. | Definition 15.3 allows each $f_i$ its own constant. A common constant is a strictly stronger requirement, so the rectifiability condition would be the wrong one. |
| 3 | Requiring literal containment $E \subseteq \bigcup_i f_i(\mathbb{R}^m)$. | The definition only asks for containment up to an $\mathcal{H}^m$-null set. Exact containment is strictly stronger and would break the equivalence. |
| 4 | Dropping the positive-upper-density conjunct from the tangent plane definition. | Without it, at any point where $E$ is thin every subspace satisfies the cone condition, so "there is a tangent plane" would become almost vacuous and item (4) would no longer characterize rectifiability. |
| 5 | Using `μH[(m:ℝ)].restrict E` while not assuming $E$ measurable. | `Measure.restrict` only computes as `μ (S ∩ E)` for measurable `E`; without that hypothesis the a.e. statements are not the intended ones. (Compare `mattila_6_2`, where the guarded form `∀ᵐ x ∂μH[s], x ∈ A → …` is used for exactly this reason.) |
| 6 | Letting the plane, $r_0$ and $c$ in 15.7 be chosen before $\eta$. | The definition allows all three to depend on $\eta$; hoisting them out changes the condition into a stronger one. |
| 7 | Replacing the equivalence by a chain of implications, or listing only some of the four items. | The theorem asserts all four are equivalent. |
| 8 | Dropping $\mathcal{H}^m(E) < \infty$. | For sets of infinite measure the four conditions come apart, so the equivalence fails. |

## Notes on the ground truth

- The Grassmannian appears here only pointwise, through `∃ V` and `∃! V`. No measure on $G(n,m)$ is
  involved, so the measurable-structure issue that affects `mattila_9_7`, `mattila_10_10` and
  `mattila_18_1` does not arise. `Grassmannian n m` is a subtype of
  `Submodule ℝ (EuclideanSpace ℝ (Fin n))`, so `∃!` really is uniqueness of the subspace.
- An affine $m$-plane through $a$ is rendered by a linear subspace `V` together with the membership
  test `x - a ∈ V.1`. The cone complement $\mathbb{R}^n \setminus X(a,V,s)$ is
  `{x | s * dist x a ≤ infDist (x - a) V.1}`, exactly the complement of
  $\{x : d(x-a, V) < s\lvert x - a\rvert\}$.
- The two normalizations differ on purpose and match the book: `upperHausdorffDensity` divides by
  $(2r)^m$, while the cone condition in 15.17 divides by $r^m$.
- ⚠️ The slab complement in 15.7 uses `η * r ≤ infDist …`, i.e. the complement of the *open*
  $\eta r$-neighbourhood of the plane. Reading the book's $W(\eta r)$ as closed would give a strict
  `<` there instead. This does not affect the equivalence, since $\eta$ is universally quantified,
  but it is not literal.
- ⚠️ `MeasurableSet E` rather than `NullMeasurableSet E μH[(m:ℝ)]`; note the tension with the
  `.restrict E` encoding — a fully literal version would have to switch to guarded a.e. statements
  as well.
- All quotients are `ℝ≥0∞`-valued with denominators `ENNReal.ofReal (r ^ (m:ℝ))`, which are positive
  and finite for `r > 0`, and all limits are along `𝓝[>] 0`, so the junk values of `Real.rpow` at
  nonpositive base are never seen.
