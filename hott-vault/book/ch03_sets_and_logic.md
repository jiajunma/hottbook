---
title: "Chapter 3: Sets and Logic / 集合与逻辑"
type: chapter-digest
hott_book_chapter: 3
sections: [3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.9, 3.10, 3.11]
key_concepts:
  - sets (0-types)
  - n-types
  - mere propositions (-1-types)
  - propositional truncation
  - law of excluded middle
  - axiom of choice
  - unique choice
  - contractibility (-2-types)
  - subsets
  - propositional resizing
prerequisites: [ch01_type_theory, ch02_homotopy_type_theory]
leads_to: [ch04_equivalences, ch07_homotopy_n_types]
---

# Chapter 3: Sets and Logic / 集合与逻辑

回答核心问题："在 HoTT 中如何做普通数学？" 引入 n-type 层级（集合、命题、可缩类型），用命题截断恢复传统逻辑连接词，讨论经典逻辑与构造逻辑的关系，给出选择公理和唯一选择原理的精确表述。

This chapter answers: "How do we do ordinary mathematics in HoTT?" It introduces the n-type hierarchy (sets, propositions, contractible types), recovers traditional logical connectives via propositional truncation, discusses classical vs constructive logic, and gives precise formulations of the axiom of choice and the principle of unique choice.

> **核心洞见 / Core Insight:** 类型论中"命题即类型"的朴素解读与 univalence 不兼容（LEM 对所有类型成立会导致矛盾）。解决方案是区分"纯命题"（mere proposition，至多一个元素的类型）和一般类型，将经典逻辑限制在纯命题上。这个区分自然产生 n-type 层级：可缩类型 $\subset$ 纯命题 $\subset$ 集合 $\subset$ 1-type $\subset \cdots$
>
> The naive propositions-as-types reading is incompatible with univalence (LEM for all types leads to contradiction). The solution: distinguish mere propositions (types with at most one element) from general types, and restrict classical logic to mere propositions. This naturally gives rise to the n-type hierarchy: contractible $\subset$ prop $\subset$ set $\subset$ 1-type $\subset \cdots$

---

## 3.1 Sets and n-types / 集合与 n-类型

[[Truncation_Levels/sets]]

### 关键定义 / Key Definitions

**Definition 3.1.1 (Set / 集合).** 类型 $A$ 是**集合 (set)** 如果对所有 $x, y : A$ 和所有 $p, q : x = y$，有 $p = q$。

$$\mathsf{isSet}(A) :\equiv \prod_{(x,y:A)} \prod_{(p,q:x=y)} (p = q)$$

A type $A$ is a **set** if for all $x, y : A$ and all $p, q : x = y$, we have $p = q$.

**Definition 3.1.4 (1-type).** 类型 $A$ 是 **1-type** 如果对所有 $x, y : A$，$p, q : x = y$，$r, s : p = q$，有 $r = s$。

$$\text{is-1-Type}(A) :\equiv \prod_{(x,y:A)} \prod_{(p,q:x=y)} \prod_{(r,s:p=q)} (r = s)$$

### 关键定理 / Key Theorems

**Lemma 3.1.3 (集合是 1-type).** 如果 $A$ 是集合（即 $\mathsf{isSet}(A)$ 有居民），则 $A$ 是 1-type。

If $A$ is a set (i.e., $\mathsf{isSet}(A)$ is inhabited), then $A$ is a 1-type.

**Example 3.1.9 (宇宙不是集合).** 类型宇宙 $\mathcal{U}$ 不是集合。证明：取 $A = \mathbf{2}$（布尔类型），令 $f : \mathbf{2} \to \mathbf{2}$ 交换 $0_\mathbf{2}$ 和 $1_\mathbf{2}$。$f$ 是等价，由 univalence 给出路径 $p : \mathbf{2} = \mathbf{2}$。若 $p = \mathsf{refl}$，则 $f = \mathsf{id}$，矛盾。

The type universe $\mathcal{U}$ is not a set. Proof: the swap equivalence $f : \mathbf{2} \simeq \mathbf{2}$ gives a nontrivial path $p : \mathbf{2} = \mathbf{2}$ by univalence. If $p = \mathsf{refl}$, then $f = \mathsf{id}$, contradicting $0_\mathbf{2} \neq 1_\mathbf{2}$.

### 集合的封闭性 / Closure Properties

- $\mathbf{1}$（单元类型）是集合 / $\mathbf{1}$ (unit type) is a set
- $\mathbf{0}$（空类型）是集合 / $\mathbf{0}$ (empty type) is a set
- $\mathbb{N}$（自然数）是集合 / $\mathbb{N}$ (natural numbers) is a set
- 若 $A$, $B$ 是集合，则 $A \times B$ 是集合 / if $A$, $B$ are sets, so is $A \times B$
- 若 $A$ 是集合且每个 $B(x)$ 是集合，则 $\sum_{(x:A)} B(x)$ 是集合 / if $A$ is a set and each $B(x)$ is a set, so is $\sum_{(x:A)} B(x)$
- 若每个 $B(x)$ 是集合，则 $\prod_{(x:A)} B(x)$ 是集合（$A$ 任意） / if each $B(x)$ is a set, so is $\prod_{(x:A)} B(x)$ (for any $A$)

