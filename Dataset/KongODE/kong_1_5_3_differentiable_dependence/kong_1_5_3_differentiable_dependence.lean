import Dataset.KongODE.Defs

/-!
# `kong_1_5_3_differentiable_dependence`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kong_1_5_3_differentiable_dependence.md`.
Quality rubric: `kong_1_5_3_differentiable_dependence.criteria.md`.
-/

namespace Dataset
namespace KongODE

/-- Kong 1.5.3, differentiable dependence on initial data and parameters. -/
theorem kong_1_5_3_differentiable_dependence
    {n k : ℕ} {D : Set (ℝ × (Fin n → ℝ) × (Fin k → ℝ))}
    {f : ℝ → (Fin n → ℝ) → (Fin k → ℝ) → (Fin n → ℝ)}
    (hD : IsOpen D)
    (hf : ContinuousOn (fun p : ℝ × (Fin n → ℝ) × (Fin k → ℝ) ↦ f p.1 p.2.1 p.2.2) D)
    (hfx : ContinuousOn
      (fun p : ℝ × (Fin n → ℝ) × (Fin k → ℝ) ↦ fderiv ℝ (fun y ↦ f p.1 y p.2.2) p.2.1) D)
    (hfμ : ContinuousOn
      (fun p : ℝ × (Fin n → ℝ) × (Fin k → ℝ) ↦ fderiv ℝ (fun m ↦ f p.1 p.2.1 m) p.2.2) D)
    (hfxdiff : ∀ p ∈ D, DifferentiableAt ℝ (fun y ↦ f p.1 y p.2.2) p.2.1)
    (hfμdiff : ∀ p ∈ D, DifferentiableAt ℝ (fun m ↦ f p.1 p.2.1 m) p.2.2) :
    ∃ (I : ℝ → (Fin n → ℝ) → (Fin k → ℝ) → Set ℝ)
      (x : ℝ → ℝ → (Fin n → ℝ) → (Fin k → ℝ) → (Fin n → ℝ)),
      (∀ t₀ x₀ μ, (t₀, x₀, μ) ∈ D → IsOpen (I t₀ x₀ μ) ∧
        (I t₀ x₀ μ).OrdConnected ∧ t₀ ∈ I t₀ x₀ μ ∧
        IsTrajectoryOn (I t₀ x₀ μ) (fun t y ↦ f t y μ) (fun t ↦ x t t₀ x₀ μ) ∧
        x t₀ t₀ x₀ μ = x₀ ∧
        (∀ t ∈ I t₀ x₀ μ, (t, x t t₀ x₀ μ, μ) ∈ D) ∧
        ∀ y, IsTrajectoryOn (I t₀ x₀ μ) (fun t z ↦ f t z μ) y → y t₀ = x₀ →
          (∀ t ∈ I t₀ x₀ μ, (t, y t, μ) ∈ D) →
          Set.EqOn y (fun t ↦ x t t₀ x₀ μ) (I t₀ x₀ μ)) ∧
      (let flowDomain := {p : ℝ × ℝ × (Fin n → ℝ) × (Fin k → ℝ) |
        p.1 ∈ I p.2.1 p.2.2.1 p.2.2.2};
        ContDiffOn ℝ 1 (fun p ↦ x p.1 p.2.1 p.2.2.1 p.2.2.2) flowDomain) ∧
      (∀ t₀ x₀ μ, (t₀, x₀, μ) ∈ D →
        let z := fun t ↦ fderiv ℝ (fun η ↦ x t t₀ x₀ η) μ
        z t₀ = 0 ∧ ∀ t ∈ I t₀ x₀ μ, HasDerivAt z
          ((fderiv ℝ (fun y ↦ f t y μ) (x t t₀ x₀ μ)).comp (z t) +
            fderiv ℝ (fun η ↦ f t (x t t₀ x₀ μ) η) μ) t) ∧
      (∀ t₀ x₀ μ, (t₀, x₀, μ) ∈ D →
        let z := fun t ↦ fderiv ℝ (fun y ↦ x t t₀ y μ) x₀
        z t₀ = ContinuousLinearMap.id ℝ (Fin n → ℝ) ∧ ∀ t ∈ I t₀ x₀ μ,
          HasDerivAt z ((fderiv ℝ (fun y ↦ f t y μ) (x t t₀ x₀ μ)).comp (z t)) t) ∧
      ∀ t₀ x₀ μ, (t₀, x₀, μ) ∈ D →
        let z := fun t ↦ deriv (fun s ↦ x t s x₀ μ) t₀
        z t₀ = -f t₀ x₀ μ ∧ ∀ t ∈ I t₀ x₀ μ,
          HasDerivAt z ((fderiv ℝ (fun y ↦ f t y μ) (x t t₀ x₀ μ)) (z t)) t := by
  sorry

end KongODE
end Dataset
