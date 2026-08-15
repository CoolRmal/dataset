# Context: niven_6_2_unique_nearest_integer

**Statement:** [niven_6_2_unique_nearest_integer.md](niven_6_2_unique_nearest_integer.md) · **Criteria:** [niven_6_2_unique_nearest_integer.criteria.md](niven_6_2_unique_nearest_integer.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The nearest integer to an irrational number

**What the theorem asserts.** For an irrational $\alpha$ there is **exactly one** integer $m$ with
$-\frac12 < \alpha - m < \frac12$: existence and uniqueness together.

**Why irrationality is assumed.** It rules out the tie $\alpha = n + \frac12$, the one case in which two
integers are equally close and the open interval of length $1$ would contain neither or both endpoints
symmetrically. In fact any non-half-integer would do, so the hypothesis is stronger than necessary — but it
is the book's, and the strict inequalities are what make it needed at all.

**Both bounds are strict**, the interval is symmetric about $0$, and the quantity bounded is
$\alpha - m$ in that order.

**$m$ is an integer**, not a natural number, so negative $\alpha$ is covered.
