---
type: section
title: 经典良序 / Classical Well-Orderings
chapter: 10
section: 10.4
tags: [set-theory, well-ordering, excluded-middle, choice]
references:
  - "[[03_ordinal_numbers]]"
next:
  - "[[05_cumulative_hierarchy]]"
---

# 经典良序 / Classical Well-Orderings

## 三分性 / Trichotomy

**引理** (假设排中律): 每个序数满足三分性:
$$\forall a, b : A. \; (a < b) \lor (a = b) \lor (b < a)$$

## 经典等价刻画 / Classical Characterization

**定理** (假设排中律): $(A, <)$ 是序数当且仅当每个非空子集 $B \subseteq A$ 有最小元。

经典数学中后者作为良序的定义。在 HoTT 中，结构恒等原则意味着不需要寻找良序的典范代表。

## 与选择公理的关系 / Relation to Axiom of Choice

**定理** (假设排中律): 以下等价:
1. 对每个集合 $X$，仅存在选择函数 $f : \mathcal{P}^+(X) \to X$（满足 $f(Y) \in Y$）
2. 每个集合仅具有序数结构

这是选择公理的标准经典版本之一。

## 参考 / References

- HoTT Book, Section 10.4
