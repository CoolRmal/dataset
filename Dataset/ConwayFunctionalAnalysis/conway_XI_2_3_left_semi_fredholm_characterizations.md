# J. B. Conway, *A Course in Functional Analysis*, Theorem XI.2.3 (characterizations of left semi-Fredholm operators)

- **Source:** J. B. Conway, *A Course in Functional Analysis*
- **Domain:** Fredholm theory
- **Lean declaration:** `Dataset.ConwayFunctionalAnalysis.conway_XI_2_3_left_semi_fredholm_characterizations` ([conway_XI_2_3_left_semi_fredholm_characterizations.lean](conway_XI_2_3_left_semi_fredholm_characterizations.lean))
- **Criteria:** [conway_XI_2_3_left_semi_fredholm_characterizations.criteria.md](conway_XI_2_3_left_semi_fredholm_characterizations.criteria.md)
- **Context:** [conway_XI_2_3_left_semi_fredholm_characterizations.context.md](conway_XI_2_3_left_semi_fredholm_characterizations.context.md)

## Statement

**Definition.** A bounded operator $A : \mathcal{H} \to \mathcal{H}'$ is *left semi-Fredholm* if it is left invertible modulo the compact operators: there are bounded $B : \mathcal{H}' \to \mathcal{H}$ and compact $C : \mathcal{H} \to \mathcal{H}$ such that $BA = 1 + C$.

**XI.2.3. Theorem.** If $A : \mathcal{H} \to \mathcal{H}'$ is a bounded operator, the following statements are equivalent.

- **(a)** $A$ is left semi-Fredholm.
- **(b)** $\operatorname{ran} A$ is closed and $\dim \ker A < \infty$.
- **(c)** There is a bounded operator $B : \mathcal{H}' \to \mathcal{H}$ and a finite rank operator $F$ on $\mathcal{H}$ such that $BA = 1 + F$.
- **(d)** There is no sequence $\{h_n\}$ of unit vectors in $\mathcal{H}$ such that $h_n \to 0$ weakly and $\lim \|A h_n\| = 0$.
- **(e)** There is no orthonormal sequence $\{e_n\}$ in $\mathcal{H}$ such that $\lim \|A e_n\| = 0$.
- **(f)** There is a $\delta > 0$ such that $\{ h \in \mathcal{H} : \|Ah\| \le \delta \|h\| \}$ contains no infinite dimensional manifold.
- **(g)** If the positive operator $(A^*A)^{1/2} = \int_0^\infty t \, dE(t)$, then there is a $\delta > 0$ such that $E[0, \delta] \mathcal{H}$ is finite dimensional.
- **(h)** If $K \in \mathcal{B}_0(\mathcal{H})$, then $\dim \ker(A + K) < \infty$.
