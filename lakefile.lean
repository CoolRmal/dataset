import Lake

open Lake DSL

package dataset where
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩,
    ⟨`autoImplicit, false⟩
  ]

require mathlib from "../mathlib4"

@[default_target]
lean_lib Dataset where
