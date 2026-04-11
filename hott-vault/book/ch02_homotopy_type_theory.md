---
title: "Chapter 2: Homotopy Type Theory / 同伦类型论"
type: chapter-digest
book: "Homotopy Type Theory: Univalent Foundations of Mathematics"
chapter: 2
status: comprehensive
tags:
  - homotopy-type-theory
  - identity-types
  - groupoid-structure
  - transport
  - equivalence
  - univalence
  - function-extensionality
---

# Chapter 2: Homotopy Type Theory / 同伦类型论

这一章是全书的核心转折——揭示恒等类型的同伦含义。类型是空间，路径有 $\infty$-群胚结构，函数是函子，类型族是纤维化。最终引入两大公理：函数外延性和 Univalence。

This chapter is the central turning point of the book — revealing the homotopical meaning of identity types. Types are spaces, paths form $\infty$-groupoid structure, functions are functors, type families are fibrations. It culminates with two major axioms: function extensionality and univalence.

> **核心直觉 / Core Insight:** 在经典同伦论中，空间 $X$ 的 $k$-路径构成一个 $\infty$-群胚。在 HoTT 中，恒等类型的归纳原则 (path induction) 自动产生所有这些高维群胚结构——无需额外假设。
>
> In classical homotopy theory, the $k$-paths of a space $X$ form an $\infty$-groupoid. In HoTT, the induction principle for identity types automatically generates all this higher groupoid structure — no extra axioms needed.

**三重视角 / Three Viewpoints:**

| 等式观点 Equality | 同伦观点 Homotopy | $\infty$-群胚观点 $\infty$-Groupoid |
|---|---|---|
| 自反性 reflexivity | 常值路径 constant path | 恒等态射 identity morphism |
| 对称性 symmetry | 路径求逆 inversion of paths | 逆态射 inverse morphism |
| 传递性 transitivity | 路径拼接 concatenation of paths | 态射复合 composition of morphisms |

---

## 2.1 Types are higher groupoids / 类型是高阶群胚

[[Identity_and_Paths/path_operations]]

### 为什么重要 / Why it matters

本节从恒等类型的归纳原则出发，推导出路径的逆、拼接和群胚律。这证明了每个类型自动具有 $\infty$-群胚结构——这是 HoTT 最核心的发现之一。经典同伦论需要人工构造这些结构，而在 HoTT 中它们是"免费的"。

This section derives path inversion, concatenation, and groupoid laws from the induction principle of identity types. It proves every type automatically carries $\infty$-groupoid structure — one of the most central discoveries of HoTT. Classical homotopy theory requires manual construction; in HoTT they come for free.

### 关键定义 / Key Definitions

**路径 / Path:** 恒等类型 $\mathrm{Id}_A(x,y)$ 的元素 $p : x =_A y$ 称为从 $x$ 到 $y$ 的路径。$x$ 称为起点，$y$ 称为终点。

An element $p : x =_A y$ of the identity type is called a path from $x$ to $y$.

**环路空间 / Loop space:**
$$\Omega(A,a) :\equiv (a =_A a, \, \mathsf{refl}_a)$$

$n$-fold iterated loop space:
$$\Omega^0(A,a) :\equiv (A,a), \qquad \Omega^{n+1}(A,a) :\equiv \Omega^n(\Omega(A,a))$$

**pointed type / 带基点类型:**
$$(A,a) \text{ where } A:\mathcal{U}, \; a:A, \qquad \mathcal{U}_\bullet :\equiv \sum_{A:\mathcal{U}} A$$

### 关键引理 / Key Lemmas

**Lemma 2.1.1 (Path Inversion / 路径求逆):**
对任意类型 $A$ 和 $x,y:A$，存在函数
$$p^{-1} : (x = y) \to (y = x)$$
满足 $\mathsf{refl}_x^{-1} \equiv \mathsf{refl}_x$。

> 由路径归纳：要为所有 $p : x = y$ 构造 $y = x$ 中的元素，只需处理 $p$ 为 $\mathsf{refl}_x$ 的情况——此时目标类型 $x = x$ 由 $\mathsf{refl}_x$ 居住。

**Lemma 2.1.2 (Path Concatenation / 路径拼接):**
对任意 $x,y,z:A$，存在函数
$$p \cdot q : (x = y) \to (y = z) \to (x = z)$$
满足 $\mathsf{refl}_x \cdot \mathsf{refl}_x \equiv \mathsf{refl}_x$。

> **注意 / Note:** 拼接有三种自然的证明方式（归纳 $p$、归纳 $q$、两者都归纳），产生不同的判断等式（definitional equality），但它们之间可以证明命题等式。选择对称的双归纳版本使得 $\mathsf{refl} \cdot \mathsf{refl} \equiv \mathsf{refl}$。

**Lemma 2.1.4 ($\omega$-Groupoid Laws / $\omega$-群胚律):**
设 $A:\mathcal{U}$，$x,y,z,w:A$，$p:x=y$，$q:y=z$，$r:z=w$，则：

1. **右单位 / right unit:** $p = p \cdot \mathsf{refl}_y$ 且 $p = \mathsf{refl}_x \cdot p$
2. **逆律 / inverse law:** $p^{-1} \cdot p = \mathsf{refl}_y$ 且 $p \cdot p^{-1} = \mathsf{refl}_x$
3. **双逆 / double inverse:** $(p^{-1})^{-1} = p$
4. **结合律 / associativity:** $p \cdot (q \cdot r) = (p \cdot q) \cdot r$

