# Criteria: nikolski_B_3_2_nevanlinna_pick_interpolation

**Statement:** [nikolski_B_3_2_nevanlinna_pick_interpolation.md](nikolski_B_3_2_nevanlinna_pick_interpolation.md) · **Lean:** [nikolski_B_3_2_nevanlinna_pick_interpolation.lean](nikolski_B_3_2_nevanlinna_pick_interpolation.lean) · **Context:** [nikolski_B_3_2_nevanlinna_pick_interpolation.context.md](nikolski_B_3_2_nevanlinna_pick_interpolation.context.md)

## What the theorem says

Given finitely many distinct points $\lambda_1,\dots,\lambda_n$ of the open unit disc and target
values $w_1,\dots,w_n$, Pick's theorem decides when there is an analytic function $f$ on the disc
with $\lvert f\rvert \le 1$ and $f(\lambda_k) = w_k$ for every $k$. Such an $f$ exists exactly when
the Pick matrix with entries $\frac{1 - w_i\bar w_j}{1 - \lambda_i\bar\lambda_j}$ is positive
semidefinite. When a solution exists, it is unique exactly when that matrix is singular.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The interpolation nodes lie in the open unit disc. | ✅ `hz : ∀ i : Fin n, z i ∈ Metric.ball (0 : ℂ) 1`. |
| 2 | The nodes are pairwise distinct. | ✅ `hz_injective : Function.Injective z`. |
| 3 | The competitors are Schur functions: analytic on the disc with modulus at most $1$ there. | ✅ `SchurFunction f` = `HardyClass ⊤ f ∧ ∀ z ∈ Metric.ball (0 : ℂ) 1, ‖f z‖ ≤ 1`. |
| 4 | The interpolation conditions hold at every node. | ✅ `∀ i : Fin n, f (z i) = w i`, inside the definition of `solutions`. |
| 5 | Solvability is equivalent to positive semidefiniteness of the Pick matrix. | ✅ `solutions.Nonempty ↔ PositiveSemidefiniteMatrix (PickMatrix z w)`. |
| 6 | The Pick matrix has entries $\frac{1 - w_i\bar w_j}{1 - \lambda_i\bar\lambda_j}$, with the conjugate on the second index. | ✅ `PickMatrix z w i j = (1 - w i * star (w j)) / (1 - z i * star (z j))`. |
| 7 | Positive semidefiniteness is the Hermitian quadratic form condition $\sum_{i,j}\bar c_i A_{ij} c_j \ge 0$ for every coefficient vector. | ✅ `PositiveSemidefiniteMatrix A = ∀ c, 0 ≤ Complex.re (∑ i, ∑ j, star (c i) * A i j * c j)`. |
| 8 | The uniqueness half is conditioned on solvability. | ✅ `solutions.Nonempty → (… ↔ …)`. |
| 9 | Uniqueness means that any two solutions agree **on the disc**. | ✅ `∀ f ∈ solutions, ∀ g ∈ solutions, Set.EqOn f g (Metric.ball (0 : ℂ) 1)`. |
| 10 | Degeneracy of the Pick matrix is singularity. | ✅ `Matrix.det (PickMatrix z w) = 0`; `Matrix.rank < n` would be equally faithful. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Stating uniqueness as `solutions.Subsingleton`, or as `∃!`. | The competitors are total functions `ℂ → ℂ`, and every condition on them constrains only the restriction to the disc. So whenever there is one solution there are infinitely many, and the clause is unsatisfiable. Take $n = 1$, $\lambda_1 = 0$, $w_1 = 1$: the constant $1$ solves the problem, the Pick matrix is $[0]$ with determinant $0$, and yet the solution set is not a subsingleton — the equivalence would be false. |
| 2 | Dropping the assumption that the nodes are distinct. | The uniqueness half goes false. Take $n = 2$, both nodes $0$, both targets $0$: the Pick matrix is all ones, so it is positive semidefinite with determinant $0$, but $f = 0$ and $f(z) = z$ are two solutions that differ on the disc. |
| 3 | Reading $\lVert f\rVert_\infty \le 1$ as an essential bound on boundary values. | That requires boundary values to exist before they have been produced. The direct reading is the pointwise bound on the open disc. |
| 4 | Omitting a conjugate, or conjugating the first index instead of the second, in the Pick entries. | The resulting matrix is not Hermitian and the positivity condition is a different one. |
| 5 | Stating the uniqueness half without conditioning on solvability. | With no solutions, "the solution is unique" is meaningless, and the Pick matrix need not be singular, so the unconditioned biconditional is false. |
| 6 | Encoding degeneracy as "not positive definite" without carrying the standing semidefiniteness. | For a general matrix that is not the same as singularity; the equivalence is only available under the positive semidefiniteness already established. |
| 7 | Allowing nodes on or outside the unit circle. | The denominator $1 - \lambda_i\bar\lambda_j$ vanishes or changes sign, so the Pick kernel is not defined and the criterion breaks. |

## Notes on the ground truth

- Interpolants are total functions `ℂ → ℂ`, so uniqueness can only be uniqueness on the disc, and
  `Set.EqOn f g (Metric.ball (0 : ℂ) 1)` is exactly that reading. An earlier version of this file
  used `solutions.Subsingleton` and was false for that reason; Mistake 1 records the defect. The
  distinctness hypothesis `hz_injective` was also added later; Mistake 2 records its absence.
- `PositiveSemidefiniteMatrix` asks only for nonnegativity of the quadratic form and omits the
  Hermitian conjunct that mathlib's `Matrix.PosSemidef` carries. Harmless here, since the Pick
  matrix is Hermitian by construction, but `Matrix.PosSemidef` would be the idiomatic and safer
  statement.
- The text writes the condition as $\sum_{i,j} a_i\bar a_j \frac{1 - w_i\bar w_j}{1 - \lambda_i
  \bar\lambda_j} \ge 0$, which is the transposed convention. For a Hermitian matrix the two
  conventions define the same condition.
- The denominators never vanish, because `hz` places every node in the open disc.
- The `Fin n` indexing matches "$k = 1,\dots,n$" and allows $n = 0$: the data is empty, the Pick
  matrix is the empty matrix with determinant $1$, and both halves come out correctly.
- Inside `SchurFunction`, the `HardyClass ⊤` conjunct is redundant given the pointwise bound,
  except for the analyticity it carries, which is essential.
- No hypothesis is placed on the targets $w_k$, and none is needed: $\lvert w_k\rvert \le 1$ follows
  from solvability and is already encoded in the Pick condition.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[nikolski_B_3_2_nevanlinna_pick_interpolation.md](nikolski_B_3_2_nevanlinna_pick_interpolation.md) and the background in [nikolski_B_3_2_nevanlinna_pick_interpolation.context.md](nikolski_B_3_2_nevanlinna_pick_interpolation.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 10 rows, so each row is worth 5.0 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 2 with the nodes not required distinct.
- Requirement 8 with the uniqueness clause asserted unconditionally rather than under solvability.
- Requirement 9 with uniqueness compared outside the disc.

### Domain-specific pitfalls for this problem

- The competitors are Schur functions: analytic on the disc with modulus $\le 1$ **there**, not merely bounded.
- The Pick matrix's denominators are nonzero because the nodes are inside the disc; a node on the circle would make them junk.
- Positive semidefiniteness is the Hermitian quadratic form condition, with conjugates in the right places.
- Degeneracy means singularity of $I - WW^*$, i.e. rank $< n$.
- Uniqueness is equality of functions restricted to the disc.
