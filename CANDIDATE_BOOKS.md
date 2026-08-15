# Candidate books for expansion

The sixteen books currently in `Dataset/` are almost all analysis. This file records a search for
**freely licensed** textbooks that could become new books, judged against the dataset's selection
rule: the *theorem* should be absent from Mathlib, but the *vocabulary* needed to state it should
already be there.

Every licence below was checked by reading the copyright page or the licence file, and every
Mathlib claim was checked by grepping and reading `/Users/aaron/mathlib4`. Where something could
not be verified, it says so.

## Recommended

### 1. Haynes Miller, *Lectures on Algebraic Topology* (MIT 18.905/18.906)

- **Licence:** CC BY-NC-SA 4.0, as MIT OpenCourseWare. The 38 per-lecture PDFs at
  <https://ocw.mit.edu/courses/18-905-algebraic-topology-i-fall-2016/pages/lecture-notes/> are the
  licensed source of record.
- **Area:** algebraic topology — the largest subject hole in the collection, which has none of it.
- **Mathlib gap (verified):** `Mathlib/AlgebraicTopology/SingularHomology/` is **four files, 269
  lines total** — the singular chain complex, `H₀` of a totally disconnected space, and homotopy
  invariance. That is the entire library. Zero hits for excision, Universal Coefficient Theorem,
  Künneth, cellular homology, Borsuk–Ulam or Brouwer. Every `MayerVietoris` hit is sheaf-theoretic
  and every `VanKampen` hit is `CategoryTheory` colimits — neither is the topological theorem.
- **Vocabulary present (verified):** `Topology/Category/TopPair.lean`,
  `AlgebraicTopology/EilenbergSteenrod.lean` (which bundles relative homology functors as *data*
  without proving any instance satisfies the axioms), `Topology/CWComplex/{Abstract,Classical}`,
  `AlgebraicTopology/FundamentalGroupoid/`, `Topology/Covering/`, `GroupTheory/{CoprodI,PushoutI}`,
  and `CategoryTheory/Abelian/Ext.lean` for the UCT's Ext term.
- **Estimated new definitions:** 4–6 short ones (relative homology, the subcomplex of small chains,
  the cellular chain complex, degree of a self-map of `Sⁿ`).
- **Sample problems:** Mayer–Vietoris (Thm 11.5); the locality principle (Thm 13.5); the Universal
  Coefficient Theorem as a naturally split short exact sequence (Thm 24.1).
- **Risk:** the theorem numbers above were verified against the *consolidated* PDF, which is the
  World Scientific (2021) book and carries no open licence. Only the per-lecture OCW files are
  demonstrably CC-licensed, and their numbering must be re-checked before use.

This is the purest instance of "vocabulary present, theorems absent" anywhere in Mathlib.

### 2. The Stacks Project, Chapter 10 (*Commutative Algebra*)

- **Licence:** GFDL 1.2, verified in `COPYING` in the project repository.
- **Mathlib gap (verified):** zero hits for `CohenMacaulay`, `catenary`, Cohen structure,
  Auslander–Buchsbaum; one incidental hit for `Gorenstein`.
- **Estimated new definitions:** ~6 (depth, Cohen–Macaulay module and ring, catenary, Serre's
  conditions `(Rₖ)`/`(Sₖ)`).
- **Sample problems:** the Cohen structure theorem (tag 032A); Serre's criterion for normality
  (§10.157); Cohen–Macaulay implies universally catenary (§10.104–105).
- **Risk:** a reference work, not a course, so all curation is on the selector — and the first third
  of Chapter 10 maps almost one-for-one onto existing Mathlib, so a careless pick yields a
  copy-from-Mathlib problem.

### 3. John Voight, *Quaternion Algebras* (GTM 288)

- **Licence:** CC BY-NC 4.0 — a genuinely open-access Springer GTM. The cleanest licence in the batch.
- **Mathlib gap (verified):** zero hits for `hilbertSymbol` or `SkolemNoether`.
- **Estimated new definitions:** 5–6 (Hilbert symbol over a local field, the ramification set,
  reduced norm and trace).
- **Sample problems:** the four-way characterisation of split quaternion algebras (Main Thm 5.4.4);
  uniqueness of the division quaternion algebra over a local field (Main Thm 12.3.2).
- **Risk:** several of the best results are *bijections between classes of objects*, an awkward
  formalization idiom where getting the equivalence relation right is most of the work.

### 4. Judith Roitman, *Introduction to Modern Set Theory*

- **Licence:** CC BY-NC-ND 3.0, verified on the copyright page.
- **Mathlib gap (verified):** zero hits for `ErdosRado`; Silver's theorem, Martin's Axiom and
  Aronszajn/Suslin trees also absent. **Correction to note:** Mathlib *does* have Fodor's lemma
  (`SetTheory/Cardinal/Cofinality/Club.lean`) with `IsClub` and `IsStationary`, so §7.6 is partly
  covered.
