---
type: theorem
title: "Coproducts / 余积"
chapter: 2
section: 12
tags: [coproduct, encode-decode, code, positive-type, disjointness, injectivity]
references:
  - "[[identity_type]]"
  - "[[paths_in_nat]]"
  - "[[transport]]"
---

# Coproducts / 余积

## 概述 / Overview

余积类型 $A + B$ 是我们遇到的第一个**正类型** (positive type)。正类型由构造子"呈现"，其消去规则表达呈现的泛性质。对于正类型，不总能直接刻画恒等类型，但在许多情况下可以通过**编码-解码方法** (encode-decode method) 实现。

---

## 期望结果 / Expected Results

直觉上 $A + B$ 包含 $A$ 和 $B$ 的不相交精确副本，故期望：

- $(\mathsf{inl}(a_1) = \mathsf{inl}(a_2)) \simeq (a_1 = a_2)$ (inl 是单射)
- $(\mathsf{inr}(b_1) = \mathsf{inr}(b_2)) \simeq (b_1 = b_2)$ (inr 是单射)
- $(\mathsf{inl}(a) = \mathsf{inr}(b)) \simeq \mathbf{0}$ (像不相交)

---

## $\mathsf{code}$ 函数方法 / The $\mathsf{code}$ Function Approach

固定 $a_0 : A$，定义类型族 $\mathsf{code} : A + B \to \mathcal{U}$：

$$\mathsf{code}(\mathsf{inl}(a)) :\equiv (a_0 = a)$$
$$\mathsf{code}(\mathsf{inr}(b)) :\equiv \mathbf{0}$$

关键洞察：可以使用 $A + B$ 的递归原理来**定义** $\mathsf{code}$。

---

## 主要定理 / Main Theorem

### Theorem 2.12.5

对所有 $x : A + B$：

$$(\mathsf{inl}(a_0) = x) \simeq \mathsf{code}(x)$$

**证明 (编码-解码方法)**:

1. **编码 / Encode**: $\mathsf{encode}(x, p) :\equiv \mathsf{transport}^{\mathsf{code}}(p, \mathsf{refl}_{a_0})$

2. **解码 / Decode**: 对 $x$ 做余积消去
   - 若 $x \equiv \mathsf{inl}(a)$：$\mathsf{code}(x) \equiv (a_0 = a)$，取 $c \mapsto \mathsf{ap}_{\mathsf{inl}}(c)$
   - 若 $x \equiv \mathsf{inr}(b)$：$\mathsf{code}(x) \equiv \mathbf{0}$，由空类型消去

3. **互逆性**:
   - $\mathsf{decode}(x, \mathsf{encode}(x, p)) = p$：通过（基）路径归纳
   - $\mathsf{encode}(x, \mathsf{decode}(x, c)) = c$：分情况讨论

---

## 推论 / Corollaries

- **不相交性 / Disjointness**: $\mathsf{encode}(\mathsf{inr}(b), -) : (\mathsf{inl}(a_0) = \mathsf{inr}(b)) \to \mathbf{0}$，即 $\mathsf{inl}(a_0) \neq \mathsf{inr}(b)$
- **单射性 / Injectivity**: $\mathsf{encode}(\mathsf{inl}(a), -) : (\mathsf{inl}(a_0) = \mathsf{inl}(a)) \to (a_0 = a)$

特别地，因为 $\mathbf{2} \simeq \mathbf{1} + \mathbf{1}$，我们有 $\mathsf{false} \neq \mathsf{true}$。

---

## 余积类型族中的传输 / Transport in Coproduct Type Families

给定 $A, B : X \to \mathcal{U}$，$p : x_1 = x_2$：

$$\mathsf{transport}^{A + B}(p, \mathsf{inl}(a)) = \mathsf{inl}(\mathsf{transport}^A(p, a))$$
$$\mathsf{transport}^{A + B}(p, \mathsf{inr}(b)) = \mathsf{inr}(\mathsf{transport}^B(p, b))$$

---

## 编码-解码方法 / Encode-Decode Method

这是一种描述路径空间的通用方法：

1. 定义一个比较纤维化 $\mathsf{code}$，给出路径的更显式描述
2. 定义 $\mathsf{encode}$（通常通过传输 $\mathsf{refl}$）
3. 为所有纤维的实例一般性地定义 $\mathsf{decode}$（关键：使得路径归纳可用于分析 $\mathsf{decode} \circ \mathsf{encode}$）
4. 证明互逆性

这一方法在后续章节中用于计算球面的同伦群。

---

## 相关概念 / Related Concepts

- [[paths_in_nat|Natural Numbers / 自然数]]
- [[transport|Transport / 传输]]

---

## 参考文献 / References

- HoTT Book, Section 2.12: Coproducts

---

## Lean 4

```lean
-- inl ≠ inr (different constructors are never equal)
-- In Lean: Sum.noConfusion or Nat.noConfusion
example : ¬ (Sum.inl 0 = Sum.inr "hi") := Sum.noConfusion
```
