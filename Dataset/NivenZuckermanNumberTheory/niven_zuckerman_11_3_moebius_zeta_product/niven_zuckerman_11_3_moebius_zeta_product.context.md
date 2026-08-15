# Context: niven_zuckerman_11_3_moebius_zeta_product

**Statement:** [niven_zuckerman_11_3_moebius_zeta_product.md](niven_zuckerman_11_3_moebius_zeta_product.md) · **Criteria:** [niven_zuckerman_11_3_moebius_zeta_product.criteria.md](niven_zuckerman_11_3_moebius_zeta_product.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The Möbius function against $\zeta(2)$

**$\mu$ is the Möbius function**: $\mu(1)=1$, $\mu(n)=(-1)^k$ if $n$ is a product of $k$ distinct primes,
and $\mu(n)=0$ if $n$ is divisible by a square $>1$. It is integer-valued, so it must be cast to
$\mathbb{R}$ before dividing.

**Both series start at $n = 1$.** The $n = 0$ term has to be excluded explicitly — leaving it to a
convention such as $1/0 = 0$ happens to give the right value here, but it is a junk value and not the
intended reading.

**What is asserted** is that the **product of the two sums** equals $1$ — i.e. $\sum\mu(n)/n^2$ is the
reciprocal of $\zeta(2)$. Both exponents are $2$.
