/-!
# HoTT Essentials Workshop
# Chapters 1–3 of the HoTT Book, in Lean 4
#
# Paste this entire file into https://live.lean-lang.org/
# Work through the sections in order.
# Replace `sorry` with your solutions.
-/

-- ============================================================
-- PART 1: Types, Functions, and Data (Ch1)
-- ============================================================

-- § Every expression has a type
#check 42            -- Nat
#check "hello"       -- String
#check true          -- Bool
#check fun x => x    -- ?α → ?α

-- § Definitions
def double (x : Nat) : Nat := x + x
#eval double 21      -- 42

-- § Lambda = anonymous function
#eval (fun x => x * x) 5   -- 25

-- § Currying: multi-argument = nested single-argument
def add (x : Nat) (y : Nat) : Nat := x + y
#check add 3         -- Nat → Nat  (partial application!)
#eval add 3 4        -- 7

-- § Definitional equality: rfl succeeds when Lean can compute
example : double 3 = 6 := rfl
example : add 2 3 = 5 := rfl

-- § Propositional equality: needs proof when Lean can't just compute
-- example : ∀ n, n + 0 = n := rfl  -- ✗ fails! n is a variable
theorem add_zero' (n : Nat) : n + 0 = n := by
  induction n with
  | zero => rfl
  | succ n ih => simp [Nat.succ_add, ih]


-- ────────────────────────────────────────────────
-- EXERCISE 1A: Write a function that computes n!
-- ────────────────────────────────────────────────
def factorial : Nat → Nat
  | 0 => sorry
  | n + 1 => sorry

-- Uncomment to test:
-- #eval factorial 5   -- should be 120


-- § Inductive types: define your own
inductive MyNat where
  | zero : MyNat
  | succ : MyNat → MyNat

open MyNat

def myAdd : MyNat → MyNat → MyNat
  | zero,   n => n
  | succ m, n => succ (myAdd m n)


-- ────────────────────────────────────────────────
-- EXERCISE 1B: Define multiplication on MyNat
-- ────────────────────────────────────────────────
def myMul : MyNat → MyNat → MyNat
  | zero,   _ => sorry
  | succ m, n => sorry


-- § Products = pairs
def p : Nat × String := (42, "hello")
#eval p.1            -- 42
#eval p.2            -- "hello"
example : (42, "hello").1 = 42 := rfl

-- § Coproducts = tagged union
inductive MyEither (α β : Type) where
  | left  : α → MyEither α β
  | right : β → MyEither α β

def describe : MyEither Nat String → String
  | .left  n => s!"number: {n}"
  | .right s => s!"string: {s}"

-- § Empty type = False (no constructors)
inductive MyEmpty where

-- From False, anything follows (ex falso)
def exFalso (e : MyEmpty) : α := nomatch e


-- § Curry-Howard: propositions = types, proofs = programs

-- True = Unit (one proof: ())
-- False = Empty (no proof)
-- A ∧ B = A × B (pair of proofs)
-- A → B = function (transform proof of A into proof of B)
-- ¬A = A → False

-- A proof is just a function!
-- (Using `def` because the types involve Sort, not just Prop)
def andSwap (h : A ∧ B) : B ∧ A := ⟨h.2, h.1⟩

def impTrans (f : A → B) (g : B → C) : A → C :=
  fun a => g (f a)


-- ────────────────────────────────────────────────
-- EXERCISE 1C: Prove these (replace sorry)
-- ────────────────────────────────────────────────
def ex1c_1 : A → (B → A) := sorry

def ex1c_2 (h : A ∧ B → C) : A → B → C := sorry

def ex1c_3 (h : A → B → C) : A ∧ B → C := sorry


-- ============================================================
-- PART 2: Paths and Higher Structure (Ch2)
-- ============================================================

-- § Identity type: a = b is a TYPE whose elements are PATHS
variable {α : Type} {β : Type} {x y z w : α}

-- § rfl: the trivial path (reflexivity)
example : 3 = 3 := rfl
example : (fun x => x + 1) 2 = 3 := rfl

-- § Symmetry: reverse a path
example (p : x = y) : y = x := p.symm

-- § Transitivity: concatenate paths
example (p : x = y) (q : y = z) : x = z := p.trans q

-- § Groupoid laws (all proved by path induction = cases)
theorem symm_symm (p : x = y) : p.symm.symm = p := by cases p; rfl
theorem trans_refl (p : x = y) : p.trans rfl = p := by cases p; rfl
theorem trans_symm (p : x = y) : p.trans p.symm = rfl := by cases p; rfl
theorem path_assoc (p : x = y) (q : y = z) (r : z = w) :
    (p.trans q).trans r = p.trans (q.trans r) := by
  cases p; cases q; cases r; rfl


-- ────────────────────────────────────────────────
-- EXERCISE 2A: Prove these path equations
-- ────────────────────────────────────────────────
theorem ex2a_1 (p : x = y) : rfl.trans p = p := sorry

theorem ex2a_2 (p : x = y) : p.symm.trans p = rfl := sorry


-- § ap: functions act on paths ("continuity")
-- If p : x = y, then f maps it to a path f x = f y
#check @congrArg  -- (f : α → β) → a₁ = a₂ → f a₁ = f a₂

example (f : Nat → Nat) {a b : Nat} (p : a = b) : f a = f b :=
  congrArg f p

-- ap preserves path composition
theorem ap_trans' (f : α → β) {a b c : α} (p : a = b) (q : b = c) :
    congrArg f (p.trans q) = (congrArg f p).trans (congrArg f q) := by
  cases p; cases q; rfl


