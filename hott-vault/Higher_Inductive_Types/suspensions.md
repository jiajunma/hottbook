---
type: definition
title: 悬挂 / Suspensions
chapter: 6
section: 5
tags: [suspension, spheres, loop-space, adjunction]
references:
  - "[[04_circle_sphere]]"
---

# 悬挂 / Suspensions $\Sigma A$

## 定义 / Definition

类型 $A$ 的**悬挂** $\Sigma A$ 由以下生成：
- $\mathsf{N} : \Sigma A$（北极）
- $\mathsf{S} : \Sigma A$（南极）
- $\mathsf{merid} : A \to (\mathsf{N} =_{\Sigma A} \mathsf{S})$（子午线）

## 球面的递归定义 / Recursive Definition of Spheres

$$S^{-1} \equiv \mathbf{0}, \quad S^0 \equiv \mathbf{2}, \quad S^{n+1} \equiv \Sigma S^n$$

**引理 6.5.1.** $\Sigma \mathbf{2} \simeq S^1$。

## 悬挂-循环空间伴随 / Suspension-Loop Space Adjunction

**引理 6.5.4.** 对指向类型 $(A, a_0)$ 和 $(B, b_0)$：

$$\mathsf{Map}_*(\Sigma A, B) \simeq \mathsf{Map}_*(A, \Omega B)$$

特别地，对球面：

$$\mathsf{Map}_*(S^n, B) \simeq \Omega^n B$$

这说明用悬挂定义的球面具有预期的泛性质。

## 参考文献 / References

- HoTT Book, Section 6.5
