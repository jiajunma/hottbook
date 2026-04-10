---
type: discussion
title: 经典逻辑与直觉逻辑 / Classical vs Intuitionistic Logic
chapter: 3
section: 4
tags: [LEM, classical-logic, intuitionistic-logic, decidable]
references:
  - "[[00_Overview]]"
  - "[[03_mere_propositions]]"
  - "[[02_propositions_as_types_problem]]"
---

# 经典逻辑与直觉逻辑 / Classical vs Intuitionistic Logic

## 排中律（限于纯命题）/ LEM for Mere Propositions

**排中律 (Law of Excluded Middle)**，限于纯命题：

$$\mathsf{LEM} \defeq \prod_{A:\mathcal{U}}\left(\mathsf{isProp}(A) \to (A + \neg A)\right)$$

与 [[02_propositions_as_types_problem|无限制版本 $\mathsf{LEM}_\infty$]] 不同，这个版本**与 univalence 一致**。

Unlike the unrestricted $\mathsf{LEM}_\infty$, this version restricted to mere propositions is **consistent with univalence**.

## 为什么限制很重要 / Why the Restriction Matters

$\mathsf{LEM}_\infty$ 对所有类型（包括 $\mathsf{Bool}$、$\mathbb{N}$ 等非命题类型）要求选择，这与 univalence 冲突。而 $\mathsf{LEM}$ 只对纯命题做选择——纯命题至多一个元素，所以不存在由自等价引起的问题。

## 可判定性 / Decidability

类型 $A$ 是**可判定的 (decidable)** 如果：

$$A + \neg A$$

类型族 $B : A \to \mathcal{U}$ 是**可判定的**如果：

$$\prod_{x:A} (B(x) + \neg B(x))$$

> 可判定性是一个*构造性*概念——它给出一个算法来判断。LEM 断言所有纯命题都是可判定的，但不给出算法。

## 双重否定 / Double Negation

在直觉逻辑中，我们有：

- $A \to \neg\neg A$ （总是成立）
- $\neg\neg A \to A$ （一般不成立，等价于 LEM）
- $\neg\neg\neg A \to \neg A$ （总是成立）

## HoTT 中的立场 / Position in HoTT

HoTT 是**兼容的 (agnostic)**：

- 默认是直觉逻辑（不假设 LEM）
- 可以在需要时假设 LEM（作为公理）
- 许多经典定理可以在不使用 LEM 的情况下证明
- 某些定理（如 Cantor 定理的某些形式）需要 LEM

## 相关概念 / Related Concepts

- [[02_propositions_as_types_problem|命题即类型的问题]] - 为什么需要限制
- [[03_mere_propositions|纯命题]] - LEM 的限制对象
- [[07_axiom_of_choice|选择公理]] - 另一个经典原理

## 参考文献 / References

- HoTT Book, Section 3.4: Classical vs. intuitionistic logic
