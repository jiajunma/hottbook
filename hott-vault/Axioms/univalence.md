---
type: axiom
title: "Universes and the Univalence Axiom / 宇宙与一致性公理"
chapter: 2
section: 10
tags: [axiom, univalence, ua, idtoeqv, universe, equivalence]
references:
  - "[[01_function_extensionality]]"
  - "[[../03_Equivalences/00_homotopy]]"
  - "[[../06_Examples/00_equality_of_structures]]"
---

# Universes and the Univalence Axiom / 宇宙与一致性公理

## $\mathsf{idtoeqv}$ 函数 / The $\mathsf{idtoeqv}$ Function

### Lemma 2.10.1

对于类型 $A, B : \mathcal{U}$，存在函数：

$$\mathsf{idtoeqv} : (A =_\mathcal{U} B) \to (A \simeq B)$$

**构造**: 将恒等函数 $\mathsf{id}_\mathcal{U} : \mathcal{U} \to \mathcal{U}$ 视为以宇宙 $\mathcal{U}$ 为索引的类型族（将每个类型 $X$ 映射到类型 $X$ 本身）。给定路径 $p : A =_\mathcal{U} B$，传输函数 $\mathsf{transport}^{X \mapsto X}(p, -) : A \to B$ 是等价（通过对 $p$ 归纳，归结为 $\mathsf{id}_A$ 是等价）。

---

## 一致性公理 / The Univalence Axiom

### Axiom 2.10.3 (Univalence)

对于任何 $A, B : \mathcal{U}$，函数 $\mathsf{idtoeqv}$ 是等价。

> **Axiom (Univalence)**: For any $A, B : \mathcal{U}$, the function $\mathsf{idtoeqv}$ is an equivalence.

特别地：

$$\boxed{(A =_\mathcal{U} B) \simeq (A \simeq B)}$$

若宇宙 $\mathcal{U}$ 满足此公理，称其为**一致的** (univalent)。

---

## 引入/消去/计算/唯一性 / Introduction/Elimination/Computation/Uniqueness

| 角色 | 操作 |
|---|---|
| **引入规则** | $\mathsf{ua} : (A \simeq B) \to (A =_\mathcal{U} B)$ |
| **消去规则** | $\mathsf{idtoeqv} \equiv \mathsf{transport}^{X \mapsto X} : (A =_\mathcal{U} B) \to (A \simeq B)$ |
| **命题计算规则** | $\mathsf{transport}^{X \mapsto X}(\mathsf{ua}(f), x) = f(x)$ |
| **命题唯一性原则** | 对任何 $p : A = B$，$p = \mathsf{ua}(\mathsf{transport}^{X \mapsto X}(p))$ |

---

## 宇宙中等式的高维结构 / Higher Structure of Equalities in the Universe

$$\mathsf{refl}_A = \mathsf{ua}(\mathsf{id}_A)$$

$$\mathsf{ua}(f) \cdot \mathsf{ua}(g) = \mathsf{ua}(g \circ f)$$

$$\mathsf{ua}(f)^{-1} = \mathsf{ua}(f^{-1})$$

---

## 传输即等价 / Transport in Universe = the Equivalence

### Lemma 2.10.5

对于类型族 $B : A \to \mathcal{U}$，$p : x = y$，$u : B(x)$：

$$\mathsf{transport}^B(p, u) = \mathsf{transport}^{X \mapsto X}(\mathsf{ap}_B(p), u) = \mathsf{idtoeqv}(\mathsf{ap}_B(p))(u)$$

这将类型族中的传输化为宇宙中路径所对应的等价的应用。

---

## 核心意义 / Core Significance

**等价的类型可以等同** (Equivalent types may be identified)。

一致性公理意味着：关于类型的所有性质和构造自动尊重等价。如果 $A \simeq B$，则在任何上下文中 $A$ 和 $B$ 可互换。这使得数学中常见的"符号滥用"——将同构的结构等同——变成形式上正确的。

---

## 重要备注 / Important Remark

一致性公理要求使用"好的"等价定义 $\mathsf{isequiv}(f)$（如双可逆 bi-invertible），而不是 $\mathsf{qinv}(f)$。

---

## 相关概念 / Related Concepts

- [[01_function_extensionality|Function Extensionality / 函数外延性]]
- [[../03_Equivalences/00_homotopy|Equivalences / 等价]]
- [[../06_Examples/00_equality_of_structures|Equality of Structures / 结构的等式]]

---

## 参考文献 / References

- HoTT Book, Section 2.10: Universes and the univalence axiom
