---
type: concept
title: 归纳定义的一般语法 / General Syntax of Inductive Definitions
chapter: 5
section: 6
tags: [induction, strict-positivity, syntax]
references:
  - "[[01_intro_inductive_types]]"
---

# 归纳定义的一般语法 / General Syntax of Inductive Definitions

## 严格正性 / Strict Positivity

并非所有"看起来像归纳定义"的东西都有意义。关键限制是**严格正性 (strict positivity)**：被定义的类型不得出现在其构造子参数的箭头左侧。

Not every "inductive-looking definition" makes sense. The key restriction is **strict positivity**: the type being defined must never appear on the left of an arrow in the domains of its constructors.

### 为什么需要此限制 / Why This Restriction

- **协变性不够**：$((X \to \mathbb{N}) \to \mathbb{N})$ 虽然协变，但允许 Cantor 式悖论
- **反例**：构造子 $g : (C \to \mathbb{N}) \to C$ 的递归原理无法良好定义
- 构造子 $k : ((D \to \mathsf{Prop}) \to \mathsf{Prop}) \to D$ 导致矛盾（对角化论证）

### 合法的构造子形式 / Valid Constructor Form

$$c : (A \to W) \to (B \to C \to W) \to D \to W \to W$$

所有函数类型也可以是依赖函数（$\Pi$-类型）。

## 递归原理 / Recursion Principle

给定目标类型 $P$，对每个构造子提供相应的"递推数据"。例如上述构造子的递推假设为：

$$d : (A \to W) \to (A \to P) \to (B \to C \to W) \to (B \to C \to P) \to D \to W \to P \to P$$

## 归纳原理 / Induction Principle

类似递归原理，但递归调用参数替换为依赖函数。例如 $(A \to P)$ 变为 $\prod_{a:A} P(\alpha(a))$。

## 模式匹配 / Pattern Matching

在实践中，我们通过**模式匹配 (pattern matching)** 隐式调用归纳原理，为每个构造子写一个定义方程。

## 参考文献 / References

- HoTT Book, Section 5.6
