module

import Mathlib.Analysis.Distribution.SchwartzSpace.Fourier
import Mathlib.Analysis.Fourier.AddCircle
import Mathlib.MeasureTheory.Function.LpSeminorm.Basic
import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# Hard Fourier-analysis statements from Grafakos

Ten statement-only formalizations selected from Loukas Grafakos,
*Classical Fourier Analysis*, third edition.
-/

open Filter Function MeasureTheory Metric Set

open scoped ENNReal FourierTransform SchwartzMap Topology

namespace Dataset
namespace GrafakosFourier

universe u v

/-- A sublinear operator on complex-valued measurable functions. -/
def IsSublinearOperator {X : Type u} {Y : Type v}
    (T : (X → ℂ) → Y → ℂ) : Prop :=
  T 0 = 0 ∧
    (∀ f g x, ‖T (f + g) x‖ ≤ ‖T f x‖ + ‖T g x‖) ∧
    ∀ c : ℂ, ∀ f x, ‖T (c • f) x‖ = ‖c‖ * ‖T f x‖

/-- Weak type `(p,p)` with a specified constant. -/
def HasWeakType {X : Type u} {Y : Type v} [MeasurableSpace X] [MeasurableSpace Y]
    (μ : Measure X) (ν : Measure Y) (T : (X → ℂ) → Y → ℂ)
    (p : ℝ) (C : ℝ≥0∞) : Prop :=
  ∀ f : X → ℂ, MemLp f (ENNReal.ofReal p) μ → ∀ α : ℝ, 0 < α →
    ν {y | ENNReal.ofReal α < ‖T f y‖ₑ} ≤
      ENNReal.rpow (C * eLpNorm f (ENNReal.ofReal p) μ / ENNReal.ofReal α) p

/-- Strong type `L^p(μ) → L^q(ν)` with a specified constant. -/
def HasStrongType {X : Type u} {Y : Type v} [MeasurableSpace X] [MeasurableSpace Y]
    (μ : Measure X) (ν : Measure Y) (T : (X → ℂ) → Y → ℂ)
    (p q : ℝ≥0∞) (C : ℝ≥0∞) : Prop :=
  ∀ f : X → ℂ, MemLp f p μ →
    MemLp (T f) q ν ∧ eLpNorm (T f) q ν ≤ C * eLpNorm f p μ

