module

public import Mathlib.Combinatorics.Enumerative.Partition.Basic
public import Mathlib.Combinatorics.Schnirelmann
public import Mathlib.NumberTheory.ArithmeticFunction.Moebius
public import Mathlib.Analysis.SpecialFunctions.Pow.NNReal
public import Mathlib.SetTheory.Cardinal.Finite
public import Mathlib.Topology.Algebra.InfiniteSum.Basic

/-!
# Shared definitions for the NivenZuckermanNumberTheory problems

Custom notions used by the statement files in `Dataset/NivenZuckermanNumberTheory/`
that are not already supplied by Mathlib. Schnirelmann density is Mathlib's
`schnirelmannDensity`, the Möbius function is `ArithmeticFunction.moebius`, and the
number of partitions of `n` is the cardinality of `Nat.Partition n`; what is added
here is the counting function `A(n)` of a set of integers and the notion of
*natural* (asymptotic) density built from it.
-/

@[expose] public section

open Filter
open scoped Topology

namespace Dataset
namespace NivenZuckermanNumberTheory

/-- `A(n)`, the number of positive integers not exceeding `n` that lie in `A`. -/
noncomputable def countingFunction (A : Set ℕ) (n : ℕ) : ℕ :=
  Nat.card {a : ℕ | a ∈ A ∧ 1 ≤ a ∧ a ≤ n}

/-- `A` has natural (asymptotic) density `d`, i.e. `A(n)/n → d`. -/
def HasNaturalDensity (A : Set ℕ) (d : ℝ) : Prop :=
  Tendsto (fun n : ℕ ↦ (countingFunction A n : ℝ) / n) atTop (𝓝 d)

/-- `p n`, the number of partitions of `n`. -/
noncomputable def partitionCount (n : ℕ) : ℕ := Nat.card (Nat.Partition n)

end NivenZuckermanNumberTheory
end Dataset
