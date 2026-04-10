---
type: section
title: Rezk 完备化 / The Rezk Completion
chapter: 9
section: 9.9
tags: [category-theory, rezk-completion, weak-equivalence]
references:
  - "[[08_structure_identity]]"
---

# Rezk 完备化 / The Rezk Completion

## 动机 / Motivation

给定预范畴 $A$，有泛方式将其替换为范畴 $\hat{A}$，称为 **Rezk 完备化**（也称栈完备化）。

## 弱等价 / Weak Equivalence

**定义**: 函子 $H : A \to B$ 是 **弱等价** 若完全忠实且本质满。

## 关键定理 / Key Theorem

**定理**: 若 $A, B$ 是预范畴，$C$ 是范畴，$H : A \to B$ 是弱等价，则
$$(\_ \circ H) : C^B \to C^A$$
是同构（范畴间的）。

**证明关键**: 要定义 $G : B \to C$，对每个 $b : B$ 需唯一指定 $Gb$。在经典范畴论中，$Gb$ 仅在唯一同构意义下确定，不足以给出函数（需选择公理）。在 HoTT 中，若 $C$ 是范畴，同构即相等，故唯一同构意味着可缩空间，可直接提取函数。

## Rezk 完备化的构造 / Construction

**方法一**: $\hat{A}$ 的对象为 $\sum_{F : \mathsf{Set}^{A^{\mathsf{op}}}} \|{\sum_{a:A} \mathsf{y}(a) \cong F}\|_{-1}$（可表预层的本质像）。

**方法二**: 用 HIT 构造。

**性质**:
- 函子 $A \to \hat{A}$ 完全忠实且本质满
- $\hat{A}$ 是范畴
- 预范畴 $A$ 是范畴当且仅当 $A \to \hat{A}$ 是等价

## 参考 / References

- HoTT Book, Section 9.9
