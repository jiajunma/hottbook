---
type: moc
title: 高阶归纳类型 / Higher Inductive Types
chapter: 6
tags: [moc, higher-inductive-types, hits, circle, pushouts]
---

# 高阶归纳类型 / Higher Inductive Types

## 概述 / Overview

HIT 允许构造子不仅引入点，还引入路径 (及更高路径)。这使得在类型论内部可以直接构造 $S^1$、$S^n$、推出、商、截断等空间。

HITs allow constructors that introduce not just points but also paths (and higher paths). This enables direct construction of spaces like $S^1$, $S^n$, pushouts, quotients, and truncations within type theory.

## 本区域笔记 / Notes in This Area

### 基础 / Foundations
- [[introduction]] -- HIT 导论 / Introduction to HITs
- [[dependent_paths]] -- 依赖路径与 pathover / Dependent paths and pathovers
- [[general_syntax]] -- HIT 的一般语法 / General syntax of HITs

### 基本 HIT / Basic HITs
- [[interval]] -- 区间类型 / The interval
- [[circle_and_spheres]] -- 圆 $S^1$ 和球面 $S^n$ / The circle and spheres
- [[suspensions]] -- 悬挂 $\Sigma A$ / Suspensions

### 构造技术 / Construction Techniques
- [[cell_complexes]] -- 胞腔复形 / Cell complexes
- [[hubs_and_spokes]] -- 轮毂与辐条构造 / Hubs and spokes construction
- [[pushouts]] -- 推出 / Pushouts

### 截断与商 / Truncation and Quotients
- [[truncations_as_hits]] -- 截断作为 HIT / Truncations as HITs
- [[quotients]] -- 商类型 / Quotient types

### 代数与技术工具 / Algebra and Technical Tools
- [[free_algebra]] -- 自由代数 / Free algebras
- [[flattening_lemma]] -- 展平引理 / The flattening lemma

## 跨区域链接 / Cross-Area Links

- [[truncation]] (Truncation_Levels) -- 截断由 HIT 实现 / Truncation is implemented via HITs
- [[pi1_circle]] (Homotopy_Theory) -- $\pi_1(S^1) \cong \mathbb{Z}$ 使用圆的 HIT 定义 / Uses the HIT definition of the circle
- [[cauchy_reals]] (Real_Numbers) -- Cauchy 实数是一个 HIT / Cauchy reals are a HIT
- [[surreal_numbers]] (Real_Numbers) -- 超实数是一个 HIT / Surreal numbers are a HIT
- [[cumulative_hierarchy]] (Set_Theory) -- 累积层叠 $V$ 是一个 HIT / The cumulative hierarchy $V$ is a HIT