> 这些等式本身是路径的路径（2-paths），即恒等类型的恒等类型中的元素。这些高阶路径满足它们自己的相干律，一路到无穷维。
>
> These equalities are themselves paths-of-paths (2-paths), i.e., elements in identity-types-of-identity-types. These higher paths satisfy their own coherence laws, all the way up to infinity.

### Eckmann-Hilton 论证 / Eckmann-Hilton Argument

**Theorem 2.1.6 (Eckmann-Hilton):**
第二环路空间 $\Omega^2(A)$ 上的拼接运算是交换的：
$$\alpha \cdot \beta = \beta \cdot \alpha, \qquad \text{for all } \alpha, \beta : \Omega^2(A)$$

*证明要点：* 定义水平拼接 $\alpha \star \beta$ 的两种方式（先右-whiskering 后左-whiskering，或反之），在 $\Omega^2$ 中两者分别等于 $\alpha \cdot \beta$ 和 $\beta \cdot \alpha$，又可证两种水平拼接相等。

**Whiskering / 鞭打运算:**
- 右 whiskering: $\alpha \triangleright r : p \cdot r = q \cdot r$（对 2-path $\alpha : p = q$ 和 1-path $r$）
- 左 whiskering: $q \triangleleft \beta : q \cdot r = q \cdot s$（对 1-path $q$ 和 2-path $\beta : r = s$）
- 水平拼接: $\alpha \star \beta :\equiv (\alpha \triangleright r) \cdot (q \triangleleft \beta)$

### 关键例子 / Key Examples

- 类型 $\mathbb{N}$ 是"集合态的"(set-like)：其高阶恒等类型平凡（见 3.1 节）
- 宇宙 $\mathcal{U}$ 通过 univalence 拥有丰富的路径结构——不是集合
- $\Omega^2(A)$ 的交换性将在第 8 章用于证明高阶同伦群是阿贝尔群

---

## 2.2 Functions are functors / 函数是函子

[[Identity_and_Paths/ap]]

### 为什么重要 / Why it matters

每个函数 $f : A \to B$ 自动保持路径结构：它将 $A$ 中的路径映为 $B$ 中的路径，并保持拼接和求逆。拓扑上说"每个函数连续"；范畴论上说"每个函数是函子"。这在 HoTT 中是内建的，无需额外证明。

Every function $f : A \to B$ automatically preserves path structure. Topologically, "every function is continuous"; categorically, "every function is a functor". This is built into HoTT.

### 关键定义 / Key Definitions

**$\mathsf{ap}$ (action on paths / 路径上的作用):**

**Lemma 2.2.1:** 设 $f : A \to B$，则对任意 $x, y : A$，存在运算
$$\mathsf{ap}_f : (x =_A y) \to (f(x) =_B f(y))$$
满足 $\mathsf{ap}_f(\mathsf{refl}_x) \equiv \mathsf{refl}_{f(x)}$。

*证明：* 路径归纳。在 $p \equiv \mathsf{refl}_x$ 的情况下，定义 $\mathsf{ap}_f(\mathsf{refl}_x) :\equiv \mathsf{refl}_{f(x)}$。

### 关键定理 / Key Theorems

**Lemma 2.2.2 (Functoriality of $\mathsf{ap}$ / $\mathsf{ap}$ 的函子性):**
设 $f : A \to B$，$g : B \to C$，$p : x =_A y$，$q : y =_A z$，则：

1. $\mathsf{ap}_f(p \cdot q) = \mathsf{ap}_f(p) \cdot \mathsf{ap}_f(q)$ — 保持拼接
2. $\mathsf{ap}_f(p^{-1}) = (\mathsf{ap}_f(p))^{-1}$ — 保持求逆
3. $\mathsf{ap}_g(\mathsf{ap}_f(p)) = \mathsf{ap}_{g \circ f}(p)$ — 复合律
4. $\mathsf{ap}_{\mathrm{id}_A}(p) = p$ — 恒等律

> 这些等式又满足更高层的相干律，如此无穷递归——这正是 $\infty$-函子的定义。

---

## 2.3 Type families are fibrations / 类型族是纤维化

[[Identity_and_Paths/transport]]

### 为什么重要 / Why it matters

Transport 是贯穿全书的核心运算。类型族 $P : A \to \mathcal{U}$ 拓扑上对应纤维化（fibration），其中 $A$ 是底空间，$P(x)$ 是 $x$ 上方的纤维，$\sum_{x:A} P(x)$ 是全空间。Transport 沿路径 $p : x =_A y$ 将纤维 $P(x)$ 中的元素提升到 $P(y)$ 中——这是"路径提升性质"的类型论版本。

Transport is the core operation throughout the book. A type family $P : A \to \mathcal{U}$ corresponds topologically to a fibration, with $A$ the base, $P(x)$ the fiber over $x$, and $\sum_{x:A} P(x)$ the total space. Transport lifts elements along paths — the type-theoretic version of the path lifting property.

### 关键定义 / Key Definitions

**Lemma 2.3.1 (Transport):**
设 $P : A \to \mathcal{U}$ 为类型族，$p : x =_A y$，则存在函数
$$\mathsf{transport}^P(p, -) : P(x) \to P(y)$$
满足 $\mathsf{transport}^P(\mathsf{refl}_x, -) \equiv \mathrm{id}_{P(x)}$。

*简写：* $p_*(u)$ 或 $\mathsf{transport}^P(p, u)$。

**Lemma 2.3.2 (Path Lifting Property / 路径提升性质):**
设 $P : A \to \mathcal{U}$，$u : P(x)$，$p : x = y$，则
$$\mathsf{lift}(u, p) : (x, u) =_{\sum_{x:A} P(x)} (y, p_*(u))$$
且 $\mathsf{ap}_{\pi_1}(\mathsf{lift}(u, p)) = p$。

