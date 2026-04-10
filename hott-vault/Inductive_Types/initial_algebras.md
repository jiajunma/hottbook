---
type: concept
title: 归纳类型是初始代数 / Inductive Types are Initial Algebras
chapter: 5
section: 4
tags: [initial-algebras, homotopy-initial, category-theory]
references:
  - "[[03_w_types]]"
  - "[[05_homotopy_inductive]]"
---

# 归纳类型是初始代数 / Inductive Types are Initial Algebras

## 核心思想 / Core Idea

归纳类型是**同伦初始代数 (homotopy-initial algebras)**：由构造子确定的"代数"范畴中的初始对象（直到相干同伦）。

Inductive types are **homotopy-initial algebras**: initial objects (up to coherent homotopy) in a category of "algebras" determined by the constructors.

## $\mathbb{N}$-代数 / $\mathbb{N}$-Algebras

**定义.** $\mathbb{N}$-代数是一个类型 $C$ 配备 $c_0 : C$ 和 $c_s : C \to C$：

$$\mathsf{NAlg} \equiv \sum_{C:\mathsf{Type}} C \times (C \to C)$$

**定义.** $\mathbb{N}$-同态是保持结构的函数 $h : C \to D$，即 $h(c_0) = d_0$ 且 $h(c_s(c)) = d_s(h(c))$。

**定义.** $\mathbb{N}$-代数 $I$ 是**同伦初始的 (h-initial)**，若对任何 $\mathbb{N}$-代数 $C$，同态类型 $\mathsf{NHom}(I, C)$ 是可缩的。

## 关键定理 / Key Theorems

**定理.** 任意两个同伦初始 $\mathbb{N}$-代数相等。（由单值公理。）

**定理 5.4.2.** $(\mathbb{N}, 0, \mathsf{succ})$ 是同伦初始的。

## 多项式函子 / Polynomial Functors

对于 W-类型，关联的**多项式函子**为：

$$P(X) = \sum_{x:A}(B(x) \to X)$$

**定理 5.4.3.** 对任何 $A$ 和 $B$，W-代数 $(\mathsf{W}_{x:A}B(x), \mathsf{sup})$ 是同伦初始的。

## 参考文献 / References

- HoTT Book, Section 5.4
