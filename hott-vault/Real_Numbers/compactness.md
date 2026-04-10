---
type: section
title: 区间紧致性 / Compactness of the Interval
chapter: 11
section: 11.5
tags: [real-numbers, compactness, heine-borel, constructive-analysis]
references:
  - "[[04_cauchy_vs_dedekind]]"
next:
  - "[[06_surreal_numbers]]"
---

# 区间紧致性 / Compactness of the Interval

## 三种紧致性 / Three Notions of Compactness

| 概念 | 定义 | 构造性状态 |
|---|---|---|
| **度量紧致** | Cauchy 完备 + 完全有界 | $[0,1]$ 满足 |
| **Bolzano-Weierstrass** | 每个序列有收敛子列 | 蕴涵受限全知原则 (LPO) |
| **Heine-Borel** | 每个开覆盖有有限子覆盖 | 朴素版本不可行; 归纳覆盖可行 |

## 度量紧致性 / Metric Compactness

$[0,1]$ 是度量紧致的:
- **完备**: 继承自 $\mathbb{R}$
- **完全有界**: 对每个 $\epsilon > 0$，$[0,1]$ 有 $\epsilon$-网

一致连续函数在度量紧致空间上的行为符合预期（有界、达到最值等）。

## Bolzano-Weierstrass 性质

**定理**: "每个 $[0,1]$ 中的序列有收敛子列"蕴涵受限全知原则 (LPO)，这是排中律的一个实例。

故在纯构造性设定中 B-W 性质不成立。

## Heine-Borel 紧致性 / Heine-Borel Compactness

朴素的有限子覆盖性质构造性不可行。替代方案: **归纳覆盖 (inductive covers)** 的证明相关概念。

## 参考 / References

- HoTT Book, Section 11.5
