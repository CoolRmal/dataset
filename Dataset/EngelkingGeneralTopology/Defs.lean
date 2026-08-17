import Mathlib.Topology.DenseEmbedding
import Mathlib.Topology.PartitionOfUnity
import Mathlib.Topology.Separation.CompletelyRegular

/-!
# Shared definitions for the EngelkingGeneralTopology problems

Custom notions used by the statement files in `Dataset/EngelkingGeneralTopology/` that are
not already supplied by Mathlib. Each problem file that needs them imports
this module.
-/

open Set TopologicalSpace Topology

namespace Dataset
namespace EngelkingGeneralTopology

universe u v w

/-- A concrete compactification: an embedding with dense image into a compact space. -/
def IsCompactification {X : Type u} {K : Type v} [TopologicalSpace X]
    [TopologicalSpace K] (e : X → K) : Prop :=
  IsDenseEmbedding e ∧ CompactSpace K ∧ T2Space K

/-- Two compactifications are equivalent when a homeomorphism commutes with their embeddings. -/
def EquivalentCompactifications {X : Type u} {K L : Type v} [TopologicalSpace X]
    [TopologicalSpace K] [TopologicalSpace L] (e : X → K) (f : X → L) : Prop :=
  ∃ h : K ≃ₜ L, h ∘ e = f

/-- Engelking's definition of a realcompact space: no proper Tychonoff extension of the
space permits the extension of every continuous real-valued function. -/
def IsRealcompact (X : Type u) [tX : TopologicalSpace X] : Prop :=
  T35Space X ∧ ¬∃ (Y : Type (u + 1)) (tY : TopologicalSpace Y),
    @T35Space Y tY ∧ ∃ r : X → Y,
      @IsEmbedding X Y tX tY r ∧ range r ≠ closure (range r) ∧
        closure (range r) = univ ∧
          ∀ f : X → ℝ, Continuous f →
            ∃ g : Y → ℝ, @Continuous Y ℝ tY _ g ∧ g ∘ r = f

/-- A family of sets is discrete: every point has a neighborhood meeting at most one member. -/
def IsDiscreteFamily {X : Type u} [TopologicalSpace X] {ι : Type v}
    (U : ι → Set X) : Prop :=
  ∀ x : X, ∃ V ∈ 𝓝 x, {i : ι | (V ∩ U i).Nonempty}.Subsingleton

/-- An indexed family is an open cover. (Deliberately `Set`-valued and indexed, matching the
book's families `{U_s}`; mathlib's `TopologicalSpace.IsOpenCover` is `Opens`-valued.) -/
def IsOpenCover {X : Type u} [TopologicalSpace X] {ι : Type v}
    (U : ι → Set X) : Prop :=
  (∀ i, IsOpen (U i)) ∧ ⋃ i, U i = univ

/-- One indexed family refines another when each member lies in some member of the latter. -/
def Refines {X : Type u} {ι : Type v} {κ : Type w} (V : κ → Set X)
    (U : ι → Set X) : Prop :=
  ∀ j, ∃ i, V j ⊆ U i

/-- An indexed family is a closed cover. -/
def IsClosedCover {X : Type u} [TopologicalSpace X] {ι : Type v}
    (F : ι → Set X) : Prop :=
  (∀ i, IsClosed (F i)) ∧ ⋃ i, F i = univ

/-- A family is star-finite when each member meets only finitely many members. -/
def IsStarFiniteFamily {X : Type u} {ι : Type v} (A : ι → Set X) : Prop :=
  ∀ i, {j | (A i ∩ A j).Nonempty}.Finite

/-- A family is star-countable when each member meets only countably many members. -/
def IsStarCountableFamily {X : Type u} {ι : Type v} (A : ι → Set X) : Prop :=
  ∀ i, {j | (A i ∩ A j).Nonempty}.Countable

/-- Engelking's definition of countable paracompactness. -/
def IsCountablyParacompact (X : Type u) [TopologicalSpace X] : Prop :=
  T2Space X ∧
    ∀ (ι : Type u) (_ : Countable ι) (U : ι → Set X), IsOpenCover U →
      ∃ (κ : Type u) (V : κ → Set X), IsOpenCover V ∧ Refines V U ∧ LocallyFinite V

/-- Engelking's definition of strong paracompactness. -/
def IsStronglyParacompact (X : Type u) [TopologicalSpace X] : Prop :=
  T2Space X ∧
    ∀ (ι : Type u) (U : ι → Set X), IsOpenCover U →
      ∃ (κ : Type u) (V : κ → Set X),
        IsOpenCover V ∧ Refines V U ∧ IsStarFiniteFamily V

/-- A base which is the union of countably many locally finite families. -/
def HasSigmaLocallyFiniteBase (X : Type u) [TopologicalSpace X] : Prop :=
  ∃ (ι : ℕ → Type u) (B : ∀ n, ι n → Set X),
    IsTopologicalBasis {V : Set X | ∃ n i, B n i = V} ∧
      ∀ n, LocallyFinite (B n)

/-- A base which is the union of countably many discrete families. -/
def HasSigmaDiscreteBase (X : Type u) [TopologicalSpace X] : Prop :=
  ∃ (ι : ℕ → Type u) (B : ∀ n, ι n → Set X),
    IsTopologicalBasis {V : Set X | ∃ n i, B n i = V} ∧
      ∀ n, IsDiscreteFamily (B n)

/-- At most `n + 1` members of a cover contain any one point. -/
def CoverOrderLE {X : Type u} {ι : Type v} (U : ι → Set X) (n : ℕ) : Prop :=
  ∀ x : X, ∀ s : Finset ι, (∀ i ∈ s, x ∈ U i) → s.card ≤ n + 1

/-- Covering dimension at most `n`, stated using finite open refinements. -/
def CoveringDimensionLE (X : Type u) [TopologicalSpace X] (n : ℕ) : Prop :=
  ∀ (m : ℕ) (U : Fin m → Set X), IsOpenCover U →
    ∃ (k : ℕ) (V : Fin k → Set X),
      IsOpenCover V ∧ Refines V U ∧ CoverOrderLE V n

/-- A proximity relation in the sense of Smirnov. -/
structure Proximity (X : Type u) [TopologicalSpace X] where
  close : Set X → Set X → Prop
  empty_left : ∀ A, ¬close ∅ A
  intersects : ∀ A B, (A ∩ B).Nonempty → close A B
  symmetric : ∀ A B, close A B ↔ close B A
  union_left : ∀ A B C, close (A ∪ B) C ↔ close A C ∨ close B C
  strong : ∀ A B, ¬close A B → ∃ E : Set X, ¬close A E ∧ ¬close Eᶜ B
  closure_eq : ∀ A : Set X, closure A = {x | close {x} A}

/-- The proximity induced by taking intersecting closures in a compactification. -/
def IsAssignedProximity {X : Type u} {K : Type v} [TopologicalSpace X]
    [TopologicalSpace K] (e : X → K) (p : Proximity X) : Prop :=
  ∀ A B : Set X,
    p.close A B ↔ (closure (e '' A) ∩ closure (e '' B)).Nonempty

end EngelkingGeneralTopology
end Dataset
