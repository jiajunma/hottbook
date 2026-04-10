---
type: definition
title: 命题即类型 / Propositions as Types
chapter: 1
section: 11
tags: [type-theory, propositions-as-types, curry-howard, constructive-logic]
references:
  - "[[00_MOC]]"
  - "[[pi_type]]"
  - "[[sigma_type]]"
  - "[[coproduct_type]]"
  - "[[teaching/symbol_guide]]"
---

# 命题即类型 / Propositions as Types

## Curry-Howard 对应 / The Curry-Howard Correspondence

这是整个第一章的**哲学高潮**：证明定理和写程序是**同一件事**。
This is the **philosophical climax** of Chapter 1: proving theorems and writing programs are **the same thing**.

类型论中的类型可以同时解读为命题。一个类型的**元素**就是该命题的**证明**。
Types can be read as propositions. An **element** (inhabitant) of a type is a **proof** of the corresponding proposition.

> The mathematical activity of *proving a theorem* is identified with a special case of the mathematical activity of *constructing an object* — in this case, an inhabitant of a type that represents a proposition.
> — HoTT Book, Introduction

## 完整对应表 / Full Correspondence Table

| 逻辑 / Logic | 类型 / Type | 编程 / Programming | 说明 |
|---|---|---|---|
| 真 True | $\mathbf{1}$ | `null` / `()` | 有唯一证明 $\star$ |
| 假 False | $\mathbf{0}$ | `never` | 没有证明（无居民） |
| $A \land B$ (且) | $A \times B$ | `[A, B]` tuple | 对 = 两个证明 |
| $A \lor B$ (或) | $A + B$ | `Either<A, B>` | 标记联合 = 某一边的证明 |
| $A \Rightarrow B$ (蕴含) | $A \to B$ | `(a: A) => B` | 函数 = 证明的变换 |
| $\neg A$ (否定) | $A \to \mathbf{0}$ | `(a: A) => never` | 推出矛盾 |
| $\forall x:A.\, P(x)$ | $\prod_{(x:A)} P(x)$ | 泛型函数 | 对每个 $x$ 给出证明 |
| $\exists x:A.\, P(x)$ | $\sum_{(x:A)} P(x)$ | 带约束的 pair | 见证 + 证明 |
| $A \Leftrightarrow B$ | $(A \to B) \times (B \to A)$ | 双向转换 | 逻辑等价 |

## Lean 4

```lean
-- 命题 = 类型，证明 = 居民
theorem and_comm (h : A ∧ B) : B ∧ A := ⟨h.2, h.1⟩

theorem imp_trans (f : A → B) (g : B → C) : A → C :=
  fun a => g (f a)

theorem dne_intro (a : A) : ¬¬A :=
  fun notA => notA a

-- 排中律不是自动成立的
-- #check Classical.em  -- 需要 open Classical

-- 恒等类型
example : 2 + 2 = 4 := rfl
```

## 编程视角 / Programming Perspective

### 类型就是命题，程序就是证明 / Types ARE Propositions, Programs ARE Proofs

```typescript
// "A 蕴含 B" = "从 A 到 B 的函数"
// 证明 A → B 就是：写一个接受 A 的证据、返回 B 的证据的函数

// 证明：A ∧ B → B ∧ A（且的交换律）
function andCommutative<A, B>(proof: [A, B]): [B, A] {
    const [a, b] = proof;
    return [b, a];  // 交换分量——这就是完整的证明！
}

// 证明：A → ¬¬A（双重否定引入）
function doubleNegIntro<A>(a: A): (notA: (a: A) => never) => never {
    return (notA) => notA(a);
    // 如果我有 a:A 的证据，又有 ¬A 的证据，就得到矛盾 (never)
}

// 证明：A → (B → A)（蕴含的弱化）
function weakening<A, B>(a: A): (b: B) => A {
    return (_b) => a;  // 忽略 B 的证据，直接返回 A 的证据
}
```

### 无法证明的事 / What We CANNOT Prove

```typescript
// ✗ 无法证明：¬¬A → A（双重否定消除）
// function doubleNegElim<A>(nna: (f: (a: A) => never) => never): A {
//     return ???;  // 无法从 "否定的否定" 中提取出 A 的值！
// }

// ✗ 无法证明：A ∨ ¬A（排中律）
// function lem<A>(): Either<A, (a: A) => never> {
//     return ???;  // 对一般的 A，既没有证据也没有反驳！
// }
```

