---
type: section
title: 严格范畴 / Strict Categories
chapter: 9
section: 9.6
tags: [category-theory, strict-category]
references:
  - "[[05_yoneda]]"
next:
  - "[[07_dagger_categories]]"
---

# 严格范畴 / Strict Categories

## 定义 / Definition

**定义**: **严格范畴**是对象类型为集合的预范畴。

严格范畴不一定是范畴。范畴是严格范畴当且仅当它是 **gaunt** 的（唯一的同构是恒等）。

## 优势 / Advantage

严格范畴有比等价更严格的"相同"概念，即同构（由范畴性质等价于相等）。

## 例子 / Examples

- **单态射范畴**: 给定预范畴 $A$ 和对象 $x$，$\mathsf{mono}(A, x)$ 的对象是 $(y, m)$ 其中 $m : y \to x$ 单态射。若 $A$ 是范畴，则 $\mathsf{mono}(A, x)$ 是严格范畴。

- **Galois 理论**: 有限 Galois 扩张 $E/F$ 的中间域范畴与 Galois 群子群范畴是同构的严格范畴（Galois 基本定理）。

## 参考 / References

- HoTT Book, Section 9.6
