---
type: section
title: 圆的基本群 / π₁(S¹)
chapter: 8
section: 8.1
tags: [homotopy-theory, fundamental-group, circle, encode-decode, universal-cover]
references:
  - "[[00_Overview]]"
  - "[[../06_HITs/01_Circle]]"
next:
  - "[[02_connectedness_suspensions]]"
---

# $\pi_1(S^1) \cong \mathbb{Z}$

## 目标 / Goal

证明 $\Omega(S^1) \simeq \mathbb{Z}$，从而 $\pi_1(S^1) \cong \mathbb{Z}$ 且 $\pi_n(S^1) = 0$ (对 $n > 1$)。

## 万有覆盖 / Universal Cover

**定义**: 用圆的递归定义 $\mathsf{code} : S^1 \to \mathcal{U}$:

$$\mathsf{code}(\mathsf{base}) \defeq \mathbb{Z}, \qquad \mathsf{ap}_{\mathsf{code}}(\mathsf{loop}) = \mathsf{ua}(\mathsf{succ})$$

这是 $S^1$ 的 **万有覆盖 (universal cover)** 的类型论版本。绕圈一次对应后继函数。

**传输性质**:
- $\mathsf{transport}^{\mathsf{code}}(\mathsf{loop}, x) = x + 1$
- $\mathsf{transport}^{\mathsf{code}}(\overline{\mathsf{loop}}, x) = x - 1$

## 编码-解码证明 / Encode-Decode Proof

**编码 (encode)**: $\mathsf{encode} : \prod_{x:S^1} (\mathsf{base} = x) \to \mathsf{code}(x)$

$$\mathsf{encode}(p) \defeq \mathsf{transport}^{\mathsf{code}}(p, 0)$$

直觉: 沿路径在覆盖中传输，计算绕圈数 (**winding number**)。

**解码 (decode)**: $\mathsf{decode} : \prod_{x:S^1} \mathsf{code}(x) \to (\mathsf{base} = x)$

在 $\mathsf{base}$ 处: $\mathsf{decode}_{\mathsf{base}}(n) = \mathsf{loop}^n$

**互逆性**:
1. $\mathsf{decode}(\mathsf{encode}(p)) = p$ -- 路径归纳即可
2. $\mathsf{encode}(\mathsf{decode}(c)) = c$ -- 需要对 $S^1$ 归纳和对 $\mathbb{Z}$ 归纳

## 主要定理 / Main Theorems

**定理**: 存在等价族 $\prod_{x:S^1} (\mathsf{base} = x) \simeq \mathsf{code}(x)$

**推论**:
- $\Omega(S^1, \mathsf{base}) \simeq \mathbb{Z}$
- $\pi_1(S^1) \cong \mathbb{Z}$ (作为群)
- $\pi_n(S^1) = 0$ 对 $n > 1$ (因为 $\mathbb{Z}$ 是集合)

## 同伦论证明 / Homotopy-Theoretic Proof

另一种证明: 证明覆盖的总空间 $\sum_{x:S^1} \mathsf{code}(x)$ 可缩（同伦论实数 $R$），路径纤维化的总空间也可缩，从而纤维等价。

**关键引理**: $\sum_{x:S^1} \mathsf{code}(x)$ 可缩。通过展平引理 (flattening lemma)，此类型等价于一个 HIT $R$（同伦论实数），具有构造器 $\mathsf{c} : \mathbb{Z} \to R$ 和路径 $\mathsf{p}_z : \mathsf{c}(z) = \mathsf{c}(z+1)$。

## 注记 / Remarks

- 一致性公理在此证明中 **不可或缺**: 没有它，$\pi_1(S^1)$ 可以是平凡的
- 编码-解码方法本质上是将万有覆盖的存在性和纤维等价性"打包"成直接计算

## 参考 / References

- HoTT Book, Section 8.1
