module

import Mathlib.Geometry.Manifold.Algebra.LieGroup
import Mathlib.Geometry.Manifold.ContMDiffMFDeriv
import Mathlib.Geometry.Manifold.Immersion
import Mathlib.Geometry.Manifold.SmoothApprox
import Mathlib.Geometry.Manifold.Submersion
import Mathlib.Geometry.Manifold.WhitneyEmbedding
import Mathlib.MeasureTheory.Measure.Haar.NormedSpace

/-!
# Hard smooth-manifold statements from Lee

Ten statement-only formalizations selected from John M. Lee,
*Introduction to Smooth Manifolds*.
-/

open Function MeasureTheory Set Topology

open scoped ContDiff Manifold Topology

namespace Dataset
namespace LeeSmoothManifolds

universe u v

/-- A smooth (Fin diffeomorphism → ℝ) between two subsets. -/
structure SmoothDiffeomorphismOn {m n : ℕ} (U : Set ((Fin m → ℝ)))
    (V : Set ((Fin n → ℝ))) where
  toFun : (Fin m → ℝ) → (Fin n → ℝ)
  invFun : (Fin n → ℝ) → (Fin m → ℝ)
  mapsTo : MapsTo toFun U V
  invMapsTo : MapsTo invFun V U
  leftInvOn : Set.LeftInvOn invFun toFun U
  rightInvOn : Set.RightInvOn invFun toFun V
  smooth : ContDiffOn ℝ ⊤ toFun U
  smooth_inv : ContDiffOn ℝ ⊤ invFun V

/-- The rank of the Frechet derivative is constantly `k` on `U`. -/
def EuclideanConstantRank {m n : ℕ} (U : Set ((Fin m → ℝ)))
    (F : (Fin m → ℝ) → (Fin n → ℝ)) (k : ℕ) : Prop :=
  ∀ x ∈ U, Module.finrank ℝ (LinearMap.range (fderiv ℝ F x).toLinearMap) = k

/-- Constant rank of the manifold derivative. -/
def ConstantRank {m n : ℕ} {M : Type u} {N : Type v}
    [TopologicalSpace M] [ChartedSpace ((Fin m → ℝ)) M]
    [TopologicalSpace N] [ChartedSpace ((Fin n → ℝ)) N]
    (F : M → N) (k : ℕ) : Prop :=
  ∀ p : M,
    Module.finrank ℝ
      (LinearMap.range
        (mfderiv 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin n → ℝ)) F p).toLinearMap) = k

/-- An embedded submanifold in local slice coordinates. -/
def EmbeddedSubmanifoldOfCodimension {m : ℕ} {M : Type u}
    [TopologicalSpace M] [ChartedSpace ((Fin m → ℝ)) M]
    (S : Set M) (codim : ℕ) : Prop :=
  ∀ p ∈ S,
    ∃ φ : OpenPartialHomeomorph M ((Fin m → ℝ)),
      φ ∈ IsManifold.maximalAtlas 𝓘(ℝ, (Fin m → ℝ)) ∞ M ∧ p ∈ φ.source ∧
      φ '' (S ∩ φ.source) =
        {x ∈ φ.target | ∀ i : Fin m, m - codim ≤ i.1 → x i = 0}

/-- A regular value: the map is a submersion at every point of its fiber. -/
def RegularValue {m n : ℕ} {M : Type u} {N : Type v}
    [TopologicalSpace M] [ChartedSpace ((Fin m → ℝ)) M]
    [TopologicalSpace N] [ChartedSpace ((Fin n → ℝ)) N]
    (F : M → N) (c : N) : Prop :=
  ∀ p, F p = c →
    Manifold.IsSubmersionAt 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin n → ℝ)) ∞ F p

/-- A smooth free proper action, including the group-action laws. -/
def SmoothFreeProperAction {g m : ℕ} {G : Type u} {M : Type v}
    [Group G] [TopologicalSpace G] [ChartedSpace ((Fin g → ℝ)) G]
    [TopologicalSpace M] [ChartedSpace ((Fin m → ℝ)) M]
    (act : G → M → M) : Prop :=
  (∀ x, act 1 x = x) ∧ (∀ a b x, act (a * b) x = act a (act b x)) ∧
    ContMDiff (𝓘(ℝ, (Fin g → ℝ)).prod 𝓘(ℝ, (Fin m → ℝ)))
      𝓘(ℝ, (Fin m → ℝ)) ∞ (fun p : G × M ↦ act p.1 p.2) ∧
    (∀ a x, act a x = x → a = 1) ∧
    IsProperMap fun p : G × M ↦ (act p.1 p.2, p.2)

