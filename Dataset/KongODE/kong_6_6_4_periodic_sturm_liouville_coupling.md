# Q. Kong, *A Short Course in Ordinary Differential Equations*, Theorem 6.6.4

- **Source:** Q. Kong, *A Short Course in Ordinary Differential Equations*
- **Domain:** ODE
- **Lean declaration:** `Dataset.KongODE.kong_6_6_4_periodic_sturm_liouville_coupling` ([kong_6_6_4_periodic_sturm_liouville_coupling.lean](kong_6_6_4_periodic_sturm_liouville_coupling.lean))
- **Criteria:** [kong_6_6_4_periodic_sturm_liouville_coupling.criteria.md](kong_6_6_4_periodic_sturm_liouville_coupling.criteria.md)

## Statement

**Theorem 6.6.4.** SLP (S-L), (P) has a countably infinite number of eigenvalues $\lambda_n$, $n \in \mathbb{N}_0$, which are all real, bounded below and unbounded above, and can be arranged to satisfy the coupling relations with $\mu_n$ and $\nu_n$ for $n \in \mathbb{N}_0$:

$$\nu_0 \le \lambda_0 < \{\mu_0, \nu_1\} < \lambda_1 \le \{\mu_1, \nu_2\} \le \lambda_2 < \{\mu_2, \nu_3\} < \lambda_3 \le \{\mu_3, \nu_4\} \le \lambda_4 < \cdots$$
$$\cdots < \{\mu_{2n}, \nu_{2n+1}\} < \lambda_{2n+1} \le \{\mu_{2n+1}, \nu_{2n+2}\} \le \lambda_{2n+2} < \cdots .$$

Furthermore,

**(a)** $\lambda_0$ is geometrically simple; and for $n \ge 1$, $\lambda_n$ may be geometrically simple or double, and $\lambda_n$ is geometrically double $\iff$ $\lambda_n = \mu_i = \nu_j$ for some $i, j \in \mathbb{N}_0$.

**(b)** The eigenfunctions associated with $\lambda_0$ have no zeros in $[a,b]$, and for $n \in \mathbb{N}_0$, the eigenfunctions associated with $\lambda_{2n+1}$ and $\lambda_{2n+2}$ have exactly $2n+2$ zeros in the half-open interval $[a,b)$.

**Equation (S-L).** The regular Sturm–Liouville equation on $[a,b]$, $a < b$,

$$\big(p(x) y'\big)' = \big(q(x) - \lambda w(x)\big) y, \qquad x \in [a,b],$$

with $p, q, w$ continuous on $[a,b]$ and $p(x) > 0$, $w(x) > 0$ there.

**Boundary conditions (P).** The periodic boundary conditions

$$y(a) = y(b), \qquad p(a) y'(a) = p(b) y'(b).$$

**The coupled spectra $\mu_n$ and $\nu_n$.** $\{\mu_n\}_{n \in \mathbb{N}_0}$ are the eigenvalues of the Dirichlet problem for (S-L), i.e. with $y(a) = y(b) = 0$, and $\{\nu_n\}_{n \in \mathbb{N}_0}$ are the eigenvalues of the Neumann problem, i.e. with $y'(a) = y'(b) = 0$. The notation $\{\mu_i, \nu_j\}$ in a chain of inequalities means that the stated relation holds for each of $\mu_i$ and $\nu_j$ separately, no order being asserted between $\mu_i$ and $\nu_j$. An eigenvalue is *geometrically simple* (resp. *double*) when its eigenspace is one- (resp. two-) dimensional.
