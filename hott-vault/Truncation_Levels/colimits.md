---
type: concept
title: n-类型的余极限 / Colimits of n-types
chapter: 7
section: 4
tags: [colimits, pushouts, n-types, truncation]
references:
  - "[[03_truncations]]"
  - "[[../../06_HITs/08_pushouts]]"
---

# $n$-类型的余极限 / Colimits of $n$-types

## 问题 / Problem

$n$-类型的（同伦）余极限一般不再是 $n$-类型。例如，$\mathbf{1}$ 和 $\mathbf{1}$ 是集合，但推出 $\mathbf{1} \sqcup^\mathbf{2} \mathbf{1} \simeq S^1$ 不是集合。

## 解决方案 / Solution

对 $n$-类型的推出进行截断，得到的 $n$-类型有正确的泛性质。

### 截断推出 / Truncated Pushout

给定 $n$-类型跨度 $A \xleftarrow{f} C \xrightarrow{g} B$：

$$\|\!A \sqcup^C B\!\|_n$$

对 $n$-类型 $E$ 有：

$$(\|\!A \sqcup^C B\!\|_n \to E) \simeq \mathsf{cocone}_\mathscr{D}(E)$$

### 一般构造 / General Construction

$n$-类型范畴中的余极限 = 普通余极限后截断。

## 参考文献 / References

- HoTT Book, Section 7.4