/-- A vector normal to every velocity of a curve in the submanifold. -/
def IsNormalVector {n : ℕ} (M : Set ((Fin n → ℝ)))
    (x v : (Fin n → ℝ)) : Prop :=
  x ∈ M ∧ ∀ γ : ℝ → (Fin n → ℝ), ∀ velocity : (Fin n → ℝ),
    γ 0 = x → (∀ᶠ t in 𝓝 0, γ t ∈ M) → HasDerivAt γ velocity 0 →
      ∑ i, v i * velocity i = 0

/-- The variable-radius normal disk bundle of an embedded (Fin submanifold → ℝ). -/
def NormalDiskBundle {n : ℕ} (M : Set ((Fin n → ℝ)))
    (radius : M → ℝ) : Set (M × (Fin n → ℝ)) :=
  {p | IsNormalVector M p.1 p.2 ∧ ‖p.2‖ < radius p.1}

/-- Lee 7.6, the inverse function theorem. -/
theorem lee_7_6_inverse_function_theorem
    {n : ℕ} {U V : Set ((Fin n → ℝ))} {F : (Fin n → ℝ) → (Fin n → ℝ)}
    {p : (Fin n → ℝ)} (hU : IsOpen U) (hV : IsOpen V)
    (hF : MapsTo F U V ∧ ContDiffOn ℝ ⊤ F U) (hp : p ∈ U)
    (hD : Function.Bijective (fderiv ℝ F p)) :
    ∃ U₀ V₀,
      (IsOpen U₀ ∧ IsConnected U₀ ∧ p ∈ U₀ ∧ U₀ ⊆ U) ∧
      (IsOpen V₀ ∧ IsConnected V₀ ∧ F p ∈ V₀ ∧ V₀ ⊆ V) ∧
      ∃ e : SmoothDiffeomorphismOn U₀ V₀, e.toFun = F := by
  sorry

/-- Lee 7.8, the (Fin rank → ℝ) theorem. -/
theorem lee_7_8_rank_theorem
    {m n k : ℕ} {U : Set ((Fin m → ℝ))} {V : Set ((Fin n → ℝ))}
    {F : (Fin m → ℝ) → (Fin n → ℝ)} {p : (Fin m → ℝ)}
    (hU : IsOpen U) (hV : IsOpen V) (hF : MapsTo F U V ∧ ContDiffOn ℝ ⊤ F U)
    (hp : p ∈ U)
    (hk : k ≤ m ∧ k ≤ n) (hrank : EuclideanConstantRank U F k) :
    ∃ U₀ V₀, (IsOpen U₀ ∧ IsConnected U₀ ∧ p ∈ U₀ ∧ U₀ ⊆ U) ∧
      (IsOpen V₀ ∧ IsConnected V₀ ∧ F p ∈ V₀ ∧ V₀ ⊆ V) ∧
      MapsTo F U₀ V₀ ∧
      ∃ (sourceTarget : Set (Fin m → ℝ)) (targetTarget : Set (Fin n → ℝ))
        (φ : SmoothDiffeomorphismOn U₀ sourceTarget)
        (ψ : SmoothDiffeomorphismOn V₀ targetTarget),
        ∀ x ∈ φ.toFun '' U₀, ψ.toFun (F (φ.invFun x)) =
          fun i ↦ if h : i.1 < k ∧ i.1 < m then x ⟨i.1, h.2⟩ else 0 := by
  sorry

