# Context: bogachev_gaussian_1_9_2_rotation_characterization

**Statement:** [bogachev_gaussian_1_9_2_rotation_characterization.md](bogachev_gaussian_1_9_2_rotation_characterization.md) · **Criteria:** [bogachev_gaussian_1_9_2_rotation_characterization.criteria.md](bogachev_gaussian_1_9_2_rotation_characterization.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Independent copies, and what the rotation condition says

**"Independent copies of $\xi$".** A pair $(\xi_1,\xi_2)$ of random vectors that are independent and
each distributed as $\xi$. Equivalently: the joint law of the pair on
$\mathbb{R}^n \times \mathbb{R}^n$ is the product $\mu \otimes \mu$, where $\mu$ is the law of $\xi$.
The two components have the *same* law $\mu$; a pair with different laws is not what is meant.

**What the right-hand condition asserts.** For every angle $\varphi$, the pair
$$\bigl(\xi_1\sin\varphi + \xi_2\cos\varphi,\ \xi_1\cos\varphi - \xi_2\sin\varphi\bigr)$$
is *again* a pair of independent copies of $\xi$ — that is, its joint law is again $\mu \otimes \mu$.
This is strictly more than saying each of the two mixtures has law $\mu$ separately: the independence
of the rotated pair is part of the condition, and many non-Gaussian laws preserve the marginals while
destroying independence.

**Centred Gaussian on $\mathbb{R}^n$.** A Borel probability measure every continuous linear functional
of which has a (possibly degenerate) Gaussian law with mean $0$; equivalently a measure with
characteristic function $\exp(-\tfrac12 \langle Qt,t\rangle)$ for a positive semidefinite $Q$. The
covariance is arbitrary, and may be singular — the standard Gaussian is not the only case.

**No moment hypothesis.** Nothing is assumed beyond the two conditions. That $\xi$ has a finite second
moment is part of what the hard direction proves; assuming it gives away the difficulty.

**Both directions are asserted.** The forward direction is a computation; the converse is Kac's
characterization and is the theorem.
