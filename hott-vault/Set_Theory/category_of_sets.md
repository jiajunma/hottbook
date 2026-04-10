---
type: section
title: 集合范畴 / The Category of Sets
chapter: 10
section: 10.1
tags: [set-theory, category-of-sets, pretopos, regular-category]
references:
  - "[[00_Overview]]"
next:
  - "[[02_cardinal_numbers]]"
---

# 集合范畴 / The Category of Sets

## 概述 / Overview

$\mathsf{Set}$ 是 0-类型和它们之间的函数构成的范畴。在构造性、谓词性、一致基础中，它是 $\Pi W$-预拓扑。

## 极限与余极限 / Limits and Colimits

- **积**: $\Pi$ 类型（无穷积也可）
- **拉回**: $\sum_{a:A} \sum_{b:B} f(a) = g(b)$
- **余积**: $+$ 类型和 $\sum$ 类型
- **推出**: 由 HIT 推出构造

$\mathsf{Set}$ 是 **完备且余完备** 的。

## 像 / Image

像 $\mathsf{im}(f) \defeq \sum_{b:B} \|\mathsf{fib}_f(b)\|_{-1}$，给出 **满-单** 分解:
$$A \xrightarrow{\tilde{f}} \mathsf{im}(f) \xrightarrow{i_f} B$$

$\tilde{f}$ 满射，$i_f$ 单射。此分解在拉回下稳定。

## 正则范畴 / Regular Category

$\mathsf{Set}$ 是正则范畴:
1. 有限完备
2. 核对的余等化子存在
3. 正则满态射在拉回下稳定

## 单/满态射 / Mono/Epimorphisms

- **单态射** = 单射函数
- **满态射** = 满射函数 = 正则满态射 (余等化子)

## $\Pi W$-预拓扑 / $\Pi W$-Pretopos

$\mathsf{Set}$ 具有:
- 有限极限和余极限
- 不交余积和有效等价关系
- 依赖积 ($\Pi$ 类型) 和 $W$ 类型

若假设命题缩放 (propositional resizing)，$\mathsf{Set}$ 是初等拓扑; 若假设排中律和选择公理，则是 Lawvere 的 ETCS 模型。

## 参考 / References

- HoTT Book, Section 10.1
