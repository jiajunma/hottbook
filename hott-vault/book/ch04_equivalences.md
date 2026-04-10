---
title: "Chapter 4: Equivalences / 等价"
type: chapter-digest
created: 2026-04-08
sources: equivalences.tex
---

# Chapter 4: Equivalences / 等价

深入研究等价的"正确"定义。Quasi-inverse 不够好（不是 mere prop），需要 half adjoint、bi-invertible 或 contractible fibers。最终证明 univalence 蕴含 funext。

This chapter studies the "correct" definition of equivalence in depth. Quasi-inverse is insufficient (not a mere proposition); we need half adjoint, bi-invertible, or contractible fibers. The chapter concludes by showing univalence implies funext.

---

## 4.1 Quasi-inverses / 拟逆
[[Equivalences/quasi_inverses]]

> **核心问题 / Core Problem:** $\mathrm{qinv}(f)$ 不是 mere proposition，因此不适合作为等价的定义。
> The type $\mathrm{qinv}(f)$ is not a mere proposition, making it unsuitable as the definition of equivalence.

**Definition.** 对于 $f : A \to B$，其 quasi-inverse 类型为：

$$\mathrm{qinv}(f) :\equiv \sum_{g:B \to A} (f \circ g \sim \mathrm{id}_B) \times (g \circ f \sim \mathrm{id}_A)$$

**问题 / Problem:** 对于等价 $f$，$\mathrm{qinv}(f)$ 的自同伦空间 (auto-homotopy space) 非平凡。具体来说，$\mathrm{qinv}(f)$ 等价于 $(g \circ f \sim \mathrm{id}_A) \times (g \circ f \sim \mathrm{id}_A)$，后者一般不是 mere prop。在 univalence 下，这导致 $\mathrm{qinv}(\mathrm{id}_A) \simeq (A \to A) \times (A \to A)$，对非 set 的 $A$ 有无穷多不同证明。

For an equivalence $f$, $\mathrm{qinv}(f)$ is equivalent to $(g \circ f \sim \mathrm{id}_A) \times (g \circ f \sim \mathrm{id}_A)$, which is generally not a mere prop. Under univalence, $\mathrm{qinv}(\mathrm{id}_A) \simeq (A \to A) \times (A \to A)$, which has infinitely many distinct proofs for non-set types $A$.

**Theorem (qinv is not a prop).** 存在类型 $A$ 使得 $\mathrm{qinv}(\mathrm{id}_A)$ 不是 mere proposition。

---

## 4.2 Half Adjoint Equivalences / 半伴随等价
[[Equivalences/half_adjoint]]

> **关键洞察 / Key Insight:** 添加一个高阶 coherence 条件可以修复 $\mathrm{qinv}$ 的问题。
> Adding a single higher coherence condition fixes the problem with $\mathrm{qinv}$.

**Definition.** $f : A \to B$ 是 half adjoint equivalence 如果：

$$\mathrm{ishae}(f) :\equiv \sum_{g:B \to A} \sum_{\eta: g \circ f \sim \mathrm{id}_A} \sum_{\epsilon: f \circ g \sim \mathrm{id}_B} \prod_{x:A} \mathrm{ap}_f(\eta(x)) = \epsilon(f(x))$$

最后一个分量 $\tau$ 是关键的 coherence 条件，即三角恒等式 (triangle identity)。

The last component $\tau$ is the crucial coherence condition — the triangle identity.

**Theorem (ishae is a mere prop).** 对于任何 $f : A \to B$，$\mathrm{ishae}(f)$ 是 mere proposition。

*证明思路 / Proof idea:* 给定两个证明 $(g, \eta, \epsilon, \tau)$ 和 $(g', \eta', \epsilon', \tau')$，可以通过 $\eta$ 和 $\eta'$ 构造 $g = g'$，然后逐步传播等式到 $\epsilon$ 和 $\tau$。coherence 条件 $\tau$ 确保了这种传播的唯一性。

**Lemma (qinv to ishae).** 从 $\mathrm{qinv}(f)$ 可以构造 $\mathrm{ishae}(f)$。从 $(g, \epsilon, \eta)$ 出发，定义 $\epsilon'(b) :\equiv \overline{\epsilon(f(g(b)))} \cdot \mathrm{ap}_f(\eta(g(b))) \cdot \epsilon(b)$，然后新的 $\epsilon'$ 满足三角恒等式。

