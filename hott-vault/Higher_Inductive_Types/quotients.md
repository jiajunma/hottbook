---
type: definition
title: 集合商 / Set Quotients
chapter: 6
section: 10
tags: [quotients, equivalence-relation, integers, HITs]
references:
  - "[[09_truncations]]"
---

# 集合商 / Set Quotients

## 定义 / Definition

给定集合 $A$ 和纯关系 $R : A \times A \to \mathsf{Prop}$，**集合商** $A/R$ 由以下生成：
- $q : A \to A/R$
- 对每个 $a, b : A$ 若 $R(a,b)$，则 $q(a) = q(b)$
- 0-截断构造子：对所有 $x, y : A/R$ 和 $r, s : x = y$，$r = s$

## 泛性质 / Universal Property

**引理 6.10.3.** 对任何集合 $B$：

$$(A/R \to B) \simeq \left(\sum_{f:A\to B} \prod_{a,b:A} R(a,b) \to (f(a) = f(b))\right)$$

## 等价关系 / Equivalence Relations

当 $R$ 是等价关系（自反、对称、传递）时，$R(a,b) \simeq (q(a) =_{A/R} q(b))$。

## 典范代表 / Canonical Representatives

**引理 6.10.8.** 若存在幂等函数 $r : A \to A$ 使得 $(r(x) = r(y)) \simeq (x \sim y)$，则 $A/{\sim}$ 可具体构造为 $\sum_{x:A}(r(x) = x)$。

## 整数 $\mathbb{Z}$ / The Integers

$$\mathbb{Z} \equiv (\mathbb{N} \times \mathbb{N})/{\sim}, \qquad (a,b) \sim (c,d) \equiv (a + d = b + c)$$

$(a,b)$ 代表整数 $a - b$。有典范代表 $(n,0)$（非负）和 $(0,m)$（非正）。

**引理 6.10.12（整数归纳）.** 给定 $d_0 : P(0)$, $d_+ : \prod_{n:\mathbb{N}} P(n) \to P(n+1)$, $d_- : \prod_{n:\mathbb{N}} P(-n) \to P(-n-1)$，存在 $f : \prod_{z:\mathbb{Z}} P(z)$。

## 参考文献 / References

- HoTT Book, Section 6.10
