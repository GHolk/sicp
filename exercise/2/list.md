# 列表與操作
lisp 中的列表 list，是由更基礎的 pair 或說 cons 構成的，
這大概是我對 lisp 第一個震撼。
順帶一提，其它依序是：

1. cons 構成 list，和其它的一切。
2. [簡單的 eval 可以透過 cons car cdr cond atom quote eq 實現，][eval]
又因為最主要的 lisp 程式可以看作 list，
要 eval 一個函數只要做簡單的代換，把所有型參換成實參即可。
3. define 函數可以用 dot notation 表示 rest 參數，下面會講。

[eval]: http://daiyuwen.freeshell.org/gb/rol/roots_of_lisp.html "lisp 之根源"

## pair 構成 list
lisp 中最重要的結構 list，也就是 lisp 的語法，是由 pair 構成。
一個 pair 可以存二個值，
如果一個 pair 中的 cdr 也指向一個 pair，
第二個 pair 的 cdr 也是，如此串起來的 pair 即是 list。

這些 pair 的 car 都還沒放東西，表的資料即是放在這個 car 裡。
看是第幾項就放在第幾個 pair 的 car。
而最後一個 pair 的 cdr 指向一個特殊的 symbol，
在 lisp 中叫 nil，在 scheme 中則沒有特別定義名稱。

其實他的名稱不重要，只要建構一個表，最後一個 cdr 是了；
而若是建構空表，就直接是 nil。
一個空表就是指向 nil 的指針，
只有一個元素的表則是一個 car 指向元素，cdr 指向 nil 的 pair。

但我不太了解為什麼 scheme 要把 `#f` 和 `nil` 分開，
我認為傳統 lisp 的作法較優雅，
也許讀到後面，sicp 就會展示他的理由了。
就像我認為 lisp 把函數和變數命名空間分開很蠢一樣，
也許有些人會認為把函數和變數混在一起很奇怪，
至少我最初在 js 看到時，是覺得 *哇太酷了吧* 。

## count-change
重寫了第一章提到的 count-change，加入可以自定零錢種類。
但還是只計算了能找幾種，而沒有找的方法列出來。

## same-parity
介紹了如何定義可變參數函數，原來就是用 dot notation，太酷了吧。
像 `(define (foo a . b))` 如果想成 destruct assign 就很直覺，
如果 `(foo 1)` 那 b 就會是 nil，而事實也的確如此。

後來發現 sicp 還沒介紹 qoute 和 assoc 之類的 dot notation 寫法，
也就是 sicp 中 dot notation 是作為可選參數首次出現，
搞不好原本就是用來描述參數的語法，
只是後來引申出 cons 簡寫的意義而已 `= =`

## reverse filter map 和迴圈
一開始有定義了一個 reverse 函數，沒放在心上。
後來在寫 same-parity 的時候發現如果用迴圈的寫法，
列表順序會反過來。

因為列表是類似的 stack 的結構，
要讀一個列表只能從第一個開始讀，
而新的列表又要從最後一個開始建，
把新的一個個疊上去；原本的第一個就被壓到最底下了。
所以直覺上 filter 和 map 都會讓順序反過來。

這時候就可以再呼叫 reverse 把倒過來的列表再反轉回去，
但複雜度就會從 n 變 2n。
用遞迴就沒這個問題，
但如果列表太長可能會 stack overflow。

## for-each
實作 for-each 這個為副作用而生的函數時，
發現 scheme 少了一些方便的控制結構；
僅管都能自己定義，就不太方便而已。

像 emacs 有 when 和 unless：

    (when (= 1 1)
        (display "sure 1 = 1\n")
        (display "multi expression\n"))
    
    (unless (not (= 1 1))
        (display "unless = (when (not exp))\n")
        (display "also allow multi expression\n"))

在定義 for-each 時就想了要返回什麼，
因為 if 要有第一個 then expression，
才能有第二個 else expression。
而且 else 還是只能塞一行，多個要自己用 begin 包起來。

後來發現可以在 test 那裡加一個 not，
然後 then else 就交換了，就可以把 else 省掉了，
也就自動成為沒有返回值了。

## 抽像化
最後的 map 和 for-each 函數做了很重要的事，
抽像化了 **操作列表** 的過程。
從此其它函數不用知道列表怎麼實作，
也不用寫迴圈遍歷列表，
只要直接呼叫 map 或 for-each，
把要做的事寫成 lambda 傳入就好了。

相當於之前實作的分數結構，
其它函數不用了解分子、分母是如何存在分數裡的，
只要直接呼叫 numer 和 denom 就好。
這些函數在列表上建立了一個抽像層。

其實從更大觀點看來，list 也是一個抽像層，
把列表從 pair 獨立出來。
可以直接存取第 n 個元素的 nth 也是，
只是一般好像不習慣用到，scheme 也沒有納入標準；
有map之類的就夠了。
