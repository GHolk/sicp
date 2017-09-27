# 樹結構
介紹對樹結構的操作。

## nil 與 `#f`
到這章我知道為什麼 scheme 把 nil 和 `#f` 分開了。
在傳統 lisp 中，nil 身兼 false 和 end of list 二種身份，
而 scheme 就把 nil 單純視為 end of list，和 false 分開。

想像樹結構，如果樹中有元素為 false，
那 lisp 會變成 `(1 2 nil 4)`，
同時也可以看成 `(1 2 () 4)`。
就產生了歧義，到底是表示 false，還是表示二層的樹？


## 樹狀遞迴
樹狀遞迴有二種作法，

 1. 同時對 car 和 cdr 遞迴；

 2. 使用 map、reduce 之類，
    如果該元素也是表，就再對元素 map reduce。

如果使用 1，就要注意怎麼處理 nil，
如果建構了 map-tree 的函數，
碰到 nil 是要把 nil 丟給輸入函數，
還是直接返回 nil。

此時 nil 可能是 eol 或 false，
可以從 nil 是來自 car 或 cdr 判斷，
但因此就製造了多餘的複雜性。

如果用 2，map reduce 對空表都是直接返回空表。就沒得選。
如果 map 中遇到表，就呼叫原函數，
而不是呼叫 map 自己，好像是間接遞迴。

總之，還是像 scheme 把空表和 false 分開的好。

## extract-last
讀出樹中最頂層、最後的元素。
題目給的範例沒有要求要最後，
但我猜應該有這個意思吧。

我寫得蠻複雜的，先把所有元素變成結構，
裡面記錄深度和元素內容。
再一一比較，找出最深最右的。

原本我在遞迴 car cdr 的時候做錯，
因為 cdr 還是在同一層表，深度應該不用增加。

最後發現題目好像只要要我們用 car cdr 取出該元素，
練習 car cdr 的使用，沒有要寫出一個通用的程序。


## deep-reverse
相比 reverse，deep-reverse 若元素也是表，
該元素也會被 reverse。
就簡單用 map 實現了，這種應該是叫間接遞迴。

## fringe
就是平展一個表。
一開始我用 reduce 寫，但一直錯，
發現 scheme 的 reduce 很奇怪，
init 參數根本用不到，第一次會用表中第 1 2 個元素當參數。
於是就改寫了自己習慣的 reduce。

然後因為 reduce 是從第一個元素開始，
所以最後順序會倒過來，
就再用 deep-reverse 把表轉正。

## mobile branch
看半天才知道題目是要算力矩平衡，
每個 mobile 有二個 branch，branch 有重量和長度，
branch 的戴重可以直接是數字或另一個 mobile。

把一堆函數都寫好後，覺得有點像物件導向，
但函數沒有被聚在同一個物件下，都是分散的。
最後要我們重寫底層資料結構，
基本上就改 selector 和 constructor 就好，
其它上層函數都不用動，因為都沒有直接接觸資料，
都是用 selector 和 constructor。

## map-tree
最後的重頭戲，造出了map-tree函數；
其實也沒有很難啦。
可以用car cdr雙重遞迴，
或用map寫。