-- § Transport: move data along a path
-- If P : α → Type and p : x = y, then transport gives P x → P y
def myTransport {A : Sort u} (P : A → Sort v) {a b : A}
    (p : a = b) (x : P a) : P b :=
  p ▸ x

-- Example: 0 + n = n is rfl, but n + 0 = n needs induction
example : 0 + 2 = 2 := rfl
-- example : 2 + 0 = 2 := rfl  -- ✗ fails
example : 2 + 0 = 2 := Nat.add_zero 2


-- § 2-paths: paths between paths
-- The groupoid laws ARE 2-paths. For example:
-- trans_refl p : (p.trans rfl = p)  is a 2-path

-- 3-paths: equalities between 2-paths
theorem three_path (p : x = y) :
    let proof1 : p.symm.symm = p := by cases p; rfl
    let proof2 : p.symm.symm = p := by cases p; rfl
    proof1 = proof2 := by cases p; rfl


-- ────────────────────────────────────────────────
-- EXERCISE 2B: Prove ap preserves inverses
-- ────────────────────────────────────────────────
theorem ex2b (f : α → β) {a b : α} (p : a = b) :
    congrArg f p.symm = (congrArg f p).symm := sorry


-- § Equivalences (simplified)
structure MyEquiv (α β : Type) where
  toFun    : α → β
  invFun   : β → α
  leftInv  : ∀ a, invFun (toFun a) = a
  rightInv : ∀ b, toFun (invFun b) = b

-- Bool ≃ Bool has TWO elements: id and not
def boolId : MyEquiv Bool Bool where
  toFun := id; invFun := id
  leftInv := fun _ => rfl; rightInv := fun _ => rfl

def boolNot : MyEquiv Bool Bool where
  toFun := not; invFun := not
  leftInv := fun b => by cases b <;> rfl
  rightInv := fun b => by cases b <;> rfl

-- These are different!
example : boolId.toFun true = true := rfl
example : boolNot.toFun true = false := rfl

-- § Univalence (concept): (A = B) ≃ (A ≃ B) in the universe
-- Bool = Bool has TWO paths (via id and not)
-- → The universe Type is NOT a set!


-- ============================================================
-- PART 3: Sets, Propositions, and Logic (Ch3)
-- ============================================================

-- § What is a "set" in HoTT?
-- A type A is a set if any two paths p q : x = y are equal.

-- Nat IS a set: any two proofs of m = n are the same
example (p q : (3 : Nat) = 3) : p = q := Subsingleton.elim p q

-- The universe is NOT a set (Bool = Bool has two different paths)


-- § What is a "mere proposition"?
-- A type P where any two elements are equal: at most one element.

def IsMereProp (P : Sort u) := ∀ (x y : P), x = y

-- Empty is a mere prop (vacuously)
example : IsMereProp Empty := fun x _ => nomatch x

-- Unit is a mere prop
example : IsMereProp Unit := fun x y => by cases x; cases y; rfl

-- Bool is NOT a mere prop (true ≠ false)


-- § n-type hierarchy (recursive definition)
-- (-2)-type = contractible = exactly one element
-- (-1)-type = mere proposition = at most one element
-- ( 0)-type = set = paths are mere propositions
-- ( 1)-type = groupoid = 2-paths are mere propositions
-- ...


-- § Why LEM fails for general types
-- LEM∞ : ∀ (A : Type), A ∨ ¬A  is INCONSISTENT with univalence
-- Because: if f : ∀ A, A ∨ ¬A, then f(Bool) must pick true or false,
-- but the swap equivalence (not) forces f(Bool) to be a fixed point
-- of not. But not has no fixed points!

-- § LEM is FINE for mere propositions (Lean's Prop has it)
open Classical in
example (P : Prop) : P ∨ ¬P := em P


-- ────────────────────────────────────────────────
-- EXERCISE 3A: Prove in Prop (all proofs equal)
-- ────────────────────────────────────────────────
theorem ex3a (P : Prop) (p q : P) : p = q := sorry


-- ────────────────────────────────────────────────
-- EXERCISE 3B: Double negation intro (constructive)
-- ────────────────────────────────────────────────
theorem dne_intro' (P : Prop) (a : P) : ¬¬P := sorry

-- De Morgan (one direction, constructive)
theorem deMorgan' {A B : Prop} (h : ¬(A ∨ B)) : ¬A ∧ ¬B := sorry


-- ────────────────────────────────────────────────
-- EXERCISE 3C: Induction on Nat
-- ────────────────────────────────────────────────

-- Prove: n + 0 = n by induction
theorem my_add_zero' : ∀ n : Nat, n + 0 = n := sorry

-- BONUS (hard): addition is commutative
-- theorem my_add_comm : ∀ m n : Nat, m + n = n + m := sorry


-- ============================================================
-- SUMMARY
-- ============================================================
/-!
What you've seen:
1. Types = propositions, programs = proofs (Curry-Howard)
2. Identity type a = b has rich structure: inverse, concat, groupoid laws
3. All structure comes from path induction (cases ... ; rfl)
4. Functions preserve paths (ap / congrArg)
5. Equivalences ≃ capture "same structure"
6. Univalence: (A = B) ≃ (A ≃ B) — equality IS equivalence
7. n-type hierarchy: contractible ⊂ prop ⊂ set ⊂ 1-type ⊂ ...
8. Classical logic (LEM) works for Prop but not for general Type

         Type (universe)
           ├── (x : A) → B x    Π-type (∀)
           ├── (x : A) × B x    Σ-type (∃)
           ├── inductive         Nat, Bool, custom types
           └── Prop              mere propositions
                ├── ∧ ∨ → ¬      logic
                └── a = b         identity type (paths!)
-/
