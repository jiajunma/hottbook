---
type: definition
title: 函数类型 / Function Type
chapter: 1
section: 2
tags: [type-theory, type-former]
references:
  - "[[00_MOC]]"
  - "[[judgment]]"
  - "[[pi_type]]"
  - "[[teaching/symbol_guide]]"
---

# 函数类型 / Function Type

## 核心思想 / Core Idea

给定类型 $A$ 和 $B$，可以构造**函数类型** $A \to B$，表示从 $A$ 到 $B$ 的函数。
Given types $A$ and $B$, we can form the **function type** $A \to B$ of functions from $A$ to $B$.

> Given types $A$ and $B$, we can construct the type $A \to B$ of *functions* with domain $A$ and codomain $B$. Unlike in set theory, functions are not defined as functional relations; rather they are a primitive concept in type theory.

与集合论不同，类型论中的函数不是"满足某种条件的有序对集合"，而是**原始概念** -- 就像编程语言中函数是内建的，不需要用更基础的东西来定义。
Unlike set theory, functions in type theory are **primitive** -- like how functions are built-in in programming languages, not defined from something more basic.

## Lean 4

```lean
-- λ-抽象 = fun
def double : Nat → Nat := fun x => x + x
#eval double 21   -- 42

-- β-规约
#eval (fun x => x + x) 3   -- 6

-- 柯里化（天然的）
def add (x y : Nat) : Nat := x + y
#check add 3     -- Nat → Nat（部分应用）

-- η-展开
-- f 和 fun x => f x 是同一个函数
```

## 编程视角 / Programming Perspective

函数类型在编程中无处不在 / Function types are everywhere in programming:

```python
# Python 中的函数类型
from typing import Callable

# double : int → int
double: Callable[[int], int] = lambda x: x + x

# greet : str → str
greet: Callable[[str], str] = lambda name: f"Hello, {name}!"
```

```typescript
// TypeScript 中的函数类型更自然
const double: (x: number) => number = (x) => x + x;
// double : number → number

const greet: (name: string) => string = (name) => `Hello, ${name}!`;
// greet : string → string
```

## 五条规则 / Five Rules for Function Types

类型论通过五条规则完整地刻画函数类型。每条规则都有编程中的对应物。
Type theory characterizes function types through five rules. Each has a programming counterpart.

### 1. 构造规则 (Formation) -- "什么时候可以写 $A \to B$？"

如果 $A : \mathcal{U}$ 且 $B : \mathcal{U}$，那么 $A \to B : \mathcal{U}$。
If $A : \mathcal{U}$ and $B : \mathcal{U}$, then $A \to B : \mathcal{U}$.

```typescript
// 只要 number 和 string 是类型，number → string 就是类型
type F = (x: number) => string;  // ✓ 合法的类型
```

### 2. 引入规则 (Introduction) -- $\lambda$ 抽象 = 匿名函数

如果在假设 $x : A$ 的情况下有 $b : B$，那么 $\lambda x.\, b : A \to B$。
If assuming $x : A$ we have $b : B$, then $\lambda x.\, b : A \to B$.

**$\lambda$ 抽象就是匿名函数** / Lambda abstraction IS the anonymous function:

```python
# λx. x + x  就是  lambda x: x + x
double = lambda x: x + x          # double : int → int

# λx. x * x  就是  lambda x: x * x
square = lambda x: x * x          # square : int → int

# 也可以用 def，效果等价
def square_v2(x: int) -> int:     # 同样构造了 int → int 的一个项
    return x * x
```

```typescript
// TypeScript 的箭头函数更接近 λ 记法
const double = (x: number): number => x + x;    // λx. x+x
const square = (x: number): number => x * x;    // λx. x*x
```

### 3. 消除规则 (Elimination) -- 函数应用 = 调用函数

给定 $f : A \to B$ 和 $a : A$，得到 $f(a) : B$。
Given $f : A \to B$ and $a : A$, we get $f(a) : B$.

```python
square(3)   # 传入 3 : int，得到 9 : int
greet("Alice")  # 传入 "Alice" : str，得到 "Hello, Alice!" : str
```

这就是**函数调用**，编程中最常见的操作。
This is just **function application** -- the most common operation in programming.

### 4. 计算规则 (Computation) -- $\beta$-规约 = 代入参数

$$(\lambda x.\, \Phi)(a) \equiv \Phi[a/x]$$

把参数 $a$ 代入函数体 $\Phi$ 中所有的 $x$，结果是**定义相等**的。
Substitute $a$ for every $x$ in the body $\Phi$. The result is **definitionally equal**.

