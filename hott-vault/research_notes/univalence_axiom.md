---
type: research-note
title: "Univalence 公理的精确定义"
tags: [research-notes, univalence, axiom, identity-type]
references:
  - "[[Axioms/univalence]]"
  - "[[Identity_and_Paths/identity_type]]"
  - "[[Equivalences/00_MOC]]"
---

# Univalence 公理的精确定义

## 一句话

> **Univalence**：给定两个类型 $A$ 和 $B$，说它们"相等"（$A = B$）和说它们"等价"（$A \simeq B$）是**等价**的。
>
> 形式上：公理断言典范映射 $\mathsf{idtoeqv} : (A = B) \to (A \simeq B)$ 本身是一个等价。

---

## 精确定义

**公理 (Univalence, HoTT Book §2.10)**：对任意 $A, B : \mathcal{U}$，典范映射

$$\mathsf{idtoeqv} : (A =_\mathcal{U} B) \to (A \simeq B)$$

**是一个等价** (is itself an equivalence)。

这个陈述有两部分：典范映射的构造（不需要公理）+ 它是等价（公理）。

---

## 第一部分：典范映射 $\mathsf{idtoeqv}$

给定 $p : A = B$，定义 $\mathsf{idtoeqv}(p) : A \simeq B$ 如下：

$$\mathsf{idtoeqv}(p) :\equiv \mathsf{transport}^{X \mapsto X}\, p$$

即：**沿路径 $p$ 传输**（用恒等类型族 $X \mapsto X : \mathcal{U} \to \mathcal{U}$）。这给出一个函数 $A \to B$。

**为什么这是等价？** 用路径归纳 (J)：要证明对所有 $p : A = B$ 这个传输是等价，只需处理 $p \equiv \mathsf{rfl}$ 的情况。此时 $A \equiv B$，传输就是恒等函数 $\mathsf{id}_A$，它显然是等价。

这部分**完全不需要 univalence 公理**——纯类型论规则就能构造。

**直觉**：如果 $A$ 和 $B$ 相等，它们就是等价的——因为相等意味着可以互换。

```lean
def idtoeqv {A B : Type u} (p : A = B) : A → B :=
  fun a => p ▸ a
```

---

## 第二部分：$\mathsf{idtoeqv}$ 本身是等价（这才是公理）

$$\mathsf{ua} : \mathsf{isEquiv}(\mathsf{idtoeqv})$$

等价地：

$$(A =_\mathcal{U} B) \;\simeq\; (A \simeq B)$$

由于 $\mathsf{idtoeqv}$ 是等价，它有一个逆：

$$\mathsf{ua} : (A \simeq B) \to (A =_\mathcal{U} B)$$

给定等价 $e : A \simeq B$，$\mathsf{ua}(e)$ 是一条 $A$ 到 $B$ 的路径。

### 计算规则

Univalence 包含一条 propositional 计算规则：

$$\mathsf{idtoeqv}(\mathsf{ua}(e)) = e$$

即：先从等价造路径，再从路径回到等价，应该得到原来那个等价。

**重要**：在**标准 HoTT** 中这只是**命题等式** (propositional equality)，不是判断等式 (definitional equality)。这意味着 $\mathsf{ua}$ 不会自动计算——它是一个"黑盒"。使用 `transport^(ua e)` 的证明无法直接化简。Cubical type theory 解决了这个问题——见 [[cubical_vs_hott]]。

---

## 为什么这是公理

在朴素类型论（没有 univalence）中：

- $A = B \Rightarrow A \simeq B$ 可以证明（即 $\mathsf{idtoeqv}$ 存在）
- 但**无法证明**反向——给定一个等价构造相等路径是不可能的

**直观**：朴素类型论只允许类型在**定义相等** ($\equiv$) 意义下互相替换。两个非平凡等价的类型（例如 $\mathsf{Bool}$ 和 $\mathbf{1} + \mathbf{1}$）在定义相等意义下不相等，所以它们的恒等类型 $A =_\mathcal{U} B$ 在朴素类型论中是"空的"（没有明显的居民）。

Univalence 作为公理**假设**这个恒等类型有丰富居民——每个等价都反射回一条相等路径。

---

## 为什么叫 "univalence"

"Univalent"（单值）的意思是：**相等类型单值地描述了等价**——没有"多种意义"下的相等，相等就等同于等价。

