---
type: concept
title: 归纳类型的唯一性 / Uniqueness of Inductive Types
chapter: 5
section: 2
tags: [induction, uniqueness, univalence]
references:
  - "[[01_intro_inductive_types]]"
---

# 归纳类型的唯一性 / Uniqueness of Inductive Types

## 核心思想 / Core Idea

如果两个类型 $\mathbb{N}$ 和 $\mathbb{N}'$ 具有相同的归纳定义，则 $\mathbb{N} \simeq \mathbb{N}'$，进而由**单值公理**得 $\mathbb{N} =_\mathsf{Type} \mathbb{N}'$。

If $\mathbb{N}$ and $\mathbb{N}'$ have identical inductive definitions, then $\mathbb{N} \simeq \mathbb{N}'$, and by **univalence** $\mathbb{N} =_\mathsf{Type} \mathbb{N}'$.

## 构造等价 / Constructing the Equivalence

由递归原理得到互逆映射：
- $f \equiv \mathsf{rec}_\mathbb{N}(\mathbb{N}', 0', \mathsf{succ}') : \mathbb{N} \to \mathbb{N}'$
- $g \equiv \mathsf{rec}_{\mathbb{N}'}(\mathbb{N}, 0, \mathsf{succ}) : \mathbb{N}' \to \mathbb{N}$

由唯一性定理（定理 5.1.1），$g \circ f$ 满足与 $\mathsf{id}_\mathbb{N}$ 相同的递推关系，故 $g \circ f = \mathsf{id}_\mathbb{N}$。

## 单值公理的作用 / Role of Univalence

在传统数学中，我们非形式地"识别"同构的结构。**单值公理**使这一做法精确化：

$$\mathbb{N} \simeq \mathbb{N}' \implies \mathbb{N} =_\mathsf{Type} \mathbb{N}'$$

由此，关于 $\mathbb{N}$ 的任何构造或定理可以自动**传递 (transport)** 到 $\mathbb{N}'$。

## 一般结论 / General Conclusion

对于任何归纳类型 $W$：若 $W'$ 满足与 $W$ 相同的归纳原理，则 $W \simeq W'$，从而 $W = W'$。

## 参考文献 / References

- HoTT Book, Section 5.2
