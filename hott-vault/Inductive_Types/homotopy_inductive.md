---
type: concept
title: 同伦归纳类型 / Homotopy-Inductive Types
chapter: 5
section: 5
tags: [homotopy-inductive, propositional-computation]
references:
  - "[[04_initial_algebras]]"
---

# 同伦归纳类型 / Homotopy-Inductive Types

## 动机 / Motivation

将自然数编码为 W-类型时，归纳原理只能给出**命题地**（而非判断地）满足递推的函数。这促使我们考虑**同伦归纳类型**：所有计算规则用 $=$ 代替 $\equiv$。

When encoding $\mathbb{N}$ as a W-type, the induction principle only yields functions satisfying recurrences **propositionally** (up to a path). This motivates **homotopy-inductive types** where computation rules use $=$ instead of $\equiv$.

## 三种等价刻画 / Three Equivalent Characterizations

对于 W-类型 $\mathsf{W}_{x:A}B(x)$，以下三种类型等价：

1. **$\mathsf{W}_d(A,B)$** — 依赖消除（归纳原理 + 命题计算规则）
2. **$\mathsf{W}_s(A,B)$** — 简单消除 + 唯一性 + 相干性
3. **$\mathsf{W}_h(A,B)$** — 同伦初始代数

$$\mathsf{W}_d(A,B) \simeq \mathsf{W}_s(A,B) \simeq \mathsf{W}_h(A,B)$$

每个都是纯命题。

## 核心定理 / Key Theorem

满足 W-类型构成规则、引入规则、消除规则和**命题计算规则**的类型，恰好是同伦初始 W-代数。

The types satisfying formation, introduction, elimination, and **propositional** computation rules for W-types are precisely the homotopy-initial W-algebras.

## 参考文献 / References

- HoTT Book, Section 5.5
