---
type: definition
title: 截断作为 HITs / Truncations as HITs
chapter: 6
section: 9
tags: [truncation, propositional-truncation, set-truncation, HITs]
references:
  - "[[08_pushouts]]"
  - "[[../../03_Sets_and_Logic/00_Overview]]"
---

# 截断作为 HITs / Truncations as HITs

## 命题截断 / Propositional Truncation

$\|A\|$ 由以下生成：
- $|{-}| : A \to \|A\|$
- 对每个 $x, y : \|A\|$，路径 $x = y$

第二个构造子断言 $\|A\|$ 是纯命题。递归原理：给定纯命题 $B$ 和 $g : A \to B$，存在 $f : \|A\| \to B$。

## 集合截断 / 0-Truncation

$\|A\|_0$ 由以下生成：
- $|{-}|_0 : A \to \|A\|_0$
- 对每个 $x, y : \|A\|_0$ 和 $p, q : x = y$，路径 $p = q$

**引理 6.9.1.** 若 $B : \|A\|_0 \to \mathsf{Type}$ 使得每个 $B(x)$ 是集合，且 $g : \prod_{a:A} B(|a|_0)$，则存在 $f : \prod_{x:\|A\|_0} B(x)$。

**泛性质.** 对任何集合 $B$：$(\|A\|_0 \to B) \simeq (A \to B)$。

## 集合推出 / Set Pushouts

对于集合的跨度，$\|\!A \sqcup^C B\!\|_0$ 对其他集合有正确的泛性质。

## 参考文献 / References

- HoTT Book, Section 6.9
