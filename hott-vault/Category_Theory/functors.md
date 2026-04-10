---
type: section
title: 函子与自然变换 / Functors and Natural Transformations
chapter: 9
section: 9.2
tags: [category-theory, functor, natural-transformation, functor-category]
references:
  - "[[01_precategories]]"
next:
  - "[[03_adjunctions]]"
---

# 函子与自然变换 / Functors and Natural Transformations

## 函子 / Functor

**定义**: 函子 $F : A \to B$（预范畴之间）由以下组成:
1. 函数 $F_0 : A_0 \to B_0$
2. 对每个 $a, b$，函数 $F_{a,b} : \hom_A(a,b) \to \hom_B(Fa, Fb)$
3. $F(1_a) = 1_{Fa}$
4. $F(g \circ f) = Fg \circ Ff$

## 自然变换 / Natural Transformation

**定义**: 对函子 $F, G : A \to B$，自然变换 $\gamma : F \to G$ 由以下组成:
1. 分量: 对每个 $a : A$，$\gamma_a : \hom_B(Fa, Ga)$
2. 自然性: $Gf \circ \gamma_a = \gamma_b \circ Ff$

自然性是纯命题（因为 $\hom$-集合是集合），故自然变换的相等由分量决定。

## 函子预范畴 / Functor Precategory

**定义**: $B^A$ 的对象是函子 $A \to B$，态射是自然变换。

**引理**: $\gamma : F \to G$ 是 $B^A$ 中的同构当且仅当每个 $\gamma_a$ 是 $B$ 中的同构。

**定理**: 若 $A$ 是预范畴，$B$ 是范畴，则 $B^A$ 是范畴。

特别地，范畴之间自然同构的函子是相等的。

## 合成 / Composition

- 函子合成 $G \circ F$
- 水平合成（whiskering）: $\gamma F$ 和 $K\gamma$
- 交换律: $(\delta G)(H\gamma) = (K\gamma)(\delta F)$
- 函子合成满足结合律（非定义上的），且满足 Mac Lane 五边形一致性

## 参考 / References

- HoTT Book, Section 9.2