为什么？因为类型论对应的是**构造主义逻辑**——你必须实际"构造"出证据，不能靠反证法。
Why? Because type theory corresponds to **constructive logic** — you must actually "construct" the evidence, you can't use proof by contradiction.

### Python 版本 / Python Version

```python
# 证明 A → (B → A)：给定 A 的证据，无论 B 是什么都能返回 A
def weakening(a):
    return lambda b: a    # λa. λb. a —— 这就是证明！

# 证明 (A → B) → (B → C) → (A → C)：函数组合 = 蕴含的传递性
def transitivity(f, g):
    return lambda a: g(f(a))  # 如果能从 A 推出 B，再从 B 推出 C，就能从 A 推出 C

# Curry-Howard 的魔力：上面不是"关于证明的程序"，
# 它们本身就是证明！类型签名就是定理陈述。
```

## 否定 / Negation

$$\neg A \;:\equiv\; A \to \mathbf{0}$$

$\neg A$ 的证明是一个函数：如果你给我任何 $A$ 的证据，我就能推出矛盾（$\mathbf{0}$ 的居民）。
A proof of $\neg A$ is a function: given any evidence of $A$, I produce a contradiction (an element of $\mathbf{0}$).

**双重否定 / Double negation:** 可以证明 $A \to \neg\neg A$：

$$\lambda a.\, \lambda f.\, f(a) \;:\; A \to (A \to \mathbf{0}) \to \mathbf{0}$$

直觉：如果我有 $a : A$，而你声称 $\neg A$（即 $f : A \to \mathbf{0}$），那我把 $a$ 喂给 $f$ 就得到矛盾。
Intuition: If I have $a : A$ and you claim $\neg A$ (i.e., $f : A \to \mathbf{0}$), I feed $a$ to $f$ to get a contradiction.

但**反过来不行**：无法从 $\neg\neg A$ 提取出 $A$ 的具体证据。
But the **reverse fails**: we cannot extract a concrete witness of $A$ from $\neg\neg A$.

## 构造主义 vs 经典逻辑 / Constructive vs Classical Logic

| 经典逻辑 / Classical | 构造主义 / Constructive | 状态 / Status |
|---|---|---|
| 排中律 $A \lor \neg A$ | $A + (A \to \mathbf{0})$ | **不是定理**——可加为公理 |
| 双重否定消除 $\neg\neg A \to A$ | $(A \to \mathbf{0}) \to \mathbf{0}) \to A$ | **不是定理** |
| 反证法 | 假设 $\neg A$ 推出矛盾 → $A$ | **不是定理** |
| $A \to \neg\neg A$ | $A \to (A \to \mathbf{0}) \to \mathbf{0}$ | ✓ 可证 |
| 爆炸原理 $\bot \to A$ | $\mathbf{0} \to A$ | ✓ 可证 |

> **关键洞察 / Key Insight**: 构造主义的 $A + B$ 不只是说"A 或 B 成立"——它**指出是哪一个**并给出证据。这比经典逻辑更强：你不能靠排中律"免费"获得证据，你必须真正构造它。
> Constructive $A + B$ doesn't just say "A or B holds" — it **specifies which one** with evidence. This is stronger than classical logic.

## 为什么这很重要？/ Why Does This Matter?

1. **证明助手** (Lean, Coq, Agda) 正是基于这个原理：写程序 = 证明定理
2. **程序正确性**：如果你的程序通过了类型检查，它就是一个正确的证明
3. **构造性**：每个存在性证明都自动给出具体的见证——不是"存在但我不知道是什么"

```
证明 ∃n:ℕ. n > 5          →  给出具体的 n=6 和 6>5 的证据
                               不是"假设不存在→矛盾→存在"
```

## 相关概念 / Related Concepts

- [[pi_type]] — 编码全称量词 $\forall$
- [[sigma_type]] — 编码存在量词 $\exists$
- [[coproduct_type]] — 编码析取 $\lor$，空类型 = 假
- [[product_type]] — 编码合取 $\land$，单元类型 = 真
- [[Identity_and_Paths/identity_type]] — 编码等式命题 $a = b$
- [[Logic/classical_vs_intuitionistic]] — 构造主义 vs 经典的详细比较

## 参考文献 / References

- HoTT Book, Section 1.11: Propositions as types
