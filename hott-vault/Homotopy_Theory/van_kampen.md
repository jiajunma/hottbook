---
type: section
title: van Kampen 定理 / The van Kampen Theorem
chapter: 8
section: 8.7
tags: [homotopy-theory, van-kampen, fundamental-group, pushout]
references:
  - "[[06_freudenthal]]"
next:
  - "[[08_whitehead]]"
---

# van Kampen 定理 / The van Kampen Theorem

## 概述 / Overview

van Kampen 定理计算推出的基本群 $\pi_1$。经典版本描述两个开子空间并集的基本群；HoTT 版本适用于任意推出。

## 基本广群 / Fundamental Groupoid

对类型 $X$，定义基本预广群:
$$\Pi_1 X(x, y) \defeq \|x = y\|_0$$

带有诱导的广群运算（合成、逆、ap）。

## 编码-解码方法 / Encode-Decode Approach

给定类型 $A, B, C$，函数 $f : A \to B$, $g : A \to C$，推出 $P = B \sqcup^A C$。

定义 $\mathsf{code} : P \to P \to \mathcal{U}$ 由 $P$ 上的双重归纳：
- $\mathsf{code}(\mathsf{inl}(b), \mathsf{inl}(b'))$ 是在 $B$ 和 $C$ 之间"之字形"移动的序列的集合商
- 类似地处理其他组合

## 主要定理 / Main Theorem

**定理 (van Kampen)**: 推出 $P = B \sqcup^A C$ 的基本广群 $\Pi_1(P)$ 是 $\Pi_1(B)$ 和 $\Pi_1(C)$ 沿 $\Pi_1(A)$ 的二元余积（在广群范畴中）。

特别地，取基点后得到 $\pi_1(P)$ 的计算。

## 参考 / References

- HoTT Book, Section 8.7
