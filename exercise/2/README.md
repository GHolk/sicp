# 資料結構
這章是介紹抽像化資料結構。

## 2-1
介紹抽像化資料結構的意義。

### 2-1-1 [分數](ration.sch)
簡單示範利用 cons 建構分數結構。
再一層層建立建構函數、存取函數，
在之上建立分數的各種運算。

### 2-1-2 [點線面](segment-2d.sch)
利用類似的方法用 cons 儲存 x y 座標構成點，
再用二個點構成線。

最後一題要建立長方形，
numbbbbb 是假設是和 x y 軸正交的正方形，
所以只要存二個點。

但我覺得不妥，做成存一條邊和高，
然後幫 segment 寫一個函數 `length-segment` ，
長方形有 height 返回高、side 返回邊、width 返邊的長度三個函數，
然後再用 height width 作出 perimeter area。