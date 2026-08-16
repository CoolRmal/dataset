import Mathlib.Analysis.Distribution.Sobolev
import Mathlib.RingTheory.MvPolynomial.Homogeneous

/-!
# Shared definitions for the KrylovSobolev problems

Custom notions used by the statement files in `Dataset/KrylovSobolev/` that are not
already supplied by Mathlib. The Laplacian is Mathlib's `Δ`, the Schwartz space and the
tempered distributions are `𝓢(E, ℂ)` and `𝓢'(E, ℂ)`, the Bessel potential `(1 - Δ)^{γ/2}`
is `TemperedDistribution.besselPotential`, and membership in a Bessel potential space is
`TemperedDistribution.MemSobolev`; what is added here is Krylov's coordinate partial
derivative `D_i` together with the multi-index derivative `D^α`, the Bessel potential on
Schwartz functions in Krylov's normalization, generalized first derivatives, the
divergence-form equation of Chapter 13.6, the norm of the Bessel potential space (which
Mathlib supplies only as a predicate), and strong ellipticity.
-/

open MeasureTheory TemperedDistribution
open scoped ContDiff ENNReal SchwartzMap

namespace Dataset
namespace KrylovSobolev

section Deriv

variable {d : ℕ} {F : Type*} [NormedAddCommGroup F] [NormedSpace ℝ F]

/-- Krylov's `u_{x^i}`, the `i`-th coordinate partial derivative. It maps functions to
functions, so it iterates: `partialDeriv j (partialDeriv i u)` is `u_{x^i x^j}`. -/
noncomputable def partialDeriv (i : Fin d) (u : EuclideanSpace ℝ (Fin d) → F) :
    EuclideanSpace ℝ (Fin d) → F :=
  fun x ↦ fderiv ℝ u x (EuclideanSpace.single i 1)

/-- Krylov's `D^α u`, the mixed partial derivative selected by the multi-index `α`, whose
order is `|α| = ∑ i, α i`. -/
noncomputable def multiDeriv (α : Fin d → ℕ) (u : EuclideanSpace ℝ (Fin d) → F) :
    EuclideanSpace ℝ (Fin d) → F :=
  (List.finRange d).foldr (fun i v ↦ (partialDeriv i)^[α i] v) u

end Deriv

/-- Krylov's `(1 - Δ)^{γ/2}` acting on Schwartz functions: the Fourier multiplier with symbol
`(1 + |ξ|²)^{γ/2}`. The factor `(2π)²` compensates Mathlib's `e^{-2πi⟪x, ξ⟫}` convention, so this
is Krylov's operator itself and not merely an equivalent one. -/
noncomputable def besselOp {d : ℕ} (γ : ℝ) :
    𝓢(EuclideanSpace ℝ (Fin d), ℂ) →L[ℂ] 𝓢(EuclideanSpace ℝ (Fin d), ℂ) :=
  SchwartzMap.fourierMultiplierCLM ℂ fun ξ ↦
    (((1 + (2 * Real.pi) ^ 2 * ‖ξ‖ ^ 2) ^ (γ / 2) : ℝ) : ℂ)

/-- Krylov's Definition 1.3.4 in first order: `v` is the family of generalized (Sobolev) first
derivatives of `u` on `ℝ^d`, that is `∫ u D_j φ = -∫ v_j φ` for every test function `φ`. -/
def HasWeakGradient {d : ℕ} (u : EuclideanSpace ℝ (Fin d) → ℝ)
    (v : Fin d → EuclideanSpace ℝ (Fin d) → ℝ) : Prop :=
  ∀ (j : Fin d) (φ : EuclideanSpace ℝ (Fin d) → ℝ), ContDiff ℝ ∞ φ → HasCompactSupport φ →
    (∫ x, u x * partialDeriv j φ x) = -∫ x, v j x * φ x

/-- Krylov's equation (13.6.1), `D_i(a^{ij}D_j u + a^i u) + b^i D_i u + cu - λu = D_i f^i + g`,
in the sense of distributions: `u` lies in `𝓛_p` with generalized gradient `v`, and the identity
obtained by integrating the divergence terms by parts holds against every test function. -/
def IsDivergenceFormSolution {d : ℕ} (a : Fin d → Fin d → EuclideanSpace ℝ (Fin d) → ℝ)
    (a' b : Fin d → EuclideanSpace ℝ (Fin d) → ℝ) (c : EuclideanSpace ℝ (Fin d) → ℝ) (lam : ℝ)
    (f : Fin d → EuclideanSpace ℝ (Fin d) → ℝ) (g u : EuclideanSpace ℝ (Fin d) → ℝ)
    (v : Fin d → EuclideanSpace ℝ (Fin d) → ℝ) : Prop :=
  HasWeakGradient u v ∧
    ∀ φ : EuclideanSpace ℝ (Fin d) → ℝ, ContDiff ℝ ∞ φ → HasCompactSupport φ →
      ((∑ i, ∫ x, ((∑ j, a i j x * v j x) + a' i x * u x - f i x) * partialDeriv i φ x) +
          ∫ x, g x * φ x) =
        ∫ x, ((∑ i, b i x * v i x) + (c x - lam) * u x) * φ x

/-- Krylov's Definition 13.3.1: the norm `‖g‖_{H_p^s} = ‖(1 - Δ)^{s/2} g‖_{𝓛_p}` of the Bessel
potential space, as the `𝓛_p` norm of the representative of `besselPotential s g` when there is
one and `⊤` otherwise. -/
noncomputable def sobolevNorm {d : ℕ} (s : ℝ) (p : ℝ≥0∞) [Fact (1 ≤ p)]
    (g : 𝓢'(EuclideanSpace ℝ (Fin d), ℂ)) : ℝ≥0∞ :=
  ⨅ f ∈ {f : Lp ℂ p (volume : Measure (EuclideanSpace ℝ (Fin d))) |
    besselPotential (EuclideanSpace ℝ (Fin d)) ℂ s g = f}, ‖f‖ₑ

/-- Krylov's Definition 12.2.1: the constant-coefficient operator `L = ∑_{|α| ≤ m} a^α D^α`,
with its coefficients packaged as the polynomial `P = ∑_α a^α X^α`, is strongly elliptic of
order `m` when its principal symbol does not vanish off the origin and its characteristic
polynomial `σ_L(ξ) = ∑_{|α| ≤ m} a^α i^{|α|} ξ^α = P(iξ)` does not vanish at all. -/
def IsStronglyElliptic {d : ℕ} (m : ℕ) (P : MvPolynomial (Fin d) ℂ) : Prop :=
  P.totalDegree ≤ m ∧
    (∀ ξ : Fin d → ℝ, ξ ≠ 0 →
      MvPolynomial.eval (fun j ↦ ((ξ j : ℝ) : ℂ)) (MvPolynomial.homogeneousComponent m P) ≠ 0) ∧
    ∀ ξ : Fin d → ℝ, MvPolynomial.eval (fun j ↦ Complex.I * (ξ j : ℂ)) P ≠ 0

end KrylovSobolev
end Dataset
