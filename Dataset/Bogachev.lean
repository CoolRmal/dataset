module

import Mathlib.Analysis.Calculus.ContDiff.Basic
import Mathlib.Analysis.Convex.Function
import Mathlib.Analysis.Normed.Module.FiniteDimension
import Mathlib.MeasureTheory.Constructions.Polish.Basic
import Mathlib.MeasureTheory.Function.UniformIntegrable
import Mathlib.MeasureTheory.Integral.Prod
import Mathlib.MeasureTheory.Measure.NullMeasurable
import Mathlib.MeasureTheory.Measure.ProbabilityMeasure
import Mathlib.MeasureTheory.Measure.Regular
import Mathlib.MeasureTheory.Measure.Tight
import Mathlib.MeasureTheory.VectorMeasure.Basic
import Mathlib.MeasureTheory.VectorMeasure.Decomposition.Jordan

/-!
# Hard measure-theory statement dataset

This file contains ten statement-only formalizations selected from V. I. Bogachev,
*Measure Theory*, Volumes I-II. They were chosen as difficult autoformalization
targets because the theorem statements themselves have substantial mathematical
structure: Lusin's property, differentiability and image measure, Hardy inequalities,
Prokhorov compactness, change of variables, uniform integrability, uniform countable
additivity, simultaneous transport, liftings, and Radon preimages.
-/

open Filter MeasureTheory ProbabilityTheory Set Topology

open scoped BoundedContinuousFunction ENNReal MeasureTheory NNReal ProbabilityTheory Topology

namespace Dataset
namespace Bogachev

/-- The integral of a bounded continuous function against a finite signed measure. -/
noncomputable def signedMeasureIntegral {X : Type*} [TopologicalSpace X] [MeasurableSpace X]
    (s : SignedMeasure X) (f : X →ᵇ ℝ) : ℝ :=
  (∫ x, f x ∂s.toJordanDecomposition.posPart) -
    ∫ x, f x ∂s.toJordanDecomposition.negPart

/-- Weak convergence of finite signed measures against bounded continuous functions. -/
def weakly_converges_signed {X : Type*} [TopologicalSpace X] [MeasurableSpace X]
    (s : ℕ → SignedMeasure X) (t : SignedMeasure X) : Prop :=
  ∀ f : X →ᵇ ℝ,
    Tendsto (fun n ↦ signedMeasureIntegral (s n) f) atTop (𝓝 (signedMeasureIntegral t f))

/-- Every sequence in the family has a weakly convergent subsequence. -/
def relatively_sequentially_weakly_compact_signed {X : Type*} [TopologicalSpace X]
    [MeasurableSpace X] (S : Set (SignedMeasure X)) : Prop :=
  ∀ s : ℕ → SignedMeasure X, (∀ n, s n ∈ S) →
    ∃ φ : ℕ → ℕ, StrictMono φ ∧ ∃ t, weakly_converges_signed (fun n ↦ s (φ n)) t

