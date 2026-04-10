---
type: definition
title: 布尔类型 / The Boolean Type
chapter: 1
section: 8
tags: [type-theory, type-former, boolean]
references:
  - "[[00_Overview]]"
  - "[[coproduct_type]]"
  - "[[sigma_type]]"
  - "[[pi_type]]"
---

# 布尔类型 / The Boolean Type (HoTT Book \S 1.8)

## 定义 / Definition

**布尔类型** $\mathbf{2}$ 恰好有两个元素 --- 这是最简单的非平凡类型：

$$0_{\mathbf{2}} : \mathbf{2} \qquad 1_{\mathbf{2}} : \mathbf{2}$$

编程类比很直接：就是 `bool`，有 `True` 和 `False` 两个值。But in HoTT, its role is subtly different from what you might expect.

## Lean 4

```lean
-- 自己定义 Bool（避免与标准库 Bool 冲突）
inductive MyBool where
  | myFalse : MyBool
  | myTrue  : MyBool

-- 递归子 = if-then-else
def myIte (b : MyBool) (t f : α) : α :=
  match b with
  | .myTrue  => t
  | .myFalse => f

#eval myIte true "yes" "no"   -- "yes"
```

## 消除规则 / Elimination (If-Then-Else)

### 递归子 / Recursor

$$\mathsf{rec}_{\mathbf{2}} : \prod_{(C:\mathcal{U})} C \to C \to \mathbf{2} \to C$$

$$\mathsf{rec}_{\mathbf{2}}(C, c_0, c_1, 0_{\mathbf{2}}) \equiv c_0$$
$$\mathsf{rec}_{\mathbf{2}}(C, c_0, c_1, 1_{\mathbf{2}}) \equiv c_1$$

这就是 **if-then-else** 的类型论版本。

### 归纳原理 / Induction

$$\mathsf{ind}_{\mathbf{2}} : \prod_{(C:\mathbf{2} \to \mathcal{U})} C(0_{\mathbf{2}}) \to C(1_{\mathbf{2}}) \to \prod_{(x:\mathbf{2})} C(x)$$

归纳比递归更强：目标类型 $C$ 可以**依赖于**布尔值。这意味着 $C(0_{\mathbf{2}})$ 和 $C(1_{\mathbf{2}})$ 可以是不同的类型。

## 编程视角 / Programming Perspective

```python
# Bool recursor = if-then-else / 布尔递归子 = 条件表达式
def bool_rec(c_true, c_false, b: bool):
    """rec_𝟐(C, c₀, c₁, b) --- 根据 b 选择返回值"""
    if b:
        return c_true   # b = 1₂ → c₁
    else:
        return c_false  # b = 0₂ → c₀

# 这就是你每天写的 if-else！类型论只是把它形式化了。
# This is just the if-else you write every day, formalized.

x = bool_rec("yes", "no", True)   # → "yes"
y = bool_rec("yes", "no", False)  # → "no"
```

```typescript
// TypeScript: generic if-then-else
function boolRec<C>(cFalse: C, cTrue: C, b: boolean): C {
    return b ? cTrue : cFalse;
}

// 归纳原理的编程意义：返回类型可以依赖于输入
// The induction principle: return type depends on input
function boolInd(b: boolean): b extends true ? string : number {
    // TypeScript's conditional types capture this idea!
    return (b ? "hello" : 42) as any;
}
```

## 通过布尔编码其他类型 / Encoding Other Types via Bool

这是 $\mathbf{2}$ 最有趣的性质：它可以当做"类型级别的开关"。

### 余积通过 $\Sigma$ + 布尔 / Coproduct via $\Sigma$ + Bool

$$A + B \;\simeq\; \sum_{(x:\mathbf{2})} \mathsf{rec}_{\mathbf{2}}(\mathcal{U}, A, B, x)$$

直觉：一个 $A + B$ 的元素就是**一个标签 + 一个值**，其中值的类型由标签决定。

```python
# "tagged value = tag + value whose type depends on the tag"
# 标记值 = 标签 + 类型取决于标签的值
from typing import Union

Tagged = tuple[bool, Union[int, str]]
# (True, 42)   means "right side, value 42"   ~ inr(42)
# (False, "hi") means "left side, value 'hi'" ~ inl("hi")

# rec_𝟐(𝒰, A, B, x) 就是说：
# x = False → 类型 A; x = True → 类型 B
```

### 积通过 $\Pi$ + 布尔 / Product via $\Pi$ + Bool

$$A \times B \;\simeq\; \prod_{(x:\mathbf{2})} \mathsf{rec}_{\mathbf{2}}(\mathcal{U}, A, B, x)$$

直觉：一个 $A \times B$ 的元素是一个函数，给 $0_\mathbf{2}$ 返回 $A$ 的元素，给 $1_\mathbf{2}$ 返回 $B$ 的元素。

```typescript
// A function from bool that returns different types
// 相当于一个长度为 2 的"异构数组"
function pair(b: boolean): b extends false ? string : number {
    return (b ? 42 : "hello") as any;
}
// pair(false) = "hello" : string   ~ pr₁
// pair(true)  = 42 : number        ~ pr₂
```

## 布尔 $\neq$ 真值 / Booleans Are NOT Truth Values

> **关键警告 / Critical Warning**: 在 HoTT 中，布尔类型 $\mathbf{2}$ **不是**命题的真值类型！

这是从编程转向类型论最容易犯的错误。In programming, `bool` is how you express truth. In HoTT, truth is expressed differently:

| 概念 Concept | 编程 Programming | HoTT |
|-------------|-----------------|------|
| 真值 Truth values | `bool` | $\mathsf{hProp}$ (有零或一个元素的类型) |
| "P 为真" | `p == True` | $P$ 有 inhabitant (类型非空) |
| "P 为假" | `p == False` | $P \to \mathbf{0}$ (类型为空) |
| 布尔的角色 | 表示真假 | **纯数据类型**，用于 if-else |

为什么？因为命题对应**类型**，而非布尔值。例如"$3 + 5 = 8$"这个命题对应一个类型，它的证明 ($\mathsf{refl}$) 是该类型的元素。你不需要一个布尔值来说"这是真的" --- 有证明就是真的。

$\mathbf{2}$ 有两个**不同的** inhabitants ($0_\mathbf{2} \neq 1_\mathbf{2}$)，所以它本身不是一个命题 (proposition)，而是一个普通的数据类型。

## 与 $\mathbf{1} + \mathbf{1}$ 的等价 / Equivalence with $\mathbf{1} + \mathbf{1}$

$$\mathbf{2} \;\simeq\; \mathbf{1} + \mathbf{1}$$

两个元素分别对应 $\mathsf{inl}(\star)$ 和 $\mathsf{inr}(\star)$。这验证了"布尔 = 两个选择"的直觉。

## 相关概念 / Related Concepts

- [[coproduct_type]] --- $\mathbf{2} \simeq \mathbf{1} + \mathbf{1}$
- [[sigma_type]] --- 通过 $\mathbf{2}$ 编码余积
- [[pi_type]] --- 通过 $\mathbf{2}$ 编码积
- [[propositions_as_types]] --- 真值 vs 布尔

## 参考文献 / References

- HoTT Book, Section 1.8: The type of booleans
