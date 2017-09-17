# 因數與質數
因數與質數的計算方法及演算法。

## gcd
是用 [[輾轉相除法]] 實作 gcd。
有先實作一個 remainder，但效率是 n 蠻差的，
我也不知道怎麼優化。

之前用 c 寫 gcd 都會想要用大的減小的，
要判斷大小很麻煩。
現在才發現其實可以不用，不知道以前在想什麼。


## fermat-test
根據 [[費馬小定理]] 的質數判定方法，
特色是運算量小，但是不是絕對正確的；
只是正確率蠻高的。

另外在 fermat-test 中因為有用到 expmod 的結果二次，
但還沒介紹到 let，所以另外定義了一個函數，
把 expmod 的結果當參數傳入，就能用二次。


## expmod
另外 fermat-test 要用到模數下的極大次方運算，
因此先實現了 `expmod` 。
其中有用到上一章的快速冪，還用遞迴和迴圈都寫了一邊。

用迴圈寫的一開始跑得比遞迴還慢，
發現是在降冪時會把 base 平方，
後來 base 就變超大，運算就變很慢。
發現 base 取模後不會影響運算結果，
改成平方後就取模一次，就變快了。

## prime?-time
然後要我們測量 fermat-test 和 linear-prime-test 的速度，
就用計時測，發現 fermat-test 超快，
log n 和 sqrt n 根本沒得比。

## miller-rabin-test
這是改進了費馬測試會有例外的情況，看不是很懂；
總之抄了 numbbbbb的code就大概懂了。