import Dataset.NikolskiOperators.Defs

/-!
# `nikolski_A_5_4_helson_szego` — 5.4.1

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `nikolski_A_5_4_helson_szego.md`.
Quality rubric: `nikolski_A_5_4_helson_szego.criteria.md`.
-/

open MeasureTheory
open scoped ENNReal

namespace Dataset
namespace NikolskiOperators

/--
Nikol'ski, *Operators, Functions, and Systems*, Volume 1, Part A, Section 5.4:
the Helson-Szego theorem, in Hardy-space language: the exponential system is a
basis in weighted `L²(T, μ)` exactly when the weight admits the Helson-Szego
factorization.
-/
theorem nikolski_A_5_4_helson_szego
    {w : {z : ℂ // ‖z‖ = 1} → ℝ}
    (hwmeas : AEStronglyMeasurable (fun t ↦ w (unitCirclePoint t))
      (volume.restrict (Set.Ioc 0 (2 * Real.pi))))
    (hwpos : ∀ᵐ t ∂volume.restrict (Set.Ioc 0 (2 * Real.pi)), 0 < w (unitCirclePoint t))
    (hwint : IntegrableOn (fun t ↦ w (unitCirclePoint t)) (Set.Ioc 0 (2 * Real.pi))) :
    let weightedMeasure := (volume.restrict (Set.Ioc 0 (2 * Real.pi))).withDensity
      fun t ↦ ENNReal.ofReal (w (unitCirclePoint t))
    let complete := ∀ f : ℝ → ℂ, MemLp f 2 weightedMeasure →
      (∀ k : ℤ, ∫ t, star (Complex.exp (Complex.I * k * t)) * f t ∂weightedMeasure = 0) →
        f =ᵐ[weightedMeasure] 0
    let basis := (∃ A B : ℝ, 0 < A ∧ A ≤ B ∧ ∀ c : ℤ → ℂ, c.support.Finite →
      A * ∑' k : ℤ, ‖c k‖ ^ 2 ≤ weightedL2NormSq w c ∧
        weightedL2NormSq w c ≤ B * ∑' k : ℤ, ‖c k‖ ^ 2) ∧ complete
    let boundedProjection := ∃ C : ℝ, 0 ≤ C ∧ ∀ c : ℤ → ℂ, c.support.Finite →
      weightedL2NormSq w (analyticFourierPart c) ≤ C ^ 2 * weightedL2NormSq w c
    let positiveAngle := ∃ δ : ℝ, 0 < δ ∧ ∀ plus minus : ℤ → ℂ,
      plus.support.Finite → minus.support.Finite →
        (∀ k, plus k ≠ 0 → 0 ≤ k) → (∀ k, minus k ≠ 0 → k < 0) →
          δ * weightedL2NormSq w plus ≤
            weightedL2NormSq w (fun k ↦ plus k + minus k)
    let outerDistance := ∃ h q : ℂ → ℂ, OuterFunction 2 h ∧ HardyClass ⊤ q ∧
      (∀ᵐ t ∂volume.restrict (Set.Ioc 0 (2 * Real.pi)),
        w (unitCirclePoint t) = ‖boundaryValue h (unitCirclePoint t)‖ ^ 2) ∧
      eLpNorm (fun t : ℝ ↦ star (boundaryValue h (unitCirclePoint t)) /
        boundaryValue h (unitCirclePoint t) - boundaryValue q (unitCirclePoint t)) ∞
        (volume.restrict (Set.Ioc 0 (2 * Real.pi))) < 1
    let helsonSzego := ∃ u v : {z : ℂ // ‖z‖ = 1} → ℝ,
      eLpNorm (fun t : ℝ ↦ u (unitCirclePoint t)) ∞
          (volume.restrict (Set.Ioc 0 (2 * Real.pi))) < ∞ ∧
        eLpNorm (fun t : ℝ ↦ v (unitCirclePoint t)) ∞
          (volume.restrict (Set.Ioc 0 (2 * Real.pi))) < ENNReal.ofReal (Real.pi / 2) ∧
        ∀ᵐ t ∂volume.restrict (Set.Ioc 0 (2 * Real.pi)),
          w (unitCirclePoint t) =
            Real.exp (u (unitCirclePoint t) + circleHilbertTransform v t)
    List.TFAE [basis, boundedProjection, positiveAngle, outerDistance, helsonSzego] := by
  sorry

end NikolskiOperators
end Dataset
