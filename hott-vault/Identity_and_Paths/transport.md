---
type: definition
title: "Type Families are Fibrations / 类型族是纤维化"
chapter: 2
section: 3
tags: [transport, fibration, path-lifting, apd, dependent-map, type-family]
references:
  - "[[path_operations]]"
  - "[[ap]]"
  - "[[Equivalences/homotopy]]"
  - "[[Transport_in_Type_Formers/overview]]"
---

# Type Families are Fibrations / 类型族是纤维化

## 传输 / Transport

### Lemma 2.3.1 (Transport)

设 $P$ 是 $A$ 上的类型族，$p : x =_A y$。则存在函数：

$$\mathsf{transport}^P(p, -) : P(x) \to P(y)$$

记作 $p_*(-)$ 或 $\mathsf{transport}^P(p, -)$。

> Suppose that $P$ is a type family over $A$ and that $p : x =_A y$. Then there is a function $\mathsf{transport}^P(p, -) : P(x) \to P(y)$.

**证明**: 通过路径归纳，只需处理 $p \equiv \mathsf{refl}_x$ 的情况，此时取 $\mathsf{transport}^P(\mathsf{refl}_x, -) : P(x) \to P(x)$ 为恒等函数。

## Lean 4

```lean
-- Transport: move data along a path
-- In Lean, this is subst / Eq.mpr / ▸
def myTransport (P : α → Sort u) (p : a = b) (u : P a) : P b :=
  p ▸ u

-- Example: transport along n = m converts Vec n to Vec m  
-- Path lifting is implicit in Lean's Sigma/Subtype handling
```

### 解读 / Interpretations

| 视角 | 传输的意义 |
|---|---|
| 逻辑 | 性质 $P$ 尊重等式：若 $x = y$ 且 $P(x)$ 成立，则 $P(y)$ 成立 |
| 拓扑 | 纤维化中的**路径提升** (path lifting)：沿 $p$ 将 $P(x)$ 中的点传输到 $P(y)$ |
| 范畴 | 纤维上的平行运输 (parallel transport) |

---

## 纤维化的观点 / Fibration Viewpoint

类型族 $P : A \to \mathcal{U}$ 被看作**纤维化** (fibration)：
- **底空间** (base space): $A$
- **纤维** (fiber) 在 $x$ 上: $P(x)$
- **全空间** (total space): $\sum_{x:A} P(x)$
- **投影**: $\mathsf{pr}_1 : \sum_{x:A} P(x) \to A$

---

## 路径提升性质 / Path Lifting Property

### Lemma 2.3.2

设 $P : A \to \mathcal{U}$，$u : P(x)$，$p : x = y$。则在 $\sum_{x:A} P(x)$ 中有：

$$\mathsf{lift}(u, p) : (x, u) = (y, p_*(u))$$

使得 $\mathsf{ap}_{\mathsf{pr}_1}(\mathsf{lift}(u, p)) = p$。

直觉上，这是在全空间中将路径 $p$ "提升"到从 $(x, u)$ 出发的路径。

---

## 依赖映射 / Dependent Map ($\mathsf{apd}$)

### Lemma 2.3.4

设 $f : \prod_{x:A} P(x)$，则有：

$$\mathsf{apd}_f : \prod_{p : x = y} (\mathsf{transport}^P(p, f(x)) =_{P(y)} f(y))$$

> Suppose $f : \prod_{x:A} P(x)$; then we have $\mathsf{apd}_f : \prod_{p : x = y} (p_*(f(x)) =_{P(y)} f(y))$.

**证明**: 通过路径归纳。当 $p \equiv \mathsf{refl}_x$ 时，$p_*(f(x)) \equiv f(x)$，取 $\mathsf{refl}_{f(x)}$ 即可。

### 直觉 / Intuition

$\mathsf{apd}_f(p)$ 是 $f$ "沿路径 $p$ 的依赖版本的作用"。它不是直接在 $P(x)$ 和 $P(y)$ 之间给出路径（因为它们可能是不同类型），而是先通过传输将 $f(x)$ 送到 $P(y)$ 中，再与 $f(y)$ 比较。

---

## $\mathsf{ap}$ 与 $\mathsf{apd}$ 的关系 / Relationship between $\mathsf{ap}$ and $\mathsf{apd}$

对于非依赖函数 $f : A \to B$（视为常类型族的截面），有：

$$\mathsf{apd}_f(p) = \mathsf{transportconst}^B(p, f(x)) \cdot \mathsf{ap}_f(p)$$

其中 $\mathsf{transportconst}$ 是常族中传输等于恒等的见证。

---

## 传输的基本性质 / Basic Properties of Transport

传输满足若干自然法则（可通过路径归纳证明）：

- **传输的复合 / Composition of transport**: $\mathsf{transport}^P(q, \mathsf{transport}^P(p, u)) = \mathsf{transport}^P(p \cdot q, u)$
- **传输沿 $\mathsf{ap}$ / Transport along $\mathsf{ap}$**: $\mathsf{transport}^{B \circ f}(p, u) = \mathsf{transport}^B(\mathsf{ap}_f(p), u)$

---

## 相关概念 / Related Concepts

- [[path_operations|Path Operations / 路径操作]]
- [[ap|ap: Functions are Functors / 函数是函子]]
- [[Transport_in_Type_Formers/overview|Transport in Type Formers / 类型构造子中的传输]]

---

## 参考文献 / References

- HoTT Book, Section 2.3: Type families are fibrations
