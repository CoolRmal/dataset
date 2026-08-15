# V. I. Bogachev, *Gaussian Measures*, Theorem 1.9.3 (a tail characterization of Gaussian variables)

- **Source:** V. I. Bogachev, *Gaussian Measures*
- **Domain:** Probability
- **Lean declaration:** `Dataset.BogachevGaussian.bogachev_gaussian_1_9_3_symmetric_tail_characterization` ([bogachev_gaussian_1_9_3_symmetric_tail_characterization.lean](bogachev_gaussian_1_9_3_symmetric_tail_characterization.lean))
- **Criteria:** [bogachev_gaussian_1_9_3_symmetric_tail_characterization.criteria.md](bogachev_gaussian_1_9_3_symmetric_tail_characterization.criteria.md)
- **Context:** [bogachev_gaussian_1_9_3_symmetric_tail_characterization.context.md](bogachev_gaussian_1_9_3_symmetric_tail_characterization.context.md)

## Statement

**Theorem 1.9.3.** Let $\eta$ and $\xi$ be two independent random variables with a common symmetric distribution such that

$$P\left(\left|\frac{\xi+\eta}{\sqrt{2}}\right| \ge t\right) \le P(|\xi| \ge t), \qquad \forall t \ge 0. \tag{1.9.1}$$

Then these random variables are Gaussian.

**Notation.** A distribution $\mu$ on the real line is *symmetric* if it is invariant under $x \mapsto -x$. A measure on $\mathbb{R}$ is Gaussian when it is of the form $N(a,\sigma^2)$, degenerate values $\sigma = 0$ (Dirac measures) included.
