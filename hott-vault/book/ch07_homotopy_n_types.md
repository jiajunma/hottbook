---
title: "Chapter 7: Homotopy n-types / 同伦 n-类型"
type: chapter-digest
created: 2026-04-08
sources: hlevels.tex
---

# Chapter 7: Homotopy n-types / 同伦 n-类型

系统发展 n-type 层级的理论。Ch3 引入了 set 和 prop，这里推广到一般的 n-type，构造 n-截断、发展连通性理论、建立正交分解系统，最终推广到模态 (modalities)——HoTT 独有的抽象框架。

This chapter systematically develops the theory of the n-type hierarchy. Ch3 introduced sets and propositions; here we generalize to arbitrary n-types, construct n-truncations, develop connectedness theory, establish the orthogonal factorization system, and generalize to modalities — an abstract framework unique to HoTT.

---

## 7.1 Definition of n-types / n-类型的定义
[[Truncation_Levels/n_types]]

> **递归定义：$n$-type 是路径空间均为 $(n-1)$-type 的类型。**
> Recursive definition: an $n$-type is a type whose path spaces are all $(n-1)$-types.

**Definition.** 对 $n \geq -2$ 递归定义：

$$\mathrm{is\text{-}n\text{-}type}(X) \defeq \begin{cases} \mathrm{isContr}(X) & n = -2 \\ \prod_{x,y:X} \mathrm{is\text{-}n'\text{-}type}(x =_X y) & n = n' + 1 \end{cases}$$

| $n$ | 名称 / Name | 直觉 / Intuition |
|-----|-------------|-------------------|
| $-2$ | contractible | 恰好一个点 / exactly one point |
| $-1$ | mere proposition | 至多一个点 / at most one point |
| $0$ | set | 无非平凡路径 / no nontrivial paths |
| $1$ | 1-type (groupoid) | 路径间无非平凡路径 / no nontrivial paths between paths |

**Theorem (Retracts).** $n$-type 的 retract 仍是 $n$-type。

**Theorem (Cumulativity).** 若 $X$ 是 $n$-type，则 $X$ 也是 $(n+1)$-type。

**Theorem ($\Sigma$-types).** 若 $A$ 是 $n$-type 且每个 $B(a)$ 是 $n$-type，则 $\sum_{x:A} B(x)$ 是 $n$-type。

**Theorem ($\Pi$-types).** 若每个 $B(a)$ 是 $n$-type，则 $\prod_{x:A} B(x)$ 是 $n$-type。

**Theorem.** 对任何 $n \geq -2$ 和类型 $X$，$\mathrm{is\text{-}n\text{-}type}(X)$ 是 mere proposition。

**Definition.** $n$-type 的宇宙：$n\text{-}\mathrm{Type} \defeq \sum_{X:\mathcal{U}} \mathrm{is\text{-}n\text{-}type}(X)$。

**Theorem.** $n\text{-}\mathrm{Type}$ 是 $(n+1)$-type。对于 $(X,p), (X',p') : n\text{-}\mathrm{Type}$：

$$(X,p) =_{n\text{-}\mathrm{Type}} (X',p') \;\simeq\; (X =_\mathcal{U} X') \;\simeq\; (X \simeq X')$$

---

## 7.2 Uniqueness of Identity Proofs and Hedberg's Theorem / UIP 与 Hedberg 定理
[[Truncation_Levels/hedberg]]

**Theorem (Axiom K $\Leftrightarrow$ Set).** 类型 $X$ 是集合当且仅当满足 Axiom K：对所有 $x : X$，$p : x = x$，有 $p = \mathrm{refl}_x$。

> **注意 / Note:** 我们不假设 UIP 或 Axiom K 为公理！它们只是特定类型可能满足的性质。

**Theorem.** 若反射性 mere relation $R$ 蕴含恒等（$\prod_{x,y} R(x,y) \to x = y$），则 $X$ 是集合且 $R(x,y) \simeq (x = y)$。

*第一种证明 / First proof:* 利用 $R(x,x)$ 是 mere prop 和 $f : R \to \mathrm{Id}$ 的"自然性"（连续性），推出所有自环 $p : x = x$ 等于 $\mathrm{refl}$。

*第二种证明 / Second proof:* 证明 $\sum_y R(x,y)$ contractible，由此 $f(x) : R(x,y) \to (x = y)$ 是等价。

**Corollary.** 若 $\neg\neg(x = y) \to (x = y)$，则 $X$ 是集合。

**Theorem (Hedberg).** 若 $X$ 有可判定等式（$\prod_{x,y} (x = y) + \neg(x = y)$），则 $X$ 是集合。

**Theorem.** $\mathbb{N}$ 有可判定等式，因此是集合。

**推广到 n-types / Generalization to n-types:**

**Theorem.** 对 $n \geq -1$，$A$ 是 $(n+1)$-type 当且仅当对所有 $a : A$，$\Omega(A, a)$ 是 $n$-type。

**Theorem.** 对 $n \geq -1$，$A$ 是 $n$-type 当且仅当对所有 $a : A$，$\Omega^{n+1}(A, a)$ 是 contractible。

---

## 7.3 Truncations / 截断
[[Truncation_Levels/truncation]]

> **$\|A\|_n$ 是 $A$ 的"最佳 $n$-type 近似"。**
> $\|A\|_n$ is the "best $n$-type approximation" of $A$.

**构造 / Construction (for $n \geq -1$).** 利用 hub-and-spokes 和 $S^{n+1}$。$\|A\|_n$ 由以下生成：
- 函数 $|{-}|_n : A \to \|A\|_n$
- 对每个 $r : S^{n+1} \to \|A\|_n$，一个 hub 点 $h(r) : \|A\|_n$
- 对每个 $r : S^{n+1} \to \|A\|_n$ 和 $x : S^{n+1}$，一条 spoke 路径 $s_r(x) : r(x) = h(r)$

**Lemma.** $\|A\|_n$ 是 $n$-type。

*证明 / Proof:* 由 $\Omega^{n+1}(\|A\|_n, b) \simeq \mathrm{Map}_*(S^{n+1}, (\|A\|_n, b))$。后者 contractible：中心是常值映射 $c_b$，对任意 $(r, p)$ 利用 spokes 给出到 $c_b$ 的路径。

**Theorem (Induction for truncations).** 给定 $P : \|A\|_n \to \mathcal{U}$ 使得每个 $P(x)$ 是 $n$-type，和 $g : \prod_{a:A} P(|a|_n)$，存在 $f : \prod_{x:\|A\|_n} P(x)$ 满足 $f(|a|_n) \jdeq g(a)$。

**Theorem (Universal property).** 对 $n \geq -2$，$A : \mathcal{U}$，$B : n\text{-}\mathrm{Type}$：

$$(\|A\|_n \to B) \;\xrightarrow[\sim]{\;\;{-} \circ |{-}|_n\;\;}\; (A \to B)$$

即 $n$-type 形成类型范畴的**反射子范畴 (reflective subcategory)**。

**函子性 / Functoriality.** $f : A \to B$ 诱导 $\|f\|_n : \|A\|_n \to \|B\|_n$。有自然性同伦 $\mathrm{nat}^f_n : \prod_a \|f\|_n(|a|_n) = |f(a)|_n$。

**Theorem (Products).** $\|A \times B\|_n \simeq \|A\|_n \times \|B\|_n$。

**Theorem (Sigma in truncation).** $\|\sum_x \|P(x)\|_n\|_n \simeq \|\sum_x P(x)\|_n$。

**Theorem (Path spaces).** 对 $x, y : A$ 和 $n \geq -2$：

$$\|x =_A y\|_n \;\simeq\; (|x|_{n+1} =_{\|A\|_{n+1}} |y|_{n+1})$$

**Corollary.** $\|\Omega(A,a)\|_n = \Omega(\|A\|_{n+1}, |a|_{n+1})$。更一般地，$\|\Omega^k(A,a)\|_n = \Omega^k(\|A\|_{n+k}, |a|_{n+k})$。

**Lemma (Cumulative truncation).** 若 $k \leq n$，则 $\|\|A\|_n\|_k = \|A\|_k$。

**Corollary.** $A$ 是 $n$-type 当且仅当 $|{-}|_n : A \to \|A\|_n$ 是等价。

---

## 7.4 Colimits of n-types / n-类型的余极限
[[Truncation_Levels/colimits]]

> **$n$-type 的 pushout 通过截断普通 pushout 获得。**

**Theorem.** 设 $\mathscr{D}$ 是 span，$(D, c)$ 是其 pushout。则 $(\|D\|_n, \|c\|_n)$ 是 $\|\mathscr{D}\|_n$ 在 $n$-types 中的 pushout。

*证明使用 2-out-of-3 性质和截断的自然性。*

---

## 7.5 Connectedness / 连通性
[[Truncation_Levels/connectedness]]

> **$n$-connected = $n$ 维以下信息平凡。截断的"对偶"概念。**
> $n$-connected = trivial information below dimension $n$. "Dual" to truncation.

**Definition.** 函数 $f : A \to B$ 是 **$n$-connected** 如果 $\prod_{b:B} \mathrm{isContr}(\|\mathrm{fib}_f(b)\|_n)$。类型 $A$ 是 **$n$-connected** 如果 $\|A\|_n$ contractible。

| 性质 / Property | 等价条件 / Equivalent condition |
|---|---|
| $(-2)$-connected | 总是成立 / always |
| $(-1)$-connected 函数 | 满射 / surjective |
| $(-1)$-connected 类型 | merely inhabited |
| $0$-connected 类型 | connected (一个连通分量 / one component) |
| $1$-connected 类型 | simply connected |

**Theorem (Characterization by induction).** 对 $f : A \to B$，以下等价：
1. $f$ 是 $n$-connected。
2. 对每个 $P : B \to n\text{-}\mathrm{Type}$，$(\prod_b P(b)) \xrightarrow{- \circ f} (\prod_a P(f(a)))$ 是等价。
3. 条件 2 只要求有截面。

> 这是 $n$-connected 映射的"归纳原理"——对 $n$-type 值族可以沿 connected 映射提升截面。

**Corollary.** $|{-}|_n : A \to \|A\|_n$ 是 $n$-connected。

**Corollary.** $A$ 是 $n$-connected 当且仅当 $b \mapsto \lambda a. b : B \to (A \to B)$ 对每个 $n$-type $B$ 是等价（"从 $A$ 到 $n$-type 的映射都是常值"）。

**Lemma (Connected pointed types).** 设 $n \geq -1$。有点类型 $(A, a_0)$ 是 $n$-connected 当且仅当 $a_0 : \mathbf{1} \to A$ 是 $(n-1)$-connected。

**Closure properties / 封闭性:**
- 若 $f$ 是 $n$-connected 的 retract，则也 $n$-connected。
- 若 $f : A \to B$ 是 $n$-connected，则 $g : B \to C$ 是 $n$-connected 当且仅当 $g \circ f$ 是。
- $n$-connected 映射诱导截断上的等价：若 $f$ 是 $n$-connected，则 $\|f\|_n : \|A\|_n \simeq \|B\|_n$。

---

## 7.6 Orthogonal Factorization / 正交分解
[[Truncation_Levels/factorization]]

> **每个映射唯一分解为 $n$-connected 后接 $n$-truncated。**
> Every map factors uniquely as $n$-connected followed by $n$-truncated.

**Definition.** 函数 $f : A \to B$ 是 **$n$-truncated** 如果 $\mathrm{fib}_f(b)$ 对所有 $b$ 是 $n$-type。

| $n$ | $n$-truncated 映射 / $n$-truncated map |
|-----|------|
| $-2$ | 等价 / equivalence |
| $-1$ | 嵌入 / embedding |
| $0$ | 所有纤维是集合 / all fibers are sets |

**Lemma.** $f$ 是 $(n+1)$-truncated 当且仅当 $\mathrm{ap}_f : (x = y) \to (f(x) = f(y))$ 对所有 $x, y$ 是 $n$-truncated。

**Definition ($n$-image).** $\mathrm{im}_n(f) \defeq \sum_{b:B} \|\mathrm{fib}_f(b)\|_n$。

**Lemma.** $\tilde{f} : A \to \mathrm{im}_n(f)$ 是 $n$-connected，$\pi_1 : \mathrm{im}_n(f) \to B$ 是 $n$-truncated。

**Theorem (Unique factorization).** 对每个 $f : A \to B$，分解空间

$$\mathrm{fact}_n(f) \defeq \sum_{X:\mathcal{U}} \sum_{g:A \to X} \sum_{h:X \to B} (h \circ g \sim f) \times \mathrm{conn}_n(g) \times \mathrm{trunc}_n(h)$$

是 contractible 的。中心是 $(\mathrm{im}_n(f), \tilde{f}, \pi_1, \ldots)$。

**Theorem (Orthogonality).** 设 $e : A \to B$ 是 $n$-connected，$m : C \to D$ 是 $n$-truncated。则

$$(B \to C) \;\xrightarrow{\sim}\; \sum_{h:A \to C} \sum_{k:B \to D} (m \circ h \sim k \circ e)$$

**Theorem (Stability of images under pullback).** 若外矩形是 pullback，则 $\mathrm{im}_n(f) \to \mathrm{im}_n(g)$ 形成的底部方形也是 pullback。

---

## 7.7 Modalities / 模态
[[Truncation_Levels/modalities]]

> **模态统一了截断、连通性等概念，是 HoTT 独有的抽象工具。**
> Modalities unify truncation, connectedness, and more — an abstract tool unique to HoTT.

**Definition (Reflective subuniverse).** 谓词 $P : \mathcal{U} \to \mathrm{Prop}$ 使得对每个 $A$ 存在 $\bigcirc A$（$P(\bigcirc A)$ 成立）和 $\eta_A : A \to \bigcirc A$，满足对每个 $B$ with $P(B)$：

$$(\bigcirc A \to B) \;\xrightarrow[\sim]{\;\;{-} \circ \eta_A\;\;}\; (A \to B)$$

**性质 / Properties of reflective subuniverses:**
- $A \in \mathcal{P}$ 当且仅当 $\eta_A$ 是等价。
- $\mathcal{P}$ 对所有极限封闭（乘积、pullback、恒等类型）。
- $\mathcal{P}$ 对 $\Pi$-types 封闭（指数理想）。
- 反射子保持有限乘积：$\bigcirc(A \times B) \simeq \bigcirc A \times \bigcirc B$。

**Definition (Modality).** 模态是 $\bigcirc : \mathcal{U} \to \mathcal{U}$，带有：
1. $\eta^{\bigcirc}_A : A \to \bigcirc A$
2. 归纳原理：对 $B : \bigcirc A \to \mathcal{U}$，$(\prod_a \bigcirc B(\eta(a))) \to \prod_z \bigcirc B(z)$
3. 计算规则：$\mathrm{ind}_{\bigcirc}(f)(\eta(a)) = f(a)$
4. 路径空间条件：$\eta_{z=z'} : (z = z') \to \bigcirc(z = z')$ 是等价

$A$ 是 **$\bigcirc$-modal** 如果 $\eta_A$ 是等价。

**Theorem.** 对反射子宇宙 $\mathcal{P}$，以下等价：
1. $\mathcal{P}$ 对 $\Sigma$-types 封闭。
2. 反射子有**归纳原理**（不仅是递归原理）：对 $B : \bigcirc A \to \mathcal{P}$，$(\prod_a B(\eta(a))) \to \prod_z B(z)$。

满足这些的反射子宇宙正是**模态**。

**$\bigcirc$-connected 和 $\bigcirc$-truncated 映射:**
- $f$ 是 $\bigcirc$-connected 如果 $\bigcirc(\mathrm{fib}_f(b))$ 对所有 $b$ contractible。
- $f$ 是 $\bigcirc$-truncated 如果 $\mathrm{fib}_f(b)$ 对所有 $b$ modal。
- 正交分解系统推广到任何模态。

**例子 / Examples of modalities:**
- $n$-截断 $\|{-}\|_n$
- 双重否定 $X \mapsto \neg\neg X$
- 开模态 (open modality) $X \mapsto (P \to X)$（$P$ 是 mere prop）
- 闭模态 (closed modality) $X \mapsto P * X$
- $f$-局部化 (localization)：$Z$ 是 $f$-local 如果 $(B \to Z) \xrightarrow{\sim} (A \to Z)$

**左正合模态 / Left exact modalities:** 保持 pullback 的模态。对应 Lawvere-Tierney 拓扑（elementary topos 论）和 sub-$(\infty,1)$-toposes。$n$-截断不是左正合的。

---

**独特工具 / Unique to HoTT:** Modalities 是 HoTT 中独特的抽象工具，将模态逻辑、反射子范畴、同伦截断统一到同一框架中。正交分解系统是对集合论中满射-单射分解的大规模推广。

Modalities are a uniquely HoTT abstraction, unifying modal logic, reflective subcategories, and homotopy truncation in a single framework. The orthogonal factorization system is a massive generalization of the surjection-injection factorization from set theory.