---

## 4.3 Bi-invertible Maps / 双可逆映射
[[Equivalences/bi_invertible]]

> **实用替代 / Practical Alternative:** 分别要求左逆和右逆比证明 coherence 更容易。
> Requiring separate left and right inverses is often easier to verify than proving a coherence condition.

**Definition.** $f : A \to B$ 是 bi-invertible 如果：

$$\mathrm{biinv}(f) :\equiv \left(\sum_{g:B \to A} g \circ f \sim \mathrm{id}_A\right) \times \left(\sum_{h:B \to A} f \circ h \sim \mathrm{id}_B\right)$$

**Theorem.** $\mathrm{biinv}(f)$ 是 mere proposition，且与 $\mathrm{ishae}(f)$ 等价。

*直觉 / Intuition:* 两个对称的半部分各自是 mere prop（因为类型 $\sum_{g:B \to A} g \circ f \sim \mathrm{id}_A$ 当 $f$ 是等价时是 contractible），且它们的乘积仍然是 mere prop。

---

## 4.4 Contractible Fibers / 可缩纤维
[[Equivalences/contractible_fibers]]

> **Voevodsky 的定义 / Voevodsky's definition:** 等价 = 所有纤维可缩。
> Equivalence = all fibers are contractible.

**Definition.** $f : A \to B$ 的纤维：$\mathrm{fib}_f(y) :\equiv \sum_{x:A} f(x) =_B y$

$$\mathrm{isContr}(f) :\equiv \prod_{y:B} \mathrm{isContr}(\mathrm{fib}_f(y))$$

**Theorem.** $\mathrm{isContr}(f)$ 是 mere proposition，且与 $\mathrm{ishae}(f)$ 等价。

*直觉 / Intuition:* 这是最概念清晰的定义——$f$ 是等价当且仅当它是"每个点上的 contractible fibration"。

**正式选择 / Official choice.** 书中选择 $\mathrm{isequiv}(f) \defeq \mathrm{ishae}(f)$ 作为正式定义，因为它包含最直接有用的数据（用于形式化）。但任何定义都可互换使用。

---

## 4.6 Surjections and Embeddings / 满射与嵌入
[[Equivalences/surjections_embeddings]]

> **等价 = 满射 + 嵌入 / Equivalence = Surjection + Embedding**

**Definition.** 设 $f : A \to B$。
- $f$ 是**满射 (surjective)** 如果对每个 $b : B$，$\|\mathrm{fib}_f(b)\|$ 成立。
- $f$ 是**嵌入 (embedding)** 如果对每个 $x, y : A$，$\mathrm{ap}_f : (x =_A y) \to (f(x) =_B f(y))$ 是等价。

当 $A, B$ 是集合时：嵌入等价于**单射 (injective)**：$\prod_{x,y:A} (f(x) =_B f(y)) \to (x =_A y)$。

满射不同于**分裂满射 (split surjection)**：$\prod_{b:B} \sum_{a:A} f(a) = b$。选择公理断言集合间的满射都是分裂的，但在 univalence 下并非所有满射都分裂。

**Theorem.** $f : A \to B$ 是等价当且仅当它既是满射又是嵌入。

$$\mathrm{isequiv}(f) \simeq \mathrm{isEmbedding}(f) \times \mathrm{isSurjective}(f)$$

---

## 4.7 Closure Properties of Equivalences / 等价的封闭性
[[Equivalences/closure_properties]]

**Theorem (2-out-of-3 property).** 设 $f : A \to B$，$g : B \to C$。若 $f, g, g \circ f$ 中任意两个是等价，则第三个也是。

**Definition (retract of a function).** $g : A \to B$ 是 $f : X \to Y$ 的 retract 如果存在以下交换图，带有适当的同伦和 coherence：

$$A \xrightarrow{s} X \xrightarrow{r} A, \quad B \xrightarrow{s'} Y \xrightarrow{r'} B$$

满足 $r \circ s \sim \mathrm{id}_A$，$r' \circ s' \sim \mathrm{id}_B$，以及纤维上的兼容性。

**Theorem.** 若 $g$ 是等价 $f$ 的 retract，则 $g$ 也是等价。

**Fiberwise equivalences / 纤维化等价.** 给定类型族 $P, Q : A \to \mathcal{U}$ 和 $f : \prod_{x:A} P(x) \to Q(x)$：