```python
# (λx. x + x)(3)  ≡  3 + 3  ≡  6
(lambda x: x + x)(3)   # Python 直接求值得到 6

# (λx. x * x)(5)  ≡  5 * 5  ≡  25
(lambda x: x * x)(5)   # Python 直接求值得到 25

# 关键：这是"定义相等" ≡，不只是"碰巧相等" =
# 编译器/类型检查器可以不执行代码就知道它们相同
```

### 5. 唯一性原则 (Uniqueness) -- $\eta$-展开

$$f \equiv \lambda x.\, f(x)$$

一个函数**完全由它在所有输入上的行为决定**。
A function is **completely determined by its behavior on all inputs**.

```python
f = lambda x: x * 2
g = lambda x: f(x)     # g ≡ f，因为对所有 x，g(x) = f(x)

# η-展开的直觉：函数 = 黑盒
# 如果两个黑盒对所有输入都给出相同输出，它们就是"同一个"函数
# 你不能打开盒子看"实现"，只能看行为
```

```typescript
const f = (x: number) => x * 2;
const g = (x: number) => f(x);  // g ≡ f by η-expansion
// TypeScript 中 f 和 g 行为完全相同
```

## 柯里化 / Currying

> The idea of currying is to represent a function of two inputs $a:A$ and $b:B$ as a function which takes *one* input $a:A$ and returns *another function*, which then takes a second input $b:B$ and returns the result.

多参数函数在类型论中通过**柯里化 (currying)** 实现：$f : A \to B \to C$ 表示"接受一个 $A$，返回一个 $B \to C$ 的函数"。
Multi-argument functions use **currying**: $f : A \to B \to C$ means "take an $A$, return a function $B \to C$."

```python
from typing import Callable

# 柯里化版本: add : int → (int → int)
def add(x: int) -> Callable[[int], int]:
    return lambda y: x + y

add(3)(4)   # = 7
# add(3) 返回一个函数 λy. 3 + y
# 然后 (λy. 3 + y)(4) ≡ 3 + 4 ≡ 7
```

```typescript
// TypeScript/Haskell 风格的柯里化非常自然
const add = (x: number) => (y: number) => x + y;
// add : number → number → number
// add(3)     : number → number     (部分应用)
// add(3)(4)  = 7                   (完全应用)

// 变量捕获示例 (variable capture)
const f = (x: number) => (y: number) => x + y;
// f(y) 中的内部 y 和外部 y 是不同的变量！
// f(y) ≡ (z) => y + z   (重命名避免混淆)
```

柯里化在 Haskell 中是默认的：`add :: Int -> Int -> Int` 等价于 `add :: Int -> (Int -> Int)`。
In Haskell, currying is the default: `add :: Int -> Int -> Int` is the same as `add :: Int -> (Int -> Int)`.

## 函数外延性 / Function Extensionality (预告 / Preview)

两个函数 $f, g : A \to B$ 什么时候"相等"？当它们对所有输入给出相等的输出时：
When are two functions $f, g : A \to B$ "equal"? When they agree on all inputs:

$$\prod_{(x:A)} (f(x) = g(x)) \;\to\; (f = g)$$

这就是**函数外延性公理** -- 直觉上显然（两个黑盒行为一样就是同一个），但在类型论中需要额外声明。
This is the **function extensionality axiom** -- intuitively obvious, but requires explicit statement in type theory.

详见 [[propositions_as_types]] 和 [[pi_type]] / See [[propositions_as_types]] and [[pi_type]] for more.

## 小结：规则速查 / Summary: Rules at a Glance

| 规则 / Rule | 形式化 / Formal | 编程类比 / Programming Analogy |
|---|---|---|
| Formation | $A, B : \mathcal{U} \;\Rightarrow\; A \to B : \mathcal{U}$ | `type F = (x: A) => B` |
| Introduction ($\lambda$) | $\lambda x.\, b : A \to B$ | `(x) => b` 箭头函数 |
| Elimination (app) | $f(a) : B$ | `f(a)` 函数调用 |
| Computation ($\beta$) | $(\lambda x.\, b)(a) \equiv b[a/x]$ | 代入参数求值 / substitute and evaluate |
| Uniqueness ($\eta$) | $f \equiv \lambda x.\, f(x)$ | 函数由行为决定 / function = its behavior |

符号速查请参见 [[teaching/symbol_guide]] / See [[teaching/symbol_guide]] for a symbol quick-reference.

## 参考文献 / References

- HoTT Book, Section 1.2: Function types
