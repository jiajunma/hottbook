---
type: section
title: Freudenthal 悬挂定理 / Freudenthal Suspension Theorem
chapter: 8
section: 8.6
tags: [homotopy-theory, freudenthal, suspension, stable-homotopy]
references:
  - "[[05_hopf_fibration]]"
next:
  - "[[07_van_kampen]]"
---

# Freudenthal 悬挂定理 / Freudenthal Suspension Theorem

## 悬挂映射 / Suspension Map

给定尖点类型 $(X, x_0)$，标准映射:
$$\sigma : X \to \Omega \Sigma X, \qquad \sigma(x) \defeq \mathsf{merid}(x) \cdot \overline{\mathsf{merid}(x_0)}$$

## 楔连通性引理 / Wedge Connectivity Lemma

**引理**: 若 $(A, a_0)$ 是 $n$-连通的，$(B, b_0)$ 是 $m$-连通的，$n, m \ge 0$，且 $P : A \to B \to (n+m)\text{-}\mathsf{Type}$，则给定截面条件可以扩展为全截面。

## 主定理 / Main Theorem

**定理 (Freudenthal 悬挂定理)**: 若 $X$ 是 $n$-连通的尖点类型 ($n \ge 0$)，则
$$\sigma : X \to \Omega \Sigma X$$
是 $2n$-连通的。

**证明**: 使用编码-解码方法的变体，直接构造纤维截断的编码。

## 稳定同伦群 / Stable Homotopy Groups

**推论**: 对 $n$-连通的 $X$:
- $\pi_k(\sigma) : \pi_k(X) \to \pi_k(\Omega \Sigma X) \cong \pi_{k+1}(\Sigma X)$ 是同构，当 $k \le 2n$
- 是满射，当 $k = 2n + 1$

**球面稳定性**: 由于 $S^n$ 是 $(n-1)$-连通的:
$$\pi_{n+k}(S^n) \cong \pi_{n+k+1}(S^{n+1}) \quad \text{当 } k \le n - 2$$

特别地，$\pi_n(S^n) \cong \pi_{n+1}(S^{n+1}) \cong \cdots$ 对足够大的 $n$，这些是 **稳定同伦群**。

**推论**: $\pi_n(S^n) \cong \mathbb{Z}$ (对所有 $n \ge 1$)。

## 参考 / References

- HoTT Book, Section 8.6
