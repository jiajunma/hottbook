---
type: teaching
title: "HoTT Essentials Workshop Guide (Ch1–Ch3)"
tags: [teaching, workshop, lean, ch1, ch2, ch3]
audience: First-year CS students (non-math, can program)
tool: "https://live.lean-lang.org/"
duration: 3 hours
lean_file: "[[teaching/hott_workshop.lean]]"
---

# HoTT Essentials Workshop (Ch1–Ch3)

**Audience**: First-year non-math students who can program
**Duration**: 3 hours
**Tool**: [live.lean-lang.org](https://live.lean-lang.org/)
**Lean file**: `hott_workshop.lean` — students paste the entire file into the web editor
**Bios**: [[teaching/curry_howard_bios]] (photos of Curry and Howard)

## Before class

- Students open [live.lean-lang.org](https://live.lean-lang.org/)
- Paste the contents of `hott_workshop.lean`
- Verify: the file compiles with only `sorry` warnings (no errors)

## Structure overview

| Time | What | Mode |
|---|---|---|
| 0:00–0:10 | **Story**: Curry, Howard, and the secret connection | Lecture + photos |
| 0:10–0:30 | Types, functions, definitional vs propositional equality | Live coding |
| 0:30–0:50 | **Hands-on**: Exercises 1A–1C | Students work, instructor walks around |
| 0:50–1:00 | **Break** | |
| 1:00–1:10 | **Story**: Voevodsky and the crisis of mathematical proof | Lecture |
| 1:10–1:35 | Paths, groupoid laws, ap, transport | Live coding |
| 1:35–1:50 | **Hands-on**: Exercises 2A–2B | Students work |
| 1:50–2:00 | **Break** | |
| 2:00–2:10 | **Story**: Russell's paradox, Brouwer vs Hilbert | Lecture |
| 2:10–2:30 | Sets, mere props, n-types, why LEM breaks | Live coding |
| 2:30–2:50 | **Hands-on**: Exercises 3A–3C + thought questions | Students work + discuss |
| 2:50–3:00 | Summary + open discussion | |

---

## Part 1: Types and Logic (50 min)

### Historical opener: Curry, Howard, and the secret connection (10 min)

Show the photos from [[teaching/curry_howard_bios]].

**Haskell Curry** (1900–1982) started studying medicine at Harvard, switched to math, and spent his career working on combinatory logic — a system so abstract that most mathematicians ignored it. Three programming languages are named after him (Haskell, Brook, Curry). "Currying" — the technique of converting multi-argument functions into chains of single-argument functions — bears his name, though the idea goes back to Schönfinkel and Frege.

**William Alvin Howard** (b. 1926) wrote a manuscript in **1969** showing that proofs in intuitionistic logic correspond exactly to programs in typed lambda calculus. The punchline: **proving a theorem and writing a type-correct program are the same activity.** The manuscript was so ahead of its time that it circulated informally for **11 years** before being published in 1980.

**The punchline for students**: every time your compiler checks your types, it's doing a simplified version of theorem proving. The type checker IS a proof checker.

**Thought question** (pose now, discuss at end):
> If writing a program is the same as proving a theorem, does that mean every bug is a logical error? And every logical error is a bug?

### Live coding: types, functions, equality (20 min)

Walk through the Lean code live. Key moments to pause on:

**1. `#check` and `#eval`** (3 min)
```lean
#check 42         -- Nat
#check fun x => x -- guess the type first!
#eval (fun x => x * x) 5
```
Let students call out their guesses before you run it.

**2. Currying** (3 min)
```lean
def add (x : Nat) (y : Nat) : Nat := x + y
#check add 3     -- Nat → Nat!
```
"In C, `add(3)` would be a syntax error. Here it's a perfectly good function that adds 3 to things."

**3. The big moment: two kinds of equality** (8 min)

This is the most important slide of Part 1. Write on the board:

```
    Definitional equality          Propositional equality
    ─────────────────────          ──────────────────────
    double 3 = 6                   ∀ n, n + 0 = n
    rfl works ✓                    rfl fails ✗
    Lean computes it               YOU must prove it
    Compile-time                   Needs induction
```

Demo both in Lean:
```lean
example : double 3 = 6 := rfl          -- ✓
-- example : ∀ n, n + 0 = n := rfl     -- ✗ uncomment to see error
```

"Why does `n + 0 = n` fail? Because Lean's `+` recurses on the **first** argument. `0 + n` reduces to `n` directly. But `n + 0` — Lean doesn't know what `n` is, so it can't compute."

**4. Curry-Howard** (6 min)
```lean
def andSwap (h : A ∧ B) : B ∧ A := ⟨h.2, h.1⟩
```
"This function IS a proof of 'A and B implies B and A.' The type signature IS the theorem statement. The function body IS the proof. That's Curry-Howard."

### Hands-on: Exercises 1A–1C (20 min)

Students work on their laptops. Instructor walks around helping.

- **1A** (factorial): warm-up, just pattern matching
- **1B** (myMul): forces them to think about recursion on MyNat
- **1C** (logic proofs): the Curry-Howard exercises — "write a function with this type"

**Hint for 1C if students are stuck**: "Don't think about logic. Think about types. What function takes an `A` and a `B` and returns an `A`?"

---

*Break 10 min*

---

## Part 2: Paths and Equality (50 min)

### Historical opener: Voevodsky and the crisis of proof (10 min)

**Vladimir Voevodsky** (1966–2017) won the **Fields Medal** in 2002 for his work on motivic cohomology — deep, technical algebraic geometry.

Then something disturbing happened. He discovered that a key lemma in a published proof by another mathematician was **wrong** — and the error had gone undetected for years. Worse, he found a subtle gap in one of his **own** earlier proofs. The mathematical community had accepted these proofs through peer review, seminars, and citations — and nobody caught the mistakes.

Voevodsky's reaction was radical: **mathematics needs machine-checked proofs.** He spent the rest of his career (2006–2017) developing a new foundation for mathematics — **univalent foundations** / HoTT — designed to be formalized in proof assistants from the ground up.

In 2012–2013, a group of mathematicians gathered at the Institute for Advanced Study (Princeton) and wrote the **HoTT Book** collaboratively — the textbook we're studying. Voevodsky's central axiom, **univalence**, says:

> Two types are equal if and only if they are equivalent.

This single sentence reshapes the entire meaning of equality in mathematics.

**Thought question**:
> If a Fields Medalist can have errors in his proofs, what does that say about the thousands of proofs published every year that nobody checks carefully?

### Live coding: paths and groupoid structure (25 min)

**1. Path operations** (10 min)

```lean
-- Every equality proof is a "path" — it has direction and can be composed
example (p : x = y) : y = x := p.symm          -- reverse
example (p : x = y) (q : y = z) : x = z := p.trans q  -- compose
```

"A proof of `x = y` is not just 'yes, they're equal.' It's a **specific witness** — a path from `x` to `y`. And paths have structure: you can reverse them, chain them, and they satisfy algebraic laws."

Show the groupoid laws — all proved by `cases p; rfl`:

```lean
theorem trans_refl (p : x = y) : p.trans rfl = p := by cases p; rfl
```

"`cases p` is the J rule: reduce to the case where the path is `rfl`. Then both sides are the same, so `rfl` finishes it. **This one trick proves everything.**"

**2. ap: functions are "continuous"** (5 min)
```lean
example (f : Nat → Nat) {a b : Nat} (p : a = b) : f a = f b :=
  congrArg f p
```
"If you have a path from `a` to `b`, any function `f` maps it to a path from `f a` to `f b`. Every function in type theory automatically preserves equality structure. There is no such thing as a 'discontinuous' function."

**3. 2-paths: the groupoid laws ARE paths between paths** (5 min)
```lean
-- trans_refl p has TYPE (p.trans rfl = p)
-- That's an equality between two paths — a "2-path"
-- A 2-path is itself a first-class object!
```
"The proof of `p.trans rfl = p` is itself a path — between paths. And you can ask whether two such 2-paths are equal — that's a 3-path. This goes on forever. This is what makes types into ∞-groupoids."

**4. Bool ≃ Bool: why the universe is interesting** (5 min)
```lean
-- Bool ≃ Bool has TWO equivalences: id and not
-- By univalence, these give TWO different paths Bool = Bool
-- So Type is NOT a "set" — it has non-trivial path structure!
```
"In ordinary math, `Bool = Bool` has one proof: 'obviously.' In HoTT, it has **two**: 'obviously via identity' and 'obviously via negation.' These are genuinely different — you can't deform one into the other."

### Hands-on: Exercises 2A–2B (15 min)

- **2A**: two basic path equalities. "Use `cases` and `rfl` — that's all you need."
- **2B**: ap preserves inverses. Same technique.

**If students finish early**, challenge them:
> Can you prove `path_assoc` yourself (without looking at the code above)? Hint: `cases p; cases q; cases r; rfl`.

---

*Break 10 min*

---

## Part 3: Sets, Propositions, and the Limits of Logic (50 min)

### Historical opener: Russell's paradox and the constructivism war (10 min)

**1901, Bertrand Russell** writes a letter to Gottlob Frege (who had just published a major book on foundations): "Consider the set of all sets that don't contain themselves. Does it contain itself?"

If yes → it doesn't. If no → it does. Frege's entire system collapses. Russell later wrote: "I felt like a doctor who discovers that the patient is terminally ill."

This led to two competing responses:

- **Hilbert's program** (1920s): formalize all of math, prove it consistent. "No one shall expel us from the paradise Cantor has created."
- **Brouwer's intuitionism** (1920s): math must be constructive — every proof of existence must provide a witness. No proof by contradiction. No law of excluded middle.

The debate was bitter — Hilbert got Brouwer removed from the editorial board of a major journal. Then in **1931, Gödel** showed Hilbert's program was impossible (incompleteness theorems), but the community largely sided with Hilbert anyway.

**HoTT offers a resolution**: you can have classical logic (LEM) **for mere propositions**, and constructive reasoning for everything else. You don't have to choose sides — the n-type hierarchy lets both coexist.

**Thought question**:
> Russell's paradox comes from "the set of all sets." In type theory, there's no "type of all types" (because of universe levels). Is the paradox really *avoided*, or just *hidden*?

### Live coding: sets, props, n-types (20 min)

**1. isSet: concrete examples** (10 min)

```lean
-- Nat IS a set: any two proofs of 3 = 3 are equal
example (p q : (3 : Nat) = 3) : p = q := Subsingleton.elim p q
```

"A set is a type where equality is boring — there's at most one path between any two points. Natural numbers, integers, booleans — all sets. But the **universe** is not a set, because `Bool = Bool` has two different paths."

Draw on the board:

```
                 contractible  ⊂  prop  ⊂  set  ⊂  1-type  ⊂  ...
                 ───────────     ────     ───     ──────
                "one point"   "true/     "normal"  "categories"
                              false"     math"
```

**2. Why LEM breaks** (10 min)

"Suppose God gave you a function `f : (A : Type) → A ∨ ¬A` — for every type, it tells you yes or no."

"Apply it to `Bool`. You get either `true` or `false` (wrapped in `Or.inl`). Let's say it picks `true`."

"Now here's the problem. By univalence, the swap `not : Bool ≃ Bool` is a symmetry. Your function `f` must respect this symmetry — it must give the same answer for `Bool` and the 'swapped Bool'. But the swap turns `true` into `false`. So `f(Bool)` must be a fixed point of `not`. But `not` has no fixed points!"

"So `f` can't exist. LEM for all types is **inconsistent** with univalence. But LEM for Prop is fine — because Prop has proof irrelevance, no non-trivial symmetries."

```lean
-- LEM in Lean's Prop works fine:
open Classical in
example (P : Prop) : P ∨ ¬P := em P
```

### Hands-on: Exercises 3A–3C + thought questions (20 min)

Students work on:

- **3A** (proof irrelevance in Prop): should be quick, uses `Subsingleton.elim`
- **3B** (double negation intro, De Morgan): constructive proofs, no classical axioms
- **3C** (induction): `n + 0 = n` — connects all three chapters

**Thought questions for discussion** (put on screen while students work — discuss in the last 5 minutes):

1. **Curry-Howard paradox**: if every program is a proof, is an infinite loop a proof of `False`? (Answer: no — type theory requires termination. That's why Lean rejects non-structurally-decreasing recursion.)

2. **Constructivism in practice**: a constructive proof of "there exists a prime > 10¹⁰⁰" must actually **produce** the prime. Is this a strength or a weakness? (Both — it's more informative but harder to prove.)

3. **The universe question**: we said the universe is not a set because `Bool = Bool` has two paths. But `Nat = Nat` has only one path (id). So the universe has "interesting parts" and "boring parts." Is there a type where `A = A` has **infinitely many** distinct paths? (Yes — the circle $S^1$. Its loop space is $\mathbb{Z}$. This is Chapter 8.)

---

## Summary and open discussion (10 min)

Show the final diagram:

```
    Type (universe — NOT a set!)
      ├── (x : A) → B x    Π-type (∀, dependent functions)
      ├── (x : A) × B x    Σ-type (∃, dependent pairs)
      ├── inductive         Nat, Bool, custom types
      └── Prop              mere propositions (proof irrelevant)
           ├── ∧ ∨ → ¬      classical logic OK here
           └── a = b         identity type = PATHS

    n-type hierarchy:
      contractible ⊂ prop ⊂ set ⊂ 1-type ⊂ ... ⊂ ∞-type
         (-2)        (-1)    (0)    (1)           (∞)
```

**Three sentences**:
1. **Ch1**: Proofs are programs, types are propositions — Curry-Howard.
2. **Ch2**: Equality is not just yes/no; it has structure. All structure comes from one rule (J / path induction).
3. **Ch3**: Most math lives at the "set" level. Classical logic works there. Beyond sets, univalence reveals richer structure.

**Closing question**: "We've covered Chapters 1–3 of a 400-page book in 3 hours. What do you think happens in the other 300 pages?" (Answer: circles, spheres, homotopy groups, category theory, real numbers — all built from the foundations you just learned.)

---

## Exercise solutions (for instructor)

```lean
-- 1A
def factorial : Nat → Nat
  | 0 => 1
  | n + 1 => (n + 1) * factorial n

-- 1B
def myMul : MyNat → MyNat → MyNat
  | zero,   _ => zero
  | succ m, n => myAdd n (myMul m n)

-- 1C
def ex1c_1 : A → (B → A) := fun a _ => a
def ex1c_2 (h : A ∧ B → C) : A → B → C := fun a b => h ⟨a, b⟩
def ex1c_3 (h : A → B → C) : A ∧ B → C := fun ⟨a, b⟩ => h a b

-- 2A
theorem ex2a_1 (p : x = y) : rfl.trans p = p := rfl
theorem ex2a_2 (p : x = y) : p.symm.trans p = rfl := by cases p; rfl

-- 2B
theorem ex2b (f : α → β) (p : a = b) :
    congrArg f p.symm = (congrArg f p).symm := by cases p; rfl

-- 3A
theorem ex3a (P : Prop) (p q : P) : p = q := Subsingleton.elim p q

-- 3B
theorem dne_intro' (P : Prop) (a : P) : ¬¬P := fun h => h a
theorem deMorgan' (h : ¬(A ∨ B)) : ¬A ∧ ¬B :=
  ⟨fun a => h (Or.inl a), fun b => h (Or.inr b)⟩

-- 3C
theorem my_add_zero' : ∀ n : Nat, n + 0 = n := by
  intro n; induction n with
  | zero => rfl
  | succ n ih => simp [Nat.succ_add, ih]
```
