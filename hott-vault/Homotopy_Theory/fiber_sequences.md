---
type: section
title: 纤维序列与长正合列 / Fiber Sequences and Long Exact Sequence
chapter: 8
section: 8.4
tags: [homotopy-theory, fiber-sequence, long-exact-sequence, homotopy-groups]
references:
  - "[[03_pi_k_n]]"
next:
  - "[[05_hopf_fibration]]"
---

# 纤维序列与同伦群长正合列 / Fiber Sequences and LES

## 尖点映射与环路空间函子 / Pointed Maps and Loop Space Functor

**尖点映射**: $(X, x_0) \to (Y, y_0)$ 是映射 $f : X \to Y$ 加路径 $f_0 : f(x_0) = y_0$。

**环路空间函子**: 给定尖点映射 $f$，定义 $\Omega f : \Omega X \to \Omega Y$:
$$(\Omega f)(p) \defeq \overline{f_0} \cdot \mathsf{ap}_f(p) \cdot f_0$$

## 纤维序列 / Fiber Sequence

给定尖点映射 $f : X \to Y$，**纤维序列**是无限序列:

$$\cdots \to X^{(n+1)} \xrightarrow{f^{(n)}} X^{(n)} \to \cdots \to F \xrightarrow{i} X \xrightarrow{f} Y$$

其中 $X^{(n+1)} \defeq \mathsf{fib}_{f^{(n-1)}}(x_0^{(n-1)})$。

**关键引理**: 纤维序列中的类型是 $F$, $X$, $Y$ 的迭代环路空间:

$$\cdots \to \Omega^2 X \xrightarrow{\Omega^2 f} \Omega^2 Y \to \Omega F \to \Omega X \xrightarrow{-\Omega f} \Omega Y \xrightarrow{\partial} F \xrightarrow{i} X \xrightarrow{f} Y$$

## 同伦群长正合列 / Long Exact Sequence of Homotopy Groups

**定理**: 给定尖点映射 $f : X \to Y$，纤维 $F \defeq \mathsf{fib}_f(y_0)$，有长正合列:

$$\cdots \to \pi_k(F) \to \pi_k(X) \to \pi_k(Y) \to \pi_{k-1}(F) \to \cdots \to \pi_0(F) \to \pi_0(X) \to \pi_0(Y)$$

- $k \ge 2$: 交换群
- $k = 1$: 群
- $k = 0$: 尖点集

**应用**: 若 $f$ 是 $n$-连通的，则:
1. $\pi_k(f)$ 是同构，对 $k \le n$
2. $\pi_k(f)$ 是满射，对 $k = n+1$

## 参考 / References

- HoTT Book, Section 8.4
