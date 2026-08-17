import Mathlib.Analysis.Complex.ValueDistribution.CharacteristicFunction

/-!
# Shared definitions for the HaymanMeromorphic problems

Custom notions used by the statement files in `Dataset/HaymanMeromorphic/` that are
not already supplied by Mathlib. Mathlib's `ValueDistribution.proximity`,
`ValueDistribution.logCounting` and `ValueDistribution.characteristic` are Hayman's
`m(r,a)`, `N(r,a)` and `T(r,a)`; what is added here is the *reduced* counting function
`N̄(r,a)`, the three Nevanlinna indices `δ`, `θ`, `Θ` built from it, and the growth
conditions used in Chapter 2.
-/

open Filter Set ValueDistribution

namespace Dataset
namespace HaymanMeromorphic

/-- `n̄(t, a)`, the number of *distinct* roots of `f z = a` in the closed disk `|z| ≤ t`:
`z` is an `a`-point exactly when `f - a` has positive meromorphic order at `z`, which is the
representative-independent reading (re-valuing `f` on a discrete set changes neither the
meromorphic germ nor this count, and poles are never counted as `a`-points). -/
noncomputable def distinctCount (f : ℂ → ℂ) (a : ℂ) (t : ℝ) : ℕ :=
  {z : ℂ | ‖z‖ ≤ t ∧ 0 < meromorphicOrderAt (fun w ↦ f w - a) z}.ncard

/-- `N̄(r, a)`, the logarithmic counting function of the *distinct* `a`-points of `f`,
in which multiple roots are counted only once. -/
noncomputable def reducedLogCounting (f : ℂ → ℂ) (a : ℂ) (r : ℝ) : ℝ :=
  (∫ t in Ioc 0 r, ((distinctCount f a t : ℝ) - distinctCount f a 0) / t) +
    (distinctCount f a 0 : ℝ) * Real.log r

/-- Hayman's deficiency `δ(a) = liminf_{r → ∞} m(r,a)/T(r)`. -/
noncomputable def deficiency (f : ℂ → ℂ) (a : WithTop ℂ) : ℝ :=
  liminf (fun r ↦ proximity f a r / characteristic f ⊤ r) atTop

/-- Hayman's index of multiplicity `θ(a) = liminf_{r → ∞} (N(r,a) - N̄(r,a))/T(r)`. -/
noncomputable def ramificationIndex (f : ℂ → ℂ) (a : ℂ) : ℝ :=
  liminf (fun r ↦ (logCounting f (a : WithTop ℂ) r - reducedLogCounting f a r) /
    characteristic f ⊤ r) atTop

/-- Hayman's `Θ(a) = 1 - limsup_{r → ∞} N̄(r,a)/T(r)`. -/
noncomputable def nevanlinnaTheta (f : ℂ → ℂ) (a : ℂ) : ℝ :=
  1 - limsup (fun r ↦ reducedLogCounting f a r / characteristic f ⊤ r) atTop

/-- `f` is transcendental: entire but not a polynomial. -/
def IsTranscendentalEntire (f : ℂ → ℂ) : Prop :=
  Differentiable ℂ f ∧ ¬ ∃ p : Polynomial ℂ, ∀ z, f z = p.eval z

/-- `f` has finite order of growth: `log M(r) = O(r^k)` for some `k`. -/
def HasFiniteOrder (f : ℂ → ℂ) : Prop :=
  ∃ k : ℝ, ∀ᶠ r in atTop, ∀ z : ℂ, ‖z‖ ≤ r → ‖f z‖ ≤ Real.exp (r ^ k)

/-- `f` has order zero: `log M(r) = O(r^ε)` for every `ε > 0`. -/
def HasZeroOrder (f : ℂ → ℂ) : Prop :=
  ∀ ε : ℝ, 0 < ε → ∀ᶠ r in atTop, ∀ z : ℂ, ‖z‖ ≤ r → ‖f z‖ ≤ Real.exp (r ^ ε)

end HaymanMeromorphic
end Dataset
