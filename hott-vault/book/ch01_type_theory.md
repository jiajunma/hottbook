---
title: "Chapter 1: Type Theory / 类型论"
type: chapter-digest
tags: [type-theory, foundations, HoTT]
created: 2026-04-08
book: "Homotopy Type Theory: Univalent Foundations of Mathematics"
chapter: 1
sections: [1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 1.10, 1.11, 1.12]
---

# Chapter 1: Type Theory / 类型论

这一章建立类型论的基本语言。从判断和规则出发，逐步引入所有基本类型构造器，最终到达恒等类型——HoTT 的关键起点。全章仅由**规则**（rules）组成，不引入任何**公理**（axioms）——这保证了类型论的良好计算性质。

This chapter establishes the basic language of type theory. Starting from judgments and rules, it progressively introduces all fundamental type formers, culminating in the identity type — the key starting point of HoTT. The entire chapter consists only of **rules**, with no **axioms** — this ensures good computational properties.

> **每种类型构造器都遵循统一模式 / Every type former follows a uniform pattern:** Formation, Introduction, Elimination, Computation, (optional) Uniqueness.

---

## 1.1 Type theory vs set theory / 类型论 vs 集合论
[[Foundations/judgment]]

### 核心思想 / Key Idea

> 类型论是自足的演绎系统，不需要嵌入到一阶逻辑中。

集合论有**两层**：一阶逻辑（演绎系统）+ 集合论公理（如 ZFC）。类型论只有**一层**：类型（types）同时扮演集合和命题的角色。

Set theory has **two layers**: first-order logic (deductive system) + set theory axioms (e.g. ZFC). Type theory has only **one layer**: types simultaneously play the roles of sets and propositions.

### 判断形式 / Forms of Judgment

类型论基于两种判断（judgments）：

| 判断 / Judgment | 含义 / Meaning |
|---|---|
| $a : A$ | "$a$ 是类型 $A$ 的对象" / "$a$ is an object of type $A$" |
| $a \equiv b : A$ | "$a$ 和 $b$ 是类型 $A$ 中定义相等的对象" / "$a$ and $b$ are definitionally equal objects of type $A$" |

**关键区别 / Key distinction:**

- **判断等式 $a \equiv b$**（judgmental/definitional equality）：元理论层面，算法可判定，不可否定或假设。如 $f(x) \defeq x^2$ 时 $f(3) \equiv 3^2$。
- **命题等式 $a =_A b$**（propositional equality）：对象层面，是一个**类型**，可以有多个居民（witnesses）。

- **Judgmental equality $a \equiv b$**: metatheoretic, algorithmically decidable, cannot be negated or assumed. E.g. $f(3) \equiv 3^2$ when $f(x) \defeq x^2$.
- **Propositional equality $a =_A b$**: object-level, it is a **type** that can have multiple inhabitants.

### $a : A$ vs $a \in A$ / 判断 vs 命题

| 集合论 / Set theory | 类型论 / Type theory |
|---|---|
| $a \in A$ 是**命题**（可否定、可假设） | $a : A$ 是**判断**（不可否定、不可假设） |
| $a$ 独立于 $A$ 存在 | $a$ 天然属于某个类型 |
| "设 $x$ 为自然数" = "设 $x$ 为物且 $x \in \mathbb{N}$" | "设 $x : \mathbb{N}$" 是原子语句 |

### 上下文 / Context

判断可依赖**假设**（assumptions）$x : A$。所有假设的有序列表称为**上下文**（context）。后面的假设可依赖前面的——拓扑上可理解为"参数空间"。

Judgments may depend on **assumptions** $x : A$. The ordered list of all such assumptions is the **context**. Later assumptions may depend on earlier ones — topologically, this can be understood as a "parameter space".

### 规则 vs 公理 / Rules vs Axioms

> 类型论中信息由**规则**承载，无需**公理**。这使得计算性质（如 canonicity）成为可能。

In set theory, rules are just logic; all mathematical content is in axioms. In type theory, rules carry all the information, enabling good computational properties (like canonicity). Later chapters will add axioms (notably univalence) where needed.

### 为什么重要 / Why it matters

理解判断（judgment）与命题（proposition）的区别是进入类型论的第一道门槛。混淆二者会导致许多初学者困惑：例如试图"否定" $a : A$，或将 $a \equiv b$ 当作可假设的前提。

---

## 1.2 Function types / 函数类型
[[Foundations/function_type]]

> 函数是类型论的**原始概念**（primitive），不是定义为函数关系的集合。

### 规则 / Rules

**Formation / 构成:**
$$A : \mathcal{U}, \quad B : \mathcal{U} \quad \Longrightarrow \quad (A \to B) : \mathcal{U}$$

**Introduction / 引入 ($\lambda$-abstraction):**
给定 $x : A$ 下的表达式 $\Phi : B$，构造：
$$\lambda(x : A).\, \Phi \;:\; A \to B$$

等价地，可直接定义 $f : A \to B$：$f(x) \defeq \Phi$。

**Elimination / 消去 (function application):**
$$f : A \to B, \quad a : A \quad \Longrightarrow \quad f(a) : B$$

