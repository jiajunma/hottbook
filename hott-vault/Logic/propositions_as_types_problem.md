---
type: discussion
title: 命题即类型的问题 / Propositions-as-Types Problem
chapter: 3
section: 2
tags: [propositions-as-types, double-negation, LEM, logic]
references:
  - "[[00_Overview]]"
  - "[[03_mere_propositions]]"
  - "[[04_classical_vs_intuitionistic]]"
---

# 命题即类型的问题 / Propositions-as-Types Problem

## 朴素对应 / Naive Correspondence

在 Curry-Howard 对应中，命题直接对应类型，证明对应项。但在 HoTT 中，这种朴素对应会产生问题。

Under the naive Curry-Howard correspondence, propositions are types and proofs are terms. In HoTT, this naive approach leads to problems.

## 问题一：双重否定消除 / Problem 1: Double Negation Elimination

在朴素的命题即类型解释下：

$$\neg\neg A \to A$$

在一般情况下是**不可证明的**。这里 $\neg A \defeq A \to \mathbf{0}$。

这不仅仅是直觉逻辑的特性——在 HoTT 中，即使我们想要经典逻辑，朴素版本也有问题。

## 问题二：无限制排中律 / Problem 2: Unrestricted LEM

**无限制排中律** $\mathsf{LEM}_\infty$：

$$\mathsf{LEM}_\infty \defeq \prod_{A:\mathcal{U}} (A + \neg A)$$

> **这与 univalence 不一致！**

原因：$\mathsf{LEM}_\infty$ 要求对*所有类型*（包括非命题的类型）做选择。对于 $\mathsf{Bool} : \mathcal{U}$，这要求选择 $\mathsf{Bool}$ 的一个元素或证明它为空——但 univalence 要求这种选择对 $\mathsf{Bool}$ 的自等价不变，而交换 $\mathsf{true}$ 和 $\mathsf{false}$ 的自等价会翻转选择。

## 问题三：证明相关性 / Problem 3: Proof Relevance

在朴素解释下，"$A$ 或 $B$"对应 $A + B$。但 $A + B$ 记住了选择哪一侧及其证明——这比逻辑析取包含更多信息。

| 逻辑概念 / Logical concept | 朴素解释 / Naive | 正确解释 / Correct |
|---|---|---|
| $P \lor Q$ | $P + Q$ | $\|P + Q\|$ |
| $\exists_{x:A} P(x)$ | $\sum_{x:A} P(x)$ | $\|\sum_{x:A} P(x)\|$ |

## 解决方案 / Solution

区分**类型**和**纯命题**：

- 一般类型可以有多个不同的项（证明相关）
- **纯命题**（mere propositions）：所有项都相等（证明无关）
- 逻辑连接词应使用纯命题

详见 [[03_mere_propositions|纯命题]] 和 [[06_propositional_truncation|命题截断]]。

## 参考文献 / References

- HoTT Book, Section 3.2: Propositions as types?
