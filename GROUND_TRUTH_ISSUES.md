# Ground-truth repair ledger

Applying the per-problem rubrics (`Dataset/<Book>/<decl>.criteria.md`) exposed
several false, junk-valued, or materially divergent Lean statements. The
issues formerly recorded here have now been repaired in the Lean sources.
This file is retained as a regression ledger: each row records the semantic
change that must survive future refactors.

All repaired declarations elaborate in the repository-wide `lake build`.
Their proofs remain intentionally `sorry`, as is standard for this
statement-only dataset.

## False or unsatisfiable statements

| Statement | Repair |
|---|---|
| `KrylovSobolev/krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership` | Added `0 < d`. Without it the second half is false at `d = 0`: the space is a single point, so the support and decay hypotheses hold vacuously for every constant function while the bounding constant is fixed in advance, and the `H_p^γ` norms of the constants are unbounded. A machine-checked refutation was produced during review. |
| `MattilaGeometry/mattila_8_8_frostman_lemma` | Scoped the quantitative conclusion under positive Hausdorff measure, made the witnessing measures finite and compactly supported in `B`, and restored the strict quantitative inequality. |
| `ConwayFunctionalAnalysis/conway_IX_2_2_bounded_normal_spectral_theorem` | Conjugated the spectral integrand to account for Mathlib's conjugate-linearity in the first inner-product argument. |
| `EngelkingGeneralTopology/engelking_5_1_9_paracompact_partition_of_unity` | Added the Hausdorff hypothesis implicit in Engelking's convention for paracompact spaces. |
| `LeeSmoothManifolds/lee_10_7_sards_theorem` | Added second-countability hypotheses for both manifolds. |
| `LeeSmoothManifolds/lee_10_19_tubular_neighborhood_theorem` | Replaced analytic regularity (`⊤`) by smooth regularity (`∞`). |
| `NikolskiOperators/nikolski_B_3_2_nevanlinna_pick_interpolation` | Required distinct interpolation nodes and expressed uniqueness by equality on the unit disc, rather than equality of total representatives. |
| `NikolskiOperators/nikolski_B_7_2_1_adamyan_arov_krein` | Included the zero rational function in degree zero. |
| `NikolskiOperators/nikolski_A_5_4_helson_szego`, `nikolski_B_4_3_3_devinatz_widom` | Replaced the non-summable `tsum` Fourier expression by the limit of finite symmetric partial sums. |
| `GrafakosFourier/grafakos_4_1_1_torus_summability_uniform_boundedness` | Stated convergence to an abstract `L^p` limit, constructed the bounded extension separately, and guarded agreement with the formal Fourier series by summability. |
| `GrafakosFourier/grafakos_5_3_1_calderon_zygmund_decomposition` | Indexed the selected cubes by an arbitrary subset of `ℕ`, permitting a finite or empty family. |
| `GrafakosFourier/grafakos_1_3_2_marcinkiewicz_interpolation` | Added measurable-output hypotheses needed by the strong-type conclusion. |
| `KongODE/kong_1_5_3_differentiable_dependence` | Required the phase-parameter domain to be open. |
| `KongODE/kong_2_3_1_variation_of_parameters` | Used derivatives within the interval through the shared trajectory predicate. |
| `KongODE/kong_2_5_3_floquet_theorem` | Added continuity of the coefficient matrix. |
| `KongODE/kong_3_4_2_integrable_perturbation_stability` | Restricted stability initial times to the nonnegative half-line controlled by the perturbation hypotheses. |
| `KongODE/kong_3_5_2_lasalle_invariance_stability` | Added smoothness and the equilibrium hypothesis, and used the within-ball orbital derivative. |
| `KongODE/kong_4_5_3_generalized_poincare_bendixson` | Added the regularity required of the planar vector field. |
| `KongODE/kong_6_6_4_periodic_sturm_liouville_coupling` | Existentially bound the three spectral sequences, required eigenfunctions to be nonzero on the interval, made endpoint derivative data explicit, and compared linear dependence only on the problem interval. |
| `KrylovHolder/krylov_2_3_1_green_poisson_representation` | Required `K` to be a Laplace fundamental solution and strengthened the domain, normal, and boundary-solution predicates. |
| `KrylovHolder/krylov_3_7_2_constant_coefficient_holder_solvability`, `krylov_4_5_1_variable_coefficient_global_solvability` | Required a positive spectral parameter (or a positive threshold), excluding the negative-eigenvalue counterexamples. |
| `KrylovHolder/krylov_4_2_1_better_regular_data_better_regular_solution` | Made the positive threshold existential and applied the estimate only above it. |
| `KrylovHolder/krylov_6_5_3_smooth_domain_dirichlet_solvability` | Added continuity up to the boundary and imposed the correct zeroth-order sign through `SecondOrderEllipticOperator L 0`. |
| `KrylovHolder/krylov_7_1_2_interior_holder_regularization` | Replaced global up-to-boundary Hölder regularity by local regularity and restricted the equation to the domain. |
| `KrylovHolder/krylov_10_3_3_parabolic_dirichlet_domain_solvability` | Corrected the time orientation of the parabolic boundary, added domain barriers, and required boundary continuity and time differentiability of solutions. |

