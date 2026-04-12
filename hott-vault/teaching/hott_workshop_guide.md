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

## Before class

- Students open [live.lean-lang.org](https://live.lean-lang.org/)
- Paste the contents of `hott_workshop.lean`
- Verify: the file compiles with only `sorry` warnings (no errors)

## Structure

| Time | Part | Content | Exercises |
|---|---|---|---|
| 0:00–0:50 | **Part 1** | Types, functions, data, Curry-Howard | 1A (factorial), 1B (multiply), 1C (logic proofs) |
| 0:50–1:00 | Break | | |
| 1:00–1:50 | **Part 2** | Paths, groupoid laws, ap, transport, equivalences | 2A (path equations), 2B (ap preserves inverse) |
| 1:50–2:00 | Break | | |
| 2:00–2:50 | **Part 3** | Sets, mere props, n-types, LEM, truncation | 3A (proof irrelevance), 3B (constructive logic), 3C (induction) |
| 2:50–3:00 | Summary | Big picture diagram | |

## Teaching notes

### Part 1: Types, Functions, and Data (50 min)

**Key idea to convey**: in type theory, there is no separation between "data" and "logic." A type IS a proposition, and constructing an element IS a proof.

Walk through the code **live**, executing line by line:

1. **`#check` and `#eval`** (5 min): show that every expression has a type. Let students guess the types before running.

2. **Functions and currying** (10 min): `add 3` returns a function — partial application. This is natural in type theory but impossible in C. Don't dwell on this, just show it.

3. **Two kinds of equality** (10 min): THIS IS CRUCIAL.
   - `double 3 = 6` — `rfl` works (Lean computes it)
   - `∀ n, n + 0 = n` — `rfl` fails (n is a variable, Lean can't compute)
   - Needs **induction** — this is the bridge to Ch2

4. **Inductive types** (10 min): `MyNat` from scratch. Students define `myMul` themselves.

5. **Curry-Howard** (15 min): `andSwap`, `impTrans`. The key moment: "this function IS a proof."
   - Students do Exercise 1C (prove `A → B → A`, curry, uncurry)
   - If they're stuck: "write the type signature and think about what function has that type"

### Part 2: Paths and Higher Structure (50 min)

**Key idea**: equality is not just "yes/no" — it has structure. Two things can be equal in **different ways**.

1. **Path operations** (15 min): `symm`, `trans`, groupoid laws. All proved by `cases p; rfl`.
   - Emphasize: `cases` IS path induction (J rule). It reduces everything to `rfl`.
   - Students do Exercise 2A

2. **ap / congrArg** (10 min): functions preserve paths. Every function is "continuous." Show `ap_trans'`.

3. **Transport** (10 min): `0 + 2 = 2` is `rfl`, but `2 + 0 = 2` needs a lemma. Why? Because `Nat.add` recurses on the **first** argument. Transport lets you "move data along a path."

4. **2-paths and 3-paths** (5 min): the groupoid laws themselves are paths between paths. Briefly show `three_path`.

5. **Equivalences and univalence** (10 min): `boolId` vs `boolNot` — two different equivalences `Bool ≃ Bool`. By univalence (the axiom), these give two different paths `Bool = Bool`. So the universe is NOT a set.

### Part 3: Sets, Propositions, Logic (50 min)

**Key idea**: most mathematics happens at the "set" level. HoTT gives you a hierarchy that tells you exactly how much higher structure a type has.

1. **isSet** (15 min): definition + examples.
   - Nat: any two proofs of `3 = 3` are equal → set
   - Universe: `Bool = Bool` has two distinct paths → NOT a set
   - Draw the picture: "set = no interesting paths between paths"

2. **Mere propositions** (10 min): at most one element. `Empty` (vacuously), `Unit`. `Bool` is NOT a prop.

3. **n-type hierarchy** (5 min): just the table. Don't go deep — the recursive definition is in the code comments.

4. **LEM and univalence** (10 min): WHY naive LEM breaks.
   - Core argument: "if you could pick an element of every type, the pick must respect the swap symmetry of Bool — but swap has no fixed points"
   - LEM restricted to Prop is fine → Lean's `Classical.em`
   - Students do Exercise 3A, 3B

5. **Induction practice** (10 min): Exercise 3C. Students prove `n + 0 = n` by induction. This connects Ch1 (recursion), Ch2 (paths/equality), and Ch3 (sets).

### Summary (10 min)

Show the ASCII diagram at the end of the file. One sentence per chapter:

- **Ch1**: Types are propositions, programs are proofs
- **Ch2**: Equality has structure — paths, groupoid laws, and all of it comes from J
- **Ch3**: Not all types are sets; restrict classical logic to mere propositions

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
