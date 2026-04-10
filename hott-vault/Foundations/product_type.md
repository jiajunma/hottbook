---
type: definition
title: 积类型 / Product Types
chapter: 1
section: 5
tags: [type-theory, type-former, product-type]
references:
  - "[[00_Overview]]"
  - "[[function_type]]"
  - "[[sigma_type]]"
---

# 积类型 / Product Types (HoTT Book \S 1.5)

## 类型定义的通用模式 / The General Pattern

积类型是 HoTT Book 中第一次完整展示**五条规则 (five rules)** 的类型。这个模式是类型论的核心模板 --- 之后的每一种类型都遵循同样的结构。

> There is a general pattern for introduction of a new kind of type in type theory... To specify a type, we specify: (i) how to form new types of this kind, via *formation rules*; (ii) how to construct elements of that type (*introduction rules*); (iii) how to use elements of that type (*elimination rules*); (iv) a *computation rule*; (v) an optional *uniqueness principle*.

把它想象成定义一个新数据结构的"接口合同"：你必须说明怎么**创建**它、怎么**使用**它、以及使用后的**计算行为**。Think of it as the "interface contract" for defining a new data structure.

## 定义 / Definition

给定类型 $A, B : \mathcal{U}$，**积类型** $A \times B$ 的元素是有序对 $(a, b)$，其中 $a : A$ 且 $b : B$。Given types $A, B : \mathcal{U}$, the **product type** $A \times B$ consists of pairs $(a, b)$ with $a : A$ and $b : B$.

## 五条规则 / Five Rules

### 1. Formation --- 怎么声明这个类型？

$$\frac{A : \mathcal{U} \quad B : \mathcal{U}}{A \times B : \mathcal{U}}$$

### 2. Introduction --- 怎么构造元素？

$$\frac{a : A \quad b : B}{(a, b) : A \times B}$$

### 3. Elimination --- 怎么使用元素？(投影 / Projections)

$$\mathsf{pr}_1 : A \times B \to A \qquad \mathsf{pr}_2 : A \times B \to B$$

### 4. Computation --- 投影的计算行为

$$\mathsf{pr}_1(a, b) \equiv a \qquad \mathsf{pr}_2(a, b) \equiv b$$

### 5. Uniqueness --- 元素可以被投影完全确定

对任何 $p : A \times B$，有**命题唯一性原理**：

$$p =_{A \times B} (\mathsf{pr}_1(p),\, \mathsf{pr}_2(p))$$

> **注意 / Note**: 这里的唯一性是**命题的** (propositional) --- 可以证明，但不是定义相等 (judgmental equality)。

## Lean 4

```lean
-- 积类型
#check (42, "hello")   -- Nat × String
example : (42, "hello").1 = 42 := rfl

-- 模式匹配解构
def swap (p : α × β) : β × α :=
  let (a, b) := p; (b, a)

-- 单元类型
#check ()    -- Unit
```

## 编程视角 / Programming Perspective

积类型就是编程中的 **tuple** 或 **struct** --- 把两个值打包在一起。

```python
# Product type = tuple / struct
from typing import Tuple
pair: Tuple[int, str] = (42, "hello")  # (42, "hello") : int × str

# Projections = accessing fields / 投影 = 访问字段
fst = pair[0]  # pr₁(42, "hello") ≡ 42
snd = pair[1]  # pr₂(42, "hello") ≡ "hello"

# Recursor = destructuring / 递归子 = 解构
def show_pair(p: Tuple[int, str]) -> str:
    x, y = p  # destructuring = applying the recursor
    return f"{x}: {y}"
```

```typescript
// TypeScript: tuple type
type Pair<A, B> = [A, B];
const p: Pair<number, string> = [42, "hello"];
const [x, y] = p;  // destructuring = projections

// Unit type = void/undefined with one value
type Unit = null;   // only one value: null
```

五条规则对应编程概念 / The five rules map to programming:

| 规则 Rule | 编程对应 Programming analog |
|-----------|---------------------------|
| Formation | 类型声明 `Tuple[int, str]` |
| Introduction | 构造 `(42, "hello")` |
| Elimination | 解构 / 字段访问 `p[0]`, `p[1]` |
| Computation | `(42, "hello")[0]` 求值得 `42` |
| Uniqueness | 任何 tuple 都等于 `(p[0], p[1])` |

## 递归子与归纳原理 / Recursor and Induction

### 递归子 / Recursor

$$\mathsf{rec}_{A \times B} : \prod_{(C:\mathcal{U})} (A \to B \to C) \to A \times B \to C$$

$$\mathsf{rec}_{A \times B}(C, g, (a,b)) \equiv g(a)(b)$$

投影是递归子的特殊情况：$\mathsf{pr}_1 = \mathsf{rec}_{A \times B}(\_, \lambda a.\lambda b.\, a, \_)$。

### 归纳原理 / Induction Principle

$$\mathsf{ind}_{A \times B} : \prod_{(C : A \times B \to \mathcal{U})} \left(\prod_{(a:A)}\prod_{(b:B)} C((a,b))\right) \to \prod_{(p : A \times B)} C(p)$$

归纳比递归更强：它允许目标类型 $C$ **依赖于**输入 $p$。编程类比：递归子像普通的 `map`，归纳原理像 dependent pattern matching。

## 单元类型 / Unit Type $\mathbf{1}$

$\mathbf{1}$ 是**空积** (nullary product) --- 不含任何分量的 tuple，恰好有一个元素 $\star$。

- **引入**：$\star : \mathbf{1}$
- **归纳**：要证明 $\prod_{(x:\mathbf{1})} C(x)$，只需给出 $C(\star)$ 的元素
- **唯一性**：$\prod_{(x:\mathbf{1})} x =_{\mathbf{1}} \star$

编程类比：Python 的 `None`、TypeScript 的 `null` --- 只有一个值，不携带信息。

## 与 $\Sigma$ 类型的关系 / Relation to $\Sigma$-Types

积类型是 $\Sigma$ 类型的特殊情况。当 $B$ 不依赖于 $x : A$ 时：

$$\sum_{(x:A)} B \;\simeq\; A \times B$$

就像 Python 中 `Tuple[int, str]` 是 `TypedDict` 的特例 --- 后者的字段类型可以依赖于前面的值。

## 相关概念 / Related Concepts

- [[sigma_type]] --- 积类型的依赖推广 (dependent generalization)
- [[coproduct_type]] --- 积类型的对偶 (dual)
- [[pi_type]] --- 函数空间，与积类型的伴随关系

## 参考文献 / References

- HoTT Book, Section 1.5: Product types
