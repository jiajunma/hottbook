---
type: moc
title: 恒等类型与路径 / Identity Types and Paths
chapter: 2
tags: [moc, identity-type, paths, homotopy-type-theory]
---

# 恒等类型与路径 / Identity Types and Paths

## 概述 / Overview

在 HoTT 中，恒等类型 $a =_A b$ 不仅仅是一个命题，而是一个空间——其元素是路径。这是类型论与同伦论之间的桥梁。所有高维群胚结构都来自路径归纳 (J 规则)。

In HoTT, the identity type $a =_A b$ is not just a proposition but a space -- its elements are paths. This is the bridge between type theory and homotopy theory. All higher groupoid structure arises from path induction (the J rule).

## 本区域笔记 / Notes in This Area

### 核心定义 / Core Definitions
- [[identity_type]] -- 恒等类型 $a =_A b$ 与路径归纳 / Identity type and path induction
- [[path_operations]] -- 路径运算：逆、合成、结合律 / Path operations: inverse, composition, associativity

### 函子性与传输 / Functoriality and Transport
- [[ap]] -- 函数对路径的作用 $\mathsf{ap}_f$ / Action of functions on paths
- [[transport]] -- 沿路径传输 $\mathsf{transport}^P$ / Transport along paths

### 各类型中的路径 / Paths in Specific Types
- [[paths_in_products]] -- 积类型中的路径 / Paths in product types
- [[paths_in_sigma]] -- $\Sigma$-类型中的路径 / Paths in $\Sigma$-types
- [[paths_in_pi]] -- $\Pi$-类型中的路径 / Paths in $\Pi$-types
- [[paths_in_unit]] -- 单位类型中的路径 / Paths in the unit type
- [[paths_in_coproducts]] -- 余积类型中的路径 / Paths in coproduct types
- [[paths_in_nat]] -- 自然数中的路径 / Paths in $\mathbb{N}$
- [[paths_in_identity]] -- 恒等类型中的路径 / Paths in identity types

### 高级技术 / Advanced Techniques
- [[equality_of_structures]] -- 结构的相等性 / Equality of structures
- [[identity_systems]] -- 恒等系统 / Identity systems
- [[encode_decode]] -- 编码-解码方法 / Encode-decode method

## 跨区域链接 / Cross-Area Links

- [[univalence]] (Axioms) -- Univalence 将类型等价提升为路径 / Univalence lifts equivalences to paths
- [[function_extensionality]] (Axioms) -- 函数外延性：逐点相等即路径 / Function extensionality: pointwise equality is a path
- [[homotopy]] (Equivalences) -- 函数间的同伦是逐点路径 / Homotopies between functions are pointwise paths
- [[circle_and_spheres]] (Higher_Inductive_Types) -- 圆和球面中的路径 / Paths in circles and spheres
- [[pi1_circle]] (Homotopy_Theory) -- $\pi_1(S^1) \cong \mathbb{Z}$ 由编码-解码证明 / Proved via encode-decode
