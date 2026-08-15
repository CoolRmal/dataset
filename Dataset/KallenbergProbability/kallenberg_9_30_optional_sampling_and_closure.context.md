# Context: kallenberg_9_30_optional_sampling_and_closure

**Statement:** [kallenberg_9_30_optional_sampling_and_closure.md](kallenberg_9_30_optional_sampling_and_closure.md) · **Criteria:** [kallenberg_9_30_optional_sampling_and_closure.criteria.md](kallenberg_9_30_optional_sampling_and_closure.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Optional times, $\mathcal{F}_\sigma$, and closure

**Localization.** Kallenberg defines "local" properties uniformly: a process $X$ has property P
*locally* when there are optional times $\tau_n \uparrow \infty$ (a *localizing sequence*) such that
each stopped and centred process $X^{\tau_n} - X_0$ has property P. This applies to martingales,
submartingales, $L^2$-martingales and integrability alike. A local martingale is therefore **not** a
martingale, and "locally integrable" is **not** integrability. The centring by $X_0$ is part of the
definition.

**Increasing process.** For Kallenberg an *increasing process* is non-decreasing, **right-continuous**,
**adapted**, and starts at $A_0 = 0$; it is *integrable* when $\mathbb{E}A_\infty < \infty$. All four
clauses are part of the word.

**Right-continuity conventions.** All submartingales in this book are taken right-continuous, and the
filtration is assumed right-continuous where needed. These are conventions carried in the surrounding
text, not stated in the theorem sentences, and a formalization has to restore them.

**Optional (stopping) time.** A map $\tau \colon \Omega \to [0,\infty]$ with $\{\tau \le t\} \in
\mathcal{F}_t$ for every $t$. The value $+\infty$ is allowed, which is exactly why the second half of the
theorem needs a terminal variable.

**$\mathcal{F}_\sigma$** is the $\sigma$-algebra of events determined by time $\sigma$:
$\{A : A \cap \{\sigma \le t\} \in \mathcal{F}_t \ \forall t\}$.

**$X_{\sigma\wedge\tau}$ and $X_\tau$** are stopped values, $\omega \mapsto X_{\tau(\omega)}(\omega)$. On
$\{\tau = \infty\}$ this is undefined unless a terminal value $X_\infty$ is supplied — and supplying it is
part of the closure half of the theorem.

**The three assertions.** (1) $X_\tau$ is integrable for bounded $\tau$; (2) the sampling **inequality**
$X_{\sigma\wedge\tau} \le \mathbb{E}(X_\tau \mid \mathcal{F}_\sigma)$ a.s. — an inequality, since $X$ is a
submartingale, not an equality; (3) an *if and only if*: the inequality extends to unbounded $\tau$
exactly when $X^+$ is uniformly integrable.

**$X^+ = \max(X,0)$**, and uniform integrability is of the family $\{X_t^+ : t \ge 0\}$.
