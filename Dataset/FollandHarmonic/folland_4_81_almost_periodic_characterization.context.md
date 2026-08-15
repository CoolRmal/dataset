# Context: folland_4_81_almost_periodic_characterization

**Statement:** [folland_4_81_almost_periodic_characterization.md](folland_4_81_almost_periodic_characterization.md) · **Criteria:** [folland_4_81_almost_periodic_characterization.criteria.md](folland_4_81_almost_periodic_characterization.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Characters, $bG$, and uniform almost periodicity

**$\widehat{G}$ and characters.** $G$ is a locally compact abelian group and $\widehat{G}$ its dual: the
continuous homomorphisms $\xi \colon G \to \mathbb{T}$ into the unit circle. Every character has modulus
$1$ everywhere; the pairing is written $\langle x,\xi\rangle = \xi(x)$.

**"Linear combinations of characters"** means *finite* complex linear combinations —
$\sum_{j=1}^{N} c_j \xi_j$ — i.e. trigonometric polynomials. "Uniform limit" means the approximation is
in the supremum norm over all of $G$: for every $\varepsilon > 0$ there is one such finite sum within
$\varepsilon$ of $f$ *at every point simultaneously*.

**$bG$, the Bohr compactification.** The compact abelian group obtained by giving $\widehat{G}$ the
discrete topology and taking its dual; there is a canonical continuous homomorphism $G \to bG$ with dense
image, and condition (a) says $f$ extends continuously along it. For $G = \mathbb{R}$ this recovers
Bohr's classical almost periodic functions.

**Uniformly almost periodic.** $f$ is uniformly almost periodic when the set of right translates
$\{R_yf : y \in G\}$, with $R_yf(x) = f(xy)$, is *totally bounded* in the supremum norm — that is, for
every $\varepsilon > 0$ finitely many translates $\varepsilon$-approximate all the others uniformly.
Totally bounded, not compact and not bounded: boundedness is automatic for a bounded $f$.

**Standing hypotheses.** $f$ is bounded and continuous; the three conditions are then equivalent.
