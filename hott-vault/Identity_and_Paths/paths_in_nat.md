---
type: theorem
title: "Natural Numbers / 自然数"
chapter: 2
section: 13
tags: [natural-numbers, encode-decode, code, successor, injectivity]
references:
  - "[[paths_in_coproducts]]"
  - "[[transport]]"
  - "[[paths_in_unit]]"
---

# Natural Numbers / 自然数

## 概述 / Overview

使用编码-解码方法来刻画自然数的路径空间。与余积不同的是，这里同时刻画双边路径空间。

---

## $\mathsf{code}$ 函数 / The $\mathsf{code}$ Function

$$\mathsf{code} : \mathbb{N} \to \mathbb{N} \to \mathcal{U}$$

通过对 $\mathbb{N}$ 的双重递归定义：

$$\mathsf{code}(0, 0) :\equiv \mathbf{1}$$
$$\mathsf{code}(\mathsf{succ}(m), 0) :\equiv \mathbf{0}$$
$$\mathsf{code}(0, \mathsf{succ}(n)) :\equiv \mathbf{0}$$
$$\mathsf{code}(\mathsf{succ}(m), \mathsf{succ}(n)) :\equiv \mathsf{code}(m, n)$$

还定义依赖函数 $r : \prod_{n:\mathbb{N}} \mathsf{code}(n, n)$：

$$r(0) :\equiv \star$$
$$r(\mathsf{succ}(n)) :\equiv r(n)$$

---

## 主要定理 / Main Theorem

### Theorem 2.13.1

对所有 $m, n : \mathbb{N}$：

$$\boxed{(m = n) \simeq \mathsf{code}(m, n)}$$

**证明**:

**编码 / Encode**: $\mathsf{encode}(m, n, p) :\equiv \mathsf{transport}^{\mathsf{code}(m, -)}(p, r(m))$

**解码 / Decode**: 通过对 $m, n$ 的双重归纳：
- $m \equiv 0, n \equiv 0$: $\mathbf{1} \to (0 = 0)$，映所有东西到 $\mathsf{refl}_0$
- $m$ 是后继而 $n \equiv 0$（或反之）：域是 $\mathbf{0}$，由空类型消去
- $m \equiv \mathsf{succ}(m'), n \equiv \mathsf{succ}(n')$：复合 $\mathsf{code}(m', n') \xrightarrow{\mathsf{decode}(m', n')} (m' = n') \xrightarrow{\mathsf{ap}_{\mathsf{succ}}} (\mathsf{succ}(m') = \mathsf{succ}(n'))$

**互逆性**通过路径归纳和双重归纳证明。

---

## 推论 / Corollaries

### 0 不是任何数的后继 / Zero is not a successor

$$\mathsf{encode}(\mathsf{succ}(m), 0) : (\mathsf{succ}(m) = 0) \to \mathbf{0}$$

### 后继函数是单射 / Successor is injective

复合映射：

$$(\mathsf{succ}(m) = \mathsf{succ}(n)) \xrightarrow{\mathsf{encode}} \mathsf{code}(\mathsf{succ}(m), \mathsf{succ}(n)) \equiv \mathsf{code}(m, n) \xrightarrow{\mathsf{decode}} (m = n)$$

---

## 与余积的类比 / Analogy with Coproducts

$\mathbb{N}$ 作为正类型，其路径空间的刻画使用了与余积相同的编码-解码方法。同样的技术在后续章节中用于计算球面的同伦群。

---

## 相关概念 / Related Concepts

- [[paths_in_coproducts|Coproducts / 余积]] -- 使用相同方法
- [[paths_in_unit|Unit Type / 单元类型]]

---

## 参考文献 / References

- HoTT Book, Section 2.13: Natural numbers

---

## Lean 4

```lean
-- succ is injective
#check @Nat.succ_injective  -- succ m = succ n → m = n

-- 0 ≠ succ n
example (n : Nat) : ¬ (0 = n + 1) := Nat.noConfusion
```
