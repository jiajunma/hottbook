---
type: section
title: Whitehead 定理与原则 / Whitehead's Theorem and Principle
chapter: 8
section: 8.8
tags: [homotopy-theory, whitehead, n-types, classicality]
references:
  - "[[07_van_kampen]]"
next:
  - "[[09_encode_decode]]"
---

# Whitehead 定理与原则 / Whitehead's Theorem and Principle

## 经典 Whitehead 定理 / Classical Whitehead's Theorem

经典同伦论: 若 $f : A \to B$ 诱导所有同伦群的同构 $\pi_n(A, a) \cong \pi_n(B, f(a))$，且 $A, B$ 是 CW-复形，则 $f$ 是同伦等价。

## HoTT 中的情况 / Status in HoTT

**Whitehead 定理在 HoTT 中不可证明。** 存在反模型（非超完备 $(\infty,1)$-topos）使其失败。

因此 **Whitehead 原则** 是一个"经典性公理"，类似于排中律和选择公理。

## 截断情况 / Truncated Case

对 $n$-截断类型，Whitehead 定理成立:

**定理**: 若 $f : A \to B$ 满足:
1. $\|f\|_0 : \|A\|_0 \to \|B\|_0$ 是双射
2. 对任意 $x : A$，$\Omega f : \Omega(A, x) \to \Omega(B, f(x))$ 是等价

则 $f$ 是等价。

**定理 (截断 Whitehead)**: 若 $A, B$ 是 $n$-截断的，$f : A \to B$ 诱导所有 $\pi_k$ 上的等价（$k \le n$），则 $f$ 是等价。

**证明**: 对 $n$ 做"向下"归纳，利用长正合列。

## 应用 / Applications

- Eilenberg-Mac Lane 空间的本质唯一性
- $n$-连通映射的同伦群刻画

## 参考 / References

- HoTT Book, Section 8.8
