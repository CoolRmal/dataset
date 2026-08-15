# I. Niven, *Numbers: Rational and Irrational*, §2.4–2.5 (rational numbers and periodic decimals)

- **Source:** I. Niven, *Numbers: Rational and Irrational*
- **Domain:** Number theory
- **Lean declaration:** `Dataset.NivenIrrational.niven_2_4_rational_iff_periodic_decimal` ([niven_2_4_rational_iff_periodic_decimal.lean](niven_2_4_rational_iff_periodic_decimal.lean))
- **Criteria:** [niven_2_4_rational_iff_periodic_decimal.criteria.md](niven_2_4_rational_iff_periodic_decimal.criteria.md)
- **Context:** [niven_2_4_rational_iff_periodic_decimal.context.md](niven_2_4_rational_iff_periodic_decimal.context.md)

## Statement

**Proposition (§2.4).** Any rational fraction $a/b$ is expressible as a terminating decimal or an infinite periodic decimal; conversely, any decimal expansion which is either terminating or infinite periodic is equal to some rational number.

**Notation.** The decimal expansion of $x \in [0,1)$ is the digit sequence $d_k = \lfloor 10^{k+1}x\rfloor \bmod 10$. A terminating expansion is the eventually periodic one whose repeating digit is $0$, so "terminating or infinite periodic" is exactly "eventually periodic" (§2.5, *Terminating Decimals Written as Periodic Decimals*).
