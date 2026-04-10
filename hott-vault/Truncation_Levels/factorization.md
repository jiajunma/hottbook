---
type: concept
title: 正交分解 / Orthogonal Factorization
chapter: 7
section: 6
tags: [factorization, n-connected, n-truncated, image]
references:
  - "[[05_connectedness]]"
  - "[[01_n_types]]"
---

# 正交分解 / Orthogonal Factorization

## 核心思想 / Core Idea

在集合论中，满射和单射构成唯一分解系统。在 HoTT 中，$n$-连通映射和 $n$-截断映射推广了这一结构。

## $n$-截断映射 / $n$-Truncated Maps

**定义.** $f : A \to B$ 是 $n$-截断的，若所有纤维 $\mathsf{fib}_f(b)$ 是 $n$-类型。

- $(-2)$-截断 = 等价
- $(-1)$-截断 = 嵌入

**引理 7.6.2.** $f$ 是 $(n+1)$-截断的当且仅当 $\mathsf{ap}_f : (x = y) \to (f(x) = f(y))$ 对所有 $x, y$ 是 $n$-截断的。

## $n$-像 / $n$-Image

**定义.** $f : A \to B$ 的 $n$-像为：

$$\mathsf{im}_n(f) \equiv \sum_{b:B} \|\mathsf{fib}_f(b)\|_n$$

当 $n = -1$ 时写作 $\mathsf{im}(f)$。

## 分解定理 / Factorization Theorem

**引理 7.6.5.** 任何函数 $f : A \to B$ 分解为 $n$-连通映射后接 $n$-截断映射：

$$A \xrightarrow{n\text{-conn}} \mathsf{im}_n(f) \xrightarrow{n\text{-trunc}} B$$

**定理 7.6.6.** 此分解本质上唯一：$n$-连通和 $n$-截断映射构成**正交分解系统**。

正交性意味着：对 $n$-连通映射 $f$ 和 $n$-截断映射 $g$，任何从 $f$ 到 $g$ 的交换正方形有唯一对角填充。

## 参考文献 / References

- HoTT Book, Section 7.6
