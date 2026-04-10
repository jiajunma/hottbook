---
title: "Chapter 10: Set Theory / 集合论"
type: chapter-digest
---

# Chapter 10: Set Theory / 集合论

证明 HoTT 中的集合（0-type）足以发展经典集合论的核心内容：$\text{Set}$ 是 $\Pi W$-预拓扑，在适当公理下是初等拓扑；构造基数、序数，以及 ZF 风格的累积层叠 $V$。

Shows that sets (0-types) in HoTT suffice for classical set theory: $\text{Set}$ is a $\Pi W$-pretopos (elementary topos with resizing); cardinal and ordinal numbers are developed structurally; and the ZF cumulative hierarchy $V$ is constructed as a HIT.

> **核心观点 / Key perspective:** HoTT 中的集合不是 ZF 集合（没有全局 $\in$ 关系），而是结构性集合论（structural set theory）。但本章证明了两个方向的兼容性：HoTT 集合行为良好，且可以在 HoTT 内部构造 ZF 风格的材料集合论。

---

## 10.1 集合范畴 / The Category of Sets
[[Set_Theory/category_of_sets]]

### 极限与余极限 / Limits and Colimits

$\text{Set}$ 是**完备的**（有所有有限极限）：
- 积：$A \times B$（集合对乘积封闭）
- 拉回：$\sum_{a:A} \sum_{b:B} f(a) = g(b)$
- 无穷积：$\prod_{a:A} B(a)$

$\text{Set}$ 是**余完备的**：
- 余积：$A + B$，$\emptyset$
- 依赖和：$\sum_{a:A} B(a)$
- 推出（Ch6 的构造在 $n$-type 上封闭）

### 像与正则范畴 / Images and Regular Category

**Definition.** $f : A \to B$ 的**像**为 $\text{im}(f) \defeq \sum_{b:B} \| \text{fib}_f(b) \|_{-1}$。

分解 $A \xrightarrow{\tilde{f}} \text{im}(f) \xrightarrow{i_f} B$，其中 $\tilde{f}$ 满射，$i_f$ 单射。

**Lemma.** 函数 $f : A \to B$（集合间）是单射当且仅当是 $\text{Set}$ 中的单态射。

**Lemma.** 以下等价（对集合间函数 $f$）：(1) $f$ 是满射范畴论意义的满态射；(2) 映射锥 $C_f$ 可缩；(3) $f$ 是满射。

**Theorem.** $\text{Set}$ 是正则范畴：有限完备、核对的余等化子存在、正则满态射的拉回仍是正则满态射。

### 商与有效等价关系 / Quotients and Effective Equivalence Relations

**Definition.** 等价关系 $R : A \to A \to \text{Prop}$ 是**有效的**，若 $\sum_{x,y:A} R(x,y)$ 的两个投影的余等化子 $c_R$ 满足：对所有 $x, y : A$，$(c_R(x) = c_R(y)) \simeq R(x,y)$。

**Lemma.** 所有等价关系在 $\text{Set}$ 中是有效的。

Proof uses encode-decode: extend $R$ to $\widetilde{R} : A/R \to A/R \to \text{Prop}$ by double induction on the quotient, then show $\widetilde{R}(w,w') \simeq (w = w')$.

**Theorem.** 核函数的关系 $\ker(f, x, y) \defeq (f(x) = f(y))$ 对任何函数 $f$ 是有效的。

### $\Pi W$-预拓扑与初等拓扑 / $\Pi W$-Pretopos and Elementary Topos

**Theorem.** $\text{Set}$ 是 $\Pi W$-预拓扑：局部笛卡尔闭、不相交有限余积、有效等价关系、多项式自函子的初始代数。

> 这是构造性、谓词性设定下的"拓扑"概念，足以进行大部分日常数学。

**Theorem.** 若存在 $\Omega : \mathcal{U}$（所有 mere proposition 的类型），则 $\text{Set}_\mathcal{U}$ 是初等拓扑。

子对象分类器：$\text{Prop}$（univalence 保证它分类单态射）。需要命题缩放 (propositional resizing) 使之成为小类型。

### 选择公理蕴含排中律 / AC Implies LEM

**Lemma.** 若 $A$ 是 mere proposition，则其悬挂 $\Sigma A$ 是集合，且 $A \simeq (\text{N} =_{\Sigma A} \text{S})$。

**Theorem (Diaconescu).** 选择公理蕴含排中律。

Proof: 对 mere proposition $A$，构造满射 $\mathbf{2} \to \Sigma A$；AC 给出截面；$\mathbf{2}$ 上等式可判定，由此得到 $A + \neg A$。

**Theorem.** 若选择公理成立，则 $\text{Set}$ 是良指向 (well-pointed) 的布尔初等拓扑（Lawvere 的 ETCS 公理）。

---

## 10.2 基数 / Cardinal Numbers
[[Set_Theory/cardinal_numbers]]

**Definition.** 基数类型 $\text{Card} \defeq \| \text{Set} \|_0$。基数 $|A|$ 是集合 $A$ 在 $\| \text{Set} \|_0$ 中的像。

**Definition.** 基数运算（通过截断归纳定义）：
- 加法：$|A| + |B| \defeq |A + B|$
- 乘法：$|A| \cdot |B| \defeq |A \times B|$
- 指数：$|A|^{|B|} \defeq |B \to A|$