**Computation / 计算 ($\beta$-reduction):**
$$(\lambda(x : A).\, \Phi)(a) \equiv \Phi[a/x]$$
其中 $\Phi[a/x]$ 是将 $\Phi$ 中 $x$ 替换为 $a$（避免变量捕获）。

**Uniqueness / 唯一性 ($\eta$-expansion):**
$$f \equiv \lambda x.\, f(x)$$
即函数由其值唯一确定。

### 柯里化 / Currying

多参数函数通过迭代函数类型表示：$f : A \to B \to C$（右结合）。应用时 $f(a, b) \defeq f(a)(b)$（左结合）。

Multi-argument functions are represented via iterated function types: $f : A \to B \to C$ (right-associative). Application: $f(a, b) \defeq f(a)(b)$ (left-associative).

### 示例 / Examples

- 常函数：$(\lambda(x : A).\, y) : A \to B$（给定 $y : B$）
- 加倍函数：$(\lambda(x : \mathbb{N}).\, x + x) : \mathbb{N} \to \mathbb{N}$

### 变量捕获 / Variable Capture

若 $f(x) \defeq \lambda(y : \mathbb{N}).\, x + y$，则 $f(y)$ **不是** $\lambda(y).\, y + y$，而是 $\lambda(z).\, y + z$（$\alpha$-conversion）。这与积分 $f(x) \defeq \int_1^2 \frac{dt}{x-t}$ 中 $f(t) = \int_1^2 \frac{ds}{t-s}$ 的道理完全一致。

### 为什么重要 / Why it matters

函数类型是所有后续构造的基石。$\lambda$-抽象和函数应用是类型论中最基本的运算。$\beta$/$\eta$ 规则建立了计算的基本律。

---

## 1.3 Universes and families / 宇宙与类型族
[[Foundations/universes]]

> 宇宙使我们能够"谈论类型"——类型本身成为数学对象。

### 宇宙层级 / Universe Hierarchy

为避免 Russell 悖论（$\mathcal{U}_\infty : \mathcal{U}_\infty$ 导致不一致），引入层级：
$$\mathcal{U}_0 : \mathcal{U}_1 : \mathcal{U}_2 : \cdots$$

**Cumulativity / 累积性:** 若 $A : \mathcal{U}_i$ 则 $A : \mathcal{U}_{i+1}$。

**Typical ambiguity / 典型歧义:** 通常省略下标，写 $\mathcal{U}$，甚至 $\mathcal{U} : \mathcal{U}$（读作 $\mathcal{U}_i : \mathcal{U}_{i+1}$）。验证论证正确性时需检查下标可一致分配。

### 类型族 / Type Families

**定义:** 函数 $B : A \to \mathcal{U}$ 称为 $A$ 上的**类型族**（family of types），也称**依赖类型**（dependent type）。

**示例:**
- 有限集族 $\mathrm{Fin} : \mathbb{N} \to \mathcal{U}$，其中 $\mathrm{Fin}(n)$ 有恰好 $n$ 个元素 $0_n, 1_n, \ldots, (n-1)_n$
- 常类型族（constant family）：$(\lambda(x : A).\, B) : A \to \mathcal{U}$
- **非**例子：没有类型族 $\lambda(i : \mathbb{N}).\, \mathcal{U}_i$（没有足够大的宇宙作为值域）

**Small types / 小类型:** 属于某个固定宇宙 $\mathcal{U}$ 的类型。

### 为什么重要 / Why it matters

类型族是 $\Pi$-type 和 $\Sigma$-type 的前提。宇宙 $\mathcal{U}$ 本身是类型这一事实极为微妙——它使我们可以通过**递归**定义类型族（如用 $\mathrm{rec}_\mathbf{2}$ 定义 $A + B$）。

---

## 1.4 Dependent function types ($\Pi$-types) / 依赖函数类型
[[Foundations/pi_type]]

> $\Pi$-type 统一了函数类型和全称量词——返回类型随输入变化。

### 规则 / Rules

**Formation / 构成:**
$$A : \mathcal{U}, \quad B : A \to \mathcal{U} \quad \Longrightarrow \quad \prod_{(x:A)} B(x) : \mathcal{U}$$

当 $B$ 为常族时退化为普通函数类型：$\prod_{(x:A)} B \equiv (A \to B)$。

**Introduction / 引入:**
$$\lambda(x : A).\, \Phi \;:\; \prod_{(x:A)} B(x) \qquad \text{（其中 } \Phi : B(x) \text{ 假设 } x : A \text{）}$$

**Elimination / 消去:**
$$f : \prod_{(x:A)} B(x), \quad a : A \quad \Longrightarrow \quad f(a) : B(a)$$

**Computation / 计算 ($\beta$):**
$$(\lambda(x : A).\, \Phi)(a) \equiv \Phi[a/x]$$

**Uniqueness / 唯一性 ($\eta$):**
$$f \equiv \lambda x.\, f(x) \qquad \text{for any } f : \prod_{(x:A)} B(x)$$

### 示例 / Examples

**多态恒等函数 / Polymorphic identity:**
$$\mathrm{id} : \prod_{(A:\mathcal{U})} A \to A, \qquad \mathrm{id} \defeq \lambda(A : \mathcal{U}).\,\lambda(x : A).\, x$$

