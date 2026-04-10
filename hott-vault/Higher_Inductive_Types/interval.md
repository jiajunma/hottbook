---
type: definition
title: 区间类型 / The Interval
chapter: 6
section: 3
tags: [HITs, interval, function-extensionality, contractible]
references:
  - "[[02_induction_dependent_paths]]"
---

# 区间类型 / The Interval

## 定义 / Definition

**区间** $\mathbb{I}$ 由以下构造子生成：
- $0_\mathbb{I} : \mathbb{I}$
- $1_\mathbb{I} : \mathbb{I}$
- $\mathsf{seg} : 0_\mathbb{I} =_\mathbb{I} 1_\mathbb{I}$

## 区间是可缩的 / The Interval is Contractible

**引理 6.3.1.** $\mathbb{I}$ 是可缩类型。

证明：对所有 $x : \mathbb{I}$ 证明 $x = 1_\mathbb{I}$，用归纳原理处理 $0_\mathbb{I}$（用 $\mathsf{seg}$）、$1_\mathbb{I}$（用 $\mathsf{refl}$）和沿 $\mathsf{seg}$ 变化的情形。

## 函数外延性 / Function Extensionality from the Interval

**引理 6.3.2.** 若 $f, g : A \to B$ 满足 $\prod_{x:A}(f(x) = g(x))$，则 $f =_{A \to B} g$。

证明思路：用逐点等式 $p(x)$ 定义 $\widetilde{p}_x : \mathbb{I} \to B$，然后构造 $q : \mathbb{I} \to (A \to B)$，其中 $q(i) \equiv \lambda x.\, \widetilde{p}_x(i)$。则 $\mathsf{ap}_q(\mathsf{seg}) : f = g$。

## 参考文献 / References

- HoTT Book, Section 6.3
