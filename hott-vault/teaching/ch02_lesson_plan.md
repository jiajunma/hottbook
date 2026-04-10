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

### 1.1 The identity type, revisited (15 min)

In Chapter 1, we used `rfl` and moved on. Now we look deeper.

**Key shift in perspective**: an element $p : a =_A b$ is not just "evidence that $a$ equals $b$." It is a **path** from $a$ to $b$ in the space $A$.

> "The central new idea in homotopy type theory is that types can be regarded as spaces in homotopy theory. We will frequently refer to an element $p : x =_A y$ as a **path** from $x$ to $y$." — HoTT Book §2.0

```lean
-- The identity type: a = b is a type, and its elements are paths
variable (A : Type) (x y z : A)

-- rfl is the trivial path: x → x (the "stay still" path)
#check @rfl A x    -- x = x

-- A path p : x = y is a FIRST-CLASS OBJECT
-- We can ask further questions about paths themselves
variable (p : x = y) (q : y = z)
```

**What can we do with paths?** Three operations, all derived from the induction principle:

### 1.2 Path inverse (symmetry) (10 min)

If $p : x = y$, then $p^{-1} : y = x$. Paths can be reversed.

> "For every type $A$ and every $x, y : A$ there is a function $(x = y) \to (y = x)$, denoted $p \mapsto p^{-1}$, such that $\mathsf{refl}_x^{-1} \equiv \mathsf{refl}_x$." — HoTT Book, Lemma 2.1.1

```lean
-- Symmetry: if p : x = y then p.symm : y = x
#check @Eq.symm    -- {a b : α} → a = b → b = a

-- How is this defined? By path induction!
-- To define f(p) for all p : x = y,
-- it suffices to define f(rfl) when x ≡ y.
-- When p is rfl : x = x, we need y = x, which is also rfl : x = x. ✓

-- Concrete example
example (h : 1 = 1) : 1 = 1 := h.symm
```

**Proof by path induction** (the fundamental technique of Ch2):
- Want to define something for all $p : x = y$
- Suffices to handle the case $p \equiv \mathsf{rfl} : x = x$
- Everything else follows automatically from the induction principle

### 1.3 Path concatenation (transitivity) (10 min)

If $p : x = y$ and $q : y = z$, then $p \cdot q : x = z$. Paths can be joined.

> "For every type $A$ and every $x, y, z : A$ there is a function $(x = y) \to (y = z) \to (x = z)$, denoted $p \cdot q$, such that $\mathsf{refl}_x \cdot \mathsf{refl}_x \equiv \mathsf{refl}_x$." — HoTT Book, Lemma 2.1.2

```lean
-- Transitivity: Eq.trans or the ▸ notation
#check @Eq.trans    -- {a b c : α} → a = b → b = c → a = c

-- Defined by double path induction:
-- suffices to handle p = rfl, q = rfl
-- then rfl · rfl := rfl ✓

-- Lean's `calc` blocks make this readable
example (p : x = y) (q : y = z) : x = z := p.trans q

-- Or using calc:
example (p : x = y) (q : y = z) : x = z := calc
  x = y := p
  _ = z := q
```

### 1.4 The groupoid laws (15 min)

These three operations satisfy the groupoid laws — **but only up to higher paths!**

```lean
-- These are all PROPOSITIONAL equalities, not definitional:
-- 1. Left unit: rfl · p = p
-- 2. Right unit: p · rfl = p
-- 3. Left inverse: p⁻¹ · p = rfl
-- 4. Right inverse: p · p⁻¹ = rfl
-- 5. Associativity: p · (q · r) = (p · q) · r

-- Example: left unit (in Lean, this is rfl because of how trans is defined)
example (p : x = y) : (rfl).trans p = p := rfl

-- Associativity
theorem path_assoc (p : x = y) (q : y = z) (r : z = w) :
    (p.trans q).trans r = p.trans (q.trans r) := by
  cases p; cases q; cases r; rfl
```

**The crucial point**: these equalities are *themselves* paths — between paths! So we have:
- **0-paths**: points $x, y : A$
- **1-paths**: paths $p, q : x = y$
- **2-paths**: paths between paths $\alpha : p = q$  (homotopies!)
- **3-paths**: ... and so on, infinitely

> "All of the higher groupoid structure arises automatically from the induction principle for identity types." — HoTT Book §2.0

This infinite tower of paths is what makes a type into an **∞-groupoid**.

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
