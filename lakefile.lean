import Lake

open Lake DSL

package dataset where
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩,
    ⟨`autoImplicit, false⟩
  ]

require mathlib from git "https://github.com/leanprover-community/mathlib4.git" @
  "f4fd7f7e24a83af258ec9d80deb04648d3428d34"

@[default_target]
lean_lib Dataset where
