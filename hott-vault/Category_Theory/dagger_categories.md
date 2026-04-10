---
type: section
title: †-范畴 / Dagger Categories
chapter: 9
section: 9.7
tags: [category-theory, dagger-category, unitary]
references:
  - "[[06_strict_categories]]"
next:
  - "[[08_structure_identity]]"
---

# $\dagger$-范畴 / Dagger Categories

## $\dagger$-预范畴 / $\dagger$-Precategory

**定义**: $\dagger$-预范畴是预范畴 $A$ 加上:
1. $\dagger : \hom_A(x,y) \to \hom_A(y,x)$
2. $\dagger(1_x) = 1_x$
3. $\dagger(g \circ f) = \dagger f \circ \dagger g$
4. $\dagger(\dagger f) = f$

## 酉态射 / Unitary Morphisms

**定义**: $f$ 是 **酉的 (unitary)** 若 $\dagger f \circ f = 1_x$ 且 $f \circ \dagger f = 1_y$。

酉态射一定是同构，且酉性是纯命题。

## $\dagger$-范畴 / $\dagger$-Category

**定义**: $\dagger$-范畴是 $\dagger$-预范畴，使得 $(x = y) \to (x \cong_{\mathsf{unitary}} y)$ 是等价。

## 例子 / Examples

- **$\mathsf{Rel}$**: 关系范畴，$\dagger R(y,x) \defeq R(x,y)$
- **群胚**: $\dagger f \defeq f^{-1}$
- **$\mathsf{Hilb}$** (有限维内积空间): $\dagger$ 为伴随映射。酉同构 = 等距。$\mathsf{Hilb}$ 是 $\dagger$-范畴但不是范畴（并非每个线性同构都是酉的）。

HoTT 将 $\dagger$-范畴和严格范畴统一归为预范畴的不同变体。

## 参考 / References

- HoTT Book, Section 9.7
