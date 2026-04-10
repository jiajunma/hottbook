---
type: teaching
title: 符号渲染指南 / Symbol Rendering Guide
tags: [teaching, symbols, obsidian, latex]
---

# 符号渲染指南 / Symbol Rendering Guide for Obsidian

## 问题 / The Problem

HoTT 书使用了大量自定义 LaTeX 宏（定义在 `macros.tex` 中），但 Obsidian 使用 MathJax 渲染数学公式，不认识这些自定义命令。

The HoTT book defines custom LaTeX macros in `macros.tex`. Obsidian's MathJax doesn't know these commands.

## 符号对照表 / Symbol Mapping

### 等式与定义 / Equality and Definition

| 书中写法 (Book) | Obsidian 写法 | 含义 / Meaning | 示例 |
|---|---|---|---|
| `\jdeq` | `\equiv` | 判断等式 / judgmental equality | $a \equiv b$ |
| `\defeq` | `:\equiv` | 定义 / definition | $f(x) :\equiv x^2$ |

### 路径与恒等类型 / Paths and Identity Types

| 书中写法 (Book) | Obsidian 写法 | 含义 / Meaning | 示例 |
|---|---|---|---|
| `\refl{a}` | `\mathsf{refl}_a` | 自反性 / reflexivity | $\mathsf{refl}_a : a =_A a$ |
| `p \ct q` | `p \cdot q` | 路径拼接 / path concatenation | $p \cdot q : a =_A c$ |
| `\opp{p}` | `p^{-1}` | 路径逆 / path inverse | $p^{-1} : b =_A a$ |
| `\trans{p}{u}` | `\mathsf{transport}^p(u)` | 沿路径传输 / transport | $\mathsf{transport}^p(u) : B(b)$ |
| `\map{f}{p}` 或 `\ap f p` | `\mathsf{ap}_f(p)` | 函数作用于路径 / ap | $\mathsf{ap}_f(p) : f(a) = f(b)$ |
| `\mapdep{f}{p}` | `\mathsf{apd}_f(p)` | 依赖函数作用于路径 / apd | — |

### 类型构造子 / Type Formers

| 书中写法 (Book) | Obsidian 写法 | 含义 / Meaning | 示例 |
|---|---|---|---|
| `\prd{x:A} B(x)` | `\prod_{(x:A)} B(x)` | 依赖函数类型 / Π-type | $\prod_{(x:A)} B(x)$ |
| `\sm{x:A} B(x)` | `\sum_{(x:A)} B(x)` | 依赖对类型 / Σ-type | $\sum_{(x:A)} B(x)$ |
| `\eqv{A}{B}` | `A \simeq B` | 等价 / equivalence | $A \simeq B$ |

### 宇宙与特殊类型 / Universes and Special Types

| 书中写法 (Book) | Obsidian 写法 | 含义 / Meaning |
|---|---|---|
| `\UU` | `\mathcal{U}` | 宇宙 / universe |
| `\type` | `\mathcal{U}` | 同上（非正式写法） |
| `\set` | `\mathsf{Set}` | 集合宇宙 / universe of sets |
| `\prop` | `\mathsf{Prop}` | 命题宇宙 / universe of propositions |
| `\unit` | `\mathbf{1}` | 单位类型 / unit type |
| `\emptyt` | `\mathbf{0}` | 空类型 / empty type |
| `\bool` | `\mathbf{2}` | 布尔类型 / Bool |
| `\nat` | `\mathbb{N}` | 自然数 / natural numbers |

### 命名函数 / Named Functions

| 书中写法 (Book) | Obsidian 写法 | 含义 |
|---|---|---|
| `\idfunc` | `\mathsf{id}` | 恒等函数 |
| `\ttt` | `\star` 或 `\mathsf{tt}` | unit 的唯一元素 |
| `\fst`, `\snd` | `\mathsf{pr}_1`, `\mathsf{pr}_2` | 投影 |
| `\inl`, `\inr` | `\mathsf{inl}`, `\mathsf{inr}` | 余积注入 |
| `\ind{A}` | `\mathsf{ind}_A` | 归纳原理 / induction principle |
| `\rec{A}` | `\mathsf{rec}_A` | 递归子 / recursor |

## 编程符号对照 / Programming Notation

为了帮助有编程背景的读者，我们有时也使用以下记法：

| 数学记法 | 编程类比 | 说明 |
|---|---|---|
| $\lambda x.\, e$ | `(x) => e` 或 `lambda x: e` | λ-抽象 = 匿名函数 |
| $f(a)$ | `f(a)` | 函数应用 |
| $(a, b) : A \times B$ | `(a, b): [A, B]` 或 `Tuple[A, B]` | 有序对 |
| $\mathsf{pr}_1(p)$ | `p[0]` 或 `p.first` | 第一投影 |
| $\mathsf{inl}(a)$ | `Left(a)` 或 `{ tag: 'left', value: a }` | 左注入 |
| $\mathsf{rec}_\mathbb{N}(c_0, c_s, n)$ | `fold` / `reduce` on natural numbers | 自然数递归 |

## 在 Obsidian 中使用 / Usage in Obsidian

行内公式用 `$...$`：
```markdown
判断 $a : A$ 表示 $a$ 是类型 $A$ 的一个元素。
```

显示公式用 `$$...$$`：
```markdown
$$\prod_{(x:A)} B(x)$$
```

所有公式都应使用本文件中的 Obsidian 兼容写法，而非 HoTT 书的自定义宏。
