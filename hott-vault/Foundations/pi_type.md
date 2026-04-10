---
type: definition
title: "\u03A0 \u7C7B\u578B / Dependent Function Types (\u03A0-Types)"
chapter: 1
section: 4
tags: [type-theory, type-former, pi-type, dependent-type]
references:
  - "[[00_Overview]]"
  - "[[function_type]]"
  - "[[universes]]"
---

# $\Pi$ 类型 / Dependent Function Types ($\Pi$-Types)

> In type theory we often use a more general version of function types, called a $\Pi$-type or dependent function type. The elements of a $\Pi$-type are functions whose codomain type can vary depending on the element of the domain to which the function is applied.
> — HoTT Book, Section 1.4

## 定义 / Definition

给定类型 $A : \mathcal{U}$ 和类型族 $B : A \to \mathcal{U}$，**依赖函数类型 (dependent function type)** 为：

$$\prod_{(x:A)} B(x)$$

其元素是这样的函数：对每个 $a : A$，返回一个 $B(a)$ 类型的元素。关键点：**返回类型随输入值变化**。

Given $A : \mathcal{U}$ and $B : A \to \mathcal{U}$, the **dependent function type** $\prod_{(x:A)} B(x)$ consists of functions that, given $a : A$, return an element of $B(a)$. The return type **depends on** the input value.

## Lean 4

```lean
-- 普通函数（返回类型固定）
def double (x : Nat) : Nat := x + x

-- 依赖函数（返回类型随输入变化）
def MyFamily : Bool → Type
  | true  => Nat
  | false => String

def familyVal : (b : Bool) → MyFamily b
  | true  => 42
  | false => "hello"

-- 多态 = Π 对 Type 的特殊情况
def myId (α : Type) (x : α) : α := x
```

## 从普通函数到依赖函数：三步理解 / Three Steps to Understanding

理解 $\Pi$ 类型的关键是一个渐进过程 / The key is a gradual progression:

**第一步：普通函数 / Step 1: Ordinary functions.** 返回类型固定。

$$f : A \to B \quad\text{（返回类型始终是 } B \text{）}$$

**第二步：泛型函数 / Step 2: Generic (polymorphic) functions.** 返回类型依赖于一个**类型参数**。

$$\mathsf{id} : \prod_{(A:\mathcal{U})} (A \to A) \quad\text{（对每个类型 } A \text{ 返回 } A \to A \text{）}$$

**第三步：完全依赖函数 / Step 3: Fully dependent functions.** 返回类型依赖于一个**值参数**。这是真正的跳跃！

$$f : \prod_{(n:\mathbb{N})} \mathsf{Vec}(n) \quad\text{（输入 } n=3 \text{ 返回长度 3 的向量类型）}$$

## 编程视角 / Programming Perspective

### TypeScript: 泛型就是 $\Pi$ 类型的特例！

```typescript
// 第二步：泛型函数 = 对类型参数的 Π 类型
// id : Π(A:𝒰) A → A
function id<A>(x: A): A { return x; }
// 对每个类型 A，id<A> 是一个 A → A 的函数

// swap : Π(A:𝒰) Π(B:𝒰) Π(C:𝒰) (A→B→C) → (B→A→C)
function swap<A, B, C>(
    g: (a: A) => (b: B) => C
): (b: B) => (a: A) => C {
    return (b) => (a) => g(a)(b);
}

// 第三步的飞跃：返回类型依赖于输入 **值**
// 大多数语言只能依赖类型，不能依赖值！
// 但设想：
// vectorOfLength : (n: number) => Vec<n>
// 输入 3 → 返回 Vec<3>，输入 5 → 返回 Vec<5>
// 每次调用的返回 **类型** 不同！
```

### Python: 为什么普通语言表达不了？

```python
# Python 可以写泛型（第二步）：
from typing import TypeVar
T = TypeVar('T')
def identity(x: T) -> T: return x  # Π(T:𝒰) T → T

# 但 Python 无法写第三步——返回类型依赖于值：
# def make_vector(n: int) -> Vec[n]:  # ← 语法错误！
#     ...
# 因为 Python 的类型系统不允许类型依赖值

# 只有 Lean/Idris/Agda 等语言才能写：
# def fmax (n : Nat) : Fin (n + 1) := n
# fmax(0) : Fin(1), fmax(1) : Fin(2), fmax(2) : Fin(3)
# 每次调用返回 **不同的类型**！
```