### 为什么重要 / Why It Matters

> 集合是做"普通数学"的基础层面。大部分传统数学（代数、分析、组合等）在集合层面进行。n-type 层级的引入让我们精确刻画类型的高维信息量：集合没有非平凡路径，1-type 没有非平凡路径之间的路径，以此类推。
>
> Sets are the foundational level for "ordinary mathematics." Most traditional math (algebra, analysis, combinatorics) lives at this level. The n-type hierarchy precisely captures how much higher-dimensional information a type carries.

---

## 3.2 Propositions as types? / 命题即类型？

[[Logic/propositions_as_types_problem]]

### 核心问题 / The Problem

朴素的"命题即类型"对应在 HoTT 中遇到根本性问题。

The naive propositions-as-types correspondence encounters fundamental problems in HoTT.

**Theorem 3.2.2 (双重否定消去不成立).** 并非对所有 $A : \mathcal{U}$ 都有 $\neg(\neg A) \to A$。

$$\neg\left(\prod_{(A:\mathcal{U})} (\neg\neg A \to A)\right)$$

It is not the case that for all $A : \mathcal{U}$ we have $\neg(\neg A) \to A$.

**证明思路 / Proof idea:** 假设有 $f : \prod_{(A:\mathcal{U})} (\neg\neg A \to A)$。取 $e : \mathbf{2} \simeq \mathbf{2}$ 为交换等价，$p :\equiv \mathsf{ua}(e) : \mathbf{2} = \mathbf{2}$。由 $f$ 的自然性（univalence 保证的连续性），得 $e(f(\mathbf{2})(u)) = f(\mathbf{2})(u)$，即 $f(\mathbf{2})(u)$ 是 $e$ 的不动点。但 $e$ 无不动点，矛盾。

Assuming $f : \prod_{(A:\mathcal{U})} (\neg\neg A \to A)$, the naturality of $f$ (guaranteed by univalence) with respect to the swap equivalence $e : \mathbf{2} \simeq \mathbf{2}$ yields $e(f(\mathbf{2})(u)) = f(\mathbf{2})(u)$, a fixed point. But $e$ has no fixed points, contradiction.

**Corollary 3.2.7 (排中律不成立).** 并非对所有 $A : \mathcal{U}$ 都有 $A + (\neg A)$。

It is not the case that for all $A : \mathcal{U}$ we have $A + (\neg A)$.

### 关键后果 / Key Consequences

- 不存在 Hilbert 风格的选择算子，能对每个非空类型选出元素（这样的算子无法关于等价自然）
  No Hilbert-style choice operator picking an element from every inhabited type — such an operator cannot be natural with respect to equivalences.
- 但 $\neg\neg\neg A \to \neg A$ 对所有 $A$ 仍成立
  However, $\neg\neg\neg A \to \neg A$ still holds for all $A$.
- 类型论版选择公理 $\prod_{(x:X)} \sum_{(a:A(x))} P(x,a) \to \sum_{(g:\prod_{(x:X)} A(x))} \prod_{(x:X)} P(x,g(x))$ 仍可证
  The type-theoretic axiom of choice (untruncated version) remains provable.

### 为什么重要 / Why It Matters

> 这是 HoTT 最关键的分叉点之一。Univalence 要求对类型的所有操作都关于等价自然，而 LEM 对一般类型不自然。解决方案不是放弃命题即类型，而是精炼它——引入 mere proposition 的概念。
>
> This is one of the most critical branching points of HoTT. Univalence requires all operations on types to be natural with respect to equivalences, but LEM is not natural for general types. The solution: refine propositions-as-types by introducing mere propositions.

---

## 3.3 Mere propositions / 纯命题

[[Truncation_Levels/mere_propositions]]

### 关键定义 / Key Definitions

**Definition 3.3.1 (Mere proposition / 纯命题).** 类型 $P$ 是**纯命题 (mere proposition)** 如果对所有 $x, y : P$，有 $x = y$。

$$\mathsf{isProp}(P) :\equiv \prod_{(x,y:P)} (x = y)$$

等价术语 / Equivalent terminology: (-1)-type, h-proposition, subterminal object, subsingleton.

### 关键定理 / Key Theorems

**Lemma 3.3.2 (有居民的纯命题等价于 $\mathbf{1}$).** 若 $P$ 是纯命题且 $x_0 : P$，则 $P \simeq \mathbf{1}$。

If $P$ is a mere proposition and $x_0 : P$, then $P \simeq \mathbf{1}$.

**Lemma 3.3.3 (纯命题之间的逻辑等价即等价).** 若 $P$ 和 $Q$ 是纯命题，$P \to Q$ 且 $Q \to P$，则 $P \simeq Q$。

If $P$ and $Q$ are mere propositions with $P \to Q$ and $Q \to P$, then $P \simeq Q$.

**Lemma 3.3.4 (纯命题是集合).** 每个纯命题都是集合。

Every mere proposition is a set.

