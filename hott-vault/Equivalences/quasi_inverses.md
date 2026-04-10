---
type: definition
title: 拟逆 / Quasi-Inverses
chapter: 4
section: 1
tags: [quasi-inverse, equivalence, not-a-prop]
references:
  - "[[00_Overview]]"
  - "[[02_half_adjoint_equivalences]]"
  - "[[../03_Sets_and_Logic/03_mere_propositions]]"
---

# 拟逆 / Quasi-Inverses

## 定义 / Definition

函数 $f : A \to B$ 的**拟逆 (quasi-inverse)** 是一个三元组 $(g, \alpha, \beta)$：

$$\mathsf{qinv}(f) \defeq \sum_{g:B \to A} \left((f \circ g \sim \mathsf{id}_B) \times (g \circ f \sim \mathsf{id}_A)\right)$$

其中 $h \sim k$ 表示逐点同伦 $\prod_{x} h(x) = k(x)$。

A quasi-inverse of $f : A \to B$ consists of $g : B \to A$ with homotopies $f \circ g \sim \mathsf{id}$ and $g \circ f \sim \mathsf{id}$.

## 问题：不是纯命题 / Problem: Not a Mere Proposition

> **$\mathsf{qinv}(f)$ 不是纯命题！**

对于等价映射 $f$，$\mathsf{qinv}(f)$ 可以有无穷多个不同的元素。

### 反例 / Counterexample

考虑 $\mathsf{id}_A : A \to A$ 对于 $A \defeq S^1$（圆）。

$\mathsf{qinv}(\mathsf{id}_{S^1})$ 的元素形如 $(\mathsf{id}_{S^1}, \alpha, \beta)$，其中 $\alpha, \beta : \mathsf{id}_{S^1} \sim \mathsf{id}_{S^1}$。

逐点同伦 $\mathsf{id}_{S^1} \sim \mathsf{id}_{S^1}$ 等价于 $\prod_{x:S^1}(x = x)$，而 $S^1$ 上的自环路由 $\pi_1(S^1) \cong \mathbb{Z}$ 分类。因此 $\mathsf{qinv}(\mathsf{id}_{S^1})$ 包含 $\mathbb{Z} \times \mathbb{Z}$ 的信息——远非纯命题。

## 为什么这是问题 / Why This Matters

若使用 $\mathsf{qinv}$ 定义等价，则类型 $\eqv{A}{B} \defeq \sum_{f:A \to B}\mathsf{qinv}(f)$ 不是集合（即使 $A$ 和 $B$ 是集合）。与 univalence 结合时，$(A =_\mathcal{U} B) \simeq \eqv{A}{B}$ 会使恒等类型变得过大。

我们需要的是一个**纯命题**版本的"$f$ 是等价"。

## 解决方案 / Solutions

- [[02_half_adjoint_equivalences|半伴随等价 $\mathsf{ishae}(f)$]] - 加一致性条件
- [[03_bi_invertible_maps|双可逆 $\mathsf{biinv}(f)$]] - 分开要求左逆和右逆
- [[04_contractible_fibers|可缩纤维]] - Voevodsky 的定义

## 相关概念 / Related Concepts

- [[02_half_adjoint_equivalences|半伴随等价]] - 修复后的定义
- [[../03_Sets_and_Logic/03_mere_propositions|纯命题]] - 等价定义应满足的性质

## 参考文献 / References

- HoTT Book, Section 4.1: Quasi-inverses
