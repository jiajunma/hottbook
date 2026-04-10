---
title: "Chapter 6: Higher Inductive Types / 高阶归纳类型"
type: chapter-digest
created: 2026-04-08
sources: hits.tex
---

# Chapter 6: Higher Inductive Types / 高阶归纳类型

HoTT 的第二大创新（第一个是 univalence）。归纳类型的构造器只生成点，而 HIT 的构造器还可以生成路径甚至高维路径。这使得我们可以直接在类型论内部构造拓扑空间、商类型和自由代数结构。

The second major innovation of HoTT (the first being univalence). Ordinary inductive type constructors only generate points, while HIT constructors can also generate paths and higher paths. This enables direct construction of topological spaces, quotient types, and free algebraic structures within type theory.

---

## 6.1 Introduction / 导论
[[Higher_Inductive_Types/introduction]]

> **核心思想 / Core idea:** 高阶群胚有多个维度的"生成元"——点、路径、路径之间的路径...
> Higher groupoids have "generators" in multiple dimensions — points, paths, paths-between-paths...

**例子：圆 $S^1$ / Example: the circle.** 由以下生成：
- 一个点 $\mathrm{base} : S^1$
- 一条路径 $\mathrm{loop} : \mathrm{base} =_{S^1} \mathrm{base}$

**关键要点 / Key points:**
1. **自由生成 (Free generation):** $S^1$ 不仅包含 $\mathrm{loop}$，还包含 $\mathrm{loop} \cdot \mathrm{loop}$、$\mathrm{loop}^{-1}$ 等——群胚运算产生新路径。
2. **没有隐含的关系 / No implicit relations:** 我们不能直接"强制" $\mathrm{loop} \cdot \mathrm{loop} = \mathrm{refl}$，但可以通过添加 2 维路径生成元来实现。
3. **HIT 是单一类型 / HIT is a single type:** 泛性质属于 HIT 本身，不属于它的恒等类型。
4. **维度不对应 / Dimension mismatch:** 构造器的维度不等于类型有非平凡同伦的维度。$S^2$ 有 2 维生成元 $\mathrm{surf}$，但有非平凡的 3 维路径（Hopf fibration）。

---

## 6.2 Induction Principles and Dependent Paths / 归纳原理与依赖路径
[[Higher_Inductive_Types/dependent_paths]]

> **依赖路径 (dependent path) 是在 HIT 上定义依赖函数的核心技术。**

**Definition (Dependent path / Pathover).** 对于 $P : A \to \mathcal{U}$，$p : x =_A y$，$u : P(x)$，$v : P(y)$：

$$u =^P_p v \;\defeq\; \mathrm{transport}^P(p, u) = v$$

**$S^1$ 的归纳原理 / Induction principle for $S^1$:** 给定 $P : S^1 \to \mathcal{U}$，
- 一个点 $b : P(\mathrm{base})$，
- 一条依赖路径 $\ell : b =^P_{\mathrm{loop}} b$，

则存在 $f : \prod_{x:S^1} P(x)$ 满足 $f(\mathrm{base}) \jdeq b$ 和 $\mathrm{apd}_f(\mathrm{loop}) = \ell$。

**计算规则约定 / Computation rule conventions:**
- 点构造器的计算规则：**判断等式** ($\jdeq$)。
- 路径构造器的计算规则：**命题等式** ($=$)，记作 $\defid$。

**Lemma ($S^1$ 的递归原理).** 给定 $A$ 和 $a : A$，$p : a = a$，存在 $f : S^1 \to A$ 满足 $f(\mathrm{base}) \defeq a$ 和 $\mathrm{ap}_f(\mathrm{loop}) \defid p$。

**Lemma ($S^1$ 的泛性质).** 对任何类型 $A$：

$$(S^1 \to A) \;\simeq\; \sum_{x:A} (x = x)$$

---

## 6.3 The Interval / 区间
[[Higher_Inductive_Types/interval]]

