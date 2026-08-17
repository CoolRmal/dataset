# Criteria: kallenberg_5_25_portmanteau

**Statement:** [kallenberg_5_25_portmanteau.md](kallenberg_5_25_portmanteau.md) · **Lean:** [kallenberg_5_25_portmanteau.lean](kallenberg_5_25_portmanteau.lean) · **Context:** [kallenberg_5_25_portmanteau.context.md](kallenberg_5_25_portmanteau.context.md)

## What the theorem says

Let $\xi, \xi_1, \xi_2, \dots$ be random elements of a metric space $S$. The portmanteau theorem
says that four conditions are equivalent: convergence in distribution of $\xi_n$ to $\xi$; for every
open set $G$, that $\liminf_n P\{\xi_n \in G\}$ is at least $P\{\xi \in G\}$; for every closed set
$F$, that $\limsup_n P\{\xi_n \in F\}$ is at most $P\{\xi \in F\}$; and, for every measurable set $B$
whose boundary carries no mass under the law of $\xi$, that $P\{\xi_n \in B\}$ converges to
$P\{\xi \in B\}$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $S$ is a metric space with its Borel measurable structure, and all measures involved are probability measures. | ✅ `[MetricSpace S] [MeasurableSpace S] [BorelSpace S]`, `[IsProbabilityMeasure μ] [IsProbabilityMeasure μ']`. |
| 2 | The random elements are measurable maps into $S$. | ✅ `hξn : ∀ n, AEMeasurable (ξn n) μ` and `hξ : AEMeasurable ξ μ'`, stated as standalone hypotheses. |
| 3 | Condition (i) is weak convergence of the laws. | ✅ `TendstoInDistribution ξn atTop ξ (fun _ ↦ μ) μ'`, which is `Tendsto` of the pushforward laws inside `ProbabilityMeasure S`, the space carrying the weak topology. |
| 4 | Condition (ii): for every open $G$, the limit inferior of $P\{\xi_n \in G\}$ is at least $P\{\xi \in G\}$. | ✅ `∀ G : Set S, IsOpen G → (μ'.map ξ) G ≤ liminf (fun n ↦ (μ.map (ξn n)) G) atTop`. |
| 5 | Condition (iii): for every closed $F$, the limit superior of $P\{\xi_n \in F\}$ is at most $P\{\xi \in F\}$. | ✅ `∀ F : Set S, IsClosed F → limsup (fun n ↦ (μ.map (ξn n)) F) atTop ≤ (μ'.map ξ) F`. |
| 6 | Condition (iv) applies to measurable sets $B$ whose *boundary in $S$* is null for the law of $\xi$, and asserts full convergence of the probabilities. | ✅ `∀ B : Set S, MeasurableSet B → (μ'.map ξ) (frontier B) = 0 → Tendsto (fun n ↦ (μ.map (ξn n)) B) atTop (𝓝 ((μ'.map ξ) B))`. |
| 7 | All four conditions are asserted equivalent in one statement, in the order printed. | ✅ `List.TFAE [lawsConverge, openLowerBound, closedUpperBound, continuitySets]`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Pairing open sets with `limsup ≤` and closed sets with `liminf ≥`. | The directions are swapped and the resulting statement is false. Take $\xi_n$ a point mass at $1/n$ and $\xi$ a point mass at $0$, with $G = (0, \infty)$: $P\{\xi_n \in G\} = 1$ for every $n$ while $P\{\xi \in G\} = 0$. |
| 2 | Taking the boundary of the preimage, `μ' (frontier (ξ ⁻¹' B))`, instead of the boundary of $B$ in $S$ — i.e. instead of `(μ'.map ξ) (frontier B)`. | The sample space has no topology, so the boundary of a subset of it is not defined. The condition is about the boundary of $B$ inside $S$, pulled back through $\xi$. |
| 3 | Dropping `MeasurableSet B` in condition (iv). | The text's class of $\xi$-continuity sets is a subclass of the Borel sets. Without measurability the two sides are outer measures rather than probabilities, condition (iv) is no longer implied by (i), and the equivalence breaks. |
| 4 | Stating (i) as `Tendsto (fun n ↦ μ.map (ξn n)) atTop (𝓝 (μ'.map ξ))` inside `Measure S`. | The topology on `Measure S` is not the topology of weak convergence, so this is a different — and generally false — assertion. |
| 5 | Replacing (i) by almost-sure convergence or convergence in measure. | Both are strictly stronger than convergence in distribution, so the implications from (ii)–(iv) back to (i) fail. They are also inexpressible when the $\xi_n$ and $\xi$ live on different spaces. |
| 6 | Formalizing only a chain of implications, or only `(i) ↔ (iv)`. | The theorem asserts all four conditions equivalent; a partial chain loses content. |
| 7 | Leaving out the measurability hypotheses and relying on those bundled inside `TendstoInDistribution`. | Conditions (ii)–(iv) on their own do not give measurability of the maps, so the implications back to (i) would not be provable and the equivalence would be false. |

## Notes on the ground truth

- The probabilities are `ℝ≥0∞`-valued throughout, so `liminf` and `limsup` always exist and no
  conversion to real numbers can truncate at $\infty$. Using `μ.real` or `ENNReal.toReal` would work
  here but would need `IsProbabilityMeasure` to be sound.
- The four conditions are stated about the *laws* `μ.map (ξn n)` and `μ'.map ξ`, which is what weak
  convergence concerns and what `AEMeasurable` is exactly enough to define.
- The limit lives on its own probability space, so the random elements are not forced onto a common
  one — which is Kallenberg's setting.
- The text writes (ii) as `liminf ≥`; the Lean writes the same inequality with the sides exchanged.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[kallenberg_5_25_portmanteau.md](kallenberg_5_25_portmanteau.md) and the background in [kallenberg_5_25_portmanteau.context.md](kallenberg_5_25_portmanteau.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 7 rows, so each row is worth 7.1 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirements 4–5 with the $\liminf$/$\limsup$ or the inequality directions swapped.
- Requirement 6 with condition (iv) asserted for all Borel sets rather than for $\xi$-continuity sets.
- Requirement 7 with the four conditions strung as implications rather than a single equivalence.

### Domain-specific pitfalls for this problem

- Open sets pair with $\liminf \ge$, closed sets with $\limsup \le$; the asymmetry is the substance.
- The boundary in condition (iv) is taken in the ambient space $S$, and the null condition is for the law of the limit $\xi$.
- Convergence in distribution is about laws; the random elements need not share a probability space.
- The measures of preimages live in `ℝ≥0∞`, where `liminf`/`limsup` are always defined — no boundedness side condition is needed.
