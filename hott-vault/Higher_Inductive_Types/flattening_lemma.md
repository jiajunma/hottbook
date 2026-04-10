---
type: theorem
title: 展平引理 / The Flattening Lemma
chapter: 6
section: 12
tags: [flattening-lemma, total-space, univalence, HITs]
references:
  - "[[04_circle_sphere]]"
  - "[[08_pushouts]]"
---

# 展平引理 / The Flattening Lemma

## 核心思想 / Core Idea

将高阶归纳类型与单值公理结合：若 $W$ 是 HIT，可用 $W$ 的递归原理定义类型族 $P : W \to \mathcal{U}$，路径构造子处需要 $\mathcal{U}$ 中的路径（由单值公理提供）。

## 示例 / Example

给定类型 $X$ 和自等价 $e : X \simeq X$，定义 $P : S^1 \to \mathcal{U}$：

$$P(\mathsf{base}) \equiv X, \qquad \mathsf{ap}_P(\mathsf{loop}) = \mathsf{ua}(e)$$

则 $\mathsf{transport}^P(\mathsf{loop}, u) = e(u)$。

## 展平引理 / The Flattening Lemma

设 $W$ 是余等化子（由 $\mathsf{cc} : A \to W$ 和 $\mathsf{pp} : \prod_{b:B}(\mathsf{cc}(f(b)) = \mathsf{cc}(g(b)))$ 生成），$P : W \to \mathcal{U}$ 由 $C : A \to \mathsf{Type}$ 和等价 $D : \prod_{b:B}(C(f(b)) \simeq C(g(b)))$ 递归定义。

设 $\widetilde{W}$ 由 $\mathsf{cc'} : \prod_{a:A} C(a) \to \widetilde{W}$ 和对应路径构造子生成，则：

$$\left(\sum_{x:W} P(x)\right) \simeq \widetilde{W}$$

范畴论地说，这表达了全空间 $\sum_{x:W} P(x)$ 作为 Grothendieck 构造的泛性质（松余极限）。

## 参考文献 / References

- HoTT Book, Section 6.12
