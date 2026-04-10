---
title: "Chapter 8: Homotopy Theory / 同伦论"
type: chapter-digest
---

# Chapter 8: Homotopy Theory / 同伦论

全书的高潮——用前面发展的工具（恒等类型、高阶归纳类型、截断、连通性）在类型论内部证明经典同伦论的核心定理。采用**综合方法 (synthetic approach)**：空间=类型，路径=恒等类型，同伦=高阶路径。

The climax of the book — proving core theorems of classical homotopy theory entirely within type theory using identity types, HITs, truncation, and connectedness. The **synthetic approach**: spaces = types, paths = identity types, homotopies = higher paths.

> **核心洞察 / Key insight:** 类型论中的证明自动适用于所有 $(\infty,1)$-topos 的模型，不仅仅是经典拓扑空间。Univalence 公理在计算同伦群中起着本质性的作用——没有它，所有类型都可以是集合。
>
> Proofs in type theory automatically apply in all $(\infty,1)$-topos models, not just classical topological spaces. The univalence axiom is essential for computing homotopy groups — without it, all types could consistently be sets.

---

## 8.0 同伦群的定义 / Definition of Homotopy Groups

**Definition (Homotopy Groups).** 给定 $n \ge 1$ 和尖点类型 $(A, a)$，定义同伦群：
$$\pi_n(A, a) \defeq \| \Omega^n(A, a) \|_0$$
其中迭代环路空间递归定义为 $\Omega^0(A,a) = (A,a)$，$\Omega^{n+1}(A,a) = \Omega^n(\Omega(A,a))$。

Given $n \ge 1$ and pointed type $(A, a)$, the **homotopy groups** are $\pi_n(A,a) \defeq \| \Omega^n(A,a) \|_0$, where iterated loop spaces are defined recursively.

- 当 $n \ge 1$ 时，$\pi_n(A)$ 构成群（群运算来自路径拼接与逆）/ For $n \ge 1$, $\pi_n(A)$ forms a group (from path concatenation and inversion)
- 当 $n \ge 2$ 时，$\pi_n(A)$ 是交换群（Eckmann-Hilton 论证）/ For $n \ge 2$, $\pi_n(A)$ is abelian (Eckmann-Hilton argument)
- 约定 $\pi_0(A) \defeq \| A \|_0$（不是群，且不依赖基点）/ Convention: $\pi_0(A) \defeq \| A \|_0$ (not a group, no basepoint needed)

---

## 8.1 $\pi_1(S^1) = \mathbb{Z}$
[[Homotopy_Theory/pi1_circle]]

### 万有覆盖 / The Universal Cover

**Definition (Universal Cover of $S^1$).** 用圆的递归定义 $\text{code} : S^1 \to \mathcal{U}$：
$$\text{code}(\text{base}) \defeq \mathbb{Z}, \qquad \text{ap}_{\text{code}}(\text{loop}) = \text{ua}(\text{succ})$$

Define $\text{code} : S^1 \to \mathcal{U}$ by circle recursion: $\text{code}(\text{base}) \defeq \mathbb{Z}$ and $\text{ap}_{\text{code}}(\text{loop}) = \text{ua}(\text{succ})$.

> **直觉 / Intuition:** $\text{code}$ 是圆的万有覆盖空间的类型论版本。纤维是 $\mathbb{Z}$，沿 loop 的 transport 是后继函数——正如经典螺旋线覆盖，绕圆一圈对应于在整数上加 1。
>
> $\text{code}$ is the type-theoretic universal cover. The fiber is $\mathbb{Z}$, transport along loop is successor — just like the classical helix, going around the circle adds 1 to the integer.

**Lemma.** $\text{transport}^{\text{code}}(\text{loop}, x) = x + 1$ 且 $\text{transport}^{\text{code}}(\bar{\text{loop}}, x) = x - 1$。

### Encode-Decode 方法 / The Encode-Decode Method
[[Identity_and_Paths/encode_decode]]

**Definition.** 定义 $\text{encode} : \prod_{x:S^1} (\text{base} = x) \to \text{code}(x)$ 为 $\text{encode}(p) \defeq \text{transport}^{\text{code}}(p, 0)$。

**Definition.** 定义 $\text{decode} : \prod_{x:S^1} \text{code}(x) \to (\text{base} = x)$ 在 $x \equiv \text{base}$ 时为 $\text{decode}(n) \defeq \text{loop}^n$。

**Lemma.** 对所有 $x : S^1$ 和 $p : \text{base} = x$，有 $\text{decode}_x(\text{encode}_x(p)) = p$（通过路径归纳 / by path induction）。