**Lemma 3.3.5 ($\mathsf{isProp}$ 和 $\mathsf{isSet}$ 本身是纯命题).** 对任意类型 $A$，$\mathsf{isProp}(A)$ 和 $\mathsf{isSet}(A)$ 都是纯命题。

For any type $A$, the types $\mathsf{isProp}(A)$ and $\mathsf{isSet}(A)$ are mere propositions.

### 关键例子 / Key Examples

- $\mathbf{0}$ 是纯命题（空虚真） / $\mathbf{0}$ is a mere proposition (vacuously)
- $\mathbf{1}$ 是纯命题（任意两元素相等） / $\mathbf{1}$ is a mere proposition (any two elements are equal)
- $\mathbf{2}$ **不是**纯命题（$0_\mathbf{2} \neq 1_\mathbf{2}$，所以给出一个居民提供了额外的一比特信息）
  $\mathbf{2}$ is **not** a mere proposition ($0_\mathbf{2} \neq 1_\mathbf{2}$; giving an inhabitant provides one extra bit of information)
- $A$ 是集合 $\iff$ 对所有 $x, y : A$，$x =_A y$ 是纯命题
  $A$ is a set $\iff$ for all $x, y : A$, $x =_A y$ is a mere proposition
- $\mathsf{isequiv}(f)$ 是纯命题（Ch2 中的条件）/ $\mathsf{isequiv}(f)$ is a mere proposition (the condition from Ch2)

### 为什么重要 / Why It Matters

> 纯命题恢复了传统逻辑中"命题"的含义：证明之间没有区别，只有真/假。"mere" 强调虽然任何类型可视为命题，但纯命题不含超出真值的额外信息。这是 n-type 层级的关键中间层：可缩类型（有且仅有一个元素）$\subset$ 纯命题（至多一个元素）$\subset$ 集合（恒等类型是纯命题）。
>
> Mere propositions recover the traditional meaning of "proposition": no distinction between proofs, only true/false. The adjective "mere" emphasizes that a mere proposition carries no information beyond a truth value. This is the key intermediate level: contractible (exactly one element) $\subset$ mere prop (at most one) $\subset$ set (identity types are mere props).

---

## 3.4 Classical vs. intuitionistic logic / 经典逻辑与直觉主义逻辑

[[Logic/classical_vs_intuitionistic]]

### 关键定义 / Key Definitions

**排中律 / Law of Excluded Middle.** 正确的 HoTT 表述 / The correct HoTT formulation:

$$\mathsf{LEM} :\equiv \prod_{(A:\mathcal{U})} \left(\mathsf{isProp}(A) \to (A + \neg A)\right)$$

**双重否定律 / Law of Double Negation.**

$$\prod_{(A:\mathcal{U})} \left(\mathsf{isProp}(A) \to (\neg\neg A \to A)\right)$$

LEM 和双重否定律等价（Exercise 3.18）。
LEM and double negation are equivalent (Exercise 3.18).

**朴素版 LEM（不一致） / Naive LEM (inconsistent):**

$$\mathsf{LEM}_\infty :\equiv \prod_{(A:\mathcal{U})} (A + \neg A)$$

此版本与 univalence 不一致——因为 $\mathbf{2}$ 不是纯命题。
This version is inconsistent with univalence, because $\mathbf{2}$ is not a mere proposition.

**Definition 3.4.3 (可判定性 / Decidability).**

- 类型 $A$ **可判定 (decidable)** 若 $A + \neg A$。
  A type $A$ is **decidable** if $A + \neg A$.
- 类型族 $B : A \to \mathcal{U}$ **可判定** 若 $\prod_{(a:A)} (B(a) + \neg B(a))$。
  A type family $B : A \to \mathcal{U}$ is **decidable** if $\prod_{(a:A)} (B(a) + \neg B(a))$.
- $A$ 有**可判定相等 (decidable equality)** 若 $\prod_{(a,b:A)} ((a = b) + \neg(a = b))$。
  $A$ has **decidable equality** if $\prod_{(a,b:A)} ((a = b) + \neg(a = b))$.

$\mathsf{LEM}$ 恰好说所有纯命题都可判定。
$\mathsf{LEM}$ says precisely that all mere propositions are decidable.

### 关键洞见 / Key Insights

> **构造数学的实践原则：**
> 1. 用 "inhabited"（有居民）替代 "nonempty"（非空），避免不必要的双重否定
> 2. 反证法证否定 $\neg A$ 时不需要 LEM（因为 $\neg A \equiv A \to \mathbf{0}$）
> 3. $\neg\neg\neg A \to \neg A$ 对所有 $A$ 成立
> 4. 许多经典定理只需适当重新表述定义即可构造性证明
> 5. HoTT 的 univalence 和高阶归纳类型提供了绕过经典推理的强大工具
>
> **Practical principles of constructive math:**
> 1. Replace "nonempty" with "inhabited" to avoid unnecessary double negation
> 2. Proof by contradiction for negations $\neg A$ needs no LEM (since $\neg A \equiv A \to \mathbf{0}$)
> 3. $\neg\neg\neg A \to \neg A$ holds for all $A$
> 4. Many classical theorems need only appropriate reformulation to be constructively provable
> 5. Univalence and HITs in HoTT provide powerful tools to bypass classical reasoning

