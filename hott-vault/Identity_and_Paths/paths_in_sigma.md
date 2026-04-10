---
type: theorem
title: "Σ-types / Σ-类型"
chapter: 2
section: 7
tags: [sigma-type, dependent-pair, path, transport, path-over]
references:
  - "[[00_overview]]"
  - "[[01_product]]"
  - "[[../02_Paths/02_transport]]"
---

# Σ-types / Σ-类型

## Σ-类型中的路径 / Paths in Σ-types

### Theorem 2.7.2

设 $P : A \to \mathcal{U}$ 是 $A$ 上的类型族，$w, w' : \sum_{x:A} P(x)$。则有等价：

$$\boxed{(w = w') \simeq \sum_{p : \mathsf{pr}_1(w) = \mathsf{pr}_1(w')} \mathsf{transport}^P(p, \mathsf{pr}_2(w)) = \mathsf{pr}_2(w')}$$

> A path $w = w'$ in the total space is determined by a path $p : \mathsf{pr}_1(w) = \mathsf{pr}_1(w')$ in $A$ together with a path from $\mathsf{pr}_2(w)$ to $\mathsf{pr}_2(w')$ lying over $p$.

**直觉**: Σ-类型中的路径是一对：
1. 底空间 $A$ 中的一条路径 $p$
2. 纤维中的一条"路径上方的路径" (path-over)：$p_*(\mathsf{pr}_2(w)) = \mathsf{pr}_2(w')$

这推广了积类型的结果（积类型是 $P$ 为常族的特例）。

---

## 重要警告 / Important Caveat

### Remark 2.7.1

若有 $x : A$ 和 $u, v : P(x)$ 使得 $(x, u) = (x, v)$，**不能**直接推出 $u = v$。只能推出存在 $p : x = x$ 使得 $p_*(u) = v$。

拓扑解读：纤维化全空间中同一纤维上两点间的路径，不一定能投影为恒等路径——它可能绕了一圈。

---

## 命题唯一性原则 / Propositional Uniqueness Principle

### Corollary 2.7.3

对于 $z : \sum_{x:A} P(x)$：

$$z = (\mathsf{pr}_1(z), \mathsf{pr}_2(z))$$

---

## Σ-类型族中的传输 / Transport in Σ-type Families

### Theorem 2.7.4

设 $P : A \to \mathcal{U}$ 和 $Q : (\sum_{x:A} P(x)) \to \mathcal{U}$。对于 $p : x = y$ 和 $(u, z) : \sum_{u:P(x)} Q(x, u)$：

$$\mathsf{transport}^P_{\Sigma}(p, (u, z)) = \left(\mathsf{transport}^P(p, u),\; \mathsf{transport}^Q(\mathsf{pair}^=(p, \mathsf{refl}_{p_*(u)}), z)\right)$$

---

## 路径提升的关系 / Relation to Path Lifting

Lemma 2.3.2 中的提升路径 $\mathsf{lift}(u, p)$ 是引入形式的特例：

$$\mathsf{pair}^=(p, \mathsf{refl}_{p_*(u)}) : (x, u) = (y, p_*(u))$$

---

## 相关概念 / Related Concepts

- [[01_product|Cartesian Product Types / 笛卡尔积类型]] -- 特例
- [[../02_Paths/02_transport|Transport / 传输]]
- [[00_overview|Overview / 概述]]

---

## 参考文献 / References

- HoTT Book, Section 2.7: Σ-types