**Swap 函数:**
$$\mathsf{swap} : \prod_{(A,B,C:\mathcal{U})} (A \to B \to C) \to (B \to A \to C)$$
$$\mathsf{swap}(A,B,C,g) \defeq \lambda b.\,\lambda a.\, g(a)(b)$$

**有限集最大元素:**
$$\mathrm{fmax} : \prod_{(n:\mathbb{N})} \mathrm{Fin}(n+1), \qquad \mathrm{fmax}(n) \defeq n_{n+1}$$

### 多参数依赖函数 / Multi-argument

给定 $A : \mathcal{U}$、$B : A \to \mathcal{U}$、$C : \prod_{(x:A)} B(x) \to \mathcal{U}$，可构造：
$$\prod_{(x:A)} \prod_{(y:B(x))} C(x,y)$$

### 为什么重要 / Why it matters

$\Pi$-type 是类型论核心表达力的来源。在命题即类型的对应下，$\prod_{(x:A)} P(x)$ 就是全称量词"对所有 $x : A$，$P(x)$ 成立"。

---

## 1.5 Product types / 积类型
[[Foundations/product_type]]

> 积类型展示了类型构造器的**一般模式**：构成、引入、消去、计算、唯一性。

### 类型构造器的一般模式 / General Pattern (Remark 1.5.1)

引入新类型时需指定：
1. **Formation rules** — 如何构成此种类型
2. **Introduction rules (constructors)** — 如何构造此类型的元素
3. **Elimination rules (eliminators)** — 如何使用此类型的元素
4. **Computation rules ($\beta$-reduction)** — 消去器作用于构造器的结果
5. **Uniqueness principle ($\eta$-expansion, optional)** — 构造器作用于消去器的结果（有时仅作为命题等式）

### 积类型 $A \times B$ / Product Type

**Formation:** $A, B : \mathcal{U} \Longrightarrow A \times B : \mathcal{U}$

**Introduction:** $a : A, \; b : B \Longrightarrow (a, b) : A \times B$

**Elimination (projections):**
$$\mathrm{pr}_1 : A \times B \to A, \qquad \mathrm{pr}_1(a, b) \defeq a$$
$$\mathrm{pr}_2 : A \times B \to B, \qquad \mathrm{pr}_2(a, b) \defeq b$$

**Recursor / 递归器:**
$$\mathrm{rec}_{A \times B} : \prod_{(C:\mathcal{U})} (A \to B \to C) \to A \times B \to C$$
$$\mathrm{rec}_{A \times B}(C, g, (a, b)) \defeq g(a)(b)$$

**Induction / 归纳 (dependent eliminator):**
给定 $C : A \times B \to \mathcal{U}$ 和 $g : \prod_{(x:A)} \prod_{(y:B)} C((x,y))$：
$$\mathrm{ind}_{A \times B}(C, g, (a, b)) \defeq g(a)(b)$$

**Propositional uniqueness / 命题唯一性:**
$$\mathrm{uniq}_{A \times B} : \prod_{(x : A \times B)} (\mathrm{pr}_1(x), \mathrm{pr}_2(x)) =_{A \times B} x$$
$$\mathrm{uniq}_{A \times B}((a, b)) \defeq \mathrm{refl}_{(a,b)}$$

### 单位类型 $\mathbf{1}$ / Unit Type

**Introduction:** $\star : \mathbf{1}$

**Induction:**
$$\mathrm{ind}_\mathbf{1} : \prod_{(C : \mathbf{1} \to \mathcal{U})} C(\star) \to \prod_{(x : \mathbf{1})} C(x)$$
$$\mathrm{ind}_\mathbf{1}(C, c, \star) \defeq c$$

**Propositional uniqueness:** $\mathrm{uniq}_\mathbf{1} : \prod_{(x:\mathbf{1})} x =_\mathbf{1} \star$，通过 $\mathrm{uniq}_\mathbf{1}(\star) \defeq \mathrm{refl}_\star$。

### 为什么重要 / Why it matters

积类型是第一个完整展示所有五种规则的例子。递归器（recursor）和归纳器（inductor）的区分——非依赖 vs 依赖消去器——是后续所有归纳类型的基础。

---

## 1.6 Dependent pair types ($\Sigma$-types) / 依赖对类型
[[Foundations/sigma_type]]

> $\Sigma$-type 是积类型的依赖推广——第二个分量的类型依赖于第一个分量。

### 规则 / Rules

**Formation:**
$$A : \mathcal{U}, \quad B : A \to \mathcal{U} \quad \Longrightarrow \quad \sum_{(x:A)} B(x) : \mathcal{U}$$

当 $B$ 为常族时退化：$\sum_{(x:A)} B \equiv A \times B$。

**Introduction:**
$$a : A, \quad b : B(a) \quad \Longrightarrow \quad (a, b) : \sum_{(x:A)} B(x)$$

**Projections / 投影:**
$$\mathrm{pr}_1 : \Big(\sum_{(x:A)} B(x)\Big) \to A, \qquad \mathrm{pr}_1(a, b) \defeq a$$
$$\mathrm{pr}_2 : \prod_{(p : \sum_{(x:A)} B(x))} B(\mathrm{pr}_1(p)), \qquad \mathrm{pr}_2(a, b) \defeq b$$

