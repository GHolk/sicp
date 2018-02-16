# 資料結構
這章是介紹抽像化資料結構。

## 2-1 用 cons 表示資料
介紹抽像化資料結構的意義，
與用 cons 構成簡單的資料結構。

### 2-1-1 [分數](ration.sch)
簡單示範利用 cons 建構分數結構。
再一層層建立建構函數、存取函數，
在之上建立分數的各種運算。

### 2-1-2 [點線面](segment-2d.sch)
利用類似的方法用 cons 儲存 x y 座標構成點，
再用二個點構成線。

最後一題要建立長方形，
numbbbbb 是假設是和 x y 軸正交的正方形，
所以只要存二個點。

但我覺得不妥，做成存一條邊和高，
然後幫 segment 寫一個函數 `length-segment` ，
長方形有 height 返回高、side 返回邊、width 返邊的長度三個函數，
然後再用 height width 作出 perimeter area。

### 2-1-3 [用函數與閉包實作資料結構](cons.md): 
之前用了 cons car cdr 三個函數存資料，
但其實這三個函數也可以用函數自己實現 `;)`

### 2-1-4 [區間計算](interval.md)
關於電阻、區間的加減乘除。

## 2-2 用 cons 建構高級結構
用 cons 建造高結抽象的資料結構，像串列之類的。

  - 2-2-1 [列表](list.md) ：介紹列表的構成與函數。
  - 2-2-2 [樹](tree.md) ：介紹樹和樹的遞迴，
    這章我才了解 false 和 nil 要分開的原因。
  - 2-2-3 [通用列表](sequence.md) ：
    以列表作為通用結構。
    像在 js 中會 `array.map(...).filter(...).forEach(...)` ，
    在 scheme 也可以。
    這章中有很經典的八皇后問題，蠻難的。
  - 2-2-4 [繪圖](painter.md) ：實作了一個與底層無關的繪圖語言。
    聽說 gimp 是用 scheme 作為內部語言，
    難道就是這章內容？

## 2-3 Quote 與 Symbol
lisp 中用一種稱為 quote 的方式實作 symbol 這個概念，
並以 symbol 及 list 來表達 lisp 語言本身。

要註明一個詞是 symbol，僅代表該詞本身，
如同在寫作時使用引號標起來，僅代表本身。

quote 也就是 `'` ，
在 lisp 中也是 s 表達式，
也就是 `'(a b c)` 其實是
`(quote (a b c))` 的簡寫。
這裡 a b c 不會被求值，
因為 quote 和 if 同為特殊形式，
並不遵守一般求值規則。

quote 必須為巢狀，不太懂。

> But allowing statements in a
> language that talk about other statements in that language makes it very
> difficult to maintain any coherent principle of what "equals can be
> substituted for equals" should mean.  For example, if we know that the
> evening star is the morning star, then from the statement "the evening
> star is Venus" we can deduce "the morning star is Venus."  However,
> given that "John knows that the evening star is Venus" we cannot infer
> that "John knows that the morning star is Venus."

等號的一致性，不太懂。

  - 2-3-1 [符號系統的微分](symbol-different.md) ：
    如同數學的微分，符號系統也能定義微分。
    符號系統的微分在 lisp 存在已久，
    因此這章實作作為符號的練習。
