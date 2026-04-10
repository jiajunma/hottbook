---
type: section
title: 伴随 / Adjunctions
chapter: 9
section: 9.3
tags: [category-theory, adjunction, unit, counit]
references:
  - "[[02_functors]]"
next:
  - "[[04_equivalences]]"
---

# 伴随 / Adjunctions

## 定义 / Definition

**定义**: 函子 $F : A \to B$ 是 **左伴随** 若存在:
- 函子 $G : B \to A$
- 单位 $\eta : 1_A \to GF$
- 余单位 $\epsilon : FG \to 1_B$
- 三角恒等式: $(\epsilon F)(F\eta) = 1_F$ 且 $(G\epsilon)(\eta G) = 1_G$

## 命题性 / Propositionality

**引理**: 若 $A$ 是范畴，则 "F 是左伴随" 是纯命题。

**证明**: 给定两组伴随数据 $(G, \eta, \epsilon)$ 和 $(G', \eta', \epsilon')$，构造自然同构 $G \cong G'$。由范畴性质得 $G = G'$，再验证 $\eta, \epsilon$ 沿此相等传输后一致。

## 参考 / References

- HoTT Book, Section 9.3
