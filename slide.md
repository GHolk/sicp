
讀魔法書 SICP
============

*gholk*

---

<style>
    td {
        width: 50%;
        }
</style>

<table>
<tr>
<td>
Structure and Interpolation of Computer Program

![魔法書]

<td>
從 1970 年代開始作為 MIT 電機與電腦科學的基礎程式設計課程用書，
直到 2008 年被 python 取代為止。
</table>

[魔法書]: https://upload.wikimedia.org/wikipedia/commons/9/9d/SICP_cover.jpg

---

## gold holk

<img src="http://sitcon.org/2018/static/img/speaker/15.jpg" 
     style="width: 30%; 
            display: block;
            margin: auto;">

* 日常 GNU/Linux 使用者
* 興趣取向的 Web 開發者

---

## 為什麼要讀這本書？

* 身為 linux 使用者，多少會碰一點程式。
* 聽說 javascript 的概念來自 scheme。
* 寫出會動的程式外，要如何寫出良構、健壯、好懂的程式？
* 除了讓電腦動起來為你做事，是不是該學一點演算法、資料結構？

---

## javascript 與 scheme

功能 | scheme | javascript
----|--------|-----------
閉包 | 有     | 有
函數作為第一類公民 （與變數同命名空間）| 有 | 有
範式 | 函數式 | 指令式
物件導向 | 函數與巨集實現 | 語言內實現

---

## 讀 sicp 的好處

* 讓你寫遞迴像喝水一樣。（第 1 章後）
* 了解函數式程式語言之美。（第 1 2 章後）
* 了解 lisp 語法之美。（第 2 章吧？）

---

## 這本書就是

* 從 scheme 入門程式設計
* 探討（實作）多個議題：
  * 物件
  * 模組
  * 直譯器

---

### lisp 語言

* 傳統 lisp 基於符號、列表及 lambda 演算
* scheme 引入了 lexical scope、詞法作用域、靜態作用域、閉包
* scheme 將函數與變數放在同一命名空間
* 現代 lisp 也有 lexical scope

---

## 章節

 1. 程序
 2. 資料結構
 3. 模組、物件、狀態
 4. 語法解析
 5. 暫存器與底層結構

* 前二章是 scheme 練習
* 後三章是理論探討與實作

---

### 從 C 開始的程式設計

 1. C 語言的意義就是一連串的記憶體操作
 2. 變數的宣告、讀取、改變都對應到底層
 3. 從 0101 的二進位內容建構整數、字串、鏈表、物件等高級結構
 4. 最後建構出編譯器，構成一個完整的程式架構

---

### 從 scheme 開始的 sicp

 1. 函數的呼叫是抽像的代換規則
 2. 用函數實現資料結構
 3. 用函數及資料結構實作直譯器
 4. 用函數模擬 CPU

---

### 函數

* 沒有算符，只有函數。
* 沒有優先權問題。
* 免去 **運算子** 的 **重載** 與 **多載** 。

```c
1 + 2 * 3
// (1 + 2) * 3 ?
// 1 + (2 * 3) ?
```

```c
add(1, multiply(2,3) )
// 1 + (2 * 3)
```

---

### S 表達式

* 函數與巨集都以 S 表達式表示。
* 控制結構也是 S 表達式，簡化語法分析。

```scheme
(+ 1 (* 2 3)) ; 1 + (2 * 3)
```

```scheme
(if (> a b)
    (print a)
    (print b))

```

---

## 迴圈與遞迴

在 scheme 中雖然有迴圈，但不常用，
多直接用遞迴表示。

```scheme
(define (series i sum)
  (if (= 0 i)
      sum
      (series (- i 1)
              (+ sum i))))
```

### 迴圈的問題

迴圈的問題是他沒有 **返回值** ，
迴圈多是執行完後會改變上下文狀態。

```javascript
let sum = 0
for (let i=0; i<n; i++) {
  sum = sum + i
}
```

---

### do loop

```scheme
(do ((i 0 (+ i 1))
     (sum 0 (+ sum i)))
    ((= i 10) sum)
  (display i) (display "\t")
  (display sum) (newline))
```

```scheme
;; 等價遞迴寫法
(define (do-loop i sum)
  (if (= i 0)
      sum
      (begin
        (display i) (display "\t")
        (display sum) (newline)
        (do-loop (+ i 1)
                 (+ sum i)))))
(do-loop 0 0)
```

---

### 八皇后問題

<style id="queen-8">
#queen-8 + * td {
  width: 1em;
  border: solid 2px;
}
#queen-8 + * tr td:first-child,
#queen-8 + * tr th:first-child {
    border: none;
}
#queen-8 + * {
    font-size: 75%;
}
</style>


x|1|2|3|4|5|6|7|8
-|-|-|-|-|-|-|-|-
1| | | |o| | | |
2| |o| | | | | |
3| | | | | | |o|
4| | |o| | | | |
5| | | | | |o| |
6| | | | | | | |o
7| | | | |o| | |
8|o| | | | | | |

---

### 微分解析解

```scheme
(deriv '(+ x 3))
;; (+ 1 0)

(deriv '(* 6 x))
;; (+ (* 0 x)
;;    (* 6 1))
```

---

### 過時的 scheme
* 在 1970 年代，你沒有選擇
* lisp 系語言式微
* 本書偏難
* 對指令式編程的偏好

---

#### 指令式編程較符合底層結構

每個 statement 都在改變程式的狀態。

 1. 從硬碟中的內容寫到記憶體中
 2. 把該記憶體位置的值 `*3`
 3. 將該記憶體內容寫回硬碟

```javascript
x = read_file()
x = x * 3
write_file(x)
```

---

#### 函數式編程是一層層往上疊

在 scheme 中，函數可以有多個 statement，
但基本上你用不到第二個 statement

```javascript
function fp(a, b) {
  return multiply(add(a, b), a)
}
```

---

## 誰適合讀這本書

* 已經有程式基礎的人
* 喜歡函數式編程的人
* 不喜歡底層組語二進位的人

---

## 如何讀

* sicp book: UTF texinfo | html | pdf
* scheme interpreter: mit scheme | guile | racket
* editor: emacs | vim