## Junk-valued operations

| Statement or definition | Repair |
|---|---|
| `MattilaGeometry/Defs.hausdorffContent` | Uses extended diameter, so unbounded cover sets contribute `∞` instead of `0`. |
| `MattilaGeometry/Defs.rieszEnergy` | Takes the inverse after embedding the distance in `ℝ≥0∞`, so the diagonal has the intended infinite kernel value. |
| `MattilaGeometry/mattila_9_7_projection_energy`, `mattila_10_10_plane_sections`, `mattila_18_1_besicovitch_federer_projection` | Gives the Grassmannian its canonical projection-induced topology and Borel measurable structure instead of quantifying over an arbitrary instance. |
| `KallenbergProbability/kallenberg_9_30_optional_sampling_and_closure` | Uses the terminal a.s. limit at infinite stopping times instead of `WithTop.untopA`'s arbitrary finite default. |
| `GrafakosFourier/grafakos_2_2_16_hausdorff_young` | Defines the `L^p` Fourier transform by completion from Schwartz functions instead of applying the Bochner-integral transform to a possibly non-`L^1` representative. |

## Material fidelity improvements

| Statement or definition | Repair |
|---|---|
| `LeeSmoothManifolds/Defs.SmoothDiffeomorphismOn`, `lee_7_6_inverse_function_theorem`, `lee_7_8_rank_theorem` | Use `C^∞` rather than real-analytic maps. |
| `MattilaGeometry/mattila_7_7_lipschitz_level_sets` | Uses an upper integral expressed as the infimum over measurable majorants. |
| `MattilaGeometry/mattila_12_14_falconer_distance_set` | Adds the source theorem's dimension hypothesis `2 ≤ n`. |
| `KrylovHolder/krylov_2_5_2_harmonic_smooth_interior_estimates` | Uses Euclidean space, `C^∞`, and a dimension/order-dependent constant quantified outside the domain and function. |
| `KrylovHolder` definitions and statements | Use `EuclideanSpace ℝ (Fin d)` consistently instead of the sup-norm function space `Fin d → ℝ`. |
| `NikolskiOperators/nikolski_A_1_3_beurling_invariant_subspaces` | Formalizes the stated Beurling--Helson theorem for simply invariant subspaces of boundary `L²`, including a.e. saturation and unimodular generators. |
| `NikolskiOperators/nikolski_B_7_2_1_adamyan_arov_krein` | Restores the headline equality between the approximation number (distance to arbitrary finite-rank matrices) and the best finite-rank Hankel approximation. |
| `ConwayFunctionalAnalysis/conway_VIII_5_17_gelfand_naimark` | Covers nonunital C-star algebras and uses nonunital star homomorphisms. |
| `KongODE/kong_5_4_2_hopf_friedrich_dichotomy` | Uses smooth rather than real-analytic regularity. |
| `GrafakosFourier/grafakos_2_2_14_fourier_identities_on_schwartz` | Restores the missing fifth Fourier identity involving the inverse transform. |
| `KallenbergProbability/kallenberg_10_5_doob_meyer` | States decomposition and uniqueness by indistinguishability (`∀ᵐ ω, ∀ t`) rather than only per-time modification equality. |

