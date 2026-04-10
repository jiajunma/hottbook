---
title: "Chapter 9: Category Theory / 范畴论"
type: chapter-digest
---

# Chapter 9: Category Theory / 范畴论

在 HoTT 中重新发展范畴论。核心创新：区分预范畴（precategory）和范畴（category），后者要求 $\text{idtoiso}$ 是等价——这是 univalence 公理在范畴论中的类比。结果：全忠实本质满射函子自动是等价，无需选择公理。

Redeveloping category theory in HoTT. Core innovation: distinguishing precategories from categories, where the latter requires $\text{idtoiso}$ to be an equivalence — the categorical analogue of univalence. Result: fully faithful essentially surjective functors are automatically equivalences, no axiom of choice needed.

> **关键三分法 / Key trichotomy:** 预范畴是原材料；**范畴**（$\text{idtoiso}$ 是等价）、**严格范畴**（对象构成集合）、**$\dagger$-范畴**（有 $\dagger$ 结构）是三种不同的"修正"方式。
>
> Precategories are raw material; **categories** (idtoiso is equiv), **strict categories** (objects form a set), and **$\dagger$-categories** (have dagger structure) are three different "completions."

---

## 9.1 范畴与预范畴 / Categories and Precategories
[[Category_Theory/precategories]]

**Definition (Precategory).** 预范畴 $A$ 由以下数据构成：
1. 类型 $A_0$（对象 / objects）
2. 对每对 $a, b : A$，**集合** $\hom_A(a,b)$（态射 / morphisms）
3. 恒等态射 $1_a : \hom_A(a,a)$
4. 合成 $g \circ f : \hom_A(a,c)$（对 $f : \hom_A(a,b)$，$g : \hom_A(b,c)$）
5. 单位律：$1_b \circ f = f = f \circ 1_a$
6. 结合律：$h \circ (g \circ f) = (h \circ g) \circ f$

**Definition (Isomorphism).** $f : \hom_A(a,b)$ 是同构，若存在 $g : \hom_A(b,a)$ 使得 $g \circ f = 1_a$ 且 $f \circ g = 1_b$。记 $a \cong b$ 为同构类型。

**Lemma.** "$f$ 是同构" 是 mere proposition。因此 $a \cong b$ 是集合。

**Lemma (idtoiso).** 在预范畴中，$(a = b) \to (a \cong b)$。

**Definition (Category).** 范畴是预范畴，使得对所有 $a, b : A$，函数 $\text{idtoiso}_{a,b}$ 是等价。

A **category** is a precategory such that $\text{idtoiso} : (a = b) \to (a \cong b)$ is an equivalence for all $a, b$.

> **核心类比 / Core analogy:** 正如 univalence 公理断言 $(A =_{\mathcal{U}} B) \simeq (A \simeq B)$，范畴条件断言 $(a =_{A_0} b) \simeq (a \cong_A b)$。

**Example.** $\text{Set}$ 是范畴（由 univalence 保证：集合间的等价即双射即同构）。

**Lemma.** 在范畴中，对象类型是 1-type。

**Example (Preorders).** hom-集都是 mere proposition 的预范畴等价于预序。范畴条件则要求反对称性，即偏序。

**Example (Discrete Categories).** 任何 1-type $X$ 给出范畴，$\hom(x,y) \defeq (x = y)$。若 $X$ 是集合则称为离散范畴。

---

## 9.2 函子与自然变换 / Functors and Transformations
[[Category_Theory/functors]]

**Definition (Functor).** 函子 $F : A \to B$ 由以下构成：
1. 对象映射 $F_0 : A_0 \to B_0$
2. 态射映射 $F_{a,b} : \hom_A(a,b) \to \hom_B(Fa, Fb)$
3. 保持恒等：$F(1_a) = 1_{Fa}$
4. 保持合成：$F(g \circ f) = Fg \circ Ff$

**Definition (Natural Transformation).** 自然变换 $\gamma : F \to G$ 由分量 $\gamma_a : \hom_B(Fa, Ga)$ 构成，满足自然性：$Gf \circ \gamma_a = \gamma_b \circ Ff$。

**Definition (Functor Precategory).** $B^A$ 以函子为对象，自然变换为态射。

