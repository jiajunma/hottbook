---
type: definition
title: 判断 / Judgment
chapter: 1
section: 1
tags: [type-theory, foundational]
references:
  - "[[00_MOC]]"
  - "[[function_type]]"
  - "[[teaching/symbol_guide]]"
---

# 判断 / Judgment

## 什么是判断？/ What Is a Judgment?

**判断 (judgment)** 是类型论中最基本的陈述形式 -- 它是推导系统中我们可以"到达"的位置。
A **judgment** is the most basic form of statement in type theory -- a "position" we can reach in a deductive system.

> Informally, a deductive system is a collection of *rules* for deriving things called *judgments*. If we think of a deductive system as a formal game, then the judgments are the "positions" in the game which we reach by following the game rules.

如果你玩过棋类游戏：规则 (rules) 规定棋子怎么走，判断 (judgments) 就是棋盘上合法的局面。
If you have played board games: the rules say how pieces move, and judgments are the legal board states.

## 两种基本判断 / Two Basic Judgments

类型论建立在两种判断之上 / Type theory is built on two forms of judgment:

| 判断 / Judgment | 读法 / Pronunciation | 类比 / Analogy |
|---|---|---|
| $a : A$ | "$a$ 是类型 $A$ 的项 / $a$ has type $A$" | Python 中的 `x: int = 42` |
| $a \equiv b : A$ | "$a$ 和 $b$ 定义相等 / $a$ and $b$ are definitionally equal" | 编译期常量折叠 / compile-time constant folding |

> The basic judgment of type theory, analogous to "$A$ has a proof", is written "$a:A$" and pronounced as "the term $a$ has type $A$", or more loosely "$a$ is an element of $A$" (or, in homotopy type theory, "$a$ is a point of $A$"). When $A$ is a type representing a proposition, then $a$ may be called a *witness* to the provability of $A$, or *evidence* of the truth of $A$.

## Lean 4

```lean
-- 类型判断
#check 42            -- 42 : Nat
#check "hello"       -- "hello" : String

-- 定义与定义相等
def sq (x : Nat) : Nat := x * x
example : sq 3 = 9 := rfl    -- 定义相等：rfl 就够了
-- example : ∀ n, n + 0 = n := rfl  -- ✗ 命题相等需要证明
```

## 编程视角 / Programming Perspective

### 类型判断 $a : A$ 就像类型声明 / Typing judgment is like type declaration

```c
// C 中的类型声明 -- 类似于判断 a : A
int x = 42;            // "42 : int"   是一个类型判断
char *name = "hello";  // "hello" : char*  是一个类型判断

// 类型论比 C 更严格！
// C 中你可以用 void* 丢掉类型信息：
void *p = &x;          // p 的"真实类型"被抹掉了
// 类型论中不可能这样——每个值的类型是确定的、不可丢弃的

// 另一个区别：C 中可以先声明后赋值
int y;        // y 的类型是 int，但没有值（未初始化）
// 类型论中 a : A 表示 a 是 A 的一个具体元素——不存在"没有值的类型判断"
```

> A good way to think about this is that in set theory, "membership" is a relation which may or may not hold between two pre-existing objects "$a$" and "$A$", while in type theory we cannot talk about an element "$a$" in isolation: every element *by its very nature* is an element of some type, and that type is (generally speaking) uniquely determined.

关键区别：C 中可以用 `void *` 丢掉类型信息；在类型论中，值**天生**属于某个类型，不能脱离类型存在。
Key difference: in C you can cast away type info with `void *`; in type theory a value **inherently** belongs to a type.

### 定义相等 $\equiv$ 就像编译期展开 / Definitional equality is compile-time unfolding

> This is called *judgmental equality* or *definitional equality*, and we write it as $a \equiv b : A$ or simply $a \equiv b$. It is helpful to think of this as meaning "equal by definition".

