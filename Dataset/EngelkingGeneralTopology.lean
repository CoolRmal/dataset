module

import Mathlib.Topology.Compactness.Compact
import Mathlib.Topology.Compactness.Paracompact
import Mathlib.Topology.ContinuousMap.Compact
import Mathlib.Topology.LocallyFinite
import Mathlib.Topology.Metrizable.Basic
import Mathlib.Topology.PartitionOfUnity
import Mathlib.Topology.Compactification.StoneCech
import Mathlib.Topology.Separation.CompletelyRegular
import Mathlib.Tactic.TFAE

/-!
# Hard general-topology statements from Engelking

Ten statement-only formalizations selected from Ryszard Engelking, *General Topology*.
-/

open Function Set TopologicalSpace Topology

namespace Dataset
namespace EngelkingGeneralTopology

universe u v w

/-- A concrete compactification: an embedding with dense image into a compact space. -/
def IsCompactification {X : Type u} {K : Type v} [TopologicalSpace X]
    [TopologicalSpace K] (e : X → K) : Prop :=
  IsEmbedding e ∧ DenseRange e ∧ IsCompact (univ : Set K) ∧ T2Space K

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

/-- An indexed family is an open cover. -/
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
    ∀ (ι : Type v) (_ : Countable ι) (U : ι → Set X), IsOpenCover U →
      ∃ (κ : Type v) (V : κ → Set X), IsOpenCover V ∧ Refines V U ∧ LocallyFinite V

/-- Engelking's definition of strong paracompactness. -/
def IsStronglyParacompact (X : Type u) [TopologicalSpace X] : Prop :=
  T2Space X ∧
    ∀ (ι : Type v) (U : ι → Set X), IsOpenCover U →
      ∃ (κ : Type v) (V : κ → Set X),
        IsOpenCover V ∧ Refines V U ∧ IsStarFiniteFamily V

/-- A base which is the union of countably many locally finite families. -/
def HasSigmaLocallyFiniteBase (X : Type u) [TopologicalSpace X] : Prop :=
  ∃ (ι : ℕ → Type v) (B : ∀ n, ι n → Set X),
    IsTopologicalBasis {V : Set X | ∃ n i, B n i = V} ∧
      ∀ n, LocallyFinite (B n)

/-- A base which is the union of countably many discrete families. -/
def HasSigmaDiscreteBase (X : Type u) [TopologicalSpace X] : Prop :=
  ∃ (ι : ℕ → Type v) (B : ∀ n, ι n → Set X),
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

/-- Engelking 3.11.16, existence and uniqueness of the Hewitt realcompactification. -/
theorem engelking_3_11_16_hewitt_realcompactification
    {X : Type u} [TopologicalSpace X] [T35Space X] :
    ∃ (Y : Type u) (tY : TopologicalSpace Y) (ν : X → Y),
      @IsRealcompact Y tY ∧ @IsEmbedding X Y _ tY ν ∧ closure (range ν) = univ ∧
        (∀ f : X → ℝ, Continuous f →
          ∃ g : Y → ℝ, @Continuous Y ℝ tY _ g ∧ g ∘ ν = f) ∧
        (∀ (Z : Type u) (tZ : TopologicalSpace Z), @IsRealcompact Z tZ →
          ∀ f : X → Z, @Continuous X Z _ tZ f →
            ∃ g : Y → Z, @Continuous Y Z tY tZ g ∧ g ∘ ν = f) ∧
        ∀ (Z : Type u) (tZ : TopologicalSpace Z) (ζ : X → Z),
          @IsRealcompact Z tZ → @IsEmbedding X Z _ tZ ζ → closure (range ζ) = univ →
          (∀ f : X → ℝ, Continuous f →
            ∃ g : Z → ℝ, @Continuous Z ℝ tZ _ g ∧ g ∘ ζ = f) →
          ∃ h : @Homeomorph Y Z tY tZ, h ∘ ν = ζ := by
  sorry

/-- Engelking 5.2.8, normality of a product with the closed unit interval. -/
theorem engelking_5_2_8_normal_product_interval
    {X : Type u} [TopologicalSpace X] [T1Space X] :
    (NormalSpace X ∧ IsCountablyParacompact X) ↔
      NormalSpace (X × Set.Icc (0 : ℝ) 1) := by
  sorry

/-- Engelking 5.3.10, four characterizations of strong paracompactness. -/
theorem engelking_5_3_10_strong_paracompactness
    {X : Type u} [TopologicalSpace X] [RegularSpace X] [T1Space X] :
    let closedLocallyFiniteStarFinite :=
      ∀ (ι : Type v) (U : ι → Set X), IsOpenCover U →
        ∃ (κ : Type v) (F : κ → Set X),
          IsClosedCover F ∧ Refines F U ∧ LocallyFinite F ∧ IsStarFiniteFamily F
    let closedLocallyFiniteStarCountable :=
      ∀ (ι : Type v) (U : ι → Set X), IsOpenCover U →
        ∃ (κ : Type v) (F : κ → Set X),
          IsClosedCover F ∧ Refines F U ∧ LocallyFinite F ∧ IsStarCountableFamily F
    let starCountableOpen := ∀ (ι : Type v) (U : ι → Set X), IsOpenCover U →
      ∃ (κ : Type v) (V : κ → Set X),
        IsOpenCover V ∧ Refines V U ∧ IsStarCountableFamily V
    List.TFAE [IsStronglyParacompact X, closedLocallyFiniteStarFinite,
      closedLocallyFiniteStarCountable, starCountableOpen] := by
  sorry

