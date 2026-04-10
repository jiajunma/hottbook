---
type: theorem
title: Univalence 蕴含函数外延性 / Univalence Implies Function Extensionality
chapter: 4
section: 9
tags: [univalence, function-extensionality, funext, weak-funext]
references:
  - "[[00_Overview]]"
  - "[[../02_HoTT_Basics/04_Axioms/02_univalence]]"
  - "[[../03_Sets_and_Logic/09_contractibility]]"
---

# Univalence 蕴含函数外延性 / Univalence Implies Function Extensionality

## 函数外延性 / Function Extensionality

**函数外延性 (function extensionality, funext)** 断言：逐点相等的函数是相等的。

$$\mathsf{funext} : \left(\prod_{x:A} f(x) = g(x)\right) \to (f = g)$$

更精确地，$\mathsf{happly} : (f = g) \to \prod_{x:A} f(x) = g(x)$ 是等价。

## 定理 / Theorem

> **Univalence 蕴含函数外延性。**

这是一个重要的结果：univalence 公理（关于类型相等的公理）蕴含了关于函数相等的原理。

## 证明策略 / Proof Strategy

证明分两步：

### 第一步：Univalence $\Rightarrow$ 弱函数外延性 / Step 1: Weak Funext

**弱函数外延性 (weak function extensionality)**：

$$\mathsf{weak\text{-}funext} : \left(\prod_{x:A}\mathsf{isContr}(P(x))\right) \to \mathsf{isContr}\left(\prod_{x:A}P(x)\right)$$

即：如果类型族 $P$ 的每个纤维都可缩，则其 $\prod$ 类型也可缩。

从 univalence 出发：若每个 $P(x)$ 可缩，则每个 $P(x) \simeq \mathbf{1}$，由 univalence 得 $P(x) = \mathbf{1}$，从而 $P = \lambda x.\mathbf{1}$（by funext for paths in $\mathcal{U}$），因此 $\prod_{x:A} P(x) = \prod_{x:A}\mathbf{1} \simeq \mathbf{1}$，即可缩。

### 第二步：弱函数外延性 $\Rightarrow$ 函数外延性 / Step 2: Weak Funext $\Rightarrow$ Funext

利用弱函数外延性，可以证明 $\mathsf{happly}$ 的纤维是可缩的，从而 $\mathsf{happly}$ 是等价，即函数外延性成立。

关键用到了[[../03_Sets_and_Logic/09_contractibility|自由路径空间的可缩性]]。

## 意义 / Significance

- 函数外延性在 Martin-Lof 类型论中是独立的（不可证也不可否证）
- Univalence 统一了多个"外延性"原理
- 这表明 univalence 是一个非常强的公理

## 相关概念 / Related Concepts

- [[../02_HoTT_Basics/04_Axioms/02_univalence|Univalence 公理]]
- [[../03_Sets_and_Logic/09_contractibility|可缩性与自由路径空间]]
- [[07_object_classifier|对象分类器]] - univalence 的另一个推论

## 参考文献 / References

- HoTT Book, Section 4.9: Univalence implies function extensionality
