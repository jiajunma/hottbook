---
type: definition
title: 半伴随等价 / Half Adjoint Equivalences
chapter: 4
section: 2
tags: [half-adjoint, ishae, equivalence, coherence, mere-proposition]
references:
  - "[[00_Overview]]"
  - "[[01_quasi_inverses]]"
  - "[[04_contractible_fibers]]"
  - "[[../03_Sets_and_Logic/03_mere_propositions]]"
---

# 半伴随等价 / Half Adjoint Equivalences

## 定义 / Definition

函数 $f : A \to B$ 是**半伴随等价 (half adjoint equivalence)** 如果存在：

$$\mathsf{ishae}(f) \defeq \sum_{g:B \to A}\sum_{\eta: g \circ f \sim \mathsf{id}_A}\sum_{\epsilon: f \circ g \sim \mathsf{id}_B} \prod_{x:A} \mathsf{ap}_f(\eta(x)) = \epsilon(f(x))$$

即拟逆数据 $(g, \eta, \epsilon)$ 加上一个**一致性条件 (coherence condition)**：

$$\mathsf{ap}_f(\eta(x)) = \epsilon(f(x))$$

The coherence condition says the two ways of identifying $f(g(f(x)))$ with $f(x)$ agree.

## 动机 / Motivation

回忆 [[01_quasi_inverses|$\mathsf{qinv}(f)$ 不是纯命题]]。$\mathsf{ishae}(f)$ 通过添加一个一致性条件来"修复"这个问题。

一致性条件要求：对于 $x : A$，下面的三角形交换：

$$f(g(f(x))) \xrightarrow{\epsilon(f(x))} f(x)$$
$$f(g(f(x))) \xrightarrow{\mathsf{ap}_f(\eta(x))} f(x)$$

## 关键定理 / Key Theorems

### ishae 是纯命题 / ishae is a mere proposition

$$\mathsf{isProp}(\mathsf{ishae}(f))$$

这是 $\mathsf{ishae}$ 优于 $\mathsf{qinv}$ 的关键优势。

### 与 qinv 的关系 / Relation to qinv

$$\mathsf{qinv}(f) \to \mathsf{ishae}(f)$$

每个拟逆都可以提升为半伴随等价（通过调整 $\epsilon$ 或 $\eta$ 以满足一致性条件）。反向也成立（遗忘一致性条件），因此：

$$\mathsf{qinv}(f) \simeq \mathsf{ishae}(f) \quad \text{(逻辑等价，但非类型等价)}$$

## 纤维刻画 / Fiber Characterization

$\mathsf{ishae}(f)$ 等价于所有纤维可缩：

$$\mathsf{ishae}(f) \simeq \prod_{y:B}\mathsf{isContr}(\mathsf{fib}_f(y))$$

其中 $\mathsf{fib}_f(y) \defeq \sum_{x:A}(f(x) = y)$。

详见 [[04_contractible_fibers|可缩纤维]]。

## 相关概念 / Related Concepts

- [[01_quasi_inverses|拟逆]] - 没有一致性条件
- [[03_bi_invertible_maps|双可逆映射]] - 另一种纯命题定义
- [[04_contractible_fibers|可缩纤维]] - 等价的第三种定义

## 参考文献 / References

- HoTT Book, Section 4.2: Half adjoint equivalences