/-- Engelking 4.4.1, Stone's open-refinement theorem. -/
theorem engelking_4_4_1_stone_open_refinement
    {X : Type u} [TopologicalSpace X] [MetrizableSpace X] :
    ∀ (ι : Type v) (U : ι → Set X), IsOpenCover U →
      ∃ (κ : Type w) (V : κ → Set X) (level : κ → ℕ),
        IsOpenCover V ∧ Refines V U ∧ LocallyFinite V ∧
          ∀ n, IsDiscreteFamily fun j : {j : κ // level j = n} ↦ V j := by
  sorry

/-- Engelking 4.4.7, the Nagata-Smirnov metrization theorem. -/
theorem engelking_4_4_7_nagata_smirnov_metrization
    {X : Type u} [TopologicalSpace X] [T1Space X] :
    MetrizableSpace X ↔ RegularSpace X ∧ HasSigmaLocallyFiniteBase X := by
  sorry

/-- Engelking 4.4.8, the Bing metrization theorem. -/
theorem engelking_4_4_8_bing_metrization
    {X : Type u} [TopologicalSpace X] [T1Space X] :
    MetrizableSpace X ↔ RegularSpace X ∧ HasSigmaDiscreteBase X := by
  sorry

/-- Engelking 5.1.9, paracompactness via partitions of unity. -/
theorem engelking_5_1_9_paracompact_partition_of_unity
    {X : Type u} [TopologicalSpace X] [T1Space X] :
    let locallyFinitePartition := ∀ (ι : Type v) (U : ι → Set X), IsOpenCover U →
      ∃ ρ : PartitionOfUnity ι X, ρ.IsSubordinate U
    let partition := ∀ (ι : Type v) (U : ι → Set X), IsOpenCover U →
      ∃ ρ : ι → C(X, ℝ), 0 ≤ ρ ∧ (∀ x, HasSum (fun i ↦ ρ i x) 1) ∧
        ∀ i, tsupport (ρ i) ⊆ U i
    List.TFAE [ParacompactSpace X, locallyFinitePartition, partition] := by
  sorry

/-- Engelking 5.1.38, Tamano's theorem. -/
theorem engelking_5_1_38_tamano_theorem
    {X : Type u} [tX : TopologicalSpace X] [T35Space X] :
    let everyCompactification := ∀ (K : Type v) (tK : TopologicalSpace K) (e : X → K),
      @IsCompactification X K tX tK e →
        @NormalSpace (X × K) (tX.induced Prod.fst ⊓ tK.induced Prod.snd) ∧ T1Space (X × K)
    let someCompactification := ∃ (K : Type v) (tK : TopologicalSpace K) (e : X → K),
      @IsCompactification X K tX tK e ∧
        @NormalSpace (X × K) (tX.induced Prod.fst ⊓ tK.induced Prod.snd) ∧ T1Space (X × K)
    List.TFAE [ParacompactSpace X, everyCompactification,
      NormalSpace (X × StoneCech X) ∧ T1Space (X × StoneCech X), someCompactification] := by
  sorry

/-- Engelking 7.2.1, the countable sum theorem for covering dimension. -/
theorem engelking_7_2_1_countable_sum_theorem
    {X : Type u} [TopologicalSpace X] [NormalSpace X] {n : ℕ}
    (hcover : ∃ F : ℕ → Set X, (∀ j, IsClosed (F j)) ∧ ⋃ j, F j = univ ∧
      ∀ j, CoveringDimensionLE (F j) n) :
    CoveringDimensionLE X n := by
  sorry

/-- Engelking 8.4.13, Smirnov's compactification-proximity correspondence. -/
theorem engelking_8_4_13_smirnov_proximity_compactification
    {X : Type u} [TopologicalSpace X] [T35Space X] :
    (∀ (K : Type v) (tK : TopologicalSpace K) (e : X → K),
      @IsCompactification X K _ tK e →
        ∃ p : Proximity X, @IsAssignedProximity X K _ tK e p) ∧
    (∀ p : Proximity X, ∃ (K : Type v) (_ : TopologicalSpace K) (e : X → K),
      IsCompactification e ∧ IsAssignedProximity e p) ∧
    ∀ (K L : Type v) (_ : TopologicalSpace K) (_ : TopologicalSpace L)
      (e : X → K) (f : X → L) (p : Proximity X),
        IsCompactification e → IsCompactification f →
        IsAssignedProximity e p → IsAssignedProximity f p →
        EquivalentCompactifications e f := by
  sorry

end EngelkingGeneralTopology
end Dataset
