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
但空間會變n。

## 巢狀迴圈
