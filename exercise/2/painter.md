# 畫圖語言
這章用 scheme 實作一個簡單的繪圖語言，
基於圖片與要展示圖片的框架，
並使用 scheme 作為該語言的處理。
（gimp 使用 scheme 作為內部語言，
難道 gimp 就是這樣做的？
還是使用 scheme 是指 gimp 用 guile 當介面設計語言？）

這章是用瀏覽器看的，因為有圖片，
info 版本沒有圖片。

; painter
: 一個 painter 是一個平行四邊形圖樣，
: （方便起見，可以直接想像成正方形。）
: 能被展示在一個 frame 裡。

; frame
: 一個 frame 是有定義實際位置的座標系。
: 有一個旋轉。

分層設計的好處，
每層都只使用下一層提供的介面，
並提供上一層使用。
使用時不跨層，
讓修改程式時只需要保持對上對下一致，
與實作細節無關。
任一層修改後，