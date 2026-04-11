---
type: research-note
title: "Cubical Type Theory vs 传统 HoTT"
tags: [research-notes, cubical-type-theory, HoTT, univalence, comparison]
references:
  - "[[univalence_axiom]]"
  - "[[Axioms/univalence]]"
  - "[[Identity_and_Paths/identity_type]]"
---

# Cubical Type Theory vs 传统 HoTT

## 一句话

> **HoTT 是一个声明**：类型 = 空间，等价 = 路径。
>
> **Cubical type theory 是一个实现**：让这个声明里的操作都能真正"跑起来"。

两者描述的是**同一个数学结构**（∞-groupoid 模型），但形式化方式根本不同。

---

## 核心区别：univalence 的地位

### 传统 HoTT

Univalence 是一条**公理**。你声明

$$\mathsf{ua} : (A \simeq B) \to (A = B)$$

存在，然后用它推理。但问题是 **`ua` 没有计算规则**：

```
theorem foo : Bool = Bool := ua swapEquiv
#eval foo  -- 卡住！因为 ua 是黑盒
```

所有涉及 `transport^(ua e)` 的证明都无法化简，你只能在命题等式层面上操作。

**更严重的后果**：这违反了类型论的**典范性 (canonicity)**——封闭项 (closed term) 应该可以规约到典范形式。加入 univalence 后，Natural number 的封闭项仍然能规约到 $0, 1, 2, \ldots$，但更复杂的项就可能卡在 `ua` 上。

此外，计算规则 $\mathsf{idtoeqv}(\mathsf{ua}(e)) = e$ 在标准 HoTT 里只是**命题等式**，不是定义等式。这让形式化变得繁琐。

### Cubical Type Theory

Univalence **被证明出来**（不是公理），而且所有操作都计算。代价：底层类型论的结构完全不同。

核心想法：**重新定义恒等类型**。

不把 $a = b$ 看作归纳类型（只有 `refl` 一个构造子），而是看作从区间 $\mathbb{I}$ 到类型的**函数**：

$$a =_A b \;:\equiv\; \prod_{i : \mathbb{I}} A \;\;\text{with}\;\; p(0) = a,\; p(1) = b$$

这里 $\mathbb{I}$ 是一个**原始区间**——不是一个类型，而是类型论内置的"形状"，有两个端点 $0, 1$ 和各种面操作 (face operations)。

**路径就是函数**：

```
p : a = b     意思是     p : I → A，且 p(0) ≡ a 且 p(1) ≡ b
```

这和拓扑学里"路径是 $[0,1] \to X$ 的映射"直接对应——cubical 就是字面地把这个变成类型论的原语。

---

## 关键差异对比

| 方面 | HoTT | Cubical TT |
|---|---|---|
| 恒等类型 | 归纳类型，只有 `refl` | 函数类型 $\mathbb{I} \to A$ |
| 路径归纳 (J) | 原始消去规则 | 推导出来 |
| Univalence | 公理 | 定理（可证） |
| Funext | 公理或定理 | 定理（直接构造：$\lambda i.\, \lambda x.\, p(x)(i)$） |
| Transport | 由 J 定义 | 原始操作（基于 Kan filling） |
| 计算规则 | `ua` 不计算 | 一切都计算 |
| 典范性 | 破坏（因 `ua`） | 保持 |
| HITs | 手动公理化 | 通过 cubical 原语自然支持 |

---

## 直观理解：路径的本质

这是两者最深的差别：

### HoTT：路径是"点"

路径是恒等类型的元素。`refl` 是唯一构造子。我们用 J 规则间接操作它们。

```
rfl : a = a   ← 这是一个点（恒等类型的元素）
其他路径通过构造得到（symm、trans、ap 等，都由 J 定义）
```

### Cubical：路径是"函数"

$p : a = b$ **是**一个从 $\mathbb{I}$ 到 $A$ 的连续映射。你可以**抽象和应用**它：

```cubical
p : a = b           -- 意味着 p : I → A
p 0 ≡ a             -- definitional equality
p 1 ≡ b             -- definitional equality
p i                 -- 取 p 在时刻 i 的值（a 和 b 之间的"中间点"）

-- 自反性
refl : a = a
refl = λ i → a      -- 常函数：任何时刻都在 a
```

**路径自反性变成"常值函数"**——这比"$\mathsf{refl}$ 是一个原始构造子"更几何，也更可计算。

---

## 为什么 univalence 在 cubical 中可证

Cubical TT 有一个关键的基本构造叫 **Glue type**。它允许把"类型 $A$ 在某个边界沿等价 $e$ 被替换"表达为一个新类型：

$$\mathsf{Glue}\,[e : A \simeq B]\, B$$

这个 glue 构造直接给出了从 $A \simeq B$ 到 $A = B$ 的路径——因为 glue 在路径意义下把 $A$ 沿 $e$"粘"到 $B$。

具体来说：

