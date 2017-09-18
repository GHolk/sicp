之前介紹資料結構，是直接把 cons car cdr 三個函數拿來用，
這章介紹其實這三個函數也沒什麼好神奇的，可以手動實現。
和之前很喜歡的一篇文章
[神奇的 &lambda; 演算](http://www.jianshu.com/p/e7db2f50b012)
類似的內容。

## cons
首先實作了 cons car cdr，題目一開始是用數字當索引，
把 pair 寫成接受一個數字，1 就返回 car，2 返回 cdr。
car 和 cdr 就寫成丟 1 和 2 到 cons 裡。
（這段 code 不喜歡，沒有抄。）

後來才介紹 cons 變成把存的 car 和 cdr 塞到輸入的參數裡，
也就我寫的版本。
car 和 cdr 則實作成塞不同的 lambda 函數給輸入的 cons 的函數。

## 自然數
用函數實現 cons 還不夠 hardcore？
再來用函數實現了自然數！這題想蠻久的，
尤其要看結果對不對要用到第一章介紹的參數代換，
人腦 compile 那一堆東西根本反直覺。

後來寫了個 show-n 函數可以把 lambda 的自然數
轉成 scheme 裡的自然數，
還發現一開始 one two 寫錯，多呼叫了一次變成 2 3。

和一個 get-n 可以把整數轉換成 lambda 自然數，
這個就是從0開始加的，沒什麼好說的只能這樣寫。
