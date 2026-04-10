---
type: definition
title: 圆与球面 / Circles and Spheres
chapter: 6
section: 4
tags: [circle, sphere, loop, HITs]
references:
  - "[[02_induction_dependent_paths]]"
  - "[[05_suspensions]]"
---

# 圆与球面 / Circles $S^1$ and Spheres $S^n$

## 圆 $S^1$ / The Circle

**构造子：**
- 点：$\mathsf{base} : S^1$
- 路径：$\mathsf{loop} : \mathsf{base} =_{S^1} \mathsf{base}$

### 圆是非平凡的 / The Circle is Nontrivial

**引理 6.4.1.** $\mathsf{loop} \neq \mathsf{refl}_{\mathsf{base}}$。

证明：若 $\mathsf{loop} = \mathsf{refl}$，则对任何类型 $A$ 中 $x : A$ 和 $p : x = x$，递归映射给出 $p = \mathsf{refl}_x$，即所有类型都是集合，矛盾。

**引理 6.4.2.** 存在 $\prod_{x:S^1}(x = x)$ 的元素不等于 $x \mapsto \mathsf{refl}_x$。（定义 $f(\mathsf{base}) \equiv \mathsf{loop}$。）

**推论.** 若 $S^1$ 属于某个宇宙 $\mathsf{Type}$，则 $\mathsf{Type}$ 不是 1-类型。

## 球面 $S^2$ / The 2-Sphere

**构造子：**
- $\mathsf{base} : S^2$
- $\mathsf{surf} : \mathsf{refl}_{\mathsf{base}} = \mathsf{refl}_{\mathsf{base}}$（2 维路径）

## 一般 $n$-球面 / General $n$-Spheres

用 $n$-重循环空间定义：$S^n$ 由 $\mathsf{base} : S^n$ 和 $\mathsf{loop}_n : \Omega^n(S^n, \mathsf{base})$ 生成。

或者用悬挂递归定义（见 [[05_suspensions]]）：
$$S^0 \equiv \mathbf{2}, \qquad S^{n+1} \equiv \Sigma S^n$$

## 参考文献 / References

- HoTT Book, Section 6.4
