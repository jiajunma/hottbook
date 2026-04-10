---
type: section
title: 结构恒等原则 / The Structure Identity Principle
chapter: 9
section: 9.8
tags: [category-theory, structure-identity, univalence]
references:
  - "[[07_dagger_categories]]"
next:
  - "[[09_rezk_completion]]"
---

# 结构恒等原则 / The Structure Identity Principle

## 核心思想 / Core Idea

**结构恒等原则**: 同构的结构是相等的。一致性公理对"无结构的类型"表达了这一原则; SIP 将其推广到带结构的类型。

## 结构概念 / Notion of Structure

**定义**: 范畴 $X$ 上的 **结构概念 (notion of structure)** $(P, H)$ 由以下组成:
1. 类型族 $P : X_0 \to \mathcal{U}$（结构）
2. 纯命题族 $H_{\alpha\beta}(f)$（何时 $f$ 是同态射）
3. 恒等是同态射; 同态射可合成

**标准结构概念**: 预序 $\alpha \le_x \beta \defeq H_{\alpha\beta}(1_x)$ 是偏序。

## 结构预范畴 / Precategory of Structures

$\mathsf{Str}_{(P,H)}(X)$ 的对象为 $\sum_{x:X_0} Px$，态射为满足 $H$ 的 $X$-态射。

## 主要定理 / Main Theorem

**定理 (SIP)**: 若 $X$ 是范畴，$(P, H)$ 是标准结构概念，则 $\mathsf{Str}_{(P,H)}(X)$ 是范畴。

## 应用 / Applications

- 函子范畴 $B^A$（作为 $B^{A_0}$ 上的结构）
- 一阶签名的结构范畴（群、环、拓扑空间等）均自动是范畴

## 参考 / References

- HoTT Book, Section 9.8
