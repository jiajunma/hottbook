---
type: definition
title: 余积类型 / Coproduct Types
chapter: 1
section: 7
tags: [type-theory, type-former, coproduct, empty-type]
references:
  - "[[00_Overview]]"
  - "[[product_type]]"
  - "[[bool]]"
---

# 余积类型 / Coproduct Types (HoTT Book \S 1.7)

## 定义 / Definition

给定类型 $A, B : \mathcal{U}$，**余积类型** $A + B$ 表示 $A$ 或 $B$ 的**不交并 (disjoint union)** --- 每个元素要么来自 $A$，要么来自 $B$，而且你**知道它来自哪一边**。

Given $A, B : \mathcal{U}$, the **coproduct type** $A + B$ is the disjoint union: each element is tagged as coming from $A$ or from $B$.

## Lean 4

```lean
-- 用 inductive 定义余积
inductive MySum (α β : Type) where
  | inl : α → MySum α β
  | inr : β → MySum α β

-- 消去 = 模式匹配（必须穷尽）
def handle : MySum Nat String → String
  | .inl n => s!"num: {n}"
  | .inr s => s!"str: {s}"

-- 空类型
inductive MyEmpty where
def absurd' (e : MyEmpty) : α := nomatch e
```

## 编程视角 / Programming Perspective

余积类型就是编程中的 **tagged union** (标记联合体) 或 **Either** 类型。

```python
# Coproduct = tagged union / Either
from dataclasses import dataclass
from typing import Generic, TypeVar

A, B = TypeVar('A'), TypeVar('B')

@dataclass
class Left(Generic[A]):
    value: A

@dataclass
class Right(Generic[B]):
    value: B

Either = Left[A] | Right[B]

# Example: inl 和 inr 是两个"注入" / two injections
result: Either[str, int] = Left("error")   # inl("error")
result2: Either[str, int] = Right(42)      # inr(42)

# Elimination = pattern matching / 消除 = 模式匹配
def handle(e: Either[str, int]) -> str:
    match e:
        case Left(msg): return f"Error: {msg}"   # case inl
        case Right(n):  return f"Got: {n}"        # case inr
```

```typescript
// TypeScript discriminated union / 可辨别联合类型
type Either<A, B> =
  | { tag: 'left';  value: A }   // inl(a)
  | { tag: 'right'; value: B };  // inr(b)

// Pattern matching via switch
function handle(e: Either<string, number>): string {
  switch (e.tag) {
    case 'left':  return `Error: ${e.value}`;
    case 'right': return `Got: ${e.value}`;
  }
}
```

关键对应 / Key correspondences:

| HoTT | 编程 Programming |
|------|------------------|
| $\mathsf{inl}(a)$ | `Left(a)` / `{ tag: 'left', value: a }` |
| $\mathsf{inr}(b)$ | `Right(b)` / `{ tag: 'right', value: b }` |
| $\mathsf{ind}_{A+B}$ | `match` / `switch` (pattern matching) |

## 规则 / Rules

### Introduction --- 注入 / Injections

$$\mathsf{inl} : A \to A + B \qquad \mathsf{inr} : B \to A + B$$

每个注入给值"贴标签"，标记它来自哪一边。Each injection "tags" a value with which side it comes from.

### Elimination --- 分情况讨论 / Case Analysis

给定 $C : A + B \to \mathcal{U}$，要定义 $\prod_{(x : A+B)} C(x)$，只需分别处理两种情况：

$$\mathsf{ind}_{A+B} : \left(\prod_{(a:A)} C(\mathsf{inl}(a))\right) \to \left(\prod_{(b:B)} C(\mathsf{inr}(b))\right) \to \prod_{(x:A+B)} C(x)$$

### Computation --- 计算规则

$$\mathsf{ind}_{A+B}(g_0, g_1, \mathsf{inl}(a)) \equiv g_0(a)$$
$$\mathsf{ind}_{A+B}(g_0, g_1, \mathsf{inr}(b)) \equiv g_1(b)$$

这正是 pattern matching 的语义：匹配到 `Left` 就执行 $g_0$，匹配到 `Right` 就执行 $g_1$。

## 空类型 / Empty Type $\mathbf{0}$

$\mathbf{0}$ 是**空余积** (nullary coproduct) --- 没有构造子 (no introduction rules)，所以**不存在**任何元素。

编程类比：TypeScript 的 `never` 类型 --- 没有任何值属于这个类型。

```typescript
// Empty type = never (no values exist)
type Empty = never;

// Ex falso: a function from never to anything is trivially definable
// 从 never 到任何类型的函数"自动存在"，因为永远不会被调用
function absurd<T>(x: never): T {
    throw "impossible";  // can never actually be called!
}
```

### 消除规则 / Elimination (ex falso quodlibet)

$$\mathsf{ind}_{\mathbf{0}} : \prod_{(C : \mathbf{0} \to \mathcal{U})} \prod_{(x:\mathbf{0})} C(x)$$

翻译成人话：如果你给我一个 $\mathbf{0}$ 的元素，我能证明**任何事**。但因为 $\mathbf{0}$ 没有元素，这个承诺永远不会被兑现。

> **关键洞察 / Key Insight**: 消除规则是**空洞真 (vacuously true)** 的 --- 因为不存在 $\mathbf{0}$ 的元素，所以没有需要处理的情况。

这在编程中也很自然：TypeScript 的类型检查器知道 `never` 分支不可达，所以允许你返回任何类型。

## 逻辑解读 / Logical Reading

在 Curry-Howard 对应下，类型对应命题，元素对应证明：

| 类型 Type | 逻辑 Logic | 直觉 Intuition |
|----------|-----------|----------------|
| $A + B$ | $A \lor B$ (析取 disjunction) | 知道 $A$ 或 $B$ 中**哪个**成立 |
| $\mathsf{inl}(a)$ | $A$ 的证据 | 左边成立，证据是 $a$ |
| $\mathsf{inr}(b)$ | $B$ 的证据 | 右边成立，证据是 $b$ |
| $\mathbf{0}$ | $\bot$ (假 falsehood) | 无法证明的命题 |
| $\mathsf{ind}_{\mathbf{0}}$ | 爆炸原理 ex falso | 从假前提可推出一切 |

> **注意**: 析取是**证明相关的 (proof-relevant)** --- 知道 $A + B$ 有 inhabitant 意味着知道**哪一边**有证据。这比经典逻辑的"$A \lor B$"更强。

## 具体例子 / Concrete Example

定义"安全除法"：结果要么是商 (成功)，要么是错误信息 (除以零)。

$$\mathsf{safediv} : \mathbb{N} \times \mathbb{N} \to \mathbb{N} + \mathsf{String}$$

- $\mathsf{safediv}(10, 3) :\equiv \mathsf{inl}(3)$ --- 成功，商为 3
- $\mathsf{safediv}(10, 0) :\equiv \mathsf{inr}(\text{"division by zero"})$ --- 失败

这正是 Rust 的 `Result<T, E>` 和 Haskell 的 `Either` 的理论基础。

## 相关概念 / Related Concepts

- [[product_type]] --- 余积类型的对偶 (dual)
- [[bool]] --- $\mathbf{1} + \mathbf{1} \simeq \mathbf{2}$
- [[propositions_as_types]] --- 余积 = 析取

## 参考文献 / References

- HoTT Book, Section 1.7: Coproduct types
