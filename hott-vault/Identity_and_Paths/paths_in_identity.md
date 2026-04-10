---
type: theorem
title: "Identity Type / 恒等类型的路径"
chapter: 2
section: 11
tags: [identity-type, paths-of-paths, transport, ap]
references:
  - "[[../02_Paths/00_path]]"
  - "[[../02_Paths/01_ap]]"
  - "[[../02_Paths/02_transport]]"
  - "[[../04_Transport_in_Type_Formers/01_product]]"
---

# Identity Type / 恒等类型的路径

## 概述 / Overview

恒等类型 $p =_{x =_A y} q$（路径之间的路径）没有独立的简单刻画——它取决于 $A$ 的恒等类型的具体形式。但如果我们已经知道 $x =_A y$ 的刻画，则 $p =_{x =_A y} q$ 也随之确定。

### Theorem 2.11.1

若 $f : A \to B$ 是等价，则对所有 $a, a' : A$：

$$\mathsf{ap}_f : (a =_A a') \to (f(a) =_B f(a'))$$

也是等价。

---

## 恒等类型的恒等类型的例子 / Examples

- 路径 $p = q$，其中 $p, q : w =_{A \times B} w'$，等价于一对路径：
  $$\mathsf{pr}_1^=(p) = \mathsf{pr}_1^=(q) \quad \text{和} \quad \mathsf{pr}_2^=(p) = \mathsf{pr}_2^=(q)$$

- 路径 $p = q$，其中 $p, q : f =_{\prod_{x:A} B(x)} g$，等价于同伦：
  $$\prod_{x:A} (\mathsf{happly}(p)(x) = \mathsf{happly}(q)(x))$$

---

## 路径族中的传输 / Transport in Families of Paths

### Lemma 2.11.2

对于 $A$ 和 $a : A$，$p : x_1 = x_2$：

- $\mathsf{transport}^{x \mapsto (a = x)}(p, q) = q \cdot p$ ，对 $q : a = x_1$
- $\mathsf{transport}^{x \mapsto (x = a)}(p, q) = p^{-1} \cdot q$ ，对 $q : x_1 = a$
- $\mathsf{transport}^{x \mapsto (x = x)}(p, q) = p^{-1} \cdot q \cdot p$ ，对 $q : x_1 = x_1$

即：
- 沿 $x \mapsto (a = x)$ 传输 = **后复合** (post-composition)
- 沿 $x \mapsto (x = a)$ 传输 = **逆变前复合** (contravariant pre-composition)

这些分别是协变和逆变 hom-函子 $\hom(a, -)$ 和 $\hom(-, a)$ 的函子性作用。

---

### Theorem 2.11.3 (一般形式)

对于 $f, g : A \to B$，$p : a = a'$，$q : f(a) = g(a)$：

$$\mathsf{transport}^{x \mapsto f(x) = g(x)}(p, q) = \mathsf{ap}_f(p)^{-1} \cdot q \cdot \mathsf{ap}_g(p)$$

### Theorem 2.11.4 (依赖版本)

设 $B : A \to \mathcal{U}$，$f, g : \prod_{x:A} B(x)$，$p : a = a'$，$q : f(a) =_{B(a)} g(a)$：

$$\mathsf{transport}^{x \mapsto f(x) =_{B(x)} g(x)}(p, q) = \mathsf{apd}_f(p)^{-1} \cdot \mathsf{ap}_{\mathsf{transport}^B(p)}(q) \cdot \mathsf{apd}_g(p)$$

---

### Theorem 2.11.5 (依赖路径的等价刻画)

对于 $p : a = a'$，$q : a = a$，$r : a' = a'$：

$$(p_*(q) = r) \simeq (q \cdot p = p \cdot r)$$

（其中传输沿类型族 $x \mapsto (x = x)$ 进行。）

---

## 相关概念 / Related Concepts

- [[../02_Paths/00_path|Path Operations / 路径操作]]
- [[../04_Transport_in_Type_Formers/01_product|Product Types / 积类型]]

---

## 参考文献 / References

- HoTT Book, Section 2.11: Identity type
