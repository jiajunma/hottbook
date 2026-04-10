---
title: "Chapter 11: Real Numbers / 实数"
type: chapter-digest
---

# Chapter 11: Real Numbers / 实数

用 HoTT 工具（HIT、截断、归纳-归纳类型）构造实数，展示构造性分析的可能性。给出 Dedekind 实数和 Cauchy 实数两种构造，用泛性质刻画它们，比较两者，讨论区间紧致性，并构造 Conway 超实数。

Constructing the real numbers with HoTT tools (HITs, truncation, inductive-inductive types). Two constructions: Dedekind reals and Cauchy reals, characterized by universal properties. Comparison, compactness of [0,1], and Conway's surreal numbers.

> **核心创新 / Key innovation:** Cauchy 实数作为高阶归纳-归纳类型 (higher inductive-inductive type) 构造，同时添加 Cauchy 序列的极限并商掉重合关系，避免了对可数选择公理的依赖。

---

## 11.1 有理数域 / The Field of Rationals
[[Real_Numbers/rationals]]

**Construction.** $\mathbb{Q} \defeq (\mathbb{Z} \times \mathbb{N}) / {\approx}$，其中 $(u, a) \approx (v, b) \defeq u(b+1) = v(a+1)$。

对 $(u, a)$ 表示有理数 $u/(1+a)$（巧妙地避免了除以零）。取最简分数为规范代表元，由此得到具有可判定等式和可判定序的有序域 $\mathbb{Q}$。

$\mathbb{Q}$ 可刻画为**初始有序域**。记 $\mathbb{Q}^+ \defeq \{ q : \mathbb{Q} \mid q > 0 \}$ 为正有理数类型。

---

## 11.2 Dedekind 实数 / Dedekind Reals
[[Real_Numbers/dedekind_reals]]

### 定义 / Definition

**Definition (Dedekind Cut).** Dedekind 切割是一对 mere 谓词 $(L, U) : (\mathbb{Q} \to \Omega) \times (\mathbb{Q} \to \Omega)$，满足：
1. **Inhabited（有界）:** $\exists q.\, L(q)$ 且 $\exists r.\, U(r)$
2. **Rounded（圆）:** $L(q) \Leftrightarrow \exists r > q.\, L(r)$，$U(r) \Leftrightarrow \exists q < r.\, U(q)$
3. **Disjoint（不相交）:** $\neg(L(q) \land U(q))$
4. **Located（定位）:** $q < r \Rightarrow L(q) \lor U(r)$

$$\mathbb{R}_D \defeq \{ (L, U) : (\mathbb{Q} \to \Omega)^2 \mid \text{dcut}(L, U) \}$$

> **关于 $\Omega$ / About $\Omega$:** 可以是带宇宙跟踪的 $\text{Prop}$，或假设命题缩放使所有 $\text{Prop}$ 在同一宇宙，或假设 LEM 取 $\Omega = \mathbf{2}$，或取初始 $\sigma$-frame。

嵌入 $\mathbb{Q} \hookrightarrow \mathbb{R}_D$：$q \mapsto (L_q, U_q)$，其中 $L_q(r) \defeq (r < q)$，$U_q(r) \defeq (q < r)$。

### 代数结构 / Algebraic Structure

**加法：**
$$L_{x+y}(q) \defeq \exists r,s.\, L_x(r) \land L_y(s) \land q = r + s$$

**乘法（区间算术风格）：**
$$L_{x \cdot y}(q) \defeq \exists a,b,c,d.\, L_x(a) \land U_x(b) \land L_y(c) \land U_y(d) \land q < \min(ac, ad, bc, bd)$$

**序：**
$$(x \le y) \defeq \forall q.\, L_x(q) \Rightarrow L_y(q), \qquad (x < y) \defeq \exists q.\, U_x(q) \land L_y(q)$$

**Lemma.** $L_x(q) \Leftrightarrow (q < x)$，$U_x(q) \Leftrightarrow (x < q)$。

**弱线性 / Weak linearity:** $(x < y) \Rightarrow (x < z) \lor (z < y)$（构造性替代线性序）。