### 为什么重要 / Why It Matters

> 将 LEM 限制到纯命题后与 univalence 一致。HoTT 默认是构造性的，但可以一致地假设 $\mathsf{LEM}$（限于纯命题）。这使得 HoTT 既能做经典数学（需要时加 LEM），又能享受构造数学的好处（更精细的信息、可计算性）。
>
> Restricting LEM to mere propositions is consistent with univalence. HoTT is constructive by default but can consistently assume LEM (for mere propositions). This allows both classical math (add LEM when needed) and constructive benefits (finer information, computability).

---

## 3.5 Subsets and propositional resizing / 子集与命题调整

[[Logic/subsets]]

### 关键定义 / Key Definitions

**子集 / Subset.** 给定谓词 $P : A \to \mathcal{U}$（每个 $P(x)$ 是纯命题），子集定义为：
Given a predicate $P : A \to \mathcal{U}$ (each $P(x)$ a mere proposition), the subset is defined as:

$$\{x : A \mid P(x)\} :\equiv \sum_{(x:A)} P(x)$$

**成员关系 / Membership.** $a \in P$ 指纯命题 $P(a)$。
$a \in P$ refers to the mere proposition $P(a)$.

**包含关系 / Containment.** $P \subseteq Q$ 定义为 $\prod_{(x:A)} (P(x) \to Q(x))$。
$P \subseteq Q$ is defined as $\prod_{(x:A)} (P(x) \to Q(x))$.

**子宇宙 / Subuniverses.**

$$\mathsf{Set}_\mathcal{U} :\equiv \{A : \mathcal{U} \mid \mathsf{isSet}(A)\}, \qquad \mathsf{Prop}_\mathcal{U} :\equiv \{A : \mathcal{U} \mid \mathsf{isProp}(A)\}$$

### 关键定理 / Key Theorems

**Lemma 3.5.1 (子集中路径由基类型决定).** 设 $P : A \to \mathcal{U}$ 每个 $P(x)$ 是纯命题。若 $u, v : \sum_{(x:A)} P(x)$ 满足 $\pi_1(u) = \pi_1(v)$，则 $u = v$。

If $P : A \to \mathcal{U}$ is a family of mere propositions and $u, v : \sum_{(x:A)} P(x)$ with $\pi_1(u) = \pi_1(v)$, then $u = v$.

**Axiom 3.5.5 (Propositional resizing / 命题调整).** 映射 $\mathsf{Prop}_{\mathcal{U}_i} \to \mathsf{Prop}_{\mathcal{U}_{i+1}}$ 是等价。

The map $\mathsf{Prop}_{\mathcal{U}_i} \to \mathsf{Prop}_{\mathcal{U}_{i+1}}$ is an equivalence.

**幂集 / Power set.** 在命题调整下，$\mathcal{P}(A) :\equiv (A \to \Omega)$，其中 $\Omega$ 分类所有纯命题。
Under propositional resizing, $\mathcal{P}(A) :\equiv (A \to \Omega)$, where $\Omega$ classifies all mere propositions.

### 为什么重要 / Why It Matters

> 纯命题值谓词确保子集中的路径完全由基类型决定——不会因为"同一元素的不同证明"产生意外的多余元素。这是 HoTT 中做集合论的关键技术。命题调整是一种受控的非直谓性，使得幂集定义不依赖宇宙选择。
>
> Mere-proposition-valued predicates ensure paths in a subset are determined entirely by the base type. No spurious elements from "different proofs of the same thing." Propositional resizing is a controlled form of impredicativity making the power set definition universe-independent.

---

## 3.6 The logic of mere propositions / 纯命题的逻辑

### 纯命题保持的逻辑运算 / Operations Preserving Mere Propositions

| 运算 / Operation | 类型 / Type | 保持纯命题? |
|---|---|---|
| $P \times Q$（合取 / conjunction） | 若 $P, Q$ 是纯命题 | 是 |
| $\prod_{(x:A)} P(x)$（全称 / universal） | 若每个 $P(x)$ 是纯命题 | 是 |
| $A \to P$（蕴含 / implication） | 若 $P$ 是纯命题 | 是（$A$ 任意） |
| $\neg A \equiv A \to \mathbf{0}$（否定 / negation） | | 总是纯命题 |
| $P + Q$（析取 / disjunction） | 即使 $P, Q$ 是纯命题 | **否**（$\mathbf{1} + \mathbf{1} = \mathbf{2}$） |
| $\sum_{(x:A)} P(x)$（存在 / existential） | | **否**（记住了见证） |

**问题：** $+$ 和 $\Sigma$ 不保持纯命题！需要**命题截断**来恢复"经典"析取和存在量词。

$+$ and $\Sigma$ do not preserve mere propositions! We need **propositional truncation** to recover "classical" disjunction and existential quantifier.

---

## 3.7 Propositional truncation / 命题截断

