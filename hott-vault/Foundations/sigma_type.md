---
type: definition
title: "\u03A3 \u7C7B\u578B / Dependent Pair Types (\u03A3-Types)"
chapter: 1
section: 6
tags: [type-theory, type-former, sigma-type, dependent-type]
references:
  - "[[00_Overview]]"
  - "[[universes]]"
  - "[[pi_type]]"
  - "[[product_type]]"
---

# $\Sigma$ 类型 / Dependent Pair Types ($\Sigma$-Types)

## 定义 / Definition

给定 $A : \mathcal{U}$ 和 $B : A \to \mathcal{U}$，**依赖对类型 (dependent pair type)** 为：

$$\sum_{(x:A)} B(x)$$

其元素是对 $(a, b)$，其中 $a : A$ 且 $b : B(a)$。第二个分量的**类型依赖于**第一个分量的**值**。

The elements of $\sum_{(x:A)} B(x)$ are pairs $(a, b)$ where $a : A$ and $b : B(a)$. The type of the second component **depends on the value** of the first.

## Lean 4

```lean
-- 普通积（不依赖）
#check (42, "hello")    -- Nat × String

-- 依赖对：Σ(n : Nat), Vec Nat n
inductive Vec (α : Type) : Nat → Type where
  | nil  : Vec α 0
  | cons : α → Vec α n → Vec α (n + 1)

def myVec : (n : Nat) × Vec Nat n :=
  ⟨2, .cons 10 (.cons 20 .nil)⟩

-- 存在量词
example : ∃ n : Nat, n > 5 := ⟨7, by omega⟩
```

## 核心直觉 / Core Intuition

一句话理解：**$\Sigma$ 类型 = 第二个字段的类型由第一个字段的值决定的结构体**。

One-liner: a $\Sigma$-type is a struct where the type of a later field can depend on the value of an earlier field.

## 编程视角 / Programming Perspective

### TypeScript: 从普通 tuple 到依赖对

```typescript
// 普通积类型（无依赖）：两个字段类型固定
type Pair = { fst: number; snd: string }; // number × string

// 依赖对——第二个字段的 **类型** 由第一个字段的 **值** 决定：
// 例：一个数字 n 配上恰好 n 个元素的数组
// Σ(n:ℕ) Vec(n)
type DepPair = { n: number; elements: /* 长度恰好为 n 的数组 */ any[] };

// TypeScript 中最接近的近似：可辨识联合 (Discriminated Union)
type Shape =
  | { kind: "circle"; radius: number }
  | { kind: "rect"; width: number; height: number };
// kind = "circle" 时可用字段是 radius
// kind = "rect"   时可用字段是 width + height
// 可用字段 **依赖于** kind 的值！这就是 Σ 类型的精髓

function area(s: Shape): number {
    switch (s.kind) {
        case "circle": return Math.PI * s.radius ** 2;
        case "rect":   return s.width * s.height;
    }
}
```

### Python: 从 tuple 到存在量词

```python
# 非依赖版本：普通 tuple = 积类型
from typing import NamedTuple
class Point(NamedTuple):
    x: float
    y: float
# Point ≃ float × float

# 依赖版本的直觉：
# Σ(n:ℕ) Vec(n) = "一个数字 n，加上恰好 n 个元素的列表"
sized_data = (3, [10, 20, 30])  # n=3, 列表恰好 3 个元素
bad_data   = (3, [10, 20])      # 不合法！n=3 但只有 2 个元素
# 第二个分量的 **合法性** 取决于第一个分量的 **值**

# Python 的 dataclass 无法在类型层面表达这种依赖
# 只有 Lean/Idris/Agda 才能在编译期检查长度匹配
```

## 与积类型的关系 / Relation to Product Types

当 $B$ 是常量族时，$\Sigma$ 类型退化为普通积类型：

$$\sum_{(x:A)} C \;\equiv\; A \times C$$

类比：`Shape` 如果每个 `kind` 都有相同的字段，那它就退化成普通 struct。

## 五条规则 / Five Rules

### 1. 形成 / Formation

$$\frac{A : \mathcal{U} \quad x:A \vdash B(x) : \mathcal{U}}{\sum_{(x:A)} B(x) : \mathcal{U}}$$

### 2. 引入 / Introduction

