---
type: teaching
title: "Chapter 2 Lesson Plan: Homotopy Type Theory"
tags: [teaching, lesson-plan, homotopy-type-theory, chapter-2, lean]
audience: CS freshmen (completed Ch1 lesson)
tool: "Lean 4: live.lean-lang.org or prove.reaslab.io/playground"
total_hours: 3
lectures: 1
prerequisite: "[[teaching/ch01_lesson_plan]]"
---

# Chapter 2: Homotopy Type Theory (Single 3h Lecture)

**Prerequisite**: [[teaching/ch01_lesson_plan]] (Ch1: Dependent Type Theory)
**Tool**: [live.lean-lang.org](https://live.lean-lang.org) or [prove.reaslab.io/playground](https://prove.reaslab.io/playground)

**Covers**: HoTT Book Chapter 2, §2.1–§2.10 (core), §2.11–§2.15 (overview)

**The big idea**: In Chapter 1, we saw that $a =_A b$ is a *type*. In Chapter 2, we discover that this type has incredibly rich structure — identity proofs are not just "yes/no" but form *paths* in a *space*, with operations that mirror topology.

---

## Pre-class recap

Students should be comfortable with:
- `#check`, `#eval`, `def`, `theorem`, `inductive`
- Pattern matching, recursion, induction
- `rfl`, basic tactic proofs
- Π-types, Σ-types, Curry-Howard

---

## Part 1: Paths and the groupoid structure (50 min)

> §2.1 Types are higher groupoids

### 1.1 A physical analogy: walking in a room (10 min)

Before any formalism, let's build intuition with a physical picture.

**Imagine a room.** There are two people, Alice (at point $A$) and Bob (at point $B$).

**1-paths = ways to walk.** A "path from $A$ to $B$" is a specific route Alice can walk to reach Bob. There might be many different routes — around the left side of a table, or around the right.

```
    A ───route p───→ B
    A ───route q───→ B
```

**When are two routes "the same"?** If you can continuously deform one into the other without hitting an obstacle. Walking slightly to the left or slightly to the right of the same route — those are "the same." But if there's a **pillar** in the middle, walking left around it and walking right around it are **genuinely different** routes — you can't morph one into the other without passing through the pillar.

**2-paths = deformations between routes.** A "2-path from $p$ to $q$" is a continuous deformation of route $p$ into route $q$. If $p$ goes left of the pillar and $q$ goes right, no such deformation exists. If $p$ and $q$ both go left but take slightly different curves, a deformation does exist.

```
    A ═══════════→ B
    ↑  deformation  ↑
    A ═══════════→ B
```

**3-paths = deformations between deformations.** If there are two different ways to deform route $p$ into route $q$, we can ask whether those two deformations are themselves "the same." An answer to that question is a 3-path.

**This goes on forever** — in principle. For most rooms (3D spaces), 3-paths and above are all trivial. But in higher-dimensional spaces, or in type theory, they can be non-trivial.

**Three operations on routes:**
1. **Reverse**: walk the route backwards. ($p^{-1}$)
2. **Compose**: walk route $p$ then route $q$. ($p \cdot q$)
3. **Stand still**: don't move. ($\mathsf{rfl}$)

These satisfy "group-like" laws: $p \cdot p^{-1} \approx \mathsf{rfl}$, $p \cdot \mathsf{rfl} \approx p$, $(p \cdot q) \cdot r \approx p \cdot (q \cdot r)$. But only **approximately** — the $\approx$ means "there exists a 2-path (deformation) between them," not that they are identical routes.

**This structure — points, paths, deformations, deformations of deformations, ... with composition, inverse, and identity at every level — is called an ∞-groupoid.** "Groupoid" because every arrow has an inverse (you can always walk backwards). "∞" because the structure exists at every level, all the way up.

### 1.2 Types are ∞-groupoids (10 min)

The amazing discovery of HoTT:

> **Every type in type theory automatically has this structure.**

| Physical picture | Type theory |
|---|---|
| Room (space) | Type $A$ |
| Points in the room | Elements $x, y : A$ |
| Routes from $A$ to $B$ | Paths $p : x =_A y$ |
| Deformations between routes | 2-paths $\alpha : p =_{(x=y)} q$ |
| Deformations of deformations | 3-paths $\beta : \alpha = \alpha'$ |
| Stand still at $A$ | $\mathsf{rfl}_x : x = x$ |
| Walk backwards | $p^{-1} : y = x$ (symmetry) |
| Walk $p$ then $q$ | $p \cdot q : x = z$ (transitivity) |

> "The central new idea in homotopy type theory is that types can be regarded as spaces. We will frequently refer to an element $p : x =_A y$ as a **path** from $x$ to $y$." — HoTT Book §2.0

For **simple types** like `Nat`, the identity type is boring: the only path from $n$ to $n$ is `rfl`, and there are no non-trivial 2-paths. (This is like a room with no obstacles — every route can be deformed into every other.)

But for **complex types** like the universe `Type` itself, the identity type has rich structure. (This is like a room full of pillars — routes can go around them in genuinely different ways.) We will see this concretely when we discuss univalence in Part 3.

```lean
-- In Lean:
variable (A : Type) (x y z : A)

-- rfl = "stand still"
#check @rfl A x    -- x = x

-- A path is a first-class object — we can ask questions about it
variable (p : x = y) (q : y = z)
-- p.symm : y = x       (reverse)
-- p.trans q : x = z     (compose)
```

### 1.3 Path operations, derived from J (10 min)

All three operations come from the **path induction principle (J rule)**:

> To define/prove something for all paths $p : x = y$, it suffices to handle the single case $p \equiv \mathsf{rfl} : x = x$.

**Inverse** (walk backwards):

```lean
-- To define p.symm for all p : x = y, handle p = rfl:
-- when p = rfl : x = x, we need x = x → just give rfl. ✓
#check @Eq.symm    -- a = b → b = a
example (p : x = y) : y = x := p.symm
```

**Concatenation** (walk $p$ then $q$):

```lean
-- To define p.trans q for all p : x = y, handle p = rfl:
-- when p = rfl : x = x, we need (x = z) given q : x = z → just give q. ✓
#check @Eq.trans   -- a = b → b = c → a = c
example (p : x = y) (q : y = z) : x = z := p.trans q
```

### 1.4 The groupoid laws — and why they produce 2-paths (10 min)

These operations satisfy group-like laws:

```lean
-- All proved by: cases on the paths (J rule), then rfl.
example (p : x = y) : (rfl).trans p = p := rfl
theorem right_unit (p : x = y) : p.trans rfl = p := by cases p; rfl
theorem trans_inv  (p : x = y) : p.trans p.symm = rfl := by cases p; rfl
theorem inv_inv    (p : x = y) : p.symm.symm = p := by cases p; rfl
theorem path_assoc (p : x = y) (q : y = z) (r : z = w) :
    (p.trans q).trans r = p.trans (q.trans r) := by
  cases p; cases q; cases r; rfl
```

**Key observation**: `right_unit p` has type `p.trans rfl = p`. This type is an identity type between two paths — it's the type of **2-paths** from `p.trans rfl` to `p`. And `right_unit p` is one particular 2-path (one particular deformation).

Similarly, `path_assoc p q r` is a 2-path. And any equation between `right_unit` and `path_assoc` would be a **3-path**. This continues forever.

### 1.5 All structure from J — with examples (10 min)

> "All of the higher groupoid structure arises automatically from the induction principle for identity types." — HoTT Book §2.0

**Why does J alone generate infinitely many levels of structure?**

The trick is always the same. At every level:
1. We want to define/prove something about paths
2. J reduces it to the `rfl` case
3. In the `rfl` case, everything is trivially equal
4. `rfl` finishes it

**Layer 1 — paths.** We defined inverse and concatenation. (J → handle rfl → done.)

**Layer 2 — 2-paths.** We proved groupoid laws. Each proof, like `right_unit p : p.trans rfl = p`, is a 2-path. (J → handle rfl → both sides collapse → done.)

**Layer 3 — 3-paths.** Any two 2-paths between the same endpoints are themselves equal:

```lean
-- A 3-path: two proofs that p.symm.symm = p are equal
theorem three_path (p : x = y) :
    let proof1 : p.symm.symm = p := by cases p; rfl
    let proof2 : p.symm.symm = p := by cases p; rfl
    proof1 = proof2 := by cases p; rfl
-- Same trick: cases on p → both proofs become rfl → they're equal.
```

**Layer 4, 5, ...** — the same trick works forever. At each level, `cases` reduces everything to `rfl`, and `rfl` finishes it.

| Layer | Lives here | Example | Proof method |
|---|---|---|---|
| 0 | Points $x : A$ | $0 : \mathbb{N}$ | — |
| 1 | Paths $p : x = y$ | inverse, concatenation | J (cases; rfl) |
| 2 | 2-paths $\alpha : p = q$ | `right_unit`, `path_assoc` | J (cases; rfl) |
| 3 | 3-paths $\beta : \alpha = \alpha'$ | `three_path` above | J (cases; rfl) |
| $n$ | $n$-paths | coherence of coherences | J (cases; rfl) |

**Why is this remarkable?**

In classical mathematics, defining an ∞-groupoid requires specifying infinitely many operations and coherence conditions by hand. This is so complex that several competing definitions exist, and mathematicians debated for decades which one is "correct."

In type theory, you specify **nothing** — just one constructor (`rfl`) and one eliminator (J). The entire infinite tower of structure emerges automatically. This is what makes homotopy type theory a **synthetic** theory of spaces: the structure isn't built from coordinates and formulas, it's built into the fabric of the type system itself.

---

*— 10 min break —*

---

## Part 2: Functions on paths (50 min)

> §2.2 Functions are functors, §2.3 Type families are fibrations, §2.4 Homotopies and equivalences

### 2.1 ap: functions act on paths (15 min)

If $f : A \to B$ and $p : x =_A y$, then $f$ maps the path $p$ to a path $\mathsf{ap}_f(p) : f(x) =_B f(y)$.

> "Functions $f : A \to B$ behave functorially on paths. Topologically, this corresponds to saying that every function is 'continuous', i.e., preserves paths." — HoTT Book §2.2

```lean
-- ap (action on paths): applies f to a path
#check @congrArg  -- (f : α → β) → a = b → f a = f b

-- In Lean 4, this is congrArg or the ▸ mechanism
example (f : Nat → Nat) (p : x = y) : f x = f y :=
  congrArg f p

-- ap preserves path operations (functoriality):
-- ap f (p · q) = ap f p · ap f q
-- ap f (p⁻¹) = (ap f p)⁻¹
-- ap g (ap f p) = ap (g ∘ f) p
-- ap id p = p
```

**Slogan**: every function in type theory is automatically "continuous" — it maps paths to paths, homotopies to homotopies, etc. There is no notion of a "discontinuous" function.

### 2.2 Transport: moving data along paths (20 min)

This is the dependent version of `ap`. Given a type family $P : A \to \mathsf{Type}$ and a path $p : x =_A y$, we get a function $\mathsf{transport}^p : P(x) \to P(y)$.

> "If $P$ is a type family over $A$ and $p : x =_A y$, then there is a function $\mathsf{transport}^p : P(x) \to P(y)$." — HoTT Book, Lemma 2.3.1

```lean
-- Transport: move data along a path
-- transport P p : P x → P y   (when p : x = y)

-- Lean's ▸ notation IS transport
example (P : Nat → Type) (p : n = m) (u : P n) : P m :=
  p ▸ u

-- Define it ourselves to see what's happening:
def myTransport {A : Sort u} (P : A → Sort v) {x y : A} (p : x = y) : P x → P y :=
  fun u => p ▸ u

-- Concrete example: if we prove 3 = 3, transport is the identity
example : myTransport (fun n => Vector Nat n) rfl = id := rfl

-- Concrete example: transport along a proof that n = m
-- converts a "vector of length n" into a "vector of length m"
-- This is the dependent version of ap.
```

**Intuition**: think of $P : A \to \mathsf{Type}$ as a "fiber bundle." Each point $x : A$ has a fiber $P(x)$ sitting above it. A path $p : x = y$ lets you "slide" data from fiber $P(x)$ to fiber $P(y)$.

```
P(x)         P(y)
  |             |
  u ---transport---> p ▸ u
  |             |
  x -----p----> y       (base space A)
```

**Intuition**: think of $P : A \to \mathsf{Type}$ as a "fiber bundle." Each point $x : A$ has a fiber $P(x)$ sitting above it. A path $p : x = y$ in the base $A$ lets you "slide" data from fiber $P(x)$ to fiber $P(y)$. This is the **path lifting property** of fibrations.

```
P(x)         P(y)
  |             |
  u ~~transport~~> transport p u
  |             |
  x ----p----> y       (base space A)
```

### 2.3 Homotopies and equivalences (15 min)

A **homotopy** between $f, g : A \to B$ is a pointwise identification:

$$f \sim g \;:\equiv\; \prod_{(x:A)} f(x) = g(x)$$

> "A homotopy from $f$ to $g$ is a dependent function of type $(f \sim g) :\equiv \prod_{(x:A)} (f(x) = g(x))$." — HoTT Book, Definition 2.4.1

```lean
-- Homotopy = pointwise equality
def Homotopy (f g : α → β) := ∀ x, f x = g x

-- Note: homotopy f ~ g is NOT the same as f = g
-- (but function extensionality will connect them — see §2.9)
```

An **equivalence** $A \simeq B$ is a function $f : A \to B$ with a two-sided inverse up to homotopy. Several equivalent definitions exist (quasi-inverse, half-adjoint, bi-invertible); the book discusses why the naive "quasi-inverse" definition is subtly wrong.

```lean
-- Define equivalence ourselves (no Mathlib needed)
structure MyEquiv (α β : Sort u) where
  toFun : α → β
  invFun : β → α
  left_inv : ∀ a, invFun (toFun a) = a
  right_inv : ∀ b, toFun (invFun b) = b

-- Example: Bool ≃ Bool via negation
def boolNotEquiv : MyEquiv Bool Bool where
  toFun := not
  invFun := not
  left_inv := fun b => by cases b <;> rfl
  right_inv := fun b => by cases b <;> rfl

-- The identity equivalence always exists
def boolIdEquiv : MyEquiv Bool Bool where
  toFun := id;  invFun := id
  left_inv := fun _ => rfl
  right_inv := fun _ => rfl

-- So Bool ≃ Bool has (at least) two elements!
-- This is key for univalence later.
```

---

*— 10 min break —*

---

## Part 3: Paths in type formers, and the two axioms (50 min)

> §2.5–§2.8 Paths in specific types, §2.9 Function extensionality, §2.10 Univalence

### 3.1 Characterizing paths in each type (20 min)

A key theme of Ch2: for each type former from Ch1, we can **characterize** what paths look like in the resulting type.

| Type | Path $p : a =_T b$ looks like... | HoTT § |
|---|---|---|
| $A \times B$ | a pair of paths $(p_1, p_2)$ with $p_1 : a.1 = b.1$ and $p_2 : a.2 = b.2$ | §2.6 |
| $\sum_{(x:A)} B(x)$ | a path $p : a.1 = b.1$ in the base + a path in the fiber over transport | §2.7 |
| $\mathbf{1}$ | trivial — any two elements of Unit are equal | §2.8 |
| $A + B$ | $\mathsf{inl}(a) = \mathsf{inl}(a')$ iff $a = a'$; $\mathsf{inl} \neq \mathsf{inr}$ | §2.12 |
| $\mathbb{N}$ | $0 \neq \mathsf{succ}(n)$; $\mathsf{succ}(m) = \mathsf{succ}(n)$ iff $m = n$ | §2.13 |

```lean
-- Paths in products: a = b iff componentwise equal
example (a b : α × β) : a = b ↔ (a.1 = b.1 ∧ a.2 = b.2) := by
  constructor
  · intro h; exact ⟨congrArg Prod.fst h, congrArg Prod.snd h⟩
  · intro ⟨h1, h2⟩; exact Prod.ext h1 h2

-- Paths in Nat: succ is injective, 0 ≠ succ n
#check Nat.succ_injective   -- succ m = succ n → m = n
#check Nat.noConfusion       -- 0 ≠ succ n (derived)
```

### 3.2 Function extensionality (10 min)

Two functions are equal if and only if they agree on all inputs:

$$(f =_{A \to B} g) \;\simeq\; \prod_{(x:A)} f(x) = g(x)$$

This is **not provable** from the rules of Ch1 alone. It is our first **axiom**.

> "The type theory of Chapter 1 is insufficient to guarantee this. Thus we formulate this property as an axiom: function extensionality." — HoTT Book §2.9

```lean
-- In Lean, function extensionality is built in
example (f g : α → β) (h : ∀ x, f x = g x) : f = g :=
  funext h

-- funext converts a homotopy (∀ x, f x = g x) into a path (f = g)
```

### 3.3 The univalence axiom (20 min)

This is **the** central axiom of HoTT. It says:

$$(A =_{\mathsf{Type}} B) \;\simeq\; (A \simeq B)$$

Two types are *equal* (in the universe) if and only if they are *equivalent* (as types).

> "Given two types $A$ and $B$, we may form the identity type $A =_\mathsf{Type} B$. **Univalence** is the identification of $A =_\mathsf{Type} B$ with the type $A \simeq B$ of equivalences." — HoTT Book §2.10

**Why is this remarkable?**

1. **Equality of types is meaningful.** In ZFC, asking whether two sets are "equal" is either trivial (they have the same elements) or meaningless (depends on encoding). Univalence says: two types are equal precisely when they are interchangeable.

2. **Structure identity principle.** If two groups are isomorphic, they are *equal as groups*. No need for "up to isomorphism" — isomorphic things are literally the same.

3. **Topological meaning.** Paths in the universe correspond to equivalences. The universe $\mathsf{Type}$ is not a discrete space — it has non-trivial topology!

```lean
-- The canonical map: idtoeqv : (A = B) → (A ≃ B)
-- Defined by transport: if p : A = B, then transport p is an equivalence.
-- Univalence says idtoeqv is ITSELF an equivalence:
-- (A = B) ≃ (A ≃ B)

-- Forward direction (always available, no axiom needed):
def idtoeqv (p : α = β) : MyEquiv α β where
  toFun := p ▸ id
  invFun := p.symm ▸ id
  left_inv := fun a => by cases p; rfl
  right_inv := fun b => by cases p; rfl

-- Bool ≃ Bool concretely has TWO elements:
-- boolIdEquiv (identity) and boolNotEquiv (negation)
-- They are genuinely different:
example : boolIdEquiv.toFun true = true := rfl
example : boolNotEquiv.toFun true = false := rfl

-- By univalence, each gives a DIFFERENT path Bool = Bool.
-- So (Bool = Bool) in the universe has two distinct elements.
-- The universe Type is NOT a set — it has non-trivial loops!
```

**Why "Bool = Bool" has two proofs:**
- The identity equivalence $\mathsf{id} : \mathsf{Bool} \simeq \mathsf{Bool}$
- The negation equivalence $\mathsf{not} : \mathsf{Bool} \simeq \mathsf{Bool}$

By univalence, these correspond to two *different paths* from Bool to Bool in the universe. This means the universe $\mathsf{Type}$ is not a "set" (in the HoTT sense) — it has non-trivial loops!

---

## Summary (5 min)

### What Chapter 2 added to Chapter 1

| Chapter 1 | Chapter 2 |
|---|---|
| $a = b$ is a type | $a = b$ is a **space of paths** |
| `rfl` is the only constructor | paths have **inverse**, **concatenation**, **groupoid laws** |
| Functions map values | Functions **map paths** (ap, functoriality) |
| Type families assign types | Type families are **fibrations** (transport) |
| Types are "sets" | Types are **∞-groupoids** |
| No axioms | Two axioms: **funext** and **univalence** |

### The slogan

> **Type theory is synthetic homotopy theory.**
> Points, paths, and higher paths are primitive.
> All structure arises from the identity type induction principle.

---

## Exercises

### A. Paths

1. Prove by path induction:
   ```lean
   theorem symm_symm (p : x = y) : p.symm.symm = p := sorry
   theorem trans_symm (p : x = y) : p.trans p.symm = rfl := sorry
   ```

2. Show that `ap` preserves composition:
   ```lean
   theorem ap_trans (f : α → β) (p : x = y) (q : y = z) :
       congrArg f (p.trans q) = (congrArg f p).trans (congrArg f q) := sorry
   ```

### B. Transport

3. If `P : Nat → Type` and `p : n = m`, describe what `transport p` does to an element of `P n`. Verify in Lean using `▸`.

4. Define `transport` yourself using `match`:
   ```lean
   def myTransport (P : α → Type) (p : a = b) (u : P a) : P b := sorry
   ```

### C. Thinking

5. Why can't we prove function extensionality from the rules of Chapter 1 alone? What goes wrong if you try?

6. Explain in your own words: why does "Bool ≃ Bool has two elements" mean that `Type` is not a set?

7. In classical math, we say "isomorphic groups are the same up to isomorphism." What does univalence change about this?
