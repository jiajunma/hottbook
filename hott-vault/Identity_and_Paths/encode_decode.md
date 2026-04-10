---
type: section
title: 一般编码-解码方法 / General Encode-Decode Method
chapter: 8
section: 8.9
tags: [homotopy-theory, encode-decode, loop-space, path-space]
references:
  - "[[08_whitehead]]"
  - "[[01_pi1_circle]]"
next:
  - "[[10_additional]]"
---

# 一般编码-解码方法 / General Encode-Decode Method

## 概述 / Overview

编码-解码方法已用于表征多种类型的路径空间: 余积、自然数、截断、圆、悬挂、推出等。不同问题需要稍有不同的变体。

## 环路空间版本 / For Loop Spaces

**引理**: 给定尖点类型 $(A, a_0)$ 和纤维化 $\mathsf{code} : A \to \mathcal{U}$，若:
1. $c_0 : \mathsf{code}(a_0)$
2. $\mathsf{decode} : \prod_{x:A} \mathsf{code}(x) \to (a_0 = x)$
3. 对所有 $c : \mathsf{code}(a_0)$: $\mathsf{transport}^{\mathsf{code}}(\mathsf{decode}(c), c_0) = c$
4. $\mathsf{decode}(c_0) = \mathsf{refl}$

则 $(a_0 = a_0) \simeq \mathsf{code}(a_0)$。

**编码**定义为: $\mathsf{encode}_x(\alpha) = \mathsf{transport}^{\mathsf{code}}(\alpha, c_0)$

## 截断环路空间版本 / For Truncations of Loop Spaces

**引理**: 给定尖点类型 $(A, a_0)$，纤维化 $\mathsf{code} : A \to \mathcal{U}$（每个 $\mathsf{code}(x)$ 是 $k$-类型），若:
1. $c_0 : \mathsf{code}(a_0)$
2. $\mathsf{decode} : \prod_{x:A} \mathsf{code}(x) \to \|a_0 = x\|_k$
3. $\mathsf{encode}_{a_0}(\mathsf{decode}_{a_0}(c)) = c$ 对所有 $c$
4. $\mathsf{decode}(c_0) = |{\mathsf{refl}}|$

则 $\|a_0 = a_0\|_k \simeq \mathsf{code}(a_0)$。

此版本用于 van Kampen 定理（$k = 0$）。

## 应用列表 / Applications

| 结果 | 类型 |
|---|---|
| $\Omega(A + B)$ | 路径空间表征 |
| $\Omega(\mathbb{N})$ | 路径空间表征 |
| $\Omega(S^1) \simeq \mathbb{Z}$ | 环路空间 |
| Freudenthal | 连通性 |
| van Kampen | 截断环路空间 |
| Blakers-Massey | 连通性 |

## 参考 / References

- HoTT Book, Section 8.9
