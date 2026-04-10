---
type: concept
title: 代数 / Algebra (Free Groups etc.)
chapter: 6
section: 11
tags: [free-group, monoid, algebra, HITs, group-presentation]
references:
  - "[[10_quotients]]"
---

# 代数 / Free Algebraic Structures

## 自由幺半群 / Free Monoid

自由幺半群即列表类型 $\mathsf{List}(A)$，由 $\mathsf{nil}$ 和 $\mathsf{cons}$ 生成，运算为列表连接。

## 自由群 / Free Group

$\mathsf{F}(A)$ 是高阶归纳类型，包含：
- $\eta : A \to \mathsf{F}(A)$
- 群运算 $m$, 单位元 $e$, 逆元 $i$
- 群公理（结合律、单位律、逆元律）的路径构造子
- 0-截断构造子

**定理.** $\mathsf{F}(A)$ 是 $A$ 上的自由群：$\mathsf{Hom}_\mathsf{Group}(\mathsf{F}(A), G) \simeq (A \to G)$。

### 意义 / Significance

我们无需给出自由群的显式构造，只需写下它应满足的泛性质。这是类型论的强大之处。

## 显式构造 / Explicit Construction

$\mathsf{F}'(A) \equiv \mathsf{List}(A + A) / {\sim}$，其中关系消去相邻的 $a, \hat{a}$ 对。当 $A$ 有可判定相等时，自由群可用化简字描述。

特别地，$\mathsf{F}(\mathbf{1}) \simeq \mathbb{Z}$。

## 群的余极限 / Colimits of Groups

用类似方法构造**合并自由积** $H *_G K$（群范畴中的推出）。

## 群表示 / Group Presentations

给定生成元 $A$ 和关系 $R \rightrightarrows \mathsf{F}(A)$，群表示是 $\mathsf{F}(R) \rightrightarrows \mathsf{F}(A)$ 的余等化子。

## 参考文献 / References

- HoTT Book, Section 6.11
