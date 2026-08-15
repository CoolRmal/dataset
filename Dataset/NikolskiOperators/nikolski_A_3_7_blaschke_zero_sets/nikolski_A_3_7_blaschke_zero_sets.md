# N. K. Nikolski, *Operators, Functions, and Systems: An Easy Reading*, Lemma 3.7.1 (Blaschke condition, interior uniqueness theorem)

- **Source:** N. K. Nikolski, *Operators, Functions, and Systems: An Easy Reading*, Volume 1: Hardy, Hankel, and Toeplitz (Part A)
- **Domain:** Hardy spaces
- **Lean declaration:** `Dataset.NikolskiOperators.nikolski_A_3_7_blaschke_zero_sets` ([nikolski_A_3_7_blaschke_zero_sets.lean](nikolski_A_3_7_blaschke_zero_sets.lean))
- **Criteria:** [nikolski_A_3_7_blaschke_zero_sets.criteria.md](nikolski_A_3_7_blaschke_zero_sets.criteria.md)
- **Context:** [nikolski_A_3_7_blaschke_zero_sets.context.md](nikolski_A_3_7_blaschke_zero_sets.context.md)

## Statement

**3.7.1. Lemma (Blaschke condition, interior uniqueness theorem).** Suppose $f \in \operatorname{Hol}(\mathbb{D})$, $f \ne 0$, and let $(\lambda_n)_{n \ge 1}$ be the zero sequence of $f$ in $\mathbb{D}$, each zero being repeated according to its multiplicity. Suppose that

$$\lim_{r \to 1} \int_{\mathbb{T}} \log|f_r| \, dm < \infty,$$

then $\sum_{n \ge 1} (1 - |\lambda_n|) < \infty$. In particular, this holds whenever $f \in H^p(\mathbb{D})$, $p > 0$.

**3.7.3. Lemma (Blaschke Product).** If $(\lambda_n)_{n \ge 1}$ is a sequence in $\mathbb{D}$ satisfying the Blaschke condition $\sum_{n \ge 1} (1 - |\lambda_n|) < \infty$, then the infinite product

$$B = \prod_{n \ge 1} b_{\lambda_n}$$

converges uniformly on compact subsets of $\mathbb{D}$ (and even on compact subsets of $\mathbb{C} \setminus \operatorname{clos}\{1/\lambda_n\}_{n \ge 1}$). Moreover $|B| \le 1$ in $\mathbb{D}$, $|B| = 1$ a.e. on $\mathbb{T}$, and the zeros of $B$ are exactly $(\lambda_n)_{n \ge 1}$ (counting multiplicities).

**3.7.2. Remark.** The condition $\sum_{n \ge 1} (1 - |\lambda_n|) < \infty$ is called the *Blaschke condition*.
