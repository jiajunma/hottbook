---
type: definition
title: 命题截断 / Propositional Truncation
chapter: 3
section: 7
tags: [truncation, mere-existence, disjunction, existential, bracket-type]
references:
  - "[[00_Overview]]"
  - "[[03_mere_propositions]]"
  - "[[02_propositions_as_types_problem]]"
  - "[[08_unique_choice]]"
---

# 命题截断 / Propositional Truncation

## 定义 / Definition

对任意类型 $A$，其**命题截断 (propositional truncation)** $\|A\|$ 是一个类型，满足：

1. **构造器 / Constructor**: $|{-}| : A \to \|A\|$，即 $|a| : \|A\|$ 对任意 $a : A$
2. **截断性 / Truncation**: $\prod_{x,y:\|A\|} (x = y)$，即 $\|A\|$ 是纯命题
3. **消除 / Elimination**: 若 $B$ 是纯命题且 $f : A \to B$，则存在 $g : \|A\| \to B$

$\|A\|$ is the mere proposition that "forgets" how $A$ is inhabited. It says "$A$ is merely inhabited" without providing a specific witness.

## 直觉 / Intuition

$\|A\|$ 将 $A$ 的所有元素"压缩"为一个点（如果存在的话）。它保留了"是否有元素"的信息，但丢弃了"是哪个元素"的信息。

## 截断后的逻辑连接词 / Truncated Logical Connectives

### 析取 / Disjunction

$$P \lor Q \defeq \|P + Q\|$$

这是纯命题版的"或"。$P + Q$ 记住了选择哪一侧，但 $\|P + Q\|$ 只记住"至少一侧成立"。

### 存在量词 / Existential Quantifier

$$\exists_{x:A} P(x) \defeq \left\|\sum_{x:A} P(x)\right\|$$

这是纯命题版的"存在"。$\sum_{x:A} P(x)$ 提供具体的见证，但 $\exists_{x:A} P(x)$ 只断言"存在某个 $x$"。

## "Merely" 的含义 / The Meaning of "Merely"

在 HoTT 文献中，**"merely"** 表示命题截断：

| 表述 / Phrase | 含义 / Meaning |
|---|---|
| $A$ is inhabited | $a : A$（有具体见证） |
| $A$ is **merely** inhabited | $\|A\|$（存在但不知具体是谁） |
| there **merely** exists | $\exists$（截断的存在量词） |

## 消除原理 / Elimination Principle

> 从 $\|A\|$ 只能映射到纯命题。

若 $B$ 是纯命题，则：

$$(A \to B) \to (\|A\| \to B)$$

这意味着：若你的目标本身是纯命题，那么你可以"打开"截断并使用具体的见证。

## 例子 / Example

- $\|\mathbb{N}\|$ 是纯命题（等价于 $\mathbf{1}$，因为 $\mathbb{N}$ 被居住）
- $\|\mathbf{0}\|$ 等价于 $\mathbf{0}$

## 相关概念 / Related Concepts

- [[03_mere_propositions|纯命题]] - 截断的目标
- [[08_unique_choice|唯一选择]] - 从截断中提取的条件
- [[../06_HITs|高阶归纳类型]] - 截断可用 HIT 定义

## 参考文献 / References

- HoTT Book, Section 3.7: Propositional truncation