[[Logic/propositional_truncation]]

### 关键定义 / Key Definitions

**命题截断 / Propositional truncation.** 对任意类型 $A$，有类型 $\|A\|$，带两个构造子：
For any type $A$, there is a type $\|A\|$ with two constructors:

1. 对任意 $a : A$，有 $|a| : \|A\|$
   For any $a : A$, we have $|a| : \|A\|$.
2. 对任意 $x, y : \|A\|$，有 $x = y$（即 $\|A\|$ 是纯命题）
   For any $x, y : \|A\|$, we have $x = y$ (i.e., $\|A\|$ is a mere proposition).

**递归原理 / Recursion principle.** 若 $B$ 是纯命题且有 $f : A \to B$，则存在 $g : \|A\| \to B$ 使得 $g(|a|) \equiv f(a)$。

If $B$ is a mere proposition and $f : A \to B$, then there is $g : \|A\| \to B$ with $g(|a|) \equiv f(a)$.

> **核心原则：** $\|A\|$ 作为纯命题，不含超出 $A$ 是否有居民之外的信息。从 $\|A\|$ 只能构造纯命题——因为构造结果不能依赖于被"遗忘"的具体见证。
>
> **Core principle:** $\|A\|$ as a mere proposition contains no more information than whether $A$ is inhabited. From $\|A\|$ we can only construct mere propositions — the result cannot depend on the forgotten witness.

### 截断逻辑的定义 / Traditional Logical Notation (Definition 3.7.1)

$$\begin{aligned}
\top &:\equiv \mathbf{1} \\
\bot &:\equiv \mathbf{0} \\
P \land Q &:\equiv P \times Q \\
P \Rightarrow Q &:\equiv P \to Q \\
P \Leftrightarrow Q &:\equiv P = Q \\
\neg P &:\equiv P \to \mathbf{0} \\
P \lor Q &:\equiv \|P + Q\| \\
\forall_{(x:A)} P(x) &:\equiv \prod_{(x:A)} P(x) \\
\exists_{(x:A)} P(x) &:\equiv \left\|\sum_{(x:A)} P(x)\right\|
\end{aligned}$$

### 子集运算 / Subset Operations

$$\begin{aligned}
\{x : A \mid P(x)\} \cap \{x : A \mid Q(x)\} &:\equiv \{x : A \mid P(x) \land Q(x)\} \\
\{x : A \mid P(x)\} \cup \{x : A \mid Q(x)\} &:\equiv \{x : A \mid P(x) \lor Q(x)\} \\
A \setminus \{x : A \mid P(x)\} &:\equiv \{x : A \mid \neg P(x)\}
\end{aligned}$$

注意：没有 LEM 时，$B \cup (A \setminus B)$ 未必等于 $A$。
Note: without LEM, $B \cup (A \setminus B)$ is not necessarily equal to $A$.

### 为什么重要 / Why It Matters

> 命题截断是连接 HoTT 与传统逻辑的桥梁。它将任意类型"压扁"为纯命题，恢复了经典的"或"和"存在"，同时保留了构造主义的精髓。关键技术：要使用 $\|A + B\|$ 形式的假设证明纯命题 $Q$，只需构造 $A + B \to Q$（即可以做 case analysis）。
>
> Propositional truncation bridges HoTT and traditional logic. It squashes any type into a mere proposition, recovering classical "or" and "exists" while preserving constructive content. Key technique: to prove a mere proposition $Q$ from $\|A + B\|$, it suffices to construct $A + B \to Q$ (case analysis is valid).

---

## 3.8 The axiom of choice / 选择公理

[[Axioms/axiom_of_choice]]

### 关键定义 / Key Definitions

**选择公理 / Axiom of Choice (AC).** 设 $X$ 为集合，$A : X \to \mathcal{U}$ 每个 $A(x)$ 为集合，$P : \prod_{(x:X)} A(x) \to \mathcal{U}$ 每个 $P(x, a)$ 为纯命题。则：
Let $X$ be a set, $A : X \to \mathcal{U}$ a family of sets, and $P : \prod_{(x:X)} A(x) \to \mathcal{U}$ a family of mere propositions. Then:

$$\mathsf{AC} : \left(\prod_{(x:X)} \left\|\sum_{(a:A(x))} P(x,a)\right\|\right) \to \left\|\sum_{(g:\prod_{(x:X)} A(x))} \prod_{(x:X)} P(x,g(x))\right\|$$

用传统记号 / In traditional notation: $\left(\forall_{x:X} \exists_{a:A(x)} P(x,a)\right) \Rightarrow \left(\exists_{g:\prod_{x:X} A(x)} \forall_{x:X} P(x,g(x))\right)$

### 等价形式 / Equivalent Form

**Lemma 3.8.2.** AC 等价于：对任意集合 $X$ 和集合值族 $Y : X \to \mathcal{U}$，

$$\left(\prod_{(x:X)} \|Y(x)\|\right) \to \left\|\prod_{(x:X)} Y(x)\right\|$$

即"非空集族的笛卡尔积非空"。
That is, "the cartesian product of a family of nonempty sets is nonempty."

