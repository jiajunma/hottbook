---
type: section
title: 超实数 / The Surreal Numbers
chapter: 11
section: 11.6
tags: [real-numbers, surreal-numbers, conway, HIT, higher-inductive-inductive]
references:
  - "[[05_compactness]]"
  - "[[../10_Set_Theory/03_ordinal_numbers]]"
---

# 超实数 / The Surreal Numbers

## 概述 / Overview

Conway 的超实数域 $\mathsf{No}$ 是 Dedekind 实数和序数的共同自然推广。在 HoTT 中用高阶归纳-归纳类型构造。

## 定义 / Definition

$\mathsf{No}$ 与关系 $<$ 和 $\le$ 同时归纳-归纳定义:

**$\mathsf{No}$ 的构造器**:
1. **分割**: 对 $\mathcal{U}$-小类型 $\mathbb{L}, \mathbb{R}$ 和函数 $\mathbb{L} \to \mathsf{No}$, $\mathbb{R} \to \mathsf{No}$（值记为 $x^L, x^R$），若 $\forall L, R. x^L < x^R$，则有超实数 $x$
2. **路径**: 若 $x \le y$ 且 $y \le x$，则 $x = y$

**$\le$ 的构造器**: 给定分割定义的 $x, y$，若 $\forall L. x^L < y$ 且 $\forall R. x < y^R$，则 $x \le y$。截断为纯命题。

**$<$ 的构造器**: 给定分割定义的 $x, y$，若存在 $L$ 使 $x \le y^L$，或存在 $R$ 使 $x^R \le y$，则 $x < y$。截断为纯命题。

## 例子 / Examples

$$0 = \{\ |\ \}, \quad 1 = \{0\ |\ \}, \quad -1 = \{\ |\ 0\}$$
$$n+1 = \{n\ |\ \}, \quad \omega = \{0, 1, 2, \ldots\ |\ \}$$
$$1/2 = \{0\ |\ 1\}, \quad 1/3 = \{1/4\ |\ 1/2\}$$

## 与 Conway 定义的对比 / Comparison with Conway

Conway 的等式 "$x = y$ iff $x \ge y$ and $y \ge x$" 对应路径构造器。Conway 的 $<$ 是 $\ge$ 的否定; HoTT 中我们对 $<$ 和 $\le$ 分别归纳定义（避免否定式定义，且在构造性设定中更好）。

## 优势 / Advantages in HoTT

HoTT 的高阶归纳-归纳定义比经典集合论构造更自然:
- 无需选择公理处理提升问题
- 商和构造同时完成
- 结构恒等原则自动成立

## 参考 / References

- HoTT Book, Section 11.6
- Conway, *On Numbers and Games*
