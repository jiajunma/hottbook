---
type: definition
title: "\u5B87\u5B99\u4E0E\u65CF / Universes and Families"
chapter: 1
section: 3
tags: [type-theory, type-former, universe]
references:
  - "[[00_Overview]]"
  - "[[function_type]]"
  - "[[pi_type]]"
---

# 宇宙与族 / Universes and Families

> A universe is a type whose elements are types. As in naive set theory, we might wish for a universe of all types including itself. However, as in set theory, this is unsound.
> — HoTT Book, Section 1.3

## 动机 / Motivation

我们希望能够**对类型进行量化**——例如定义"对所有类型 $A$ 都成立"的多态函数。为此需要一个"类型的类型"——即**宇宙 (universe)**。

We want to **quantify over types** — e.g. to define polymorphic functions that work for all types $A$. This requires a "type of types" — a **universe**.

## Lean 4

```lean
-- Nat, Bool 等都是 Type 的元素
#check Nat       -- Nat : Type
#check Bool      -- Bool : Type
#check Type      -- Type : Type 1
#check Type 1    -- Type 1 : Type 2

-- 类型族：从值到类型的函数
def MyFamily : Bool → Type
  | true  => Nat
  | false => String

#check MyFamily true    -- Type (= Nat)

-- 宇宙多态（Lean 自动处理层级）
def myId (α : Type) (x : α) : α := x
```

## 编程视角 / Programming Perspective

### Python: `type` 就是一个宇宙！

```python
# 在 Python 中，类型本身是值：
int_type: type = int       # "int : 𝒰" — int 是宇宙的一个元素
str_type: type = str       # "str : 𝒰" — str 也是

# type 本身就像 𝒰₀ — "类型的类型"
print(type(int))           # <class 'type'>
print(type(type))          # <class 'type'>  ← 危险！

# Python 允许 type(type) = type，即 𝒰 : 𝒰
# 但这在逻辑上是不安全的！(Russell 悖论 / Girard 悖论)
# HoTT 用宇宙层级来避免这个问题
```

### TypeScript: 类型与值的分离

```typescript
// TypeScript 严格分离类型层和值层
type MyType = number;        // 类型层：number 是一个类型
const x: number = 42;        // 值层：42 是 number 的元素

// 你不能写：
// const t: ??? = number;     // number 不是一个值！
// TypeScript 没有 "类型的类型" 作为值

// 但泛型参数暗示了宇宙的存在：
function id<A>(x: A): A { return x; }
// A 在 "所有类型" 上量化 — 这个 "所有类型" 就是宇宙 𝒰

// TypeScript 的 "type" 关键字可以理解为：
// type Pair<A, B> = { fst: A; snd: B };
// 定义了一个类型族 Pair : 𝒰 → 𝒰 → 𝒰
```

## 宇宙层级 / Universe Hierarchy

宇宙构成一个累积的层级：

$$\mathcal{U}_0 : \mathcal{U}_1 : \mathcal{U}_2 : \cdots$$

### 规则 / Rules

- 每个 $\mathcal{U}_i$ 本身是 $\mathcal{U}_{i+1}$ 的一个元素
- **累积性 (cumulativity)**: 如果 $A : \mathcal{U}_i$，则 $A : \mathcal{U}_{i+1}$
- 不存在"所有宇宙的宇宙" — 这避免了 Girard 悖论

### 为什么需要层级？ / Why a Hierarchy?

```python
# 类比 Russell 悖论：
# 假设存在 "所有集合的集合" S
# 令 R = { x ∈ S | x ∉ x }  →  R ∈ R 当且仅当 R ∉ R，矛盾！

# 类型论版本：如果 𝒰 : 𝒰，可以构造类似的悖论 (Girard's paradox)
# 解决方案：𝒰₀ : 𝒰₁ : 𝒰₂ : ...
# 每个宇宙只属于更高层的宇宙，永远没有自引用
```

> **关键洞察 / Key Insight**: 宇宙层级解决了 Russell 式悖论。如果允许 $\mathcal{U} : \mathcal{U}$，则可以构造矛盾。

## 典型歧义 / Typical Ambiguity

在实践中，我们通常省略宇宙层级下标，简写为 $\mathcal{U}$。这称为**典型歧义 (typical ambiguity)**。

In practice, we omit universe level subscripts and write simply $\mathcal{U}$. This is called **typical ambiguity**. The reader (or proof assistant) can always reconstruct consistent level assignments.

编程类比：就像 TypeScript 中你写 `Array<T>` 而不关心 `T` 在编译器内部的具体表示层级。

## 类型族 / Type Families

> To model a collection of types varying over a given type $A$, we use functions $B : A \to \mathcal{U}$ whose codomain is a universe. These functions are called *families of types* (or sometimes *dependent types*).
> — HoTT Book, Section 1.3

**类型族 (type family)** 是一个以类型为值的函数：

$$B : A \to \mathcal{U}$$

对每个 $a : A$，$B(a)$ 是一个类型。这是**依赖类型 (dependent types)** 的核心概念。

### 编程类比 / Programming Analogy

```typescript
// 类型族 = 从值到类型的映射
// TypeScript 的条件类型就是类型族！

type ElementType<T extends "number" | "string" | "boolean"> =
    T extends "number" ? number :
    T extends "string" ? string :
    T extends "boolean" ? boolean :
    never;

// ElementType : {"number"|"string"|"boolean"} → 𝒰
// ElementType("number") = number
// ElementType("string") = string
// 输入不同的值，返回不同的类型

// 更数学的例子：
// Fin : ℕ → 𝒰
// Fin(n) = 恰好有 n 个元素的有限类型
// Fin(0) = 𝟎 (空类型 / never)
// Fin(1) = 𝟏 (单元类型 / void 的对偶)
// Fin(2) = 𝟐 (布尔 / boolean)
// Fin(3) = {0, 1, 2}
```

### 经典示例 / Classic Example

$$\mathsf{Fin} : \mathbb{N} \to \mathcal{U}$$

其中 $\mathsf{Fin}(n)$ 是恰好有 $n$ 个元素的有限类型：
- $\mathsf{Fin}(0) \simeq \mathbf{0}$（空类型）
- $\mathsf{Fin}(1) \simeq \mathbf{1}$（单元类型）
- $\mathsf{Fin}(2) \simeq \mathbf{2}$（布尔类型）

## 宇宙、类型族与依赖类型的关系 / How It All Connects

```
         类型族 B : A → 𝒰
              ↓
    对每个 a:A，B(a) 是一个类型
        ↙              ↘
Π(x:A) B(x)        Σ(x:A) B(x)
依赖函数类型          依赖对类型
"对所有 x"          "存在某个 x"
```

宇宙使类型族成为可能，类型族使 $\Pi$ 类型和 $\Sigma$ 类型成为可能。这三者构成依赖类型论的基础。

## 与集合论比较 / Comparison with Set Theory

| 集合论 / Set Theory | 类型论 / Type Theory |
|--------------------|--------------------|
| 集合的集合（需要小心） | 宇宙 $\mathcal{U}_i$ |
| 索引集族 $\{B_a\}_{a \in A}$ | 类型族 $B : A \to \mathcal{U}$ |
| 没有内建层级限制 | 严格的宇宙层级 |
| ZFC 通过分离公理限制 | 类型论通过层级避免悖论 |

## 相关概念 / Related Concepts

- [[pi_type]] — 依赖函数类型，使用类型族
- [[sigma_type]] — 依赖对类型，使用类型族
- [[function_type]] — 非依赖的特殊情况

## 参考文献 / References

- HoTT Book, Section 1.3: Universes and families
