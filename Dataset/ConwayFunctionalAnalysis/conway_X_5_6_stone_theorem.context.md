# Context: conway_X_5_6_stone_theorem

**Statement:** [conway_X_5_6_stone_theorem.md](conway_X_5_6_stone_theorem.md) · **Criteria:** [conway_X_5_6_stone_theorem.criteria.md](conway_X_5_6_stone_theorem.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## One-parameter unitary groups and unbounded self-adjoint generators

**"Strongly continuous one parameter unitary group"** is four conditions: $U(0) = 1$;
$U(s+t) = U(s)U(t)$ for all real $s,t$; each $U(t)$ is unitary ($U^*U = UU^* = 1$ — both identities,
since on an infinite-dimensional space a single one gives only an isometry); and *strong* continuity,
meaning $t \mapsto U(t)x$ is continuous for every fixed vector $x$. Norm continuity would be a strictly
stronger hypothesis and would restrict the theorem to bounded generators.

**"Self-adjoint operator $A$" here is unbounded.** This is the point of the theorem: the generator is
in general not defined on all of $\mathcal{H}$. Such an operator is a pair (a dense linear subspace
$\mathcal{D}(A) \subseteq \mathcal{H}$, a linear map $A \colon \mathcal{D}(A) \to \mathcal{H}$).
*Self-adjoint* for an unbounded operator is two conditions together: the domain of the adjoint $A^*$
equals $\mathcal{D}(A)$, and $A^* = A$ on it. Merely symmetric — $\langle Ax,y\rangle = \langle x,Ay\rangle$
for $x,y$ in the domain — is strictly weaker and is *not* sufficient for Stone's theorem.

**$\exp(itA)$ for unbounded $A$** cannot be a power series. It is defined through the spectral theorem:
if $E$ is the spectral measure of $A$, supported on the real line, then $\exp(itA)$ is the operator with
$\langle \exp(itA)x, y\rangle = \int e^{it\lambda}\,d\langle E(\lambda)x,y\rangle$, and $A$ itself is
recovered as $\langle Ax,y\rangle = \int \lambda \, d\langle E(\lambda)x,y\rangle$ for $x$ in the
domain. The support condition — $E$ vanishes off $\mathbb{R}$ — is what encodes self-adjointness
spectrally.

**Uniqueness.** The generator is unique, which is part of the standard statement and is what makes "the"
generator well defined.
