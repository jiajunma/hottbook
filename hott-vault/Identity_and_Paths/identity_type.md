---
type: definition
title: 恒等类型 / Identity Types
chapter: 1
section: 12
tags: [type-theory, identity-type, path, equality]
references:
  - "[[Overview]]"
  - "[[judgment]]"
  - "[[propositions_as_types]]"
---

# 恒等类型 / Identity Types

## 定义 / Definition

给定类型 $A$ 和元素 $a, b : A$，**恒等类型 (identity type)** 为：

$$\mathsf{Id}_A(a, b) \quad \text{或简写为} \quad a =_A b$$

当存在 $p : a =_A b$ 时，我们说 $a$ 和 $b$ 是**(命题) 相等的 (propositionally equal)**。

## Lean 4

```lean
-- Identity type: a = b is a type
#check @Eq       -- Eq : α → α → Prop (in Lean, = is in Prop)
#check @rfl      -- rfl : a = a

-- Path induction (J rule): to prove P for all p : x = y,
-- suffice to prove P for rfl : x = x
example (P : {y : α} → x = y → Prop) (d : P rfl) (p : x = y) : P p :=
  p ▸ d   -- subst
```

## 引入规则 / Introduction: Reflexivity

$$\mathsf{refl}_a : a =_A a$$

对每个 $a : A$，$\mathsf{refl}_a$ 见证 $a$ 与自身相等。

## 消除规则 / Elimination: Path Induction (J Rule)

### 路径归纳 / Path Induction

给定类型族 $C : \prod_{x,y:A} (x =_A y) \to \mathcal{U}$，要定义 $\prod_{x,y:A} \prod_{p : x =_A y} C(x, y, p)$，只需给出**反射性情况**：

$$c : \prod_{x:A} C(x, x, \mathsf{refl}_x)$$

则：

$$\mathsf{ind}_{=_A}(C, c, x, x, \mathsf{refl}_x) \equiv c(x)$$

### 基于点的路径归纳 / Based Path Induction

固定一端 $a : A$，给定 $C : \prod_{y:A} (a =_A y) \to \mathcal{U}$，要定义 $\prod_{y:A} \prod_{p : a =_A y} C(y, p)$，只需给出：

$$c : C(a, \mathsf{refl}_a)$$

> **直觉 / Intuition**: 基于点的路径归纳说——要证明关于从 $a$ 出发的所有路径的性质，只需证明 $\mathsf{refl}_a$ 的情况。这是因为在类型论中，$(a, \mathsf{refl}_a)$ 是类型 $\sum_{y:A}(a =_A y)$ 的"中心"。

## 关键警告 / Critical Warning

> **路径归纳 ≠ "唯一的路径是 refl"**
>
> 路径归纳**不是**说 $a =_A b$ 的唯一元素是 $\mathsf{refl}$。它说的是：要对所有路径证明一个性质，只需在 $\mathsf{refl}$ 上验证。
>
> 在 HoTT 中，恒等类型可以有**非平凡的结构**——这正是同伦论的起点！

## 两种相等 / Two Kinds of Equality

| 定义相等 / Definitional | 命题相等 / Propositional |
|----------------------|----------------------|
| $a \equiv b$ | $p : a =_A b$ |
| 判断层面 (metalevel) | 类型层面 (internal) |
| 由计算/定义决定 | 需要证明 |
| 不能否定或假设 | 是一个类型，可以操作 |
| 类型检查器自动验证 | 需要显式构造证明项 |

定义相等蕴含命题相等（通过 $\mathsf{refl}$），但反过来**不成立**。

## 不可区分性 / Indiscernibility of Identicals

从 $p : a =_A b$ 和类型族 $C : A \to \mathcal{U}$，可以推导出**传输 (transport)**：

$$\mathsf{transport}^C(p, -) : C(a) \to C(b)$$

即：如果 $a =_A b$，则 $a$ 和 $b$ 在所有性质上不可区分。

这由路径归纳直接得出：对 $\mathsf{refl}_a$ 取恒等函数 $\mathsf{id}_{C(a)}$。

## 路径的代数结构 / Algebraic Structure of Paths

通过路径归纳可以证明：

- **对称性 (symmetry)**: $p : a =_A b \;\Rightarrow\; p^{-1} : b =_A a$
- **传递性 (transitivity)**: $p : a =_A b,\; q : b =_A c \;\Rightarrow\; p \cdot q : a =_A c$
- **函数的合同性 (ap)**: $f : A \to B,\; p : a =_A a' \;\Rightarrow\; \mathsf{ap}_f(p) : f(a) =_B f(a')$

> 在 HoTT 中，这些结构赋予恒等类型 **$\infty$-群胚 ($\infty$-groupoid)** 的结构。

## 相关概念 / Related Concepts

- [[judgment|判断]] — 定义相等 vs 命题相等
- [[propositions_as_types|命题即类型]] — 恒等类型 = 等式命题
- [[groupoid_structure|群胚结构]] — 恒等类型的高阶结构

## 参考文献 / References

- HoTT Book, Section 1.12: Identity types
