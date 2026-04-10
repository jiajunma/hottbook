---
type: section
title: 基数 / Cardinal Numbers
chapter: 10
section: 10.2
tags: [set-theory, cardinal-numbers, cantor]
references:
  - "[[01_category_of_sets]]"
next:
  - "[[03_ordinal_numbers]]"
---

# 基数 / Cardinal Numbers

## 定义 / Definition

**定义**: 基数类型 $\mathsf{Card} \defeq \|\mathsf{Set}\|_0$（集合类型的 0-截断）。

基数 $|A|$ 是集合 $A$ 在 $\|\mathsf{Set}\|_0$ 中的像。$\mathsf{Card}$ 是集合。

## 运算 / Operations

由截断归纳定义:
- **加法**: $|A| + |B| \defeq |A + B|$
- **乘法**: $|A| \cdot |B| \defeq |A \times B|$
- **指数**: $|A|^{|B|} \defeq |B \to A|$

**引理**: $\mathsf{Card}$ 是交换半环，指数满足通常法则。

## 不等式 / Inequality

**定义**: $|A| \le |B| \defeq \|\mathsf{inj}(A, B)\|_{-1}$（仅存在单射）。

基数不等式是预序，且与半环运算兼容。

## 经典结果 / Classical Results (with LEM)

- **Schroeder-Bernstein**: $\mathsf{inj}(A,B) \to \mathsf{inj}(B,A) \to (A \cong B)$
- 假设排中律: 基数不等式是偏序

## Cantor 定理 / Cantor's Theorem

**定理**: 不存在满射 $A \to (A \to \mathbf{2})$。

**推论** (假设排中律): 对任意 $\alpha$，存在 $\beta$ 使 $\alpha \le \beta$ 且 $\alpha \ne \beta$。取 $\beta = 2^\alpha$。

## 参考 / References

- HoTT Book, Section 10.2
