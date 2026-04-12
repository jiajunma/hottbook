---
type: teaching
title: "HoTT Workshop Preparation Notes (备课记录)"
tags: [teaching, workshop, prep-notes, thought-questions]
related:
  - "[[teaching/hott_workshop_guide]]"
  - "[[teaching/hott_workshop.lean]]"
---

# Workshop Preparation Notes (备课记录)

These are expanded background notes for the instructor. **Not all of this goes into the lecture** — use it to prepare answers, deepen discussion when students ask, and handle follow-up questions.

---

## Thought Question 1: "Is every bug a logical error?"

### The surface answer

Yes. Curry-Howard says program = proof, type = proposition. If the program has a bug (doesn't match its type signature), the corresponding "proof" is wrong.

### The deeper answer

The real issue is that **type signatures are usually too weak to capture the full specification**.

```lean
-- This function has a "bug" (it ignores y), but it typechecks:
def bad_add (x y : Nat) : Nat := x
-- The type Nat → Nat → Nat only says "give me two Nats, I give you a Nat"
-- That's too weak to rule out bad_add.
```

The type `Nat → Nat → Nat` as a "proposition" only says "given two natural numbers, there exists a natural number." That's trivially true and carries no information about *which* number. `bad_add` is a perfectly valid proof of this trivial proposition.

To rule out `bad_add`, you'd need a **stronger type**:

```lean
-- A type that actually specifies addition:
def correct_add (x y : Nat) : { z : Nat // z = x + y } := ⟨x + y, rfl⟩
-- Now bad_add can't satisfy this type.
```

### The real lesson

**Bugs arise from the gap between what you MEAN and what you WRITE as a type.** In ordinary programming, types are weak (`int → int → int`), so bugs are common. In Lean/Coq/Agda, you CAN write types that fully specify behavior — and then typechecking = full verification. The bug doesn't disappear; it gets caught at compile time instead of runtime.

**This is why Voevodsky wanted proof assistants**: encode the full mathematical statement as a type, and let the compiler verify the proof. No gap between intention and specification.

### For discussion

Ask students: "In your programming experience, which bugs could have been caught by a stronger type system?" (Common answers: null pointer exceptions, array out of bounds, wrong argument order.)

---

## Thought Question 2: "If a Fields Medalist has errors..."

### Voevodsky's specific experiences

1. **The Kapranov–Voevodsky paper (1990s)**: their paper on ∞-groupoids contained a wrong lemma. Carlos Simpson pointed it out in 1998. Voevodsky initially disagreed — it took **years** before he accepted the error. The paper's main result remains unproved.

2. **Voevodsky's own 1989 paper**: he discovered an error in his early work roughly 24 years later. Nobody in the community had noticed.

3. **Voevodsky's 2014 lecture** (paraphrased):

   > "I was becoming more and more worried. I am a reasonably careful mathematician, and I was finding errors in my own proofs. If I can't verify my own work, how can I trust anyone else's? The only solution I could see was computer-verified proofs."

### The scale of the problem

- Mathematics publishes tens of thousands of papers per year
- Referees typically check the "big picture" and spot-check details — they don't verify every line
- Error rates are unknown because errors are rarely caught (unless they contradict known results)
- Some famous examples: the original proof of the classification of finite simple groups spans ~10,000 pages across hundreds of papers; verification took decades and is arguably still ongoing

### The contrast with software engineering

In software, we **expect** bugs: we write tests, run CI, do code review, use type checkers. The culture is built around the assumption that errors are inevitable.

In mathematics, we **assume** correctness: peer review is a weak filter, and once published, proofs are rarely re-examined. The culture is built around trust.

**Question for students**: which attitude is healthier? HoTT + proof assistants bring the software engineering attitude to mathematics.

---

## Thought Question 3: "Is an infinite loop a proof of False?"

### The precise argument

Curry-Howard: an element of type `A` = a proof of proposition `A`. If `A = Empty` (False), then an element of `Empty` = a proof of a contradiction.

Suppose we allow non-terminating definitions:

```
-- Hypothetical: if Lean didn't check termination
def loop : Empty := loop
```

This "typechecks" — `loop` has type `Empty`. But `loop` never produces a value; it runs forever. If we accepted it as a valid proof, then `Empty` would be inhabited, and from `Empty` we can derive anything (ex falso). The entire logical system collapses.

### Why type theory requires termination

| Logic | Programming |
|---|---|
| **Consistency**: False has no proof | **Termination**: `Empty` has no element |
| Allowing contradiction → everything provable | Allowing infinite loops → type system meaningless |
| Proof = construction that halts | Program = computation that finishes |

### The design choice in Lean

Lean has two modes:

- **`def`**: must be total (terminate on all inputs). Can be used in proofs. The type theory is **consistent** (assuming no bugs in the kernel).
- **`partial def`** / **`unsafe`**: may diverge. Cannot be used in proofs. Turing complete but logically unsound.

```lean
-- This is rejected:
-- def loop : Empty := loop   -- ✗ "fail to show termination"

-- This is accepted but can't be used in proofs:
-- partial def loop : Empty := loop   -- ✓ but useless for logic
```

### Connection to Turing completeness

See [[#Turing completeness]] below for the rigorous definition. The key point:

- **Lean's `def` mode is NOT Turing complete.** It only defines total (terminating) functions. It cannot express the halting problem, arbitrary `while` loops, etc.
- **Lean's `partial def` / `unsafe` mode IS Turing complete.** But it can't participate in proofs.

This is a **deliberate trade-off**: sacrifice Turing completeness to gain logical consistency. For proving theorems, you don't need infinite loops. For running practical programs (servers, GUIs), Lean offers `partial def` as an escape hatch.

### For discussion

"Every programming language you've used (C, Python, Java) is Turing complete — and therefore logically inconsistent if you treat types as propositions. That's why ordinary type checkers can't catch every bug: the type system is necessarily incomplete (or the language is not Turing complete)."

---

## Turing completeness: rigorous definition

### Definition (Turing machine)

A **Turing machine** is a tuple $M = (Q, \Sigma, \Gamma, \delta, q_0, q_{\text{accept}}, q_{\text{reject}})$ where:

- $Q$ is a finite set of states
- $\Sigma$ is the input alphabet ($\sqcup \notin \Sigma$ where $\sqcup$ is the blank symbol)
- $\Gamma \supseteq \Sigma \cup \{\sqcup\}$ is the tape alphabet
- $\delta : Q \times \Gamma \to Q \times \Gamma \times \{L, R\}$ is the transition function
- $q_0 \in Q$ is the start state
- $q_{\text{accept}}, q_{\text{reject}} \in Q$ are the accept and reject states

A Turing machine computes a **partial function** $f : \Sigma^* \rightharpoonup \Sigma^*$: given input $w$, the machine either halts with output $f(w)$ on the tape, or runs forever (in which case $f(w)$ is undefined).

### Definition (Turing completeness)

A computational system $S$ is **Turing complete** if for every Turing machine $M$ there exists a program in $S$ that simulates $M$. Equivalently:

$$S \text{ is Turing complete} \iff S \text{ can compute every partial recursive function } \mathbb{N} \rightharpoonup \mathbb{N}$$

The equivalence of these two formulations is the content of the **Church-Turing thesis** (as a mathematical theorem within the formalized notions; as a philosophical claim about "computability" it remains a thesis).

### Equivalent characterizations

The following are all Turing complete (and can simulate each other):

- Turing machines
- Lambda calculus (untyped)
- Partial recursive functions (Kleene)
- While programs (structured programming with unbounded loops)
- C, Python, Java, JavaScript, ... (any mainstream programming language)

### What is NOT Turing complete

- **Finite automata** (DFA/NFA): can't count unboundedly
- **Pushdown automata**: can't handle two independent counters
- **Primitive recursive functions**: always terminate, but can't compute the Ackermann function
- **Simply typed lambda calculus**: all programs terminate → not Turing complete
- **System T (Gödel)**: extends STLC with primitive recursion on Nat → all programs terminate → not Turing complete
- **System F (Girard-Reynolds)**: all programs terminate → not Turing complete
- **Lean 4 `def` mode** (CIC without `partial`/`unsafe`): all definitions must be total → not Turing complete
- **Coq** (without axioms): all functions terminate → not Turing complete
- **Agda** (with termination checking): same

### The precise trade-off

**Theorem (folklore)**: A consistent type theory in which every type is interpreted as a proposition (Curry-Howard) cannot be Turing complete.

**Proof sketch**: if the system were Turing complete, it could encode the halting problem. The type "this Turing machine halts" would be decidable (by running the machine), but by the undecidability of the halting problem, no total decision procedure exists. More directly: a non-terminating program of type `Empty` would inhabit `Empty`, making the system inconsistent.

**Gödel's second incompleteness theorem** is related: a consistent formal system cannot prove its own consistency. In type theory terms: a consistent type theory cannot prove `¬(Empty)` is inhabited for all possible extensions of itself.

### In practice

| System | Turing complete? | Consistent? | Can prove theorems? |
|---|---|---|---|
| C / Python | Yes | N/A (no Curry-Howard) | No |
| Lean `def` | No (total only) | Yes | Yes |
| Lean `partial def` | Yes | N/A (not in logic) | No |
| Coq | No (total only) | Yes | Yes |
| Agda | No (total only) | Yes | Yes |
| Untyped lambda calculus | Yes | Inconsistent as logic | No |

The design of Lean (and Coq, Agda) is: **total `def` for proofs** (consistent, not Turing complete) + **`partial def` / `unsafe` for programs** (Turing complete, not used in proofs). You get both, in separate compartments.

---

## Additional background: Russell's paradox in type theory

### Why it can't be stated

In set theory, you can form $R = \{x \mid x \notin x\}$ because:
1. $\in$ is a relation between any two objects
2. Comprehension allows forming sets from arbitrary predicates

In type theory, you **cannot** state "$A$ contains itself" because:
1. $a : A$ is a **judgment** (meta-level), not a **proposition** (object-level) — you can't negate it
2. Universe hierarchy: if $A : \mathcal{U}_i$, then the question "$A : A$" is ill-typed (a type and its elements live at different levels)

So the sentence "the type of all types that don't contain themselves" is **grammatically ill-formed** in type theory. The paradox isn't patched — it's **inexpressible**.

### Is it "avoided" or "hidden"?

This is a genuine philosophical question worth discussing. Two perspectives:

**"Avoided"**: the universe hierarchy is a principled structural constraint, not an ad hoc patch. It arises naturally from the desire for types to classify terms (types and terms are categorically different things). Russell's paradox shows that treating everything as the same kind of thing leads to inconsistency.

**"Hidden"**: the hierarchy introduces its own complications (universe polymorphism, `Type : Type 1 : Type 2 : ...`). Some argue it's just a different way of restricting comprehension, analogous to ZFC's separation axiom. The restriction is real — you can't form "the type of all types" — and this limits expressiveness.

**HoTT's nuance**: univalence adds a further twist. Even within a single universe, the identity type $A =_\mathcal{U} B$ can be non-trivial (e.g., `Bool = Bool` has two paths). So the universe has rich internal structure despite not containing itself.

---

## Additional background: the Brouwer-Hilbert controversy

### What happened

In the 1920s, **L.E.J. Brouwer** argued that mathematics must be constructive: every proof of existence must provide a witness. He rejected the law of excluded middle (LEM), proof by contradiction (for existence), and the axiom of choice.

**David Hilbert** countered that classical reasoning was essential: "Taking the principle of excluded middle from the mathematician would be the same as denying the astronomer his telescope or the boxer the use of his fists."

The debate turned personal. Hilbert engineered Brouwer's removal from the editorial board of *Mathematische Annalen* in 1928. Most of the mathematical community sided with Hilbert.

### Resolution in HoTT

HoTT shows that you don't have to choose:

- **Constructive by default**: all definitions and proofs are constructive unless otherwise noted
- **Classical when needed**: assume LEM (restricted to mere propositions) as an axiom when you need it
- **The n-type hierarchy mediates**: classical logic is safe for mere propositions; for general types, only constructive reasoning is sound with univalence

This is arguably the most satisfying resolution of the century-old debate.
