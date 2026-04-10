---
type: definition
title: "Types are Higher Groupoids / 类型是高维群胚"
chapter: 2
section: 1
tags: [path, groupoid, concatenation, inverse, reflexivity, associativity, loop-space, eckmann-hilton]
references:
  - "[[identity_type]]"
  - "[[ap]]"
  - "[[transport]]"
  - "[[Equivalences/homotopy]]"
---

# Types are Higher Groupoids / 类型是高维群胚

## 路径操作 / Path Operations

## Lean 4

```lean
-- Inverse (symmetry)
#check @Eq.symm   -- a = b → b = a
example (p : x = y) : y = x := p.symm

-- Concatenation (transitivity)
#check @Eq.trans   -- a = b → b = c → a = c
example (p : x = y) (q : y = z) : x = z := p.trans q

-- Groupoid laws (all proved by cases on the paths)
theorem inv_inv (p : x = y) : p.symm.symm = p := by cases p; rfl
theorem trans_inv (p : x = y) : p.trans p.symm = rfl := by cases p; rfl
theorem assoc (p : x = y) (q : y = z) (r : z = w) :
    (p.trans q).trans r = p.trans (q.trans r) := by cases p; cases q; cases r; rfl
```

### 反转 (逆) / Inverse

对于每个类型 $A$ 和每个 $x, y : A$，存在函数：

$$p^{-1} : (x = y) \to (y = x)$$

使得 $\mathsf{refl}_x^{-1} \equiv \mathsf{refl}_x$。

> **Lemma 2.1.1**: For every type $A$ and every $x, y : A$ there is a function $(x = y) \to (y = x)$, denoted $p \mapsto p^{-1}$, such that $\mathsf{refl}_x^{-1} \equiv \mathsf{refl}_x$.

**证明思路**: 通过路径归纳，只需处理 $y \equiv x$, $p \equiv \mathsf{refl}_x$ 的情况。此时 $y = x$ 就是 $x = x$，取 $\mathsf{refl}_x$ 即可。

---

### 拼接 (复合) / Concatenation

对于每个类型 $A$ 和每个 $x, y, z : A$，存在函数：

$$p \cdot q : (x = y) \to (y = z) \to (x = z)$$

使得 $\mathsf{refl}_x \cdot \mathsf{refl}_x \equiv \mathsf{refl}_x$。

> **Lemma 2.1.2**: For every type $A$ and every $x, y, z : A$ there is a function $(x = y) \to (y = z) \to (x = z)$, written $p \mapsto q \mapsto p \cdot q$, such that $\mathsf{refl}_x \cdot \mathsf{refl}_x \equiv \mathsf{refl}_x$.

**注意**: 路径拼接与函数复合的方向相反：$p : x = y$ 和 $q : y = z$ 给出 $p \cdot q : x = z$，但 $f : A \to B$ 和 $g : B \to C$ 给出 $g \circ f : A \to C$。

---

## 群胚法则 / Groupoid Laws

### Lemma 2.1.4

设 $A : \mathcal{U}$，$x, y, z, w : A$，$p : x = y$，$q : y = z$，$r : z = w$。则：

1. **右单位律 / Right unit**: $p = p \cdot \mathsf{refl}_y$ 且 $p = \mathsf{refl}_x \cdot p$
2. **逆律 / Inverse law**: $p^{-1} \cdot p = \mathsf{refl}_y$ 且 $p \cdot p^{-1} = \mathsf{refl}_x$
3. **双重逆 / Double inverse**: $(p^{-1})^{-1} = p$
4. **结合律 / Associativity**: $p \cdot (q \cdot r) = (p \cdot q) \cdot r$

**关键点**: 这些等式本身是恒等类型*中*的路径（即2-路径/同伦），而非判断等式。它们满足自身的更高相干性法则 (coherence laws)，如此"一直到无穷"。

---

## Mac Lane 五角形与相干性 / Mac Lane Pentagon and Coherences

结合律的各种证明之间的关系产生了 Mac Lane 五角形：将 $p \cdot (q \cdot (r \cdot s))$ 重组为 $((p \cdot q) \cdot r) \cdot s$ 的各种方式满足五角形相干性。

更高层级的相干性法则（用例如球形 operad 精确化）也存在，但同伦类型论的一个优点是所有这些结构都可以仅从恒等类型的归纳性质**证明**出来。

---

## 环路空间 / Loop Space

给定一个带基点的类型 $(A, a)$，定义其**环路空间** (loop space)：

$$\Omega(A, a) :\equiv (a =_A a, \mathsf{refl}_a)$$

$n$-重迭代环路空间递归定义为：
$$\Omega^0(A, a) :\equiv (A, a), \quad \Omega^{n+1}(A, a) :\equiv \Omega^n(\Omega(A, a))$$

---

## Eckmann-Hilton 论证 / Eckmann-Hilton Argument

### Theorem 2.1.6

第二环路空间上的复合运算是交换的：

$$\alpha \cdot \beta = \beta \cdot \alpha, \quad \text{对所有 } \alpha, \beta : \Omega^2(A)$$

**证明关键**：定义**水平复合** (horizontal composition) $\alpha \star \beta$ 和 whiskering 操作 $\alpha \rhd r$ 与 $q \lhd \beta$，然后证明两种水平复合方式一致，从而得出交换性。

---

## 证明的相关性 / Proof Relevance

在同伦类型论中，我们做的是**证明相关** (proof-relevant) 的数学：不仅重要的是一个类型是否被居住，*哪个*特定元素被构造也很重要。

例如，Lemma 2.1.2 有三种不同的证明（对 $p$ 归纳、对 $q$ 归纳、对两者归纳），它们产生不同的判断计算规则：
- 对 $p$ 归纳：$\mathsf{refl}_y \cdot q \equiv q$
- 对 $q$ 归纳：$p \cdot \mathsf{refl}_y \equiv p$
- 对两者归纳：$\mathsf{refl}_x \cdot \mathsf{refl}_x \equiv \mathsf{refl}_x$

---

## 相关概念 / Related Concepts

- [[identity_type|Identity Type / 恒等类型]]
- [[ap|Functions are Functors / 函数是函子]]
- [[transport|Type Families are Fibrations / 类型族是纤维化]]

---

## 参考文献 / References

- HoTT Book, Section 2.1: Types are higher groupoids
