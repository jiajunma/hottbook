---
type: definition
title: 连通性 / Connectedness
chapter: 7
section: 5
tags: [connectedness, n-connected, surjection, truncation]
references:
  - "[[01_n_types]]"
  - "[[03_truncations]]"
---

# 连通性 / Connectedness

## 定义 / Definitions

**$n$-连通函数.** $f : A \to B$ 是 $n$-连通的，若对所有 $b : B$，$\|\mathsf{fib}_f(b)\|_n$ 可缩：

$$\mathsf{conn}_n(f) \equiv \prod_{b:B} \mathsf{isContr}(\|\mathsf{fib}_f(b)\|_n)$$

**$n$-连通类型.** $A$ 是 $n$-连通的，若 $\|A\|_n$ 可缩。

## 与满射的关系 / Relation to Surjectivity

**引理 7.5.2.** $f$ 是 $(-1)$-连通的当且仅当 $f$ 是满射。

- 0-连通类型 = **连通** (connected)
- 1-连通类型 = **单连通** (simply connected)

## 等价刻画 / Equivalent Characterization

**引理 7.5.7.** 对 $f : A \to B$ 和 $n \ge -2$，以下等价：
1. $f$ 是 $n$-连通的
2. 对每个 $P : B \to n\text{-}\mathsf{Type}$，预合成 $\lambda s.\, s \circ f$ 是等价
3. 对每个 $P : B \to n\text{-}\mathsf{Type}$，预合成有截面

**推论.** $|{-}|_n : A \to \|A\|_n$ 是 $n$-连通的。

**推论.** $A$ 是 $n$-连通的当且仅当 $B \to (A \to B)$（常值函数映射）对每个 $n$-类型 $B$ 是等价。

## $n$-连通映射诱导截断等价 / Connected Maps Induce Truncation Equivalence

**引理 7.5.13.** 若 $f : A \to B$ 是 $n$-连通的，则 $\|A\|_n \simeq \|B\|_n$。

## 参考文献 / References

- HoTT Book, Section 7.5
