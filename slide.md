
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

### 迴圈與遞迴

```scheme
(define (series i sum)
  (if (= 0 i)
      sum
      (series (- i 1)
              (+ sum i))))
```

```javascript
let sum = 0
for (let i=0; i<n; i++) {
  sum = sum + i
}
```

---

### 八皇后問題

 |1|2|3|4|5|6|7|8
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

## 結論

* 喜歡函數式編程的人
* 不喜歡底層組語二進位的人

---

## 如何讀

* UTF texinfo | html | pdf
* mit scheme | guile | racket
* emacs | vim | atom

---

## 程序

* scheme 語法與運算規則
* 遞迴與迴圈
* 抽象化過程

---

### 迴圈與遞迴

```javascript
function recursion(i) {
    if (i == 0) return 0
    else {
        print(i)
        i++
        return recurtion(i)
    }
}
let i = 0
recursion(i)
```

```javascript
for (let i=0; i<10; i++) {
    print(i)
}
```

---

### 尾端遞迴

```scheme
(define (fact n i)
  (if (= i 0)
      n
      (fact (* n i) (- i 1))))
```

---

### 樹狀遞迴

```scheme
(define (fibonacci n)
  (cond
    ((= n 0) 0)
    ((= n 1) 1)
    (else (+ (fibonacci (- n 1))
             (fibonacci (- n 2))))))
```

---

### 遍歷

```scheme
(define (print-list list)
  (if (not (null? list))
      (begin
        (print (car list))
        (print-list (cdr list)))))
```

```scheme
(for-each (lambda (n) (print n))
          (list 1 2 3 4))
```

---

### 更改預設函數

```scheme
(define (+ . whatever) 0)
```

---

## 引導思考與實作：回呼函數

我要對列表所有元素做同一操作

```scheme
(define (print-list list)
  (if (not (null? list))
      (begin
        (print (car list))
        (print-list (cdr list)))))
```

---

如果要所有列表元素加一？

```scheme
(define (print-list list)
  (if (not (null? list))
      (begin
        (print (+ 1 (car list)))
        (print-list (cdr list)))))
```

---

使用了大量重覆的程式。
可不可以把要執行的邏輯獨立出來？

```scheme
(define (for-each f list)
  (if (not (null? list))
      (begin
        (f (car list))
        (for-each f (cdr list)))))
```

---

## sicp 與 scheme 的結合

scheme 是極自由的語言，
整個語言幾乎由函數和巨集提供。
（除了 if cond lambda 等基本元素。）

---

## 函數

* `+-*/`
* `for-each`
* `let`

---

## 資料

selector 概念
符號與 quote

---

### 資料結構

```scheme
;; (numerator denominator)
(define (make-fraction n d)
  (list n d))
(define (numerator fraction)
  (list-ref fraction 0))
(define (denominator fraction)
  (list-ref fraction 1))
```

```scheme
;; (denominator numerator)
(define (make-fraction n d)
  (list d n))
```

---

### 物件的泛型

如何存取不同物件的同一屬性？

---

### 標籤型別系統

```scheme
;; (tag content)
(define (attach-tag tag content)
  (list tag content))
(define (tag data)
  (list-ref data 0))
(define (content data)
  (list-ref data 1))
```

```scheme
;; (nd-fraction (numerator denominator))
(define (make-nd-fraction numerator denominator)
  (attach-tag 'nd-fraction (list numerator denominator)))
```

---

### 如何判斷標籤

在要存取時檢查標籤，呼叫對應的函數。
但每增加型別，就必須修改原函數。

```scheme
(define (get-numerator fraction)
  (cond
    ((eq? (tag fraction) 'nd-fraction) 
     (numerator-nd-fraction fraction))
    ((eq? (tag fraction) 'dn-fraction)
     (numerator-dn-fraction fraction))))
```

---

把存取交給外部函數，建立一個統一的註冊表，
只要告訴那個函數我要存取這個物件的哪個屬性即可。

```scheme
(define (get-numerator fraction)
  ((get 'numerator (tag fraction)) fraction))
```

---

物件封裝成函數，依要求回傳不同屬性。

```scheme
(define (make-fraction numerator denominator)
  (define (fraction property)
    (cond
      ((eq? property 'numerator) numerator)
      ((eq? property 'denominator) denominator)))
  fraction)
```

```scheme
(let ((f (make-fraction 2 3)))
  (f 'numerator) ;2
  (f 'denominator) ;3
)
```

---

### 程式的狀態

```javascript
let x = 0
let y = 1
alert(x + y)
```

```scheme
(let ((x 0)
      (y 1))
  (display (+ x y)))
```

---

### let 語法糖

```scheme
(let ((x 0)
      (y 1))
  (display (+ x y)))
```

```scheme
((lambda (x y)
   (display (+ x y)))
 0 1)
```

---

### c 與 scheme
C 給你一顆 cpu，
scheme 則給你一條變換規則，
二者都讓你實現全世界。

---

### 結論
真要說，的確沒什麼特別的。
我倒是想問，
為什麼 C 要手動管理記憶體？
為什麼 python 要用那麼多關鍵字？
為什麼你們的語法這麼複雜？
