# Context: mattila_8_8_frostman_lemma

**Statement:** [mattila_8_8_frostman_lemma.md](mattila_8_8_frostman_lemma.md) · **Criteria:** [mattila_8_8_frostman_lemma.criteria.md](mattila_8_8_frostman_lemma.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

$\mathcal{M}(B)$ is the nonzero finite Radon measures with compact support **inside $B$**. Both Frostman inequalities are **non-strict** as the book prints them: the growth bound $\mu(B(x,r)) \le r^s$ holds for every $x$ and every $r>0$, and the quantitative clause asks for $\mu(B) \ge c\,\mathcal{H}^s_\infty(B)$. Reading either as strict misreads the theorem — the strict variants say the same thing only after rescaling the unspecified constant, and they are not what 8.8 states. The biconditional is with the Hausdorff **measure**; the quantitative clause uses the **content** $\mathcal{H}^s_\infty$, which allows covers of unrestricted diameter.