**Lemma 2.3.4 (Dependent Map / 依赖映射 $\mathsf{apd}$):**
设 $f : \prod_{x:A} P(x)$，则
$$\mathsf{apd}_f : \prod_{p : x = y} \big( p_*(f(x)) =_{P(y)} f(y) \big)$$
满足 $\mathsf{apd}_f(\mathsf{refl}_x) \equiv \mathsf{refl}_{f(x)}$。

> $\mathsf{apd}_f$ 推广了 $\mathsf{ap}_f$：当 $P$ 是常值类型族 $P(x) \equiv B$ 时，两者通过 $\mathsf{transportconst}$ 关联。

### 关键引理 / Key Lemmas

**Lemma 2.3.5 (Transport in constant family / 常值族中的传输):**
若 $P(x) \equiv B$，则 $\mathsf{transportconst}^B(p, b) : p_*(b) = b$。

**Lemma 2.3.6:** $\mathsf{apd}_f(p) = \mathsf{transportconst}^B(p, f(x)) \cdot \mathsf{ap}_f(p)$（将 $\mathsf{apd}$ 与 $\mathsf{ap}$ 关联）。

**Lemma 2.3.8 (Transport concatenation / 传输拼接):**
$$q_*(p_*(u)) = (p \cdot q)_*(u)$$

**Lemma 2.3.9 (Transport compose / 传输与复合):**
$$\mathsf{transport}^{P \circ f}(p, u) = \mathsf{transport}^P(\mathsf{ap}_f(p), u)$$

**Lemma 2.3.10 (Transport naturality / 传输自然性):**
对函数族 $f : \prod_{x:A} P(x) \to Q(x)$：
$$\mathsf{transport}^Q(p, f_x(u)) = f_y(\mathsf{transport}^P(p, u))$$

### 关键例子 / Key Examples

- Transport 等价于纤维之间的等价（$p_*$ 的逆是 $p^{-1}_*$，由 Lemma 2.3.8 推得）
- 非依赖函数 $f : A \to B$ 是依赖函数 $f : \prod_{x:A} B$ 的特例，此时 $\mathsf{apd}$ 退化为 $\mathsf{ap}$

---

## 2.4 Homotopies and equivalences / 同伦与等价

[[Equivalences/homotopy]]

### 为什么重要 / Why it matters

定义函数之间的"相同"（同伦）和类型之间的"相同"（等价）。同伦是逐点相等；等价需要比 quasi-inverse 更好的定义以保证良好的证明论性质。等价概念贯穿全书——univalence 断言等价类型是相等类型。

Defines "sameness" between functions (homotopy) and between types (equivalence). Homotopy is pointwise equality; equivalence requires a better notion than quasi-inverse for proof-relevance. The equivalence concept pervades the entire book.

### 关键定义 / Key Definitions

**Definition 2.4.1 (Homotopy / 同伦):**
设 $f, g : \prod_{x:A} P(x)$，从 $f$ 到 $g$ 的同伦为
$$(f \sim g) :\equiv \prod_{x:A} (f(x) = g(x))$$

> **注意：** 同伦 $f \sim g$ 不等于恒等 $f = g$。需要函数外延性公理（2.9 节）才能建立两者的等价。

**Definition 2.4.6 (Quasi-inverse / 拟逆):**
函数 $f : A \to B$ 的拟逆为三元组 $(g, \alpha, \beta)$：
$$\mathsf{qinv}(f) :\equiv \sum_{g:B \to A} (f \circ g \sim \mathrm{id}_B) \times (g \circ f \sim \mathrm{id}_A)$$

> $\mathsf{qinv}(f)$ 在证明相关数学中行为不好（同一个 $f$ 可能有多个不等的拟逆）。因此需要更好的定义。

**等价的好定义 / Good notion of equivalence:**
$$\mathsf{isequiv}(f) :\equiv \Big(\sum_{g:B \to A} (f \circ g \sim \mathrm{id}_B)\Big) \times \Big(\sum_{h:B \to A} (h \circ f \sim \mathrm{id}_A)\Big)$$

满足三个性质：
1. $\mathsf{qinv}(f) \to \mathsf{isequiv}(f)$
2. $\mathsf{isequiv}(f) \to \mathsf{qinv}(f)$
3. 对任意 $e_1, e_2 : \mathsf{isequiv}(f)$，有 $e_1 = e_2$（命题性）

**等价类型 / Equivalence type:**
$$(A \simeq B) :\equiv \sum_{f : A \to B} \mathsf{isequiv}(f)$$

### 关键定理 / Key Theorems

**Lemma 2.4.2 (Homotopy is equivalence relation / 同伦是等价关系):**
- 自反: $f \sim f$
- 对称: $f \sim g \to g \sim f$
- 传递: $f \sim g \to g \sim h \to f \sim h$

**Lemma 2.4.3 (Naturality of homotopies / 同伦的自然性):**
设 $H : f \sim g$ 对 $f, g : A \to B$，$p : x =_A y$，则
$$H(x) \cdot \mathsf{ap}_g(p) = \mathsf{ap}_f(p) \cdot H(y)$$

> 这就是自然变换的交换图！同伦自动是"自然"的。

**Corollary 2.4.4:** 若 $H : f \sim \mathrm{id}_A$，则 $H(f(x)) = \mathsf{ap}_f(H(x))$。

**Lemma 2.4.12 (Equivalence is equivalence relation / 等价是等价关系):**
1. $A \simeq A$（$\mathrm{id}_A$ 是等价）
2. $A \simeq B \to B \simeq A$
3. $A \simeq B \to B \simeq C \to A \simeq C$