**Lemma.** 对所有 $n : \mathbb{Z}$，有 $\text{encode}'(\text{loop}^n) = n$（通过整数归纳 / by integer induction）。

**Theorem.** 存在等价族 $\prod_{x:S^1} (\text{base} = x) \simeq \text{code}(x)$。

**Corollary.** $\Omega(S^1, \text{base}) \simeq \mathbb{Z}$。

**Corollary.** $\pi_1(S^1) = \mathbb{Z}$，而 $\pi_n(S^1) = 0$ 对 $n > 1$（因为 $\mathbb{Z}$ 是集合 / since $\mathbb{Z}$ is a set）。

> **注意 / Remark:** 所有关于 $\pi_1(S^1) = \mathbb{Z}$ 的证明都本质性地使用了 univalence 公理。没有 univalence，类型论与 "所有类型都是集合" 相容，这将使 $\pi_1(S^1) = 1$。

---

## 8.2 悬挂的连通性 / Connectedness of Suspensions
[[Homotopy_Theory/connectedness_suspensions]]

**Theorem.** 如果 $A$ 是 $n$-connected 的，则其悬挂 $\Sigma A$ 是 $(n+1)$-connected 的。

If $A$ is $n$-connected, then $\Sigma A$ is $(n+1)$-connected.

**Corollary.** 球面 $S^n$ 是 $(n-1)$-connected 的。/ The sphere $S^n$ is $(n-1)$-connected.

证明利用了截断推出的交换性：$\| \Sigma A \|_{n+1}$ 是截断类型中 $\| A \|_{n+1}$ 对应图表的推出。

---

## 8.3 $n$-connected 空间的同伦群 / Homotopy Groups of Connected Spaces
[[Homotopy_Theory/homotopy_groups]]

**Lemma.** 如果 $A$ 是 $n$-type 且 $k > n$，则 $\pi_k(A, a) = 1$。

**Lemma.** 如果 $A$ 是 $n$-connected 且 $k \le n$，则 $\pi_k(A, a) = 1$。

If $A$ is $n$-connected and $k \le n$, then $\pi_k(A,a) = 1$.

证明要点 / Proof sketch: $\pi_k(A,a) = \| \Omega^k(A,a) \|_0 = \Omega^k(\| A \|_k) = \Omega^k(\| \| A \|_n \|_k) = \Omega^k(\| 1 \|_k) = \Omega^k(1) = 1$。

**Corollary.** $\pi_k(S^n) = 1$ 对 $k < n$。/ $\pi_k(S^n) = 1$ for $k < n$.

---

## 8.4 纤维序列与长正合列 / Fiber Sequences and the Long Exact Sequence
[[Homotopy_Theory/fiber_sequences]]

**Definition (Pointed Map).** 尖点映射 $f : (X,x_0) \to (Y,y_0)$ 由映射 $f : X \to Y$ 加路径 $f_0 : f(x_0) = y_0$ 构成。

**Definition (Loop Space Functor).** $(\Omega f)(p) \defeq \bar{f_0} \cdot \text{ap}_f(p) \cdot f_0$。

**Definition (Fiber Sequence).** 尖点映射 $f : X \to Y$ 的纤维序列是无穷序列 $\cdots \to X^{(n+1)} \xrightarrow{f^{(n)}} X^{(n)} \to \cdots \to X^{(1)} \xrightarrow{f^{(0)}} X^{(0)}$，其中 $X^{(0)} = Y$，$X^{(1)} = X$，$f^{(0)} = f$，$X^{(n+1)} = \text{fib}_{f^{(n-1)}}(x_0^{(n-1)})$。

**Lemma.** 纤维序列等价于：$\cdots \to \Omega^2 X \to \Omega^2 Y \to \Omega F \to \Omega X \to \Omega Y \to F \to X \to Y$

**Theorem (Long Exact Sequence).** 对尖点映射 $f : X \to Y$，纤维 $F \defeq \text{fib}_f(y_0)$，存在长正合列：
$$\cdots \to \pi_k(F) \to \pi_k(X) \to \pi_k(Y) \to \pi_{k-1}(F) \to \cdots \to \pi_0(F) \to \pi_0(X) \to \pi_0(Y)$$
其中 $k \ge 2$ 时为交换群的正合列，$k = 1$ 时为群的正合列。

> **正合性 / Exactness:** $\text{im}(f^{(n)}) = \ker(f^{(n-1)})$，即 $f^{(n-1)}(a) = a_0^{(n-1)}$ 当且仅当 $\exists b : A^{(n+1)}$ 使得 $f^{(n)}(b) = a$。

