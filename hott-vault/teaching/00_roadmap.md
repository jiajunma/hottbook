---
type: teaching
title: Teaching Roadmap
tags: [teaching, roadmap, dependent-type-theory, lean]
audience: CS freshmen (all know C)
tool: "Lean 4: live.lean-lang.org or prove.reaslab.io/playground"
---

# Teaching Roadmap: Dependent Type Theory

## Audience

- CS freshmen, all know C
- Math background: high school level
- No assumed knowledge of Python, Haskell, or functional programming

## Tool

- [live.lean-lang.org](https://live.lean-lang.org)
- [prove.reaslab.io/playground](https://prove.reaslab.io/playground)

Zero setup — browser only. Lean **is** dependent type theory, not an analogy for it.

## Approach

1. **No forced analogies.** C only as a one-sentence anchor when the mapping is clean. If a concept has no clean programming equivalent, go straight to the formal definition + Lean code.
2. **Lean is the language.** Definitions, computation, proofs — all in Lean.
3. **Concrete first.** Run code in Lean, see results, then explain the theory.

## Concept–Lean mapping

| Type theory concept | Lean 4 | HoTT §  | Notes |
|---|---|---|---|
| Typing judgment $a : A$ | `#check (42 : Nat)` | 1.1 | [[Foundations/judgment]] |
| Definition | `def f (x : Nat) : Nat := x * x` | 1.1 | [[Foundations/judgment]] |
| Function type $A \to B$ | `Nat → Nat` | 1.2 | [[Foundations/function_type]] |
| λ-abstraction | `fun x => x + x` | 1.2 | [[Foundations/function_type]] |
| Product $A \times B$ | `A × B`, `Prod` | 1.5 | [[Foundations/product_type]] |
| Coproduct $A + B$ | `Sum A B` or custom `inductive` | 1.7 | [[Foundations/coproduct_type]] |
| Universe | `Type`, `Type 1` | 1.3 | [[Foundations/universes]] |
| Π-type | `(x : A) → B x` | 1.4 | [[Foundations/pi_type]] |
| Σ-type | `(x : A) × B x` | 1.6 | [[Foundations/sigma_type]] |
| Bool | `Bool`, `true`, `false` | 1.8 | [[Foundations/bool]] |
| Natural numbers | `Nat`, `0`, `Nat.succ` | 1.9 | [[Foundations/nat]] |
| Pattern matching | `match ... with` | 1.10 | [[Foundations/pattern_matching]] |
| Propositions as types | `Prop`, theorems are functions | 1.11 | [[Foundations/propositions_as_types]] |
| Identity type | `a = b`, `rfl` | 1.12 | [[Identity_and_Paths/identity_type]] |

## Schedule: single 3-hour lecture

**Lesson plan**: [[teaching/ch01_lesson_plan]]

| Block | Content | Covers |
|---|---|---|
| **Part 1** (45 min) | Types, functions, products, coproducts | §1.1–§1.2, §1.5, §1.7 |
| Break (10 min) | | |
| **Part 2** (50 min) | Inductive types, Π-types, Σ-types | §1.3–§1.4, §1.6, §1.8–§1.10 |
| Break (10 min) | | |
| **Part 3** (50 min) | Propositions as types, proofs, identity types | §1.11, §1.12 |
| Summary (5 min) | Big picture | |

### Lecture 2: Homotopy Type Theory (Ch2, 3h)

**Lesson plan**: [[teaching/ch02_lesson_plan]]

| Block | Content | Covers |
|---|---|---|
| **Part 1** (50 min) | Paths, inverse, concatenation, groupoid laws | §2.1 |
| Break (10 min) | | |
| **Part 2** (50 min) | ap, transport, homotopies, equivalences | §2.2–§2.4 |
| Break (10 min) | | |
| **Part 3** (50 min) | Paths in type formers, funext, univalence | §2.5–§2.10 |
| Summary (5 min) | Big picture | |

## Resources

- **Lesson plans**: [[teaching/ch01_lesson_plan]], [[teaching/ch02_lesson_plan]]
- **Symbol guide**: [[teaching/symbol_guide]]
- **Concept notes**: [[Foundations/00_MOC]], [[Identity_and_Paths/00_MOC]]
- **Book digests**: [[book/ch01_type_theory]], [[book/ch02_homotopy_type_theory]]
- **Biographies**: [[teaching/curry_howard_bios]]