### 关键例子 / Key Examples

- $\mathrm{id}_A$ 的拟逆是 $\mathrm{id}_A$ 本身
- 对 $p : x =_A y$，函数 $(p \cdot -) : (y = z) \to (x = z)$ 的拟逆是 $(p^{-1} \cdot -)$
- $\mathsf{transport}^P(p, -) : P(x) \to P(y)$ 的拟逆是 $\mathsf{transport}^P(p^{-1}, -)$

---

## 2.5 The higher groupoid structure of type formers / 类型构造器的高阶群胚结构

### 为什么重要 / Why it matters

本节是路线图，概述后续各节的目标：对于每种类型构造器，刻画其恒等类型（路径空间）、transport 行为和 $\mathsf{ap}$ 的行为。并预告了两个需要公理的情况：$\Pi$-类型（函数外延性）和宇宙（univalence）。

This section is a roadmap, outlining the goals of subsequent sections: for each type former, characterize its identity type (path space), transport behavior, and behavior of $\mathsf{ap}$. It previews two cases requiring axioms: $\Pi$-types (function extensionality) and universes (univalence).

> **关键原则 / Key Principle:** 对许多类型 $A$，路径类型 $x =_A y$ 可用构建 $A$ 的数据来刻画（up to equivalence）。例如积类型中的路径是分量路径的对。但并非所有类型都如此——高阶归纳类型的路径空间可能非常复杂（如 $S^n$ 的高阶同伦群）。

---

## 2.6 Cartesian product types / 笛卡尔积类型

[[Identity_and_Paths/paths_in_products]]

### 为什么重要 / Why it matters

积类型中的路径等价于分量路径的对——最简单、最直觉的路径刻画。这是后续更复杂类型（$\Sigma$-类型等）的模板。

Paths in product types are equivalent to pairs of component paths — the simplest and most intuitive path characterization. This is the template for more complex types.

### 关键定理 / Key Theorems

**Theorem 2.6.2 (Paths in products / 积中的路径):**
对任意 $x, y : A \times B$，
$$\big( x =_{A \times B} y \big) \;\simeq\; \big( \pi_1(x) =_A \pi_1(y) \big) \times \big( \pi_2(x) =_B \pi_2(y) \big)$$

正向函数（消去）：$r \mapsto (\mathsf{ap}_{\pi_1}(r), \, \mathsf{ap}_{\pi_2}(r))$

逆向函数（引入）：$\mathsf{pair}^=(p, q) : x = y$（给定 $p : \pi_1(x) = \pi_1(y)$，$q : \pi_2(x) = \pi_2(y)$）

**命题计算规则 / Propositional computation rules:**
$$\mathsf{ap}_{\pi_1}(\mathsf{pair}^=(p,q)) = p, \qquad \mathsf{ap}_{\pi_2}(\mathsf{pair}^=(p,q)) = q$$

**高阶结构 / Higher structure:**
$$\mathsf{refl}_{(a,b)} = \mathsf{pair}^=(\mathsf{refl}_a, \mathsf{refl}_b)$$
$$r^{-1} = \mathsf{pair}^=(\mathsf{ap}_{\pi_1}(r)^{-1}, \, \mathsf{ap}_{\pi_2}(r)^{-1})$$
$$r \cdot s = \mathsf{pair}^=(\mathsf{ap}_{\pi_1}(r) \cdot \mathsf{ap}_{\pi_1}(s), \, \mathsf{ap}_{\pi_2}(r) \cdot \mathsf{ap}_{\pi_2}(s))$$

**Theorem 2.6.4 (Transport in products / 积中的传输):**
对类型族 $A, B : Z \to \mathcal{U}$，路径 $p : z =_Z w$，元素 $x : A(z) \times B(z)$：
$$p_*(x) = (p_*^A(\pi_1(x)), \, p_*^B(\pi_2(x)))$$

**Theorem 2.6.5 ($\mathsf{ap}$ for products / 积的 $\mathsf{ap}$):**
设 $f(x) :\equiv (g(\pi_1(x)), h(\pi_2(x)))$，则
$$\mathsf{ap}_f(\mathsf{pair}^=(p, q)) = \mathsf{pair}^=(\mathsf{ap}_g(p), \mathsf{ap}_h(q))$$

---

## 2.7 $\Sigma$-types / $\Sigma$-类型

[[Identity_and_Paths/paths_in_sigma]]

### 为什么重要 / Why it matters

$\Sigma$-类型是积的依赖版本。其路径刻画更微妙：需要一个基路径加上纤维中的依赖路径（经过 transport）。这是纤维化视角最自然的体现，也是后续章节反复使用的核心工具。

$\Sigma$-types are the dependent version of products. Their path characterization is more subtle: a base path plus a dependent path in the fiber (after transport). This is the natural manifestation of the fibration viewpoint and a core tool used repeatedly.

### 关键定理 / Key Theorems

