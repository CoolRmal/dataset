# Context: mattila_12_14_falconer_distance_set

**Statement:** [mattila_12_14_falconer_distance_set.md](mattila_12_14_falconer_distance_set.md) · **Criteria:** [mattila_12_14_falconer_distance_set.criteria.md](mattila_12_14_falconer_distance_set.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

$D(A)=\{|x-y| : x,y \in A\}$ is a set of **distances**, a subset of $\mathbb{R}$. The two parts differ in strictness, and the difference is content. Part (1)'s hypothesis is the strict $\dim A > \frac{n+1}{2}$; the theorem does not claim positive measure at the threshold itself. Part (2) has a **two-sided** hypothesis, **non-strict at both ends**: $\frac{n-1}{2} \le \dim A \le \frac{n+1}{2}$, endpoints included — at the upper endpoint the conclusion already says $\dim D(A) \ge 1$, a case nothing else in the theorem covers, so reading either bound as strict is a misreading. Part (2)'s conclusion is the non-strict $\dim D(A) \ge \dim A - \frac{n-1}{2}$; no strict gain is claimed.