AC is equivalent to: for any set $X$ and set-valued family $Y : X \to \mathcal{U}$, the product of a family of merely inhabited sets is merely inhabited.

### 关键定理 / Key Theorems

**Lemma 3.8.5 (AC 对非集合的索引失败).** 存在类型 $X$ 和集合值族 $Y : X \to \mathcal{U}$ 使上述等价形式为假。

There exists a type $X$ and a family $Y : X \to \mathcal{U}$ of sets such that the above is false.

**证明构造 / Proof construction:** 取 $X :\equiv \sum_{(A:\mathcal{U})} \|\mathbf{2} = A\|$，$x_0 :\equiv (\mathbf{2}, |\mathsf{refl}|)$。则 $(x_0 = x_0) \simeq (\mathbf{2} \simeq \mathbf{2})$，故 $X$ 不是集合。定义 $Y(x) :\equiv (x_0 = x)$，可证每个 $\|Y(x)\|$ 有居民，但 $\|\prod_x Y(x)\|$ 意味着 $X$ 可缩，矛盾。
Take $X :\equiv \sum_{(A:\mathcal{U})} \|\mathbf{2} = A\|$ and $x_0 :\equiv (\mathbf{2}, |\mathsf{refl}|)$. Then $(x_0 = x_0) \simeq (\mathbf{2} \simeq \mathbf{2})$, so $X$ is not a set. Define $Y(x) :\equiv (x_0 = x)$; each $\|Y(x)\|$ is inhabited, but $\|\prod_x Y(x)\|$ would imply $X$ is contractible — contradiction.

> **深层洞见：** 注意截断出现两次。域中的截断表示"对每个 $x$ 存在某个 $a$，但不指定是哪个"；值域中的截断表示"存在选择函数 $g$，但不指定是哪个"。关键约束：$X$ 必须是集合！$\prod$ 不与 $\|\cdot\|$ 交换：$\|\prod_{x:A} P(x)\|$ 一般不等价于 $\prod_{x:A} \|P(x)\|$。
>
> **Deep insight:** The truncation appears twice. Domain truncation: "for each $x$, some $a$ exists but is not specified." Codomain truncation: "some choice function $g$ exists but is not specified." Critical constraint: $X$ must be a set! $\prod$ does not commute with $\|\cdot\|$ in general.

### 为什么重要 / Why It Matters

> HoTT 中的选择公理比经典集合论更微妙。类型论的朴素 AC（未截断版本 $\mathsf{AC}_\infty$）是可证的（Theorem 2.15.7），但集合论版本（带截断）需要作为公理。而且它只能对集合起作用——高维类型的"选择"可证地失败。
>
> AC in HoTT is subtler than in classical set theory. The naive type-theoretic AC ($\mathsf{AC}_\infty$, untruncated) is provable, but the set-theoretic version (with truncation) must be assumed as an axiom, and it only works for sets — "choice" for higher-dimensional types provably fails.

---

## 3.9 The principle of unique choice / 唯一选择原理

[[Logic/unique_choice]]

### 关键定理 / Key Theorems

**Lemma 3.9.1 (纯命题等价于其截断).** 若 $P$ 是纯命题，则 $P \simeq \|P\|$。

If $P$ is a mere proposition, then $P \simeq \|P\|$.

**Corollary 3.9.2 (唯一选择原理 / Principle of Unique Choice).** 设类型族 $P : A \to \mathcal{U}$ 满足：
Let $P : A \to \mathcal{U}$ be a type family such that:
1. 每个 $P(x)$ 是纯命题 / each $P(x)$ is a mere proposition
2. 每个 $\|P(x)\|$ 有居民 / each $\|P(x)\|$ is inhabited

则 $\prod_{(x:A)} P(x)$。
Then $\prod_{(x:A)} P(x)$.

If each $P(x)$ is a mere proposition and each $\|P(x)\|$ is inhabited, then $\prod_{(x:A)} P(x)$.

### 实用技术 / Practical Technique

若已知 $\|A\|$，想从中构造 $B$ 的元素 / If we know $\|A\|$ and want to construct an element of $B$:

1. 直接只能证 $\|B\|$（因为从截断只能到纯命题）
   Directly we can only derive $\|B\|$ (since from truncations we can only map into mere propositions).
2. **唯一选择的绕行 / Unique choice workaround:** 定义谓词 $Q : B \to \mathcal{U}$ 使 $\sum_{(x:B)} Q(x)$ 是纯命题。从 $A$ 的元素构造 $(b, q)$，由截断得 $\left\|\sum_{(x:B)} Q(x)\right\|$，再由 Lemma 3.9.1 得 $\sum_{(x:B)} Q(x)$，投影得 $b : B$。
   Define a predicate $Q : B \to \mathcal{U}$ so that $\sum_{(x:B)} Q(x)$ is a mere proposition. Construct $(b,q)$ from elements of $A$, obtain $\left\|\sum_{(x:B)} Q(x)\right\|$ by truncation, then apply Lemma 3.9.1 and project to get $b : B$.

### 为什么重要 / Why It Matters