/-- The uncentered Hardy-Littlewood maximal function on Euclidean space. -/
noncomputable def hardyLittlewoodMaximal (n : ℕ)
    (f : EuclideanSpace ℝ (Fin n) → ℂ) (x : EuclideanSpace ℝ (Fin n)) : ℝ≥0∞ :=
  ⨆ y : EuclideanSpace ℝ (Fin n), ⨆ r : {r : ℝ // 0 < r},
    ⨆ (_ : x ∈ ball y r),
      (∫⁻ z in ball y r, ‖f z‖ₑ) / volume (ball y r)

/-- The centered Hardy-Littlewood maximal function on Euclidean space. -/
noncomputable def hardyLittlewoodCenteredMaximal (n : ℕ)
    (f : EuclideanSpace ℝ (Fin n) → ℂ) (x : EuclideanSpace ℝ (Fin n)) : ℝ≥0∞ :=
  ⨆ r : {r : ℝ // 0 < r},
    (∫⁻ z in ball x r, ‖f z‖ₑ) / volume (ball x r)

/-- The standard character of the `n`-torus indexed by an integer vector. -/
noncomputable def torusCharacter {n : ℕ} (m : Fin n → ℤ)
    (x : Fin n → AddCircle (1 : ℝ)) : ℂ :=
  ∏ i, fourier (m i) (x i)

/-- The Fourier coefficient of a function on the `n`-torus. -/
noncomputable def torusFourierCoefficient {n : ℕ}
    [MeasurableSpace (Fin n → AddCircle (1 : ℝ))]
    (μ : Measure (Fin n → AddCircle (1 : ℝ)))
    (f : (Fin n → AddCircle (1 : ℝ)) → ℂ) (m : Fin n → ℤ) : ℂ :=
  ∫ x, star (torusCharacter m x) * f x ∂μ

/-- The maximal symmetric partial Fourier integral on the line. -/
noncomputable def carlesonHuntMaximal (f : 𝓢(ℝ, ℂ)) (x : ℝ) : ℝ≥0∞ :=
  ⨆ R : {R : ℝ // 0 < R},
    ‖∫ ξ in Set.Icc (-R.1) R.1,
      𝓕 f ξ * Complex.exp (2 * Real.pi * Complex.I * ξ * x)‖ₑ

/-- A dyadic cube in Euclidean space. -/
structure DyadicCube (n : ℕ) where
  scale : ℤ
  corner : Fin n → ℤ

/-- The half-open carrier of a dyadic cube. -/
def DyadicCube.carrier {n : ℕ} (Q : DyadicCube n) : Set (EuclideanSpace ℝ (Fin n)) :=
  {x | ∀ i,
    (Q.corner i : ℝ) * 2 ^ Q.scale ≤ x i ∧
      x i < (Q.corner i + 1 : ℤ) * 2 ^ Q.scale}

/-- Grafakos 1.3.2, the Marcinkiewicz interpolation theorem. -/
theorem grafakos_1_3_2_marcinkiewicz_interpolation
    {X : Type u} {Y : Type v} [MeasurableSpace X] [MeasurableSpace Y]
    (μ : Measure X) (ν : Measure Y) [SigmaFinite μ]
    (T : (X → ℂ) → Y → ℂ) {p₀ p₁ p : ℝ} {A₀ A₁ : ℝ≥0∞}
    (hp : 0 < p₀ ∧ p₀ < p ∧ p < p₁)
    (hA₀ : A₀ < ∞) (hA₁ : A₁ < ∞)
    (hT : IsSublinearOperator T) (h₀ : HasWeakType μ ν T p₀ A₀)
    (h₁ : HasWeakType μ ν T p₁ A₁) :
    HasStrongType μ ν T (ENNReal.ofReal p) (ENNReal.ofReal p)
      (2 * ENNReal.rpow
        (ENNReal.ofReal (p / (p - p₀) + p / (p₁ - p))) (1 / p) *
          ENNReal.rpow A₀ ((p₀ / p) * ((p₁ - p) / (p₁ - p₀))) *
            ENNReal.rpow A₁ ((p₁ / p) * ((p - p₀) / (p₁ - p₀)))) := by
  sorry

/-- Grafakos 1.3.4, the Riesz-Thorin interpolation theorem. -/
theorem grafakos_1_3_4_riesz_thorin_interpolation
    {X : Type u} {Y : Type v} [MeasurableSpace X] [MeasurableSpace Y]
    (μ : Measure X) (ν : Measure Y) (T : (X → ℂ) →ₗ[ℂ] (Y → ℂ))
    {p₀ p₁ q₀ q₁ p q : ℝ≥0∞} {θ : ℝ} {M₀ M₁ : ℝ≥0∞}
    (hθ : 0 < θ ∧ θ < 1)
    (hexponents : 1 ≤ p₀ ∧ 1 ≤ p₁ ∧ 1 ≤ q₀ ∧ 1 ≤ q₁)
    (hM₀ : M₀ < ∞) (hM₁ : M₁ < ∞)
    (hp : p⁻¹ = ENNReal.ofReal (1 - θ) * p₀⁻¹ + ENNReal.ofReal θ * p₁⁻¹)
    (hq : q⁻¹ = ENNReal.ofReal (1 - θ) * q₀⁻¹ + ENNReal.ofReal θ * q₁⁻¹)
    (h₀ : HasStrongType μ ν T p₀ q₀ M₀)
    (h₁ : HasStrongType μ ν T p₁ q₁ M₁) :
    HasStrongType μ ν T p q
      (ENNReal.rpow M₀ (1 - θ) * ENNReal.rpow M₁ θ) := by
  sorry

/-- Grafakos 2.1.6, the Hardy-Littlewood maximal estimates. -/
theorem grafakos_2_1_6_hardy_littlewood_maximal {n : ℕ} :
    let operators := ({hardyLittlewoodMaximal n,
      hardyLittlewoodCenteredMaximal n} : Set ((EuclideanSpace ℝ (Fin n) → ℂ) →
        EuclideanSpace ℝ (Fin n) → ℝ≥0∞))
    (∀ M ∈ operators, ∀ f : EuclideanSpace ℝ (Fin n) → ℂ, MemLp f 1 volume →
      ∀ α : ℝ, 0 < α → volume {x | ENNReal.ofReal α < M f x} ≤
        ENNReal.ofReal (3 ^ n / α) *
          ∫⁻ x in {x | ENNReal.ofReal α < M f x}, ‖f x‖ₑ) ∧
    ∀ M ∈ operators, ∀ p : ℝ, 1 < p → ∀ f : EuclideanSpace ℝ (Fin n) → ℂ,
      MemLp f (ENNReal.ofReal p) volume →
        ENNReal.rpow (∫⁻ x, ENNReal.rpow (M f x) p) (1 / p) ≤
          ENNReal.ofReal (3 ^ ((n : ℝ) / p) * p / (p - 1)) *
            eLpNorm f (ENNReal.ofReal p) volume := by
  sorry

/-- Grafakos 2.2.14, Fourier identities on the Schwartz space. -/
theorem grafakos_2_2_14_fourier_identities_on_schwartz
    {n : ℕ} (f g h : 𝓢(EuclideanSpace ℝ (Fin n), ℂ)) :
    ((∫ x, f x * 𝓕 g x) = ∫ x, 𝓕 f x * g x) ∧
      𝓕⁻ (𝓕 f) = f ∧ 𝓕 (𝓕⁻ f) = f ∧
      (∫ x, star (𝓕 f x) * 𝓕 g x) = ∫ x, star (f x) * g x ∧
      eLpNorm (fun x ↦ 𝓕 f x) 2 volume = eLpNorm f 2 volume ∧
      eLpNorm (fun x ↦ 𝓕⁻ f x) 2 volume = eLpNorm f 2 volume ∧
      (∫ x, 𝓕 f x * h x) = ∫ x, f x * 𝓕 h x := by
  sorry

/-- Grafakos 2.2.16, the Hausdorff-Young inequality. -/
theorem grafakos_2_2_16_hausdorff_young
    {n : ℕ} {p : ℝ} {f : EuclideanSpace ℝ (Fin n) → ℂ}
    (hp : 1 ≤ p ∧ p ≤ 2) (hf : MemLp f (ENNReal.ofReal p) volume) :
    let conjugateExponent : ℝ≥0∞ := if p = 1 then ∞ else ENNReal.ofReal (p / (p - 1))
    MemLp (𝓕 f) conjugateExponent volume ∧
      eLpNorm (𝓕 f) conjugateExponent volume ≤
        eLpNorm f (ENNReal.ofReal p) volume := by
  sorry

/-- Grafakos 3.2.8, the Poisson summation formula. -/
theorem grafakos_3_2_8_poisson_summation
    {n : ℕ} {f : EuclideanSpace ℝ (Fin n) → ℂ}
    (hf : Continuous f ∧ Integrable f ∧
      (∃ C δ : ℝ, 0 < C ∧ 0 < δ ∧ ∀ x,
        ‖f x‖ ≤ C * (1 + ‖x‖) ^ (-(n : ℝ) - δ)) ∧
      Summable fun m : Fin n → ℤ ↦ 𝓕 f ((WithLp.toLp 2 fun i ↦ (m i : ℝ)))) :
    (∀ x : EuclideanSpace ℝ (Fin n),
      ∑' m : Fin n → ℤ, 𝓕 f ((WithLp.toLp 2 fun i ↦ (m i : ℝ))) *
          Complex.exp (2 * Real.pi * Complex.I * (∑ i, (m i : ℂ) * (x i : ℂ))) =
        ∑' k : Fin n → ℤ, f (x + (WithLp.toLp 2 fun i ↦ (k i : ℝ)))) ∧
      (∑' m : Fin n → ℤ, 𝓕 f ((WithLp.toLp 2 fun i ↦ (m i : ℝ)))) =
        ∑' k : Fin n → ℤ, f ((WithLp.toLp 2 fun i ↦ (k i : ℝ))) := by
  sorry

/-- Grafakos 4.1.1, uniform boundedness for torus summability. -/
theorem grafakos_4_1_1_torus_summability_uniform_boundedness
    {n : ℕ}
    (a : ℝ → (Fin n → ℤ) → ℂ) (aLimit : (Fin n → ℤ) → ℂ)
    (hfinite : ∀ R, 0 < R → (Function.support (a R)).Finite)
    (hbounded : ∃ M : ℝ, 0 ≤ M ∧ ∀ R m, 0 < R → ‖a R m‖ ≤ M)
    (htendsto : ∀ m, Tendsto (fun R ↦ a R m) atTop (𝓝 (aLimit m)))
    {p : ℝ} (hp : 1 ≤ p) :
    let μ : Measure (Fin n → AddCircle (1 : ℝ)) := volume
    let S := fun R (f : (Fin n → AddCircle (1 : ℝ)) → ℂ)
      (x : Fin n → AddCircle (1 : ℝ)) ↦
        ∑' m, a R m * torusFourierCoefficient μ f m * torusCharacter m x
    let A := fun (f : (Fin n → AddCircle (1 : ℝ)) → ℂ)
      (x : Fin n → AddCircle (1 : ℝ)) ↦
        ∑' m, aLimit m * torusFourierCoefficient μ f m * torusCharacter m x
    ((∀ f, MemLp f (ENNReal.ofReal p) μ →
        Tendsto (fun R ↦ eLpNorm (S R f - A f) (ENNReal.ofReal p) μ) atTop (𝓝 0)) ↔
      ∃ C : ℝ≥0∞, C < ∞ ∧ ∀ R, 0 < R →
        HasStrongType μ μ (S R) (ENNReal.ofReal p) (ENNReal.ofReal p) C) ∧
    ∀ C : ℝ≥0∞,
      (∀ R, 0 < R → HasStrongType μ μ (S R) (ENNReal.ofReal p) (ENNReal.ofReal p) C) →
        HasStrongType μ μ A (ENNReal.ofReal p) (ENNReal.ofReal p) C := by
  sorry

/-- Grafakos 4.3.15, the Carleson-Hunt maximal estimate on the line. -/
theorem grafakos_4_3_15_carleson_hunt_line {p : ℝ} (hp : 1 < p) :
    ∃ C : ℝ≥0∞, C < ∞ ∧ ∀ f : 𝓢(ℝ, ℂ),
      ENNReal.rpow (∫⁻ x, ENNReal.rpow (carlesonHuntMaximal f x) p) (1 / p) ≤
        C * eLpNorm (f : ℝ → ℂ) (ENNReal.ofReal p) volume := by
  sorry

/-- Grafakos 5.3.1, the Calderon-Zygmund decomposition. -/
theorem grafakos_5_3_1_calderon_zygmund_decomposition
    {n : ℕ} {f : EuclideanSpace ℝ (Fin n) → ℂ} {α : ℝ}
    (hf : MemLp f 1 volume) (hα : 0 < α) :
    ∃ g b : EuclideanSpace ℝ (Fin n) → ℂ,
      ∃ (Q : ℕ → DyadicCube n) (bad : ℕ → EuclideanSpace ℝ (Fin n) → ℂ),
        f = g + b ∧ HasSum bad b ∧ eLpNorm g 1 volume ≤ eLpNorm f 1 volume ∧
          eLpNorm g ∞ volume ≤ ENNReal.ofReal (2 ^ n * α) ∧
          (Pairwise fun i j ↦ Disjoint (Q i).carrier (Q j).carrier) ∧
          (∀ j, Function.support (bad j) ⊆ (Q j).carrier) ∧
          (∀ j, ∫ x, bad j x = 0) ∧
          (∀ j, eLpNorm (bad j) 1 volume ≤
            ENNReal.ofReal (2 ^ (n + 1) * α) * volume (Q j).carrier) ∧
          ∑' j, volume (Q j).carrier ≤ eLpNorm f 1 volume / ENNReal.ofReal α := by
  sorry

/-- Grafakos 5.6.6, the Fefferman-Stein vector-valued maximal inequalities. -/
theorem grafakos_5_6_6_vector_valued_maximal
    {n : ℕ} {p r : ℝ} (hp : 1 < p) (hr : 1 < r) :
    let ellNorm := fun (f : ℕ → EuclideanSpace ℝ (Fin n) → ℂ) x ↦
      ENNReal.rpow (∑' j, ENNReal.rpow ‖f j x‖ₑ r) (1 / r)
    let maximalNorm := fun (f : ℕ → EuclideanSpace ℝ (Fin n) → ℂ) x ↦
      ENNReal.rpow (∑' j, ENNReal.rpow (hardyLittlewoodMaximal n (f j) x) r) (1 / r)
    ∃ Cn Cp : ℝ≥0∞, Cn < ∞ ∧ Cp < ∞ ∧
      (∀ f : ℕ → EuclideanSpace ℝ (Fin n) → ℂ, ∀ α : ℝ, 0 < α →
        volume {x | ENNReal.ofReal α < maximalNorm f x} ≤
          Cn * ENNReal.ofReal (1 + 1 / (r - 1)) / ENNReal.ofReal α *
            ENNReal.rpow (∫⁻ x, ellNorm f x) 1) ∧
      ∀ f : ℕ → EuclideanSpace ℝ (Fin n) → ℂ,
        ENNReal.rpow (∫⁻ x, ENNReal.rpow (maximalNorm f x) p) (1 / p) ≤
          Cp * ENNReal.rpow (∫⁻ x, ENNReal.rpow (ellNorm f x) p) (1 / p) := by
  sorry

end GrafakosFourier
end Dataset
