# 大量使用列表
使用列表可以讓程式變得一目瞭然，
雖然會稍微增加開銷；
但還沒提到會增加多少，能不能去除。

像如果要加 1 到 20，可以用迴圈加上去，
或產生一個 1-20 的列表，
再用 reduce 全部加起來。

如果要只加偶數，用迴圈就要多一個判斷式，
用列表則可以加一個 filter 濾出偶數即可。

這種法需要先窮舉所有要處理的資料，
再全部一起處理，最後再 reduce 回單一量。
優點是每個操作都簡單明瞭，
缺點則是要造出較大的列表，佔大量記憶體。

最注名的例子大概就 bash 的迴圈吧，
雖然可以用 `for ((i=0; i<n; i++))`，
但傳統又簡單的作法是 `for i in $(seq 0 $n)` 。


## accumulate
accumulate 或稱為 fold，
相當於 javascript 中的 reduce。
但 scheme 中也有 reduce，和 fold 不同。
scheme reduce 不會從 init 開始，
會直接從列表 1 2 項開始。

用 fold 可以實現 map append，
filter 應該也沒有問題。
我之前在 js 中是先實現 forEach，
再用 forEach 實現 map reduce fliter。


## count-leaves
用 fold 和 map 可以極簡的實現 count-leaves，
要不是用挖空的給我填，我大概填不出這麼優雅的程式。
但這種用到樹狀或間接遞迴的，應該都沒辦法簡單譯成迴圈。

## accumulate-n
有點像多參的 map，
會給幾個列表就把幾個參數傳給傳入的函數。
但用多參寫要用到 apply，很難寫得優雅。
而且 accumulate-n 中有用到 accumulate，
所以還是得先定義 accumulate 才行。

後來有定義用 apply 的寫法，其實不一定要用到 accumulate。


## matrix
這堆函數蠻神奇的，原來可以寫得這麼優雅。
之前我用 js 寫在那邊 map 來 reduce 去的，
轉到快瘋了。

## fold-right fold-left
fold 系有三個函數：fold fold-right fold-left。
sicp 中寫 fold 就是 fold-right，
但明明不一樣，可能是實作或 sicp 沒更新吧。

fold 是把列表中每個元素作第一個參數，初始值作為第二個；
fold-right 參數順序相同，但是從列表最後一個元素開始，
相當於 `(fold f init (reverse list))` 。
fold-right 參數順序相反，但是從列表第一個元素開始。

這種問題真得很麻煩，
王垠有抱怨過與其提供一堆名字類似又容易弄混，
不如只提供一種，然後一律用 lambda 改參數順序。

另一件很麻煩是用了 reduce 後有時列表順序會反過來，
因為 lisp 系的列表只有讀、unshift 首元素的複雜度是 1，
要加到列表末端或讀取末端都是 n。
有時為了速度，不能用 append，只能用 cons 加到開頭，
最後就要再 reverse 過來。

大部份情況是用 reduce 是迴圈，
但用完還要 reverse，時間複雜度是 2n。
或是用 cons 和遞迴，就不用 reverse，
但空間會變 n。

## flatmap
flatmap 是一個神奇的函數，
簡單來說就是 map 之後再 flat。
因為很常用，所以獨立成一個函數。

如果是一般語言，會寫成一個巢狀迴圈，
先遍歷表，再把表中元素變成表，
一一加到另一個表中。

## 巢狀迴圈
scheme 對巢狀迴圈的處理不是很好。
要嘛分解成二個間接遞迴，
不然就是要在 lambda 裡再用 map reduce，
然後 map reduce 裡又有 lambda。

因為參數順序是把列表放最後，lambda 放中間，
看起來很難閱讀。

    (for-each 
        (lambda (i)
            (for-each
                (lambda (j)
                    (cons i j))
                '(6 7 8 9)))
        '(1 2 3 4 5))

如果換一下參數順序可能會好一點，
就會比較像一般語言的迴圈，

    (for-each '(1 2 3) (lambda (i)
        (for-each '(4 5 6) (lambda (j)
            (set! l (cons (list i j) l))))))

    (reduce 0 '(1 2 3) (lambda (x s)
        (+ x s)))
        
或像 lisp 一樣用巨集：

    (dolist x '(1 2 3)
        (print x))

這節到後面的程式都有這個問題，太難閱讀。
有時候還是覺得傳統的迴圈語法好。


# permutations
列出集合中的所有子集合，蠻神奇的寫法。
好像無法譯成迴圈？

# unique-pairs
要產生 pair，其中 `car = [1,n], cdr = [1,car]`。
也就是窮舉平面上一方型區域內的格子點。

他是用 flatmap 和 map 用二個數列來產生，
但這個東西應該要抽像成一個
`car = [1,n], cdr = [1,m]` 的窮舉函數，
我寫了個 pair-2d，
再用 filter 濾掉一半變成要求的結果。

# specific-sum-triples
如果是三維座標，就不能用 cons 了，只好乖乖用 list。
只是多維下，沒有用 nth 存取列表中元素會不方便；
三維如果操作不多，還能勉強撐一下。

# queens
傳說中的八皇后問題，因為這題，
我才認識到 scheme 的巢狀迴圈真得很有問題，
太過難以閱讀了。
sicp 提供的範例我讀了好幾次才懂。

我本來以為題目作法是先把一隻皇后可能的位置全部列出來，
再和第二隻可能的位置組合，變成 `64*64` ，
然後用 filter 濾掉有衝突的。

但把範例完成後，發現好像不是這樣，但還是看不太懂。
就把他改成我想像的那樣。
結果一下就 overflow 了，超過最大 recursion 層數。

又研究了一下，才看懂範例是把第一個 queen 放第一欄，
第二個第二欄，以此類推。
因為皇后問題一欄一定只能放一個，
所以就偷吃步少了一堆情況。
就不用每次都乘上 64 種可能，乘 8 種即可。

但也因此範例只能處理皇后數和棋盤寬度一樣的情況。
而我的版本可以處理任意情況；如果遞迴 stack 沒爆的話。

另外範例每次都是用 enumerate-interval 生出棋盤的各欄列，
如果只生成一次存起來，之後直接用可能會比較快。