> 唯一选择原理说：当存在性是唯一的，截断不损失信息——不需要选择公理！这在实践中极为有用：许多"存在且唯一"的构造可以直接从截断存在性中提取见证，绕过 AC。这也解释了为什么 HoTT（尤其在 univalence 下）比集合论更适合处理"典范"构造。
>
> Unique choice says: when existence is unique, truncation loses nothing — no AC needed! Extremely useful in practice: many "exists and unique" constructions can extract witnesses from truncated existence, bypassing AC. This explains why HoTT (especially with univalence) handles "canonical" constructions better than set theory.

---

## 3.10 When are propositions truncated? / 何时截断命题？

### 截断 vs 非截断逻辑 / Truncated vs Untruncated Logic

本书默认使用**非截断逻辑**（命题即类型），需要截断时用副词"merely"标记。

This book defaults to **untruncated logic** (propositions-as-types), using the adverb "merely" when truncation is needed.

| 表述 / Phrase | 含义 / Meaning |
|---|---|
| "there exists $x : A$ such that $P(x)$" | $\sum_{(x:A)} P(x)$ |
| "there **merely** exists $x : A$ such that $P(x)$" | $\left\|\sum_{(x:A)} P(x)\right\|$ |
| "$A$ is inhabited" | $A$ 有居民 |
| "$A$ is **merely** inhabited" | $\|A\|$ 有居民 |

### 为何默认非截断 / Reasons for Untruncated Default

1. 鼓励探索非截断逻辑
   Encourage exploring the untruncated logic.
2. 避免集合论基础中"语言滥用"的问题（如证明"$A \simeq B$"实际构造了具体等价）
   Avoid the "abuse of language" problem of set-theoretic foundations (e.g., a proof "$A \simeq B$" actually constructs a specific equivalence).
3. 强调纯命题不是类型论的基本概念，只是无穷层级的第二层
   Emphasize that mere propositions are not a primitive of type theory, just the second layer of the infinite hierarchy.
4. HoTT 中许多经典意义上的命题不再是纯命题（首先是相等性）
   In HoTT, many classical "propositions" are no longer mere propositions (equality being the first example).
5. 许多类型自动是纯命题，无需截断即可使用
   Many types are automatically mere propositions and can be used without truncation.
6. 本书大部分数学不需要截断
   Most mathematics in this book does not require truncation.

---

## 3.11 Contractibility / 可缩性

[[Truncation_Levels/contractibility]]

### 关键定义 / Key Definitions

**Definition 3.11.1 (Contractible type / 可缩类型).** 类型 $A$ 是**可缩的 (contractible)** 若存在 $a : A$（**收缩中心 / center of contraction**）使得对所有 $x : A$ 有 $a = x$。

$$\mathsf{isContr}(A) :\equiv \sum_{(a:A)} \prod_{(x:A)} (a = x)$$

等价称呼 / Equivalent names: (-2)-type, singleton type.

### 等价刻画 / Equivalent Characterizations

**Lemma 3.11.3.** 对类型 $A$，以下逻辑等价 / For a type $A$, the following are logically equivalent:
1. $A$ 可缩 / $A$ is contractible
2. $A$ 是纯命题且有居民 / $A$ is a mere proposition and is inhabited
3. $A \simeq \mathbf{1}$

For a type $A$, the following are logically equivalent:
1. $A$ is contractible
2. $A$ is a mere proposition and there is a point $a : A$
3. $A \simeq \mathbf{1}$

### 关键定理 / Key Theorems

**Lemma 3.11.4 ($\mathsf{isContr}$ 是纯命题).** 对任意类型 $A$，$\mathsf{isContr}(A)$ 是纯命题。

For any type $A$, $\mathsf{isContr}(A)$ is a mere proposition.

**Corollary 3.11.5 (可缩类型的可缩性可缩).** 若 $A$ 可缩，则 $\mathsf{isContr}(A)$ 可缩。

If $A$ is contractible, then $\mathsf{isContr}(A)$ is contractible.

**Lemma 3.11.6 ($\prod$ 保持可缩性).** 若 $P : A \to \mathcal{U}$ 每个 $P(a)$ 可缩，则 $\prod_{(x:A)} P(x)$ 可缩。

If each $P(a)$ is contractible, then $\prod_{(x:A)} P(x)$ is contractible.

（此引理实际上等价于函数外延性！）
(This lemma is actually equivalent to function extensionality!)

**Lemma 3.11.8 (缩回保持可缩性).** 若 $B$ 是 $A$ 的缩回（retract），且 $A$ 可缩，则 $B$ 可缩。

If $B$ is a retract of $A$ and $A$ is contractible, then $B$ is contractible.

**Lemma 3.11.9 (自由端点路径空间可缩).** 对任意 $A$ 和 $a : A$，类型 $\sum_{(x:A)} (a = x)$ 可缩。

For any $A$ and $a : A$, the type $\sum_{(x:A)} (a = x)$ is contractible.

**Lemma 3.11.10 (可缩数据可忽略 / Contractible data can be ignored).**
1. 若每个 $P(x)$ 可缩，则 $\sum_{(x:A)} P(x) \simeq A$
   If each $P(x)$ is contractible, then $\sum_{(x:A)} P(x) \simeq A$.
