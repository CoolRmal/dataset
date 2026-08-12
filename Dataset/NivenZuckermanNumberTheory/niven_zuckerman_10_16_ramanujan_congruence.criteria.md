# Criteria: niven_zuckerman_10_16_ramanujan_congruence

**Statement:** [niven_zuckerman_10_16_ramanujan_congruence.md](niven_zuckerman_10_16_ramanujan_congruence.md) · **Lean:** [niven_zuckerman_10_16_ramanujan_congruence.lean](niven_zuckerman_10_16_ramanujan_congruence.lean)

One of the cleanest statements in the book and a genuinely deep one: $p(5m+4) \equiv 0 \pmod 5$ for **every** $m \ge 0$. The only encoding question is what `p(n)` is — the number of partitions of `n`, which mathlib provides as the cardinality of `Nat.Partition n`.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Faithful encoding | `p(n)` is the number of partitions of `n`, i.e. `Nat.card (Nat.Partition n)`; it is not the number of *distinct-part* partitions and not `Nat.factorization`. | ✅ `partitionCount n = Nat.card (Nat.Partition n)`. ❗ Predicted error: using a partition-counting function restricted to distinct parts. |
| 2 | Conclusion completeness | The congruence holds for every `m : ℕ`, including `m = 0` (`p(4) = 5`). | ✅ `∀ m : ℕ` with no side condition. ❗ Predicted error: `1 ≤ m`. |
| 3 | Mathlib conventions | `≡ 0 (mod 5)` on naturals is `n % 5 = 0`; `Nat.ModEq` would also be acceptable. | ✅ `partitionCount (5 * m + 4) % 5 = 0`. |
| 4 | Faithful encoding | The arithmetic progression is `5m + 4`, not `5m` or `5m + 1`; the congruence is false for those. | ✅ As written. ❗ Predicted error: an off-by-one in the residue. |
| 5 | Junk values | `Nat.card` of an infinite type is `0`; `Nat.Partition n` is a finite type for every `n`, so the count is genuine. | ⚠️ Relies on mathlib's `Fintype (Nat.Partition n)` instance. |