## Repairs made while adding the grading rubrics and context files

| Statement | Repair |
|---|---|
| `LeeSmoothManifolds/lee_10_11_whitney_embedding_theorem` | Replaced `IsEmbedding F ∧ ContMDiff … F` by `Manifold.IsSmoothEmbedding`, which bundles the immersion condition the textbook's "smooth embedding" requires; the old form admitted `t ↦ t³`. Countability stated as `SecondCountableTopology`, the textbook's own hypothesis, in place of `SigmaCompactSpace`. |
| `LeeSmoothManifolds/lee_10_16_whitney_approximation_theorem` | `SigmaCompactSpace` replaced by `SecondCountableTopology`, matching Lee's definition of "smooth manifold". |
| `LeeSmoothManifolds/lee_10_19_tubular_neighborhood_theorem` | Added continuity of the radius function; without it the "disk bundle" need not be open in the normal bundle. |
| `LeeSmoothManifolds/lee_7_8_rank_theorem`, `lee_7_13_rank_theorem_for_manifolds` | Added the centring conditions `φ p = 0` and `ψ (F p) = 0` that Lee's charts carry. |
| `LeeSmoothManifolds/lee_9_16_quotient_manifold_theorem` | Added `[T2Space M]`, `[SecondCountableTopology M]` and made the quotient's Hausdorffness and second countability part of the produced structure, as Lee's "topological manifold" requires. |
| `Bogachev/bogachev_4_5_9_de_la_vallee_poussin` | The uniform bound is now the printed supremum `⨆ i, ∫⁻ … < ∞` in `ℝ≥0∞` rather than an existentially bounded constant. |
| `Bogachev/bogachev_8_6_2_prokhorov_signed_measures` | Restored separability as a hypothesis of the first claim only, so the second conjunct is the theorem's second claim rather than a repetition of the first. |
| `Bogachev/bogachev_9_1_9_radon_preimage_from_compact_approximation` | Moved the compact exhaustion inside the first conjunct, so the compact-surjection corollary is not restated once per exhaustion. |
| `FollandHarmonic/folland_2_51_invariant_measure_on_quotient` | Removed a free `[TopologicalSpace (G ⧸ H)]` instance that shadowed the quotient topology and made the statement quantify over arbitrary topologies. |
| `GrafakosFourier/grafakos_5_6_6_vector_valued_maximal` | The unspecified constant `c(p,r)` is existentially quantified after `p` and `r` instead of being pinned to an invented closed formula, which would have asserted an unproved sharper bound. |
| `KongODE/kong_3_2_3_characteristic_multiplier_stability` | Added the continuity of `A` that Kong's system (H-p) assumes. |

## Recurring regression checks

1. In `WithTop ℕ∞`, `⊤` means real-analytic regularity (`ω`), while smoothness
   is written `∞` with `open scoped ContDiff`.
2. Textbook conventions may bundle separation or countability axioms that
   Mathlib deliberately keeps separate.
3. Partial operations such as `Metric.diam`, `deriv`, `fderiv`, `tsum`,
   `sInf`, inverse, conditional expectation, and stopped values at `⊤` return
   defaults outside their intended domains; every use needs its guard.
4. Quantifier placement is mathematical content: uniform constants precede
   the objects they control, existential sequences must not become implicit
   universal parameters, and uniqueness on a subdomain is `Set.EqOn` or a.e.
   equality rather than equality of arbitrary total representatives.
5. Equivalent-but-different hypotheses are a defect even when the theorem is
   unchanged: use the condition the textbook states.
