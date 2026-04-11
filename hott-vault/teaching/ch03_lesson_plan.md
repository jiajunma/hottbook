---
type: teaching
title: "Chapter 3 Lesson Plan: Sets and Logic"
tags: [teaching, lesson-plan, sets, n-types, truncation, chapter-3, lean]
audience: CS freshmen (completed Ch1 and Ch2 lessons)
tool: "Lean 4: live.lean-lang.org or prove.reaslab.io/playground"
total_hours: 3
lectures: 1
prerequisite:
  - "[[teaching/ch01_lesson_plan]]"
  - "[[teaching/ch02_lesson_plan]]"
---

# Chapter 3: Sets and Logic (Single 3h Lecture)

**Prerequisite**: [[teaching/ch01_lesson_plan]], [[teaching/ch02_lesson_plan]]
**Tool**: [live.lean-lang.org](https://live.lean-lang.org) or [prove.reaslab.io/playground](https://prove.reaslab.io/playground)

**Covers**: HoTT Book Chapter 3, §3.1–§3.11

**The big question**: After Ch2, every type looks like an ∞-groupoid with potentially rich higher structure. But most mathematics (groups, numbers, graphs) doesn't need higher paths. How do we recover "ordinary" sets, logic, and propositions inside HoTT? This chapter answers that.

---

## Pre-class recap

Students should be comfortable with:
- Paths as elements of the identity type
- Path operations: inverse, concatenation, groupoid laws
- `ap` (functoriality), transport, equivalences
- Function extensionality, univalence

---

## Part 1: The n-type hierarchy (55 min)

> §3.1 Sets and n-types, §3.3 Mere propositions, §3.11 Contractibility

### 1.1 The problem: types are too rich (5 min)

After Ch2, a type like $\mathsf{Bool}$ *looks* simple: two elements. But in principle, the identity type $\mathsf{Bool} = \mathsf{Bool}$ (in the universe) is **not** trivial — it has two distinct elements (id and not) by univalence!

So the universe $\mathcal{U}$ has non-trivial 1-paths. Its identity type carries real information. This is great for doing homotopy theory — but for ordinary math, we want to say "two groups are equal" and have it mean something *finite*, not an ∞-groupoid of witnesses.

**Solution**: introduce a hierarchy that stratifies types by how much higher structure they carry.

### 1.2 Sets: the definition, with concrete examples (20 min)

$$\mathsf{isSet}(A) :\equiv \prod_{(x,y:A)} \prod_{(p,q:x=y)} (p = q)$$

**In words**: for any two elements $x, y$ and any two paths $p, q : x = y$, those paths are equal. That is, **between any two points, there is at most one path** (up to further equality).

**Example 1: $\mathbb{N}$ is a set.**

```lean
-- In ℕ, equality is decidable: either m = n or m ≠ n.
-- For any specific m, n : ℕ, the type m = n either has 0 elements (if m ≠ n)
-- or has essentially one element rfl (if m = n).

-- Any two proofs of 3 = 3 are equal:
example (p q : (3 : Nat) = 3) : p = q := Subsingleton.elim p q

-- Lean's Nat is automatically a set
example : ∀ (m n : Nat) (p q : m = n), p = q := by
  intros m n p q; exact Subsingleton.elim p q
```

**Example 2: $\mathbf{1}$ (unit type) is a set.**

Unit has one element $\star$. Only one possible path: $\mathsf{rfl}_\star : \star = \star$. Any two paths are trivially equal.

**Example 3: $\mathbf{0}$ (empty type) is a set.**

Empty type has no elements. The statement "for all $x, y : \mathbf{0}$, ..." is vacuously true. So $\mathsf{isSet}(\mathbf{0})$ holds trivially.

**Counterexample: the universe $\mathcal{U}$ is NOT a set.**

Take $x := \mathsf{Bool}$ and $y := \mathsf{Bool}$. By univalence:

$$(\mathsf{Bool} =_\mathcal{U} \mathsf{Bool}) \simeq (\mathsf{Bool} \simeq \mathsf{Bool})$$

And $\mathsf{Bool} \simeq \mathsf{Bool}$ has **two** distinct elements:
1. $\mathsf{id}$ (true ↦ true, false ↦ false)
2. $\mathsf{not}$ (true ↦ false, false ↦ true)

These give two distinct paths $p, q : \mathsf{Bool} = \mathsf{Bool}$. If $p = q$, then the corresponding equivalences would be equal — but $\mathsf{id}$ and $\mathsf{not}$ disagree on $\mathsf{true}$. Contradiction. So $\mathsf{isSet}(\mathcal{U})$ does **not** hold.

**Intuition**: $A$ is a set ⟺ "equality in $A$ is a yes/no question" with no hidden structure. Traditional math objects ($\mathbb{N}$, $\mathbb{Z}$, $\mathbb{Q}$, finite sets, graphs, group elements) all live at this level.

### 1.3 The n-type hierarchy: recursive definition (15 min)

The key insight: "set" is just one level in an infinite hierarchy. Define recursively:

**Base case**: $A$ is a $(-2)$-type ⟺ $A$ is **contractible**.

$$\mathsf{isContr}(A) :\equiv \sum_{(a:A)} \prod_{(x:A)} (a = x)$$

"Exactly one element (up to path): a center $a$, and every other point is equal to $a$."

**Recursive step**: $A$ is an $(n+1)$-type ⟺ for all $x, y : A$, the type $x =_A y$ is an $n$-type.

$$\mathsf{is}\text{-}(n+1)\text{-type}(A) :\equiv \prod_{(x,y:A)} \mathsf{is}\text{-}n\text{-type}(x =_A y)$$

**Unwinding layer by layer:**

| $n$ | Name | Meaning | Example |
|---|---|---|---|
| $-2$ | contractible | "exactly one element" | $\mathbf{1}$, $\sum_{(x:A)} (a = x)$ |
| $-1$ | mere proposition | "at most one element" | $\mathbf{0}$, $\mathbf{1}$, $a = b$ in a set |
| $0$ | set | "between any two points, at most one path" | $\mathbb{N}$, $\mathsf{Bool}$, finite sets |
| $1$ | 1-type | "between any two paths, at most one 2-path" | The type of groups, $\mathsf{Set}$ as a type |
| $n$ | $n$-type | "$(n+1)$-paths are trivial" | ... |
| $\infty$ | general type | no restriction | $\mathcal{U}$, $S^1$ |

**Why $-2$?** It's a convention so that $0$ aligns with "ordinary set" and the hierarchy extends below (to mere propositions and contractible types). The numbering matches the geometric dimension of the corresponding truncated space.

```lean
-- Contractible: exactly one element (with a center and contraction)
structure IsContr (A : Type u) where
  center : A
  contraction : ∀ (x : A), center = x

-- Example: Unit is contractible
def unitContr : IsContr Unit := ⟨(), fun x => by cases x; rfl⟩

-- The sum type Σ x, a = x is contractible (free endpoint lemma)
example (A : Type) (a : A) : IsContr (Σ' (x : A), a = x) :=
  ⟨⟨a, rfl⟩, fun ⟨x, p⟩ => by cases p; rfl⟩
```

### 1.4 Mere propositions: at most one proof (10 min)

$$\mathsf{isProp}(P) :\equiv \prod_{(x,y:P)} (x = y)$$

"Any two elements of $P$ are equal." This is the $(-1)$-type level.

**Key theorem**: a mere proposition is either empty or contractible.

```lean
-- isProp P : any two elements of P are equal
def IsProp (P : Sort u) := ∀ (x y : P), x = y

-- Empty type is a mere prop (vacuously)
example : IsProp Empty := fun x _ => nomatch x

-- Unit is a mere prop
example : IsProp Unit := fun x y => by cases x; cases y; rfl

-- Bool is NOT a mere prop: true ≠ false
-- example : IsProp Bool := ???  -- impossible!
```

**Why the name "mere"?** In HoTT, *any* type can be read as a proposition (Curry-Howard), and its elements are proofs. A **mere** proposition is one where we don't care *which* proof you give — the proofs are all equal. This recovers the traditional notion of "proposition" where truth is binary and proofs are interchangeable.

**Crucial property**: if $P$ and $Q$ are mere propositions, then $P \simeq Q$ iff $P \iff Q$ (logical equivalence). This is Lemma 3.3.3 — for mere propositions, "equivalent" collapses to the classical "iff."

### 1.5 The chain of implications (5 min)

**Lemma 3.1.3** and its relatives give:

$$\text{contractible} \;\Rightarrow\; \text{mere prop} \;\Rightarrow\; \text{set} \;\Rightarrow\; \text{1-type} \;\Rightarrow\; \cdots$$

**Intuition**: if a type is "trivial at level $n$," it's automatically "trivial at level $n+1$." Going up the hierarchy means being *more permissive*.

```lean
-- contractible ⇒ mere prop
example (A : Type u) (h : IsContr A) : IsProp A :=
  fun x y => (h.contraction x).symm.trans (h.contraction y)

-- mere prop ⇒ set (proof is more involved, uses path induction)
```

---

*— 10 min break —*

---

## Part 2: Logic inside HoTT (55 min)

> §3.2 Propositions as types?, §3.4 Classical vs intuitionistic, §3.6 Logic of mere propositions

### 2.1 The problem with naive propositions-as-types (15 min)

In Ch1 we learned the Curry-Howard slogan: type = proposition, program = proof. The **naive** reading of this says: we should be able to reason classically about *any* type, treating it as a proposition. Concretely, this means asserting for every type $A$:

- **$\mathsf{LEM}_\infty$**: $A + \neg A$ — "either $A$ or not $A$"
- **$\mathsf{DNE}_\infty$**: $\neg\neg A \to A$ — "double negation elimination"

In Ch1 these looked like reasonable classical axioms one might add. **Ch2's univalence makes them inconsistent.** Let's see exactly how.

#### The setup

By the univalence axiom (§2.10), for any types $A, B$:

$$(A =_\mathcal{U} B) \;\simeq\; (A \simeq B)$$

Every type equivalence gives rise to a path in the universe, and vice versa. This is a **constraint**: whatever we define on types must "respect" equivalences, because equivalent types are *literally equal* as far as the theory can see.

**Concrete consequence**: if $f : \prod_{(A:\mathcal{U})} g(A)$ is a polymorphic function (like $\mathsf{DNE}_\infty$), then for any path $p : A = B$ we automatically have a transport law:

$$\mathsf{transport}^g\, p\, (f(A)) = f(B)$$

This is because $f(A)$ and $f(B)$ are both *the same* $f$ applied in different ways, and type families automatically respect paths (Lemma 2.3.1). You don't need to *prove* naturality — it's built into the type theory.

#### Theorem 3.2.2: $\mathsf{DNE}_\infty$ is inconsistent

**Claim**: there is **no** $f : \prod_{(A : \mathcal{U})} (\neg\neg A \to A)$.

**Proof** (by contradiction):

Suppose we had such an $f$. We'll derive a contradiction using the type $\mathsf{Bool}$.

**Step 1: the swap equivalence.** Define $e : \mathsf{Bool} \simeq \mathsf{Bool}$ by $e :\equiv \mathsf{not}$. This is an equivalence: it's its own inverse. By univalence, there is a path $p :\equiv \mathsf{ua}(e) : \mathsf{Bool} = \mathsf{Bool}$.

**Step 2: transport along $p$ is the swap.** The computation rule for univalence says: for the identity type family (i.e., just the domain), transport along $p$ equals $e$. Concretely:

$$\mathsf{transport}^{X \mapsto X}\, p\, \mathsf{true} = \mathsf{not}(\mathsf{true}) = \mathsf{false}$$
$$\mathsf{transport}^{X \mapsto X}\, p\, \mathsf{false} = \mathsf{not}(\mathsf{false}) = \mathsf{true}$$

**Step 3: $\neg\neg\mathsf{Bool}$ is inhabited.** Take any element, say $\mathsf{true} : \mathsf{Bool}$. Then $u :\equiv \lambda k.\, k(\mathsf{true}) : \neg\neg\mathsf{Bool}$. (If $k : \neg\mathsf{Bool}$ claims to derive $\mathbf{0}$ from any Bool, feed it $\mathsf{true}$.)

**Step 4: apply $f$ to get a Bool.** Let $b :\equiv f(\mathsf{Bool})(u) : \mathsf{Bool}$. This is some specific Boolean — either $\mathsf{true}$ or $\mathsf{false}$, but we don't yet know which.

**Step 5: naturality of $f$.** Since $f : \prod_{(A:\mathcal{U})} (\neg\neg A \to A)$, the transport law gives:

$$\mathsf{transport}^{A \mapsto (\neg\neg A \to A)}\, p\, (f(\mathsf{Bool})) = f(\mathsf{Bool})$$

Unfolding transport at a function type (the standard rule for $\mathsf{transport}$ in a function family):

$$\mathsf{transport}^{X \mapsto X}\, p\, \bigl(f(\mathsf{Bool})(\mathsf{transport}^{\neg\neg \cdot}\, p^{-1}\, u)\bigr) = f(\mathsf{Bool})(u)$$

**Step 6: simplify $\mathsf{transport}^{\neg\neg \cdot}\, p^{-1}\, u$.** Here $\neg\neg\mathsf{Bool}$ is a fancy type, but transporting any specific element of it along a loop $p^{-1} : \mathsf{Bool} = \mathsf{Bool}$ gives back *some* element of $\neg\neg\mathsf{Bool}$. Call it $u'$. By Step 5:

$$\mathsf{transport}^{X \mapsto X}\, p\, (f(\mathsf{Bool})(u')) = f(\mathsf{Bool})(u)$$

The left side is $e$ applied to $f(\mathsf{Bool})(u')$, which is $\mathsf{not}$ of some Boolean. The right side is some Boolean $b$. So we get a Boolean equation: the swap of something equals something-else.

**Step 7: the simplification kicks in.** Here's the key observation. Because $\mathsf{Bool}$ is decidable, $\neg\neg\mathsf{Bool}$ behaves essentially like $\mathsf{Bool}$ for this purpose — in fact, any two elements of $\neg\neg\mathsf{Bool}$ act the same on concrete functions out of it (this uses the more general fact that transport on $\neg\neg(\cdot)$ is the identity in this case). More formally, one can show $u' = u$, so:

$$e(f(\mathsf{Bool})(u)) = f(\mathsf{Bool})(u)$$

That is, $\mathsf{not}(b) = b$ — **$b$ is a fixed point of $\mathsf{not}$**.

**Step 8: but $\mathsf{not}$ has no fixed points.** We have $\mathsf{not}(\mathsf{true}) = \mathsf{false} \neq \mathsf{true}$ and $\mathsf{not}(\mathsf{false}) = \mathsf{true} \neq \mathsf{false}$. So $\mathsf{not}(b) = b$ is impossible whatever $b$ is.

**Contradiction.** So $f$ cannot exist. $\square$

#### What just happened, conceptually

The argument has a single moral:

> **Univalence forces every polymorphic operation on types to be natural with respect to equivalences.**

A function $f : \prod_{(A : \mathcal{U})} g(A)$ cannot "look inside" a type $A$ and make arbitrary choices — any choices it makes must commute with the symmetries of $A$. In the $\mathsf{Bool}$ case, the swap $\mathsf{not}$ is a symmetry, and $f(\mathsf{Bool})(u)$ must be invariant under it. But $\mathsf{Bool}$ has no element fixed by $\mathsf{not}$, so no such invariant element exists.

**Compare with set theory**: in ZFC, the "axiom of choice" lets you pick an element from any inhabited set, and the picked element can be completely arbitrary — no naturality constraint. HoTT can't work this way. Every operation must respect equivalences, so any "choice" you make must be canonical.

**Compare with classical Curry-Howard (pre-univalence)**: in a type theory without univalence, $\mathsf{DNE}_\infty$ is consistent (though still not provable). You can safely assume it as an axiom. The new ingredient that breaks it is univalence's rigidity.

#### Corollary 3.2.7: $\mathsf{LEM}_\infty$ is also inconsistent

$$\mathsf{LEM}_\infty :\equiv \prod_{(A : \mathcal{U})} (A + \neg A)$$

**Why**: from $\mathsf{LEM}_\infty$ one can derive $\mathsf{DNE}_\infty$ (by case-analyzing $A + \neg A$), so inconsistency of the latter gives inconsistency of the former.

#### The moral

The problem is **not** with Curry-Howard, and **not** with classical logic per se. The problem is that we tried to apply classical logic to *every* type — and univalence reveals that "general types" are too rich to admit classical reasoning. You cannot non-canonically pick an element of $\mathsf{Bool}$, because $\mathsf{Bool}$ has a symmetry you must respect.

**The fix**: restrict classical reasoning to types *without* non-trivial symmetries — types where "the element is fixed, because there's only one possibility anyway." These are exactly the **mere propositions**: types with at most one element, hence no room for non-trivial symmetries.

### 2.2 The fix: restrict LEM to mere propositions (10 min)

$$\mathsf{LEM} :\equiv \prod_{(A:\mathcal{U})} \left(\mathsf{isProp}(A) \to (A + \neg A)\right)$$

"For every mere proposition $A$, either $A$ or $\neg A$."

This **is** consistent with univalence. You can assume it as an axiom if you want classical reasoning. Lean does this by default in its `Prop` universe (via `Classical.em`).

**Double negation elimination** (restricted version):
$$\prod_{(A:\mathcal{U})} \left(\mathsf{isProp}(A) \to (\neg\neg A \to A)\right)$$

These two are equivalent (Exercise 3.18).

```lean
-- Lean's Prop has classical logic available
open Classical

example (P : Prop) : P ∨ ¬P := em P
example (P : Prop) : ¬¬P → P := by_contradiction

-- But these ONLY work in Prop, not for arbitrary Type
```

### 2.3 Which logical connectives preserve mere propositions? (10 min)

Given mere props $P, Q$, which type formers produce a mere prop?

| Connective | Type | Preserves mere props? |
|---|---|---|
| $P \land Q$ (conjunction) | $P \times Q$ | ✓ yes |
| $\forall x, P(x)$ (universal) | $\prod_{(x:A)} P(x)$ | ✓ yes |
| $P \Rightarrow Q$ (implication) | $P \to Q$ | ✓ yes (for any $P$!) |
| $\neg P$ (negation) | $P \to \mathbf{0}$ | ✓ yes (always) |
| $P \lor Q$ (disjunction) | $P + Q$ | ✗ **NO** |
| $\exists x, P(x)$ (existential) | $\sum_{(x:A)} P(x)$ | ✗ **NO** |

**Why $+$ fails**: even if $P$ and $Q$ are both $\mathbf{1}$ (contractible, hence mere prop), $P + Q \simeq \mathbf{1} + \mathbf{1} \simeq \mathbf{2}$, which has **two** distinct elements. A mere prop can have at most one element. So $+$ destroys mere-prop-ness.

**Why $\sum$ fails**: $\sum_{(x:A)} P(x)$ remembers *which* $x$ satisfies $P$, which is more information than just "$\exists x, P(x)$." A mere prop shouldn't remember that.

**Fix**: use **propositional truncation** $\|\cdot\|$ to squash a type into a mere prop.

### 2.4 Propositional truncation (15 min)

For any type $A$, there is a type $\|A\|$ (the propositional truncation of $A$) with:

1. A map $|\cdot| : A \to \|A\|$
2. $\|A\|$ is a mere proposition: $\prod_{(x,y:\|A\|)} x = y$

**Recursion principle**: to define a function $\|A\| \to B$, it suffices to:
- Give a function $f : A \to B$
- Prove $B$ is a mere proposition

The second condition is crucial: you can only "use" the truncation to build *other mere propositions*. This is why $\|A\|$ forgets the witness — because any function out of $\|A\|$ must land in something that doesn't care about the witness anyway.

```lean
-- Lean has propositional truncation as Nonempty in Prop:
#check @Nonempty         -- Nonempty α : Prop
-- Nonempty.intro : α → Nonempty α

-- Or the explicit truncation via quotient (in Prop):
-- In Lean, any Prop is already truncated
example (α : Type) : Prop := Nonempty α
example : Nonempty Nat := ⟨42⟩
```

**Traditional logical notation** (Definition 3.7.1 in HoTT Book):

$$\begin{aligned}
\top &:\equiv \mathbf{1} \\
\bot &:\equiv \mathbf{0} \\
P \land Q &:\equiv P \times Q \\
P \Rightarrow Q &:\equiv P \to Q \\
\neg P &:\equiv P \to \mathbf{0} \\
P \lor Q &:\equiv \|P + Q\| \qquad \text{(truncated!)} \\
\forall_{(x:A)} P(x) &:\equiv \prod_{(x:A)} P(x) \\
\exists_{(x:A)} P(x) &:\equiv \left\|\sum_{(x:A)} P(x)\right\| \qquad \text{(truncated!)}
\end{aligned}$$

**This is how HoTT recovers traditional logic**: use truncation for $\lor$ and $\exists$; leave the others alone.

### 2.5 Why 0 = False: a deeper look (5 min)

The correspondence between types and propositions:

| Type | As proposition | Why |
|---|---|---|
| $\mathbf{0}$ | **False** | No constructors → no inhabitants → no proof → unprovable |
| $\mathbf{1}$ | **True** | Unique constructor $\star$ → always inhabited → trivially provable |
| $A \to \mathbf{0}$ | $\neg A$ | "From $A$ we can derive a contradiction" |

**Ex falso**: the eliminator for $\mathbf{0}$:
$$\mathsf{ind}_{\mathbf{0}} : \prod_{(C:\mathbf{0} \to \mathcal{U})} \prod_{(z:\mathbf{0})} C(z)$$

Simplified: $\mathbf{0} \to C$ for any $C$. "From a false premise, anything follows." This works because $\mathbf{0}$ has no constructors, so the function needs to handle zero cases — vacuously succeeds.

```lean
-- Ex falso in Lean
example {C : Type} (h : False) : C := h.elim
example {C : Type} (h : Empty) : C := nomatch h
```

---

*— 10 min break —*

---

## Part 3: Choice, unique choice, and synthesis (45 min)

> §3.8 Axiom of choice, §3.9 Unique choice, §3.10 Truncation conventions

### 3.1 The axiom of choice (15 min)

**Naive (untruncated) AC** is provable — it's just the $\Pi$-$\Sigma$ shuffle (Theorem 2.15.7):

$$\left(\prod_{(x:A)} \sum_{(y:B(x))} R(x,y)\right) \to \sum_{(f:\prod_{(x:A)} B(x))} \prod_{(x:A)} R(x,f(x))$$

This is trivially provable: given $g : \prod_x \sum_y R(x,y)$, take $f := \lambda x.\, (g x).1$ and the proof is $\lambda x.\, (g x).2$.

**Set-theoretic AC** (needs truncation) is NOT automatically provable:

$$\mathsf{AC} : \left(\prod_{(x:X)} \left\|\sum_{(y:B(x))} R(x,y)\right\|\right) \to \left\|\sum_{(f:\prod_{(x:X)} B(x))} \prod_{(x:X)} R(x,f(x))\right\|$$

"If for every $x$ there *merely* exists a $y$, then *merely* there exists a choice function."

**Lemma 3.8.5**: set-theoretic AC **fails** if $X$ is not a set. You can actively construct a counterexample using univalence — take $X$ to be a 1-type, and the choice function would have to be natural with respect to path structure, but no such function exists.

**Key insight**: AC is subtle in HoTT because of the interplay between truncation and higher structure. It holds for sets (when assumed as an axiom) but fails for higher types.

### 3.2 Unique choice: the free lunch (15 min)

**Lemma 3.9.1**: if $P$ is a mere proposition, then $P \simeq \|P\|$.

In words: **truncation is invisible on mere propositions**. This makes sense — a mere prop is already "squashed," so truncating it does nothing.

**Corollary 3.9.2 (Unique Choice)**: if each $P(x)$ is a mere proposition and each $\|P(x)\|$ is inhabited, then $\prod_{(x:A)} P(x)$.

**Why is this a "free lunch"?** AC generally needs to be assumed as an axiom. But when the things you're choosing are **uniquely determined** (mere props), you don't need AC — unique choice gives it to you automatically.

**Practical technique**: suppose you know $\|A\|$ and want to extract an element $b : B$. Direct approach fails (truncation only lets you build mere props). But:

1. Define a predicate $Q : B \to \mathcal{U}$ such that $\sum_{(x:B)} Q(x)$ is a mere prop
2. Construct $(b, q)$ from any element of $A$ (i.e., build $A \to \sum_{(x:B)} Q(x)$)
3. By truncation, get $\left\|\sum_{(x:B)} Q(x)\right\|$
4. By Lemma 3.9.1, get $\sum_{(x:B)} Q(x)$
5. Project to get $b : B$

This pattern is pervasive in HoTT and makes many classically "non-constructive" arguments actually constructive.

```lean
-- Example: extract a unique element from truncated existence
example (P : Nat → Prop) (h : ∀ n m, P n → P m → n = m)
    (ex : ∃ n, P n) : Nat := by
  -- Since P picks a unique n (by h), we can extract it
  exact ex.choose  -- uses Classical.choice, but the UNIQUENESS
                    -- means we could do it constructively too
```

### 3.3 The truncation convention (10 min)

The HoTT Book uses **untruncated logic** by default: $\exists x. P(x)$ means $\sum_x P(x)$, not $\|\sum_x P(x)\|$. When truncation is needed, the adverb "merely" is used:

| Phrase | Meaning |
|---|---|
| "there exists $x$ such that $P(x)$" | $\sum_{(x:A)} P(x)$ (untruncated) |
| "there **merely** exists $x$ such that $P(x)$" | $\left\|\sum_{(x:A)} P(x)\right\|$ |
| "$A$ is inhabited" | just: $A$ has an element |
| "$A$ is **merely** inhabited" | $\|A\|$ has an element |

**Why**: untruncated existence is more informative, and much of HoTT mathematics works naturally at that level. Truncation is only needed when you specifically want to throw away the witness.

### 3.4 Synthesis: the n-type hierarchy and how to use it (5 min)

**Decision flow for "doing math in HoTT":**

```
Object of study
  │
  ├─ Is it a set? (groups, rings, graphs, ℕ, ℤ, ...)
  │     → work as in traditional math, use Ch3 tools
  │
  ├─ Is it a higher groupoid? (topological spaces, ∞-categories)
  │     → use full HoTT, Ch6 (HITs) and beyond
  │
  └─ Is it a mere proposition? (a truth value)
        → use propositional reasoning, LEM is safe
```

**When to truncate:**
- For disjunction and existential in *propositional* statements (to stay in mere props)
- When you don't care about the witness
- When you want to use classical logic

**When NOT to truncate:**
- When the witness matters
- When you want to compute with the result
- Most of the time in constructive mathematics

---

## Summary (5 min)

```
n-type hierarchy:
  (-2) contractible  ⊂  (-1) prop  ⊂  0 set  ⊂  1 groupoid  ⊂  ...  ⊂  ∞ arbitrary
    │                     │             │             │
  "one point"       "truth value"   "ordinary"    "categories"
```

Key ideas:
1. **n-types stratify types by higher structure.** Sets = no interesting higher paths. Mere propositions = at most one element. Contractible = exactly one.
2. **Universe is NOT a set** — that's why naive propositions-as-types breaks with univalence.
3. **Traditional logic lives in mere propositions.** LEM and double negation elimination are consistent *for mere props*, inconsistent for general types.
4. **Propositional truncation** squashes a type into a mere prop, recovering classical $\lor$ and $\exists$.
5. **Unique choice** gives AC for free when the choice is determined uniquely.

**The big picture**: HoTT doesn't force you to do "synthetic homotopy theory" — you can also do ordinary set-level math inside it. The n-type hierarchy is how you specify which level you're working at. Most mathematicians spend their time at level 0 (sets); HoTT's innovation is that *all* levels are available simultaneously, connected by a uniform language.

---

## Exercises

### A. Recognizing n-types

1. Is $\mathbb{Z}$ a set? Prove it in Lean.
2. Is the type `Nat → Nat` a set? (Hint: use function extensionality and the fact that `Nat` is a set.)
3. Is the type `Σ (A : Type), IsProp A` a set? A 1-type? Justify.

### B. Mere propositions

```lean
-- Show: if P and Q are mere propositions, so is P × Q
theorem and_is_prop (P Q : Prop) (hP : IsProp P) (hQ : IsProp Q) :
    IsProp (P × Q) := sorry

-- Show: if P is a mere proposition, so is ¬P
theorem not_is_prop (P : Prop) : IsProp (P → Empty) := sorry
```

### C. Truncation and choice

1. Show $\|A\| \to A$ is NOT provable in general. (Hint: what would it mean for $A = \mathsf{Bool}$?)
2. Show that if $A$ has decidable equality, then the "unique choice" workaround lets you extract a specific element from $\|A\|$ when $A$ is finite. (Think: search for a witness.)
3. Why does propositional resizing (Axiom 3.5.5) break without mere-proposition-valued predicates?

### D. Thinking

1. Explain in your own words: why is `Bool = Bool` a counterexample to "universe is a set"?
2. In what sense is the $n$-type hierarchy "from $n = -2$"? Why not start from $n = 0$?
3. Where exactly does the naive propositions-as-types break? Where does the refined version succeed?