**Theorem 2.7.2 (Paths in $\Sigma$-types / $\Sigma$-类型中的路径):**
设 $P : A \to \mathcal{U}$，$w, w' : \sum_{x:A} P(x)$，则
$$\big( w = w' \big) \;\simeq\; \sum_{p : \pi_1(w) = \pi_1(w')} p_*(\pi_2(w)) = \pi_2(w')$$

> **直觉 / Intuition:** 全空间中的路径 = 底空间中的路径 + 纤维中的依赖路径。

**Corollary 2.7.3 (Propositional uniqueness / 命题唯一性):**
$$z = (\pi_1(z), \pi_2(z)) \qquad \text{for } z : \sum_{x:A} P(x)$$

**Remark 2.7.1:** 即使 $(x, u)$ 和 $(x, v)$ 在全空间中路径相等 $(x,u) = (x,v)$，也不能直接得出 $u = v$——只能得出存在 $p : x = x$ 使得 $p_*(u) = v$。拓扑上：全空间中两个同纤维点之间的路径不一定在纤维内。

**Theorem 2.7.4 (Transport in $\Sigma$-types / $\Sigma$-类型中的传输):**
设 $P : A \to \mathcal{U}$，$Q : (\sum_{x:A} P(x)) \to \mathcal{U}$，$p : x =_A y$，$(u,z) : \sum_{u:P(x)} Q(x,u)$：
$$p_*(u,z) = \big(p_*(u), \, \mathsf{pair}^=(p, \mathsf{refl}_{p_*(u)})_*(z)\big)$$

---

## 2.8 The unit type / 单元类型

[[Identity_and_Paths/paths_in_unit]]

### 为什么重要 / Why it matters

$\mathbf{1}$ 中任意两个元素之间恰好有一条路径——它是可缩的 (contractible)。这是最简单的例子，也为后续定义 $n$-类型（truncation levels）奠定基础。

$\mathbf{1}$ has exactly one path between any two elements — it is contractible. The simplest example, and foundational for defining $n$-types (truncation levels).

### 关键定理 / Key Theorems

**Theorem 2.8.1:** 对任意 $x, y : \mathbf{1}$，
$$(x = y) \simeq \mathbf{1}$$

*证明要点：* 正向函数将一切映到 $\star$；逆向由 $\mathbf{1}$-归纳将 $x, y$ 归约为 $\star$，然后取 $\mathsf{refl}_\star$。

> Transport in $\mathbf{1}$ 是平凡的，即常值族中的 transport（Lemma 2.3.5）。

---

## 2.9 $\Pi$-types and the function extensionality axiom / $\Pi$-类型与函数外延性公理

[[Identity_and_Paths/paths_in_pi]], [[Axioms/function_extensionality]]

### 为什么重要 / Why it matters

函数外延性 (funext) 是 HoTT 的两大公理之一。它断言"逐点相等的函数就是相等的"——或更精确地说，$\mathsf{happly}$ 是一个等价。没有 funext，我们无法刻画 $\Pi$-类型中的路径空间。Funext 可由 univalence 或 interval type 推出。

Function extensionality (funext) is one of the two major axioms of HoTT. It asserts "pointwise equal functions are equal" — more precisely, $\mathsf{happly}$ is an equivalence. Without funext, we cannot characterize the path space of $\Pi$-types. Funext follows from univalence or an interval type.

### 关键定义 / Key Definitions

**$\mathsf{happly}$ (消去方向 / elimination direction):**
$$\mathsf{happly} : (f = g) \to \prod_{x:A} (f(x) = g(x))$$
由路径归纳定义。

**Axiom 2.9.3 (Function Extensionality / 函数外延性):**
对任意 $A$、$B : A \to \mathcal{U}$、$f, g : \prod_{x:A} B(x)$，函数 $\mathsf{happly}$ 是等价。

特别地，存在逆函数
$$\mathsf{funext} : \Big(\prod_{x:A} f(x) = g(x)\Big) \to (f = g)$$

**命题计算规则 / Propositional computation rule:**
$$\mathsf{happly}(\mathsf{funext}(h), x) = h(x)$$

**命题唯一性原则 / Propositional uniqueness:**
$$p = \mathsf{funext}(x \mapsto \mathsf{happly}(p, x)) \qquad \text{for } p : f = g$$

### 高阶结构 / Higher structure

$$\mathsf{refl}_f = \mathsf{funext}(x \mapsto \mathsf{refl}_{f(x)})$$
$$\alpha^{-1} = \mathsf{funext}(x \mapsto \mathsf{happly}(\alpha, x)^{-1})$$
$$\alpha \cdot \beta = \mathsf{funext}(x \mapsto \mathsf{happly}(\alpha, x) \cdot \mathsf{happly}(\beta, x))$$

### Transport in function types / 函数类型中的传输

对类型族 $A, B : X \to \mathcal{U}$，路径 $p : x_1 =_X x_2$，函数 $f : A(x_1) \to B(x_1)$：
$$\mathsf{transport}^{A \to B}(p, f) = \big(x \mapsto p_*^B(f(p^{-1}_*{}^A(x)))\big)$$

> 即：将参数反向传输，应用 $f$，再正向传输结果。

**Lemma 2.9.6 (Dependent paths in function types / 函数类型中的依赖路径):**
$$(p_*(f) = g) \;\simeq\; \prod_{a:A(x)} \big(p_*(f(a)) = g(p_*(a))\big)$$

---

## 2.10 Universes and the univalence axiom / 宇宙与 univalence 公理

[[Axioms/univalence]]

### 为什么重要 / Why it matters

Univalence 是 HoTT 最革命性的公理。它断言"等价的类型就是相等的类型"——$(A =_\mathcal{U} B) \simeq (A \simeq B)$。这意味着所有关于类型的构造和性质自动 respect 等价。常见的"同构即相等"的滥用记法变成了形式化的定理。Univalence 赋予宇宙丰富的路径结构，使其远超"集合"。

Univalence is the most revolutionary axiom of HoTT. It asserts "equivalent types are equal types." This means all constructions and properties about types automatically respect equivalence. Common "abuse of notation" (identifying isomorphic structures) becomes a formal theorem. Univalence gives the universe rich path structure, far beyond a "set."

### 关键定义 / Key Definitions

**Lemma 2.10.1 ($\mathsf{idtoeqv}$):**
$$\mathsf{idtoeqv} : (A =_\mathcal{U} B) \to (A \simeq B)$$
定义为 $\mathsf{idtoeqv}(p) :\equiv \mathsf{transport}^{X \mapsto X}(p, -)$（路径归纳证明它是等价）。

**Axiom 2.10.3 (Univalence / Univalence 公理):**
对任意 $A, B : \mathcal{U}$，$\mathsf{idtoeqv}$ 是等价。

$$\boxed{(A =_\mathcal{U} B) \;\simeq\; (A \simeq B)}$$

分解为：
- **引入 / Introduction:** $\mathsf{ua} : (A \simeq B) \to (A =_\mathcal{U} B)$
- **消去 / Elimination:** $\mathsf{idtoeqv} : (A =_\mathcal{U} B) \to (A \simeq B)$
- **命题计算 / Propositional computation:** $\mathsf{transport}^{X \mapsto X}(\mathsf{ua}(f), x) = f(x)$
- **命题唯一性 / Propositional uniqueness:** $p = \mathsf{ua}(\mathsf{idtoeqv}(p))$

### 高阶结构 / Higher structure

宇宙中的路径运算对应等价的运算：
$$\mathsf{refl}_A = \mathsf{ua}(\mathrm{id}_A)$$
$$\mathsf{ua}(f) \cdot \mathsf{ua}(g) = \mathsf{ua}(g \circ f)$$
$$\mathsf{ua}(f)^{-1} = \mathsf{ua}(f^{-1})$$

**Lemma 2.10.5 (Transport is $\mathsf{idtoeqv} \circ \mathsf{ap}$):**
$$\mathsf{transport}^B(p, u) = \mathsf{idtoeqv}(\mathsf{ap}_B(p))(u)$$

> 这意味着任何类型族 $B : A \to \mathcal{U}$ 中的 transport 可以通过先将 $p$ 映为宇宙中的路径 $\mathsf{ap}_B(p)$，再由 $\mathsf{idtoeqv}$ 转化为等价来理解。

### 关键例子 / Key Examples

- 宇宙 $\mathcal{U}$ 不是集合——因为存在非平凡的自等价（如 $\mathsf{not} : \mathbf{2} \simeq \mathbf{2}$）
- Univalence 蕴含函数外延性（见 4.9 节）

---

## 2.11 Identity type / 恒等类型

[[Identity_and_Paths/paths_in_identity]]

### 为什么重要 / Why it matters

恒等类型本身的路径（即"路径之间的路径"）没有简单的通用刻画，但可以通过已知刻画递推。Transport 在路径族中的行为归约为路径的前拼接和后拼接——这对应 hom-函子的协变/逆变作用。

Paths in identity types (i.e., "paths between paths") have no simple universal characterization, but can be derived recursively from known characterizations. Transport in families of paths reduces to pre- and post-composition — corresponding to the covariant/contravariant action of hom-functors.

### 关键定理 / Key Theorems

**Theorem 2.11.1 ($\mathsf{ap}$ preserves equivalences / $\mathsf{ap}$ 保持等价):**
若 $f : A \to B$ 是等价，则对所有 $a, a' : A$，
$$\mathsf{ap}_f : (a =_A a') \to (f(a) =_B f(a'))$$
也是等价。