**Definition (Apartness).** $(x \apart y) \defeq (x < y) \lor (y < x)$。

**Theorem.** 实数可逆当且仅当它与 $0$ 相离 (apart)。

**Theorem (Archimedean Principle).** 若 $x < y$，则仅仅存在 $q : \mathbb{Q}$ 使得 $x < q < y$。

**Definition (Ordered Field).** 有序域：交换幺环 + 格 $(\le, \min, \max)$ + 严格序 $<$（传递、反自反、弱线性）+ 相离关系 $\apart$（反自反、对称、余传递）+ 兼容条件。

**Theorem.** $\mathbb{R}_D$ 是 Archimedean 有序域。

### Cauchy 完备性 / Cauchy Completeness

**Definition (Cauchy Approximation).** 映射 $x : \mathbb{Q}^+ \to \mathbb{R}_D$ 满足 $|x_\delta - x_\epsilon| < \delta + \epsilon$。

**Theorem.** $\mathbb{R}_D$ 中每个 Cauchy 逼近有极限。

极限 $y$ 的切割：$L_y(q) \defeq \exists \epsilon, \theta.\, L_{x_\epsilon}(q + \epsilon + \theta)$。

### Dedekind 完备性与泛性质 / Dedekind Completeness and Universal Property

**Theorem.** $\mathbb{R}_D$ 是**终 (final) Archimedean 有序域**：任何对 $\Omega$ 可容许的 Archimedean 有序域都嵌入 $\mathbb{R}_D$。

**Corollary.** $\mathbb{R}_D$ 是 Dedekind 完备的：对每个实值 Dedekind 切割 $(L, U)$，存在唯一 $x : \mathbb{R}_D$ 使得 $L(y) = (y < x)$ 且 $U(y) = (x < y)$。

---

## 11.3 Cauchy 实数 / Cauchy Reals
[[Real_Numbers/cauchy_reals]]

### 动机与构造 / Motivation and Construction

经典构造 $\mathbb{R}_C = \mathcal{C}/{\approx}$（Cauchy 列的商）需要可数选择来提升 $\mathbb{N} \to \mathcal{C}/{\approx}$ 到 $\mathbb{N} \to \mathcal{C}$。HoTT 的解决方案：用高阶归纳-归纳类型 (higher inductive-inductive type) 同时添加极限并商掉重合关系。

**Definition (Cauchy Reals).** $\mathbb{R}_C$ 和辅助关系 $\sim_\epsilon : \mathbb{R}_C \to \mathbb{R}_C \to \text{Type}$（$\epsilon : \mathbb{Q}^+$）由以下同时归纳-归纳定义：

**$\mathbb{R}_C$ 的构造器：**
- **有理点：** 对每个 $q : \mathbb{Q}$，有 $\text{rat}(q) : \mathbb{R}_C$
- **极限点：** 对 Cauchy 逼近 $x : \mathbb{Q}^+ \to \mathbb{R}_C$（满足 $x_\delta \sim_{\delta+\epsilon} x_\epsilon$），有 $\text{lim}(x) : \mathbb{R}_C$
- **路径：** 若 $\forall \epsilon.\, u \sim_\epsilon v$，则 $u = v$

**$\sim$ 的构造器：**
- $|q - r| < \epsilon \Rightarrow \text{rat}(q) \sim_\epsilon \text{rat}(r)$
- $\text{rat}(q) \sim_{\epsilon - \delta} y_\delta \Rightarrow \text{rat}(q) \sim_\epsilon \text{lim}(y)$
- $x_\delta \sim_{\epsilon - \delta} \text{rat}(r) \Rightarrow \text{lim}(x) \sim_\epsilon \text{rat}(r)$
- $x_\delta \sim_{\epsilon - \delta - \eta} y_\eta \Rightarrow \text{lim}(x) \sim_\epsilon \text{lim}(y)$
- 命题截断（$\sim_\epsilon$ 值为 mere proposition）

> **直觉 / Intuition:** $u \sim_\epsilon v$ 意味着 "$|u - v| < \epsilon$"，但在 $\mathbb{R}_C$ 的定义完成前还没有减法和绝对值，所以作为同时定义的辅助关系。

