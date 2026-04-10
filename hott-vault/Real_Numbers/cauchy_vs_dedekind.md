---
type: section
title: Cauchy 与 Dedekind 实数比较 / Comparison
chapter: 11
section: 11.4
tags: [real-numbers, cauchy-reals, dedekind-reals, countable-choice]
references:
  - "[[03_cauchy_reals]]"
next:
  - "[[05_compactness]]"
---

# Cauchy 与 Dedekind 实数比较 / Comparison of Cauchy and Dedekind Reals

## 嵌入 / Embedding

$\mathbb{R}_C$ 是阿基米德有序域，因此由 $\mathbb{R}_D$ 的泛性质，有有序域嵌入:
$$\mathbb{R}_C \hookrightarrow \mathbb{R}_D$$
保有理数。一般地，不期望两者一致。

## 一致性条件 / Coincidence Conditions

**引理**: 若对每个 $x : \mathbb{R}_D$ 仅存在
$$c : \prod_{q, r : \mathbb{Q}} (q < r) \to (q < x) + (x < r)$$
（定位性的非截断版本），则 $\mathbb{R}_C \simeq \mathbb{R}_D$。

## 主要推论 / Main Corollary

**推论**: 若排中律或可数选择公理成立，则 $\mathbb{R}_C \simeq \mathbb{R}_D$。

- **排中律**: 直接提供非截断的定位判定
- **可数选择**: 将截断的定位判定提升为非截断版本

## 参考 / References

- HoTT Book, Section 11.4