注意 $\mathrm{pr}_2$ 是**依赖函数**——其返回类型 $B(\mathrm{pr}_1(p))$ 依赖于 $p$。定义 $\mathrm{pr}_2$ 需要**归纳原理**，非递归器。

**Recursor:**
$$\mathrm{rec}_{\sum_{(x:A)} B(x)} : \prod_{(C:\mathcal{U})} \Big(\prod_{(x:A)} B(x) \to C\Big) \to \Big(\sum_{(x:A)} B(x)\Big) \to C$$
$$\mathrm{rec}_{\sum_{(x:A)} B(x)}(C, g, (a,b)) \defeq g(a)(b)$$

**Induction:**
$$\mathrm{ind}_{\sum_{(x:A)} B(x)} : \prod_{(C : (\sum_{(x:A)} B(x)) \to \mathcal{U})} \Big(\prod_{(a:A)} \prod_{(b:B(a))} C((a,b))\Big) \to \prod_{(p : \sum_{(x:A)} B(x))} C(p)$$
$$\mathrm{ind}_{\sum_{(x:A)} B(x)}(C, g, (a,b)) \defeq g(a)(b)$$

### 类型论选择公理 / Type-theoretic Axiom of Choice

**定理 (AC).** 给定 $R : A \to B \to \mathcal{U}$：
$$\mathsf{ac} : \Big(\prod_{(x:A)} \sum_{(y:B)} R(x,y)\Big) \to \Big(\sum_{(f:A \to B)} \prod_{(x:A)} R(x, f(x))\Big)$$

**构造:** $\mathsf{ac}(g) \defeq \big(\lambda(x:A).\, \mathrm{pr}_1(g(x)),\; \lambda(x:A).\, \mathrm{pr}_2(g(x))\big)$

这在类型论中是**定理**（直接从规则推导），不需要作为公理！因为前提中的选择已经给出——我们只是将其拆成两部分。

### 编码数学结构 / Encoding Mathematical Structures

$\Sigma$-type 用于打包数学结构：

$$\mathsf{Magma} \defeq \sum_{(A:\mathcal{U})} (A \to A \to A)$$

$$\mathsf{PointedMagma} \defeq \sum_{(A:\mathcal{U})} (A \to A \to A) \times A$$

嵌套对采用右结合记法：$(x, y, z) \defeq (x, (y, z))$。

### 为什么重要 / Why it matters

$\Sigma$-type 在命题即类型对应下编码**存在量词**，同时用于打包数学结构。理解 $\Pi$ 和 $\Sigma$ 的对偶关系（全称 vs 存在，函数 vs 对）是掌握依赖类型的关键。

---

## 1.7 Coproduct types / 余积类型
[[Foundations/coproduct_type]]

> 余积 $A + B$ 对应不交并和逻辑析取。空类型 $\mathbf{0}$ 对应逻辑假。

### 余积 $A + B$ / Coproduct

**Formation:** $A, B : \mathcal{U} \Longrightarrow A + B : \mathcal{U}$

**Introduction:**
$$\mathrm{inl} : A \to A + B, \qquad \mathrm{inr} : B \to A + B$$

**Recursor (case analysis):**
$$\mathrm{rec}_{A+B} : \prod_{(C:\mathcal{U})} (A \to C) \to (B \to C) \to A + B \to C$$
$$\mathrm{rec}_{A+B}(C, g_0, g_1, \mathrm{inl}(a)) \defeq g_0(a)$$
$$\mathrm{rec}_{A+B}(C, g_0, g_1, \mathrm{inr}(b)) \defeq g_1(b)$$

**Induction:**
给定 $C : (A + B) \to \mathcal{U}$、$g_0 : \prod_{(a:A)} C(\mathrm{inl}(a))$、$g_1 : \prod_{(b:B)} C(\mathrm{inr}(b))$：
$$\mathrm{ind}_{A+B}(C, g_0, g_1, \mathrm{inl}(a)) \defeq g_0(a)$$
$$\mathrm{ind}_{A+B}(C, g_0, g_1, \mathrm{inr}(b)) \defeq g_1(b)$$

### 空类型 $\mathbf{0}$ / Empty Type

**Introduction:** 无构造器。

**Recursor (*ex falso quodlibet*):**
$$\mathrm{rec}_\mathbf{0} : \prod_{(C:\mathcal{U})} \mathbf{0} \to C$$

**Induction:**
$$\mathrm{ind}_\mathbf{0} : \prod_{(C : \mathbf{0} \to \mathcal{U})} \prod_{(z : \mathbf{0})} C(z)$$

无需定义方程——因为 $\mathbf{0}$ 没有元素需要处理。

### 为什么重要 / Why it matters

余积对应析取 $A \lor B$，空类型对应假 $\bot$。消去原理是**分情况讨论**。$\mathbf{0}$ 的消去器体现了"从矛盾可推出一切"（ex falso quodlibet）。

---

## 1.8 The type of booleans / 布尔类型
[[Foundations/bool]]

