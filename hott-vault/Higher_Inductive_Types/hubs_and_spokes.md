---
type: concept
title: 轮毂与辐条 / Hubs and Spokes
chapter: 6
section: 7
tags: [hubs-spokes, cell-complexes, HITs]
references:
  - "[[06_cell_complexes]]"
---

# 轮毂与辐条 / Hubs and Spokes

## 思想 / Idea

将 $n$ 维路径构造子替换为由 $(n-1)$ 维球面参数化的 1 维路径族。盘被视为锥点（轮毂）加上从锥点到边界每个点的子午线（辐条）。

Replace $n$-dimensional path constructors with families of 1-dimensional paths parametrized by an $(n-1)$-sphere. A disc is viewed as a cone point (hub) plus meridians (spokes) from the hub to every boundary point.

## 环面的辐条版本 / Hub-Spoke Torus

- 点 $b$, 路径 $p, q : b = b$
- 轮毂点 $h : T^2$
- 对每个 $x : S^1$，辐条路径 $s(x) : f(x) = h$

其中 $f : S^1 \to T^2$ 由 $f(\mathsf{base}) \equiv b$, $\mathsf{ap}_f(\mathsf{loop}) = p \cdot q \cdot p^{-1} \cdot q^{-1}$ 定义。

## 优势 / Advantages

- 避免定义依赖 2-路径和 $\mathsf{apd}^2$
- 所有构造子只涉及点和 1-路径
- 悬挂也是此思想的实例

## 注意 / Caveat

此"翻译"不保持判断计算规则，但保持命题计算规则。

## 参考文献 / References

- HoTT Book, Section 6.7
