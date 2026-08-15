module

public import Mathlib.Analysis.Calculus.ContDiff.Basic
public import Mathlib.Analysis.Convex.Function
public import Mathlib.Analysis.Normed.Module.FiniteDimension
public import Mathlib.MeasureTheory.Constructions.Polish.Basic
public import Mathlib.MeasureTheory.Function.UniformIntegrable
public import Mathlib.MeasureTheory.Integral.Prod
public import Mathlib.MeasureTheory.Measure.NullMeasurable
public import Mathlib.MeasureTheory.Measure.ProbabilityMeasure
public import Mathlib.MeasureTheory.Measure.Regular
public import Mathlib.MeasureTheory.Measure.Tight
public import Mathlib.MeasureTheory.VectorMeasure.Basic
public import Mathlib.MeasureTheory.VectorMeasure.Decomposition.Jordan

/-!
# Shared definitions for the Bogachev problems

Custom notions used by the statement files in `Dataset/Bogachev/` that are
not already supplied by Mathlib. Each problem file that needs them imports
this module.
-/

@[expose] public section

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
  ⨆ s : S, (s : SignedMeasure Ω).totalVariation univ < ∞

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

end Bogachev
end Dataset
