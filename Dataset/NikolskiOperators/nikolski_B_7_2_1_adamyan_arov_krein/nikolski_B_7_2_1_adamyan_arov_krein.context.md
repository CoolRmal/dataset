# Context: nikolski_B_7_2_1_adamyan_arov_krein

**Statement:** [nikolski_B_7_2_1_adamyan_arov_krein.md](nikolski_B_7_2_1_adamyan_arov_krein.md) · **Criteria:** [nikolski_B_7_2_1_adamyan_arov_krein.criteria.md](nikolski_B_7_2_1_adamyan_arov_krein.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

$s_n$ is the distance to operators of rank $\le n$; the second quantity restricts to **Hankel** ones, and that these agree is the theorem. $R_n$ is the rational functions vanishing at $\infty$ with poles in $\mathbb{D}$ of total multiplicity $\le n$ — it **contains $0$**. The degree of a finite Blaschke product is its number of zeros with multiplicity. In the last quantity the symbol is $B\varphi$: the Blaschke product **itself** multiplies $\varphi$, with no conjugate on $B$. This is what makes the term match the others — since $|B| = 1$ on the circle, $\|H_{B\varphi}\|$ is the distance from $\varphi$ to $\bar B H^\infty$, and letting $B$ range over degree $\le n$ sweeps out exactly $R_n + H^\infty$. Reading it as $\bar B\varphi$ is wrong: $\|H_{\bar B\varphi}\|$ is then the distance from $\varphi$ to $B H^\infty \subseteq H^\infty$, so every term of that minimum is at least the distance from $\varphi$ to $H^\infty$, and $B \equiv 1$ attains it — the minimum would always equal $s_0(H_\varphi)$ and the chain would wrongly force $s_n = s_0$ for every $n$.
