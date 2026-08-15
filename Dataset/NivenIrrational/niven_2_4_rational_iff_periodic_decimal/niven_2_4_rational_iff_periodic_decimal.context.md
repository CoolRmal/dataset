# Context: niven_2_4_rational_iff_periodic_decimal

**Statement:** [niven_2_4_rational_iff_periodic_decimal.md](niven_2_4_rational_iff_periodic_decimal.md) · **Criteria:** [niven_2_4_rational_iff_periodic_decimal.criteria.md](niven_2_4_rational_iff_periodic_decimal.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Decimal expansions and eventual periodicity

**The digit sequence.** For $x \in [0,1)$ the $k$-th digit after the point is
$d_k = \lfloor 10^{k+1}x\rfloor \bmod 10$. This formula is the definition in play; it gives the digits of
the standard expansion and, for the ambiguous numbers, the terminating one.

**"Terminating or infinite periodic" is exactly "eventually periodic".** A terminating expansion is the
eventually periodic one whose repeating block is the single digit $0$, so the two cases of the proposition
collapse into one condition: there are $N$ and $p > 0$ with $d_{k+p} = d_k$ for all $k \ge N$. The period
must be **strictly positive**, and the repetition is required only from some index on, not from the start.

**Both directions are asserted**: rational $\Rightarrow$ eventually periodic, and eventually periodic
$\Rightarrow$ rational.

**The range $[0,1)$** is where the digit formula above describes the expansion; for a general real one
first splits off the integer part.
