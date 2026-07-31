module

public import Mathlib.Analysis.Distribution.SchwartzSpace.Fourier
public import Mathlib.Analysis.Fourier.AddCircle
public import Mathlib.MeasureTheory.Function.LpSeminorm.Basic
public import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# Shared definitions for the GrafakosFourier problems

Custom notions used by the statement files in `Dataset/GrafakosFourier/` that are
not already supplied by Mathlib. Each problem file that needs them imports
this module.
-/

@[expose] public section

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

end GrafakosFourier
end Dataset
