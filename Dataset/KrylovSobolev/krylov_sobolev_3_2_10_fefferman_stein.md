# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*, Theorem 3.2.10 (the Fefferman–Stein theorem)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*
- **Domain:** Real analysis
- **Lean declaration:** `Dataset.KrylovSobolev.krylov_sobolev_3_2_10_fefferman_stein` ([krylov_sobolev_3_2_10_fefferman_stein.lean](krylov_sobolev_3_2_10_fefferman_stein.lean))
- **Criteria:** [krylov_sobolev_3_2_10_fefferman_stein.criteria.md](krylov_sobolev_3_2_10_fefferman_stein.criteria.md)

## Statement

**Theorem 3.2.10 (Fefferman–Stein).** Let $p \in (1,\infty)$. Then for any $f \in \mathcal{L}_p(\Omega)$ we have

$$\|f\|_{\mathcal{L}_p(\Omega)} \le N \|f^{\#}\|_{\mathcal{L}_p(\Omega)},$$

where $N = (2q)^p N_0^{p-1}$, $q = p/(p-1)$.

**Notation.** Throughout Chapter 3, $(\Omega,\mathcal{F},\mu)$ is a complete measure space with a $\sigma$-finite measure $\mu$ such that $\mu(\Omega) = \infty$. We write $|A| = \mu(A)$, and $\mathcal{F}^0$ is the set of $A \in \mathcal{F}$ with $\mu(A) < \infty$. For $A \in \mathcal{F}^0$ and $f$ summable on $A$,

$$f_A = \fint_A f\,\mu(dx) := \frac{1}{|A|}\int_A f(x)\,\mu(dx) \qquad \Big(\frac{0}{0} := 0\Big).$$

**Definition 3.1.1.** Let $(\mathbb{C}_n, n \in \mathbb{Z})$ be a sequence of partitions of $\Omega$, each consisting of countably many disjoint sets $C \in \mathbb{C}_n$ with $\mathbb{C}_n \subset \mathcal{F}^0$; for each $x \in \Omega$ and $n \in \mathbb{Z}$ there is a unique $C \in \mathbb{C}_n$ with $x \in C$, denoted $C_n(x)$. We call $(\mathbb{C}_n, n \in \mathbb{Z})$ *a filtration of partitions* if:

(i) $\inf_{C \in \mathbb{C}_n} |C| \to \infty$ as $n \to -\infty$, and $\lim_{n\to\infty} f_{C_n(x)} = f(x)$ (a.e.) for all $f \in \mathbb{L}$, where $\mathbb{L}$ is a fixed dense subset of $\mathcal{L}_1(\Omega)$;

(ii) the partitions are nested: for each $n$ and $C \in \mathbb{C}_n$ there is a (unique) $C' \in \mathbb{C}_{n-1}$ such that $C \subset C'$;

(iii) the regularity property holds: for any $n$, $C$, and $C'$ as in (ii) we have $|C'| \le N_0 |C|$, where $N_0$ is a constant independent of $n, C, C'$.

**Definition 3.1.4 (ii).** For $f \in \mathcal{L}_{1,\mathrm{loc}}(\Omega)$ and $n \in \mathbb{Z}$ we denote $f_{|n}(x) = \fint_{C_n(x)} f(y)\,\mu(dy)$.

**Definitions of the maximal and sharp functions.** $\mathcal{M}f(x) = \sup_{n < \infty} |f|_{|n}(x)$ and

$$f^{\#}(x) = \sup_{n<\infty} \fint_{C_n(x)} |f(y) - f_{|n}(y)|\,\mu(dy).$$
