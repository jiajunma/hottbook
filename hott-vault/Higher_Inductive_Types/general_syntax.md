---
type: concept
title: HIT 定义的一般语法 / General Syntax of HIT Definitions
chapter: 6
section: 13
tags: [HITs, syntax, naturality, strict-positivity]
references:
  - "[[01_introduction]]"
  - "[[../../05_Induction/06_general_syntax]]"
---

# HIT 定义的一般语法 / General Syntax of HIT Definitions

## 与普通归纳类型的区别 / Difference from Ordinary Inductive Types

HIT 的构造子输出类型可以是恒等类型 $u =_W v$ 或迭代恒等类型。需要指定每个路径构造子的源 $u$ 和目标 $v$，这些表达式可以引用**先前的**构造子。

## 自然性要求 / Naturality Requirement

表达式 $u$ 和 $v$ 只能涉及被所有函数保持的运算（即**自然变换**）。

例如：
- 路径连接是允许的（所有函数保持路径连接）
- 非自然的操作（如 $f : \prod_{X:\mathsf{Type}}(X \to X)$）是不允许的

### 反例 / Counterexample

考虑用"不自然的" $f_K$ 定义的 HIT $K$：
- $a, b : K$
- $\sigma : f_K(a) = f_K(b)$

归纳原理无法良好表述，因为 $P(f_K(a))$ 和 $P(f_K(b))$ 没有已知的元素。

## 当前状态 / Current Status

找到 HIT 有效定义的一般语法描述是活跃的研究领域。本书鼓励读者谨慎地实验。

## 参考文献 / References

- HoTT Book, Section 6.13
