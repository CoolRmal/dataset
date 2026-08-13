# Criteria: kallenberg_8_5_conditional_distributions

**Statement:** [kallenberg_8_5_conditional_distributions.md](kallenberg_8_5_conditional_distributions.md) · **Lean:** [kallenberg_8_5_conditional_distributions.lean](kallenberg_8_5_conditional_distributions.lean)

## What the theorem says

Let $\xi$ and $\eta$ be random elements of measurable spaces $S$ and $T$, where $T$ is standard
Borel. The theorem says the joint law of the pair factors as the law of $\xi$ combined with a
probability kernel $\mu$ from $S$ to $T$; that this kernel is unique up to a set of $\xi$-values that
the law of $\xi$ ignores; and that it computes conditional expectations, in the sense that for any
non-negative measurable $f$ of both variables, $\mathbb{E}(f(\xi, \eta) \mid \xi)$ equals
$\int f(\xi, t)\,\mu(\xi, dt)$. The kernel is the conditional distribution of $\eta$ given $\xi$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The standard Borel assumption is on $T$ only; $S$ carries nothing but a measurable structure. | ✅ `[MeasurableSpace S]`, `[MeasurableSpace T] [StandardBorelSpace T]`. |
| 2 | $\xi$ and $\eta$ are measurable maps and the underlying measure is a probability measure. | ✅ `hξ : Measurable ξ`, `hη : Measurable η`, `[IsProbabilityMeasure μ]`. |
| 3 | The conclusion asserts the *existence* of a kernel, as an abstract object. | ✅ `∃ κ : Kernel S T, …`. |
| 4 | The kernel is a probability kernel: every fibre has total mass $1$. | ✅ `IsMarkovKernel κ`. |
| 5 | The joint law of the pair factors as the law of $\xi$ composed with the kernel. | ✅ `μ.map (fun ω ↦ (ξ ω, η ω)) = μ.map ξ ⊗ₘ κ`. |
| 6 | Uniqueness holds among probability kernels satisfying the same identity, and it is uniqueness almost everywhere with respect to the law of $\xi$. | ✅ `∀ κ' : Kernel S T, IsMarkovKernel κ' → μ.map (fun ω ↦ (ξ ω, η ω)) = μ.map ξ ⊗ₘ κ' → κ =ᵐ[μ.map ξ] κ'`. |
| 7 | The integration formula holds for every non-negative measurable $f$ of *both* arguments. | ✅ `∀ f : S → T → ℝ≥0∞, Measurable (Function.uncurry f) → …`, with the values in `ℝ≥0∞` capturing "$f \ge 0$". |
| 8 | The conditional-expectation identity is stated by testing against every event determined by $\xi$, with the kernel evaluated at $\xi(\omega)$ inside the integral. | ✅ `∀ A : Set S, MeasurableSet A → ∫⁻ ω in ξ ⁻¹' A, f (ξ ω) (η ω) ∂μ = ∫⁻ ω in ξ ⁻¹' A, ∫⁻ t, f (ξ ω) t ∂κ (ξ ω) ∂μ`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Adding `[StandardBorelSpace S]`, or Polish / countably-generated assumptions on $S$. | The strength of the theorem is that the conditioning space needs no structure at all; adding some narrows the result. |
| 2 | Writing the conclusion in terms of Mathlib's `condDistrib η ξ μ`. | That turns an existence theorem into an almost definitional identity about an object Mathlib has already built, so nothing of Theorem 8.5 is being formalized. |
| 3 | Using `Measure.prod` instead of the composition-product `⊗ₘ`. | The product measure asserts that $\xi$ and $\eta$ are independent, which is a completely different — and false — claim. |
| 4 | Asking only for `IsFiniteKernel κ`. | The theorem produces a *probability* kernel; finite fibres of arbitrary mass do not give a conditional distribution. |
| 5 | Stating uniqueness as `κ = κ'` everywhere, or as `κ =ᵐ[μ] κ'`. | Everywhere equality is false — the kernel may be changed arbitrarily on $\xi$-null sets. And `μ` lives on $\Omega$, not on $S$, so the second is not even the right space. |
| 6 | Omitting uniqueness altogether. | The text asserts it explicitly, and it is what makes "the" conditional distribution well defined. |
| 7 | Encoding the integration formula with `condExp`. | `condExp` is a real-valued Bochner object that needs integrability side conditions and returns $0$ when they fail. The text restricts to $f \ge 0$ precisely so no such condition is needed. |
| 8 | Testing the identity only at $A$ equal to the whole space. | That gives the marginal identity $\mathbb{E}f(\xi,\eta) = \mathbb{E}\int f(\xi,t)\mu(\xi,dt)$ and loses the conditioning entirely. |
| 9 | Writing the inner integral against `κ s` for a free variable $s$ rather than against `κ (ξ ω)`. | The conditional distribution must be evaluated at the observed value of $\xi$; anything else is a different statement. |

## Notes on the ground truth

- Item (i) of the text, $\mathcal{L}(\eta \mid \xi) = \mu(\xi, \cdot)$ almost surely, is not stated
  as its own clause. ⚠️ No content is lost, because it is the case
  `f := fun _ t ↦ Set.indicator B 1 t` of the integration formula, but an explicit clause such as
  `∀ B, MeasurableSet B → ∀ A, MeasurableSet A → μ (ξ ⁻¹' A ∩ η ⁻¹' B) = ∫⁻ ω in ξ ⁻¹' A, κ (ξ ω) B ∂μ`
  would make the conditional-distribution reading visible on the page.
- `IsMarkovKernel κ` also supplies the s-finiteness that keeps `⊗ₘ` from collapsing. Mathlib defines
  the composition-product to be the zero measure when the kernel is not s-finite, so without some
  finiteness assumption the factorization identity would not mean what it appears to.
- All integrals are lower Lebesgue integrals valued in `ℝ≥0∞`, so they are defined for every
  measurable non-negative integrand and no default value can arise.
- Measurability of `ξ` matters twice: `μ.map ξ` is the zero measure for a non-measurable map, and
  `ξ ⁻¹' A` has to be measurable for the restricted integrals to mean anything.
