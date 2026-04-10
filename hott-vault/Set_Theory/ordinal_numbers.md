---
type: section
title: 序数 / Ordinal Numbers
chapter: 10
section: 10.3
tags: [set-theory, ordinal-numbers, well-founded, accessibility]
references:
  - "[[02_cardinal_numbers]]"
next:
  - "[[04_classical_well_orderings]]"
---

# 序数 / Ordinal Numbers

## 可达性 / Accessibility

**定义**: 集合 $A$ 上的关系 $<$ 下，元素 $a$ 是 **可达的 (accessible)** 归纳定义:
- 若对每个 $b < a$，$b$ 可达，则 $a$ 可达

$\mathsf{acc}(a)$ 是纯命题（由归纳原理证明）。

## 良基关系 / Well-Founded Relations

**定义**: $<$ 是 **良基的 (well-founded)** 若 $A$ 的每个元素可达。

良基归纳: 若从 $\forall b < a. P(b)$ 能推出 $P(a)$，则 $\forall a. P(a)$。

**例子**:
- $\mathbb{N}$ 上的 $<$ 良基（由"强归纳"）
- $W$-类型的"子项"关系良基

## 序数 / Ordinals

**定义**: **序数**是集合 $A$ 加上关系 $<$，满足:
1. $<$ 良基
2. $<$ 传递
3. $<$ 外延: 若 $\forall c. (c < a \Leftrightarrow c < b)$，则 $a = b$

## 序数运算 / Ordinal Arithmetic

**序数比较**: 两个序数之间的映射可以是 **模拟 (simulation)**: 保序且纤维是初始段。

**性质**:
- 序数间的模拟组成偏序
- 良基归纳确保无环
- 最小元存在（良基 + 传递）

## 参考 / References

- HoTT Book, Section 10.3
