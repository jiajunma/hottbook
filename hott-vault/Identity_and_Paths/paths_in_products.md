---
type: theorem
title: "Cartesian Product Types / 笛卡尔积类型"
chapter: 2
section: 6
tags: [product-type, path, pairpath, transport, ap]
references:
  - "[[00_MOC]]"
  - "[[paths_in_sigma]]"
  - "[[ap]]"
  - "[[transport]]"
---

# Cartesian Product Types / 笛卡尔积类型

## 积类型中的路径 / Paths in Product Types

### Theorem 2.6.2

对于任意 $x, y : A \times B$，以下函数是等价：

$$\mathsf{pr}_1 \times \mathsf{pr}_2 : (x =_{A \times B} y) \to (\mathsf{pr}_1(x) = \mathsf{pr}_1(y)) \times (\mathsf{pr}_2(x) = \mathsf{pr}_2(y))$$

即：

$$\boxed{(x =_{A \times B} y) \simeq (\mathsf{pr}_1(x) = \mathsf{pr}_1(y)) \times (\mathsf{pr}_2(x) = \mathsf{pr}_2(y))}$$

> Two pairs are equal just when their components are equal. Categorically, morphisms in a product groupoid are pairs of morphisms. Homotopically, paths in a product space are pairs of paths.

**逆函数** $\mathsf{pair}^=$：给定 $p : \mathsf{pr}_1(x) = \mathsf{pr}_1(y)$ 和 $q : \mathsf{pr}_2(x) = \mathsf{pr}_2(y)$，得到 $(x = y)$。

---

## 命题唯一性原则 / Propositional Uniqueness Principle

作为特例：对任意 $z : A \times B$，

$$z = (\mathsf{pr}_1(z), \mathsf{pr}_2(z))$$

---

## 高维结构 / Higher Groupoid Structure

积类型中的反射性、逆、复合都是逐分量的：

$$\mathsf{refl}_{(z : A \times B)} = \mathsf{pair}^=(\mathsf{refl}_{\mathsf{pr}_1(z)}, \mathsf{refl}_{\mathsf{pr}_2(z)})$$

$$p^{-1} = \mathsf{pair}^=(\mathsf{pr}_1^=(p)^{-1}, \mathsf{pr}_2^=(p)^{-1})$$

$$p \cdot q = \mathsf{pair}^=(\mathsf{pr}_1^=(p) \cdot \mathsf{pr}_1^=(q), \mathsf{pr}_2^=(p) \cdot \mathsf{pr}_2^=(q))$$

---

## 积类型族中的传输 / Transport in Product Type Families

### Theorem 2.6.4

给定类型族 $A, B : Z \to \mathcal{U}$，$p : z =_Z w$，$x : A(z) \times B(z)$：

$$\mathsf{transport}^{A \times B}(p, x) = (\mathsf{transport}^A(p, \mathsf{pr}_1(x)),\; \mathsf{transport}^B(p, \mathsf{pr}_2(x)))$$

即传输逐分量进行。

---

## $\mathsf{ap}$ 的函子性 / Functoriality of $\mathsf{ap}$

### Theorem 2.6.5

给定 $g : A \to A'$，$h : B \to B'$，定义 $f : A \times B \to A' \times B'$ 为 $f(x) :\equiv (g(\mathsf{pr}_1(x)), h(\mathsf{pr}_2(x)))$。则对于 $p : \mathsf{pr}_1(x) = \mathsf{pr}_1(y)$，$q : \mathsf{pr}_2(x) = \mathsf{pr}_2(y)$：

$$\mathsf{ap}_f(\mathsf{pair}^=(p, q)) = \mathsf{pair}^=(\mathsf{ap}_g(p), \mathsf{ap}_h(q))$$

---

## 相关概念 / Related Concepts

- [[paths_in_sigma|Σ-types / Σ-类型]] -- 积类型的推广
- [[transport|Transport / 传输]]

---

## 参考文献 / References

- HoTT Book, Section 2.6: Cartesian product types

---

## Lean 4

```lean
-- Paths in products: componentwise
example (a b : α × β) : a = b ↔ (a.1 = b.1 ∧ a.2 = b.2) := by
  constructor
  · intro h; exact ⟨congrArg Prod.fst h, congrArg Prod.snd h⟩
  · intro ⟨h1, h2⟩; exact Prod.ext h1 h2
```
