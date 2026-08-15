# Context: bogachev_3_7_1_change_of_variables_in_Rn

**Statement:** [bogachev_3_7_1_change_of_variables_in_Rn.md](bogachev_3_7_1_change_of_variables_in_Rn.md) · **Criteria:** [bogachev_3_7_1_change_of_variables_in_Rn.criteria.md](bogachev_3_7_1_change_of_variables_in_Rn.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Change of variables in $\mathbb{R}^n$

**The setting comes from the surrounding text, not the theorem sentence.** Bogachev states 3.7.1
inside a section where $U \subset \mathbb{R}^n$ has already been fixed as an *open* set and
$F \colon U \to \mathbb{R}^n$ as a *continuously differentiable* mapping. A reader who takes only
the sentence "If the mapping $F$ is injective on $U$, then …" is missing two hypotheses without
which the identity is false.

**$F'(x)$ and $J_F(x)$.** $F'(x)$ is the total (Fréchet) derivative of $F$ at $x$: the linear map
$\mathbb{R}^n \to \mathbb{R}^n$ best approximating $F$ near $x$, represented by the Jacobian matrix
of partial derivatives. $J_F(x) = \det F'(x)$ is its determinant, a real number which may be
negative or zero. The integrand carries $|J_F(x)|$, the absolute value: the sign of the determinant
records whether $F$ preserves orientation, and measure does not see orientation.

**$dx$ and $dy$.** Both are Lebesgue measure on $\mathbb{R}^n$. "Measurable set" on $\mathbb{R}^n$
means Lebesgue measurable — measurable for the completed σ-algebra — which is strictly larger than
the Borel σ-algebra.

**$g \in L^1(\mathbb{R}^n)$.** Integrability is assumed over all of $\mathbb{R}^n$, not merely over
$F(A)$; "Borel function" says $g$ is Borel measurable. $F(A)$ denotes the forward image
$\{F(x) : x \in A\}$, which is Lebesgue measurable here because $F$ is $C^1$ and $A \subseteq U$,
though that is a small theorem in its own right rather than an assumption.

**Where injectivity enters.** Injectivity is assumed on all of $U$, not just on $A$. It is what
makes the identity an equality rather than an inequality: without it, points of $F(A)$ with several
preimages are counted once on the right and several times on the left. For $F(x)=x^2$ on $(-1,1)$
and $A = (-1,1)$ the two sides already differ.
