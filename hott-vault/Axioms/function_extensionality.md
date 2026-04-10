---
type: axiom
title: "Function Extensionality / 函数外延性"
chapter: 2
section: 9
tags: [axiom, function-extensionality, funext, happly]
references:
  - "[[../04_Transport_in_Type_Formers/04_pi]]"
  - "[[02_univalence]]"
  - "[[../03_Equivalences/00_homotopy]]"
---

# Function Extensionality / 函数外延性

## 公理陈述 / Axiom Statement

### Axiom 2.9.3 (Function Extensionality)

对于任何类型 $A$，类型族 $B : A \to \mathcal{U}$，及函数 $f, g : \prod_{x:A} B(x)$，以下函数是等价：

$$\mathsf{happly} : (f = g) \to \prod_{x:A} (f(x) = g(x))$$

> For any $A$, $B$, $f$, and $g$, the function $\mathsf{happly}$ is an equivalence.

---

## 直觉 / Intuition

| 视角 | 解读 |
|---|---|
| 传统 | 逐点相等的函数是相等的 |
| 拓扑 | 函数空间中的路径等于连续同伦 |
| 范畴 | 函子范畴中的同构是自然同构族 |

---

## $\mathsf{funext}$ 与 $\mathsf{happly}$

函数外延性公理等价于 $\mathsf{happly}$ 有拟逆 $\mathsf{funext}$：

$$\mathsf{funext} : \left(\prod_{x:A} f(x) = g(x)\right) \to (f = g)$$

它们之间的关系：

- $\mathsf{happly}(\mathsf{funext}(h), x) = h(x)$ (计算规则)
- $p = \mathsf{funext}(x \mapsto \mathsf{happly}(p, x))$ (唯一性原则)

---

## 为什么需要公理？ / Why an Axiom?

Chapter 1 中的恒等类型由归纳原理统一定义，不能对不同类型"重新定义"。对于 $\Pi$-类型，仅依靠归纳原理只能构造 $\mathsf{happly}$（一个方向），不能证明它是等价。

---

## 从一致性推出 / Derivability from Univalence

函数外延性可以从 [[02_univalence|一致性公理]] 推出。也可以从区间类型推出。

更强地，Voevodsky 证明了：即使只假设存在 $\mathsf{funext}$（不要求与 $\mathsf{happly}$ 有任何关系），也足以推出完整的函数外延性公理。

---

## 相关概念 / Related Concepts

- [[../04_Transport_in_Type_Formers/04_pi|Π-types / Π-类型]]
- [[02_univalence|Univalence Axiom / 一致性公理]]
- [[../03_Equivalences/00_homotopy|Homotopies / 同伦]]

---

## 参考文献 / References

- HoTT Book, Section 2.9: Π-types and the function extensionality axiom
- HoTT Book, Section 4.9: Univalence implies function extensionality