$$\frac{a : A \quad b : B(a)}{(a, b) : \sum_{(x:A)} B(x)}$$

编程类比：构造对象 `{ kind: "circle", radius: 5 }`。

### 3. 消除 / Elimination (Projections)

$$\mathsf{pr}_1 : \left(\sum_{(x:A)} B(x)\right) \to A$$

$$\mathsf{pr}_2 : \prod_{(p : \sum_{(x:A)} B(x))} B(\mathsf{pr}_1(p))$$

> **注意 / Note**: $\mathsf{pr}_2$ 的返回类型本身是**依赖的** — 它依赖于 $\mathsf{pr}_1(p)$ 的值。编程类比：`s.radius` 只有在 `s.kind === "circle"` 时才合法。

### 4. 计算 / Computation

$$\mathsf{pr}_1(a, b) \equiv a \qquad \mathsf{pr}_2(a, b) \equiv b$$

### 5. 唯一性 / Uniqueness (Propositional)

$$p =_{\sum_{(x:A)} B(x)} (\mathsf{pr}_1(p),\, \mathsf{pr}_2(p))$$

## 类型论中的选择公理 / Type-Theoretic Axiom of Choice

> The type-theoretic axiom of choice: $\left(\prod_{(x:A)} \sum_{(y:B)} R(x,y)\right) \to \sum_{(f:A \to B)} \prod_{(x:A)} R(x, f(x))$ is directly provable — no extra axioms needed.
> — HoTT Book, Section 1.6

**证明 / Proof**: 给定 $g : \prod_{(x:A)} \sum_{(y:B)} R(x,y)$，定义：
- $f :\equiv \lambda x.\, \mathsf{pr}_1(g(x))$
- 证据：$\lambda x.\, \mathsf{pr}_2(g(x))$

### 编程直觉 / Programming Intuition for AC

```typescript
// 选择公理的编程版本——只是 "解包" 操作！
// 输入：对每个 x，都有一对 { y, proof }
// 输出：一个函数 f 和所有 proof
function ac<A, B>(g: (x: A) => { y: B; proof: any }) {
    return {
        f: (x: A) => g(x).y,           // 提取所有 y 组成函数
        proofs: (x: A) => g(x).proof,   // 提取所有证据
    };
}
```

> **关键洞察 / Key Insight**: 在集合论中选择公理是额外公理，但在类型论中它是定理！$\prod$ 和 $\sum$ 的计算内容天然包含了"选择"。

## 编码数学结构 / Encoding Mathematical Structures

$\Sigma$ 类型可以编码"具有某种结构的类型"：

| 结构 / Structure | 编码 / Encoding | 直觉 / Intuition |
|---------|---------|---------|
| 岩浆 Magma | $\sum_{(A:\mathcal{U})} (A \to A \to A)$ | 类型 + 二元运算 |
| 指向类型 Pointed | $\sum_{(A:\mathcal{U})} A$ | 类型 + 选定元素 |
| 半群 Semigroup | $\sum_{(A:\mathcal{U})} \sum_{(m:A \to A \to A)} \mathsf{isAssoc}(m)$ | 类型 + 运算 + 结合律证明 |

编程类比：就像 TypeScript 的 interface — 捆绑数据和操作。

## 直觉总结 / Intuition Summary

| 视角 / Perspective | 理解 / Understanding |
|-------------------|---------------------|
| 编程 / Programming | 可辨识联合、依赖 struct |
| 逻辑 / Logic | 存在量词 $\exists x:A.\, B(x)$ |
| 类型论 / Type theory | 依赖对 / 广义积 |
| 同伦论 / Homotopy | 纤维化的总空间 |
| 集合论 / Set theory | 不交并 $\coprod_{a \in A} B(a)$ |

**逻辑类比 / Logical analogy**: "$\exists$ 学生 $x$，$x$ 通过了考试" 就是说你能给出一个**具体的学生**和**该学生通过考试的证据**。这正是一个依赖对 $(x, \text{proof})$。

## 相关概念 / Related Concepts

- [[product_type]] — $\Sigma$ 类型的非依赖特殊情况
- [[pi_type]] — 与 $\Sigma$ 类型对偶
- [[universes]] — 类型族 $B : A \to \mathcal{U}$

## 参考文献 / References

- HoTT Book, Section 1.6: Dependent pair types ($\Sigma$-types)
