
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

<img src="http://sitcon.org/2018/static/img/speaker/15.jpg" style="width: 50%;">

* 日常 GNU/Linux 使用者
* 興趣取向的 Web 開發者

[gholk]: http://sitcon.org/2018/static/img/speaker/15.jpg

---

## 為什麼要讀這本書？

* 身為 linux 使用者，多少會碰一點程式。
* 寫出會動的程式外，要如何寫出良構、健壯、好懂的程式？
* 除了讓電腦動起來為你做事，是不是該學一點演算法、資料結構？

---

## 讀 sicp 的好處

* 讓你寫遞迴像喝水一樣
* 了解函數式程式語言之美
* 了解語法可以很簡單


---

## 筆記

我邊讀邊寫筆記，和書中例題的程式，
[放在 github 上。][note]

[note]: http://github.com/GHolk/sicp

---

## 這本書就是

* 從 scheme 入門程式設計
* 探討（實作）多個議題：
  * 物件
  * 模組
  * 直譯器

---

## 章節

 1. 程序
 2. 資料結構
 3. 模組、物件、狀態
 4. 語法解析
 5. 暫存器與底層結構

---

## 程序

* scheme 語法與運算規則
* 遞迴與迴圈
* 抽象化過程

---

### S 表達式

`f(x)` vs `(f x)`

```scheme
(printf "1 is %d\n" 1)

(+ 1 2 3)

(if (and c
         (= a b))
    (print "a = b = c")
    (print "a != b != c"))
```

---

### 函數與其它

```scheme
;; (a * b) + (c - d)
(+ (* a b)
   (- c d))
```

```scheme
;; (a > b) && (b > c)
(and (> a b)
     (> b c))

;; 用 if 實現 and
(if (> a b)
    (> b c)
    #f)
```

```scheme
(let ((sum (+ a b))
      (product (* a b)))
  (if (> sum product)
      (print (- sum product))))
```

---

### 迴圈與遞迴

```scheme
(define (fibonacci a1 a2)
  (fibonacci a2
             (+ a1 a2)))
```

```javascript
for (let a1 a2; ;) {
    [a1, a2] = [a2, a1+a2]
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
