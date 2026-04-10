---
type: definition
title: 模态 / Modalities
chapter: 7
section: 7
tags: [modalities, reflective-subuniverse, modal-types, factorization]
references:
  - "[[06_factorization]]"
  - "[[03_truncations]]"
---

# 模态 / Modalities

## 动机 / Motivation

$n$-类型和连通性的几乎所有理论都可以在更大的一般性下进行。本节概述这一推广。

## 反射子宇宙 / Reflective Subuniverse

**定义.** 反射子宇宙是谓词 $P : \mathsf{Type} \to \mathsf{Prop}$ 使得对每个 $A$ 有反射 $\bigcirc A$（满足 $P$）和映射 $\eta_A : A \to \bigcirc A$，使得预合成 $\eta_A$ 对满足 $P$ 的类型是等价。

性质：
- $P$ 中的类型在极限（积、回拉）下封闭
- 在 $\Pi$-类型下封闭（**指数理想**）
- 反射保持有限积

## 模态 / Modality

**定义 7.7.5.** **模态**是操作 $\bigcirc : \mathsf{Type} \to \mathsf{Type}$ 配备：
1. $\eta_A : A \to \bigcirc A$
2. 归纳原理：给定 $B : \bigcirc A \to \mathsf{Type}$ 和 $f : \prod_{a:A} \bigcirc(B(\eta(a)))$，存在 $\prod_{z:\bigcirc A} \bigcirc(B(z))$
3. 计算规则
4. 路径模态性：$\eta_{z=z'} : (z = z') \to \bigcirc(z = z')$ 是等价

模态等价于在 $\Sigma$-类型下封闭的反射子宇宙。

## 模态连通与截断 / Modal Connected and Truncated

对任何模态 $\bigcirc$：
- $\bigcirc$-连通：$\bigcirc(\mathsf{fib}_f(b))$ 对所有 $b$ 可缩
- $\bigcirc$-截断：$\mathsf{fib}_f(b)$ 对所有 $b$ 是模态的

由此得到正交分解系统，推广 $n$-连通/$n$-截断分解。

## 示例 / Examples

| 模态 / Modality | $\bigcirc A$ | 模态类型 / Modal types |
|---|---|---|
| $n$-截断 | $\|A\|_n$ | $n$-类型 |
| 恒等模态 | $A$ | 所有类型 |
| 命题截断 | $\|A\|_{-1}$ | 纯命题 |

**左正合模态 (left exact modalities)** 还保持回拉，对应于 Lawvere-Tierney 拓扑和子 $(\infty,1)$-拓斯。

## 参考文献 / References

- HoTT Book, Section 7.7