**Lemma.** $\text{Card}$ 是交换半环，指数满足标准恒等式。

**Definition.** 基数不等式 $|A| \le |B| \defeq \| \text{Inj}(A, B) \|_{-1}$（仅仅存在单射）。

**Lemma.** 基数不等式是预序。

**Theorem (Schroeder-Bernstein).** 假设排中律，若有 $A \hookrightarrow B$ 和 $B \hookrightarrow A$，则 $A \cong B$。

**Corollary.** 假设排中律，基数不等式是偏序。

**Theorem (Cantor).** 不存在满射 $A \twoheadrightarrow (A \to \mathbf{2})$。

Proof: 对角线论证，$g(a) \defeq \neg f(a)(a)$。

**Corollary.** 假设排中律，对任何基数 $\alpha$，有 $\alpha \le 2^\alpha$ 且 $\alpha \ne 2^\alpha$。

---

## 10.3 序数 / Ordinal Numbers
[[Set_Theory/ordinal_numbers]]

**Definition (Accessibility).** 给定集合 $A$ 上的关系 $<$，$a : A$ 是**可达的** (accessible)，若对所有 $b < a$，$b$ 可达。这是归纳定义的 mere property。

**Definition.** 关系 $<$ 是**良基的** (well-founded)，若 $A$ 的每个元素都可达。

**良基归纳 / Well-founded induction:** 若从 $\forall b < a.\, P(b)$ 可证 $P(a)$，则 $\forall a.\, P(a)$。

**Lemma (Well-founded Recursion).** 若 $g : \mathcal{P}(B) \to B$ 且 $<$ 在 $A$ 上良基，则存在 $f : A \to B$ 使得 $f(a) = g(\{ f(a') \mid a' < a \})$。

**Example.** 自然数上的标准序 $<$ 是良基的（由普通归纳推出强归纳）。W-类型上也有自然的良基关系。

**Definition (Ordinal).** 序数是集合 $A$ 配备关系 $<$ 使得：
- $<$ 是良基的
- $<$ 是传递的
- $<$ 是可扩展的（$(\forall c.\, c < a \Leftrightarrow c < b) \Rightarrow a = b$）

> **与经典定义的区别 / Difference from classical:** 经典中序数是特殊的集合（传递集）。HoTT 中序数是结构性的——集合加良序关系，由 univalence 保证"同构的良序集相等"。

**Lemma.** 假设排中律，$<$ 是良基的当且仅当每个非空子集有最小元。

**序数算术 / Ordinal arithmetic:** 加法（将两个良序拼接）、乘法（字典序积）等均可定义，满足标准性质。

---

## 10.4 经典良序 / Classical Well-Orderings
[[Set_Theory/classical_well_orderings]]

在经典逻辑（排中律 LEM）下：

- 良序简化：每个非空子集有最小元
- **Hartogs 数**的构造：对任何集合 $A$，存在序数不可嵌入 $A$
- **良序定理**与**选择公理**等价
- **Zorn 引理**：若偏序集的每条链有上界，则有极大元

> 这些结果在构造数学中需要额外公理。本节展示经典集合论的工具在 HoTT + LEM 下如何重现。

---

## 10.5 累积层叠 / The Cumulative Hierarchy
[[Set_Theory/cumulative_hierarchy]]

**Definition.** 类型 $V$ 是以下 HIT：
- 构造器 $\text{set} : (A : \text{Set}) \to (A \to V) \to V$
- 路径构造器：若 $f : A \to V$ 和 $g : B \to V$ 有相同的"像"（即存在相互覆盖的映射），则 $\text{set}(A, f) = \text{set}(B, g)$
- 集合截断 (set-truncation)

直觉：$\text{set}(A, f)$ 表示集合 $\{ f(a) \mid a : A \}$。

**成员关系 / Membership:** 定义 $x \in_V \text{set}(A, f) \defeq \exists a : A.\, x = f(a)$。

**Theorem.** $V$ 满足以下 ZF 公理（模式）：
- **$\in$-归纳** (Foundation/Regularity)：通过 $V$ 的归纳原理
- **外延性**：由路径构造器
- **空集、配对、并集**
- **分离 (Separation)**：$\{ x \in a \mid \varphi(x) \}$
- **替换 (Replacement)**：像存在

> **意义 / Significance:** 在 HoTT 内部构造了 ZF 材料集合论的模型。这证明了 HoTT 不仅是同伦论的基础，也能容纳传统集合论——集合论嵌入为 HoTT 的 0-type 层。

第三种构造商集的方式：将集合 $A$ 上的等价关系 $R$ 视为以 $A$ 为对象、$R$ 为 hom-集的预范畴，其 Rezk completion 的对象类型即为商 $A/R$。

---

**总体意义 / Overall significance:** 本章证明 HoTT 不仅是同伦论的基础，也能容纳传统集合论。集合论嵌入为 HoTT 的一个"层"（0-type 层），而 HoTT 的高维结构提供了更丰富的世界。$\Pi W$-预拓扑结构保证了 HoTT 中的集合对日常数学足够好用，而累积层叠 $V$ 证明了与 ZF 的兼容性。
