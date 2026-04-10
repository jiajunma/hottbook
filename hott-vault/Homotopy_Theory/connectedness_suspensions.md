---
type: section
title: 悬挂的连通性 / Connectedness of Suspensions
chapter: 8
section: 8.2
tags: [homotopy-theory, connectedness, suspension, spheres]
references:
  - "[[01_pi1_circle]]"
next:
  - "[[03_pi_k_n]]"
---

# 悬挂的连通性 / Connectedness of Suspensions

## 主要定理 / Main Theorem

**定理**: 若 $A$ 是 $n$-连通的，则 $A$ 的悬挂 $\Sigma A$ 是 $(n+1)$-连通的。

**证明思路**: 悬挂 $\Sigma A$ 是推出 $\mathbf{1} \sqcup^A \mathbf{1}$。利用截断与推出交换，归结为证明 $\mathbf{1}$ 也是相同图表的推出（在 $(n+1)$-截断类型中），这依赖于 $A$ 的 $n$-连通性。

## 推论: 球面的连通性 / Corollary: Connectedness of Spheres

**推论**: 对所有 $n : \mathbb{N}$，球面 $S^n$ 是 $(n-1)$-连通的。

**证明**: 对 $n$ 归纳。
- $n = 0$: $S^0$ 仅需可居 (merely inhabited)
- 归纳步: $S^{n+1} = \Sigma S^n$，由前定理得 $(n-1)$-连通 $\implies$ $n$-连通

## 参考 / References

- HoTT Book, Section 8.2
