# Context: hardy_average_and_tail_memLp

**Statement:** [hardy_average_and_tail_memLp.md](hardy_average_and_tail_memLp.md) · **Criteria:** [hardy_average_and_tail_memLp.criteria.md](hardy_average_and_tail_memLp.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Hardy's averaging operator and its adjoint

**$L^p(0,+\infty)$.** The Lebesgue space of the open half-line with ordinary Lebesgue measure, and
$p$ is a real number with $p>1$ (strictly). The exercise is about the half-line only; on all of
$\mathbb{R}$ the operator $\psi$ does not even make sense.

**The two operators.** $\varphi$ is the *averaging* (Hardy) operator: $\varphi(x)$ is the mean value
of $f$ over $(0,x)$, that is $\frac1x\int_0^x f(t)\,dt$. The factor $1/x$ is essential; without it the
claim is false. $\psi$ is the formal adjoint of the Hardy operator, the weighted tail
$\int_x^{+\infty} f(t)\,\frac{dt}{t}$; the weight $1/t$ is likewise essential.

**Both integrals need to converge.** Part of the content is that these formulas define finite numbers
for almost every $x>0$: for $f \in L^p$ with $p>1$, Hölder's inequality gives $f$ locally integrable
near $0$ and $t \mapsto f(t)/t$ integrable on $(x,\infty)$ for each $x>0$. A formalization that
silently reads a divergent integral as $0$ would be asserting something else entirely.

**Why $p>1$ is strict.** At $p=1$ the statement is false. Take $f$ the indicator of $(0,1)$: it lies
in $L^1(0,\infty)$, but $\varphi(x)=1/x$ for $x>1$, which is not integrable on $(1,\infty)$. At
$p=\infty$ it fails too: for $f \equiv 1$, $\psi(x)=\int_x^\infty dt/t = \infty$ for every $x$.

**What is asserted.** Only membership: $\varphi, \psi \in L^p(0,+\infty)$. The sharp norm inequality
$\|\varphi\|_p \le \frac{p}{p-1}\|f\|_p$ (Hardy's inequality) is a strictly stronger statement that the
exercise does not ask for.
