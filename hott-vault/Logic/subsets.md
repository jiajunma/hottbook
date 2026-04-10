---
type: definition
title: 子集 / Subsets
chapter: 3
section: 5
tags: [subset, power-set, propositional-resizing, sigma-type]
references:
  - "[[00_Overview]]"
  - "[[03_mere_propositions]]"
  - "[[06_propositional_truncation]]"
---

# 子集 / Subsets

## 定义 / Definition

给定类型 $A$ 和命题值族 $P : A \to \mathcal{U}$（即对所有 $x:A$ 有 $\mathsf{isProp}(P(x))$），**子集 (subset)** 定义为：

$$\{x : A \mid P(x)\} \defeq \sum_{x:A} P(x)$$

When $P$ is prop-valued, the sigma type $\sum_{x:A} P(x)$ behaves like a subset of $A$.

## 为什么 P 必须是命题值 / Why P Must Be Prop-Valued

若 $P(x)$ 不是纯命题，则 $\sum_{x:A} P(x)$ 的元素 $(a, p)$ 和 $(a, q)$ 在 $p \neq q$ 时不相等——这意味着同一个 $a$ 可以"属于子集"多次，这不符合子集的直觉。

当 $P$ 是命题值时，投影 $\mathsf{pr}_1 : \sum_{x:A} P(x) \to A$ 是一个[[../04_Equivalences/05_surjections_embeddings|嵌入 (embedding)]]。

## 幂集 / Power Set

类型 $A$ 的**幂集 (power set)** 是：

$$\mathcal{P}(A) \defeq A \to \mathsf{Prop}$$

其中 $\mathsf{Prop} \defeq \sum_{P:\mathcal{U}} \mathsf{isProp}(P)$ 是所有纯命题的类型。

$A$ 的每个命题值谓词 $P : A \to \mathsf{Prop}$ 对应 $A$ 的一个子集。

## 子集关系 / Subset Relation

对于子集 $P, Q : A \to \mathsf{Prop}$：

$$P \subseteq Q \defeq \prod_{x:A} P(x) \to Q(x)$$

## 命题缩放 / Propositional Resizing

**命题缩放公理 (propositional resizing axiom)** 断言：在更高宇宙 $\mathcal{U}_{i+1}$ 中的纯命题等价于 $\mathcal{U}_i$ 中的纯命题。

这确保幂集不会因为宇宙层级而变得过大。

## 相关概念 / Related Concepts

- [[03_mere_propositions|纯命题]] - 子集要求命题值谓词
- [[../04_Equivalences/05_surjections_embeddings|嵌入]] - 子集的投影是嵌入

## 参考文献 / References

- HoTT Book, Section 3.5: Subsets and propositional resizing