/--
Uniform countable additivity for a family of signed measures, expressed by
uniform smallness on tails of arbitrary pairwise-disjoint measurable sequences.
-/
def UniformlyCountablyAdditive {Ω : Type*} [MeasurableSpace Ω]
    (S : Set (SignedMeasure Ω)) : Prop :=
  ∀ A : ℕ → Set Ω,
    (∀ n : ℕ, MeasurableSet (A n)) →
      (∀ i j : ℕ, i ≠ j → Disjoint (A i) (A j)) →
        ∀ ε : ℝ, 0 < ε →
          ∃ N : ℕ, ∀ s ∈ S, ∀ n ≥ N, |s (⋃ k : {k // n ≤ k}, A k.1)| < ε

/-- A family of signed measures is uniformly bounded in total variation. -/
def UniformlyBoundedInTotalVariation {Ω : Type*} [MeasurableSpace Ω]
    (S : Set (SignedMeasure Ω)) : Prop :=
  ∃ C : ℝ≥0, ∀ s ∈ S, s.totalVariation univ ≤ C

/-- Uniform absolute continuity of a family of signed measures with respect to a measure. -/
def UniformlyAbsolutelyContinuous {Ω : Type*} [MeasurableSpace Ω]
    (S : Set (SignedMeasure Ω)) (μ : Measure Ω) : Prop :=
  ∀ ε : ℝ, 0 < ε →
    ∃ δ : ℝ, 0 < δ ∧
      ∀ s ∈ S, ∀ A : Set Ω, MeasurableSet A →
        μ A ≤ ENNReal.ofReal δ → |s A| < ε

/-- A measure is atomless if every measurable set of positive mass has a smaller positive part. -/
def is_atomless_measure {X : Type*} [MeasurableSpace X] (μ : Measure X) : Prop :=
  ∀ A : Set X, MeasurableSet A → 0 < μ A →
    ∃ B : Set X, MeasurableSet B ∧ B ⊆ A ∧ 0 < μ B ∧ μ B < μ A

/-- A pointwise linear and multiplicative choice of representatives of `L∞(μ)` classes. -/
structure LInfinityLifting {X : Type*} [MeasurableSpace X] (μ : Measure X) where
  toFun : (X → ℝ) → X → ℝ
  maps_bounded_measurable : ∀ f, (Measurable f ∧ ∃ C : ℝ, ∀ x, |f x| ≤ C) →
    Measurable (toFun f) ∧ ∃ C : ℝ, ∀ x, |toFun f x| ≤ C
  representative : ∀ f, (Measurable f ∧ ∃ C : ℝ, ∀ x, |f x| ≤ C) → toFun f =ᵐ[μ] f
  congr_ae : ∀ f g, (Measurable f ∧ ∃ C : ℝ, ∀ x, |f x| ≤ C) →
    (Measurable g ∧ ∃ C : ℝ, ∀ x, |g x| ≤ C) →
    f =ᵐ[μ] g → toFun f = toFun g
  map_ae_one : ∀ f, (Measurable f ∧ ∃ C : ℝ, ∀ x, |f x| ≤ C) →
    f =ᵐ[μ] (1 : X → ℝ) → toFun f = (1 : X → ℝ)
  map_add : ∀ f g, (Measurable f ∧ ∃ C : ℝ, ∀ x, |f x| ≤ C) →
    (Measurable g ∧ ∃ C : ℝ, ∀ x, |g x| ≤ C) →
    toFun (f + g) = toFun f + toFun g
  map_smul : ∀ c : ℝ, ∀ f, (Measurable f ∧ ∃ C : ℝ, ∀ x, |f x| ≤ C) →
    toFun (c • f) = c • toFun f
  map_mul : ∀ f g, (Measurable f ∧ ∃ C : ℝ, ∀ x, |f x| ≤ C) →
    (Measurable g ∧ ∃ C : ℝ, ∀ x, |g x| ≤ C) →
    toFun (f * g) = toFun f * toFun g

/--
A Souslin space is a Hausdorﬀ space that is an analytic set.
-/
class SouslinSpace (X : Type*) [TopologicalSpace X] [T2Space X] : Prop where
  analytic : AnalyticSet (univ : Set X)


/-- **Definition 3.6.8 (Lusin's property (N)).**
Let `F : X → Y` be a mapping between measure spaces `(X, 𝒜, μ)` and `(Y, ℬ, ν)`.
We say that `F` has Lusin's property (N) with respect to `(μ, ν)` if
`ν (F '' A) = 0` for every measurable set `A` satisfying `μ A = 0`.

When the two measure spaces coincide, this is Lusin's property (N) with respect
to `μ`, i.e. `MeasureTheory.HasLusinPropertyN F μ μ`. In Lean, `F` is a total
function and hence is defined everywhere.
-/
def HasLusinPropertyN {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y]
    (F : X → Y) (μ : Measure X) (ν : Measure Y) : Prop :=
  ∀ A : Set X, NullMeasurableSet A μ → μ A = 0 → ν (F '' A) = 0

/-- Lusin's property (N) for the restriction of a function to a set. -/
def HasLusinPropertyNOn {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y]
    (F : X → Y) (E : Set X) (μ : Measure X) (ν : Measure Y) : Prop :=
  ∀ A : Set X, NullMeasurableSet A μ → A ⊆ E → μ A = 0 → ν (F '' A) = 0

/-- **Theorem 3.6.9.**
Let `F : ℝⁿ → ℝⁿ` be Lebesgue measurable. Then
`MeasureTheory.HasLusinPropertyN F volume volume` holds if and only if `F`
sends every Lebesgue measurable set to a Lebesgue measurable set.
-/
theorem hasLusinPropertyN_iff_maps_nullMeasurableSet
    {n : ℕ} {F : (Fin n → ℝ) → (Fin n) → ℝ} (hF : NullMeasurable F volume) :
    HasLusinPropertyN F volume volume ↔
      ∀ A : Set (Fin n → ℝ),
        NullMeasurableSet A volume → NullMeasurableSet (F '' A) volume := by
  sorry

/-- **Proposition 5.5.4.**
Let `f` be a function on the real line and let `E` be a measurable set such
that at every point of `E` the function `f` is differentiable. Then

`λ (f(E)) ≤ ∫_E |f'(x)| dx`.

In particular, the function `f` on `E` has Lusin's property (N). If for all
`x ∈ E` we have `|f'(x)| ≤ L`, then `λ (f(E)) ≤ L * λ(E)`.
-/
theorem proposition_5_5_4
    (f : ℝ → ℝ) (E : Set ℝ) (hE : NullMeasurableSet E volume)
    (hf : ∀ x ∈ E, DifferentiableAt ℝ f x) :
    (volume (f '' E) ≤ ∫⁻ x in E, ENNReal.ofReal (abs (deriv f x)) ∂volume) ∧
      HasLusinPropertyNOn f E volume volume ∧
      ∀ L : ℝ,
        (∀ x ∈ E, abs (deriv f x) ≤ L) →
          volume (f '' E) ≤ ENNReal.ofReal L * volume E := by
  sorry

/-- **Exercise 4.7.75 (G. Hardy).**
Let `f ∈ L^p(0, +∞)`, where `1 < p < ∞`. Define, for `x > 0`,

`φ(x) = (1 / x) * ∫ t in 0..x, f t`

and

`ψ(x) = ∫ t in (x, +∞), f t / t`.

Then both `φ` and `ψ` belong to `L^p(0, +∞)`.
-/
theorem hardy_average_and_tail_memLp
    (f : ℝ → ℝ) (p : ℝ) (hp : 1 < p)
    (hf : MemLp f (ENNReal.ofReal p) (volume.restrict (Ioi (0 : ℝ)))) :
    MemLp
        (fun x : ℝ =>
          (1 / x) * (∫ t in (0 : ℝ)..x, f t ∂volume))
        (ENNReal.ofReal p) (volume.restrict (Ioi (0 : ℝ))) ∧
      MemLp
        (fun x : ℝ =>
          ∫ t in Ioi x, f t / t ∂volume)
        (ENNReal.ofReal p) (volume.restrict (Ioi (0 : ℝ))) := by
  sorry

/-- Bogachev 8.6.2, Prokhorov compactness for finite signed measures. -/
theorem bogachev_8_6_2_prokhorov_signed_measures
    {X : Type*} [MetricSpace X] [CompleteSpace X]
    [MeasurableSpace X] [BorelSpace X] (S : Set (SignedMeasure X)) :
    (SecondCountableTopology X →
      (relatively_sequentially_weakly_compact_signed S ↔
        IsTightMeasureSet ((fun s : SignedMeasure X ↦ s.totalVariation) '' S) ∧
          UniformlyBoundedInTotalVariation S)) ∧
      ((∀ s ∈ S, IsTightMeasureSet {s.totalVariation}) →
        (relatively_sequentially_weakly_compact_signed S ↔
          IsTightMeasureSet ((fun s : SignedMeasure X ↦ s.totalVariation) '' S) ∧
            UniformlyBoundedInTotalVariation S)) := by
  sorry

/--
Bogachev, *Measure Theory*, Volume I, Theorem 3.7.1:
"If `F : U → ℝⁿ` is continuously differentiable and injective on the open set
`U`, then for every measurable `A ⊂ U` and every Borel integrable function `g`,
`∫_A g(F x) |J_F(x)| dx = ∫_{F(A)} g(y) dy`."
-/
theorem bogachev_3_7_1_change_of_variables_in_Rn
    {n : ℕ} {U A : Set (Fin n → ℝ)} {F : (Fin n → ℝ) → (Fin n → ℝ)}
    {g : (Fin n → ℝ) → ℝ}
    (hU : IsOpen U) (hF : ContDiffOn ℝ 1 F U) (hinj : InjOn F U)
    (hA : NullMeasurableSet A volume) (hAU : A ⊆ U) (hg : Integrable g volume) :
    (∫ x in A, g (F x) * |(fderivWithin ℝ F U x).det| ∂volume) =
      ∫ y in F '' A, g y ∂volume := by
  sorry

/--
Bogachev, *Measure Theory*, Volume I, Theorem 4.5.9:
"Let `μ` be a finite nonnegative measure. A family `F` of `μ`-integrable
functions is uniformly integrable iff there exists a nonnegative increasing
function `G` on `[0,∞)` such that `G(t)/t → ∞` and
`sup_{f∈F} ∫ G(|f|) dμ < ∞`. In such a case `G` can be chosen convex."
-/
theorem bogachev_4_5_9_de_la_vallee_poussin
    {Ω ι : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsFiniteMeasure μ]
    {F : ι → Ω → ℝ} (hF : ∀ i : ι, Integrable (F i) μ) :
    let superlinear := fun G : ℝ → ℝ ↦
      (∀ t : ℝ, 0 ≤ t → 0 ≤ G t) ∧ MonotoneOn G (Ici (0 : ℝ)) ∧
        Tendsto (fun t : ℝ ↦ G t / t) atTop atTop
    (UniformIntegrable F 1 μ ↔
      ∃ G : ℝ → ℝ, superlinear G ∧
        ∃ C : ℝ≥0, ∀ i : ι, ∫⁻ x, ENNReal.ofReal (G |F i x|) ∂μ ≤ C) ∧
      (UniformIntegrable F 1 μ →
        ∃ G : ℝ → ℝ, superlinear G ∧ ConvexOn ℝ (Ici (0 : ℝ)) G ∧
          ∃ C : ℝ≥0, ∀ i : ι, ∫⁻ x, ENNReal.ofReal (G |F i x|) ∂μ ≤ C) := by
  sorry

/--
Bogachev, *Measure Theory*, Volume I, Theorem 4.6.3:
"Let a sequence of real measures `μₙ` be such that `limₙ μₙ(A)` exists and is
finite for every measurable set `A`. Then the pointwise limit is a measure.
Moreover, there are a finite nonnegative measure `ν` and a bounded nondecreasing
nonnegative function `α`, tending to zero at zero, such that
`|μₙ(A)| ≤ α(ν(A))` for all `n` and measurable `A`. In particular, the sequence
is uniformly bounded in total variation and uniformly countably additive. If
all `μₙ` are absolutely continuous with respect to a fixed finite nonnegative
measure, their absolute continuity is uniform."
-/
theorem bogachev_4_6_3_nikodym_vitali_hahn_saks
    {Ω : Type*} [MeasurableSpace Ω] {s : ℕ → SignedMeasure Ω}
    (hlim : ∀ A : Set Ω, MeasurableSet A →
      ∃ l : ℝ, Tendsto (fun n : ℕ ↦ s n A) atTop (𝓝 l)) :
    ∃ sLim : SignedMeasure Ω,
      (∀ A : Set Ω, MeasurableSet A →
        Tendsto (fun n : ℕ ↦ s n A) atTop (𝓝 (sLim A))) ∧
        (∃ ν : FiniteMeasure Ω, ∃ α : ℝ≥0 → ℝ≥0,
          Monotone α ∧
            (∃ C : ℝ≥0, ∀ t : ℝ≥0, α t ≤ C) ∧
              Tendsto α (𝓝 0) (𝓝 0) ∧
                ∀ n : ℕ, ∀ A : Set Ω, MeasurableSet A → |s n A| ≤ (α (ν A) : ℝ)) ∧
          UniformlyBoundedInTotalVariation (range s) ∧
            UniformlyCountablyAdditive (range s) ∧
              ∀ lam : FiniteMeasure Ω,
                (∀ n : ℕ, s n ≪ᵥ (lam : Measure Ω).toENNRealVectorMeasure) →
                  UniformlyAbsolutelyContinuous (range s) (lam : Measure Ω) := by
  sorry

/-- Bogachev 9.12.37, simultaneous transport of finitely many atomless measures. -/
theorem bogachev_9_12_37_simultaneous_transport
    {X : Type*} [MeasurableSpace X] [TopologicalSpace X] [T2Space X] [SouslinSpace X]
    [BorelSpace X] {n : ℕ} (μ : Fin n → Measure X) [∀ i, IsProbabilityMeasure (μ i)]
    (ν : Measure X) [IsProbabilityMeasure ν]
    (hμ : ∀ i, is_atomless_measure (μ i)) :
    ∃ T : X → X, ∀ i, MeasurePreserving T (μ i) ν := by
  sorry

/-- Bogachev 10.5.4, existence of a lifting for every complete probability measure. -/
theorem bogachev_10_5_4_lifting {X : Type*} [MeasurableSpace X] (μ : Measure X)
    [IsProbabilityMeasure μ] [μ.IsComplete] : Nonempty (LInfinityLifting μ) := by
  sorry

/--
Bogachev, *Measure Theory*, Volume II, Theorem 9.1.9:
"Let `f : X → Y` and let `ν` be a Radon signed measure on `Y`. Suppose there is
an increasing sequence of compact sets `Kₙ ⊂ X` such that `f` is continuous on
each `Kₙ` and `limₙ |ν|(f(Kₙ)) = ‖ν‖`. Then there exists a Radon signed measure
`μ` on `X` with `μ ∘ f⁻¹ = ν`, and it can be chosen with `‖μ‖ = ‖ν‖`."
-/
theorem bogachev_9_1_9_radon_preimage_from_compact_approximation
    {X Y : Type*} [TopologicalSpace X] [MeasurableSpace X] [BorelSpace X]
    [TopologicalSpace Y] [MeasurableSpace Y] [BorelSpace Y]
    {f : X → Y} {ν : SignedMeasure Y} (hν : Measure.InnerRegular ν.totalVariation)
    (K : ℕ → Set X) :
    (Monotone K → (∀ n, IsCompact (K n)) → (∀ n, ContinuousOn f (K n)) →
      Tendsto (fun n ↦ ν.totalVariation (f '' K n)) atTop (𝓝 (ν.totalVariation univ)) →
      ∃ μ : SignedMeasure X, Measure.InnerRegular μ.totalVariation ∧
        μ.totalVariation univ = ν.totalVariation univ ∧
          ∀ A : Set Y, MeasurableSet A → ∃ B : Set X, MeasurableSet B ∧
            (∀ᵐ x ∂μ.totalVariation, x ∈ B ↔ x ∈ f ⁻¹' A) ∧ μ B = ν A) ∧
      (CompactSpace X → CompactSpace Y → Continuous f → Function.Surjective f →
        ∃ μ : SignedMeasure X, Measure.InnerRegular μ.totalVariation ∧
          μ.totalVariation univ = ν.totalVariation univ ∧
            ∀ A : Set Y, MeasurableSet A → ∃ B : Set X, MeasurableSet B ∧
              (∀ᵐ x ∂μ.totalVariation, x ∈ B ↔ x ∈ f ⁻¹' A) ∧ μ B = ν A) := by
  sorry

end Bogachev
end Dataset