> 布尔类型是余积的具体实例 $\mathbf{2} \simeq \mathbf{1} + \mathbf{1}$，但独立引入更直观。

### 规则 / Rules

**Formation:** $\mathbf{2} : \mathcal{U}$

**Introduction:** $0_\mathbf{2}, 1_\mathbf{2} : \mathbf{2}$

**Recursor (if-then-else):**
$$\mathrm{rec}_\mathbf{2} : \prod_{(C:\mathcal{U})} C \to C \to \mathbf{2} \to C$$
$$\mathrm{rec}_\mathbf{2}(C, c_0, c_1, 0_\mathbf{2}) \defeq c_0, \qquad \mathrm{rec}_\mathbf{2}(C, c_0, c_1, 1_\mathbf{2}) \defeq c_1$$

**Induction:**
$$\mathrm{ind}_\mathbf{2} : \prod_{(C : \mathbf{2} \to \mathcal{U})} C(0_\mathbf{2}) \to C(1_\mathbf{2}) \to \prod_{(x:\mathbf{2})} C(x)$$

### 关键应用 / Key Applications

**每个布尔值要么是 $0_\mathbf{2}$ 要么是 $1_\mathbf{2}$：**
$$\prod_{(x:\mathbf{2})} (x = 0_\mathbf{2}) + (x = 1_\mathbf{2})$$
由归纳原理构造：$\mathrm{ind}_\mathbf{2}(\lambda x.\, (x = 0_\mathbf{2}) + (x = 1_\mathbf{2}),\; \mathrm{inl}(\mathrm{refl}_{0_\mathbf{2}}),\; \mathrm{inr}(\mathrm{refl}_{1_\mathbf{2}}))$。

**用布尔定义余积：**
$$A + B \defeq \sum_{(x:\mathbf{2})} \mathrm{rec}_\mathbf{2}(\mathcal{U}, A, B, x)$$
$$\mathrm{inl}(a) \defeq (0_\mathbf{2}, a), \qquad \mathrm{inr}(b) \defeq (1_\mathbf{2}, b)$$

**用布尔定义积：**
$$A \times B \defeq \prod_{(x:\mathbf{2})} \mathrm{rec}_\mathbf{2}(\mathcal{U}, A, B, x)$$

> 利用 $\mathcal{U}$ 本身是类型这一事实，通过**递归**定义**类型族**——这是类型论微妙而重要的特性。

### 注意 / Caveat

布尔值**不是**真值（truth values）！类型论中命题 = 类型，不是 $\mathbf{2}$ 的元素。$A \to \mathbf{2}$ 不是 $A$ 的幂集，而仅表示 $A$ 的"可判定子集"。

### 为什么重要 / Why it matters

布尔类型是最简单的归纳类型，完整展示了递归/归纳原理如何工作。通过宇宙上的递归，它还能定义余积和积——展示了类型论表达力的深度。

---

## 1.9 The natural numbers / 自然数
[[Foundations/nat]]

> $\mathbb{N}$ 是第一个真正的**递归**类型——递归原理和归纳原理终于名副其实。

### 规则 / Rules

**Formation:** $\mathbb{N} : \mathcal{U}$

**Introduction:**
$$0 : \mathbb{N}, \qquad \mathrm{succ} : \mathbb{N} \to \mathbb{N}$$
记法：$1 \defeq \mathrm{succ}(0)$, $2 \defeq \mathrm{succ}(1)$, ...

**Recursor (primitive recursion):**
$$\mathrm{rec}_\mathbb{N} : \prod_{(C:\mathcal{U})} C \to (\mathbb{N} \to C \to C) \to \mathbb{N} \to C$$
$$\mathrm{rec}_\mathbb{N}(C, c_0, c_s, 0) \defeq c_0$$
$$\mathrm{rec}_\mathbb{N}(C, c_0, c_s, \mathrm{succ}(n)) \defeq c_s(n, \mathrm{rec}_\mathbb{N}(C, c_0, c_s, n))$$

**Induction (proof by induction):**
给定 $C : \mathbb{N} \to \mathcal{U}$、$c_0 : C(0)$、$c_s : \prod_{(n:\mathbb{N})} C(n) \to C(\mathrm{succ}(n))$：
$$\mathrm{ind}_\mathbb{N} : \prod_{(C:\mathbb{N}\to\mathcal{U})} C(0) \to \Big(\prod_{(n:\mathbb{N})} C(n) \to C(\mathrm{succ}(n))\Big) \to \prod_{(n:\mathbb{N})} C(n)$$
$$\mathrm{ind}_\mathbb{N}(C, c_0, c_s, 0) \defeq c_0$$
$$\mathrm{ind}_\mathbb{N}(C, c_0, c_s, \mathrm{succ}(n)) \defeq c_s(n, \mathrm{ind}_\mathbb{N}(C, c_0, c_s, n))$$

### 示例 / Examples

**加倍函数 / Doubling:**
$$\mathrm{double}(0) \defeq 0, \qquad \mathrm{double}(\mathrm{succ}(n)) \defeq \mathrm{succ}(\mathrm{succ}(\mathrm{double}(n)))$$

验证：$\mathrm{double}(2) \equiv \mathrm{succ}(\mathrm{succ}(\mathrm{succ}(\mathrm{succ}(0)))) \equiv 4$。

