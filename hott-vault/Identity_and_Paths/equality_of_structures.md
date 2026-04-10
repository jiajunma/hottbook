---
type: example
title: "Equality of Structures / 结构的等式"
chapter: 2
section: 14
tags: [univalence, semigroup, algebraic-structure, isomorphism, transport]
references:
  - "[[../04_Axioms/02_univalence]]"
  - "[[../04_Transport_in_Type_Formers/02_sigma]]"
  - "[[../04_Transport_in_Type_Formers/04_pi]]"
---

# Equality of Structures / 结构的等式

## 概述 / Overview

本节通过**半群** (semigroup) 的例子，展示一致性公理如何使类型构造子的群胚结构与数学实践统一：**等价的结构自动可被等同**。

---

## 半群的定义 / Definition of Semigroup

$$\mathsf{SemigroupStr}(A) \defeq \sum_{m : A \to A \to A} \prod_{x, y, z : A} m(x, m(y, z)) = m(m(x, y), z)$$

$$\mathsf{Semigroup} \defeq \sum_{A : \mathcal{U}} \mathsf{SemigroupStr}(A)$$

---

## 提升等价 / Lifting Equivalences

给定类型间的等价 $e : A \simeq B$，一致性自动给出半群结构间的等价：

$$\mathsf{transport}^{\mathsf{SemigroupStr}}(\mathsf{ua}(e)) : \mathsf{SemigroupStr}(A) \to \mathsf{SemigroupStr}(B)$$

这是等价（因为沿路径的传输总是等价）。

### 导出的乘法 / Induced Multiplication

给定 $(m, a)$ 是 $A$ 上的半群结构，导出的 $B$ 上的乘法 $m'$ 满足：

$$m'(b_1, b_2) = e(m(e^{-1}(b_1), e^{-1}(b_2)))$$

即：将 $B$ 的元素通过 $e^{-1}$ 送回 $A$，在 $A$ 中相乘，再通过 $e$ 送回 $B$——正如人们所期望的。

---

## 半群的等式 / Equality of Semigroups

给定半群 $(A, m, a)$ 和 $(B, m', a')$，由 [[../04_Transport_in_Type_Formers/02_sigma|Theorem 2.7.2]] (Σ-类型的路径)，路径类型

$$(A, m, a) =_{\mathsf{Semigroup}} (B, m', a')$$

等价于一对：
1. $p_1 : A =_\mathcal{U} B$（由一致性，即一个等价 $e : A \simeq B$）
2. 传输后的结构相等的证明

经过展开，第二个条件的核心变为：

$$\prod_{x_1, x_2 : A} e(m(x_1, x_2)) = m'(e(x_1), e(x_2))$$

即 $e$ **保持乘法运算** (preserves the binary operation)。

---

## 结论 / Conclusion

**半群之间的等式精确地就是半群同构。**

对于集合上的半群（associativity 证明自动相等），等价变为双射 (bijection)，恢复标准代数定义：载体集之间的保持乘法的双射。

> Thanks to univalence, semigroups are equal precisely when they are isomorphic as algebraic structures.

同样的想法适用于所有代数结构（幺半群、群、环等）。更一般地：**在同伦类型论中，所有数学构造自动尊重同构，无需繁琐的证明或符号滥用。**

---

## 相关概念 / Related Concepts

- [[../04_Axioms/02_univalence|Univalence Axiom / 一致性公理]]
- [[../04_Transport_in_Type_Formers/02_sigma|Σ-types / Σ-类型]]
- [[01_universal_properties|Universal Properties / 泛性质]]

---

## 参考文献 / References

- HoTT Book, Section 2.14: Example: equality of structures
- HoTT Book, Section 9.8: The structure identity principle