> An important class of dependent function types are functions which are *polymorphic* over a given universe. A polymorphic function is one which takes a type as one of its arguments, and then acts on elements of that type.
> — HoTT Book, Section 1.4

## 与普通函数类型的关系 / Relation to Simple Function Types

当 $B$ 是常量族（即 $B(x) \equiv C$ 对所有 $x$），$\Pi$ 类型退化为普通函数类型：

$$\prod_{(x:A)} C \;\equiv\; (A \to C)$$

类比 / Analogy: 就像 `Array<string>` 是 `Array<T>` 在 `T = string` 时的特例。

## 五条规则 / Five Rules

### 1. 形成规则 / Formation

$$\frac{\Gamma \vdash A : \mathcal{U} \quad \Gamma, x:A \vdash B(x) : \mathcal{U}}{\Gamma \vdash \prod_{(x:A)} B(x) : \mathcal{U}}$$

"如果 $A$ 是类型，且对每个 $x:A$，$B(x)$ 也是类型，那么 $\prod_{(x:A)} B(x)$ 是类型。"

### 2. 引入规则 / Introduction (Lambda Abstraction)

$$\frac{\Gamma, x:A \vdash b(x) : B(x)}{\Gamma \vdash \lambda x.\, b(x) : \prod_{(x:A)} B(x)}$$

编程类比：定义函数体 `(x) => b(x)` 就是构造 $\Pi$ 类型的元素。

### 3. 消除规则 / Elimination (Application)

$$\frac{\Gamma \vdash f : \prod_{(x:A)} B(x) \quad \Gamma \vdash a : A}{\Gamma \vdash f(a) : B(a)}$$

编程类比：函数调用 `f(a)` — 注意返回类型是 $B(a)$，依赖于输入！

### 4. 计算规则 / Computation ($\beta$-reduction)

$$(\lambda x.\, b(x))(a) \equiv b(a)$$

编程类比：`((x) => x + 1)(3)` 计算得 `4`。

### 5. 唯一性原理 / Uniqueness ($\eta$-expansion)

$$f \equiv (\lambda x.\, f(x))$$

编程类比：`f` 和 `(x) => f(x)` 在行为上完全相同（eta 等价）。

## 示例 / Examples

### 多态恒等函数 / Polymorphic Identity

$$\mathsf{id} :\equiv \lambda A.\, \lambda x.\, x \;:\; \prod_{(A:\mathcal{U})} A \to A$$

对每个类型 $A$，$\mathsf{id}(A)$ 是 $A$ 上的恒等函数。TypeScript 中就是 `<A>(x: A) => x`。

### swap 函数 / Swap Function

$$\mathsf{swap} : \prod_{(A:\mathcal{U})} \prod_{(B:\mathcal{U})} \prod_{(C:\mathcal{U})} (A \to B \to C) \to (B \to A \to C)$$

$$\mathsf{swap}(A, B, C, g) :\equiv \lambda b.\, \lambda a.\, g(a)(b)$$

## 直觉 / Intuition

| 视角 / Perspective | 理解 / Understanding |
|-------------------|---------------------|
| 编程 / Programming | 泛型函数，类型参数化 |
| 逻辑 / Logic | 全称量词 $\forall x:A.\, B(x)$ |
| 类型论 / Type theory | 依赖函数空间 |
| 同伦论 / Homotopy | 纤维化的截面空间 |

**逻辑类比 / Logical analogy**: "$\forall$ 学生 $x$，$x$ 通过了考试" 就是说存在一个函数，输入任何学生 $x$，输出 $x$ 通过考试的证据。证据的类型（哪门考试、什么分数）可能因学生而异 — 这就是依赖性！

## 相关概念 / Related Concepts

- [[function_type]] — $\Pi$ 类型的非依赖特殊情况
- [[universes]] — 类型族 $B : A \to \mathcal{U}$
- [[sigma_type]] — 依赖对，与 $\Pi$ 类型对偶

## 参考文献 / References

- HoTT Book, Section 1.4: Dependent function types ($\Pi$-types)