**Lemma.** 自然变换 $\gamma$ 是 $B^A$ 中同构当且仅当每个分量 $\gamma_a$ 是 $B$ 中同构。

**Theorem.** 若 $A$ 是预范畴，$B$ 是范畴，则 $B^A$ 是范畴。

If $A$ is a precategory and $B$ is a category, then $B^A$ is a category.

推论：范畴之间自然同构的函子是相等的。

---

## 9.3 伴随 / Adjunctions
[[Category_Theory/adjunctions]]

**Definition.** 函子 $F : A \to B$ 是**左伴随**，若存在：
- 函子 $G : B \to A$（右伴随）
- 单位 $\eta : 1_A \to GF$，余单位 $\epsilon : FG \to 1_B$
- 三角恒等式：$(\epsilon F)(F\eta) = 1_F$ 且 $(G\epsilon)(\eta G) = 1_G$

**Lemma.** 若 $A$ 是范畴，则 "$F$ 是左伴随" 是 mere proposition。

> **证明关键 / Proof key:** 若有两组伴随数据 $(G,\eta,\epsilon)$ 和 $(G',\eta',\epsilon')$，可构造自然同构 $G \cong G'$，再由函子范畴的范畴性得到 $G = G'$；单位和余单位也由此确定。

---

## 9.4 范畴的等价 / Equivalences of Categories
[[Category_Theory/equivalences]]

**Definition.** 函子 $F : A \to B$ 是**(预)范畴等价**，若它是左伴随且 $\eta$、$\epsilon$ 都是同构。

**Definition.** $F$ 是**全忠实** (fully faithful) 若每个 $F_{a,b}$ 是等价。$F$ 是**本质满射** (essentially surjective) 若对每个 $b : B$，仅仅存在 $a : A$ 使得 $Fa \cong b$。$F$ 是**弱等价** (weak equivalence) 若全忠实且本质满射。

**Lemma.** 对范畴之间的函子，等价 $\Leftrightarrow$ 弱等价 $\Leftrightarrow$ 全忠实+本质满射。

> **无需选择！ / No choice needed!** 在经典集合论中，"全忠实+本质满射 $\Rightarrow$ 等价" 等价于选择公理。在 HoTT 范畴中这是免费的，因为范畴条件将同构提升为等式，给出唯一选择原理所需的收缩性。

**Theorem.** 若 $A$、$B$ 是范畴，则 $(A = B) \simeq (A \simeq B)$（范畴等价）。

**Corollary.** 范畴的类型是 2-type。

---

## 9.5 Yoneda 引理 / The Yoneda Lemma
[[Category_Theory/yoneda]]

**Definition.** Yoneda 嵌入 $\mathsf{y} : A \to \text{Set}^{A^{\text{op}}}$ 由 hom-函子 $\hom_A : A^{\text{op}} \times A \to \text{Set}$ 诱导。

**Theorem (Yoneda Lemma).** 对任何预范畴 $A$，$a : A$，函子 $F : \text{Set}^{A^{\text{op}}}$：
$$\hom_{\text{Set}^{A^{\text{op}}}}(\mathsf{y}(a), F) \cong F(a)$$
且关于 $a$ 和 $F$ 自然。

同构的两个方向：$\alpha \mapsto \alpha_a(1_a)$ 和 $x \mapsto (\alpha_{a'}(f) \defeq F_{a,a'}(f)(x))$。

**Corollary.** Yoneda 嵌入 $\mathsf{y}$ 是全忠实的。

**Corollary.** 若 $A$ 是范畴，则 $\mathsf{y}_0 : A_0 \to (\text{Set}^{A^{\text{op}}})_0$ 是嵌入。特别地，$\mathsf{y}(a) = \mathsf{y}(b) \Rightarrow a = b$。

**Theorem.** 在范畴中，"$F$ 是可表函子" 是 mere proposition。

---

## 9.6 严格范畴 / Strict Categories
[[Category_Theory/strict_categories]]

**Definition.** **严格范畴**是对象类型为集合的预范畴。

注意：严格范畴不一定是范畴。范畴是严格范畴当且仅当它是 gaunt 的（每个自同构是恒等态射）。

**Example.** 给定范畴 $A$ 和对象 $x$，单态射范畴 $\text{mono}(A, x)$ 是严格范畴（因为单态射的唯一性使得等式是 mere proposition）。

**Example (Galois Theory).** 有限 Galois 扩张 $E/F$ 的中间域范畴与 Galois 群的子群范畴是**同构的**（不仅仅是等价的）——严格范畴上的同构是正确的"相同"概念。

---

## 9.7 $\dagger$-范畴 / Dagger Categories
[[Category_Theory/dagger_categories]]

**Definition.** $\dagger$-预范畴是预范畴加上：
1. $\dagger : \hom_A(x,y) \to \hom_A(y,x)$
2. $(1_x)^\dagger = 1_x$，$(g \circ f)^\dagger = f^\dagger \circ g^\dagger$，$(f^\dagger)^\dagger = f$

**Definition.** 态射 $f$ 是**幺正的 (unitary)**若 $f^\dagger \circ f = 1$ 且 $f \circ f^\dagger = 1$。

**Definition.** $\dagger$-范畴是 $\dagger$-预范畴使得 $(x = y) \to (x \cong_{\text{unitary}} y)$ 是等价。

**Example.** 有限维内积空间的范畴 $\text{Hilb}$（线性映射为态射）是 $\dagger$-范畴（$\dagger$ = 伴随），但**不是**范畴（不是每个线性同构都是幺正的/等距的）。

> **HoTT 的解决 / HoTT resolution:** 经典范畴论中 $\dagger$-范畴中"正确的相同概念应该是幺正同构而非一般同构"的困惑，在 HoTT 中自然消解：$\dagger$-范畴只是另一种预范畴。

---

## 9.8 结构恒等原理 / The Structure Identity Principle
[[Category_Theory/structure_identity]]

**Definition (Notion of Structure).** 范畴 $X$ 上的**结构概念** $(P, H)$ 由以下构成：
1. 类型族 $P : X_0 \to \mathcal{U}$（结构）
2. mere proposition $H_{\alpha\beta}(f)$（同态条件），保持恒等和合成
3. **标准**意味着 $\le_x$ 是偏序（$(\alpha \le_x \beta) \defeq H_{\alpha\beta}(1_x)$）

**Theorem (Structure Identity Principle).** 若 $X$ 是范畴且 $(P,H)$ 是标准结构概念，则结构预范畴 $\text{Str}_{(P,H)}(X)$ 是范畴。

> **意义 / Significance:** 这给出了 "同构结构相等" 的统一证明——适用于群、环、拓扑空间、序域等一切标准一阶结构。这是 univalence 最强大的应用之一。

**Example.** 用 SIP 可以替代证明函子范畴 $B^A$ 是范畴的直接论证。

**Example.** 对任何一阶签名 $\Omega$，$\Omega$-结构的预范畴是范畴。

---

## 9.9 Rezk Completion
[[Category_Theory/rezk_completion]]

**Theorem.** 对任何预范畴 $A$，存在范畴 $\widehat{A}$ 和弱等价 $A \to \widehat{A}$。

**构造一 (Yoneda):** $\widehat{A}_0 \defeq \{ F : \text{Set}^{A^{\text{op}}} \mid \exists a : A.\, \mathsf{y}(a) \cong F \}$。全忠实且本质满射。缺点：提升宇宙层级。

**构造二 (HIT):** $\widehat{A}_0$ 由以下生成：
- 函数 $i : A_0 \to \widehat{A}_0$
- 对 $e : a \cong b$，路径 $j(e) : i(a) = i(b)$
- $j(1_a) = \text{refl}$，$j(g \circ f) = j(f) \cdot j(g)$
- 1-截断

**Theorem (Universal Property).** 若 $H : A \to B$ 是弱等价，$C$ 是范畴，则 $(\_ \circ H) : C^B \to C^A$ 是同构。

**Theorem.** 预范畴 $C$ 是范畴当且仅当它"看到"所有弱等价为等价（即 $(\_ \circ H) : C^B \to C^A$ 对所有弱等价 $H$ 是同构）。

**Example.** 类型 $X$ 的基本预群胚的 Rezk completion 是基本群胚，可等同于 $\| X \|_1$。

---

**HoTT 视角 / HoTT perspective:** 经典范畴论中的许多技术困难（"evil"、coherence、选择公理的依赖）在 HoTT 中自然消解。Univalence 提供的结构等式原理和范畴的定义本身就是核心工具。
