# Context: bogachev_gaussian_1_9_3_symmetric_tail_characterization

**Statement:** [bogachev_gaussian_1_9_3_symmetric_tail_characterization.md](bogachev_gaussian_1_9_3_symmetric_tail_characterization.md) · **Criteria:** [bogachev_gaussian_1_9_3_symmetric_tail_characterization.criteria.md](bogachev_gaussian_1_9_3_symmetric_tail_characterization.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Symmetry, the $\sqrt2$ normalization, and degenerate Gaussians

**Symmetric distribution.** A law $\mu$ on $\mathbb{R}$ is symmetric when it is invariant under
$x \mapsto -x$, i.e. the pushforward of $\mu$ under negation is $\mu$ again. This is strictly stronger
than "mean zero", and it is a hypothesis of the theorem: it does not follow from the tail bound.

**The two variables.** $\xi$ and $\eta$ are independent with the *same* law $\mu$. So the pair has
joint law $\mu \otimes \mu$, and the quantity $(\xi + \eta)/\sqrt{2}$ is a function on the product
space.

**Why $\sqrt2$.** For a law with variance $\sigma^2$, the sum of two independent copies has variance
$2\sigma^2$, and dividing by $\sqrt{2}$ restores variance $\sigma^2$. The normalized sum is therefore
the natural competitor of a single summand, and the hypothesis (1.9.1) says its tails are no heavier.
Without the $\sqrt2$ the hypothesis is satisfiable only by degenerate laws and the theorem becomes
empty.

**The tails are closed events.** $P(|\cdot| \ge t)$, not $>$, and the bound is required for every
$t \ge 0$.

**"Gaussian" includes the degenerate case.** The conclusion is that the common law is $N(a,\sigma^2)$;
symmetry forces $a = 0$, and $\sigma = 0$ is allowed — $\xi \equiv 0$ satisfies all the hypotheses and
is the Dirac mass at $0$. A conclusion that asserts a *positive* variance is therefore false.

**No moment hypothesis.** Finiteness of $\mathbb{E}\xi^2$ is not assumed; deriving it is the hard part
of the proof.
