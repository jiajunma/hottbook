---
type: section
title: Hopf 纤维化 / The Hopf Fibration
chapter: 8
section: 8.5
tags: [homotopy-theory, hopf-fibration, h-space, spheres]
references:
  - "[[04_fiber_sequences]]"
next:
  - "[[06_freudenthal]]"
---

# Hopf 纤维化 / The Hopf Fibration

## 主要定理 / Main Theorem

**定理 (Hopf 纤维化)**: 存在 $S^2$ 上的纤维化，纤维为 $S^1$，总空间为 $S^3$:

$$S^1 \to S^3 \to S^2$$

## H-空间 / H-Spaces

**定义**: H-空间由以下组成:
- 类型 $A$，基点 $e : A$
- 二元运算 $\mu : A \times A \to A$
- 对每个 $a : A$: $\mu(e, a) = a$ 且 $\mu(a, e) = a$

**引理**: 连通 H-空间上，$\mu(a, -)$ 和 $\mu(-, a)$ 都是等价。

## Hopf 构造 / Hopf Construction

**引理**: 给定连通 H-空间 $A$，存在 $\Sigma A$ 上的纤维化（Hopf 构造），纤维为 $A$，总空间为 $A * A$（连接）。

构造方法: 利用推出上的纤维化引理，以 $\mu(a, -)$ 作为等价族。

## 圆的 H-空间结构 / H-Space Structure on $S^1$

$S^1$ 有 H-空间结构: 乘法 $\mu$ 由圆的递归定义，利用 $S^1$ 上的自同伦 $h$ (满足 $h(\mathsf{base}) = \mathsf{loop}$)。

## 证明 $S^1 * S^1 \simeq S^3$

$$S^1 * S^1 = (\Sigma \mathbf{2}) * S^1 = (\mathbf{2} * \mathbf{2}) * S^1 = \mathbf{2} * (\mathbf{2} * S^1) = \Sigma(\Sigma S^1) = S^3$$

## 同伦群的推论 / Consequences for Homotopy Groups

由 Hopf 纤维化的长正合列:

$$\pi_k(S^1) \to \pi_k(S^3) \to \pi_k(S^2) \to \pi_{k-1}(S^1)$$

结合 $\pi_n(S^1)$ 和 $\pi_{k<n}(S^n)$ 的计算:

**推论**:
- $\pi_2(S^2) \cong \mathbb{Z}$
- $\pi_k(S^3) \cong \pi_k(S^2)$ 对 $k \ge 3$

## 参考 / References

- HoTT Book, Section 8.5
