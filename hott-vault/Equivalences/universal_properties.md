---
type: theorem
title: "Universal Properties / 泛性质"
chapter: 2
section: 15
tags: [universal-property, product, sigma-type, axiom-of-choice, pullback]
references:
  - "[[00_equality_of_structures]]"
  - "[[../04_Transport_in_Type_Formers/01_product]]"
  - "[[../04_Transport_in_Type_Formers/02_sigma]]"
  - "[[../04_Transport_in_Type_Formers/04_pi]]"
---

# Universal Properties / 泛性质

## 概述 / Overview

通过组合前述各节的路径计算规则，可以证明各种类型构造满足预期的泛性质（以同伦意义下的等价来表述）。

---

## 积类型的泛性质 / Universal Property of Products

### Theorem 2.15.2

对于类型 $X, A, B$，以下函数是等价：

$$(X \to A \times B) \xrightarrow{\;\sim\;} (X \to A) \times (X \to B)$$

由 $f \mapsto (\mathsf{pr}_1 \circ f, \mathsf{pr}_2 \circ f)$ 定义。

**拟逆**: $(g, h) \mapsto (\lambda x.\, (g(x), h(x)))$。

### 依赖版本 / Dependent Version (Theorem 2.15.4)

$$\left(\prod_{x:X} (A(x) \times B(x))\right) \simeq \left(\prod_{x:X} A(x)\right) \times \left(\prod_{x:X} B(x)\right)$$

---

## Σ-类型的泛性质 / Universal Property of Σ-types

### Theorem 2.15.7

$$\left(\prod_{x:X} \sum_{a:A(x)} P(x, a)\right) \simeq \sum_{g : \prod_{x:X} A(x)} \prod_{x:X} P(x, g(x))$$

---

## 类型论的选择公理 / Type-Theoretic Axiom of Choice

Theorem 2.15.7 在命题即类型的解读下就是**选择公理**：

- 左边: "对所有 $x : X$，存在 $a : A(x)$ 使得 $P(x, a)$"
- 右边: "存在选择函数 $g : \prod_{x:X} A(x)$，使得对所有 $x$，$P(x, g(x))$"

不仅选择公理"成立"，而且其前件实际上**等价于**其结论。

> Not only is the axiom of choice "true", its antecedent is actually equivalent to its conclusion.

（经典数学家可能会认为这不是选择公理的通常意义，因为 $g$ 的值已经被指定，没有剩余的"选择"。）

---

## "映出"泛性质 / "Mapping Out" Universal Properties

积类型也有"映出"泛性质，表达笛卡尔闭邻接：

$$((A \times B) \to C) \simeq (A \to (B \to C))$$

依赖版本：

$$\left(\prod_{w : A \times B} C(w)\right) \simeq \left(\prod_{x:A} \prod_{y:B} C(x, y)\right)$$

右到左的函数就是 $A \times B$ 的归纳原理。

对于 Σ-类型：

$$\left(\prod_{w : \sum_{x:A} B(x)} C(w)\right) \simeq \left(\prod_{x:A} \prod_{y:B(x)} C(x, y)\right)$$

---

## 路径归纳的泛性质 / Universal Property of Path Induction

路径归纳是以下等价的右到左方向：

$$\left(\prod_{x:A} \prod_{p : a = x} B(x, p)\right) \simeq B(a, \mathsf{refl}_a)$$

对于 $a : A$ 和类型族 $B : \prod_{x:A} (a = x) \to \mathcal{U}$。

---

## 回拉 / Pullbacks

给定 $f : A \to C$ 和 $g : B \to C$，定义：

$$A \times_C B \defeq \sum_{a:A} \sum_{b:B} (f(a) = g(b))$$

这满足回拉的泛性质。

---

## 相关概念 / Related Concepts

- [[../04_Transport_in_Type_Formers/01_product|Product Types / 积类型]]
- [[../04_Transport_in_Type_Formers/02_sigma|Σ-types / Σ-类型]]
- [[../04_Transport_in_Type_Formers/04_pi|Π-types / Π-类型]]
- [[00_equality_of_structures|Equality of Structures / 结构的等式]]

---

## 参考文献 / References

- HoTT Book, Section 2.15: Universal properties
