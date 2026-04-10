---
type: concept
title: 归纳原理与依赖路径 / Induction Principles and Dependent Paths
chapter: 6
section: 2
tags: [HITs, induction, dependent-paths, circle]
references:
  - "[[01_introduction]]"
  - "[[04_circle_sphere]]"
---

# 归纳原理与依赖路径 / Induction Principles and Dependent Paths

## 依赖路径 / Dependent Paths

**依赖路径**是"位于"另一条路径之上的路径：

$$\mathsf{dpath}_P(p, u, v) \equiv (\mathsf{transport}^P(p, u) = v)$$

其中 $p : x =_A y$, $u : P(x)$, $v : P(y)$。

## $S^1$ 的归纳原理 / Induction Principle for $S^1$

给定 $P : S^1 \to \mathsf{Type}$，以及：
- $b : P(\mathsf{base})$
- $\ell : \mathsf{dpath}_P(\mathsf{loop}, b, b)$

则存在 $f : \prod_{x:S^1} P(x)$，满足 $f(\mathsf{base}) \equiv b$ 且 $\mathsf{apd}_f(\mathsf{loop}) = \ell$。

## 计算规则 / Computation Rules

- **点构造子**的计算规则是**判断相等**：$f(\mathsf{base}) \equiv b$
- **路径构造子**的计算规则是**命题相等**：$\mathsf{ap}_f(\mathsf{loop}) = \ell$

这是因为 $\mathsf{ap}_f$ 不是类型论的基本部分，而是从恒等类型归纳定义的。

## 递归原理与泛性质 / Recursion and Universal Property

**引理 6.2.5.** 递归原理：给定 $a : A$ 和 $p : a = a$，存在 $f : S^1 \to A$ 满足 $f(\mathsf{base}) \equiv a$ 和 $\mathsf{ap}_f(\mathsf{loop}) = p$。

**引理 6.2.9（泛性质）.** $(S^1 \to A) \simeq \sum_{x:A}(x = x)$。

## 参考文献 / References

- HoTT Book, Section 6.2
