---
type: discussion
title: 选择公理 / Axiom of Choice
chapter: 3
section: 8
tags: [axiom-of-choice, AC, sets, logic]
references:
  - "[[00_Overview]]"
  - "[[03_mere_propositions]]"
  - "[[06_propositional_truncation]]"
  - "[[01_sets_and_n_types]]"
---

# 选择公理 / Axiom of Choice

## HoTT 中的选择公理 / AC in HoTT

在 HoTT 中，选择公理的正确表述要求索引类型是**集合**：

$$\mathsf{AC} \defeq \prod_{X:\mathsf{Set}}\prod_{A:X \to \mathsf{Set}}\prod_{P:\prod_{x:X}A(x) \to \mathsf{Prop}} \left(\prod_{x:X}\left\|\sum_{a:A(x)} P(x,a)\right\| \to \left\|\sum_{g:\prod_{x:X}A(x)}\prod_{x:X}P(x,g(x))\right\|\right)$$

直觉：如果对每个 $x:X$，"仅仅存在"满足 $P$ 的 $a:A(x)$，则"仅仅存在"一个全局选择函数。

## 为什么需要集合 / Why Sets Are Required

若不限制 $X$ 为集合，选择公理的非截断版本：

$$\prod_{x:X} \left\|\sum_{a:A(x)} P(x,a)\right\| \to \left\|\sum_{g:\prod_{x:X}A(x)} \prod_{x:X} P(x,g(x))\right\|$$

对一般类型是不合理的。核心原因是选择函数需要对 $X$ 的路径结构协变 (covariant)，而对于高维类型，这要求更多的一致性条件。

## 类型论的选择 / Type-Theoretic Choice

不需要截断的版本是类型论内可证的：

$$\prod_{x:A}\sum_{y:B(x)} P(x,y) \to \sum_{g:\prod_{x:A}B(x)}\prod_{x:A}P(x,g(x))$$

这只是依赖类型的 currying/uncurrying——**不需要**任何公理！

区别在于截断：当我们只知道"仅仅存在"而非有具体见证时，选择变得不平凡。

## 一致性 / Consistency

$\mathsf{AC}$（限于集合的版本）与 HoTT 的其他公理（包括 univalence）是一致的，但**不可证明**。

## 相关概念 / Related Concepts

- [[06_propositional_truncation|命题截断]] - AC 中截断的角色
- [[08_unique_choice|唯一选择]] - 不需要 AC 的特殊情况
- [[04_classical_vs_intuitionistic|经典逻辑]] - AC 与经典原理的关系

## 参考文献 / References

- HoTT Book, Section 3.8: The axiom of choice