```cubical
ua : (e : A ≃ B) → A = B
ua e = λ i → Glue B [...边界条件用 e...]
```

这条路径 $i$ 从 $A$（当 $i = 0$）到 $B$（当 $i = 1$）平滑变化，中间每个位置都是一个 Glue 类型。

**结果**：
- Univalence 在 cubical 中是**一个定理**，证明是具体的构造
- `ua` **现在计算了**——$\mathsf{transport}^{X \mapsto X}\, (\mathsf{ua}\, e)$ 可以实际求值到 $e$
- 典范性**保持**

---

## Kan operation / composition

Cubical 的另一个关键特性：**Kan operations**（或叫 composition / filling）。这些操作保证了高阶路径结构的连贯性。

**直觉**：在拓扑学中，如果你有一个"方格"的三条边，你可以"填满"得到第四条边。Cubical TT 把这作为**原始操作**：

```
给定：p : a = b, q : b = c
构造：p · q : a = c   (通过 Kan composition)
```

这让路径操作（拼接、逆、结合律等）都有**直接的几何定义**，而不是通过 J 规则间接推导。

更一般地：Kan operations 保证任何"部分指定"的高维立方体都可以被"填满"。这是 cubical 模型与 Kan simplicial set 模型的联系点。

---

## 实际系统

| 系统 | 类型 | 状态 |
|---|---|---|
| **Coq + HoTT library** | 传统 HoTT，公理形式 | 生产可用 |
| **Agda + HoTT library** | 传统 HoTT，`--without-K` | 生产可用 |
| **Lean 4 + Mathlib** | 不支持 univalence，有近似 | 数学库巨大 |
| **Cubical Agda** | Cubical TT | 生产可用，最成熟 |
| **cubicaltt** | 原型实现 (Mörtberg, Cohen, Coquand, Huber) | 研究原型 |
| **redtt / cooltt** | Carnegie Mellon 实验系统 | 研究原型 |
| **Arend** | JetBrains，基于 cubical 思想 | 积极开发 |

**实践建议**：对大部分 HoTT 形式化目的，**Cubical Agda** 是目前最成熟的选择。

---

## 为什么两者都存在

既然 cubical 能把 univalence 变成定理，为什么大家还在用传统 HoTT？

### 1. 复杂度

Cubical 的底层机制（区间、面操作、Kan composition、Glue types）比传统类型论复杂得多：
- 学习曲线陡峭
- 实现复杂（需要专门的 type checker 支持）
- 证明助手开发难度大

### 2. 历史

HoTT Book 用传统类型论写成（2013 年左右，cubical 还在早期）。大量现有工作和文献都在传统框架中。

### 3. 生态系统

Lean 4 + Mathlib 有巨大的数学库，但基础不是 cubical。把那些数学翻译到 cubical 需要大工程。Coq 的情况类似。

### 4. 哲学

有些研究者认为 univalence 作为公理更**清晰**——先承认这个深刻的原理，然后看后果。Cubical 把它隐藏在机械实现里，可能遮蔽了数学内容。

### 5. 未定问题

某些 HoTT 构造在 cubical 中的具体形式仍在研究中——比如某些 HIT 的计算规则，或者正确的普遍宇宙处理。

---

## HoTT Book vs Cubical TT 的"同一性"

关键事实：**两者证明的数学定理是一样的**。

如果你证明了 $\pi_1(S^1) = \mathbb{Z}$，不管你在 HoTT 还是 cubical 中证明，它都是同一个数学事实。

区别在于形式化的性质：
- **HoTT**：形式化的证明可能不计算，但数学内容清晰
- **Cubical**：证明实际可以跑，典范性保持，但底层机制复杂

可以这样理解：cubical 给出了 HoTT 的**构造性语义**。Voevodsky 的最初 HoTT 是一个**元理论层面**的语义（通过 Kan simplicial sets 模型），而 cubical 把这个语义**内化**到类型论中，使得它不再需要外部模型即可具有构造性意义。

---

## 相关参考

### 内部链接

- [[univalence_axiom]] — Univalence 的精确定义
- [[Axioms/univalence]] — 概念笔记
- [[Identity_and_Paths/identity_type]] — 恒等类型基础

### 外部参考

- **原始论文**：
  - Cohen, Coquand, Huber, Mörtberg — *Cubical Type Theory: A Constructive Interpretation of the Univalence Axiom* (2015)
  - Angiuli, Brunerie, Coquand, Harper, Hou, Licata — *Syntax and Models of Cartesian Cubical Type Theory*
- **教程**：
  - Cubical Agda 文档：https://agda.readthedocs.io/en/latest/language/cubical.html
  - 1lab：https://1lab.dev/ （Cubical Agda 编写的 HoTT library）
- **Voevodsky 原始 HoTT**：
  - Voevodsky — *Univalent Foundations* 讲座系列（IAS 2012–2014）
  - HoTT Book (The Univalent Foundations Program, 2013)
