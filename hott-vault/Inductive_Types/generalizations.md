---
type: concept
title: 归纳类型的推广 / Generalizations of Inductive Types
chapter: 5
section: 7
tags: [inductive-families, mutual-induction, inductive-inductive, inductive-recursive]
references:
  - "[[06_general_syntax]]"
---

# 归纳类型的推广 / Generalizations of Inductive Types

## 参数与指标 / Parameters vs Indices

- **参数 (parameter)**：如 $A+B$ 中的 $A, B$。每个 $A+B$ 独立地归纳定义。
- **指标 (index)**：如向量 $\mathsf{Vec}(n, A)$ 中的 $n : \mathbb{N}$。构造子可改变指标，整个族一起归纳定义。

### 向量类型 / Vectors

$\mathsf{Vec}(n, A)$ 由以下构造子生成：
- $\mathsf{nil} : \mathsf{Vec}(0, A)$
- $\mathsf{cons} : \prod_{n:\mathbb{N}} A \to \mathsf{Vec}(n, A) \to \mathsf{Vec}(\mathsf{succ}(n), A)$

## 归纳谓词 / Inductive Predicates

例如 $\mathsf{iseven} : \mathbb{N} \to \mathsf{Type}$：
- $\mathsf{even}_0 : \mathsf{iseven}(0)$
- $\mathsf{even}_{ss} : \prod_{n:\mathbb{N}} \mathsf{iseven}(n) \to \mathsf{iseven}(\mathsf{succ}(\mathsf{succ}(n)))$

## 互归纳类型 / Mutual Inductive Types

当指标类型有限时，归纳族等价于几个类型的**互归纳**定义。例如偶数/奇数自然数类型。

## 归纳-归纳类型 / Inductive-Inductive Types

同时归纳定义类型 $A$ 和依赖于 $A$ 的族 $B : A \to \mathsf{Type}$，其中 $A$ 的构造子可以引用 $B$ 的元素。

## 归纳-递归类型 / Inductive-Recursive Types

同时归纳定义类型 $A$ 并递归定义函数 $f : A \to P$，构造子可引用 $f$ 的值。目前尚不知道如何从同伦视角证明其合理性。

## 参考文献 / References

- HoTT Book, Section 5.7