> 因此，如果我们完全刻画了 $x =_A y$，则 $p =_{x=_A y} q$ 也被确定。

**Lemma 2.11.2 (Transport in path families / 路径族中的传输):**
对任意 $a : A$，$p : x_1 = x_2$：

| 族 $C(x)$ | $\mathsf{transport}^C(p, q)$ |
|---|---|
| $a = x$ | $q \cdot p$ |
| $x = a$ | $p^{-1} \cdot q$ |
| $x = x$ | $p^{-1} \cdot q \cdot p$ |

> Transport with $x \mapsto (a = x)$ is post-composition; transport with $x \mapsto (x = a)$ is contravariant pre-composition — exactly the hom-functor actions!

**Theorem 2.11.3 (General transport in path types):**
对 $f, g : A \to B$，$p : a =_A a'$，$q : f(a) =_B g(a)$：
$$\mathsf{transport}^{x \mapsto f(x) = g(x)}(p, q) = \mathsf{ap}_f(p)^{-1} \cdot q \cdot \mathsf{ap}_g(p)$$

**Theorem 2.11.5 (Dependent paths in identity types / 恒等类型中的依赖路径):**
对 $p : a = a'$，$q : a = a$，$r : a' = a'$：
$$\big(\mathsf{transport}^{x \mapsto (x=x)}(p, q) = r\big) \;\simeq\; (q \cdot p = p \cdot r)$$

---

## 2.12 Coproducts / 余积

[[Identity_and_Paths/paths_in_coproducts]]

### 为什么重要 / Why it matters

余积是第一个"正类型"(positive type) 的路径刻画。核心方法是 encode-decode——定义一个 $\mathsf{code}$ 函数来显式描述路径空间，然后证明 $\mathsf{code}$ 与实际路径空间等价。这个方法在后续计算球面同伦群时反复使用。

Coproducts are the first "positive type" path characterization. The core method is encode-decode: define a $\mathsf{code}$ function to explicitly describe the path space, then prove $\mathsf{code}$ is equivalent to the actual path space. This method is reused extensively when computing homotopy groups of spheres.

### 关键定理 / Key Theorems

