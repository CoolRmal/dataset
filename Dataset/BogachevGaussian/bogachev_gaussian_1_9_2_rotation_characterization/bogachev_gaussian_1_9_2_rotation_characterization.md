# V. I. Bogachev, *Gaussian Measures*, Theorem 1.9.2 (rotational characterization of centered Gaussian vectors)

- **Source:** V. I. Bogachev, *Gaussian Measures*
- **Domain:** Probability
- **Lean declaration:** `Dataset.BogachevGaussian.bogachev_gaussian_1_9_2_rotation_characterization` ([bogachev_gaussian_1_9_2_rotation_characterization.lean](bogachev_gaussian_1_9_2_rotation_characterization.lean))
- **Criteria:** [bogachev_gaussian_1_9_2_rotation_characterization.criteria.md](bogachev_gaussian_1_9_2_rotation_characterization.criteria.md)
- **Context:** [bogachev_gaussian_1_9_2_rotation_characterization.context.md](bogachev_gaussian_1_9_2_rotation_characterization.context.md)

## Statement

**Theorem 1.9.2.** A random vector $\xi$ in $\mathbb{R}^n$ is centered Gaussian if and only if for every pair $(\xi_1,\xi_2)$ of independent copies of $\xi$ and every real number $\varphi$, the random vectors

$$\xi_1\sin\varphi + \xi_2\cos\varphi, \qquad \xi_1\cos\varphi - \xi_2\sin\varphi$$

are independent copies of $\xi$.

**Notation.** "Independent copies of $\xi$" means a pair of independent random vectors each distributed as $\xi$; equivalently, the joint law of the pair is $\mu\otimes\mu$, where $\mu$ is the law of $\xi$. A Borel probability measure on $\mathbb{R}^n$ is Gaussian if every continuous linear functional has a (possibly degenerate) Gaussian law, and centered if its mean vector is $0$.
