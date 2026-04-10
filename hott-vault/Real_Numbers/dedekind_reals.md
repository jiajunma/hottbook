---
type: section
title: Dedekind 实数 / Dedekind Reals
chapter: 11
section: 11.2
tags: [real-numbers, dedekind-cut, ordered-field, completeness]
references:
  - "[[01_rationals]]"
next:
  - "[[03_cauchy_reals]]"
---

# Dedekind 实数 / Dedekind Reals

## Dedekind 分割 / Dedekind Cut

**定义**: Dedekind 分割是一对纯谓词 $L, U : \mathbb{Q} \to \Omega$ 满足:
1. **可居 (inhabited)**: $\exists q. L(q)$ 且 $\exists r. U(r)$
2. **圆化 (rounded)**: $L(q) \Leftrightarrow \exists r > q. L(r)$ 且 $U(r) \Leftrightarrow \exists q < r. U(q)$
3. **不交 (disjoint)**: $\lnot(L(q) \land U(q))$
4. **定位 (located)**: $q < r \Rightarrow L(q) \lor U(r)$

圆化保证分割是开的; 定位保证 $L$ 和 $U$ 之间无大间隙。

## Dedekind 实数类型 / Type of Dedekind Reals

$$\mathbb{R}_D \defeq \sum_{(L, U) : (\mathbb{Q} \to \Omega)^2} \mathsf{dcut}(L, U)$$

## 命题类型 $\Omega$ 的选择 / Choice of $\Omega$

多种方式处理宇宙层级问题:
1. 跟踪所有宇宙层级
2. 假设命题缩放公理
3. 排中律使 $\Omega = \mathbf{2}$
4. 取 $\Omega$ 为初始 $\sigma$-框架

## 有序域结构 / Ordered Field Structure

$\mathbb{R}_D$ 是阿基米德有序域。序和运算由分割上的运算定义。

## Cauchy 完备性 / Cauchy Completeness

$\mathbb{R}_D$ 是 Cauchy 完备的（每个 Cauchy 逼近有极限）。

## 泛性质 / Universal Property

**定理**: $\mathbb{R}_D$ 是 **终阿基米德有序域**: 对任何 $\Omega$-容许的阿基米德有序域 $F$，存在唯一的嵌入 $F \hookrightarrow \mathbb{R}_D$（保有理数）。

## 参考 / References

- HoTT Book, Section 11.2