- **总空间映射 (total map):** $\mathrm{total}(f) : \sum_{x:A} P(x) \to \sum_{x:A} Q(x)$，定义为 $\mathrm{total}(f)(x, u) :\equiv (x, f(x, u))$。
- **Theorem.** $f$ 是 fiberwise equivalence（每个 $f(x)$ 是等价）当且仅当 $\mathrm{total}(f)$ 是等价。
- **关键引理:** $\mathrm{fib}_{\mathrm{total}(f)}(x, v) \simeq \mathrm{fib}_{f(x)}(v)$。

---

## 4.8 The Object Classifier / 对象分类器
[[Equivalences/object_classifier]]

> **宇宙 $\mathcal{U}$ 作为映射的分类空间 / The universe $\mathcal{U}$ classifies maps.**

**Lemma (fiber of a fibration).** 对于类型族 $B : A \to \mathcal{U}$，投影 $\pi_1 : \sum_{x:A} B(x) \to A$ 的纤维等价于 $B(a)$：

$$\mathrm{fib}_{\pi_1}(a) \simeq B(a)$$

**Lemma (total space of fibers).** 对于 $f : A \to B$，$A \simeq \sum_{b:B} \mathrm{fib}_f(b)$。

**Theorem (object classifier).** 对任何类型 $B$：

$$\chi : \left(\sum_{A : \mathcal{U}} (A \to B)\right) \simeq (B \to \mathcal{U})$$

其中 $\chi((A, f), b) \defeq \mathrm{fib}_f(b)$，$\psi(P) \defeq (\sum_{b:B} P(b), \pi_1)$。

**Theorem (pullback characterization).** 对于 $f : A \to B$，以下是 pullback 方形：

$$\begin{array}{ccc} A & \xrightarrow{\vartheta_f} & \mathcal{U}_* \\ \downarrow f & & \downarrow \pi_1 \\ B & \xrightarrow{\chi_f} & \mathcal{U} \end{array}$$

这是 $(\infty,1)$-topos 论中 object classifier 的类型论版本。

---

## 4.9 Univalence Implies Function Extensionality / Univalence 蕴含函数外延性
[[Axioms/univalence_implies_funext]]

> **HoTT 只需一个额外公理 / HoTT needs only one extra axiom.**

证明分两步：univalence $\Rightarrow$ weak funext $\Rightarrow$ funext。

**Definition (Weak function extensionality).** 弱函数外延性原则断言：

$$\left(\prod_{x:A} \mathrm{isContr}(P(x))\right) \to \mathrm{isContr}\left(\prod_{x:A} P(x)\right)$$

**Step 1 (Univalence $\Rightarrow$ Weak Funext).**

- **Lemma.** 在 univalent 宇宙中，对于等价 $e : A \simeq B$，后合成给出等价 $(X \to A) \simeq (X \to B)$。
- **Corollary.** 设 $P : A \to \mathcal{U}$ 是 contractible 类型族，则 $\pi_1 : (\sum_{x:A} P(x)) \to A$ 是等价，后合成 $\alpha : (A \to \sum_{x:A} P(x)) \simeq (A \to A)$ 也是等价。
- **Theorem.** $\prod_{x:A} P(x)$ 是 $\mathrm{fib}_\alpha(\mathrm{id}_A)$ 的 retract。由于后者 contractible，$\prod_{x:A} P(x)$ 也 contractible。

**Step 2 (Weak Funext $\Rightarrow$ Funext).** 不需要 univalence。

- 要证 $\mathrm{happly}(f, g) : (f = g) \to (f \sim g)$ 是等价。
- 由 fiberwise 等价定理，只需证总空间映射是等价。
- 源 $\sum_g (f = g)$ contractible；目标 $\sum_g (f \sim g)$ 等价于 $\prod_{x:A} \sum_{u:P(x)} f(x) = u$，是 contractible 类型的乘积，由弱 funext 也 contractible。

---

**要点 / Takeaway:** 四种等价定义（qinv, ishae, biinv, contractible fibers）在逻辑上等价，但只有后三者是 mere proposition，因此适合作为数学中"等价"的定义。最终选择 $\mathrm{isequiv}(f) \defeq \mathrm{ishae}(f)$。

The four notions of equivalence are logically equivalent, but only the latter three are mere propositions. The official choice is $\mathrm{isequiv}(f) \defeq \mathrm{ishae}(f)$.