**Definition.** 区间 $\mathbb{I}$ 由以下生成：
- $0_\mathbb{I} : \mathbb{I}$，$1_\mathbb{I} : \mathbb{I}$
- $\mathrm{seg} : 0_\mathbb{I} =_\mathbb{I} 1_\mathbb{I}$

**Lemma.** $\mathbb{I}$ 是 contractible 的。

*证明 / Proof:* 定义 $f : \prod_{x:\mathbb{I}} (x = 1_\mathbb{I})$，其中 $f(0_\mathbb{I}) \defeq \mathrm{seg}$，$f(1_\mathbb{I}) \defeq \mathrm{refl}$，验证 $\mathrm{apd}_f(\mathrm{seg})$ 的类型。

> **虽然 contractible，但 $\mathbb{I}$ 能证明函数外延性！**

**Lemma (Interval implies funext).** 若 $f, g : A \to B$ 满足 $\prod_{x:A} f(x) = g(x)$，则 $f =_{A \to B} g$。

*证明 / Proof:* 对每个 $x$，用递归原理构造 $\tilde{p}_x : \mathbb{I} \to B$ 连接 $f(x)$ 到 $g(x)$，然后定义 $q : \mathbb{I} \to (A \to B)$ 为 $q(i) \defeq \lambda x. \tilde{p}_x(i)$。

---

## 6.4 Circles and Spheres / 圆与球面
[[Higher_Inductive_Types/circle_and_spheres]]

**Lemma ($\mathrm{loop} \neq \mathrm{refl}$).** 若 $\mathrm{loop} = \mathrm{refl}_{\mathrm{base}}$，则对任何 $A, x : A, p : x = x$ 有 $p = \mathrm{refl}$，即所有类型是集合，矛盾。

**Lemma (非平凡自同伦).** 存在 $f : \prod_{x:S^1} (x = x)$ 不等于 $x \mapsto \mathrm{refl}_x$。定义 $f(\mathrm{base}) \defeq \mathrm{loop}$，验证沿 $\mathrm{loop}$ 的传输（利用 $\mathrm{transport}^{x \mapsto x = x}(p)(q) = p^{-1} \cdot q \cdot p$）。

**Corollary.** 包含 $S^1$ 的宇宙不是 1-type。

**2-球面 $S^2$:** 由 $\mathrm{base} : S^2$ 和 $\mathrm{surf} : \mathrm{refl}_{\mathrm{base}} = \mathrm{refl}_{\mathrm{base}}$（在 $\mathrm{base} = \mathrm{base}$ 中）生成。需要 2 维传输 $\mathrm{transport}^2$ 和 $\mathrm{apd}^2$ 来表述归纳原理。

**$n$-球面 / $n$-spheres:** $S^n$ 由 $\mathrm{base} : S^n$ 和 $\mathrm{loop}_n : \Omega^n(S^n, \mathrm{base})$ 生成。

---

## 6.5 Suspensions / 悬挂
[[Higher_Inductive_Types/suspensions]]

**Definition.** 类型 $A$ 的悬挂 $\Sigma A$ 由以下生成：
- $\mathrm{N} : \Sigma A$（北极），$\mathrm{S} : \Sigma A$（南极）
- $\mathrm{merid} : A \to (\mathrm{N} =_{\Sigma A} \mathrm{S})$

**Lemma.** $\Sigma \mathbf{2} \simeq S^1$。

*证明 / Proof:* 定义 $f : \Sigma \mathbf{2} \to S^1$ 映射两极到 $\mathrm{base}$，$\mathrm{ap}_f(\mathrm{merid}(0_\mathbf{2})) \defid \mathrm{loop}$，$\mathrm{ap}_f(\mathrm{merid}(1_\mathbf{2})) \defid \mathrm{refl}$。反向类似。

**球面的递归定义 / Recursive definition of spheres:**

$$S^0 \defeq \mathbf{2}, \qquad S^{n+1} \defeq \Sigma S^n$$

