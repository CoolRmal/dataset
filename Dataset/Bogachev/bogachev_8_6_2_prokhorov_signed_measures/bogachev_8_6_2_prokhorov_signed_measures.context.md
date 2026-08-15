# Context: bogachev_8_6_2_prokhorov_signed_measures

**Statement:** [bogachev_8_6_2_prokhorov_signed_measures.md](bogachev_8_6_2_prokhorov_signed_measures.md) · **Criteria:** [bogachev_8_6_2_prokhorov_signed_measures.criteria.md](bogachev_8_6_2_prokhorov_signed_measures.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## What $M$, $\mathcal{M}_t(X)$ and "weak convergence" mean here

**$M$ is a family of signed measures.** This is the notation that most often misleads. Throughout
Bogachev's Chapter 8, "measure" without further qualification means a *countably additive real-valued
set function of bounded variation* — a finite signed Borel measure — and $\mathcal{M}(X)$ denotes the
space of all of them. The $M$ in the statement of 8.6.2 is a subset of that space, so the members of
$M$ take negative values in general. They are **not** probability measures and **not** nonnegative
measures. Reading $M$ as a family of probability measures turns the theorem into a much weaker and
already-known statement, because for probability measures condition (ii) is half automatic.

**$\mathcal{M}_t(X)$** is the subspace of *tight* (Radon) measures: those $\mu$ for which
$|\mu|(X \setminus K)$ can be made arbitrarily small by choosing a compact $K$. On a complete
separable metric space every finite Borel measure is tight, which is exactly why the first part of the
theorem needs separability and the second does not.

**Variation norm and uniform boundedness.** $\|\mu\| = |\mu|(X)$, the total mass of the total
variation measure $|\mu|$ of $\mu$. "Uniformly bounded in the variation norm" means
$\sup_{\mu \in M} \|\mu\| < \infty$. For a family of probability measures this is automatic; for
signed measures it is a genuine restriction, and it cannot be dropped — tightness alone does not imply
it.

**Uniform tightness** of $M$ means: for every $\varepsilon>0$ there is a compact $K \subseteq X$ with
$|\mu|(X \setminus K) < \varepsilon$ for **every** $\mu \in M$ simultaneously. It is a statement about
the total variation measures $|\mu|$, not about the signed measures themselves — "mass" for a signed
measure is measured by its variation.

**Weak convergence.** $\mu_n \to \mu$ weakly means $\int f \, d\mu_n \to \int f \, d\mu$ for every
*bounded continuous* real function $f$ on $X$. The integral of a bounded continuous function against a
signed measure is defined through the Jordan decomposition, $\int f\,d\mu^+ - \int f\,d\mu^-$; both
parts are finite measures, so both integrals are finite. Testing instead against compactly supported
continuous functions gives *vague* convergence, a strictly weaker notion for which the theorem is
false.

**"Relatively compact".** Condition (i) says every sequence in $M$ has a subsequence converging weakly
to *some* limit; the limit is not required to belong to $M$. That is relative sequential compactness,
not compactness.

**Two claims, two hypotheses.** The theorem has two parts with genuinely different assumptions on $X$:
the equivalence holds for arbitrary $M$ when $X$ is complete **and separable**, and for arbitrary
complete metric $X$ when every member of $M$ is tight. A formalization that assumes separability
globally states the first part twice.
