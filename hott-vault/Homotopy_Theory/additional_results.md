---
type: section
title: 附加结果 / Additional Results
chapter: 8
section: 8.10
tags: [homotopy-theory, blakers-massey, eilenberg-maclane, covering-spaces]
references:
  - "[[09_encode_decode]]"
  - "[[06_freudenthal]]"
---

# 附加结果 / Additional Results

以下结果已在 HoTT 中建立，但本章未给出完整证明。

## $\pi_{n+1}(S^n)$ 的计算

**定理**: 存在 $k$ 使得对所有 $n \ge 3$，$\pi_{n+1}(S^n) = \mathbb{Z}_k$。

经典中 $k = 2$。HoTT 中的证明是构造性的，可通过计算验证 $k = 2$。这是第一个不需要事先知道答案的同伦群计算。

## Blakers-Massey 定理

**定理**: 给定映射 $f : C \to X$, $g : C \to Y$，取推出 $X \sqcup^C Y$ 然后取 $\mathsf{inl}$ 和 $\mathsf{inr}$ 的拉回，诱导映射 $C \to X \times_{X \sqcup^C Y} Y$。

若 $f$ 是 $i$-连通的，$g$ 是 $j$-连通的，则此映射是 $(i+j)$-连通的。

## Eilenberg-Mac Lane 空间

**定理**: 对任意交换群 $G$ 和正整数 $n$，存在 $n$-类型 $K(G, n)$ 使得:
- $\pi_n(K(G, n)) = G$
- $\pi_k(K(G, n)) = 0$ 对 $k \ne n$

## 覆盖空间

**定理**: 对连通空间 $A$，覆盖空间与带 $\pi_1(A)$-作用的集合之间有等价。

## 参考 / References

- HoTT Book, Section 8.10
