---
type: section
title: Cauchy 实数 / Cauchy Reals
chapter: 11
section: 11.3
tags: [real-numbers, cauchy-reals, HIT, higher-inductive-inductive]
references:
  - "[[02_dedekind_reals]]"
next:
  - "[[04_cauchy_vs_dedekind]]"
---

# Cauchy 实数 / Cauchy Reals

## 动机 / Motivation

经典 Cauchy 构造需要选择公理（将 Cauchy 序列的序列提升为代表序列）。HoTT 的第四种方案: 用 HIT **同时** 添加极限和商关系。

## 高阶归纳-归纳定义 / Higher Inductive-Inductive Definition

$\mathbb{R}_C$ 和关系 $\sim_\epsilon : \mathbb{Q}^+ \times \mathbb{R}_C \times \mathbb{R}_C \to \mathcal{U}$ 同时归纳定义。

**$\mathbb{R}_C$ 的构造器**:
1. **有理点**: $\mathsf{rat}(q) : \mathbb{R}_C$，对 $q : \mathbb{Q}$
2. **极限点**: $\mathsf{lim}(x) : \mathbb{R}_C$，对 Cauchy 逼近 $x : \mathbb{Q}^+ \to \mathbb{R}_C$（满足 $x_\delta \sim_{\delta+\epsilon} x_\epsilon$）
3. **路径**: 若 $\forall \epsilon. u \sim_\epsilon v$，则 $u = v$

**$\sim_\epsilon$ 的构造器**: 规定有理数之间、有理数与极限之间、极限之间何时 $\epsilon$-接近。最后截断为纯命题。

## 关键优势 / Key Advantage

无需选择公理或幂集。所有常见实数（$\sqrt{2}$, $\pi$, $e$）都可构造为有理 Cauchy 序列的极限。

## 泛性质 / Universal Property

**定理**: $\mathbb{R}_C$ 是 **初始 Cauchy 完备阿基米德有序域**。

## 参考 / References

- HoTT Book, Section 11.3
