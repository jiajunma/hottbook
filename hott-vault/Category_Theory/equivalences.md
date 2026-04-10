---
type: section
title: 范畴等价 / Equivalences of Categories
chapter: 9
section: 9.4
tags: [category-theory, equivalence, fully-faithful, essentially-surjective]
references:
  - "[[03_adjunctions]]"
next:
  - "[[05_yoneda]]"
---

# 范畴等价 / Equivalences of Categories

## 定义 / Definition

**定义**: 函子 $F : A \to B$ 是 **范畴等价** 若它是左伴随，且 $\eta$ 和 $\epsilon$ 都是同构。

若 $A$ 是范畴，则"F 是等价"是纯命题。

## 完全忠实与本质满 / Fully Faithful and Essentially Surjective

**定义**:
- **忠实 (faithful)**: 每个 $F_{a,b}$ 是单射
- **完全 (full)**: 每个 $F_{a,b}$ 是满射
- **完全忠实 (fully faithful)**: 每个 $F_{a,b}$ 是等价
- **分裂本质满 (split essentially surjective)**: 对每个 $b : B$ 存在 $a : A$ 使 $Fa \cong b$

**引理**: 对预范畴间的函子，以下等价:
1. $F$ 是范畴等价
2. $F$ 完全忠实且分裂本质满

## 核心定理 / Key Theorem

**定理**: 若 $B$ 是范畴（非仅预范畴），则完全忠实且本质满的函子 $F : A \to B$ 是等价，**无需选择公理**。

这是 HoTT 范畴论最引人注目的结果之一。等价的范畴是相等的（作为范畴类型的元素）。

## 参考 / References

- HoTT Book, Section 9.4
