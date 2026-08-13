# Criteria: lee_7_8_rank_theorem

**Statement:** [lee_7_8_rank_theorem.md](lee_7_8_rank_theorem.md) · **Lean:** [lee_7_8_rank_theorem.lean](lee_7_8_rank_theorem.lean)

## What the theorem says

Let $U \subseteq \mathbb{R}^m$ and $V \subseteq \mathbb{R}^n$ be open and let $F : U \to V$ be
smooth. Suppose the derivative $DF(x)$ has the *same* rank $k$ at every point of $U$. Then near any
chosen point $p$ you can change coordinates on both sides so that $F$ becomes as simple as possible:
in the new coordinates it copies the first $k$ inputs and sends the rest to zero, i.e.
$(x^1,\dots,x^m) \mapsto (x^1,\dots,x^k,0,\dots,0)$. The change of coordinates is by smooth
diffeomorphisms $\varphi$ on a neighbourhood $U_0$ of $p$ and $\psi$ on a neighbourhood $V_0$ of
$F(p)$, with $F(U_0) \subseteq V_0$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $U \subseteq \mathbb{R}^m$ and $V \subseteq \mathbb{R}^n$ are open, and $F$ maps $U$ into $V$. | ✅ `hU : IsOpen U`, `hV : IsOpen V`, `hF.1 : MapsTo F U V`. |
| 2 | $F$ is $C^\infty$ on $U$. | ✅ `hF.2 : ContDiffOn ℝ ∞ F U`, using `∞` for $C^\infty$. |
| 3 | The rank is exactly $k$ at **every** point of $U$, not only at $p$. | ✅ `hrank : EuclideanConstantRank U F k`, which unfolds to `∀ x ∈ U, Module.finrank ℝ (LinearMap.range (fderiv ℝ F x).toLinearMap) = k`. |
| 4 | The hypotheses must make `fderiv` the honest derivative, otherwise the rank condition is about a junk zero map. | ✅ `hU : IsOpen U` and `hF.2 : ContDiffOn ℝ ∞ F U` supply this; on an open set the derivative within the set is the ordinary derivative. |
| 5 | The base point lies in $U$. | ✅ `hp : p ∈ U`. |
| 6 | The conclusion produces $U_0$ open with $p \in U_0 \subseteq U$, and $V_0$ open with $F(p) \in V_0 \subseteq V$. | ✅ `(IsOpen U₀ ∧ IsConnected U₀ ∧ p ∈ U₀ ∧ U₀ ⊆ U)` and the mirror clause for `V₀`. Connectedness is extra (Lee asks for it in 7.6, not 7.8) but only strengthens the conclusion. |
| 7 | $F(U_0) \subseteq V_0$, so that $\psi \circ F \circ \varphi^{-1}$ is defined where the normal form is claimed. | ✅ `MapsTo F U₀ V₀`. |
| 8 | Smooth coordinate changes: a smooth diffeomorphism $\varphi$ defined on $U_0$ and a smooth diffeomorphism $\psi$ defined on $V_0$, each with a smooth inverse. | ✅ `φ : SmoothDiffeomorphismOn U₀ sourceTarget` and `ψ : SmoothDiffeomorphismOn V₀ targetTarget`, with the two image sets existentially quantified. |
| 9 | The normal form: for every $x$ in the image $\varphi(U_0)$, coordinate $i$ of $\psi(F(\varphi^{-1}(x)))$ is $x^i$ when $i < k$ and $0$ otherwise, with $i$ ranging over all $n$ output coordinates. | ✅ `∀ x ∈ φ.toFun '' U₀, ψ.toFun (F (φ.invFun x)) = fun i ↦ if h : i.1 < k ∧ i.1 < m then x ⟨i.1, h.2⟩ else 0`. Checked coordinate by coordinate this is $(x^1,\dots,x^k,0,\dots,0)$. |
| 10 | Lee's charts are **centred**: $\varphi(p) = 0$ and $\psi(F(p)) = 0$. | ⚠️ Missing. Neither `φ.toFun p = 0` nor `ψ.toFun (F p) = 0` appears, so our conclusion is weaker than the printed one. Adding `φ.toFun p = 0` alone would be enough, since the normal form then forces $\psi(F(p)) = 0$. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Assuming the rank is $k$ only at the single point $p$. | That is the hypothesis of the inverse/immersion/submersion theorems, not the rank theorem. With rank pinned only at $p$ the normal-form conclusion is false — the rank can jump nearby and no coordinate change flattens $F$. |
| 2 | Dropping `ContDiffOn ℝ ∞ F U` while keeping the rank hypothesis. | `fderiv ℝ F x` is the zero map wherever $F$ is not differentiable, so the rank condition would be satisfied by pathological $F$ with $k = 0$, and the conclusion asserted for them is false. |
| 3 | Writing the smoothness index as `⊤` under `open scoped ContDiff`. | That elaborates to `ω`, real-analytic. Both the hypothesis on $F$ and the smoothness of the produced charts get strengthened from $C^\infty$ to $C^\omega$, giving the analytic rank theorem rather than Lee 7.8. Our file previously had this and it was repaired to `∞`. |
| 4 | Making the normal form copy the first $k$ coordinates but forgetting to force the other $n - k$ output coordinates to zero (for instance, asserting the equation only for $i < k$). | The whole content is that the map dies in the remaining directions; without that clause $\psi \circ F \circ \varphi^{-1}$ is barely constrained. |
| 5 | Omitting `MapsTo F U₀ V₀`, or omitting $U_0 \subseteq U$ / $V_0 \subseteq V$. | Then $F(\varphi^{-1}(x))$ can fall outside the domain of $\psi$, where a partial map returns a junk value, and the equation asserted is meaningless. |
| 6 | Asserting the normal form only at the single point $x = \varphi(p)$ rather than for all $x$ in $\varphi(U_0)$. | A single-point equation is nearly vacuous; the theorem is about the coordinate representation on a whole neighbourhood. |

## Notes on the ground truth

- `sourceTarget` and `targetTarget` are existentially quantified sets. Because
  `SmoothDiffeomorphismOn` bundles `mapsTo` together with `rightInvOn`, they are forced to equal
  `φ.toFun '' U₀` and `ψ.toFun '' V₀`, so asserting the normal form for `x ∈ φ.toFun '' U₀` is the
  same as asserting it on all of `sourceTarget`.
- ⚠️ Nothing requires `IsOpen sourceTarget` or `IsOpen targetTarget`, and `ContDiffOn` on a set that
  is not open is weaker than smoothness of a genuine chart. Adding
  `IsOpen sourceTarget ∧ IsOpen targetTarget` would close that gap.
- The `i.1 < m` conjunct inside the `if` is only there so a `Fin m` index can be built; it follows
  from `i.1 < k` together with `hk.1`.
- `hk : k ≤ m ∧ k ≤ n` is redundant: the rank of a linear map $\mathbb{R}^m \to \mathbb{R}^n$ is at
  most $\min(m,n)$, and `hp : p ∈ U` makes the rank hypothesis non-empty. A candidate that omits
  `hk` has produced a slightly stronger, equally faithful statement and should not be penalised.
- The centring conditions $\varphi(p) = 0$, $\psi(F(p)) = 0$ are absent; see requirement row 10.
