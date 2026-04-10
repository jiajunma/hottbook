---
type: theorem
title: "The Unit Type / 单元类型"
chapter: 2
section: 8
tags: [unit-type, contractible, path]
references:
  - "[[00_overview]]"
  - "[[01_product]]"
---

# The Unit Type / 单元类型

## 单元类型的路径空间 / Path Space of the Unit Type

### Theorem 2.8.1

对于任意 $x, y : \mathbf{1}$：

$$\boxed{(x = y) \simeq \mathbf{1}}$$

> For any $x, y : \mathbf{1}$, we have $(x = y) \simeq \mathbf{1}$.

这意味着 $\mathbf{1}$ 的任意两个元素都是相等的——即 $\mathbf{1}$ 的路径空间是可缩的。

---

## 证明 / Proof

- **方向 $(x = y) \to \mathbf{1}$**: 将所有东西映到 $\star$。
- **方向 $\mathbf{1} \to (x = y)$**: 对 $x, y : \mathbf{1}$，通过 $\mathbf{1}$-归纳可假设 $x \equiv \star \equiv y$，此时有 $\mathsf{refl}_\star : x = y$。
- **互逆性**: 一方面，任何 $u : \mathbf{1}$ 可假设 $u \equiv \star$；另一方面，给定 $p : x = y$，通过路径归纳可假设 $p$ 是 $\mathsf{refl}_x$，然后再假设 $x$ 是 $\star$。

**注意证明顺序**: 不能先对 $x, y$ 做 $\mathbf{1}$-归纳再对 $p$ 做路径归纳（会卡住）。应先保持 $x, y$ 一般，尽量推迟归纳。

---

## 传输 / Transport

$\mathbf{1}$ 中的传输引理是常类型族传输引理的特例。

---

## 相关概念 / Related Concepts

- [[00_overview|Overview / 概述]]
- [[01_product|Product Types / 积类型]]

---

## 参考文献 / References

- HoTT Book, Section 2.8: The unit type
