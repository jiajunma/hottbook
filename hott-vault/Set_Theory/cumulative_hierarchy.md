---
type: section
title: 累积层次 / The Cumulative Hierarchy
chapter: 10
section: 10.5
tags: [set-theory, cumulative-hierarchy, ZF, membership, HIT]
references:
  - "[[04_classical_well_orderings]]"
---

# 累积层次 $V$ / The Cumulative Hierarchy

## 定义 / Definition

**定义**: 相对于宇宙 $\mathcal{U}$，累积层次 $V$ 是以下 HIT:
1. 对每个 $A : \mathcal{U}$ 和 $f : A \to V$，有元素 $\mathsf{set}(A, f) : V$
2. **路径构造器**: 若 $(\forall a. \exists b. f(a) = g(b)) \land (\forall b. \exists a. f(a) = g(b))$，则 $\mathsf{set}(A, f) = \mathsf{set}(B, g)$
3. **0-截断**: $V$ 是集合

$\mathsf{set}(A, f)$ 表示集合 $\{f(a) \mid a \in A\}$。

## 成员关系 / Membership

$$x \in \mathsf{set}(A, f) \defeq \exists a : A. \; x = f(a)$$

子集关系: $x \subseteq y \defeq \forall z. z \in x \Rightarrow z \in y$

## 类 / Classes

**类** 是 $V$ 上的纯谓词 $C : V \to \mathsf{Prop}$。类是 **$V$-集** 若存在 $v : V$ 使 $C(x) \Leftrightarrow x \in v$。

## 双模拟 / Bisimulation

定义 $\mathcal{U}$-小的等价关系 $\approx$ 替代 $V$ 上的恒等:
$$\mathsf{set}(A, f) \approx \mathsf{set}(B, g) \defeq (\forall a. \exists b. f(a) \approx g(b)) \land (\forall b. \exists a. f(a) \approx g(b))$$

**引理**: $\approx$ 等价于 $V$ 上的相等（$v \approx w \Leftrightarrow v = w$）。

## ZF 公理 / ZF Axioms in V

$V$ 满足 ZF 集合论的（适当版本的）公理:
- 外延性
- 空集、配对、并集
- 分离、替换
- 幂集（假设命题缩放或排中律）
- $\in$-归纳

## 参考 / References

- HoTT Book, Section 10.5
