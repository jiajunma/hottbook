---
type: definition
title: "Functions are Functors / 函数是函子"
chapter: 2
section: 2
tags: [ap, functoriality, function, path]
references:
  - "[[path_operations]]"
  - "[[transport]]"
  - "[[identity_type]]"
---

# Functions are Functors / 函数是函子

## 定义 / Definition

函数 $f : A \to B$ 在路径上表现为函子。在传统类型论中，这等价于"函数保持等式"；在拓扑上，这对应于"每个函数都是连续的"，即保持路径。

### $\mathsf{ap}$ 操作 / The $\mathsf{ap}$ Operation

> **Lemma 2.2.1**: Suppose that $f : A \to B$ is a function. Then for any $x, y : A$ there is an operation
> $$\mathsf{ap}_f : (x =_A y) \to (f(x) =_B f(y))$$
> Moreover, for each $x : A$ we have $\mathsf{ap}_f(\mathsf{refl}_x) \equiv \mathsf{refl}_{f(x)}$.

**证明**: 通过路径归纳。假设 $p$ 是 $\mathsf{refl}_x$，此时定义 $\mathsf{ap}_f(p) :\equiv \mathsf{refl}_{f(x)} : f(x) = f(x)$。

符号 $\mathsf{ap}_f$ 可读作 "$f$ 对路径的**应用** (application)"或 "$f$ 在**路径上的作用** (action on paths)"。我们常简写 $\mathsf{ap}_f(p)$ 为 $\mathsf{ap}\,f\,p$。

## Lean 4

```lean
-- ap: functions act on paths
#check @congrArg   -- (f : α → β) → a = b → f a = f b

example (f : Nat → Nat) (p : x = y) : f x = f y := congrArg f p

-- Functoriality: ap preserves composition
theorem ap_trans (f : α → β) (p : x = y) (q : y = z) :
    congrArg f (p.trans q) = (congrArg f p).trans (congrArg f q) := by
  cases p; cases q; rfl
```

---

## 函子性法则 / Functoriality Laws

### Lemma 2.2.2

对于函数 $f : A \to B$，$g : B \to C$ 和路径 $p : x =_A y$，$q : y =_A z$：

1. **保持复合 / Preserves composition**: $\mathsf{ap}_f(p \cdot q) = \mathsf{ap}_f(p) \cdot \mathsf{ap}_f(q)$
2. **保持逆 / Preserves inverses**: $\mathsf{ap}_f(p^{-1}) = (\mathsf{ap}_f(p))^{-1}$
3. **与函数复合相容 / Respects function composition**: $\mathsf{ap}_g(\mathsf{ap}_f(p)) = \mathsf{ap}_{g \circ f}(p)$
4. **保持恒等 / Preserves identity**: $\mathsf{ap}_{\mathsf{id}_A}(p) = p$

**证明**: 留给读者（均可通过路径归纳证明）。

---

## 直觉 / Intuition

| 视角 / Perspective | $\mathsf{ap}_f$ 的意义 |
|---|---|
| 等式 (Equality) | 函数保持等式 |
| 同伦 (Homotopy) | 连续函数将路径映为路径 |
| 范畴 (Category) | 函子将态射映为态射 |
| $\infty$-群胚 | $\infty$-函子保持所有层级的态射 |

---

## 与 $\mathsf{apd}$ 的关系 / Relationship to $\mathsf{apd}$

$\mathsf{ap}_f$ 是非依赖版本。对于依赖函数 $f : \prod_{x:A} P(x)$，需要更精细的**依赖映射** $\mathsf{apd}_f$，见 [[transport|类型族是纤维化]]。

如同群胚法则的等式，$\mathsf{ap}$ 的函子性等式本身也是路径，满足自身的相干性法则，如此递推。

---

## 相关概念 / Related Concepts

- [[path_operations|Path Operations / 路径操作]]
- [[transport|Transport and apd / 传输与依赖映射]]
- [[Equivalences/homotopy|Homotopies / 同伦]]

---

## 参考文献 / References

- HoTT Book, Section 2.2: Functions are functors