- **Risk:** the statements are terse — Erdős–Rado is literally the one line `(2^λ)⁺ → (λ⁺)²₂`. The
  difficulty is real but hidden inside the arrow notation, which cuts against the preference for
  long multi-hypothesis statements.

### 5. Jiří Lebl, *Tasty Bits of Several Complex Variables*

- **Licence:** dual CC BY-SA 4.0 / CC BY-NC-SA 4.0, verified on the copyright page.
- **Sample problems:** Cartan's uniqueness theorem (1.5.1); Rothstein — no proper holomorphic map
  from the polydisc onto the ball (1.4.4); the Hartogs phenomenon (4.3.1).
- **Risk:** the weakest diversity case here — a seventeenth analysis book. And Mathlib has **no
  subharmonic functions at all** (verified: zero hits for `plurisubharmonic`), so anything touching
  plurisubharmonicity, the Levi form or pseudoconvexity costs far more than it first appears.

## The licence problem

The two best *mathematical* fits found anywhere in the search cannot be recommended, because their
licences could not be verified:

- **Hug–Weil, *A Course on Convex Geometry*.** The cleanest sweet spot in the whole search:
  `Brunn` occurs exactly once in all of Mathlib, as a bibliography line in
  `Analysis/Convex/Intrinsic.lean`, while `ConvexBody` already carries the Hausdorff metric and
  Minkowski addition. But the notes carry no licence statement at all and are the preprint of
  Springer GTM 286.
- **Sarig, *Lecture Notes on Ergodic Theory*.** Nearly as good — Mathlib defines `birkhoffAverage`,
  `Ergodic` and `condExp` but never connects them, and the only "ergodic theorem" strings in the
  library are docstring asides and a TODO. Licence unverified.

**A decision worth making explicitly.** Bruce Sagan's *Combinatorics: The Art of Counting* (AMS GSM
210) is the best content fit in the batch — Matrix-Tree (Thm 2.6.4), the hook length formula
(Thm 7.3.1), Redfield–Pólya (6.4.2), Jacobi–Trudi (7.2.3), all verified absent from Mathlib while
`SemistandardTableau` and the symmetric-function bases already exist. But it is not CC and not
public domain: it is an author-hosted PDF posted with AMS permission, and the AMS wording forbids
reposting. It clears "an author-hosted text the author explicitly permits free download" but fails
"freely and legally redistributable". Enumerative combinatorics is the largest untouched area after
algebraic topology and no open book covers it, so this is the choice: accept Sagan under the weaker
reading, or leave combinatorics unfilled. The fallback with the strongest wording is *A=B*
(Petkovšek–Wilf–Zeilberger), which grants explicit permission to reproduce for educational purposes.

## Rejected, with reasons

| Book | Reason |
|---|---|
| Hatcher, *Algebraic Topology* | Free to read on the author's page, but no redistribution licence. Mathematically the best book in the area. |
| Milne's course notes (ANT, CFT, Algebraic Geometry) | "Single paper copies for noncommercial personal use" — not redistributable. |
| Vakil, *The Rising Sea* | Contradictory licence: the site asserts CC BY-NC-ND 3.0, the PDF front matter does not. |
| Diestel, *Graph Theory* | Free online viewing only; eBook editions are paid. |
| Stanley, *Enumerative Combinatorics* vol. 1 | Licence unverifiable; the author's page hosts only errata and supplements. |
| Etingof et al., *Introduction to Representation Theory* | arXiv nonexclusive-distrib licence is not redistributable. |
| Kerodon | No licence statement; the repository `COPYING` path 404s. |
| Gathmann, *Algebraic Geometry*; Gudmundsson, *Riemannian Geometry* | No licence or permission statement anywhere. |
| J. P. May, *A Concise Course* | No numbered theorems, so problems cannot be cited precisely. |
| Judson, *Abstract Algebra*; The CRing Project; The Open Logic Project | Licences are fine (GFDL / CC BY), but the content is undergraduate and lies inside Mathlib. |
| Whittaker & Watson, *A Course of Modern Analysis* | Public domain and beautifully numbered, but Mathlib has eaten the best chapters. |
| Hardy, *Divergent Series*; Titchmarsh | Not public domain in the US until 2044. *Divergent Series* is otherwise an excellent fit. |
| Zhao, *Graph Theory and Additive Combinatorics* | Licence unverified, and Mathlib already proves Turán, Erdős–Stone–Simonovits, Szemerédi regularity and triangle removal. |

## Two corrections to earlier assumptions

- Mathlib **does** have Fodor's lemma, with `IsClub`, `IsStationary` and diagonal intersection.
- `Combinatorics/SimpleGraph/Extremal/Zarankiewicz.lean` now exists, but it only *defines* the
  Zarankiewicz function; Kővári–Sós–Turán itself is still unproved.