**加法 / Addition:**
$$\mathrm{add}(0, n) \equiv n, \qquad \mathrm{add}(\mathrm{succ}(m), n) \equiv \mathrm{succ}(\mathrm{add}(m, n))$$

**结合律证明 / Associativity proof sketch:**
$$\mathrm{assoc} : \prod_{(i,j,k:\mathbb{N})} i + (j + k) = (i + j) + k$$

- 基础情况：$\mathrm{assoc}_0(j,k) \defeq \mathrm{refl}_{j+k}$（因为 $0 + n \equiv n$）
- 归纳步骤：$\mathrm{assoc}_s(i, h, j, k) \defeq \mathrm{ap}_\mathrm{succ}(h(j,k))$（利用 $\mathrm{succ}$ 保持等式）

### 为什么重要 / Why it matters

$\mathbb{N}$ 是理解归纳类型的关键。归纳原理正是熟悉的数学归纳法在类型论中的体现。对 $+$ 结合律的证明展示了归纳法如何在形式层面运作。高阶函数类型的存在使我们能定义超越原始递归的函数（如 Ackermann 函数）。

---

## 1.10 Pattern matching and recursion / 模式匹配与递归
[[Foundations/pattern_matching]]

> 模式匹配是递归/归纳原理的实用简写——更可读，但必须可归约为归纳原理。

### 核心思想 / Key Idea

对余积类型，定义方程不涉及被定义函数本身（非递归）：
$$f(\mathrm{inl}(a)) \defeq \Phi_0, \qquad f(\mathrm{inr}(b)) \defeq \Phi_1$$
可直接翻译为递归器：$f \defeq \mathrm{rec}_{A+B}(C, \lambda a.\,\Phi_0, \lambda b.\,\Phi_1)$。