```c
// C 的宏展开就是定义相等的类比
#define SQ(x) ((x) * (x))

// 定义相等：SQ(3) ≡ ((3) * (3)) ≡ 9
// 预处理器展开定义，编译器折叠常量——不需要"运行"来验证

// 命题相等：需要运行时检查
int a = some_function();
assert(a == 9);   // 这是一个声明："a 等于 9"，需要证据
```

两种"相等"的对比 / Two kinds of equality compared:

| | 定义相等 $\equiv$ / Definitional | 命题相等 $=$ / Propositional |
|---|---|---|
| 层面 / Level | 元理论 / metatheory | 理论内部 / internal |
| 类比 / Analogy | 编译期常量折叠 / compile-time folding | 运行时 `assertEqual` |
| 需要证明？/ Needs proof? | 不需要，展开定义即可 / No, just unfold | 需要构造证据 / Yes, must provide evidence |
| 可否定？/ Negatable? | 不可以 / No | 可以 / Yes |

## 判断不是命题 / Judgments Are Not Propositions

这是初学者最容易混淆的一点。
This is the most confusing point for beginners.

> In particular, when working internally in type theory, we cannot make statements such as "if $a:A$ then it is not the case that $b:B$", nor can we "disprove" the judgment "$a:A$".

判断存在于**元理论 (metatheory)** 层面 -- 就像编程语言的类型系统在编译期运行，不是你的程序能操作的东西。
Judgments live at the **metatheory** level -- like a compiler's type system that runs at compile time, not something your program can manipulate.

```python
# 你不能在运行时写: "如果 x 的类型是 int，那么 y 的类型不是 str"
# 类型判断不是 if/else 能操纵的布尔值
# 同样，类型论中的判断不是命题，不能被"否定"或"假设"

# 正确类比:
# - 判断 a : A  ←→  TypeScript 编译器说 "x has type number" (元信息)
# - 命题 P      ←→  程序里一个 bool 值 (可以取反、组合)
```

## 上下文 / Context

判断可以依赖于**假设 (assumptions)**，写作 / Judgments can depend on **assumptions**, written as:

$$x_1 : A_1,\; x_2 : A_2,\; \ldots,\; x_n : A_n \;\vdash\; b : B$$

这读作："在假设 $x_1 : A_1, \ldots, x_n : A_n$ 的上下文中，$b$ 具有类型 $B$"。
Read as: "In the context where $x_1 : A_1, \ldots, x_n : A_n$, the term $b$ has type $B$."

编程类比：上下文就是函数签名的参数列表 / Programming analogy: the context is a function's parameter list.

```python
# 上下文 x: int, y: str  ⊢  f(x, y) : bool
# 类比于:
def f(x: int, y: str) -> bool:
    return len(y) > x
# 参数列表 (x: int, y: str) 就是"上下文"
# 返回类型 bool 就是在该上下文中的判断
```

## 与集合论的关键区别 / Key Differences from Set Theory

| 集合论 / Set Theory | 类型论 / Type Theory |
|---|---|
| $a \in A$ 是一个命题（可真可假）| $a : A$ 是一个判断（不可否定）|
| 元素可以独立存在，再问"属不属于 $A$" | 元素必须与类型同时给出 |
| $\neg(a \in A)$ 有意义 | "$a$ 不属于 $A$" 无意义 |
| 等号 $=$ 只有一种 | 区分定义相等 $\equiv$ 和命题相等 $=$ |

## 小结 / Summary

- **判断**是类型论的基本构件，存在于元理论层面 / **Judgments** are the building blocks of type theory, living at the metatheory level
- $a : A$ -- 类型判断，类似类型标注 / typing judgment, like type annotations
- $a \equiv b$ -- 定义相等，类似编译期展开 / definitional equality, like compile-time unfolding
- 判断**不是**命题，不能否定或假设 / Judgments are **not** propositions; they cannot be negated or assumed
- 上下文 = 假设列表 = 函数参数列表 / Context = list of assumptions = function parameter list

符号速查请参见 [[teaching/symbol_guide]] / See [[teaching/symbol_guide]] for a symbol quick-reference.

## 参考文献 / References

- HoTT Book, Section 1.1: Type theory versus set theory
