# Context: grafakos_2_2_14_fourier_identities_on_schwartz

**Statement:** [grafakos_2_2_14_fourier_identities_on_schwartz.md](grafakos_2_2_14_fourier_identities_on_schwartz.md) · **Criteria:** [grafakos_2_2_14_fourier_identities_on_schwartz.criteria.md](grafakos_2_2_14_fourier_identities_on_schwartz.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The five Fourier identities on the Schwartz class

**Grafakos's normalization of the Fourier transform.**
$\widehat f(\xi) = \int_{\mathbb{R}^n} f(x)\,e^{-2\pi i x\cdot\xi}\,dx$, with the $2\pi$ in the
exponent and **no** prefactor. The inverse transform is $f^{\vee}(x) = \int f(\xi)e^{+2\pi i x\cdot\xi}d\xi$,
differing only in the sign of the exponent. With this normalization the transform is an isometry of
$L^2$ on the nose, inversion has no constant, and $\widehat{f}$ of a Schwartz function is Schwartz.
Other books put $e^{-ix\xi}$ with a $(2\pi)^{-n/2}$ prefactor; every constant in this chapter depends on
the choice, so a formalization must use Grafakos's.

**Weak $L^p$.** $\|F\|_{L^{p,\infty}} = \sup_{\alpha>0}\alpha\,\nu(\{|F|>\alpha\})^{1/p}$; the weak-type
bound $\|Tf\|_{L^{p,\infty}} \le A\|f\|_{L^p}$ is the same as
$\nu(\{|Tf|>\alpha\}) \le (A\|f\|_{L^p}/\alpha)^p$ for every $\alpha>0$. It is strictly weaker than the
strong-type bound.

**$\mathcal{S}(\mathbb{R}^n)$** is the Schwartz class of smooth, rapidly decreasing functions. It is
where all five identities live because every integral in sight converges absolutely and the Fourier
transform maps the class to itself.

**The five identities are genuinely five statements.**

1. *Multiplication formula*: $\int f\,\widehat g = \int \widehat f\,g$ — a **bilinear** pairing, with no
   complex conjugate.
2. *Inversion*, in **both** orders: $(\widehat f)^{\vee} = f$ and $\widehat{(f^{\vee})} = f$.
3. *Parseval*: $\int f\,\overline h = \int \widehat f\,\overline{\widehat h}$ — the **sesquilinear**
   $L^2$ inner product, with a conjugate on one factor. Distinct from (1).
4. *Plancherel*: $\|f\|_{2} = \|\widehat f\|_{2} = \|f^{\vee}\|_{2}$, two equalities.
5. $\int f\,h = \int \widehat f\,h^{\vee}$ — the transform on one factor, the *inverse* transform on the
   other.

Identity (1) and identity (3) look alike but are not the same: one is bilinear, one carries a
conjugate. Identity (5) is again different — no conjugate, and the inverse transform on the second
factor.

**The conjugate goes on exactly one factor**, and the identity is invariant under conjugating both
sides and swapping the arguments, so a rendering with the conjugate on the other factor is equivalent —
but a rendering that omits it, or applies it to both factors, is not.