对自然数，定义方程涉及被定义函数本身（递归）：
$$f(0) \defeq \Phi_0, \qquad f(\mathrm{succ}(n)) \defeq \Phi_s$$
其中 $\Phi_s$ 可包含 $f(n)$。翻译为：$f \defeq \mathrm{rec}_\mathbb{N}(C, \Phi_0, \lambda n.\,\lambda r.\, \Phi_s')$，其中 $\Phi_s'$ 是将 $\Phi_s$ 中 $f(n)$ 替换为 $r$ 的结果。

### 安全性约束 / Safety Constraints

被定义函数 $f$ 只能以 $f(n)$ 的形式出现在 $f(\mathrm{succ}(n))$ 的定义中——即只能对结构更小的参数递归调用。否则（如 $f(\mathrm{succ}(n)) \defeq f(\mathrm{succ}(\mathrm{succ}(n)))$）会导致无穷循环，不定义函数。

### 为什么重要 / Why it matters

实践中我们几乎总是用模式匹配而非显式递归器。但理解模式匹配**必须**可归约为归纳原理这一点至关重要——这是终止性和正确性的保障。对更复杂的归纳类型（Ch5, Ch6），这一点更为关键。

---

## 1.11 Propositions as types / 命题即类型
[[Foundations/propositions_as_types]]

> Curry-Howard 对应：命题 = 类型，证明 = 项。这是类型论作为逻辑基础的核心思想。

### 对应表 / Correspondence Table

**命题逻辑 / Propositional Logic:**

| 逻辑 / Logic | 类型论 / Type Theory |
|---|---|
| True / 真 | $\mathbf{1}$ |
| False / 假 | $\mathbf{0}$ |
| $A$ and $B$ / 合取 | $A \times B$ |
| $A$ or $B$ / 析取 | $A + B$ |
| If $A$ then $B$ / 蕴含 | $A \to B$ |
| $A$ iff $B$ / 当且仅当 | $(A \to B) \times (B \to A)$ |
| Not $A$ / 否定 | $\neg A \defeq A \to \mathbf{0}$ |

**谓词逻辑 / Predicate Logic:**

| 逻辑 / Logic | 类型论 / Type Theory |
|---|---|
| For all $x : A$, $P(x)$ | $\prod_{(x:A)} P(x)$ |
| There exists $x : A$ s.t. $P(x)$ | $\sum_{(x:A)} P(x)$ |

### 详细示例 / Detailed Example: De Morgan's Law

**命题:** "若非 $A$ 且非 $B$，则非 ($A$ 或 $B$)"

**类型:** $(A \to \mathbf{0}) \times (B \to \mathbf{0}) \to (A + B \to \mathbf{0})$

**证明/构造:**
$$f((x,y))(\mathrm{inl}(a)) \defeq x(a)$$
$$f((x,y))(\mathrm{inr}(b)) \defeq y(b)$$

翻译过程：
1. "假设非 $A$ 且非 $B$" $\to$ 引入 $x : A \to \mathbf{0}$、$y : B \to \mathbf{0}$
2. "再假设 $A$ 或 $B$" $\to$ 引入 $z : A + B$，目标 $\mathbf{0}$
3. "分两种情况" $\to$ 对 $A + B$ 使用消去器
4. "若 $A$，与非 $A$ 矛盾" $\to$ 将 $a : A$ 应用于 $x : A \to \mathbf{0}$

### 构造性逻辑 / Constructive Logic

> 并非所有经典重言式在此对应下成立。

**不可证明的经典原理:**
- De Morgan 的另一半："若非 $(A \times B)$，则 (非 $A$) 或 (非 $B$)" — 无法构造 $((A \times B) \to \mathbf{0}) \to (A \to \mathbf{0}) + (B \to \mathbf{0})$
- 排中律 (LEM): $A + \neg A$
- 双重否定消去：$\neg\neg A \to A$

**可证明的否定推理:**
"假设 $A$，推出矛盾，所以 $\neg A$" **完全有效** — 这只是在构造 $A \to \mathbf{0}$ 的元素。被排除的是假设 $\neg A$ 推出矛盾来证明 $A$。

### $\Sigma$-type 的双重角色 / Dual Role

$\sum_{(x:A)} P(x)$ 可读作：
1. **存在量词**："存在 $x : A$ 使得 $P(x)$"
2. **子类型**："满足 $P$ 的 $A$ 的元素的类型"

**应用于数学结构:**
$$\mathsf{Semigroup} \defeq \sum_{(A:\mathcal{U})} \sum_{(m : A \to A \to A)} \prod_{(x,y,z:A)} m(x, m(y,z)) = m(m(x,y), z)$$

### 不等式定义 / Inequality

$$n \le m \defeq \sum_{(k:\mathbb{N})} (n + k = m)$$

### 证明相关性 / Proof-Relevance

> 此逻辑是**证明相关**的：析取和存在的证据携带信息。

知道 $A + B$ 有居民意味着我们**知道**它来自 $A$ 还是 $B$。"$\mathbb{N}$ 当且仅当 $\mathbf{1}$"（二者都有居民）但它们是完全不同的类型。逻辑等价 $\neq$ 类型等价。

在 Chapter 3 中将引入**纯命题**（mere propositions）来回收丢弃额外信息的逻辑。

### 为什么重要 / Why it matters

命题即类型是理解 HoTT 的基石。它统一了数学证明和程序构造，使"证明一个定理"等同于"构造一个对象"。构造性的特点赋予了**公理自由**——不否定 LEM，因此可一致地添加它。

---

## 1.12 Identity types / 恒等类型
[[Identity_and_Paths/identity_type]]

> **全书最关键的类型！** 恒等类型 $a =_A b$ 在 HoTT 中被解读为**路径**——从此开启高维结构。

### 规则 / Rules

**Formation:**
$$a, b : A \quad \Longrightarrow \quad (a =_A b) : \mathcal{U}$$
也写作 $\mathrm{Id}_A(a, b)$。

**Introduction (reflexivity):**
$$\mathrm{refl} : \prod_{(a:A)} (a =_A a)$$
$\mathrm{refl}_a$ 是 $a$ 处的**常路径**（constant path）。

若 $a \equiv b$（判断等式），则 $\mathrm{refl}_a : a =_A b$（因 $a =_A b \equiv a =_A a$）。

### 相等的不可区分性 / Indiscernibility of Identicals

对任意类型族 $C : A \to \mathcal{U}$，存在：
$$f : \prod_{(x,y:A)} \prod_{(p : x =_A y)} C(x) \to C(y)$$
满足 $f(x, x, \mathrm{refl}_x) \defeq \mathrm{id}_{C(x)}$。

这是恒等类型的**递归原理**：等元素可互相替换，$\mathrm{refl}$ 对应恒等函数。

### 路径归纳 / Path Induction (J rule)

**Path induction（全称形式）:**

给定：
- $C : \prod_{(x,y:A)} (x =_A y) \to \mathcal{U}$
- $c : \prod_{(x:A)} C(x, x, \mathrm{refl}_x)$

则存在：
$$f : \prod_{(x,y:A)} \prod_{(p : x =_A y)} C(x, y, p)$$
满足 $f(x, x, \mathrm{refl}_x) \defeq c(x)$。

打包为函数 $J$：
$$J \equiv \mathrm{ind}_{=_A} : \prod_{C} \Big(\prod_{(x:A)} C(x,x,\mathrm{refl}_x)\Big) \to \prod_{(x,y:A)} \prod_{(p:x=_A y)} C(x,y,p)$$
$$J(C, c, x, x, \mathrm{refl}_x) \defeq c(x)$$

**Based path induction（基点形式）:**

固定 $a : A$，给定：
- $C : \prod_{(x:A)} (a =_A x) \to \mathcal{U}$
- $c : C(a, \mathrm{refl}_a)$

则存在：
$$f : \prod_{(x:A)} \prod_{(p : a =_A x)} C(x, p)$$
满足 $f(a, \mathrm{refl}_a) \defeq c$。

### 两种归纳原理的等价性 / Equivalence

**Path induction $\Rightarrow$ Based path induction:** 直接——将 $C(x)$ 应用于 path induction 的 $C$，将 $c(x)$ 应用于 $c$。

**Based path induction $\Rightarrow$ Path induction:** 更微妙——定义辅助族 $D(x,y,p) \defeq \prod_{C : \prod_{(z:A)} (x =_A z) \to \mathcal{U}} C(x, \mathrm{refl}_x) \to C(y, p)$，然后用 path induction 一次性证明所有 based path induction 实例。

### 理解路径归纳（Remark 1.12.3）/ Understanding Path Induction

> 被归纳定义的不是恒等**类型**，而是恒等**族**。

表面上看，"唯一的路径是 $\mathrm{refl}$" 与 "可能有多条不同路径" 矛盾。关键在于：

- **Path induction** 说的是：$\sum_{(x,y:A)} (x =_A y)$（自由路径空间）由 $(x, x, \mathrm{refl}_x)$ 生成——拓扑上，自由路径空间可缩。
- **Based path induction** 说的是：$\sum_{(y:A)} (a =_A y)$（基路径空间）由 $(a, \mathrm{refl}_a)$ 生成——拓扑上，基路径空间可缩。

**关键区分:**

路径 $p : x =_A x$ 可以**不等于** $\mathrm{refl}_x$（作为 $x =_A x$ 的元素），但对 $(x, p)$ 作为 $\sum_{(y:A)} (x =_A y)$ 的元素，总有 $(x, p) = (x, \mathrm{refl}_x)$。

**拓扑类比:** 在带穿孔圆盘 $\{(x,y) \mid 0 < x^2 + y^2 < 2\}$ 中，起于 $(1,0)$ 绕洞一圈的环路在固定两端时不能缩为常路径；但若允许一端自由移动，则可以缩回。

### Path induction 不能做什么 / What Path Induction Cannot Do

对于固定两端 $a, b$ 的族 $C : (a =_A a) \to \mathcal{U}$，**不能**用路径归纳仅考虑 $C(\mathrm{refl}_a)$ 的情况。因此**不能**证明所有环路都是 $\mathrm{refl}$。归纳定义恒等族并不排除特定恒等类型中的非自反路径。

### 不等式 / Disequality

$$x \neq_A y \defeq \neg (x =_A y) \equiv (x =_A y) \to \mathbf{0}$$

构造性地，不能通过证明 $x$ 和 $y$ 不不等来证明它们相等（那需要双重否定消去）。

### 命题等式 vs 判断等式 / Propositional vs Judgmental Equality

> 命题等式是 HoTT 中的**数学等式**。

$n + 1 = 1 + n$ 对一般的 $n$ 是**命题等式**而非判断等式（尽管对具体值如 $3 + 1 \equiv 1 + 3 \equiv 4$ 是判断等式）。只有通过恒等类型和归纳原理才能证明这类事实。

### 为什么重要 / Why it matters

恒等类型是 HoTT 的核心。在同伦解释下，$a =_A b$ 是从 $a$ 到 $b$ 的路径空间——可能有多条不同路径，路径之间也有路径（高维结构）。Chapter 2 将揭示恒等类型蕴含的丰富同伦结构：路径的逆、路径的复合、transport、ap。J 规则（路径归纳）是所有这些构造的源头。

---

## 章节间的桥梁 / Bridge to Next Chapter

> 路径归纳（J 规则）是 HoTT 所有高维结构的源头。

Chapter 1 建立了基本语言：判断、函数、依赖类型、归纳类型、命题即类型、恒等类型。Chapter 2 将从恒等类型出发，推导出路径的群胚结构（逆、复合、结合律...），发现函数的作用（$\mathrm{ap}$）和依赖族上的传输（$\mathrm{transport}$），最终揭示类型论中潜藏的同伦论。

---

## 练习概览 / Exercise Overview

| 编号 | 主题 | 关键概念 |
|---|---|---|
| 1.1 | 函数复合 $g \circ f$ | 结合律（judgmental） |
| 1.2 | 从投影导出递归器 | 积/$\Sigma$-type |
| 1.3 | 从投影 + uniq 导出归纳器 | 需要 Ch2 概念 |
| 1.4 | 从迭代器导出递归器 | $\mathrm{ite} \to \mathrm{rec}_\mathbb{N}$ |
| 1.5 | 用 $\mathbf{2}$ 和 $\Sigma$ 定义 $A + B$ | 宇宙上的递归 |
| 1.6 | 用 $\mathbf{2}$ 和 $\Pi$ 定义 $A \times B$ | 需要函数外延性 |
| 1.7 | 不用宇宙导出 based path induction | 需要后续章节 |
| 1.8 | 乘法、指数，$\mathbb{N}$ 是半环 | $\mathrm{rec}_\mathbb{N}$, $\mathrm{ind}_\mathbb{N}$ |
| 1.9 | 定义 $\mathrm{Fin}$ 和 $\mathrm{fmax}$ | 类型族 |
| 1.10 | Ackermann 函数 | 高阶递归 |
| 1.11 | $\neg\neg\neg A \to \neg A$ | 构造性逻辑 |
| 1.12 | 构造性重言式 | 命题即类型 |
| 1.13 | $\neg\neg(P + \neg P)$ | 排中律的双重否定 |
| 1.14 | 为何不能证明 $\prod_{(p:x=x)} p = \mathrm{refl}_x$ | J 规则的局限 |
| 1.15 | 从 path induction 导出 indiscernibility | 基本练习 |
| 1.16 | 加法交换律 | $\mathrm{ind}_\mathbb{N}$ |
