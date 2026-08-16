import Dataset.LeeSmoothManifolds.Defs

/-!
# `lee_8_8_constant_rank_level_set_theorem`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `lee_8_8_constant_rank_level_set_theorem.md`.
Quality rubric: `lee_8_8_constant_rank_level_set_theorem.criteria.md`.
-/

open scoped ContDiff Manifold

namespace Dataset
namespace LeeSmoothManifolds

universe u v

/-- Lee 8.8, the constant-rank level-set theorem. -/
theorem lee_8_8_constant_rank_level_set_theorem
    {m n k : ℕ} {M : Type u} {N : Type v}
    [TopologicalSpace M] [ChartedSpace ((Fin m → ℝ)) M]
    [IsManifold 𝓘(ℝ, (Fin m → ℝ)) ∞ M] [T2Space M] [SecondCountableTopology M]
    [TopologicalSpace N] [ChartedSpace ((Fin n → ℝ)) N]
    [IsManifold 𝓘(ℝ, (Fin n → ℝ)) ∞ N] [T2Space N] [SecondCountableTopology N]
    {Φ : M → N} (hΦ : ContMDiff 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin n → ℝ)) ∞ Φ)
    (hrank : ConstantRank (m := m) (n := n) Φ k) :
    ∀ c, IsClosed {p | Φ p = c} ∧
      EmbeddedSubmanifoldOfCodimension (m := m) {p | Φ p = c} k := by
  sorry

end LeeSmoothManifolds
end Dataset
