---
type: section
title: 有理数 / The Rational Numbers
chapter: 11
section: 11.1
tags: [real-numbers, rationals, ordered-field]
references:
  - "[[00_Overview]]"
next:
  - "[[02_dedekind_reals]]"
---

# 有理数域 / The Field of Rational Numbers

## 构造 / Construction

$$\mathbb{Q} \defeq (\mathbb{Z} \times \mathbb{N}) / {\approx}$$

其中 $(u, a) \approx (v, b) \defeq u(b+1) = v(a+1)$。

对 $(u, a)$ 表示有理数 $u/(1+a)$（巧妙避免除零）。

有典范代表（最简分数），故可应用商类型引理得到集合 $\mathbb{Q}$，具有可判定相等。

## 性质 / Properties

- $\mathbb{Q}$ 是有序域，具有可判定相等和可判定序
- $\mathbb{Q}$ 可刻画为初始有序域
- $\mathbb{Q}^+ \defeq \{q : \mathbb{Q} \mid q > 0\}$ 为正有理数类型

## 参考 / References

- HoTT Book, Section 11.1
