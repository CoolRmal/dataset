# Context: conway_XI_2_3_left_semi_fredholm_characterizations

**Statement:** [conway_XI_2_3_left_semi_fredholm_characterizations.md](conway_XI_2_3_left_semi_fredholm_characterizations.md) · **Criteria:** [conway_XI_2_3_left_semi_fredholm_characterizations.criteria.md](conway_XI_2_3_left_semi_fredholm_characterizations.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Left semi-Fredholm: the eight conditions and their notation

**Left semi-Fredholm** is defined in the statement: $A$ is left invertible modulo the compacts, i.e.
there are a bounded $B \colon \mathcal{H}' \to \mathcal{H}$ and a compact
$C \colon \mathcal{H} \to \mathcal{H}$ with $BA = 1 + C$. Note the composite is $BA$, acting on the
*domain* space $\mathcal{H}$, and both the error $C$ and the identity live there.

**$\mathcal{B}_0(\mathcal{H})$** is the compact operators; "finite rank" in (c) means the range is
finite dimensional.

**"$h_n \to 0$ weakly" in (d)** is convergence in the weak topology of $\mathcal{H}$, and the $h_n$ are
*unit* vectors — norm exactly $1$. Condition (d) asserts that no such sequence exists.

**"Infinite dimensional manifold" in (f)** is Conway's term for an infinite dimensional *linear
subspace* (not a manifold in the differential-geometric sense). The condition says: for some
$\delta>0$, the set $\{h : \|Ah\| \le \delta\|h\|\}$ contains no infinite dimensional subspace.

**$(A^*A)^{1/2}$ and $E$ in (g).** $A^*A$ is positive, and $(A^*A)^{1/2}$ is its unique positive square
root; $\int_0^\infty t\,dE(t)$ is its spectral resolution. $E[0,\delta]\mathcal{H}$ is the range of the
spectral projection of the interval $[0,\delta]$; the condition is that this range is finite
dimensional for some $\delta>0$.

**(h)** ranges over all compact $K$, and $\ker(A+K)$ is the kernel of the perturbed operator.

**All eight are one equivalence.** The theorem's content is that these very different-looking
conditions coincide.