**历史来源**：Voevodsky 在 2006 年前后提出。名字来自模型论中的 "univalent fibration"——对象分类 fibration。Voevodsky 发现这个几何概念可以翻译到类型论。

---

## 直接推论

### 类型相等的真正含义

Univalence 让"类型相等"有了具体的计算内容：

```
事实：Bool ≃ Bool 有两个元素（id 和 not）
    ↓（通过 ua）
结论：Bool = Bool 有两条不同的路径
```

这就是为什么**宇宙不是 set**（参见 [[book/ch03_sets_and_logic#3.1|HoTT Book §3.1]]）：univalence 赋予宇宙非平凡的路径结构。

### 函数外延性

**Theorem 4.9.4 (HoTT Book)**：Univalence 蕴含 funext。

所以接受 univalence 就免费获得函数外延性——两个函数对所有输入相等 ⟹ 它们相等。

### Structure Identity Principle

在 univalence 下，**isomorphic structures are literally equal**：

- 两个同构的群 $(G_1, \cdot_1)$ 和 $(G_2, \cdot_2)$ 给出一条**群相等路径**
- 所有"up to isomorphism"的经典数学 mantras 在 HoTT 中变成字面相等
- 证明一个性质对 $G_1$ 成立，可以通过 transport 得到它对 $G_2$ 也成立

这在 HoTT Book Chapter 9 (Category Theory) 中得到系统发展，关键词是 "Rezk completion" 和 "univalent category"。

---

## 与 propositions-as-types 的冲突

Univalence 和朴素 propositions-as-types 不兼容（参见 [[book/ch03_sets_and_logic#3.2|HoTT Book §3.2]]）：

- $\mathsf{LEM}_\infty :\equiv \prod_{(A:\mathcal{U})} (A + \neg A)$ **与 univalence 不一致**
- $\mathsf{DNE}_\infty :\equiv \prod_{(A:\mathcal{U})} (\neg\neg A \to A)$ **与 univalence 不一致**

**原因**：univalence 强制所有 polymorphic 操作对等价是自然的。对于 $\mathsf{Bool}$，swap 等价 $\mathsf{not}$ 给出路径 $\mathsf{Bool} = \mathsf{Bool}$，任何 $f : \neg\neg\mathsf{Bool} \to \mathsf{Bool}$ 的输出必须是 $\mathsf{not}$ 的不动点——但 $\mathsf{not}$ 无不动点，矛盾。

详细证明见 [[teaching/ch03_lesson_plan#2.1 The problem with naive propositions-as-types (15 min)|Ch3 §2.1]]。

**解决方案**：将 LEM 限制到 mere propositions，在那个层面 univalence 和经典逻辑可以共存。

---

## Lean 中的情况

Lean 4 的 kernel **不**直接支持 univalence。原因：

- Lean 使用 **proof irrelevance**（`Prop` 中证明都相等）
- 使用 **definitional quotient types**
- 这些与 univalence 的正确形式化有干扰

但 Lean 有可用的等价和近似：

```lean
-- Equiv 类型：显式地编码 α ≃ β
#check Equiv       -- 来自 Mathlib

-- 对 Prop 而言，命题外延性给出 "univalence for Prop"：
example (p q : Prop) (h : p ↔ q) : p = q := propext h

-- 这是 univalence 在 Prop 宇宙的投影版本：
-- 对 mere propositions，"等价"坍缩为 "逻辑等价 (iff)"
-- 而 propext 就是说 iff 给出相等
```

**真正的 HoTT 形式化**一般使用：
- **Agda + HoTT library**（Agda 支持 `--without-K`）
- **Coq + HoTT library**
- **Cubical Agda**（univalence 是定理，不是公理）

---

## 相关参考

- [[Axioms/univalence]] — 概念笔记
- [[Identity_and_Paths/identity_type]] — 恒等类型
- [[Equivalences/00_MOC]] — 等价的各种定义
- [[book/ch02_homotopy_type_theory]] — §2.10 原始陈述
- [[cubical_vs_hott]] — Cubical TT 如何把 univalence 变成定理
- [[teaching/ch02_lesson_plan]] — 教案中的 univalence 部分
- [[teaching/ch03_lesson_plan]] — Ch3 §2.1 univalence 与 propositions-as-types 的冲突
