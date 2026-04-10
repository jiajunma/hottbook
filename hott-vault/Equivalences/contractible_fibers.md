---
type: definition
title: 可缩纤维 / Contractible Fibers
chapter: 4
section: 4
tags: [contractible-fibers, voevodsky, fiber, equivalence]
references:
  - "[[00_Overview]]"
  - "[[02_half_adjoint_equivalences]]"
  - "[[../03_Sets_and_Logic/09_contractibility]]"
---

# 可缩纤维 / Contractible Fibers

## 纤维的定义 / Definition of Fiber

对于 $f : A \to B$ 和 $y : B$，$f$ 在 $y$ 上的**纤维 (fiber)** 或**同伦纤维 (homotopy fiber)** 是：

$$\mathsf{fib}_f(y) \defeq \sum_{x:A}(f(x) = y)$$

纤维的元素是一对 $(x, p)$，其中 $x : A$ 且 $p : f(x) = y$。

## Voevodsky 的等价定义 / Voevodsky's Definition

$f : A \to B$ 是**等价 (equivalence)** 当且仅当其所有纤维都是可缩的：

$$\mathsf{isEquiv}(f) \defeq \prod_{y:B}\mathsf{isContr}(\mathsf{fib}_f(y))$$

This is Voevodsky's definition: $f$ is an equivalence iff every fiber is contractible.

## 直觉 / Intuition

纤维 $\mathsf{fib}_f(y)$ 是 $y$ 的"原像"——所有映射到 $y$ 的 $x$（连同见证路径）。

- **可缩的纤维** = 每个 $y$ 恰好有一个原像（up to homotopy）
- 这正是"双射"在同伦意义下的推广

| 纤维的性质 / Fiber property | $f$ 的性质 / Property of $f$ |
|---|---|
| 每个纤维可缩 | 等价 |
| 每个纤维是纯命题 | [[05_surjections_embeddings\|嵌入]] |
| 每个纤维仅仅被居住 | [[05_surjections_embeddings\|满射]] |

## 是纯命题 / Is a Mere Proposition

$$\mathsf{isProp}(\mathsf{isEquiv}(f))$$

因为 $\mathsf{isContr}$ 是纯命题，而纯命题的 $\prod$ 仍是纯命题。

## 与自由路径空间的关系 / Relation to Free Path Space

$\mathsf{id}_A$ 在 $y$ 上的纤维是：

$$\mathsf{fib}_{\mathsf{id}_A}(y) = \sum_{x:A}(x = y)$$

这正是[[../03_Sets_and_Logic/09_contractibility|自由路径空间]]，它是可缩的。因此 $\mathsf{id}_A$ 是等价（符合预期）。

## 与其他定义的等价 / Equivalence with Other Definitions

$$\mathsf{isEquiv}(f) \simeq \mathsf{ishae}(f) \simeq \mathsf{biinv}(f)$$

## 相关概念 / Related Concepts

- [[../03_Sets_and_Logic/09_contractibility|可缩性]] - 纤维的性质
- [[02_half_adjoint_equivalences|半伴随等价]] - 等价定义
- [[05_surjections_embeddings|满射与嵌入]] - 纤维的弱化条件

## 参考文献 / References

- HoTT Book, Section 4.4: Contractible fibers
