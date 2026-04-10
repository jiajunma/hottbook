---
type: concept
title: 恒等类型与恒等系统 / Identity Types and Identity Systems
chapter: 5
section: 8
tags: [identity-types, identity-systems, yoneda, equivalence-induction]
references:
  - "[[02_uniqueness]]"
  - "[[02_HoTT_Basics/01_Identity_Types/00_identity_type]]"
---

# 恒等类型与恒等系统 / Identity Types and Identity Systems

## 恒等类型作为归纳族 / Identity Types as Inductive Families

恒等类型可以用**两种方式**视为归纳族：

1. **路径归纳 (path induction)**：双指标族 $=_A : A \to A \to \mathsf{Type}$，构造子 $\mathsf{refl}_a : a =_A a$
2. **基路径归纳 (based path induction)**：固定 $a_0$，单指标族 $(a_0 =_A \mathord{-}) : A \to \mathsf{Type}$，构造子 $\mathsf{refl}_{a_0}$

## 为什么不是所有路径都是 refl / Why Not All Paths are refl

从空间/高群胚视角，自由生成的结构可以包含不是直接由生成元产生的元素（如自由群包含字的连接）。恒等类型是**自由生成的函子** $A \to \mathsf{Type}$，由 Yoneda 引理，这正是可表函子 $\mathsf{hom}_A(a_0, \mathord{-})$。

## 恒等系统 / Identity Systems

**定义.** $(A, a_0)$ 上的**恒等系统**是一个指向谓词 $(R, r_0)$（$R : A \to \mathsf{Type}$, $r_0 : R(a_0)$），满足基路径归纳原理。

**定理 5.8.2.** 对于指向谓词 $(R, r_0)$，以下等价：
1. $(R, r_0)$ 是 $a_0$ 处的恒等系统
2. 对任何指向谓词 $(S, s_0)$，$\mathsf{ppmap}(R, S)$ 可缩
3. $\mathsf{transport}^R_\mathord{-}(r_0) : (a_0 =_A b) \to R(b)$ 对所有 $b$ 是等价
4. $\sum_{b:A} R(b)$ 可缩

## 应用：等价归纳与同伦归纳 / Applications

**推论（等价归纳）.** 要证明关于所有等价的性质，只需对恒等映射证明。

$$D : \prod_{A,B:\mathcal{U}} (A \simeq B) \to \mathsf{Type},\quad d : \prod_{A:\mathcal{U}} D(A, A, \mathsf{id}_A)$$

$$\implies f : \prod_{A,B:\mathcal{U}}\prod_{e:A\simeq B} D(A, B, e)$$

**推论（同伦归纳）.** 类似地，函数外延性等价于"同伦归纳"。

## Lean 4

```lean
-- Identity systems generalize the J rule
-- In Lean, the J rule is built into the match/cases mechanism
-- #check @Eq.rec  -- the basic eliminator
```

---

## 参考文献 / References

- HoTT Book, Section 5.8