/-- Lee 7.13, the rank theorem for manifolds. -/
theorem lee_7_13_rank_theorem_for_manifolds
    {m n k : ℕ} {M : Type u} {N : Type v}
    [TopologicalSpace M] [ChartedSpace ((Fin m → ℝ)) M]
    [IsManifold 𝓘(ℝ, (Fin m → ℝ)) ∞ M]
    [TopologicalSpace N] [ChartedSpace ((Fin n → ℝ)) N]
    [IsManifold 𝓘(ℝ, (Fin n → ℝ)) ∞ N]
    {F : M → N} (hF : ContMDiff 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin n → ℝ)) ∞ F)
    (hk : k ≤ m ∧ k ≤ n) (hrank : ConstantRank (m := m) (n := n) F k) :
    ∀ p, ∃ (φ : OpenPartialHomeomorph M (Fin m → ℝ))
      (ψ : OpenPartialHomeomorph N (Fin n → ℝ)),
      φ ∈ IsManifold.maximalAtlas 𝓘(ℝ, (Fin m → ℝ)) ∞ M ∧
      ψ ∈ IsManifold.maximalAtlas 𝓘(ℝ, (Fin n → ℝ)) ∞ N ∧
      p ∈ φ.source ∧ F p ∈ ψ.source ∧ MapsTo F φ.source ψ.source ∧
      ∀ x ∈ φ.target, ψ (F (φ.symm x)) =
        fun i ↦ if h : i.1 < k ∧ i.1 < m then x ⟨i.1, h.2⟩ else 0 := by
  sorry

/-- Lee 8.8, the constant-rank level-set theorem. -/
theorem lee_8_8_constant_rank_level_set_theorem
    {m n k : ℕ} {M : Type u} {N : Type v}
    [TopologicalSpace M] [ChartedSpace ((Fin m → ℝ)) M]
    [IsManifold 𝓘(ℝ, (Fin m → ℝ)) ∞ M]
    [TopologicalSpace N] [ChartedSpace ((Fin n → ℝ)) N]
    [IsManifold 𝓘(ℝ, (Fin n → ℝ)) ∞ N]
    {Φ : M → N} (hΦ : ContMDiff 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin n → ℝ)) ∞ Φ)
    (hrank : ConstantRank (m := m) (n := n) Φ k) :
    ∀ c, IsClosed {p | Φ p = c} ∧
      EmbeddedSubmanifoldOfCodimension (m := m) {p | Φ p = c} k := by
  sorry

/-- Lee 8.10, the regular level-set theorem. -/
theorem lee_8_10_regular_level_set_theorem
    {m n : ℕ} {M : Type u} {N : Type v}
    [TopologicalSpace M] [ChartedSpace ((Fin m → ℝ)) M]
    [IsManifold 𝓘(ℝ, (Fin m → ℝ)) ∞ M]
    [TopologicalSpace N] [ChartedSpace ((Fin n → ℝ)) N]
    [IsManifold 𝓘(ℝ, (Fin n → ℝ)) ∞ N]
    {Φ : M → N} {c : N}
    (hΦ : ContMDiff 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin n → ℝ)) ∞ Φ)
    (hc : RegularValue (m := m) (n := n) Φ c) :
    IsClosed {p | Φ p = c} ∧
      EmbeddedSubmanifoldOfCodimension (m := m) {p | Φ p = c} n := by
  sorry

/-- Lee 9.16, the quotient-manifold theorem. -/
theorem lee_9_16_quotient_manifold_theorem
    {g m : ℕ} {G : Type u} {M : Type v} [Group G]
    [TopologicalSpace G] [ChartedSpace ((Fin g → ℝ)) G]
    [LieGroup 𝓘(ℝ, (Fin g → ℝ)) ∞ G]
    [TopologicalSpace M] [ChartedSpace ((Fin m → ℝ)) M]
    [IsManifold 𝓘(ℝ, (Fin m → ℝ)) ∞ M]
    {act : G → M → M} (haction : SmoothFreeProperAction (g := g) (m := m) act) :
    ∃ (Q : Type v) (_ : TopologicalSpace Q) (_ : ChartedSpace (Fin (m - g) → ℝ) Q)
      (_ : IsManifold 𝓘(ℝ, (Fin (m - g) → ℝ)) ∞ Q) (π : M → Q),
      Surjective π ∧ (∀ x y, π x = π y ↔ ∃ a, act a x = y) ∧
      Manifold.IsSubmersion 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin (m - g) → ℝ)) ∞ π ∧
      ∀ (Q' : Type v) (_ : TopologicalSpace Q')
        (_ : ChartedSpace (Fin (m - g) → ℝ) Q')
        (_ : IsManifold 𝓘(ℝ, (Fin (m - g) → ℝ)) ∞ Q') (π' : M → Q'),
        Surjective π' → (∀ x y, π' x = π' y ↔ ∃ a, act a x = y) →
        Manifold.IsSubmersion 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin (m - g) → ℝ)) ∞
          π' →
        ∃ e : Diffeomorph 𝓘(ℝ, (Fin (m - g) → ℝ)) 𝓘(ℝ, (Fin (m - g) → ℝ))
          Q Q' ∞, e ∘ π = π' := by
  sorry

