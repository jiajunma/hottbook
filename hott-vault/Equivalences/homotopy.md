---
type: definition
title: "Homotopies and Equivalences / 同伦与等价"
chapter: 2
section: 4
tags: [homotopy, equivalence, quasi-inverse, isequiv, natural-transformation]
references:
  - "[[../02_Paths/00_path]]"
  - "[[../02_Paths/01_ap]]"
  - "[[../04_Axioms/02_univalence]]"
---

# Homotopies and Equivalences / 同伦与等价

## 同伦 / Homotopy

### Definition 2.4.1

设 $f, g : \prod_{x:A} P(x)$ 是类型族 $P : A \to \mathcal{U}$ 的两个截面。从 $f$ 到 $g$ 的**同伦** (homotopy) 是如下类型的依赖函数：

$$(f \sim g) \defeq \prod_{x:A} (f(x) = g(x))$$

> A **homotopy** from $f$ to $g$ is a dependent function of type $(f \sim g) \defeq \prod_{x:A} (f(x) = g(x))$.

**注意**: 同伦 $f \sim g$ 与恒等 $f = g$ 不同。在 [[../04_Transport_in_Type_Formers/04_pi|Section 2.9]] 中引入的函数外延性公理将使它们"等价"。

---

### Lemma 2.4.2: 同伦是等价关系 / Homotopy is an Equivalence Relation

同伦在每个依赖函数类型 $\prod_{x:A} P(x)$ 上是等价关系：

- **自反性 / Reflexivity**: $\prod_{f} (f \sim f)$
- **对称性 / Symmetry**: $(f \sim g) \to (g \sim f)$
- **传递性 / Transitivity**: $(f \sim g) \to (g \sim h) \to (f \sim h)$

---

### Lemma 2.4.3: 同伦的自然性 / Naturality of Homotopies

设 $H : f \sim g$ 是函数 $f, g : A \to B$ 之间的同伦，$p : x =_A y$。则：

$$H(x) \cdot \mathsf{ap}_g(p) = \mathsf{ap}_f(p) \cdot H(y)$$

可画为交换图：

$$\begin{array}{ccc}
f(x) & \xrightarrow{\mathsf{ap}_f(p)} & f(y) \\
\downarrow H(x) & & \downarrow H(y) \\
g(x) & \xrightarrow{\mathsf{ap}_g(p)} & g(y)
\end{array}$$

这说明同伦类型论中的同伦自动是"自然变换"。

### Corollary 2.4.4

设 $H : f \sim \mathsf{id}_A$，则对任何 $x : A$：

$$H(f(x)) = \mathsf{ap}_f(H(x))$$

---

## 拟逆 / Quasi-inverse

### Definition 2.4.6

对于函数 $f : A \to B$，$f$ 的一个**拟逆** (quasi-inverse) 是三元组 $(g, \alpha, \beta)$，其中：
- $g : B \to A$
- $\alpha : f \circ g \sim \mathsf{id}_B$
- $\beta : g \circ f \sim \mathsf{id}_A$

拟逆的类型记为 $\mathsf{qinv}(f)$。

### 例子 / Examples

- 恒等函数 $\mathsf{id}_A$ 的拟逆是 $\mathsf{id}_A$ 自身
- 对于 $p : x =_A y$，函数 $(p \cdot -) : (y = z) \to (x = z)$ 的拟逆是 $(p^{-1} \cdot -)$
- 传输 $\mathsf{transport}^P(p, -) : P(x) \to P(y)$ 的拟逆是 $\mathsf{transport}^P(p^{-1}, -)$

---

## 等价 / Equivalence

$\mathsf{qinv}(f)$ 作为等价的定义"表现不好"（对于单个 $f$，可能有多个不相等的 inhabitant）。因此使用改进的定义 $\mathsf{isequiv}(f)$，满足：

1. $\mathsf{qinv}(f) \to \mathsf{isequiv}(f)$
2. $\mathsf{isequiv}(f) \to \mathsf{qinv}(f)$
3. 对于任何两个 $e_1, e_2 : \mathsf{isequiv}(f)$，有 $e_1 = e_2$

一种满足这些性质的定义是**双可逆** (bi-invertible)：

$$\mathsf{isequiv}(f) \defeq \left(\sum_{g:B \to A} (f \circ g \sim \mathsf{id}_B)\right) \times \left(\sum_{h:B \to A} (h \circ f \sim \mathsf{id}_A)\right)$$

### 等价类型 / The Type of Equivalences

$$A \simeq B \defeq \sum_{f : A \to B} \mathsf{isequiv}(f)$$

---

## 等价是等价关系 / Equivalence is an Equivalence Relation

### Lemma 2.4.12

1. 对于任何 $A$，恒等函数 $\mathsf{id}_A$ 是等价；故 $A \simeq A$
2. 对于任何 $f : A \simeq B$，有 $f^{-1} : B \simeq A$
3. 对于任何 $f : A \simeq B$ 和 $g : B \simeq C$，有 $g \circ f : A \simeq C$

---

## 相关概念 / Related Concepts

- [[../02_Paths/00_path|Path Operations / 路径操作]]
- [[../04_Transport_in_Type_Formers/04_pi|Function Extensionality / 函数外延性]]
- [[../04_Axioms/02_univalence|Univalence Axiom / 一致性公理]]

---

## 参考文献 / References

- HoTT Book, Section 2.4: Homotopies and equivalences
