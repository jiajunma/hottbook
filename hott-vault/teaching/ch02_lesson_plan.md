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

### 1.1 Three levels of equality — a concrete example (15 min)

Before any formalism, let's see the idea through concrete examples.

**Level 0: values.** Consider the natural numbers. $2$ and $3$ are values.

**Level 1: equalities between values.** $2 + 1 = 3$ is a statement — more precisely, it's a **type** in type theory, and a proof of it is an **element** of that type. We call such elements **paths**. Here, `rfl` is a path because $2 + 1$ computes to $3$ by definition.

But what about $2 + 0 = 2$? This is also true, but for a *different reason*. Lean's addition is defined by recursion on the **first** argument: $0 + n :\equiv n$, $\mathsf{succ}(m) + n :\equiv \mathsf{succ}(m + n)$. So $0 + 2$ directly reduces to $2$, but $2 + 0$ does **not** directly reduce — you need to apply a lemma (which itself requires induction). The two proofs take **different routes** to the same conclusion.

```lean
-- Two paths to "the answer is 2", via different routes:
example : 0 + 2 = 2 := rfl               -- by definition (0 + n reduces to n)
-- example : 2 + 0 = 2 := rfl            -- ✗ FAILS! 2 + 0 doesn't reduce directly
example : 2 + 0 = 2 := Nat.add_zero 2    -- needs a lemma (proved by induction)
```

**Level 2: equalities between equalities.** Now consider two functions $f, g : \mathbb{N} \to \mathbb{N}$. Suppose both satisfy $f(n) = n$ and $g(n) = n$ for all $n$. Are the *proofs* that $f = \mathsf{id}$ and $g = \mathsf{id}$ "the same proof"?

In ordinary math you'd say "who cares — they're both true." But in HoTT, the **proof itself matters**. Two different proofs of the same equation are two different **2-paths**. A 2-path is an element of the type $p = q$ where $p, q : f = g$.

```lean
-- Two functions that both equal id, but proved differently:
def f : Nat → Nat := fun n => n + 0
def g : Nat → Nat := fun n => 0 + n

-- f = id and g = id, but the PROOFS are different
-- (because f and g are defined differently)
example : f = id := funext (fun n => Nat.add_zero n)
example : g = id := funext (fun n => Nat.zero_add n)
```

**Level 3: equalities between equalities between equalities.** You can keep going. If $\alpha$ and $\beta$ are two different 2-paths (two different proofs that $p = q$), you can ask whether $\alpha = \beta$. That's a 3-path.

**The key insight: this hierarchy comes for free.** The identity type $a = b$ is a type, so we can form $(p = q)$ for $p, q : a = b$, and then $(α = β)$ for $α, β : p = q$, and so on — just by iterating the identity type. No extra machinery needed.

### 1.2 From numbers to types: where it gets interesting (5 min)

For $\mathbb{N}$, this hierarchy is **boring** above level 1: any two proofs of $m = n$ are themselves equal (there's essentially only one way to prove an equation of natural numbers). In HoTT language, $\mathbb{N}$ is a **set** — its identity types have no interesting higher structure.

But for the type **Bool**, something surprising happens (we'll see this in Part 3):

- $\mathsf{Bool} = \mathsf{Bool}$ in the universe `Type` has **two** genuinely different elements:
  - The identity equivalence $\mathsf{id} : \mathsf{Bool} \simeq \mathsf{Bool}$
  - The negation equivalence $\mathsf{not} : \mathsf{Bool} \simeq \mathsf{Bool}$
- These are **two different paths** — they cannot be identified, because `id` and `not` are genuinely different functions.

So `Type` is **not** a set. It has non-trivial 1-paths (type equivalences). And then the identity type *between* those paths might itself have structure, and so on.

**Terminology:** This layered structure — values, paths, 2-paths, 3-paths, ... with operations (composition, inverse, identity) at every level — is called an **∞-groupoid**. "Groupoid" because every path has an inverse (symmetry of equality). "∞" because the structure extends to all levels.

> "The central new idea in homotopy type theory is that types can be regarded as spaces. We will frequently refer to an element $p : x =_A y$ as a **path** from $x$ to $y$." — HoTT Book §2.0

```lean
variable (A : Type) (x y z : A)

-- A path is a first-class object
variable (p : x = y) (q : y = z)
-- p.symm : y = x       (reverse the path)
-- p.trans q : x = z     (compose two paths)
-- rfl : x = x           (the trivial path — stay put)
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

### 1.6 Loop spaces, Eckmann-Hilton, and homotopy groups (5 min)

**Loop space.** Given a pointed type $(A, a)$, the **loop space** is:

$$\Omega(A, a) :\equiv (a =_A a)$$

This is the type of all paths from $a$ back to itself — loops. It is itself a pointed type, with basepoint $\mathsf{rfl}_a$.

Iterate: $\Omega^2(A, a) = \Omega(\Omega(A, a)) = (\mathsf{rfl}_a =_{a = a} \mathsf{rfl}_a)$ — loops between loops.

```lean
-- Loop space: the type of loops at a point
def LoopSpace (A : Type) (a : A) := a = a
-- Ω²: loops between loops (2-dimensional loops)
def LoopSpace2 (A : Type) (a : A) := @rfl A a = @rfl A a
```

**Eckmann-Hilton (Theorem 2.1.6).** In $\Omega^2(A, a)$, composition is **commutative**:

$$\alpha \cdot \beta = \beta \cdot \alpha \qquad \text{for all } \alpha, \beta : \Omega^2(A, a)$$

**Important precision**: this $=$ is a **path** (propositional equality), not a definitional equality. The commutativity itself is an element of a type — a 3-path. So it too is a meaningful object that can be further investigated.

The proof works by defining two different ways to compose 2-paths — **vertical** ($\alpha \cdot_v \beta$: do $\alpha$ then $\beta$) and **horizontal** ($\alpha \star_h \beta$: do $\alpha$ and $\beta$ side by side via whiskering) — then showing:

$$\alpha \cdot_v \beta \;=\; \alpha \star_h \beta \;=\; \beta \cdot_v \alpha$$

Each $=$ is a path. Composing them gives commutativity. Every step is in the homotopy sense.

**Homotopy groups.** The $n$-th homotopy group is the loop space, truncated to a set:

$$\pi_n(A, a) :\equiv \| \Omega^n(A, a) \|_0$$

$\Omega^n$ is a full type (with all higher structure). $\pi_n$ forgets the higher structure and keeps only "how many essentially different $n$-loops are there." By Eckmann-Hilton, $\pi_n$ is an **abelian group** for $n \geq 2$.

| | $\Omega^n(A, a)$ | $\pi_n(A, a) = \|\Omega^n(A,a)\|_0$ |
|---|---|---|
| What | A type (full ∞-groupoid structure) | A set (just equivalence classes) |
| Elements | Actual $n$-loops | $n$-loops **up to homotopy** |
| Structure | Infinitely rich | Group ($n \geq 1$), abelian ($n \geq 2$) |

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
