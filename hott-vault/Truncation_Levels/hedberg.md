---
type: theorem
title: 恒等证明的唯一性与 Hedberg 定理 / UIP and Hedberg's Theorem
chapter: 7
section: 2
tags: [sets, UIP, axiom-K, hedberg, decidable-equality]
references:
  - "[[01_n_types]]"
---

# 恒等证明的唯一性与 Hedberg 定理 / UIP and Hedberg's Theorem

## Axiom K

**定理 7.2.1.** $X$ 是集合当且仅当满足 **Axiom K**：对所有 $x : X$ 和 $p : x =_X x$，$p = \mathsf{refl}_x$。

注意：我们不假设 UIP 或 Axiom K 为公理！它们只是特定类型可能满足也可能不满足的性质。

## 自反纯关系蕴含集合 / Reflexive Mere Relation Implies Set

**定理 7.2.2.** 若 $R : X \times X \to \mathsf{Prop}$ 是自反纯关系且蕴含恒等（$R(x,y) \to x = y$），则 $X$ 是集合，且 $R(x,y) \simeq (x = y)$。

**推论.** 若 $\neg\neg(x = y) \to (x = y)$ 对所有 $x, y : X$ 成立，则 $X$ 是集合。

## Hedberg 定理 / Hedberg's Theorem

**定理 7.2.5 (Hedberg).** 若 $X$ 有**可判定相等** (decidable equality)，即对所有 $x, y : X$ 有 $(x = y) + \neg(x = y)$，则 $X$ 是集合。

证明思路：可判定相等蕴含 $\neg\neg(x=y) \to (x=y)$，再由上述推论得证。

### 应用 / Application

**定理 7.2.6.** $\mathbb{N}$ 有可判定相等，因此是集合。（对 $x$ 归纳，对 $y$ 分情况讨论。）

## 参考文献 / References

- HoTT Book, Section 7.2
