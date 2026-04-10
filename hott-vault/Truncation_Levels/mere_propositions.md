---
type: definition
title: 纯命题 / Mere Propositions
chapter: 3
section: 3
tags: [mere-proposition, prop, (-1)-type, proof-irrelevance]
references:
  - "[[00_Overview]]"
  - "[[01_sets_and_n_types]]"
  - "[[09_contractibility]]"
  - "[[06_propositional_truncation]]"
---

# 纯命题 / Mere Propositions

## 定义 / Definition

类型 $P$ 是一个**纯命题 (mere proposition)** 当且仅当其任意两个元素都相等：

$$\mathsf{isProp}(P) \defeq \prod_{x,y:P}(x = y)$$

纯命题也称为 **(-1)-类型 ((-1)-type)** 或 **h-命题 (h-proposition)**。

A type $P$ is a **mere proposition** if any two of its elements are equal. Also called a (-1)-type.

## 直觉 / Intuition

纯命题是"证明无关"的类型：如果它被居住 (inhabited)，那么它恰好有一种居住方式（up to equality）。我们只关心它*是否*被居住，而非*如何*被居住。

A mere proposition is proof-irrelevant: if inhabited, it has essentially one element.

## 关键性质 / Key Properties

### 被居住的纯命题是可缩的 / Inhabited mere prop is contractible

若 $P$ 是纯命题且 $p_0 : P$，则 $P \simeq \mathbf{1}$。

具体地，$\mathsf{isProp}(P)$ 且 $p_0 : P$ 意味着 $\mathsf{isContr}(P)$。

### 每个纯命题都是集合 / Every mere prop is a set

$$\mathsf{isProp}(P) \implies \mathsf{isSet}(P)$$

这是因为如果所有路径都相等，那么平行路径之间也只有一条二维路径。

### isProp 本身是纯命题 / isProp is itself a mere prop

$$\mathsf{isProp}(\mathsf{isProp}(P))$$

## 例子 / Examples

| 类型 / Type | 是否纯命题 / Is prop? | 理由 / Reason |
|---|---|---|
| $\mathbf{1}$ | 是 | 只有一个元素 $\star$ |
| $\mathbf{0}$ | 是 | 空类型，平凡满足 |
| $x =_A y$ （当 $A$ 是集合时） | 是 | 集合的定义 |
| $\mathbb{N}$ | 否 | $0 \neq 1$ |
| $\mathsf{Bool}$ | 否 | 两个不同元素 |

## 与逻辑的对应 / Correspondence with Logic

| 逻辑 / Logic | HoTT（纯命题版）/ HoTT (prop version) |
|---|---|
| True | $\mathbf{1}$ |
| False | $\mathbf{0}$ |
| $P \land Q$ | $P \times Q$ |
| $P \Rightarrow Q$ | $P \to Q$ |
| $\neg P$ | $P \to \mathbf{0}$ |
| $P \lor Q$ | $\|P + Q\|$ （需截断） |
| $\forall_{x:A} P(x)$ | $\prod_{x:A} P(x)$ |
| $\exists_{x:A} P(x)$ | $\|\sum_{x:A} P(x)\|$ （需截断） |

> 注意：$\times$, $\to$, $\prod$ 保持纯命题性，但 $+$ 和 $\sum$ 不保持——需要[[06_propositional_truncation|命题截断]]。

## 相关概念 / Related Concepts

- [[01_sets_and_n_types|集合]] - 0-type，比纯命题高一层
- [[09_contractibility|可缩性]] - (-2)-type，比纯命题低一层
- [[06_propositional_truncation|命题截断]] - 将任意类型变为纯命题

## 参考文献 / References

- HoTT Book, Section 3.3: Mere propositions