**Theorem 2.12.5 (Paths in coproducts / 余积中的路径):**
固定 $a_0 : A$，定义 $\mathsf{code} : A + B \to \mathcal{U}$：
$$\mathsf{code}(\mathsf{inl}(a)) :\equiv (a_0 = a), \qquad \mathsf{code}(\mathsf{inr}(b)) :\equiv \mathbf{0}$$

则对所有 $x : A + B$：
$$(\mathsf{inl}(a_0) = x) \simeq \mathsf{code}(x)$$

**推论 / Corollaries:**
1. **$\mathsf{inl}$ 的单射性 / Injectivity:** $(\mathsf{inl}(a_1) = \mathsf{inl}(a_2)) \simeq (a_1 = a_2)$
2. **$\mathsf{inr}$ 的单射性:** $(\mathsf{inr}(b_1) = \mathsf{inr}(b_2)) \simeq (b_1 = b_2)$
3. **不相交性 / Disjointness:** $(\mathsf{inl}(a) = \mathsf{inr}(b)) \simeq \mathbf{0}$

**Encode-Decode 方法 / Encode-Decode Method:**
- $\mathsf{encode}(x, p) :\equiv \mathsf{transport}^\mathsf{code}(p, \mathsf{refl}_{a_0})$ — 沿 $p$ 传输反射
- $\mathsf{decode}(\mathsf{inl}(a), c) :\equiv \mathsf{ap}_\mathsf{inl}(c)$ — 应用 $\mathsf{inl}$ 的 $\mathsf{ap}$
- $\mathsf{decode}(\mathsf{inr}(b), c)$ — 由 $c : \mathbf{0}$ 的消去规则

> **特别地 / In particular:** $\mathbf{2} \equiv \mathbf{1} + \mathbf{1}$ 意味着 $\mathsf{false} \neq \mathsf{true}$。

**Transport in coproducts / 余积中的传输:**
$$p_*(\mathsf{inl}(a)) = \mathsf{inl}(p_*^A(a)), \qquad p_*(\mathsf{inr}(b)) = \mathsf{inr}(p_*^B(b))$$

---

## 2.13 Natural numbers / 自然数

[[Identity_and_Paths/paths_in_nat]]

### 为什么重要 / Why it matters

自然数也是正类型。其路径空间通过 encode-decode 刻画，揭示 Peano 公理的类型论版本：$0 \neq \mathsf{succ}(n)$ 和 $\mathsf{succ}$ 的单射性。

Natural numbers are also a positive type. Their path space, characterized via encode-decode, reveals the type-theoretic Peano axioms.

### 关键定义 / Key Definitions

**$\mathsf{code} : \mathbb{N} \to \mathbb{N} \to \mathcal{U}$（双重递归定义）:**

| | $0$ | $\mathsf{succ}(n)$ |
|---|---|---|
| $0$ | $\mathbf{1}$ | $\mathbf{0}$ |
| $\mathsf{succ}(m)$ | $\mathbf{0}$ | $\mathsf{code}(m, n)$ |

$r : \prod_{n:\mathbb{N}} \mathsf{code}(n, n)$ 定义为 $r(0) :\equiv \star$，$r(\mathsf{succ}(n)) :\equiv r(n)$。

### 关键定理 / Key Theorems

**Theorem 2.13.1 (Paths in $\mathbb{N}$ / 自然数中的路径):**
$$\forall m, n : \mathbb{N}, \quad (m = n) \simeq \mathsf{code}(m, n)$$

**推论 / Corollaries:**
1. $\mathsf{succ}(m) = 0 \to \mathbf{0}$ — **零不是后继 / zero is not a successor**
2. $(\mathsf{succ}(m) = \mathsf{succ}(n)) \to (m = n)$ — **$\mathsf{succ}$ 单射 / $\mathsf{succ}$ is injective**

---

## 2.14 Example: equality of structures / 例：结构的等式

[[Identity_and_Paths/equality_of_structures]]

### 为什么重要 / Why it matters

这是 univalence 的第一个实质应用。通过具体计算半群等式的类型，展示"同构即等价"不再是口号而是定理。对任何代数结构（幺半群、群、环等），univalence 自动使得"结构同构 = 结构相等"。这消除了数学中大量"滥用记法"。

This is the first substantive application of univalence. By concretely computing the type of equalities between semigroups, it demonstrates "isomorphism is equality" is a theorem, not a slogan. For any algebraic structure, univalence automatically makes "structural isomorphism = structural equality."

### 关键定义 / Key Definitions

**半群结构 / Semigroup structure:**
$$\mathsf{SemigroupStr}(A) :\equiv \sum_{m : A \to A \to A} \prod_{x,y,z:A} m(x, m(y,z)) = m(m(x,y), z)$$

**半群 / Semigroup:**
$$\mathsf{Semigroup} :\equiv \sum_{A:\mathcal{U}} \mathsf{SemigroupStr}(A)$$

### 关键结果 / Key Results

**Lifting equivalences / 提升等价:**
给定等价 $e : A \simeq B$，由 univalence 得 $\mathsf{ua}(e) : A =_\mathcal{U} B$，然后
$$\mathsf{transport}^{\mathsf{SemigroupStr}}(\mathsf{ua}(e)) : \mathsf{SemigroupStr}(A) \to \mathsf{SemigroupStr}(B)$$
是等价（因为 transport 沿任意路径都是等价）。

计算 transport 的具体行为：诱导乘法为
$$m'(b_1, b_2) = e(m(e^{-1}(b_1), e^{-1}(b_2)))$$

> 即：先用 $e^{-1}$ 映回 $A$，在 $A$ 中做乘法，再用 $e$ 映回 $B$。完全符合直觉。

