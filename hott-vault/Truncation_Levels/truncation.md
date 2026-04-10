---
type: definition
title: n-截断 / n-Truncations
chapter: 7
section: 3
tags: [truncation, n-truncation, hub-spoke, universal-property, reflective-subcategory]
references:
  - "[[01_n_types]]"
  - "[[../../06_HITs/09_truncations]]"
---

# $n$-截断 / $n$-Truncations $\|A\|_n$

## 构造 / Construction (Hub and Spoke)

对 $n \ge -1$，$\|A\|_n$ 由以下生成：
- $|{-}|_n : A \to \|A\|_n$
- 对每个 $r : S^{n+1} \to \|A\|_n$，轮毂点 $h(r) : \|A\|_n$
- 对每个 $r$ 和 $x : S^{n+1}$，辐条 $s_r(x) : r(x) = h(r)$

关键引理：$\|A\|_n$ 是 $n$-类型（由 $\Omega^{n+1}$ 可缩性判据）。

## 归纳原理 / Induction Principle

**定理 7.3.2.** 若 $P : \|A\|_n \to \mathsf{Type}$ 使每个 $P(x)$ 是 $n$-类型，且 $g : \prod_{a:A} P(|a|_n)$，则存在 $f : \prod_{x:\|A\|_n} P(x)$ 满足 $f(|a|_n) \equiv g(a)$。

## 泛性质 / Universal Property

**引理 7.3.3.** $n$-类型构成类型的**反射子范畴**：

$$(\|A\|_n \to B) \simeq (A \to B) \qquad \text{对 $n$-类型 $B$}$$

## 重要推论 / Key Consequences

- 函子性：$f : A \to B$ 诱导 $\|f\|_n : \|A\|_n \to \|B\|_n$
- 保持积：$\|A \times B\|_n \simeq \|A\|_n \times \|B\|_n$
- 路径空间：$\|x =_A y\|_n \simeq (|x|_{n+1} =_{\|A\|_{n+1}} |y|_{n+1})$
- 累积性：$\|\|A\|_n\|_k \simeq \|A\|_k$（$k \le n$）
- $A$ 是 $n$-类型当且仅当 $|{-}|_n : A \to \|A\|_n$ 是等价

## 参考文献 / References

- HoTT Book, Section 7.3
