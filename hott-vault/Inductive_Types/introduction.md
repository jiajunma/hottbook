---
type: concept
title: 归纳类型导论 / Introduction to Inductive Types
chapter: 5
section: 1
tags: [induction, inductive-types, recursion, natural-numbers]
references:
  - "[[00_Overview]]"
  - "[[../../01_Type_Theory/02_Type_Formers/04_sigma_type]]"
---

# 归纳类型导论 / Introduction to Inductive Types

## 什么是归纳类型？/ What is an Inductive Type?

**归纳类型 (inductive type)** $X$ 可以直觉地理解为由有限个**构造子 (constructors)** 自由生成的类型，每个构造子是一个以 $X$ 为值域的函数。

An **inductive type** $X$ is intuitively a type "freely generated" by a finite collection of **constructors**, each a function with codomain $X$.

### 基本示例 / Basic Examples

| 类型 / Type | 构造子 / Constructors | 描述 / Description |
|---|---|---|
| $\mathbf{2}$ | $0_\mathbf{2}, 1_\mathbf{2}$ | 布尔类型 |
| $\mathbf{1}$ | $\star$ | 单元类型 |
| $\mathbf{0}$ | (无) | 空类型 |
| $A + B$ | $\mathsf{inl}: A \to A+B$, $\mathsf{inr}: B \to A+B$ | 余积 |
| $\mathbb{N}$ | $0: \mathbb{N}$, $\mathsf{succ}: \mathbb{N} \to \mathbb{N}$ | 自然数 |

## 归纳原理 / Induction Principle

归纳原理是**依赖消除规则**：要证明关于归纳类型所有元素的性质 $E$，只需对每个构造子给出证明。

The induction principle (dependent elimination rule) says: to prove $E$ for all elements, it suffices to handle each constructor.

### 自然数的归纳原理 / Induction for $\mathbb{N}$

给定 $E: \mathbb{N} \to \mathsf{Type}$，若有：
- 基础情形：$e_z : E(0)$
- 归纳步骤：$e_s : \prod_{n:\mathbb{N}} E(n) \to E(\mathsf{succ}(n))$

则存在 $\mathsf{ind}_\mathbb{N}(E, e_z, e_s) : \prod_{x:\mathbb{N}} E(x)$，满足计算规则：
- $\mathsf{ind}_\mathbb{N}(E, e_z, e_s, 0) \equiv e_z$
- $\mathsf{ind}_\mathbb{N}(E, e_z, e_s, \mathsf{succ}(n)) \equiv e_s(n, \mathsf{ind}_\mathbb{N}(E, e_z, e_s, n))$

## 唯一性定理 / Uniqueness Theorem

**定理 5.1.1.** 设 $f, g : \prod_{x:\mathbb{N}} E(x)$ 满足同样的递推关系（命题相等意义下），则 $f = g$。

**Theorem 5.1.1.** If $f, g : \prod_{x:\mathbb{N}} E(x)$ satisfy the same recurrences up to propositional equality, then $f = g$.

这表明归纳原理不仅给出存在性，还蕴含唯一性。

## 参考文献 / References

- HoTT Book, Section 5.1
