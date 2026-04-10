---
type: concept
title: 高阶归纳类型导论 / Introduction to HITs
chapter: 6
section: 1
tags: [HITs, higher-inductive-types, free-generation]
references:
  - "[[00_Overview]]"
---

# 高阶归纳类型导论 / Introduction to HITs

## 基本思想 / Basic Idea

高阶归纳类型允许**路径构造子 (path constructors)** 和**高维路径构造子**，除了通常的**点构造子 (point constructors)**。

HITs allow **path constructors** and higher path constructors, in addition to ordinary **point constructors**.

### 自由生成 / Free Generation

"生成"应该严格理解，如同群由集合自由生成：
- 高群胚有路径上的**运算**（连接、求逆等）
- 这些运算创造更多不直接来自构造子的路径
- 例如在 $S^1$ 中：$\mathsf{loop} \cdot \mathsf{loop}$, $\mathsf{loop}^{-1}$ 等都存在

### 非平凡高维路径 / Unexpected Higher Paths

构造子的维度不直接决定类型包含非平凡同伦的维度。例如 $S^2$ 只有一个 2 维路径构造子 $\mathsf{surf}$，但存在非平凡的 3 维路径（Hopf 纤维化）。

### 技术要点 / Technical Points

- HIT 本身有泛性质（归纳原理），而非其恒等类型
- 确定 HIT 的恒等类型通常非平凡（等同于计算同伦群）
- 通过添加"截断构造子"可表达群表示等经典概念

## 参考文献 / References

- HoTT Book, Section 6.1
