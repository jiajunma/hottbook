---
type: theorem
title: 唯一选择原理 / Principle of Unique Choice
chapter: 3
section: 9
tags: [unique-choice, truncation, mere-proposition]
references:
  - "[[00_Overview]]"
  - "[[06_propositional_truncation]]"
  - "[[07_axiom_of_choice]]"
  - "[[03_mere_propositions]]"
---

# 唯一选择原理 / Principle of Unique Choice

## 陈述 / Statement

若 $P : A \to \mathcal{U}$ 是命题值的（$\prod_{x:A}\mathsf{isProp}(P(x))$），且对所有 $x:A$ 有 $\|P(x)\|$（即 $P(x)$ 仅仅被居住），则：

$$\prod_{x:A} P(x)$$

If $P$ is prop-valued and $\|P(x)\|$ holds for all $x$, then $\prod_{x:A}P(x)$.

## 直觉 / Intuition

当目标 $P(x)$ 本身是纯命题时，"仅仅存在"和"存在"没有区别。因为 $P(x)$ 最多有一个元素，知道它"仅仅被居住"就足以得到具体的元素。

这就是命题截断的消除原理的直接推论：$\|P(x)\| \to P(x)$ 当 $P(x)$ 是纯命题时成立。

## 证明梗概 / Proof Sketch

对于每个 $x : A$：
1. 我们有 $\|P(x)\|$
2. $P(x)$ 是纯命题
3. 由截断的消除原理，$\|P(x)\| \to P(x)$
4. 因此得到 $P(x)$

## 与选择公理的区别 / Difference from AC

| 方面 / Aspect | 唯一选择 / Unique choice | 选择公理 / AC |
|---|---|---|
| 状态 / Status | 可证明（定理） | 公理（不可证明） |
| 条件 / Condition | $P(x)$ 是纯命题 | 无此限制 |
| 截断 / Truncation | 可消除 | 不可消除 |

唯一选择是完全构造性的，不需要任何额外公理。

## 应用 / Applications

唯一选择原理经常用于：
- 从"仅仅存在唯一的 $x$"推出具体的 $x$
- 在同伦层级推理中从截断的存在性恢复具体构造

## 相关概念 / Related Concepts

- [[06_propositional_truncation|命题截断]] - 截断的消除
- [[07_axiom_of_choice|选择公理]] - 更强的原理
- [[03_mere_propositions|纯命题]] - 唯一选择的关键条件

## 参考文献 / References

- HoTT Book, Section 3.9: The principle of unique choice