**Corollary.** 如果 $f : A \to B$ 是 $n$-connected 的且 $k \le n$，则 $\pi_k(f)$ 是同构；若 $k = n+1$，则 $\pi_k(f)$ 是满射。

---

## 8.5 Hopf 纤维化 / The Hopf Fibration
[[Homotopy_Theory/hopf_fibration]]

**Definition (H-space).** H-空间由类型 $A$、基点 $e : A$、二元运算 $\mu : A \times A \to A$、以及等式 $\mu(e,a) = a$、$\mu(a,e) = a$ 构成。

**Lemma.** 连通 H-空间的左右乘法映射都是等价。

**Lemma (Hopf Construction).** 给定连通 H-空间 $A$，存在 $\Sigma A$ 上的纤维化，纤维为 $A$，总空间为 join $A * A$。

**Lemma.** $S^1$ 具有 H-空间结构。/ $S^1$ has an H-space structure.

乘法 $\mu$ 通过圆的递归定义：$\tilde{\mu}(\text{base}) \defeq \text{id}_{S^1}$，$\text{ap}_{\tilde{\mu}}(\text{loop}) = \text{funext}(h)$，其中 $h : \prod_{x:S^1} (x = x)$ 来自 $S^1$ 的自同伦。

**Theorem (Hopf Fibration).** 存在 $S^2$ 上的纤维化，纤维为 $S^1$，总空间为 $S^3$。

Proof: $S^1 * S^1 = (\Sigma \mathbf{2}) * S^1 = (\mathbf{2} * \mathbf{2}) * S^1 = \mathbf{2} * (\mathbf{2} * S^1) = \Sigma(\Sigma S^1) = S^3$。

**Corollary.** $\pi_2(S^2) \cong \mathbb{Z}$ 且 $\pi_k(S^3) \cong \pi_k(S^2)$ 对 $k \ge 3$。

由长正合列：$\cdots \to \pi_k(S^1) \to \pi_k(S^3) \to \pi_k(S^2) \to \cdots$，利用已知的 $\pi_k(S^1)$ 和 $\pi_k(S^n)$ ($k < n$) 即得。

---

## 8.6 Freudenthal 悬挂定理 / The Freudenthal Suspension Theorem
[[Homotopy_Theory/freudenthal]]

**Theorem (Freudenthal Suspension Theorem).** 若 $X$ 是 $n$-connected 尖点类型（$n \ge 0$），则映射
$$\sigma : X \to \Omega \Sigma X, \quad \sigma(x) \defeq \text{merid}(x) \cdot \overline{\text{merid}(x_0)}$$
是 $2n$-connected 的。

> **核心工具 / Key tools:** 证明结合了 encode-decode 方法与 **楔连通性引理 (wedge connectivity lemma)**：若 $(A, a_0)$ 和 $(B, b_0)$ 分别是 $n$- 和 $m$-connected 尖点类型，$P : A \to B \to (n+m)\text{-type}$，则可在 $a_0$ 处和 $b_0$ 处分别给出截面后扩展到整个 $A \times B$。

**Corollary (Freudenthal Equivalence).** $\| X \|_{2n} \simeq \| \Omega \Sigma X \|_{2n}$。

**Corollary (Stability for Spheres).** 若 $k \le 2n - 2$，则 $\pi_{k+1}(S^{n+1}) = \pi_k(S^n)$。

**Theorem.** $\pi_n(S^n) = \mathbb{Z}$ 对所有 $n \ge 1$。/ $\pi_n(S^n) = \mathbb{Z}$ for all $n \ge 1$.

Proof: 对 $n$ 归纳。基础情形 $\pi_1(S^1) = \mathbb{Z}$ 和 $\pi_2(S^2) = \mathbb{Z}$ 已知，归纳步骤由稳定性给出。

**Corollary.** $\pi_3(S^2) = \mathbb{Z}$（由 $\pi_3(S^2) = \pi_3(S^3) = \mathbb{Z}$）。

---

## 8.7 Van Kampen 定理 / The van Kampen Theorem
[[Homotopy_Theory/van_kampen]]

对推出 $P = B \sqcup^A C$（$f : A \to B$，$g : A \to C$），定义路径码 $\text{code} : P \to P \to \mathcal{U}$，由交替出现在 $B$ 和 $C$ 中的路径序列及适当的等价关系构成。

