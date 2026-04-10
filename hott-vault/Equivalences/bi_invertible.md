---
type: definition
title: 双可逆映射 / Bi-Invertible Maps
chapter: 4
section: 3
tags: [bi-invertible, linv, rinv, equivalence, mere-proposition]
references:
  - "[[00_Overview]]"
  - "[[01_quasi_inverses]]"
  - "[[02_half_adjoint_equivalences]]"
---

# 双可逆映射 / Bi-Invertible Maps

## 定义 / Definition

函数 $f : A \to B$ 是**双可逆的 (bi-invertible)** 如果它同时有左逆和右逆：

$$\mathsf{biinv}(f) \defeq \mathsf{linv}(f) \times \mathsf{rinv}(f)$$

其中：

$$\mathsf{linv}(f) \defeq \sum_{g:B \to A}(g \circ f \sim \mathsf{id}_A)$$
$$\mathsf{rinv}(f) \defeq \sum_{h:B \to A}(f \circ h \sim \mathsf{id}_B)$$

注意左逆 $g$ 和右逆 $h$ 不需要是同一个函数。

$f$ is bi-invertible if it has both a left inverse and a right inverse (not necessarily the same).

## 为什么是纯命题 / Why It Is a Mere Proposition

> **$\mathsf{biinv}(f)$ 是纯命题。**

关键在于：

1. 若 $f$ 有左逆且有右逆，则 $f$ 有拟逆（$g = h$ 可以证明）
2. 一旦 $f$ 是等价，$\mathsf{linv}(f)$ 和 $\mathsf{rinv}(f)$ 各自都是可缩的
3. 可缩类型的积仍是可缩的，故 $\mathsf{biinv}(f)$ 是可缩的（从而是纯命题）

直觉：分别要求左逆和右逆，每个条件独立地"多余到可缩"，它们的积也可缩。

## 与其他定义的等价 / Equivalence with Other Definitions

$$\mathsf{biinv}(f) \simeq \mathsf{ishae}(f) \simeq \prod_{y:B}\mathsf{isContr}(\mathsf{fib}_f(y))$$

所有三种定义互相等价，且都是纯命题。

## 优势 / Advantages

$\mathsf{biinv}$ 的定义在实践中有时更方便：
- 不需要记住一致性条件（不像 $\mathsf{ishae}$）
- 只需要分别构造左逆和右逆
- 纯命题性的证明比 $\mathsf{ishae}$ 更直接

## 相关概念 / Related Concepts

- [[01_quasi_inverses|拟逆]] - 不是纯命题
- [[02_half_adjoint_equivalences|半伴随等价]] - 通过一致性条件
- [[04_contractible_fibers|可缩纤维]] - Voevodsky 定义

## 参考文献 / References

- HoTT Book, Section 4.3: Bi-invertible maps
