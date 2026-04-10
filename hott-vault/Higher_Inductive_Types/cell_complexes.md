---
type: concept
title: 胞腔复形 / Cell Complexes
chapter: 6
section: 6
tags: [cell-complex, CW-complex, torus, HITs]
references:
  - "[[04_circle_sphere]]"
  - "[[07_hubs_spokes]]"
---

# 胞腔复形 / Cell Complexes

## 思想 / Idea

任何有限 CW 复形都可以表示为高阶归纳类型：$n$ 维盘变为 $n$ 维路径构造子。

Any finite CW complex can be presented as a HIT by turning $n$-dimensional discs into $n$-dimensional path constructors.

## 环面 $T^2$ / The Torus

$$T^2 \text{ 由以下生成：}$$
- 点 $b : T^2$
- 路径 $p : b = b$
- 路径 $q : b = b$
- 2-路径 $t : p \cdot q = q \cdot p$

等价地，$T^2 \equiv S^1 \times S^1$。

## 困难 / Difficulties

随着维度增加，归纳原理越来越难写出（需要定义依赖 $n$-路径和 $\mathsf{apd}$ 对 $n$-路径的作用）。解决方案：[[07_hubs_spokes|轮毂与辐条]]构造。

## 参考文献 / References

- HoTT Book, Section 6.6
