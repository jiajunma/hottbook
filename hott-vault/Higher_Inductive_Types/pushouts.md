---
type: definition
title: 推出 / Pushouts
chapter: 6
section: 8
tags: [pushouts, colimits, HITs, universal-property]
references:
  - "[[05_suspensions]]"
  - "[[09_truncations]]"
---

# 推出 / Pushouts

## 定义 / Definition

给定跨度 $A \xleftarrow{f} C \xrightarrow{g} B$，其**推出** $A \sqcup^C B$ 由以下生成：
- $\mathsf{inl} : A \to A \sqcup^C B$
- $\mathsf{inr} : B \to A \sqcup^C B$
- 对每个 $c : C$，$\mathsf{glue}(c) : \mathsf{inl}(f(c)) = \mathsf{inr}(g(c))$

## 泛性质 / Universal Property

**引理 6.8.2.** 对任何类型 $E$：

$$(A \sqcup^C B \to E) \simeq \mathsf{cocone}_\mathscr{D}(E)$$

其中 $\mathsf{cocone}$ 由函数 $i : A \to E$, $j : B \to E$ 和同伦 $h : \prod_{c:C}(i(f(c)) = j(g(c)))$ 组成。

## 特殊情形 / Special Cases

| 构造 / Construction | 跨度 / Span | 结果 / Result |
|---|---|---|
| 悬挂 $\Sigma A$ | $\mathbf{1} \leftarrow A \to \mathbf{1}$ | 两点 + 子午线 |
| 连接 $A * B$ | $A \leftarrow A \times B \to B$ | 投影 |
| 余纤维 | $\mathbf{1} \leftarrow A \xrightarrow{f} B$ | 锥 |
| 楔积 $A \vee B$ | $A \leftarrow \mathbf{1} \to B$ | 指向联合 |
| 粉碎积 $A \wedge B$ | $A \vee B$ 的余纤维 | |

## 参考文献 / References

- HoTT Book, Section 6.8
