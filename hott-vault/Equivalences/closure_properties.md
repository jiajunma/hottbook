---
type: theorem
title: 封闭性质 / Closure Properties
chapter: 4
section: 7
tags: [2-out-of-3, retract, fiberwise-equivalence, closure]
references:
  - "[[00_Overview]]"
  - "[[04_contractible_fibers]]"
---

# 封闭性质 / Closure Properties of Equivalences

## 2-out-of-3 性质 / 2-out-of-3 Property

给定 $f : A \to B$ 和 $g : B \to C$：

> 若 $f$、$g$、$g \circ f$ 中任意两个是等价，则第三个也是等价。

| 已知 / Given | 结论 / Conclusion |
|---|---|
| $f$, $g$ 是等价 | $g \circ f$ 是等价 |
| $f$, $g \circ f$ 是等价 | $g$ 是等价 |
| $g$, $g \circ f$ 是等价 | $f$ 是等价 |

这是等价的基本封闭性质，在许多证明中被频繁使用。

## 缩回 / Retracts

若 $A$ 是 $B$ 的**缩回 (retract)**（即存在 $s : A \to B$ 和 $r : B \to A$ 使得 $r \circ s \sim \mathsf{id}_A$），且 $B$ 具有某个性质，则 $A$ 往往也具有该性质。

特别地：
- 可缩类型的缩回是可缩的
- 纯命题的缩回是纯命题
- $n$-type 的缩回是 $n$-type

## 纤维方向的等价 / Fiberwise Equivalences

给定类型族 $P, Q : A \to \mathcal{U}$ 和纤维方向的映射 $f : \prod_{x:A} P(x) \to Q(x)$：

> $f$ 是纤维方向的等价（即每个 $f_x : P(x) \to Q(x)$ 是等价）当且仅当总空间映射
> $$\mathsf{total}(f) : \sum_{x:A}P(x) \to \sum_{x:A}Q(x)$$
> 是等价。

$$\left(\prod_{x:A}\mathsf{isEquiv}(f_x)\right) \simeq \mathsf{isEquiv}(\mathsf{total}(f))$$

这建立了纤维方向等价与总空间等价之间的对应。

## 应用 / Applications

这些封闭性质在以下场景中特别有用：
- 通过已知等价构造新等价
- 证明某个映射是等价（通过分解为已知等价的复合）
- 在纤维和总空间之间转换等价性问题

## 相关概念 / Related Concepts

- [[04_contractible_fibers|可缩纤维]] - 等价的纤维刻画
- [[05_surjections_embeddings|满射与嵌入]] - 等价的分解

## 参考文献 / References

- HoTT Book, Section 4.7: Closure properties of equivalences