**Equality of semigroups / 半群的等式:**
$(A, m, a) =_\mathsf{Semigroup} (B, m', a')$ 等价于：存在等价 $e : A \simeq B$ 使得
$$\prod_{x_1, x_2 : A} e(m(x_1, x_2)) = m'(e(x_1), e(x_2))$$
加上结合律证明的相应匹配。

> 对集合态类型，结合律证明自动匹配（因为集合中任何两个证明相等）。此时半群等式恰好就是经典的半群同构定义：载体集合之间保持乘法的双射。

---

## 2.15 Universal properties / 泛性质

[[Equivalences/universal_properties]]

### 为什么重要 / Why it matters

类型构造器的泛性质用等价表述，将抽象代数/范畴论中的泛性质与类型论的归纳/消去规则统一。特别是，$\Sigma$-类型的泛性质在命题解释下给出了"类型论选择公理"——不仅成立，而且其前件与后件等价！

Type formers' universal properties expressed as equivalences unify universal properties from abstract algebra/category theory with type-theoretic induction/elimination rules. Notably, the universal property of $\Sigma$-types gives the "type-theoretic axiom of choice" under propositions-as-types — not only true, but antecedent and conclusion are equivalent!

### 关键定理 / Key Theorems

**Theorem 2.15.2 (Universal property of products / 积的泛性质):**
$$(X \to A \times B) \;\simeq\; (X \to A) \times (X \to B)$$

依赖版本：
$$\Big(\prod_{x:X} A(x) \times B(x)\Big) \;\simeq\; \Big(\prod_{x:X} A(x)\Big) \times \Big(\prod_{x:X} B(x)\Big)$$

**Theorem 2.15.7 (Universal property of $\Sigma$-types / $\Sigma$ 的泛性质 = 类型论选择公理):**
$$\Big(\prod_{x:X} \sum_{a:A(x)} P(x,a)\Big) \;\simeq\; \sum_{g:\prod_{x:X} A(x)} \prod_{x:X} P(x, g(x))$$

> **命题解读 / Propositions-as-types reading:**
> - 左边 = "对所有 $x$，存在 $a$ 使得 $P(x,a)$"
> - 右边 = "存在选择函数 $g$ 使得对所有 $x$ 有 $P(x, g(x))$"
>
> 不仅蕴含成立，前件与后件等价！

**"Mapping out" universal properties / "映出"泛性质:**

积的笛卡尔闭伴随：
$$(A \times B \to C) \;\simeq\; (A \to (B \to C))$$

$\Sigma$-类型的映出：
$$\Big(\prod_{w:\sum_{x:A} B(x)} C(w)\Big) \;\simeq\; \Big(\prod_{x:A} \prod_{y:B(x)} C(x,y)\Big)$$

路径归纳的泛性质：
$$\Big(\prod_{x:A} \prod_{p:a=x} B(x,p)\Big) \;\simeq\; B(a, \mathsf{refl}_a)$$

> 右到左方向正是路径归纳原则！

**Pullbacks / 拉回:**
$$A \times_C B :\equiv \sum_{a:A} \sum_{b:B} (f(a) = g(b))$$
满足 pullback 的泛性质（见 Exercise 2.11）。

---

## 全章总结 / Chapter Summary

> **核心收获 / Key Takeaway:** 掌握 $\mathsf{transport}$ 和 $\mathsf{univalence}$ 是理解后续章节的关键。$\mathsf{Transport}$ 是在具体类型中做计算的核心工具；$\mathsf{univalence}$ 是 HoTT 区别于传统类型论的根本公理。Encode-decode 方法是刻画正类型路径空间的通用技术。
>
> Mastering $\mathsf{transport}$ and $\mathsf{univalence}$ is the key to understanding later chapters. $\mathsf{Transport}$ is the central tool for concrete computation in specific types; $\mathsf{univalence}$ is the fundamental axiom distinguishing HoTT from traditional type theory. The encode-decode method is the general technique for characterizing path spaces of positive types.

**方法论清单 / Methodology Checklist:**

1. **路径归纳 (Path Induction)** — 证明关于路径的性质时，归约到 $\mathsf{refl}$ 的情况
   To prove properties about paths, reduce to the $\mathsf{refl}$ case.
2. **Transport** — 沿路径在类型族的纤维之间移动元素
   Move elements between fibers of a type family along a path.
3. **$\mathsf{ap}$** — 将基空间中的路径映到值域中的路径
   Map a path in the domain to a path in the codomain.
4. **$\mathsf{apd}$** — $\mathsf{ap}$ 的依赖版本，给出依赖路径
   The dependent version of $\mathsf{ap}$, producing dependent paths.
5. **Encode-Decode** — 刻画正类型的路径空间的通用方法
   The general method for characterizing path spaces of positive types.
6. **Univalence** — 将类型等价转化为类型等式
   Convert a type equivalence into a type equality.
7. **Funext** — 将逐点同伦转化为函数等式
   Convert a pointwise homotopy into a function equality.

**后续章节预览 / Looking Ahead:**

- **Chapter 3:** 集合与逻辑——哪些类型是"集合态的"（$n$-类型/截断水平）
  Sets and logic — which types are "set-like" ($n$-types / truncation levels).
- **Chapter 4:** 等价的精确定义和更多性质
  Precise definitions of equivalence and further properties.
- **Chapter 6:** 高阶归纳类型——路径空间可以人为指定
  Higher inductive types — path spaces can be prescribed.
- **Chapter 8:** 用 encode-decode 计算球面的同伦群
  Computing homotopy groups of spheres via encode-decode.
