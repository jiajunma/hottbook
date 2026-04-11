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

**重要**：这里的 $=$ 是**同伦意义下的等式**——即一条路径（在 $\Omega^2$ 中，这是一条 3-path），**不是**判断等式 (definitional equality)。交换性本身是一个类型的居民，它可以被进一步操作。

**证明结构**：

1. 定义 **vertical composition** $\alpha \cdot_v \beta$：先 $\alpha$ 后 $\beta$（纵向拼接 2-path）
2. 定义 **horizontal composition** $\alpha \star_h \beta$：通过 whiskering 左右拼接
   - Right whiskering: $\alpha \rhd r$ — 在 $\alpha$ 右侧附加路径 $r$
   - Left whiskering: $q \lhd \beta$ — 在 $\beta$ 左侧附加路径 $q$
   - $\alpha \star_h \beta :\equiv (\alpha \rhd \mathsf{rfl}) \cdot_v (\mathsf{rfl} \lhd \beta)$
3. 证明 $\alpha \cdot_v \beta = \alpha \star_h \beta$（一条路径）
4. 证明 $\alpha \star_h \beta = \beta \cdot_v \alpha$（另一条路径）
5. 拼接得到 $\alpha \cdot_v \beta = \beta \cdot_v \alpha$

每一步都是构造一条**路径** (propositional equality)，整个论证都在同伦意义下进行。这意味着交换性的证明本身也是一个有意义的对象——可以进一步问不同的交换性证明之间是否相等 (4-path)，如此递推。

### 与高阶同伦群的关系 / Relation to Higher Homotopy Groups

Loop space 与 homotopy group 的关系：

$$\pi_n(A, a) :\equiv \| \Omega^n(A, a) \|_0$$

$\Omega^n(A,a)$ 是完整的类型（保留所有高阶结构），$\pi_n$ 是它的 set truncation（只保留"有多少种本质不同的 $n$-loop"）。Eckmann-Hilton 保证 $\pi_n$ 在 $n \geq 2$ 时自动成为**交换群 (abelian group)**。

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
