---
type: definition
title: 集合与 n-类型 / Sets and n-Types
chapter: 3
section: 1
tags: [set, n-type, 0-type, 1-type, truncation-level]
references:
  - "[[00_Overview]]"
  - "[[03_mere_propositions]]"
  - "[[../02_HoTT_Basics/01_Identity_Types/00_identity_type]]"
---

# 集合与 n-类型 / Sets and n-Types

## 定义：集合 / Definition: Set

类型 $A$ 是一个**集合 (set)** 当且仅当对于所有平行路径都相等：

$$\mathsf{isSet}(A) \defeq \prod_{x,y:A}\prod_{p,q:x=y}(p=q)$$

即：$A$ 的恒等类型都是纯命题。集合也称为 **0-类型 (0-type)**。

A type $A$ is a **set** if all parallel paths are equal. Sets are also called **0-types**.

## 直觉 / Intuition

在集合中，两个元素之间最多有一条路径（且无高维路径）。这意味着"相等即命题"——不需要关心*如何*证明相等，只需知道*是否*相等。

In a set, there is at most one path between any two points. Equality is a mere proposition.

## 例子 / Examples

### 是集合的类型 / Types that are sets

| 类型 / Type | 理由 / Reason |
|---|---|
| $\mathbb{N}$ | 自然数的相等是可判定的命题 |
| $\mathbf{1}$ | 单元类型，只有一个元素 |
| $\mathbf{0}$ | 空类型，平凡地满足 |
| $\mathbf{2}$ | Bool 类型 |
| $A \times B$ | 若 $A$, $B$ 都是集合 |
| $A \to B$ | 若 $B$ 是集合（由函数外延性） |

### 不是集合的类型 / Types that are NOT sets

| 类型 / Type | 理由 / Reason |
|---|---|
| $\mathcal{U}$ | 宇宙不是集合——由 univalence，$\mathsf{Bool} = \mathsf{Bool}$ 有非平凡自等价 |
| $S^1$ | 圆有非平凡环路 $\mathsf{loop} : \mathsf{base} = \mathsf{base}$ |

## 1-类型 / 1-Types

类型 $A$ 是 **1-类型 (1-type)** 当且仅当其恒等类型都是集合：

$$\mathsf{is\text{-}1\text{-}type}(A) \defeq \prod_{x,y:A} \mathsf{isSet}(x =_A y)$$

每个集合都是 1-类型。$\mathcal{U}$ 不是集合，但它是 1-类型（在 univalence 下）。

## n-类型的层级 / Hierarchy of n-types

$$\mathsf{isContr}(A) \implies \mathsf{isProp}(A) \implies \mathsf{isSet}(A) \implies \mathsf{is\text{-}1\text{-}type}(A) \implies \cdots$$

每个 $n$-类型也是 $(n+1)$-类型。这个层级永不坍缩。

## 关键定理 / Key Theorem

> **Hedberg 定理**: 若 $A$ 具有可判定相等性（$\prod_{x,y:A}(x=y) + \neg(x=y)$），则 $A$ 是集合。

## 相关概念 / Related Concepts

- [[03_mere_propositions|纯命题]] - (-1)-type
- [[09_contractibility|可缩性]] - (-2)-type
- [[../07_HLevels/01_N_Types/00_hlevel_definition|n-类型的一般定义]]

## 参考文献 / References

- HoTT Book, Section 3.1: Sets and n-types
