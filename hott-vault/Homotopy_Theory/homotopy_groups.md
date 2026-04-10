---
type: section
title: n-连通空间的 πₖ / π_(k≤n) of n-connected Spaces
chapter: 8
section: 8.3
tags: [homotopy-theory, homotopy-groups, connectedness, truncatedness]
references:
  - "[[02_connectedness_suspensions]]"
next:
  - "[[04_fiber_sequences]]"
---

# $\pi_{k \le n}$ / Homotopy Groups of Connected and Truncated Spaces

## 截断类型的同伦群 / Homotopy Groups of Truncated Types

**引理**: 若 $A$ 是 $n$-截断的，则 $\pi_k(A, a) = \mathbf{1}$ 对所有 $k > n$。

因为 $\Omega^k(A,a)$ 是 $(n-k)$-截断的，当 $k > n$ 时是纯命题，又可居，故可缩。

## 连通类型的同伦群 / Homotopy Groups of Connected Types

**引理**: 若 $A$ 是 $n$-连通的，则 $\pi_k(A, a) = \mathbf{1}$ 对所有 $k \le n$。

**证明**: 利用截断的传递性:
$$\pi_k(A,a) = \|\Omega^k(A,a)\|_0 = \Omega^k(\|A\|_k) = \Omega^k(\|\|A\|_n\|_k) = \Omega^k(\|\mathbf{1}\|_k) = \mathbf{1}$$

## 球面的低维同伦群 / Low Homotopy Groups of Spheres

**推论**: $\pi_k(S^n) = \mathbf{1}$ 对 $k < n$。

$S^n$ 是 $(n-1)$-连通的，故 $\pi_k(S^n) = \mathbf{1}$ 对 $k \le n-1$，即 $k < n$。

## 参考 / References

- HoTT Book, Section 8.3