### 代数结构 / Algebraic Structure

通过 **Lipschitz 扩张**从 $\mathbb{Q}$ 上的运算扩展到 $\mathbb{R}_C$：

**Theorem.** 若 $f : \mathbb{Q} \to \mathbb{R}_C$ 是 Lipschitz（常数 $M$），则 $f$ 唯一扩展为 $\bar{f} : \mathbb{R}_C \to \mathbb{R}_C$，在极限上由 $\bar{f}(\text{lim}(x)) = \text{lim}(\bar{f} \circ x)$ 定义。

加法、减法、取负、$\max$、$\min$ 直接由 Lipschitz 扩张定义。

**乘法**通过 $u \cdot v = \frac{1}{2}((u+v)^2 - u^2 - v^2)$ 归结为**平方函数**，后者在有界区间上是 Lipschitz 的，可分片扩展。

**Theorem.** $u \sim_\epsilon v \Leftrightarrow |u - v| < \text{rat}(\epsilon)$（辅助关系等价于距离条件）。

**Theorem.** $\mathbb{R}_C$ 是 Archimedean 有序域。

### Cauchy 完备性与泛性质 / Cauchy Completeness and Universal Property

**Theorem.** $\mathbb{R}_C$ 中每个 Cauchy 逼近有极限（$\text{lim}$ 构造器本身即提供）。

**Theorem.** $\mathbb{R}_C$ 是**初始 (initial) Cauchy 完备 Archimedean 有序域**：$\mathbb{R}_C$ 嵌入每个 Cauchy 完备 Archimedean 有序域。

嵌入 $e : \mathbb{R}_C \to F$ 由 $(\mathbb{R}_C, \sim)$-递归定义：$e(\text{rat}(q)) = q$，$e(\text{lim}(x)) = \lim(e \circ x)$。

---

## 11.4 Cauchy 与 Dedekind 实数的比较 / Comparison
[[Real_Numbers/cauchy_vs_dedekind]]

**Theorem.** 存在有序域嵌入 $\mathbb{R}_C \hookrightarrow \mathbb{R}_D$（固定有理数）。

由 $\mathbb{R}_C$ 的初始性和 $\mathbb{R}_D$ 的 Cauchy 完备性，或由 $\mathbb{R}_D$ 的终性和 $\mathbb{R}_C$ 的可容许性。

**Lemma.** 若对每个 $x : \mathbb{R}_D$ 仅仅存在**未截断的**定位函数 $c : \prod_{q < r} (q < x) + (x < r)$，则 $\mathbb{R}_C \simeq \mathbb{R}_D$。

Proof: 用 $c$ 构造三分搜索的有理 Cauchy 列收敛到 $x$。

**Corollary.** 若排中律或可数选择成立，则 $\mathbb{R}_C \simeq \mathbb{R}_D$。

> **一般情况 / In general:** 无额外公理时，$\mathbb{R}_C$ 可能严格小于 $\mathbb{R}_D$。Dedekind 实数需要幂集/非谓词性，Cauchy 实数需要选择或我们的 HIT 方法。

---

## 11.5 区间的紧致性 / Compactness of the Interval
[[Real_Numbers/compactness]]

### 度量紧致性 / Metric Compactness

**Definition.** 度量空间 $(X, d)$ **完备**若每个 Cauchy 逼近有极限；**完全有界**若对每个 $\epsilon > 0$ 有有限 $\epsilon$-网。

**Theorem.** $[0, 1]$ 是度量紧致的（完备且完全有界）。

**Theorem.** 度量紧致空间上的一致连续函数 $f : X \to \mathbb{R}$ 有上确界（且可达）。

### Bolzano-Weierstrass 性质 / Bolzano-Weierstrass Property

**Theorem.** "每个序列有收敛子列" 蕴含有限全知原理 (Limited Principle of Omniscience, LPO)。

因此 Bolzano-Weierstrass 在构造数学中不普遍成立。

### Heine-Borel 紧致性 / Heine-Borel Compactness

