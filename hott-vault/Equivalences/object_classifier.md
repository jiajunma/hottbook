---
type: theorem
title: 对象分类器 / Object Classifier
chapter: 4
section: 8
tags: [universe, classifier, type-family, equivalence]
references:
  - "[[00_Overview]]"
  - "[[04_contractible_fibers]]"
  - "[[../02_HoTT_Basics/04_Axioms/02_univalence]]"
---

# 对象分类器 / Object Classifier

## 核心定理 / Main Theorem

宇宙 $\mathcal{U}$ **分类 (classifies)** 映射：对于任意类型 $B$，

$$\left(\sum_{A:\mathcal{U}}(A \to B)\right) \simeq (B \to \mathcal{U})$$

The universe $\mathcal{U}$ classifies maps: the type of maps into $B$ (with specified domain in $\mathcal{U}$) is equivalent to the type of type families over $B$.

## 直觉 / Intuition

这个等价说的是：

- **左侧**：选择一个类型 $A : \mathcal{U}$ 和一个映射 $f : A \to B$
- **右侧**：选择一个类型族 $P : B \to \mathcal{U}$

对应关系是：$f : A \to B$ 对应于其纤维族 $\mathsf{fib}_f : B \to \mathcal{U}$，反过来 $P : B \to \mathcal{U}$ 对应于投影 $\mathsf{pr}_1 : \sum_{b:B} P(b) \to B$。

## 类比 / Analogy

在经典拓扑学中，这对应于**纤维丛的分类空间**：
- $B \to \mathcal{U}$ 类似于到分类空间 $BG$ 的映射
- 映射 $A \to B$ 类似于 $B$ 上的纤维丛
- $\mathcal{U}$ 扮演"万有丛"的基空间角色

## 依赖于 Univalence / Depends on Univalence

这个等价依赖于 univalence 公理。没有 univalence，$B \to \mathcal{U}$ 中的类型族不一定都来自映射的纤维。

## 相关概念 / Related Concepts

- [[04_contractible_fibers|可缩纤维]] - 纤维的定义
- [[../02_HoTT_Basics/04_Axioms/02_univalence|Univalence 公理]] - 分类器的基础
- [[08_univalence_implies_funext|Univalence 蕴含函数外延性]]

## 参考文献 / References

- HoTT Book, Section 4.8: The object classifier