（甚至 $S^{-1} \defeq \mathbf{0}$，$\Sigma \mathbf{0} \simeq \mathbf{2}$。）

**Lemma (Suspension-loop space adjunction).** 对于有点类型 $(A, a_0)$ 和 $(B, b_0)$：

$$\mathrm{Map}_*(\Sigma A, B) \simeq \mathrm{Map}_*(A, \Omega B)$$

**Corollary.** $\mathrm{Map}_*(S^n, B) \simeq \Omega^n B$，即球面的泛性质。

---

## 6.6 Cell Complexes / 胞腔复形
[[Higher_Inductive_Types/cell_complexes]]

有限 CW 复形可以表示为 HIT：$n$ 维 disc 变成 $n$ 维路径构造器，粘贴映射分为源和目标。

**例子：环面 $T^2$ / Example: the torus.** 由以下生成：
- 一个点 $b : T^2$
- 两条路径 $p : b = b$，$q : b = b$
- 一条 2-路径 $t : p \cdot q = q \cdot p$

直觉来自矩形的边识别。

---

## 6.7 Hubs and Spokes / 轴辐构造
[[Higher_Inductive_Types/hubs_and_spokes]]

> **用 1 维路径构造器替代高维路径构造器。**
> Replace higher-dimensional path constructors with 1-dimensional ones.

**思想 / Idea:** 将 disc 看成锥——一个中心点 (hub) 加上从中心到边界每个点的路径 (spokes)。

**环面的替代定义 / Alternative torus definition:**
- 点 $b$，路径 $p : b = b$，$q : b = b$
- 一个新点 $h : T^2$（hub）
- 对每个 $x : S^1$，一条路径 $s(x) : f(x) = h$，其中 $f : S^1 \to T^2$ 由 $f(\mathrm{base}) \defeq b$，$\mathrm{ap}_f(\mathrm{loop}) \defid p \cdot q \cdot p^{-1} \cdot q^{-1}$ 定义。

这避免了 2 维路径构造器和依赖 2-路径。

---

## 6.8 Pushouts / 推出
[[Higher_Inductive_Types/pushouts]]

**Definition.** 给定 span $C \xrightarrow{g} B$，$C \xrightarrow{f} A$，pushout $A \sqcup^C B$ 由以下生成：
- $\mathrm{inl} : A \to A \sqcup^C B$，$\mathrm{inr} : B \to A \sqcup^C B$
- 对每个 $c : C$，$\mathrm{glue}(c) : \mathrm{inl}(f(c)) = \mathrm{inr}(g(c))$

**Definition (Cocone).** 给定 span $\mathscr{D}$ 和类型 $D$，cocone 是 $(i : A \to D,\; j : B \to D,\; h : \prod_{c:C} i(f(c)) = j(g(c)))$。

**Lemma (Universal property).** $(A \sqcup^C B \to E) \simeq \mathrm{cocone}(\mathscr{D}, E)$。

**Pushout 的特例 / Special cases of pushouts:**
- **悬挂 / Suspension:** $\mathbf{1} \leftarrow A \to \mathbf{1}$ 的 pushout 是 $\Sigma A$。
- **Join:** $A \xleftarrow{\pi_1} A \times B \xrightarrow{\pi_2} B$ 的 pushout 是 $A * B$。
- **Cofiber:** $\mathbf{1} \leftarrow A \xrightarrow{f} B$ 的 pushout 是 $f$ 的 cone/cofiber。
- **Wedge:** $A \xleftarrow{a_0} \mathbf{1} \xrightarrow{b_0} B$ 的 pushout 是 $A \vee B$。
- **Smash product:** $A \wedge B$ 是 $A \vee B \to A \times B$ 的 cofiber。

---

## 6.9 Truncations as HITs / 截断作为 HIT
[[Higher_Inductive_Types/truncations_as_hits]]

