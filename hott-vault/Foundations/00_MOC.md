---
type: moc
title: 类型论基础 / Type Theory Foundations
chapter: 1
tags: [moc, type-theory, foundations]
---

# 类型论基础 / Type Theory Foundations

## 概述 / Overview

类型论是 HoTT 的基础语言，作为集合论的替代方案。每种类型由五条规则指定：
- **Formation** (类型形成) — 如何构造这种类型
- **Introduction** (引入/构造) — 如何创建元素
- **Elimination** (消去/使用) — 如何使用元素
- **Computation** ($\beta$-规则) — 消去作用于引入的结果
- **Uniqueness** ($\eta$-规则) — 元素由消去结果唯一决定

Type theory serves as an alternative to set theory. Each type is specified by five rules: formation, introduction, elimination, computation ($\beta$), and uniqueness ($\eta$).

## 教学资源 / Teaching Resources

- [[teaching/00_roadmap]] — 教学路线图（面向会编程的大一学生）
- [[teaching/ch01_lesson_plan]] — 第一章详细教案（4 讲 × 2 学时）
- [[teaching/symbol_guide]] — Obsidian 中的数学符号对照表
- [[book/ch01_type_theory]] — 第一章按节摘要

## 本区域笔记 / Notes in This Area

### 基本概念 / Basic Concepts
- [[judgment]] — 判断与推理规则 / Judgments and inference rules (§1.1)
- [[function_type]] — 函数类型 $A \to B$，λ-抽象 / Function types (§1.2)
- [[universes]] — 类型宇宙 $\mathcal{U}_i$，类型族 / Type universes and families (§1.3)

### 依赖类型 / Dependent Types
- [[pi_type]] — 依赖函数类型 $\prod_{(x:A)} B(x)$，泛型的终极形态 / Π-types (§1.4)
- [[sigma_type]] — 依赖对类型 $\sum_{(x:A)} B(x)$，带约束的 struct / Σ-types (§1.6)

### 数据类型 / Data Types
- [[product_type]] — 积类型 $A \times B$，tuple / Product types (§1.5)
- [[coproduct_type]] — 余积类型 $A + B$，union / Coproduct types (§1.7)
- [[bool]] — 布尔类型 $\mathbf{2}$，if-then-else / Booleans (§1.8)
- [[nat]] — 自然数 $\mathbb{N}$，递归与归纳 / Natural numbers (§1.9)

### 消去与逻辑 / Elimination and Logic
- [[pattern_matching]] — 模式匹配 = 归纳原理的语法糖 / Pattern matching (§1.10)
- [[propositions_as_types]] — 命题即类型 (Curry-Howard) / Propositions as types (§1.11)

## 建议阅读顺序 / Suggested Reading Order

```
judgment → function_type → product_type → coproduct_type
    ↓                                         ↓
universes → pi_type → sigma_type          bool → nat
                                              ↓
                            pattern_matching → propositions_as_types
```

## 跨区域链接 / Cross-Area Links

- [[Identity_and_Paths/identity_type]] — 恒等类型是 §1.12 内容，连接类型论与同伦论
- [[Truncation_Levels/n_types]] — 类型按同伦层级分类
- [[Logic/classical_vs_intuitionistic]] — 构造主义 vs 经典逻辑的详细讨论
