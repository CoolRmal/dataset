# O. Kallenberg, *Foundations of Modern Probability*, Theorem 10.5 (Doob–Meyer decomposition; Meyer, Doléans)

- **Source:** O. Kallenberg, *Foundations of Modern Probability*
- **Domain:** Martingales
- **Lean declaration:** `Dataset.KallenbergProbability.kallenberg_10_5_doob_meyer` ([kallenberg_10_5_doob_meyer.lean](kallenberg_10_5_doob_meyer.lean))
- **Criteria:** [kallenberg_10_5_doob_meyer.criteria.md](kallenberg_10_5_doob_meyer.criteria.md)
- **Context:** [kallenberg_10_5_doob_meyer.context.md](kallenberg_10_5_doob_meyer.context.md)

## Statement

**Theorem 10.5 (Doob–Meyer decomposition; Meyer, Doléans).** For an adapted process $X$, these conditions are equivalent:

- **(i)** $X$ is a local sub-martingale,
- **(ii)** $X = M + A$ a.s. for a local martingale $M$ and a locally integrable, non-decreasing, predictable process $A$ with $A_0 = 0$.

The processes $M$ and $A$ are then a.s. unique.

**Increasing and integrable processes.** By an *increasing process* we mean a non-decreasing, right-continuous, and adapted process $A$ with $A_0 = 0$. It is said to be *integrable* if $\mathbb{E}A_\infty < \infty$. Recall that all sub-martingales are taken to be right-continuous. Local sub-martingales and locally integrable processes are defined by localization, in the usual way.

**Local martingales and localizing sequences.** A process $M$ is said to be a *local martingale* if it is adapted to $\mathcal{F}$ and such that the stopped and centered processes $M^{\tau_n} - M_0$ are true martingales for some optional times $\tau_n \uparrow \infty$. By a similar localization we may define local $L^2$-martingales, locally bounded martingales, locally integrable processes, etc. The required optional times $\tau_n$ are said to form a *localizing sequence*.
