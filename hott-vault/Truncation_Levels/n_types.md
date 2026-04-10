---
type: definition
title: n-类型的定义 / Definition of n-types
chapter: 7
section: 1
tags: [n-types, h-levels, cumulative, closure]
references:
  - "[[00_Overview]]"
  - "[[../../03_Sets_and_Logic/00_Overview]]"
---

# $n$-类型的定义 / Definition of $n$-types

## 递归定义 / Recursive Definition

$$\mathsf{is\text{-}n\text{-}type}(X) \equiv \begin{cases} \mathsf{isContr}(X) & n = -2 \\ \prod_{x,y:X} \mathsf{is\text{-}n'\text{-}type}(x =_X y) & n = n'+1 \end{cases}$$

- $(-2)$-类型 = 可缩类型
- $(-1)$-类型 = 纯命题
- $0$-类型 = 集合

## 保持性 / Closure Properties

**定理 7.1.4.** $n$-类型在收缩 (retract) 下保持。

**定理 7.1.7.** $n$-类型层级是累积的：$n$-类型也是 $(n+1)$-类型。

**定理 7.1.8.** $n$-类型在 $\Sigma$-类型下保持。

**定理 7.1.9.** $n$-类型在 $\Pi$-类型下保持。

**定理 7.1.11.** $n$-类型的宇宙 $n\text{-}\mathsf{Type}$ 是 $(n+1)$-类型。

## 循环空间刻画 / Loop Space Characterization

**定理 7.2.9.** 对任何 $n \ge -1$，$A$ 是 $n$-类型当且仅当 $\Omega^{n+1}(A, a)$ 对所有 $a : A$ 可缩。

这推广了 Axiom K（集合情形）。

## 参考文献 / References

- HoTT Book, Section 7.1