2. 若 $A$ 可缩（中心 $a$），则 $\sum_{(x:A)} P(x) \simeq P(a)$
   If $A$ is contractible with center $a$, then $\sum_{(x:A)} P(x) \simeq P(a)$.

**Lemma 3.11.11 (纯命题 $\iff$ 恒等类型可缩).** $A$ 是纯命题当且仅当对所有 $x, y : A$，$x =_A y$ 可缩。

$A$ is a mere proposition iff for all $x, y : A$, $x =_A y$ is contractible.

### n-type 层级总结 / n-type Hierarchy Summary

$$\underbrace{\mathsf{isContr}(A)}_{(-2)\text{-type}} \;\Rightarrow\; \underbrace{\mathsf{isProp}(A)}_{(-1)\text{-type}} \;\Rightarrow\; \underbrace{\mathsf{isSet}(A)}_{0\text{-type}} \;\Rightarrow\; \underbrace{\text{is-1-Type}(A)}_{1\text{-type}} \;\Rightarrow\; \cdots$$

递归定义的基础：$A$ 是 $(n+1)$-type $\iff$ 对所有 $x, y : A$，$x =_A y$ 是 $n$-type。可缩类型（$(-2)$-type）是递归的 base case。第 7 章将系统发展这个层级。

The recursive definition: $A$ is an $(n+1)$-type iff for all $x, y : A$, $x =_A y$ is an $n$-type. Contractible types ($(-2)$-types) are the base case. Chapter 7 will develop this hierarchy systematically.

### 为什么重要 / Why It Matters

> 可缩类型看似平凡（都等价于 $\mathbf{1}$），但它的真正威力在于：个别非平凡的数据组合后可以形成可缩类型。自由端点路径空间 $\sum_{(x:A)} (a = x)$ 的可缩性本质上编码了基于路径的归纳原理。"可缩数据可忽略"原则让我们能化简复杂构造，将其等价到更简单的类型。
>
> Contractible types seem trivial (all equivalent to $\mathbf{1}$), but their real power: individually nontrivial data can collectively form a contractible type. The contractibility of $\sum_{(x:A)}(a=x)$ essentially encodes based path induction. The "contractible data can be ignored" principle lets us simplify complex constructions up to equivalence.

---

## 章节练习精选 / Selected Exercises

| 练习 / Exercise | 内容 / Content |
|---|---|
| 3.1 | 若 $A \simeq B$ 且 $A$ 是集合，则 $B$ 是集合。/ If $A \simeq B$ and $A$ is a set, so is $B$. |
| 3.4 | $A$ 是纯命题 $\iff$ $A \to A$ 可缩。/ $A$ is a mere proposition iff $A \to A$ is contractible. |
| 3.5 | $\mathsf{isProp}(A) \simeq (A \to \mathsf{isContr}(A))$ |
| 3.6 | 若 $A$ 是纯命题，则 $A + (\neg A)$ 也是纯命题。/ If $A$ is a mere proposition, so is $A + (\neg A)$. |
| 3.7 | 若 $A, B$ 是纯命题且 $\neg(A \times B)$，则 $A + B$ 是纯命题。/ If $A, B$ are mere propositions and $\neg(A \times B)$, then $A + B$ is a mere proposition. |
| 3.11 | LEM $\Rightarrow$ $\mathsf{Prop} \simeq \mathbf{2}$ |
| 3.14 | LEM $\Rightarrow$ $\neg\neg A$ 有与 $\|A\|$ 相同的递归原理 $\Rightarrow$ $\neg\neg A \simeq \|A\|$。/ Under LEM, $\neg\neg A$ has the same recursion principle as $\|A\|$, so $\neg\neg A \simeq \|A\|$. |
| 3.17 | LEM 与双重否定律等价。/ LEM is equivalent to double negation. |
| 3.19 | 若 $P : \mathbb{N} \to \mathcal{U}$ 是可判定纯命题族，则 $\left\|\sum_n P(n)\right\| \to \sum_n P(n)$。/ If $P : \mathbb{N} \to \mathcal{U}$ is a decidable family of mere propositions, then $\left\|\sum_n P(n)\right\| \to \sum_n P(n)$. |

---

## 概念关联 / Concept Links

- **前置 / Prerequisites:** [[ch01_type_theory]] (basic type formers), [[ch02_homotopy_type_theory]] (paths, transport, univalence)
- **后续 / Leads to:** [[ch04_equivalences]] (precise definitions of equivalence), [[ch07_homotopy_n_types]] (systematic development of the n-type hierarchy)
- **相关概念 / Related concepts:** [[Truncation_Levels/sets]], [[Logic/propositions_as_types_problem]], [[Truncation_Levels/mere_propositions]], [[Logic/classical_vs_intuitionistic]], [[Logic/subsets]], [[Logic/propositional_truncation]], [[Axioms/axiom_of_choice]], [[Logic/unique_choice]], [[Truncation_Levels/contractibility]]
