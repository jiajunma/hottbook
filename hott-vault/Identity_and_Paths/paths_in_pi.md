---
type: theorem
title: "Π-types and Function Extensionality / Π-类型与函数外延性公理"
chapter: 2
section: 9
tags: [pi-type, function-extensionality, funext, happly, pointwise, axiom]
references:
  - "[[00_MOC]]"
  - "[[Equivalences/homotopy]]"
  - "[[Axioms/function_extensionality]]"
  - "[[Axioms/univalence]]"
---

# Π-types and Function Extensionality / Π-类型与函数外延性公理

## Π-类型中的路径 / Paths in Π-types

给定类型 $A$ 和类型族 $B : A \to \mathcal{U}$，我们期望 $\prod_{x:A} B(x)$ 中从 $f$ 到 $g$ 的路径等价于逐点路径：

$$(f = g) \simeq \prod_{x:A} (f(x) =_{B(x)} g(x))$$

但 Chapter 1 的类型论**不足以**证明这一点。

---

## $\mathsf{happly}$ 函数 / The $\mathsf{happly}$ Function

存在一个通过路径归纳容易定义的函数：

$$\mathsf{happly} : (f = g) \to \prod_{x:A} (f(x) = g(x))$$

---

## 函数外延性公理 / Function Extensionality Axiom

### Axiom 2.9.3

对于任何 $A$, $B$, $f$, $g$，函数 $\mathsf{happly}$ 是等价。

> **Axiom (Function extensionality)**: For any $A$, $B$, $f$, and $g$, the function $\mathsf{happly}$ is an equivalence.

特别地，$\mathsf{happly}$ 有拟逆：

$$\mathsf{funext} : \left(\prod_{x:A} (f(x) = g(x))\right) \to (f = g)$$

---

## 引入/消去/计算/唯一性 / Introduction/Elimination/Computation/Uniqueness

| 角色 | 操作 |
|---|---|
| **引入规则** | $\mathsf{funext}$ |
| **消去规则** | $\mathsf{happly}$ |
| **命题计算规则** | $\mathsf{happly}(\mathsf{funext}(h), x) = h(x)$ |
| **命题唯一性原则** | $p = \mathsf{funext}(x \mapsto \mathsf{happly}(p, x))$ |

---

## 逐点操作 / Pointwise Operations

Π-类型中的恒等、逆、复合都逐点给出：

$$\mathsf{refl}_f = \mathsf{funext}(x \mapsto \mathsf{refl}_{f(x)})$$

$$\alpha^{-1} = \mathsf{funext}(x \mapsto \mathsf{happly}(\alpha, x)^{-1})$$

$$\alpha \cdot \beta = \mathsf{funext}(x \mapsto \mathsf{happly}(\alpha, x) \cdot \mathsf{happly}(\beta, x))$$

---

## 函数类型中的传输 / Transport in Function Types

给定 $X$，$p : x_1 =_X x_2$，类型族 $A, B : X \to \mathcal{U}$，函数 $f : A(x_1) \to B(x_1)$：

$$\mathsf{transport}^{A \to B}(p, f) = \big(x \mapsto \mathsf{transport}^B(p, f(\mathsf{transport}^A(p^{-1}, x)))\big)$$

即：将参数反向传输，应用 $f$，再正向传输结果。

---

## 依赖路径的等价刻画 / Equivalent Characterization of Dependent Paths

### Lemma 2.9.6

给定类型族 $A, B : X \to \mathcal{U}$，$p : x = y$，$f : A(x) \to B(x)$，$g : A(y) \to B(y)$：

$$(\mathsf{transport}^{A \to B}(p, f) = g) \simeq \prod_{a : A(x)} (\mathsf{transport}^B(p, f(a)) = g(\mathsf{transport}^A(p, a)))$$

---

## 与一致性的关系 / Relationship to Univalence

函数外延性可以从一致性公理推出（见 [[Axioms/univalence|Section 2.10]]）。也可以从区间类型推出。

---

## 相关概念 / Related Concepts

- [[Equivalences/homotopy|Homotopies / 同伦]]
- [[Axioms/function_extensionality|Function Extensionality (detail) / 函数外延性 (详述)]]
- [[Axioms/univalence|Univalence Axiom / 一致性公理]]

---

## 参考文献 / References

- HoTT Book, Section 2.9: Π-types and the function extensionality axiom

---

## Lean 4

```lean
-- Function extensionality
#check @funext   -- (∀ x, f x = g x) → f = g

example (f g : Nat → Nat) (h : ∀ x, f x = g x) : f = g := funext h
```
