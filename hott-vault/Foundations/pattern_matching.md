---
type: definition
title: 模式匹配 / Pattern Matching and Recursion
chapter: 1
section: 10
tags: [type-theory, pattern-matching, recursion, induction]
references:
  - "[[00_MOC]]"
  - "[[nat]]"
  - "[[coproduct_type]]"
  - "[[teaching/symbol_guide]]"
---

# 模式匹配 / Pattern Matching and Recursion

## 核心观点 / Core Idea

**模式匹配 (pattern matching)** 不是类型论的原语——它是递归子和归纳原理的**语法糖 (syntactic sugar)**。
Pattern matching is NOT a primitive of type theory — it is **syntactic sugar** for recursors and induction principles.

这就像编程语言中 `for` 循环是 `while` 循环的语法糖——方便但不增加表达力。
Like how `for` loops are syntactic sugar for `while` loops in programming — convenient but not more expressive.

## Lean 4

```lean
-- 模式匹配定义（人类友好）
def myDouble : Nat → Nat
  | 0     => 0
  | n + 1 => (myDouble n) + 2

-- 等价的递归子版本（机器友好）
def myDouble' : Nat → Nat :=
  Nat.rec 0 (fun _n prev => prev + 2)

-- Lean 强制穷尽 + 结构递减
-- def bad (n : Nat) : Nat := bad n          -- ✗ 不终止
-- def bad2 : Nat → Nat | 0 => 0            -- ✗ 缺少 succ case
```

## 编程视角 / Programming Perspective

### 你已经在用模式匹配了 / You Already Use Pattern Matching

```python
# Python 3.10+ 的 match 语句
def factorial(n: int) -> int:
    match n:
        case 0: return 1                        # 基础情况
        case _: return n * factorial(n - 1)      # 递归情况

# 这在类型论中翻译为递归子 rec_ℕ 的应用
```

```typescript
// TypeScript: 对联合类型的穷尽 (exhaustive) 匹配
type Shape = 
  | { tag: "circle"; r: number }
  | { tag: "rect";   w: number; h: number };

function area(s: Shape): number {
    switch (s.tag) {
        case "circle": return Math.PI * s.r * s.r;
        case "rect":   return s.w * s.h;
    }
    // TypeScript: 如果漏掉一个 case，编译报错！
    // 这正是归纳原理保证的：必须处理所有构造子
}
```

### 模式匹配 = 对构造子的分支 / Pattern Matching = Branching on Constructors

每种归纳类型的模式匹配都遵循相同模式 / Every inductive type has the same pattern:

| 类型 / Type | 构造子 / Constructors | 模式匹配 / Match |
|---|---|---|
| $\mathbb{N}$ | $0$, $\mathsf{succ}(n)$ | `case 0: ... case succ(n): ...` |
| $\mathbf{2}$ (Bool) | $0_\mathbf{2}$, $1_\mathbf{2}$ | `if b then ... else ...` |
| $A + B$ | $\mathsf{inl}(a)$, $\mathsf{inr}(b)$ | `case Left(a): ... case Right(b): ...` |
| $A \times B$ | $(a, b)$ | `let (x, y) = p` 解构 |
| $\mathbf{1}$ (Unit) | $\star$ | 只有一个 case（平凡匹配） |

## 示例：从模式匹配到递归子 / Example: Pattern Matching → Recursor

以下模式匹配定义 / This pattern-matching definition:

$$\mathsf{double}(0) :\equiv 0$$
$$\mathsf{double}(\mathsf{succ}(n)) :\equiv \mathsf{succ}(\mathsf{succ}(\mathsf{double}(n)))$$

等价于递归子应用 / is equivalent to the recursor application:

$$\mathsf{double} :\equiv \mathsf{rec}_{\mathbb{N}}(\mathbb{N},\; 0,\; \lambda n.\, \lambda y.\, \mathsf{succ}(\mathsf{succ}(y)))$$

```python
# 模式匹配版本（人类友好）
def double_match(n):
    match n:
        case 0:       return 0
        case Succ(m): return Succ(Succ(double_match(m)))

# 递归子版本（机器友好）
double_rec = lambda n: rec_nat(
    Zero(),                                # c₀: double(0) = 0
    lambda m, prev: Succ(Succ(prev)),      # cₛ: double(succ(n)) = succ(succ(prev))
    n
)
# 两者完全等价！
```

## 合法 vs 非法递归 / Valid vs Invalid Recursion

### 合法：结构递减 / Valid: Structurally Decreasing

递归调用必须作用于**结构更小的**参数（构造子的子项）：
Recursive calls must be on **structurally smaller** arguments:

```python
# ✓ 合法：递归在 n-1 上（succ 的子项）
def fib(n):
    match n:
        case 0: return 0
        case 1: return 1
        case _: return fib(n-1) + fib(n-2)  # n-1, n-2 都比 n 结构更小
```

### 非法：无终止保证 / Invalid: No Termination Guarantee

```python
# ✗ 非法：无限循环
def bad(n):
    return bad(n)           # 参数没变小！

def also_bad(n):
    return also_bad(n + 1)  # 参数变大了！

def tricky(n):
    if n <= 1: return n
    return tricky(n // 2 + 1)  # 不是"结构递减"，即使可能终止
```

> **关键洞察 / Key Insight**: 类型论**只接受结构递减的递归**——这从根本上保证所有程序终止。Haskell/Rust 对非穷尽模式匹配发出警告，正是在检查你是否遵守了归纳原理的要求。
> Type theory **only accepts structurally decreasing recursion** — guaranteeing termination. Haskell/Rust warnings about non-exhaustive patterns check exactly this.

## 归纳原理是首要的 / Induction Principles Are Primary

在 HoTT 中的优先级 / Priority in HoTT:

1. **归纳原理 (induction principles)** 是类型的基本消除规则
2. **模式匹配 (pattern matching)** 是推导出的简写
3. 对于简单归纳类型（$\mathbb{N}$, $\mathbf{2}$, $A + B$），两者完全等价
4. 对于**高阶归纳类型 (HITs)**（后面章节），归纳原理是唯一可靠的表述——模式匹配可能遗漏路径构造子

## 多参数匹配 / Multi-argument Matching

可以同时对多个参数匹配 / You can match on multiple arguments:

$$\mathsf{add}(0, n) :\equiv n$$
$$\mathsf{add}(\mathsf{succ}(m), n) :\equiv \mathsf{succ}(\mathsf{add}(m, n))$$

翻译为对第一个参数的递归，第二个参数作为固定参数。

```typescript
function add(m: Nat, n: Nat): Nat {
    switch (m.tag) {
        case "zero": return n;
        case "succ": return succ(add(m.pred, n));
    }
}
```

## 相关概念 / Related Concepts

- [[nat]] — 模式匹配的典型对象
- [[coproduct_type]] — case 分析是模式匹配的特殊情况
- [[product_type]] — 解构是模式匹配的特殊情况
- [[Higher_Inductive_Types/00_MOC]] — 需要更谨慎地使用归纳原理

## 参考文献 / References

- HoTT Book, Section 1.10: Pattern matching and recursion
