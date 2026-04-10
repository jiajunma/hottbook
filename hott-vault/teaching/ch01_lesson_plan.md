---
type: teaching
title: "Chapter 1 Lesson Plan: Type Theory"
tags: [teaching, lesson-plan, type-theory, chapter-1, lean]
audience: CS freshmen (all know C)
tool: "Lean 4: live.lean-lang.org or prove.reaslab.io/playground"
total_hours: 3
lectures: 1
---

# Chapter 1: Dependent Type Theory (Single 3h Lecture)

**Roadmap**: [[teaching/00_roadmap]]
**Symbol guide**: [[teaching/symbol_guide]]
**Concept index**: [[Foundations/00_MOC]]

**Tool**: [live.lean-lang.org](https://live.lean-lang.org) or [prove.reaslab.io/playground](https://prove.reaslab.io/playground)

**Covers**: HoTT Book Chapter 1, §1.1–§1.12

---

## Pre-class setup

Students open one of the URLs above and verify they can run:
```lean
#eval 2 + 3
```

---

## Part 1: Types and Functions (50 min)

> §1.1 Judgments, §1.2 Function types, §1.5 Products, §1.7 Coproducts

### 1.0 Why type theory? Set theory vs type theory (10 min)

**Set theory has two layers; type theory has one.**

In ZFC set theory, the foundation has two separate parts:
- **Layer 1**: First-order logic (the deductive system — how to reason)
- **Layer 2**: Set-theoretic axioms (what sets exist — ZFC)

Propositions and sets are different kinds of things. You reason *about* sets using logic.

Type theory collapses this into **one layer**: **types** play the role of both sets and propositions simultaneously. Proving a theorem = constructing an element of a type. There is no separate logical layer.

> "Type theory is its own deductive system: it need not be formulated inside any superstructure, such as first-order logic. Instead of the two basic notions of set theory, sets and propositions, type theory has one basic notion: *types*." — HoTT Book §1.1

**The key structural differences:**

| | Set theory (ZFC) | Type theory |
|---|---|---|
| Layers | Two (logic + axioms) | One (types) |
| Membership | $a \in A$ is a **proposition** (can be true or false) | $a : A$ is a **judgment** (either holds or doesn't — cannot be negated) |
| Elements | Exist independently; then you ask "$a \in A$?" | Cannot exist without a type; "$a : A$" is atomic |
| Content | In the axioms | In the rules |
| Computation | Not built in | Built in (β-reduction, canonicity) |

**Russell's paradox and why type theory avoids it.**

In naive set theory, you can form "the set of all sets that don't contain themselves":

$$R = \{x \mid x \notin x\}$$

Then ask: $R \in R$? If yes, then $R \notin R$. If no, then $R \in R$. Contradiction.

ZFC avoids this by restricting comprehension (you can only form subsets of existing sets). But in type theory, the paradox **can't even be stated**:

1. **No self-membership.** In type theory, $a : A$ means $a$ is a term and $A$ is a type — they live at different levels. You cannot write $A : A$ (a type "containing itself") because types and their elements are categorically different things.

2. **Universe hierarchy.** If you want types to be elements of something, you need a **universe**: $\text{Nat} : \text{Type}$. But then what is the type of $\text{Type}$ itself? Not $\text{Type} : \text{Type}$ — that would re-enable the paradox! Instead:

$$\text{Type}_0 : \text{Type}_1 : \text{Type}_2 : \cdots$$

Each universe lives in the next one up. There is no "universe of all universes."

> "A universe is a type whose elements are types. We might wish for a universe of all types including itself. However, this is unsound — we can deduce from it that every type, including the empty type, is inhabited. Using a representation of sets as trees, we can directly encode Russell's paradox." — HoTT Book §1.3

```lean
-- Lean enforces the universe hierarchy
#check Nat        -- Nat : Type      (i.e., Type 0)
#check Type       -- Type : Type 1
#check Type 1     -- Type 1 : Type 2
-- No Type : Type — that would be Russell's paradox!
```

3. **Membership is not a proposition.** You cannot write "$A \notin A$" because $a : A$ is a judgment, not a proposition. There is nothing to negate. The sentence "the type of all types that don't contain themselves" is **grammatically ill-formed** in type theory.

**In short:** set theory patches the paradox after the fact (by restricting axioms). Type theory prevents it structurally (by stratification). The paradox isn't avoided — it's **inexpressible**.

### 1.1 Entering Lean (10 min)

```lean
-- Every expression has a type
#check 42            -- 42 : Nat
#check "hello"       -- "hello" : String
#check true          -- true : Bool
#check fun x => x    -- ? → ?  (let them guess)

-- Evaluation
#eval 2 + 3                    -- 5
#eval (fun x => x + x) 21     -- 42
```

`#check` is the typing judgment $a : A$. Every value **must** have a type — no exceptions.

### 1.2 Definitions and two kinds of equality (10 min)

```lean
def sq (x : Nat) : Nat := x * x

-- Definitional equality: Lean unfolds the definition and sees it
example : sq 3 = 9 := rfl     -- rfl suffices

-- Propositional equality: requires proof
-- example : ∀ n, n + 0 = n := rfl   -- ✗ won't work; n is a variable
```

| | Definitional equality | Propositional equality |
|---|---|---|
| HoTT notation | $a \equiv b$ | $a =_A b$ |
| Lean criterion | `rfl` works | need a proof |
| Essence | unfold definitions | requires reasoning |

**Remark.** Definitional equality is sometimes called *judgmental equality*. The name comes from the fact that "$a \equiv b$" is a **judgment** — a statement at the meta-level — not a proposition inside the theory. You cannot negate a judgment or assume one as a hypothesis; it either holds or it doesn't. This is the key distinction from propositional equality $a =_A b$, which is a type (and therefore a proposition that can be assumed, negated, or proved).

### 1.3 Functions and currying (15 min)

```lean
-- Lambda abstraction = fun
def double : Nat → Nat := fun x => x + x

-- Multi-argument functions are curried by default
def add (x y : Nat) : Nat := x + y
#check add 3       -- Nat → Nat   ← partial application!
#eval (add 3) 4    -- 7
#eval add 3 4      -- 7   (same thing)
```

**β-reduction** = substitution: `(fun x => x + x) 3` → `3 + 3` → `6`.

**η-expansion**: `f` and `fun x => f x` are the same function.

```lean
-- Exercises
def compose (f : β → γ) (g : α → β) : α → γ := fun x => f (g x)
def swap (f : α → β → γ) : β → α → γ := fun b a => f a b
```

**Remark.** The name "currying" comes from the mathematician **Haskell Curry** (1900–1982), who studied the correspondence between logic and combinatory algebra. The programming language Haskell is also named after him. Curry-Howard correspondence (Part 3 of this lecture) is named after Curry and **William Alvin Howard**, who formalized the connection between proofs and programs.

### 1.4 Product types and coproduct types (10 min)

```lean
-- Product = pair (think: struct)
#check (42, "hello")           -- Nat × String
example : (42, "hello").1 = 42 := rfl

-- Coproduct = tagged union (define it ourselves)
inductive MySum (α β : Type) where
  | inl : α → MySum α β
  | inr : β → MySum α β

def handle : MySum Nat String → String
  | .inl n => s!"num: {n}"
  | .inr s => s!"str: {s}"

-- Empty type: no constructors, so you can derive anything from it
inductive MyEmpty where

def absurd' (e : MyEmpty) : α := nomatch e
```

**The uniform pattern.** Every type in type theory is specified by the same five ingredients:

| Rule | Product $A \times B$ | Coproduct $A + B$ |
|---|---|---|
| **Formation** | `A × B : Type` | `MySum α β : Type` |
| **Introduction** | `(a, b)` | `inl a` or `inr b` |
| **Elimination** | `.1`, `.2` | `match` (must cover all cases) |
| **Computation** | `(a, b).1 = a` | `match inl a => ...` fires the left branch |
| **Uniqueness** | `p = (p.1, p.2)` | — |

This pattern repeats for every type we introduce.

---

*— 10 min break —*

---

## Part 2: Inductive types and dependent types (50 min)

> §1.8–§1.10 Bool, Nat, pattern matching; §1.3 Universes; §1.4 Π-types; §1.6 Σ-types

### 2.1 Defining Bool and Nat from scratch (20 min)

```lean
inductive MyBool where
  | false : MyBool
  | true  : MyBool

open MyBool

def myIte (b : MyBool) (t f : α) : α :=
  match b with
  | true  => t
  | false => f
```

```lean
inductive MyNat where
  | zero : MyNat
  | succ : MyNat → MyNat

open MyNat

def myAdd : MyNat → MyNat → MyNat
  | zero,   n => n
  | succ m, n => succ (myAdd m n)
```

**Live trace** of `myAdd (succ (succ zero)) (succ zero)`:

```
  myAdd (succ (succ zero)) (succ zero)
= succ (myAdd (succ zero) (succ zero))
= succ (succ (myAdd zero (succ zero)))
= succ (succ (succ zero))
= 3  ✓
```

Students write `myMul` themselves.

**Pattern matching must be exhaustive and structurally decreasing.**

```lean
-- Lean rejects non-terminating recursion:
-- def bad (n : MyNat) : MyNat := bad n       -- ✗
-- def bad2 (n : MyNat) : MyNat := bad2 (succ n)  -- ✗
```

### 2.2 Recursor vs induction principle (10 min)

```lean
-- The recursor: check its type
#check @MyNat.rec
-- When the target type C is constant: ordinary recursion (programming)
-- When C depends on n: mathematical induction (proving)
```

| | Recursor | Induction principle |
|---|---|---|
| Purpose | define **functions** | prove **theorems** |
| `C` | fixed type | `C : MyNat → Prop` |
| Lean | `def f := ...` | `theorem t := by induction ...` |

### 2.3 Universes and type families (10 min)

```lean
#check Nat       -- Type
#check Type      -- Type 1
#check Type 1    -- Type 2
-- Universe hierarchy avoids Russell's paradox

-- Type family: a function returning types
def MyFamily : Bool → Type
  | true  => Nat
  | false => String
```

### 2.4 Π-types and Σ-types (10 min)

**Π-types:** the return type depends on the input value.

```lean
-- Dependent function: return type varies with input
def familyVal : (b : Bool) → MyFamily b
  | true  => (42 : Nat)
  | false => ("hello" : String)

#eval familyVal true    -- 42 : Nat
#eval familyVal false   -- "hello" : String
-- Different return types on different calls!
```

When `B` does not depend on `x`, `(x : A) → B` is just `A → B`.

**Σ-types:** the second component's type depends on the first component's value.

```lean
inductive Vec (α : Type) : Nat → Type where
  | nil  : Vec α 0
  | cons : α → Vec α n → Vec α (n + 1)

-- A length-indexed pair: "a number n together with a vector of length n"
def myVec : (n : Nat) × Vec Nat n :=
  ⟨2, .cons 10 (.cons 20 .nil)⟩
```

| Π-type | Σ-type |
|---|---|
| `(x : A) → B x` | `(x : A) × B x` |
| dependent function | dependent pair |
| logic: $\forall$ | logic: $\exists$ |
| special case: `A → B` | special case: `A × B` |

---

*— 10 min break —*

---

## Part 3: Propositions as types (50 min)

> §1.11 Propositions as types, §1.12 Identity types (preview)

### 3.1 The Curry-Howard correspondence (15 min)

```lean
-- Propositions are types; proofs are inhabitants
#check 2 + 2 = 4           -- Prop
#check (rfl : 2 + 2 = 4)   -- a proof

-- theorem is just def
theorem t1 : 2 + 2 = 4 := rfl
def     t2 : 2 + 2 = 4 := rfl   -- same thing!
```

The full correspondence:

| Logic | Lean type | How to prove |
|---|---|---|
| True | `True` | `True.intro` |
| False | `False` | impossible |
| $A \land B$ | `A ∧ B` | `⟨a, b⟩` |
| $A \lor B$ | `A ∨ B` | `Or.inl a` or `Or.inr b` |
| $A \to B$ | `A → B` | a function |
| $\neg A$ | `A → False` | derive contradiction |
| $\forall x, P(x)$ | `(x : A) → P x` | dependent function |
| $\exists x, P(x)$ | `∃ x, P x` | `⟨witness, proof⟩` |

### 3.2 Writing proofs (20 min)

**Term mode** (proof = expression):

```lean
-- A ∧ B → B ∧ A  (commutativity of conjunction)
theorem and_comm (h : A ∧ B) : B ∧ A :=
  ⟨h.2, h.1⟩

-- (A → B) → (B → C) → (A → C)  (transitivity of implication = function composition)
theorem imp_trans (f : A → B) (g : B → C) : A → C :=
  fun a => g (f a)

-- A → ¬¬A  (double negation introduction)
theorem dne_intro (a : A) : ¬¬A :=
  fun notA => notA a
```

**Tactic mode** (interactive, goal-driven):

```lean
theorem and_comm' (h : A ∧ B) : B ∧ A := by
  constructor
  · exact h.2
  · exact h.1
```

**Live demo**: move the cursor through the tactic proof and show how the goal panel updates in real time.

### 3.3 Constructivism (5 min)

```lean
-- Law of excluded middle is NOT built in
-- #check Classical.em   -- needs `open Classical`

-- ¬¬A → A is not provable (without axioms)
-- But ¬¬(A ∨ ¬A) IS provable:
theorem not_not_em : ¬¬(A ∨ ¬A) :=
  fun h => h (Or.inr (fun a => h (Or.inl a)))
```

Why this matters:
- Constructive $A \lor B$ tells you **which side** holds
- Constructive $\exists x, P(x)$ gives you the **actual witness**
- Every proof is an algorithm

### 3.4 Identity types and induction (10 min)

```lean
-- rfl handles definitional equality
example : 0 + n = n := rfl          -- ✓ (add recurses on first arg)

-- Induction handles the general case
theorem add_zero (n : Nat) : n + 0 = n := by
  induction n with
  | zero => rfl
  | succ n ih => simp [Nat.succ_add, ih]
```

This is mathematical induction — the `induction` tactic corresponds exactly to the induction principle $\mathsf{ind}_{\mathbb{N}}$ from HoTT Book §1.9.

**Preview**: in HoTT, the identity type $a =_A b$ can have **multiple distinct proofs** (paths). `rfl` is just the trivial loop. Chapter 2 will explore this.

---

## Summary (5 min)

```
Type (universe)
  ├── (x : A) → B x    Π-type (dependent function, ∀)
  ├── (x : A) × B x    Σ-type (dependent pair, ∃)
  ├── inductive         inductive types (Nat, Bool, custom)
  └── Prop              propositions (= special types)
       ├── ∧ ∨ → ¬      logical connectives
       └── a = b         identity type
```

One sentence: **types = propositions, programs = proofs, Lean = type theory.**

---

## Exercises

### A. Basics

1. Define `power (base exp : Nat) : Nat`
2. Define `MyList` from scratch using `inductive`, then write `length` and `append`
3. Define `Vec.head : Vec α (n + 1) → α` — note how the type guarantees non-emptiness

### B. Proofs

```lean
theorem or_comm : A ∨ B → B ∨ A := sorry
theorem curry_iso : (A ∧ B → C) → (A → B → C) := sorry
theorem uncurry_iso : (A → B → C) → (A ∧ B → C) := sorry
theorem add_assoc (a b c : Nat) : a + (b + c) = (a + b) + c := sorry
```

### C. Exploration

- Run `#check @Nat.rec` and compare with the induction principle in HoTT Book §1.9
- Why is `¬¬(A ∨ ¬A)` provable constructively, but `A ∨ ¬A` is not?
- Run `#print axioms and_comm` — what axioms does your proof use?
