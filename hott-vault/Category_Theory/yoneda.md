---
type: section
title: Yoneda 引理 / The Yoneda Lemma
chapter: 9
section: 9.5
tags: [category-theory, yoneda, hom-functor, embedding]
references:
  - "[[04_equivalences]]"
next:
  - "[[06_strict_categories]]"
---

# Yoneda 引理 / The Yoneda Lemma

## 对偶与积 / Opposites and Products

- **对偶范畴**: $A^{\mathsf{op}}$，$\hom_{A^{\mathsf{op}}}(a,b) \defeq \hom_A(b,a)$
- **积范畴**: $(A \times B)_0 \defeq A_0 \times B_0$
- **指数伴随**: $(A \times B \to C) \simeq (A \to C^B)$

## Hom-函子与 Yoneda 嵌入 / Hom-Functor and Yoneda Embedding

$$\hom_A : A^{\mathsf{op}} \times A \to \mathsf{Set}$$

由此得 **Yoneda 嵌入**: $\mathsf{y} : A \to \mathsf{Set}^{A^{\mathsf{op}}}$

## Yoneda 引理 / Yoneda Lemma

**定理**: 对任意预范畴 $A$，$a : A$，函子 $F : \mathsf{Set}^{A^{\mathsf{op}}}$:

$$\hom_{\mathsf{Set}^{A^{\mathsf{op}}}}(\mathsf{y}(a), F) \cong Fa$$

自然于 $a$ 和 $F$。

**证明**:
- $\to$: $\alpha \mapsto \alpha_a(1_a)$
- $\leftarrow$: $x \mapsto (\alpha_{a'}(f) \defeq F_{a,a'}(f)(x))$

## 推论 / Corollaries

- Yoneda 嵌入是完全忠实的
- 若 $A$ 是范畴，$\mathsf{y}$ 是从 $A$ 到 $\mathsf{Set}^{A^{\mathsf{op}}}$ 的嵌入

## 参考 / References

- HoTT Book, Section 9.5
