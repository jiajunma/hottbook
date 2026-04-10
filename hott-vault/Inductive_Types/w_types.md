---
type: definition
title: W-类型 / W-types (Well-founded Trees)
chapter: 5
section: 3
tags: [w-types, induction, well-founded-trees]
references:
  - "[[01_intro_inductive_types]]"
  - "[[04_initial_algebras]]"
---

# W-类型 / W-types (Well-founded Trees)

## 定义 / Definition

给定 $A : \mathsf{Type}$ 和 $B : A \to \mathsf{Type}$，**W-类型** $\mathsf{W}_{a:A} B(a)$ 是良基树的类型：
- 节点由 $A$ 的元素标记
- 标记为 $a$ 的节点有 $B(a)$ 个分支

The **W-type** $\mathsf{W}_{a:A} B(a)$ is the type of well-founded trees: nodes labeled by $A$, with $B(a)$-many branches at a node labeled $a$.

### 构造子 / Constructor

$$\mathsf{sup} : \prod_{a:A} \Big(B(a) \to \mathsf{W}_{x:A} B(x)\Big) \to \mathsf{W}_{x:A} B(x)$$

## 自然数编码 / Encoding Natural Numbers

$$\mathbb{N}^w \equiv \mathsf{W}_{b:\mathbf{2}} \mathsf{rec}_\mathbf{2}(\mathcal{U}, \mathbf{0}, \mathbf{1}, b)$$

- 标记 $0_\mathbf{2}$（零）: 零个参数（$B(0_\mathbf{2}) = \mathbf{0}$）
- 标记 $1_\mathbf{2}$（后继）: 一个参数（$B(1_\mathbf{2}) = \mathbf{1}$）

## 归纳原理 / Induction Principle

给定 $E : (\mathsf{W}_{x:A} B(x)) \to \mathsf{Type}$，要证明 $E$ 对所有元素成立，只需对 $\mathsf{sup}(a,f)$ 给出证明，假设 $E$ 对所有 $f(b)$（$b : B(a)$）成立：

$$e : \prod_{a:A}\prod_{f : B(a) \to W}\left(\prod_{b : B(a)} E(f(b))\right) \to E(\mathsf{sup}(a,f))$$

## 唯一性定理 / Uniqueness Theorem

**定理 5.3.1.** 若 $g, h : \prod_{w:\mathsf{W}_{x:A}B(x)} E(w)$ 命题地满足同一递推关系，则 $g = h$。

## 参考文献 / References

- HoTT Book, Section 5.3