经典命题："$[0,1]$ 的每个开覆盖有有限子覆盖"。

**Theorem.** 假设排中律和可数选择，经典 Heine-Borel 定理成立。

构造性替代：**归纳覆盖 (inductive cover)**。

**Definition.** $[0, 1]$ 的归纳覆盖是满足以下条件的命题族 $C : \mathbb{Q} \to \mathbb{Q} \to \text{Prop}$：
- 若 $a < c$ 且 $C(a, b)$ 且 $C(c, d)$ 且 $c < b$，则 $C(a, d)$（拼接）
- 若 $b - a < 2\delta$ 且某开球覆盖 $[a,b]$，则 $C(a, b)$（基础）

**Theorem.** $C(0, 1)$ 对任何归纳覆盖 $C$ 成立（归纳覆盖紧致性），假设排中律。

---

## 11.6 超实数 / The Surreal Numbers
[[Real_Numbers/surreal_numbers]]

**Definition.** $\mathbf{No}$ 和关系 $\le$、$<$ 由以下高阶归纳-归纳类型同时定义：

**$\mathbf{No}$ 的构造器：**
- **切割：** 给定 $L : \mathcal{L} \to \mathbf{No}$，$R : \mathcal{R} \to \mathbf{No}$，若对所有 $l, r$ 有 $L(l) < R(r)$，则 $\{ L \mid R \}$ : $\mathbf{No}$
- **路径：** 若 $x \le y$ 且 $y \le x$，则 $x = y$

**$\le$ 的构造器：** $x \le y$ 若对所有左 option $x^L$ 有 $x^L < y$，且对所有右 option $y^R$ 有 $x < y^R$。

**$<$ 的构造器：** $x < y$ 若 $x \le y^{L_0}$（某个左 option）或 $x^{R_0} \le y$（某个右 option）。

> **直觉 / Intuition:** 超实数是"游戏"——由左集和右集构成。$\{ \mid \} = 0$，$\{ 0 \mid \} = 1$，$\{ \mid 0 \} = -1$，$\{ 0 \mid 1 \} = 1/2$，$\{ 0, 1, 2, \ldots \mid \} = \omega$。

**Theorem (Conway's Theorem 0).** $x \le x$ 且对所有 option 有 $x^L < x < x^R$。

**Corollary.** $\mathbf{No}$ 是 0-type（集合）。

**Theorem (Simplicity Theorem).** 若 $\forall l.\, L(l) < x$ 且 $\forall r.\, x < R(r)$，则 $\{ L \mid R \} \le x$。

**Encode-decode for $\mathbf{No}$：** 定义辅助关系 $\preceq$ 和 $\prec$：
$$x \preceq y \defeq (\forall L.\, x^L \prec y) \land (\forall R.\, x \prec y^R)$$
$$x \prec y \defeq (\exists L.\, x \preceq y^L) \lor (\exists R.\, x^R \preceq y)$$

**Theorem.** $(x \le y) = (x \preceq y)$ 且 $(x < y) = (x \prec y)$。

**Corollary.** $\le$ 和 $<$ 是传递的（经典中 Conway 的 Theorem 1）。

**运算 / Operations:** 取负 $-x \defeq \{ -x^R \mid -x^L \}$；加法 $x + y \defeq \{ x^L + y,\, x + y^L \mid x^R + y,\, x + y^R \}$；乘法类似。都通过 $(\mathbf{No}, \le, <)$-联合递归定义。

> **Conway 的愿景 / Conway's vision:** Conway 在 *On Numbers and Games* 中呼吁一种允许自由归纳构造并自由定义等式的基础理论。HoTT 的高阶归纳类型正是这一愿景的实现——超实数的 HIT 定义比 ZFC 中的构造更自然。

---

**HoTT 工具的展示 / Showcase of HoTT tools:** 本章综合运用了 HIT（Cauchy 实数、超实数的归纳-归纳定义）、截断（Dedekind 切割中的 $\text{Prop}$）、集合论（Ch10 的有序域理论），以及 encode-decode 方法（超实数的序关系刻画），展示 HoTT 作为分析基础的可行性。
