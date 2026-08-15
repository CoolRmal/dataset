# Context: kallenberg_5_27_continuous_mapping

**Statement:** [kallenberg_5_27_continuous_mapping.md](kallenberg_5_27_continuous_mapping.md) · **Criteria:** [kallenberg_5_27_continuous_mapping.criteria.md](kallenberg_5_27_continuous_mapping.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The linking condition and the "in particular" corollary

**The linking condition** is the hypothesis $s_n \to s \in C \Rightarrow f_n(s_n) \to f(s)$: whenever a
sequence converges to a point **of $C$**, the values of the corresponding $f_n$ converge to the value of
the limit map $f$ there. It links a whole *sequence* of maps to a limit map; the classical statement, with
a single continuous $f$, is the special case $f_n = f$.

**The maps are only assumed measurable.** No continuity is assumed of $f$ or of any $f_n$ — continuity
appears only through the linking condition, and only along sequences converging into $C$.

**$C$ is an arbitrary subset**, not assumed measurable; the hypothesis "$\xi \in C$ a.s." is a statement
about outer measure if $C$ is not measurable.

**The conclusion** is $f_n(\xi_n) \to f(\xi)$ in distribution. The "in particular" clause is the classical
continuous mapping theorem: if $g$ is measurable and a.s. continuous at $\xi$ — i.e. the set of continuity
points of $g$ has full probability under the law of $\xi$ — then $\xi_n \to \xi$ implies
$g(\xi_n) \to g(\xi)$ in distribution. It is a separate assertion.
