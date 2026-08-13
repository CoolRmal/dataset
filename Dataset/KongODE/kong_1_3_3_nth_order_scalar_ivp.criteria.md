# Criteria: kong_1_3_3_nth_order_scalar_ivp

**Statement:** [kong_1_3_3_nth_order_scalar_ivp.md](kong_1_3_3_nth_order_scalar_ivp.md) · **Lean:** [kong_1_3_3_nth_order_scalar_ivp.lean](kong_1_3_3_nth_order_scalar_ivp.lean)

## What the theorem says

Take the scalar equation of order $n$, $y^{(n)} = g(t, y, y', \dots, y^{(n-1)})$, with the $n$ initial
values $y(t_0) = a_1$, $y'(t_0) = a_2$, and so on. The data live on an open set $D$ in
$\mathbb{R} \times \mathbb{R}^n$ containing the initial point. Part (a) says: if $g$ is continuous on
$D$, the problem has at least one solution on some closed time interval
$\lvert t - t_0\rvert \le \gamma$ around $t_0$. Part (b) says: if $g$ is in addition locally
Lipschitz in the $n$ state variables, that solution is the only one. The usual way to make sense of
this is to rewrite the scalar equation as a first-order system in the vector
$(y, y', \dots, y^{(n-1)})$, and that rewriting is part of what the theorem asserts.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $D$ is an open subset of $\mathbb{R} \times \mathbb{R}^n$, and the initial point $(t_0, a)$ lies in it. | ✅ `hD : IsOpen D` and `hpoint : (t₀, a) ∈ D`. |
| 2 | The equation is the **scalar** one of order $n$: the right-hand side takes $n$ real state variables and returns one real number. | ✅ `g : ℝ → (Fin n → ℝ) → ℝ`. |
| 3 | The scalar equation is turned into the first-order system $y_1' = y_2, \dots, y_{n-1}' = y_n, y_n' = g(t, y)$. | ✅ `companionField g t y i = if h : i.1 + 1 < n then y ⟨i.1 + 1, h⟩ else g t y`. |
| 4 | The $n$ initial values $y^{(i-1)}(t_0) = a_i$ are imposed together, as one vector condition. | ✅ `y t₀ = a` with `a : Fin n → ℝ`. |
| 5 | Part (a): continuity of $g$ on $D$ alone yields some $\gamma > 0$ and at least one solution. $\gamma$ is chosen after $D$, $t_0$, $a$, never fixed in advance. | ✅ The first conjunct, `ContinuousOn … D → ∃ γ, 0 < γ ∧ … ∃ y, …`. |
| 6 | "$g \in C(D, \cdot)$" is joint continuity in $(t, y)$ on $D$, not continuity in each variable separately. | ✅ `ContinuousOn (fun p : ℝ × (Fin n → ℝ) ↦ g p.1 p.2) D` on the uncurried map. |
| 7 | Part (b) adds local Lipschitz dependence on the state only, with one constant that works for every $t$ near the point. | ✅ `LocallyLipschitzInState D (companionField g)`, which gives `∀ p ∈ D, ∃ U ∈ 𝓝 p, ∃ K : ℝ≥0, ∀ t, LipschitzOnWith K (f t) …` — the `K` is bound before the `t`. |
| 8 | Part (b) asserts existence **and** uniqueness, not uniqueness alone. | ✅ The second conjunct re-states existence and then adds the uniqueness clause. |
| 9 | The time interval is the symmetric closed one $\lvert t - t_0\rvert \le \gamma$. | ✅ `let I := Set.Icc (t₀ - γ) (t₀ + γ)`. |
| 10 | A solution means a genuinely differentiable function whose derivative equals the field at every time of $I$. | ✅ `IsTrajectoryOn I (companionField g) y`, i.e. `∀ t ∈ I, HasDerivWithinAt y (companionField g t (y t)) I t`. |
| 11 | Both the produced solution and every competitor in the uniqueness clause must stay inside $D$. | ✅ `(∀ t ∈ I, (t, y t) ∈ D)` for the solution and the same guard as a hypothesis on `z`. |
| 12 | Uniqueness means any competing solution with the same initial data agrees with $y$ throughout $I$. | ✅ `Set.EqOn z y I`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Writing the equation as `deriv y t = companionField g t (y t)`. | Lean's `deriv` returns `0` wherever the function is not differentiable. So a nowhere-differentiable function satisfies the equation at every time where the field happens to vanish. The statement must use `HasDerivAt` or `HasDerivWithinAt`, which carry differentiability with them. |
| 2 | Reading "$g \in C(D,\mathbb{R}^n)$" in the transcription literally and formalizing the general first-order system $x' = g(t,x)$ with a vector-valued $g$. | That is a different, weaker theorem. The content here is the scalar equation of order $n$ and its reduction to a system; a general system loses it entirely. |
| 3 | Dropping the requirement that the competitor `z` stays in $D$. | Then uniqueness is false. `g` is a total Lean function, so its values outside $D$ are completely unconstrained; a competitor can leave $D$, be driven by those arbitrary values, and come back somewhere else, while `y` stays inside. |
| 4 | Dropping the requirement that the produced solution stays in $D$. | Without it the statement does not say the solution is a solution *of Kong's problem*, since only the values of `g` on `D` are hypothesised about. |
| 5 | Dropping part (a), or quietly adding a Lipschitz hypothesis to it. | Part (a) is Peano's theorem: existence from continuity alone. Mathlib has no Peano theorem — only Picard–Lindelöf, which needs a Lipschitz constant — so this is a tempting shortcut that changes the theorem. |
| 6 | Using `LipschitzWith K` (globally), or letting the constant `K` depend on `t`, or asking for a Lipschitz bound in the pair $(t,x)$. | The first is much stronger than "locally Lipschitz". The second and third are the wrong hypothesis: Picard–Lindelöf needs one constant valid for all times in the neighborhood, and needs no regularity in $t$ beyond continuity. |
| 7 | Assuming continuity in $t$ for each fixed $x$ and in $x$ for each fixed $t$, instead of joint continuity. | Separate continuity is strictly weaker and does not give existence. |
| 8 | Using an open interval `Ioo`, a one-sided interval `Icc t₀ (t₀ + γ)`, or asserting the conclusion for every $\gamma > 0$. | The printed statement is the two-sided closed interval $\lvert t - t_0\rvert \le \gamma$ with $\gamma$ existentially quantified. "For every $\gamma$" is false — solutions can blow up. |

## Notes on the ground truth

- Local Lipschitz dependence is asked of `companionField g` rather than of `g` itself. The two are equivalent, because the shift part of the companion field is $1$-Lipschitz in the supremum norm on `Fin n → ℝ`, so a Lipschitz bound for one gives a Lipschitz bound for the other.
- On a closed interval the literal reading of "solution on $\lvert t-t_0\rvert \le \gamma$" is a one-sided derivative at the two endpoints. `IsTrajectoryOn` uses `HasDerivWithinAt … I t`, which is exactly that, and matches what mathlib's Picard–Lindelöf API produces. An earlier version demanded the two-sided `HasDerivAt` everywhere; that was harmless for existence (shrink $\gamma$) but silently narrowed the class of competitors in the uniqueness clause, making uniqueness easier to satisfy than it should be.
- The two parts are stated as two implications conjoined in one theorem rather than as two declarations, so that the shared hypotheses `hD` and `hpoint` are written once.
