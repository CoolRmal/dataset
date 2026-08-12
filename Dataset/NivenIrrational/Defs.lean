module

public import Mathlib.Analysis.SpecialFunctions.Log.Base
public import Mathlib.NumberTheory.Real.Irrational
public import Mathlib.LinearAlgebra.Dimension.Finrank
public import Mathlib.RingTheory.Adjoin.Basic
public import Mathlib.Analysis.SpecialFunctions.Pow.Real
public import Mathlib.RingTheory.Algebraic.Defs

/-!
# Shared definitions for the NivenIrrational problems

Custom notions used by the statement files in `Dataset/NivenIrrational/` that are
not already supplied by Mathlib. Irrationality is Mathlib's `Irrational`,
transcendence is `Transcendental`, and countability is `Set.Countable`; what is
added here is the decimal expansion of a real number together with eventual
periodicity, and the class of lengths constructible by straightedge and compass.
-/

@[expose] public section

open Set

namespace Dataset
namespace NivenIrrational

/-- The `k`-th decimal digit of `x ∈ [0,1)`, i.e. `⌊10^{k+1} x⌋ mod 10`. -/
noncomputable def decimalDigit (x : ℝ) (k : ℕ) : ℕ :=
  (⌊(10 : ℝ) ^ (k + 1) * x⌋).toNat % 10

/-- A digit sequence is eventually periodic: after some point it repeats with a fixed
positive period. -/
def EventuallyPeriodic (d : ℕ → ℕ) : Prop :=
  ∃ N p : ℕ, 0 < p ∧ ∀ k, N ≤ k → d (k + p) = d k

/-- The lengths constructible from a unit segment by straightedge and compass: the closure
of the rationals under addition, subtraction, multiplication, division and square roots of
non-negative constructed lengths. -/
inductive IsConstructible : ℝ → Prop
  | rat (q : ℚ) : IsConstructible q
  | add {x y : ℝ} : IsConstructible x → IsConstructible y → IsConstructible (x + y)
  | neg {x : ℝ} : IsConstructible x → IsConstructible (-x)
  | mul {x y : ℝ} : IsConstructible x → IsConstructible y → IsConstructible (x * y)
  | inv {x : ℝ} : IsConstructible x → IsConstructible x⁻¹
  | sqrt {x : ℝ} : IsConstructible x → 0 ≤ x → IsConstructible (Real.sqrt x)

end NivenIrrational
end Dataset
