# 區間與電阻計算
這章用 cons 構成了一種區間計算，
例如電阻一般是寫成期望值和標準差的方式表達，
那相加、相乘等運算的結果也是區間，

我一直搞混參數是上下界還是下上界，sicp 是用下上界，
但我寫的 `print-interval` 是用上下界印出來，
因為我記得數學的區間是用上下界表示。

## mul-interval
相乘比較麻煩，還要檢查正負號不同情況。
還好 sicp 裡示範了一種天才做法，
全部都乘起來，最後再挑最大和最小的。

後來有一題要我舉出所有相乘的可能情況，
太麻煩做到一半放棄。

## div-interval
我本來以為除更麻煩，
結果 sicp 只是把除數變倒數，再乘上去而已ㄏㄏ

## sub-interval
就只是把符號換成減的，要用上下界要注意。

## 期望值與誤差
後來加了用期望值與容許誤差的建構式，
也就加了

  - 取期望值的函數 center
  - 取區間長的 width
  - 取相對誤差的 percent


## 算數誤差
區間的計算有一些和一般計算不同處，
加減不能消去、乘除也不能消去，
所以在算電阻時一般會減化或通分，
都不能隨便做。

題目提到因此造成的問題，
我一開始還以為是浮點運算誤差，
往下看下一題就有解釋原因才恍然大誤。
因此計算上不能通分。