**命题截断 / Propositional truncation.** $\|A\|_{-1}$ 由以下生成：
- 函数 $|{-}| : A \to \|A\|_{-1}$
- 对每个 $x, y : \|A\|_{-1}$，路径 $x = y$

第二个构造器直接断言 $\|A\|_{-1}$ 是 mere proposition。

**0-截断 / 0-truncation.** $\|A\|_0$ 由以下生成：
- 函数 $|{-}|_0 : A \to \|A\|_0$
- 对每个 $x, y : \|A\|_0$，$p, q : x = y$，路径 $p = q$

**Lemma (0-truncation induction).** 若 $B : \|A\|_0 \to \mathcal{U}$ 使得每个 $B(x)$ 是集合，且有 $g : \prod_{a:A} B(|a|_0)$，则存在 $f : \prod_{x:\|A\|_0} B(x)$ 满足 $f(|a|_0) \jdeq g(a)$。

**Lemma (Universal property).** 对任何集合 $B$：$(\|A\|_0 \to B) \simeq (A \to B)$。

**集合推出 / Set-pushout.** 集合的 span 的 pushout 可能不是集合（$\mathbf{1} \leftarrow \mathbf{2} \to \mathbf{1}$ 的 pushout 是 $S^1$），但 $\|\!A \sqcup^C B\!\|_0$ 具有正确的集合上泛性质。

---

## 6.10 Quotients / 商
[[Higher_Inductive_Types/quotients]]

**Definition (Set-quotient).** 给定集合 $A$ 和 mere relation $R : A \times A \to \mathrm{Prop}$，$A/R$ 由以下生成：
- 函数 $q : A \to A/R$
- 对每个 $a, b : A$ 满足 $R(a,b)$，路径 $q(a) = q(b)$
- 0-截断构造器：对所有 $x, y : A/R$，$r, s : x = y$，有 $r = s$

**Lemma.** $q : A \to A/R$ 是满射。

**Lemma (Universal property).** 对任何集合 $B$：

$$(A/R \to B) \simeq \sum_{f:A \to B} \prod_{a,b:A} R(a,b) \to f(a) = f(b)$$

**当 $R$ 是等价关系时：** 有 $R(a,b) \simeq (q(a) =_{A/R} q(b))$。

**蕴涵式构造 / Impredicative construction.** 当 $R$ 是等价关系时，$A \sslash R \defeq \{P : A \to \mathrm{Prop} \mid P \text{ is an equivalence class}\}$ 与 $A/R$ 等价。

**Example: 整数 $\mathbb{Z}$.** $\mathbb{Z} \defeq (\mathbb{N} \times \mathbb{N}) / {\sim}$，其中 $(a,b) \sim (c,d) \defeq (a + d = b + c)$。

**Lemma (Sign induction for $\mathbb{Z}$).** 给定 $P : \mathbb{Z} \to \mathcal{U}$，$d_0 : P(0)$，$d_+ : \prod_n P(n) \to P(\mathrm{suc}(n))$，$d_- : \prod_n P(-n) \to P(-\mathrm{suc}(n))$，则存在 $f : \prod_z P(z)$。

---

## 6.11 Algebra / 代数
[[Higher_Inductive_Types/free_algebra]]

> **代数结构作为 HIT：构造器 = 运算，路径构造器 = 公理。**
> Algebraic structures as HITs: constructors = operations, path constructors = axioms.

**自由幺半群 / Free monoid.** $\mathrm{List}(A)$ 是 $A$ 上的自由幺半群（普通归纳类型足够）。

**自由群 / Free group.** $F(A)$ 由以下生成：
- $\eta : A \to F(A)$
- 运算 $m : F(A) \times F(A) \to F(A)$，单位元 $e : F(A)$，逆 $i : F(A) \to F(A)$
- 结合律、单位律、逆元律的路径构造器
- 0-截断构造器

**Theorem.** $F(A)$ 是 $A$ 上的自由群：$\mathrm{Hom}_{\mathrm{Group}}(F(A), G) \simeq (A \to G)$。

