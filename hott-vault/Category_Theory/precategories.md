---
type: section
title: 预范畴与范畴 / Precategories and Categories
chapter: 9
section: 9.1
tags: [category-theory, precategory, category, idtoiso]
references:
  - "[[00_Overview]]"
next:
  - "[[02_functors]]"
---

# 预范畴与范畴 / Precategories and Categories

## 预范畴 / Precategory

**定义**: 预范畴 $A$ 由以下组成:
1. 类型 $A_0$（**对象**）
2. 对每个 $a, b : A$，**集合** $\hom_A(a, b)$（态射）
3. 恒等态射 $1_a : \hom_A(a, a)$
4. 合成 $g \circ f : \hom_A(a, c)$
5. 单位律: $1_b \circ f = f$ 且 $f \circ 1_a = f$
6. 结合律: $h \circ (g \circ f) = (h \circ g) \circ f$

关键: $\hom$-类型限制为 **集合** (0-类型)。

## 同构 / Isomorphism

**定义**: 态射 $f : \hom_A(a, b)$ 是 **同构** 若存在 $g : \hom_A(b, a)$ 使得 $g \circ f = 1_a$ 且 $f \circ g = 1_b$。

**引理**: "f 是同构"是纯命题。因此 $a \cong b$ 是集合。

## idtoiso 映射

**引理 (idtoiso)**: 在预范畴中，$(a = b) \to (a \cong b)$。

## 范畴 / Category

**定义**: **范畴**是预范畴，使得对所有 $a, b : A$，
$$\mathsf{idtoiso}_{a,b} : (a = b) \to (a \cong b)$$
是等价。

**推论**: 在范畴中，$a \cong b$ 蕴涵 $a = b$。

**引理**: 范畴的对象类型是 1-类型。

## 例子 / Examples

- **$\mathsf{Set}$**: 对象为集合，态射为函数。一致性公理直接蕴涵 $\mathsf{Set}$ 是范畴。
- **预序 (preorder)**: $\hom$ 均为纯命题的预范畴。预序是范畴当且仅当它是偏序。

## 参考 / References

- HoTT Book, Section 9.1