/-- Lee 10.7, Sard's theorem. -/
theorem lee_10_7_sards_theorem
    {m n : ℕ} {M : Type u} {N : Type v}
    [TopologicalSpace M] [ChartedSpace ((Fin m → ℝ)) M]
    [IsManifold 𝓘(ℝ, (Fin m → ℝ)) ∞ M]
    [TopologicalSpace N] [ChartedSpace ((Fin n → ℝ)) N]
    [IsManifold 𝓘(ℝ, (Fin n → ℝ)) ∞ N]
    {F : M → N} (hF : ContMDiff 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin n → ℝ)) ∞ F) :
    let critical := {p : M |
      ¬Manifold.IsSubmersionAt 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin n → ℝ)) ∞ F p}
    ∀ ψ : OpenPartialHomeomorph N (Fin n → ℝ),
      ψ ∈ IsManifold.maximalAtlas 𝓘(ℝ, (Fin n → ℝ)) ∞ N →
        volume (ψ '' (F '' critical ∩ ψ.source)) = 0 := by
  sorry

/-- Lee 10.11, the weak Whitney embedding theorem. -/
theorem lee_10_11_whitney_embedding_theorem
    {m : ℕ} {M : Type u} [TopologicalSpace M] [ChartedSpace ((Fin m → ℝ)) M]
    [IsManifold 𝓘(ℝ, (Fin m → ℝ)) ∞ M] [T2Space M] [SigmaCompactSpace M] :
    ∃ F : M → (Fin (2 * m + 1) → ℝ),
      IsProperMap F ∧ IsEmbedding F ∧
        ContMDiff 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin (2 * m + 1) → ℝ)) ∞ F := by
  sorry

/-- Lee 10.16, the relative Whitney approximation theorem. -/
theorem lee_10_16_whitney_approximation_theorem
    {m k : ℕ} {M : Type u} [TopologicalSpace M] [ChartedSpace ((Fin m → ℝ)) M]
    [IsManifold 𝓘(ℝ, (Fin m → ℝ)) ∞ M] [T2Space M] [SigmaCompactSpace M]
    {F : M → (Fin k → ℝ)} {δ : M → ℝ} {A : Set M}
    (hF : Continuous F) (hδ : Continuous δ) (hδpos : ∀ x, 0 < δ x)
    (hA : IsClosed A) (hFsmoothOnA : ∃ U ∈ 𝓝ˢ A,
      ContMDiffOn 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin k → ℝ)) ∞ F U) :
    ∃ Fsmooth : M → (Fin k → ℝ),
      ContMDiff 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin k → ℝ)) ∞ Fsmooth ∧
        (∀ x, dist (Fsmooth x) (F x) < δ x) ∧ EqOn Fsmooth F A := by
  sorry

/-- Lee 10.19, the tubular-neighborhood theorem. -/
theorem lee_10_19_tubular_neighborhood_theorem
    {n codim : ℕ} {M : Set ((Fin n → ℝ))}
    (hM : EmbeddedSubmanifoldOfCodimension (m := n) M codim) :
    ∃ (radius : M → ℝ) (U : Set (Fin n → ℝ)),
      (∀ x, 0 < radius x) ∧ IsOpen U ∧ M ⊆ U ∧
      ∃ inverse : (Fin n → ℝ) → M × (Fin n → ℝ),
        Set.BijOn (fun p : M × (Fin n → ℝ) ↦ (p.1 : (Fin n → ℝ)) + p.2)
          (NormalDiskBundle M radius) U ∧
        ContinuousOn inverse U ∧
        ContDiffOn ℝ ⊤ (fun z ↦ ((inverse z).1 : (Fin n → ℝ))) U ∧
        ContDiffOn ℝ ⊤ (fun z ↦ (inverse z).2) U ∧
        ∀ p ∈ NormalDiskBundle M radius, inverse ((p.1 : (Fin n → ℝ)) + p.2) = p := by
  sorry

end LeeSmoothManifolds
end Dataset
