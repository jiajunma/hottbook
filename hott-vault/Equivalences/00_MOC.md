---
type: moc
title: 等价 / Equivalences
chapter: 4
tags: [moc, equivalences, homotopy-type-theory]
---

# 等价 / Equivalences

## 概述 / Overview

等价有三种等价的定义，它们都是纯命题 (mere propositions)，而拟逆 (quasi-inverse) 不是。$A \simeq B$ 意味着存在一个具有可缩纤维的函数 / 半伴随等价 / 双可逆映射。

Three equivalent definitions of equivalence, all mere propositions (unlike quasi-inverse). $A \simeq B$ means there is a function with contractible fibers / a half-adjoint equivalence / a bi-invertible map.

## 本区域笔记 / Notes in This Area

### 基础概念 / Foundations
- [[homotopy]] -- 同伦 $f \sim g$ / Homotopies between functions
- [[quasi_inverses]] -- 拟逆及其问题 / Quasi-inverses and why they are problematic

### 等价的定义 / Definitions of Equivalence
- [[half_adjoint]] -- 半伴随等价 / Half-adjoint equivalences
- [[bi_invertible]] -- 双可逆映射 / Bi-invertible maps
- [[contractible_fibers]] -- 可缩纤维 / Contractible fibers (equivalently: $\mathsf{isEquiv}(f)$)

### 性质与应用 / Properties and Applications
- [[surjections_embeddings]] -- 满射与嵌入 / Surjections and embeddings
- [[closure_properties]] -- 等价的封闭性质 / Closure properties of equivalences
- [[object_classifier]] -- 对象分类子 / The object classifier
- [[universal_properties]] -- 泛性质 / Universal properties

## 跨区域链接 / Cross-Area Links

- [[univalence]] (Axioms) -- $(A =_\mathcal{U} B) \simeq (A \simeq B)$ / Univalence identifies equivalence with identity
- [[contractibility]] (Truncation_Levels) -- 可缩性是最低截断层级 / Contractibility is the lowest truncation level
- [[transport]] (Identity_and_Paths) -- 传输给出等价 / Transport gives equivalences
