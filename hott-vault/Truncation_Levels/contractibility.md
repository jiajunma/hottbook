---
type: definition
title: 可缩性 / Contractibility
chapter: 3
section: 11
tags: [contractible, (-2)-type, center-of-contraction, free-path-space]
references:
  - "[[00_Overview]]"
  - "[[03_mere_propositions]]"
  - "[[01_sets_and_n_types]]"
  - "[[../04_Equivalences/04_contractible_fibers]]"
---

# 可缩性 / Contractibility

## 定义 / Definition

类型 $A$ 是**可缩的 (contractible)** 如果它有一个**收缩中心 (center of contraction)**，且所有元素都等于该中心：

$$\mathsf{isContr}(A) \defeq \sum_{a:A}\prod_{x:A}(a = x)$$

可缩类型也称为 **(-2)-类型 ((-2)-type)**。

A type $A$ is **contractible** if it has a center of contraction to which every element is equal. Also called a (-2)-type.

## 直觉 / Intuition

可缩类型在同伦论中对应于可缩空间——可以连续收缩到一个点的空间。在类型论中，可缩类型"本质上只有一个元素"。

## 等价刻画 / Equivalent Characterizations

以下条件等价：

1. $\mathsf{isContr}(A)$
2. $\mathsf{isProp}(A)$ 且 $A$ 被居住（$\mathsf{isProp}(A) \times A$）
3. $A \simeq \mathbf{1}$

### 证明关系 / Proof Relations

- $(1) \Rightarrow (2)$: 若 $\mathsf{isContr}(A)$ 有中心 $a$，则 $a$ 居住 $A$；且对任意 $x, y : A$，$x = a = y$，故 $\mathsf{isProp}(A)$。
- $(2) \Rightarrow (1)$: 若 $a : A$ 且 $\mathsf{isProp}(A)$，则 $(a, \lambda x.\mathsf{isProp}(A)(a,x))$ 是收缩数据。
- $(1) \Leftrightarrow (3)$: $A$ 可缩当且仅当唯一映射 $A \to \mathbf{1}$ 是等价。

## 自由路径空间 / Free Path Space

对于 $a : A$，**自由路径空间 (free path space)** 或**基于 $a$ 的路径空间**定义为：

$$\sum_{y:A}(a = y)$$

> **关键事实**: 自由路径空间是可缩的。

收缩中心为 $(a, \mathsf{refl}_a)$。对任意 $(y, p)$（其中 $p : a = y$），由路径归纳可得 $(a, \mathsf{refl}_a) = (y, p)$。

这是[[../04_Equivalences/04_contractible_fibers|可缩纤维]]等价定义的基础。

## 层级关系 / Hierarchy

$$\underbrace{\mathsf{isContr}}_{(-2)\text{-type}} \implies \underbrace{\mathsf{isProp}}_{(-1)\text{-type}} \implies \underbrace{\mathsf{isSet}}_{0\text{-type}} \implies \cdots$$

可缩类型是最"平凡"的类型：没有任何有趣的同伦信息。

## 例子 / Examples

| 类型 / Type | 可缩？ | 理由 / Reason |
|---|---|---|
| $\mathbf{1}$ | 是 | 只有 $\star$，且 $\mathsf{refl}_\star : \star = \star$ |
| $\sum_{y:A}(a = y)$ | 是 | 自由路径空间 |
| $\mathbf{0}$ | 否 | 没有元素（不被居住） |
| $\mathbb{N}$ | 否 | 有多个不同元素 |
| $\mathsf{Bool}$ | 否 | 有两个不同元素 |

## isContr 是纯命题 / isContr is a mere proposition

$$\mathsf{isProp}(\mathsf{isContr}(A))$$

## 相关概念 / Related Concepts

- [[03_mere_propositions|纯命题]] - (-1)-type，可缩类型的推广
- [[01_sets_and_n_types|集合]] - 0-type
- [[../04_Equivalences/04_contractible_fibers|可缩纤维]] - 等价的 Voevodsky 定义

## 参考文献 / References

- HoTT Book, Section 3.11: Contractibility
