---
type: definition
title: 满射与嵌入 / Surjections and Embeddings
chapter: 4
section: 6
tags: [surjection, embedding, fiber, equivalence-factorization]
references:
  - "[[00_Overview]]"
  - "[[04_contractible_fibers]]"
  - "[[../03_Sets_and_Logic/06_propositional_truncation]]"
---

# 满射与嵌入 / Surjections and Embeddings

## 满射 / Surjection

$f : A \to B$ 是**满射 (surjective)** 如果每个纤维仅仅被居住：

$$\mathsf{isSurj}(f) \defeq \prod_{y:B}\left\|\mathsf{fib}_f(y)\right\|$$

即：对每个 $y:B$，仅仅存在某个 $x:A$ 使得 $f(x) = y$。

$f$ is surjective if every fiber is merely inhabited.

## 嵌入 / Embedding

$f : A \to B$ 是**嵌入 (embedding)** 如果 $\mathsf{ap}_f$ 对所有输入都是等价：

$$\mathsf{isEmbedding}(f) \defeq \prod_{x,y:A}\mathsf{isEquiv}(\mathsf{ap}_f : (x = y) \to (f(x) = f(y)))$$

等价地，$f$ 是嵌入当且仅当每个纤维都是纯命题：

$$\mathsf{isEmbedding}(f) \simeq \prod_{y:B}\mathsf{isProp}(\mathsf{fib}_f(y))$$

$f$ is an embedding if $\mathsf{ap}_f$ is an equivalence, equivalently if all fibers are mere propositions.

## 等价 = 满射 + 嵌入 / Equivalence = Surjection + Embedding

> $f$ 是等价 $\iff$ $f$ 既是满射又是嵌入。

| 纤维条件 / Fiber condition | $f$ 的分类 / Classification |
|---|---|
| 可缩（isContr） | 等价 |
| 纯命题（isProp） | 嵌入 |
| 仅仅被居住（$\|-\|$） | 满射 |
| 纯命题 + 仅仅被居住 | 可缩 $\Rightarrow$ 等价 |

这正是[[../03_Sets_and_Logic/09_contractibility|可缩 = 纯命题 + 被居住]]在纤维层面的体现。

## 例子 / Examples

- 子集的包含映射 $\{x:A \mid P(x)\} \hookrightarrow A$ 是嵌入
- 命题截断的映射 $|{-}| : A \to \|A\|$ 是满射
- 恒等映射是等价（从而既是满射又是嵌入）

## 相关概念 / Related Concepts

- [[04_contractible_fibers|可缩纤维]] - 等价的纤维刻画
- [[../03_Sets_and_Logic/05_subsets|子集]] - 嵌入的来源
- [[../03_Sets_and_Logic/06_propositional_truncation|命题截断]] - 满射的来源

## 参考文献 / References

- HoTT Book, Section 4.6: Surjections and embeddings