> **我们证明了自由群存在，而无需给出显式构造——只需写下泛性质！**
> We proved free groups exist without giving an explicit construction — just writing down the universal property!

**显式构造 / Explicit construction.** $F'(A) \defeq \mathrm{List}(A + A) / {\sim}$，其中关系消去相邻的 $a$ 和 $\hat{a}$。

**其他应用 / Other applications:**
- **合并自由积 / Amalgamated free product:** $H *_G K$ 作为 HIT。
- **群的表示 / Group presentations:** 生成元和关系的 HIT。
- **无穷代数理论 / Infinitary algebraic theories:** HIT 可以处理，而集合论中可能需要选择公理。

---

## 6.12 The Flattening Lemma / 展平引理
[[Higher_Inductive_Types/flattening_lemma]]

> **描述 HIT 上类型族的总空间，是 Ch8 计算同伦群的关键工具。**

**设置 / Setup:** 设 $W$ 是余等化子 (coequalizer)，由 $\mathrm{cc} : A \to W$ 和 $\mathrm{pp} : \prod_{b:B} \mathrm{cc}(f(b)) = \mathrm{cc}(g(b))$ 生成。设 $C : A \to \mathcal{U}$ 和 $D : \prod_{b:B} C(f(b)) \simeq C(g(b))$。用递归定义 $P : W \to \mathcal{U}$：

$$P(\mathrm{cc}(a)) \defeq C(a), \qquad \mathrm{ap}_P(\mathrm{pp}(b)) \defid \mathrm{ua}(D(b))$$

设 $\widetilde{W}$ 是"展平"的 HIT，由以下生成：
- $\widetilde{\mathrm{cc}} : \prod_{a:A} C(a) \to \widetilde{W}$
- $\widetilde{\mathrm{pp}} : \prod_{b:B} \prod_{y:C(f(b))} \widetilde{\mathrm{cc}}(f(b), y) = \widetilde{\mathrm{cc}}(g(b), D(b)(y))$

**Lemma (Flattening Lemma).** $\sum_{x:W} P(x) \simeq \widetilde{W}$。

*范畴论解读 / Categorical interpretation:* 这是 Grothendieck 构造的泛性质（lax colimit），也是余极限的稳定性和下降 (stability and descent) 性质的一部分。

---

## 6.13 The General Syntax of HITs / HIT 的一般语法
[[Higher_Inductive_Types/general_syntax]]

**输入约束 / Input constraints:** 与普通归纳类型相同——构造器输入中被定义类型只能严格正出现。

**输出约束 / Output constraints:** 输出可以是 $W$ 或其恒等类型 $u =_W v$，或更高维恒等类型。$u$ 和 $v$ 可以引用**之前的**构造器（有序列表）。

**自然性要求 / Naturality requirement:** $u$ 和 $v$ 中的表达式必须定义**自然变换**——只能涉及被所有类型间函数保持的运算（如路径合成），不能涉及可能不自然的运算（如多态函数 $\prod_{X:\mathcal{U}} (X \to X)$）。

**反例 / Counterexample:** 设 $f : \prod_{X:\mathcal{U}} (X \to X)$。定义 HIT $K$ 由 $a, b : K$ 和 $\sigma : f_K(a) = f_K(b)$ 生成——其归纳原理无法表述，因为我们不知道如何处理 $P(f_K(a))$ 中的元素。

---

**核心例子 / Key examples:** Circle 和 truncation 是后续章节最常用的 HIT。Circle 是 Ch8 同伦论的主角；truncation 连接 Ch3 和 Ch7 的 n-type 理论。Flattening lemma 是 Ch8 计算 $\pi_1(S^1)$ 等的关键技术工具。

Circle and truncation are the most frequently used HITs in later chapters. The flattening lemma is the key technical tool for computing $\pi_1(S^1)$ and other homotopy groups in Ch8.