**Theorem (Van Kampen).** 对推出 $P$ 的所有 $u, v : P$，有等价 $\Pi_1 P(u,v) \simeq \text{code}(u,v)$，其中 $\Pi_1 P(u,v) \defeq \| u =_P v \|_0$。

**Example.** $\pi_1(S^1) \cong \mathbb{Z}$（取 $A = \mathbf{2}$，$B = C = \mathbf{1}$）。

**Example.** $\pi_1(B \vee C) \cong \pi_1(B) * \pi_1(C)$（自由积 / free product）。

**Example (Classical VK).** 若 $A$ 连通且有基点，则 $\pi_1(B \sqcup^A C) \cong \pi_1(B) *_{\pi_1(A)} \pi_1(C)$（amalgamated free product）。

**Example.** $\pi_1(T^2) \cong \mathbb{Z} \times \mathbb{Z}$（环面 / torus）。

**Example.** 任何群都是某个类型的基本群（通过构造 Eilenberg-Mac Lane 空间 $K(G,1)$）。

---

## 8.8 Whitehead 定理与 Whitehead 原理 / Whitehead's Theorem and Principle
[[Homotopy_Theory/whitehead]]

**Theorem (Truncated Whitehead).** 若 $A$、$B$ 是 $n$-type，$f : A \to B$ 使得 $\| f \|_0$ 是双射且所有 $\pi_k(f)$ 是双射，则 $f$ 是等价。

If $A, B$ are $n$-types and $f : A \to B$ induces bijections on $\pi_0$ and all $\pi_k$, then $f$ is an equivalence.

> **重要区别 / Important distinction:** 完整的 Whitehead 定理（对一般类型）在 HoTT 中**不可证明**——它在非超完备 $(\infty,1)$-topos 中失败。作为公理（Whitehead 原理）可以一致地添加，但不是计算性类型论的一部分。

**Corollary.** 若 $A$ 是 0-connected $n$-type 且所有 $\pi_k(A, a) = 0$，则 $A$ 可缩。

**Corollary.** 对 $n \ge 0$，映射 $f : A \to B$ 是 $n$-connected 当且仅当 $\pi_0(f)$ 是同构，$\pi_k(f)$ 对 $k \le n$ 是同构，$\pi_{n+1}(f)$ 是满射。

---

## 8.9 Encode-Decode 方法（一般形式） / General Encode-Decode Method
[[Identity_and_Paths/encode_decode]]

**Lemma (Encode-decode for Loop Spaces).** 给定尖点类型 $(A, a_0)$ 和纤维化 $\text{code} : A \to \mathcal{U}$，若：
1. $c_0 : \text{code}(a_0)$
2. $\text{decode} : \prod_{x:A} \text{code}(x) \to (a_0 = x)$
3. 对所有 $c : \text{code}(a_0)$，$\text{transport}^{\text{code}}(\text{decode}(c), c_0) = c$
4. $\text{decode}(c_0) = \text{refl}$

则 $(a_0 = a_0) \simeq \text{code}(a_0)$。

> 该方法的变体已用于：余积 (Ch2)、自然数 (Ch2)、截断 (Ch7)、圆 (8.1)、悬挂/Freudenthal (8.6)、推出/van Kampen (8.7)。

---

## 8.10 其他结果 / Additional Results
[[Homotopy_Theory/additional_results]]

**Theorem.** 存在 $k$ 使得对所有 $n \ge 3$，$\pi_{n+1}(S^n) = \mathbb{Z}_k$。（经典中 $k = 2$；HoTT 证明是构造性的，可运行以验证。）

**Theorem (Blakers-Massey).** 若 $f : C \to X$ 是 $i$-connected，$g : C \to Y$ 是 $j$-connected，则诱导映射 $C \to X \times_{(X \sqcup^C Y)} Y$ 是 $(i+j)$-connected。

**Theorem (Eilenberg-Mac Lane Spaces).** 对任何交换群 $G$ 和正整数 $n$，存在 $n$-type $K(G,n)$ 使得 $\pi_n(K(G,n)) = G$ 且 $\pi_k(K(G,n)) = 0$ ($k \ne n$)。

**Theorem (Covering Spaces).** 对连通空间 $A$，覆盖空间与带 $\pi_1(A)$ 作用的集合之间有等价。

---

**核心技术 / Core technique:** [[Identity_and_Paths/encode_decode|Encode-decode]] 是贯穿本章的核心方法，连接 [[Identity_and_Paths/|路径空间的结构]] 与 [[Higher_Inductive_Types/|具体空间的构造]]。Univalence 公理将类型等价转化为宇宙中的路径，从而提取同伦信息。
